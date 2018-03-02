package finalCore.dao;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import finalDominio.Cartao;
import finalDominio.EntidadeDominio;

public class CartaoDAO extends AbstractJdbcDAO{
	public CartaoDAO() {
		super("cartao", "id_cartao");
	}
	
	@SuppressWarnings("resource")
	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		openConnection();
		PreparedStatement pst = null;
		Cartao cartao = (Cartao)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO cartao(titular, numero, codigo, validade, id_cliente, alterador, preferencial, bandeira)");
			sql.append("VALUES (?,?,?,?,?,?,?,?)");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, cartao.getTitular());
			pst.setString(2, cartao.getNumero());
			pst.setString(3, cartao.getCodigo());
			pst.setDate(4, new Date(cartao.getValidade().getTimeInMillis()), cartao.getValidade());
			pst.setInt(5, cartao.getID_Cliente());
			pst.setString(6, cartao.getAlterador());
			pst.setBoolean(7, cartao.getPreferencial());
			pst.setString(8, cartao.getBandeira());
			pst.executeUpdate();			
			connection.commit();
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT * FROM cartao WHERE 1=1\n");
			try{
				openConnection();
				pst = connection.prepareStatement(sb.toString());
				ResultSet rs = pst.executeQuery();
				while(rs.next()){
					if(rs.isLast())
					{
					Cartao c = new Cartao();
					c.setId(rs.getInt("ID_cartao"));
					c.setTitular(rs.getString("titular"));
					c.setNumero(rs.getString("numero"));
					c.setCodigo(rs.getString("codigo"));
					Calendar calendV = Calendar.getInstance();
					calendV.setTime(rs.getDate("validade"));
					c.setValidade(calendV);
					c.setID_Cliente(rs.getInt("id_cliente"));
					c.setAlterador(rs.getString("alterador"));
					c.setPreferencial(rs.getBoolean("preferencial"));
					c.setBandeira(rs.getString("bandeira"));
					entidade = c;
					}
				}
			}catch(SQLException e){
				e.printStackTrace();
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
		// TODO Auto-generated method stub
		openConnection();
		PreparedStatement pst = null;
		Cartao cartao = (Cartao)entidade;
		
		try {
			connection.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("UPDATE cartao SET titular = ?, numero = ?, codigo = ?, validade = ?, alterador = ? WHERE ID_Cliente = ?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setString(1, cartao.getTitular());
			pst.setString(2, cartao.getNumero());
			pst.setString(3, cartao.getCodigo());
			pst.setDate(4, new Date(cartao.getValidade().getTimeInMillis()), cartao.getValidade());
			pst.setString(5, cartao.getAlterador());
			pst.setInt(6, cartao.getID_Cliente());
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
		// TODO Auto-generated method stub
		PreparedStatement pst = null;
		Cartao cartao = (Cartao) entidade;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT * FROM cartao WHERE 1=1\n");
		if(cartao.getID_Cliente() != 0){
			sb.append(" and ID_Cliente = '" + cartao.getID_Cliente() + "'");
		}
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> cartoes = new ArrayList<>();
			while(rs.next()){
				Cartao c = new Cartao();
				c.setId(rs.getInt("ID_cartao"));
				c.setTitular(rs.getString("titular"));
				c.setNumero(rs.getString("numero"));
				c.setCodigo(rs.getString("codigo"));
				Calendar calendV = Calendar.getInstance();
				calendV.setTime(rs.getDate("validade"));
				c.setValidade(calendV);
				c.setID_Cliente(rs.getInt("id_cliente"));
				c.setAlterador(rs.getString("alterador"));
				c.setPreferencial(rs.getBoolean("preferencial"));
				c.setBandeira(rs.getString("bandeira"));
				cartoes.add(c);
			}
			return cartoes;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}
}