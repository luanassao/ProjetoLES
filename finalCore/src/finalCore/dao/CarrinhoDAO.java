package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalDominio.Carrinho;
import finalDominio.EntidadeDominio;

public class CarrinhoDAO extends AbstractJdbcDAO{
	public CarrinhoDAO() {
		super("carrinho", "id_carrinho");
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Carrinho carrinho = (Carrinho)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO carrinho(id_endereco, valor_frete, valor_livros, valor_total, forma_pagamento, status, data_criacao, senha_cliente)");
			sql.append("VALUES (?,?,?,?,?,?,?,sysdate())");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setInt(1, carrinho.getIdEndereco());
			pst.setDouble(2, carrinho.getFrete());
			pst.setDouble(3, carrinho.getValorLivros());
			pst.setDouble(4, carrinho.getValorTotal());
			pst.setString(5, carrinho.getFormaPagamento());
			pst.setString(6, carrinho.getStatus());
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
		Carrinho carrinho = (Carrinho)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE carrinho SET valor_frete = ?, valor_livros = ?, valor_total = ? WHERE ID_Carrinho = ?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setDouble(1, carrinho.getFrete());
			pst.setDouble(2, carrinho.getValorLivros());
			pst.setDouble(3, carrinho.getValorTotal());
			pst.setInt(4, carrinho.getId());
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
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		PreparedStatement pst = null;
		Carrinho carrinho = (Carrinho) entidade;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT * FROM carrinho WHERE 1=1\n");
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> carrinhos = new ArrayList<>();
			while(rs.next()){
				Carrinho c = new Carrinho();
				c.setId(rs.getInt("ID_Carrinho"));
				c.setIdEndereco(rs.getInt("id_endereco"));
				c.setFormaPagamento(rs.getString("forma_pagamento"));
				c.setStatus(rs.getString("status"));
				c.setFrete(rs.getDouble("valor_frete"));
				c.setValorLivros(rs.getDouble("valor_livros"));
				c.setValorTotal(rs.getDouble("valor_total"));
				carrinhos.add(c);
			}
			return carrinhos;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}
}
