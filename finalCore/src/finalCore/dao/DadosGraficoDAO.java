package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import finalDominio.DadosGrafico;
import finalDominio.EntidadeDominio;

public class DadosGraficoDAO  extends AbstractJdbcDAO{
	public DadosGraficoDAO() {
		super("", "");
	}

	@Override
	public void salvar(EntidadeDominio entidade) throws SQLException {
		
	}

	@Override
	public void alterar(EntidadeDominio entidade) throws SQLException {
		
	}

	@Override
	public List<EntidadeDominio> consultar(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		PreparedStatement pst = null;
		//Cliente cliente = (Cliente) entidade;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT ID_Carrinho, ID_LIVRO, quantidade, autor, categoria, titulo, valor_livros, data_criacao\r\n" + 
				"FROM PRODUTO\r\n" + 
				"join livros using(id_livro)\r\n" + 
				"join carrinho using(id_carrinho)\r\n" + 
				"group by ID_LIVRO, ID_Carrinho\r\n" + 
				"order by 1, 2");
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			List<EntidadeDominio> dados = new ArrayList<>();
			while(rs.next()){
				DadosGrafico dado = new DadosGrafico();
				dado.setId_Carrinho(rs.getInt("ID_Carrinho"));
				dado.setId_Livro(rs.getInt("ID_Livro"));
				dado.setQuantidade(rs.getInt("quantidade"));
				dado.setAutor(rs.getString("autor"));
				dado.setCategoria(rs.getString("categoria"));
				dado.setTitulo(rs.getString("titulo"));
				dado.setValor_livros(rs.getDouble("valor_livros"));
				Calendar dataCompra = Calendar.getInstance();
				dataCompra.setTime(rs.getDate("data_criacao"));
				dado.setDataCompra(dataCompra);

				dados.add(dado);
			}
			return dados;
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}
}