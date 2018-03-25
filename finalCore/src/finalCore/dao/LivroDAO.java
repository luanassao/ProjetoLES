package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import auxiliar.Alterador;
import auxiliar.Autor;
import auxiliar.Categoria;
import auxiliar.Editora;
import auxiliar.Precificacao;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import javafx.scene.media.AudioClip;

public class LivroDAO extends AbstractJdbcDAO{
	public LivroDAO() {
		super("livros", "id_livro");
	}

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
			
			pst = connection.prepareStatement(sql.toString());
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
			System.out.println(pst);
			pst.executeUpdate();			
			connection.commit();
			
			sql = new StringBuilder();
			sql.append("CALL ID_Livro_Salvo()");
			pst = connection.prepareStatement(sql.toString());
			System.out.println(pst);
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
				System.out.println(pst);
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
	public void alterar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		System.out.println(livro.getId());
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			Livro l = livro;
			sql.append("UPDATE livros SET id_autor = ?, ano = ?, titulo = ?, id_editora = ?,");
			sql.append("edicao = ?, ISBN = ?, npaginas = ?, sinopse = ?, status = ?, altura = ?, largura = ?, peso = ?, ");
			sql.append("profundidade = ?, alterador = ?, estoque=? WHERE ID_Livro = ?");		
			
			pst = connection.prepareStatement(sql.toString());
			pst.setInt(1, livro.getAutor().getId());
			pst.setString(2, livro.getAno());
			pst.setString(3, livro.getTitulo());
			pst.setInt(4, livro.getEditora().getId());
			pst.setString(5, livro.getEdicao());
			pst.setString(6, livro.getISBN());
			pst.setString(7, livro.getNpaginas());
			pst.setString(8, livro.getSinopse());
			pst.setBoolean(9, livro.getStatus());
			pst.setDouble(10, livro.getAltura());
			pst.setDouble(11, livro.getLargura());
			pst.setDouble(12, livro.getPeso());
			pst.setDouble(13, livro.getProfundidade());
			pst.setInt(14, livro.getAlterador().getId());
			pst.setInt(15, livro.getEstoque());
			pst.setInt(16, livro.getId());
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
		sb.append("WHERE 1=1\n");
		
		if(livro.getTitulo() != null && livro.getTitulo().length() > 0){
			sb.append(" and titulo = '" + livro.getTitulo() + "'");
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
		if(livro.getEstoque() == 1) {
			sb.append(" and estoque > 0");
		}
		try {
			if(livro.getStatus()) {
				sb.append(" and status = " + livro.getStatus());
			}
			else if(!livro.getStatus()) {
				sb.append(" and status = " + livro.getStatus());
			}
		}catch (NullPointerException e) {
			// TODO: handle exception
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
					
					l.setPrecificacao(p);
					l.setAutor(a);
					l.setEditora(e);
					l.setAlterador(alt);
					l.getCategorias().add(c);
					
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
			sql.append("UPDATE livros SET status = ?, motivo = ?, alterador = ? WHERE ID_Livro = ?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setBoolean(1, livro.getStatus());
			pst.setString(2, livro.getMotivo());
			pst.setInt(3, livro.getAlterador().getId());
			pst.setInt(4, livro.getId());
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
