package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalDominio.CupomTroca;
import finalDominio.EntidadeDominio;

public class CupomTrocaDAO  extends AbstractJdbcDAO {

	public CupomTrocaDAO() {
		super("cupomTroca", "id_cupom");
	}
	
	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
		PreparedStatement pst = null;
		openConnection();
		CupomTroca cupom = (CupomTroca)entidade;
		StringBuilder sql = new StringBuilder();
		
		try {
			sql.append("INSERT INTO cupomtroca (ID_Cliente, valor, status)" + 
					"VALUES (?,?,true);");
			pst = connection.prepareStatement(sql.toString());
			connection.setAutoCommit(false);
			pst.setInt(1, cupom.getID_Cliente());
			pst.setDouble(2, cupom.getValor());
			
			pst.executeUpdate();
			connection.commit();
			
			sql = new StringBuilder();
			sql.append("UPDATE Carrinho set status = 'TROCADO' WHERE ID_Carrinho = ?");
			
			pst = connection.prepareStatement(sql.toString());
			pst.setInt(1, cupom.getID_Carrinho());
			System.out.println(pst);
			pst.executeUpdate();
			connection.commit();
		}catch(SQLException ex) {
			connection.rollback();
			ex.printStackTrace();
		}finally {
			connection.close();
		}
		
	}

	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		PreparedStatement pst = null;
		CupomTroca cupom = (CupomTroca) entidade;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT * from cupomtroca");
		sql.append(" WHERE 1=1 ");
		if (cupom.getID_Cliente() > 0) {
			sql.append(" AND ID_Cliente = '" + cupom.getID_Cliente() + "'" );
		}

		
		try {
			openConnection();
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> cupons = new ArrayList<EntidadeDominio>();
			
			
			
			while (rs.next()) {
				if(rs.getBoolean("status")) {
				CupomTroca c = new CupomTroca();
				c.setId(rs.getInt("ID_Cupom"));
				c.setID_Cliente(rs.getInt("ID_Cliente"));
				c.setValor(rs.getDouble("valor"));
				c.setStatus(rs.getBoolean("status"));
				
				cupons.add(c);
				}

			}
			return cupons;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}