package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalDominio.EntidadeDominio;
import finalDominio.Produto;

public class ProdutoDAO extends AbstractJdbcDAO{
	public ProdutoDAO() {
		super("produto", "id_produto");
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Produto produto = (Produto)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO Produto(ID_Carrinho, ID_Livro, titulo, quantidade, email, senha)");
			sql.append("VALUES (?,?,?,?,?,?)");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setInt(1, produto.getID_Carrinho());
			pst.setInt(2, produto.getID_Livro());
			pst.setString(3, produto.getTitulo());
			pst.setInt(4, produto.getQuantidade());
			pst.setString(5, produto.getEmail());
			pst.setString(6, produto.getSenha());
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
		// TODO Auto-generated method stub
		
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		PreparedStatement pst = null;
		Produto produto = (Produto) entidade;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT * FROM produto WHERE 1=1\n");
		if(produto.getID_Carrinho() != 0){
			sb.append(" and ID_Carrinho = '" + produto.getID_Carrinho() + "'");
		}
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> produtos = new ArrayList<>();
			while(rs.next()){
				Produto p = new Produto();
				p.setId(rs.getInt("ID_Produto"));
				p.setID_Carrinho(rs.getInt("ID_Carrinho"));
				p.setID_Livro(rs.getInt("ID_Livro"));
				p.setQuantidade(rs.getInt("quantidade"));
				p.setTitulo(rs.getString("titulo"));
				p.setEmail(rs.getString("email"));
				p.setSenha(rs.getString("senha"));
				produtos.add(p);
			}
			return produtos;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}
}
