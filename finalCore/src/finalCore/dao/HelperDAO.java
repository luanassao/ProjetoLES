package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import auxiliar.Autor;
import auxiliar.Categoria;
import auxiliar.DadosCadLivro;

import finalDominio.EntidadeDominio;

public class HelperDAO extends AbstractJdbcDAO{

	public HelperDAO() {
		super("table", "idTable");
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
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		PreparedStatement pst = null;
		List<EntidadeDominio> dados = new ArrayList<>();
		openConnection();
		DadosCadLivro dado = new DadosCadLivro();
		StringBuilder sb = new StringBuilder();
		try {
			sb.append("SELECT * FROM Autor");
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			ArrayList<Autor> autores = new ArrayList<>();
			while(rs.next()) {
				Autor a = new Autor();
				a.setId(rs.getInt("ID_Autor"));
				a.setNome(rs.getString("Nome_Autor"));
				autores.add(a);
			}
			dado.setAutores(autores);
		}catch (Exception e) {
			e.printStackTrace();
		}
		sb = new StringBuilder();
		try {
			sb.append("SELECT * FROM Categoria");
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			ArrayList<Categoria> categorias = new ArrayList<>();
			while(rs.next()) {
				Categoria c = new Categoria();
				c.setId(rs.getInt("ID_Categoria"));
				c.setNome(rs.getString("Nome_Categoria"));
				categorias.add(c);
			}
			
		}catch (Exception e) {
			// TODO: handle exception
		}
		return dados;
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

}
