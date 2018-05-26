package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import auxiliar.Categoria;
import finalDominio.EntidadeDominio;

public class CategoriaDAO extends AbstractJdbcDAO{
	public CategoriaDAO() {
		super("categoria", "id_categoria");
		// TODO Auto-generated constructor stub
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
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
		StringBuilder sb = new StringBuilder();
		sb.append("select nome_categoria from categoria order by 1;");
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> categorias = new ArrayList<>();
			Categoria c = new Categoria();
			while(rs.next()){
				c = new Categoria();
				c.setNome(rs.getString("nome_categoria"));
				categorias.add(c);
			}
			return categorias;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}

}
