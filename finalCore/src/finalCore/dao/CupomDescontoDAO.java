package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import auxiliar.CupomDesconto;
import finalDominio.Cupom;
import finalDominio.EntidadeDominio;

public class CupomDescontoDAO extends AbstractJdbcDAO {

	public CupomDescontoDAO() {
		super("cupons", "id_cupom");
	}
	
	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
		PreparedStatement pst = null;
		openConnection();
		Cupom cupom = (Cupom)entidade;
		StringBuilder sql = new StringBuilder();
		
		try {
			sql.append("INSERT INTO cupons (codigo, valor)" + 
					"VALUES (?, ?);");
			pst = connection.prepareStatement(sql.toString());
			connection.setAutoCommit(false);
			pst.setString(1, cupom.getCodigo());
			pst.setDouble(2, cupom.getValor());
			
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
		CupomDesconto cupom = (CupomDesconto) entidade;
		StringBuilder sql = new StringBuilder();
		
		sql.append("SELECT * from CUPOM_DESCONTO");
		sql.append(" WHERE 1=1 ");
		if (cupom.getCodigo() != null && cupom.getCodigo().length() > 0) {
			sql.append(" AND Codigo = '" + cupom.getCodigo() + "'" );
		}
		if(cupom.getId() >= 0) {
			sql.append(" AND ID_Cupom_Desconto = '" + cupom.getId() + "'");
		}

		
		try {
			openConnection();
			pst = connection.prepareStatement(sql.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> cupons = new ArrayList<EntidadeDominio>();
			
			
			
			while (rs.next()) {
				CupomDesconto c = new CupomDesconto();
				c.setId(rs.getInt("ID_Cupom_Desconto"));
				c.setCodigo(rs.getString("Codigo"));
				c.setValor(rs.getDouble("valor"));
				
				cupons.add(c);

			}
			return cupons;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}
}
