package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalDominio.EntidadeDominio;
import finalDominio.Livro;

public class LivroDAO extends AbstractJdbcDAO{
	public LivroDAO() {
		super("livros", "id_livro");
	}

	@Override
	public void salvar(EntidadeDominio entidade) {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		/*estoque int,
	    preco double,
	    precificacao varchar(2),
	    valor double,*/
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO livros(autor, categoria, subcategoria, ano, titulo, editora,");
			sql.append("edicao, ISBN, npaginas, sinopse, status, altura, largura, peso, profundidade, alterador,");
			sql.append("estoque, preco, precificacao, valor)");
			sql.append("VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");		
			
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, livro.getAutor());
			pst.setString(2, livro.getCategoria());
			pst.setString(3, livro.getSubcategoria());
			pst.setString(4, livro.getAno());
			pst.setString(5, livro.getTitulo());
			pst.setString(6, livro.getEditora());
			pst.setString(7, livro.getEdicao());
			pst.setString(8, livro.getISBN());
			pst.setString(9, livro.getNpaginas());
			pst.setString(10, livro.getSinopse());
			pst.setBoolean(11, livro.getStatus());
			pst.setDouble(12, livro.getAltura());
			pst.setDouble(13, livro.getLargura());
			pst.setDouble(14, livro.getPeso());
			pst.setDouble(15, livro.getProfundidade());
			pst.setString(16, livro.getAlterador());
			pst.setInt(17, livro.getEstoque());
			pst.setDouble(18, livro.getPreco());
			pst.setString(19, String.valueOf(livro.getPrecificacao()));
			pst.setDouble(20, livro.getValor());
			System.out.println(pst);
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
	public void alterar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Livro livro = (Livro)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE livros SET autor = ?, categoria = ?, subcategoria = ?, ano = ?, titulo = ?, editora = ?,");
			sql.append("edicao = ?, ISBN = ?, npaginas = ?, sinopse = ?, status = ?, altura = ?, largura = ?, peso = ?, ");
			sql.append("profundidade = ?, alterador = ?, estoque=? WHERE ID_Livro = ?");		
			
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, livro.getAutor());
			pst.setString(2, livro.getCategoria());
			pst.setString(3, livro.getSubcategoria());
			pst.setString(4, livro.getAno());
			pst.setString(5, livro.getTitulo());
			pst.setString(6, livro.getEditora());
			pst.setString(7, livro.getEdicao());
			pst.setString(8, livro.getISBN());
			pst.setString(9, livro.getNpaginas());
			pst.setString(10, livro.getSinopse());
			pst.setBoolean(11, livro.getStatus());
			pst.setDouble(12, livro.getAltura());
			pst.setDouble(13, livro.getLargura());
			pst.setDouble(14, livro.getPeso());
			pst.setDouble(15, livro.getProfundidade());
			pst.setString(16, livro.getAlterador());
			pst.setInt(17, livro.getEstoque());
			pst.setInt(18, livro.getId());
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
		sb.append("SELECT * FROM livros WHERE 1=1\n");
		if(livro.getTitulo() != null && livro.getTitulo().length() > 0){
			sb.append(" and titulo = '" + livro.getTitulo() + "'");
		}
		if(livro.getAutor() != null && livro.getAutor().length() > 0){
			sb.append(" and autor = '" + livro.getAutor() + "'");
		}
		if(livro.getEditora() != null && livro.getEditora().length() > 0) {
			sb.append(" and editora = '" + livro.getEditora() + "'");
		}
		if(livro.getAno() != null && livro.getAno().length() > 0) {
			sb.append(" and ano = '" + livro.getAno() + "'");
		}
		if(livro.getISBN() != null && livro.getISBN().length() > 0) {
			sb.append(" and isbn = '" + livro.getISBN() + "'");
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
			while(rs.next()){
				Livro l = new Livro();
				l.setId(rs.getInt("ID_Livro"));
				l.setAutor(rs.getString("autor"));
				l.setCategoria(rs.getString("categoria"));
				l.setSubcategoria(rs.getString("subcategoria"));
				l.setAno(rs.getString("ano"));
				l.setTitulo(rs.getString("titulo"));
				l.setEditora(rs.getString("editora"));
				l.setEdicao(rs.getString("edicao"));
				l.setISBN(rs.getString("isbn"));
				l.setNpaginas(rs.getString("npaginas"));
				l.setSinopse(rs.getString("sinopse"));
				l.setStatus(rs.getBoolean("status"));
				l.setAltura(rs.getDouble("altura"));
				l.setLargura(rs.getDouble("largura"));
				l.setPeso(rs.getDouble("peso"));
				l.setProfundidade(rs.getDouble("profundidade"));
				l.setAlterador(rs.getString("alterador"));
				l.setPreco(rs.getDouble("preco"));
				l.setValor(rs.getDouble("valor"));
				l.setPrecificacao(rs.getString("precificacao"));
				l.setEstoque(rs.getInt("estoque"));
				livros.add(l);
			}
			return livros;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}

}
