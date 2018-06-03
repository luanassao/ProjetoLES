package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalDominio.Carrinho;
import finalDominio.Cliente;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;

public class ProdutoDAO extends AbstractJdbcDAO{

	public ProdutoDAO() {
		super("produto", "id_produto");
		// TODO Auto-generated constructor stub
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Produto produto = (Produto)entidade;
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE produto SET quantidade = quantidade - ? WHERE ID_Produto = ?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setInt(1, produto.getQuantidade());
			pst.setInt(2, produto.getId());
			pst.executeUpdate();			
			connection.commit();
		} catch (SQLException e) {
			try {
				connection.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();			
		}
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		PreparedStatement pst = null;
		Carrinho carrinho = (Carrinho) entidade;
		StringBuilder sb = new StringBuilder();
		LivroDAO livroDAO = new LivroDAO();
		sb.append("SELECT * FROM PRODUTO");
		sb.append(" LEFT JOIN LIVROS");
		sb.append(" using (ID_Livro)");
		sb.append(" WHERE 1=1\n");
		sb.append(" AND ID_Pedido = " + carrinho.getId());
		sb.append(" order by id_pedido");
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> produtos = new ArrayList<>();
			Livro l;
			Produto p;
			while(rs.next()){
				l = new Livro();
				p = new Produto();
				p.setID_Pedido(rs.getInt("ID_Pedido"));
				p.setId(rs.getInt("ID_Produto"));
				p.setQuantidade(rs.getInt("quantidade"));
				p.setID_Livro(rs.getInt("iD_Livro"));
				
				l.setId(rs.getInt("ID_Livro"));
				l = (Livro)livroDAO.consultar(l).get(0);
				
				p.setLivro(l);
				
				carrinho.getProdutos().add(p);
			}
			return produtos;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}

}
