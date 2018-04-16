package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import auxiliar.Alterador;
import auxiliar.Autor;
import auxiliar.Categoria;
import auxiliar.CategoriaAtivacao;
import auxiliar.CategoriaInativacao;
import auxiliar.Editora;
import auxiliar.Precificacao;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;

public class LivroDAO extends AbstractJdbcDAO{
	public LivroDAO() {
		super("livros", "id_livro");
	}

	@SuppressWarnings("resource")
	@Override
	public void salvar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("CALL SALVAR_LIVRO (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			/*sql.append("INSERT INTO livros(id_autor, ano, titulo, id_editora, edicao, ISBN,");
			sql.append("npaginas, sinopse, status, altura, largura, peso, profundidade, alterador,");
			sql.append("estoque, preco, id_precificacao, valor)");
			sql.append("VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");*/
			
			pst = connection.prepareStatement(sql.toString(), 
					Statement.RETURN_GENERATED_KEYS);
			pst.setInt(1, livro.getAutor().getId());
			pst.setString(2, livro.getAno());
			pst.setString(3, livro.getTitulo());
			pst.setInt(4, livro.getEditora().getId());
			pst.setString(5, livro.getEdicao());
			pst.setString(6, livro.getISBN());
			pst.setString(7, livro.getNpaginas());
			pst.setString(8, livro.getSinopse());
			pst.setInt(9, livro.getEstoque());
			pst.setDouble(10, livro.getPreco());
			pst.setInt(11, livro.getPrecificacao().getId());
			pst.setDouble(12, livro.getValor());
			pst.setBoolean(13, livro.getStatus());
			pst.setDouble(14, livro.getAltura());
			pst.setDouble(15, livro.getLargura());
			pst.setDouble(16, livro.getPeso());
			pst.setDouble(17, livro.getProfundidade());
			pst.setInt(18, livro.getAlterador().getId());
			
			pst.executeUpdate();
			/*ResultSet rs = pst.getGeneratedKeys();
			int id=0;
			if(rs.next())
			{
				System.out.println();
				id = rs.getInt("ID_Livro");
			}
			livro.setId(id);
			System.out.println(livro.getId());*/
			connection.commit();
			
			sql = new StringBuilder();
			sql.append("CALL ID_Livro_Salvo()");
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			while(rs.next()){
				livro.setId(rs.getInt("ID_Livro"));
			}
			
			for(Categoria c:livro.getCategorias())
			{
				sql = new StringBuilder();
				sql.append("CALL SALVAR_CATEGORIA_LIVRO (?,?)");
				
				pst = connection.prepareStatement(sql.toString());
				pst.setInt(1, livro.getId());
				pst.setInt(2, c.getId());
				pst.executeUpdate();			
				connection.commit();
			}
		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();			
		}finally{
			try {
				pst.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@SuppressWarnings("resource")
	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE livros SET id_autor = ?, ano = ?, titulo = ?, id_editora = ?,");
			sql.append("edicao = ?, ISBN = ?, npaginas = ?, sinopse = ?, altura = ?, largura = ?, peso = ?, ");
			sql.append("profundidade = ?, alterador = ?, estoque=?, preco = ?, valor = ?, DT_Registro=sysdate() WHERE ID_Livro = ?");	
			
			pst = connection.prepareStatement(sql.toString());
			pst.setInt(1, livro.getAutor().getId());
			pst.setString(2, livro.getAno());
			pst.setString(3, livro.getTitulo());
			pst.setInt(4, livro.getEditora().getId());
			pst.setString(5, livro.getEdicao());
			pst.setString(6, livro.getISBN());
			pst.setString(7, livro.getNpaginas());
			pst.setString(8, livro.getSinopse());
			pst.setDouble(9, livro.getAltura());
			pst.setDouble(10, livro.getLargura());
			pst.setDouble(11, livro.getPeso());
			pst.setDouble(12, livro.getProfundidade());
			pst.setInt(13, livro.getAlterador().getId());
			pst.setInt(14, livro.getEstoque());
			pst.setDouble(15, livro.getPreco());
			pst.setDouble(16, livro.getValor());
			pst.setInt(17, livro.getId());
			pst.executeUpdate();
			connection.commit();
			
			if(livro.getCategorias() != null && livro.getCategorias().size() > 0)
			{
				sql = new StringBuilder();
				sql.append("CALL Apagar_Categorias (?)");
				
				pst = connection.prepareStatement(sql.toString());
				pst.setInt(1, livro.getId());
				pst.executeUpdate();			
				connection.commit();
			}
			
			for(Categoria c:livro.getCategorias())
			{
				sql = new StringBuilder();
				sql.append("CALL SALVAR_CATEGORIA_LIVRO (?,?)");
				
				pst = connection.prepareStatement(sql.toString());
				pst.setInt(1, livro.getId());
				pst.setInt(2, c.getId());
				pst.executeUpdate();			
				connection.commit();
			}
		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();			
		}finally{
			try {
				pst.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		PreparedStatement pst = null;
		Livro livro = (Livro) entidade;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT * FROM livros ");
		sb.append("LEFT JOIN Autor using(ID_Autor)");
		sb.append("LEFT JOIN precificacao using(ID_Precificacao)");
		sb.append("LEFT JOIN editora using(ID_Editora)");
		sb.append("LEFT JOIN livro_possui_categoria using(ID_Livro)");
		sb.append("LEFT JOIN categoria using(ID_Categoria)");
		sb.append("LEFT JOIN (select ID_Cliente, Email from clientes) alterador on (alterador = alterador.ID_Cliente)");
		sb.append("LEFT JOIN categoria_ativacao on(ID_CategoriaAtivInativ = ID_Cat_Ativacao)");
		sb.append("LEFT JOIN categoria_inativacao on(ID_CategoriaAtivInativ = ID_Cat_Inativacao)");
		sb.append("WHERE 1=1\n");
		
		if(livro.getTitulo() != null && livro.getTitulo().length() > 0){
			sb.append(" and titulo like '" + livro.getTitulo() + "%'");
		}
		if(livro.getAutor() != null && livro.getAutor().getId() != 0){
			sb.append(" and id_autor = '" + livro.getAutor().getId() + "'");
		}
		if(livro.getEditora() != null && livro.getEditora().getId() != 0) {
			sb.append(" and id_editora = '" + livro.getEditora().getId() + "'");
		}
		if(livro.getAno() != null && livro.getAno().length() > 0) {
			sb.append(" and ano = '" + livro.getAno() + "'");
		}
		if(livro.getISBN() != null && livro.getISBN().length() > 0) {
			sb.append(" and isbn = '" + livro.getISBN() + "'");
		}
		if(livro.getCategorias().size() > 0 && livro.getCategorias().get(0).getId() > 0) {
			sb.append(" and ID_Categoria = '" + livro.getCategorias().get(0).getId() + "'");
		}
		if(livro.getPreco() > 0) {
			sb.append(" and valor >= '" + livro.getPreco() + "'");
		}
		if(livro.getValor() > 0) {
			sb.append(" and valor <= '" + livro.getValor() + "'");
		}
		try {
			if(livro.getStatus()) {
				sb.append(" and status = " + livro.getStatus());
			}
			else if(!livro.getStatus()) {
				sb.append(" and status = " + livro.getStatus());
			}
		}catch (NullPointerException e) {
			// Status nulo, listar por todos os status
		}
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> livros = new ArrayList<>();
			int atual = 0;
			Livro l = new Livro();
			Categoria c;
			while(rs.next()){
				if(rs.getInt("ID_Livro") != atual)
				{
					atual = rs.getInt("ID_Livro");
					l = new Livro();
					Precificacao p = new Precificacao();
					Autor a = new Autor();
					Editora e = new Editora();
					c = new Categoria();
					CategoriaAtivacao catA = new CategoriaAtivacao();
					CategoriaInativacao catI = new CategoriaInativacao();
					Alterador alt = new Alterador();
					
					l.setId(rs.getInt("ID_Livro"));
					l.setAno(rs.getString("ano"));
					l.setTitulo(rs.getString("titulo"));
					l.setEdicao(rs.getString("edicao"));
					l.setISBN(rs.getString("isbn"));
					l.setNpaginas(rs.getString("npaginas"));
					l.setSinopse(rs.getString("sinopse"));
					l.setStatus(rs.getBoolean("status"));
					l.setAltura(rs.getDouble("altura"));
					l.setLargura(rs.getDouble("largura"));
					l.setPeso(rs.getDouble("peso"));
					l.setProfundidade(rs.getDouble("profundidade"));
					l.setPreco(rs.getDouble("preco"));
					l.setValor(rs.getDouble("valor"));
					l.setEstoque(rs.getInt("estoque"));
					l.setMotivo(rs.getString("motivo"));
					
					p.setId(rs.getInt("ID_Precificacao"));
					p.setNome(rs.getString("Nome_Precificacao"));
					p.setMargem(rs.getInt("margem"));
					
					a.setId(rs.getInt("ID_Autor"));
					a.setNome(rs.getString("Nome_Autor"));
					
					e.setId(rs.getInt("ID_Editora"));
					e.setNome(rs.getString("Nome_Editora"));
					
					alt.setId(rs.getInt("alterador"));
					alt.setEmail(rs.getString("Email"));
					
					c.setId(rs.getInt("ID_Categoria"));
					c.setNome(rs.getString("Nome_Categoria"));
					
					catA.setId(rs.getInt("ID_CategoriaAtivInativ"));
					catA.setNome(rs.getString("Nome_Cat_Ativacao"));
					
					catI.setId(rs.getInt("ID_CategoriaAtivInativ"));
					catI.setNome(rs.getString("Nome_Cat_Inativacao"));
					
					Calendar calendR = Calendar.getInstance();
					calendR.setTime(rs.getDate("DT_Registro"));
					l.setDtRegistro(calendR);
					
					l.setPrecificacao(p);
					l.setAutor(a);
					l.setEditora(e);
					l.setAlterador(alt);
					l.getCategorias().add(c);
					l.setCatAtivacao(catA);
					l.setCatInativacao(catI);
					
					livros.add(l);
				}
				else
				{
					c = new Categoria();
					c.setId(rs.getInt("ID_Categoria"));
					c.setNome(rs.getString("Nome_Categoria"));
					
					l.getCategorias().add(c);
				}
			}
			return livros;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE livros SET status = ?, motivo = ?, ID_CategoriaAtivInativ = ?, alterador = ? WHERE ID_Livro = ?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setBoolean(1, livro.getStatus());
			pst.setString(2, livro.getMotivo());
			if(livro.getStatus())
				pst.setInt(3, livro.getCatAtivacao().getId());
			else
				pst.setInt(3, livro.getCatInativacao().getId());
			pst.setInt(4, livro.getAlterador().getId());
			pst.setInt(5, livro.getId());
			pst.executeUpdate();			
			connection.commit();
		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();			
		}finally{
			try {
				pst.close();
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

}
