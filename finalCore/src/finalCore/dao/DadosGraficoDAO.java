package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import auxiliar.DadosAnaliseCategoria;
import auxiliar.DadosAnaliseGenero;
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
		List<EntidadeDominio> dadosGraficoAnalise = new ArrayList<>();
		PreparedStatement pst = null;
		DadosGrafico dadosGrafico = (DadosGrafico)entidade;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT nome_categoria, DATE_FORMAT(data_criacao, '%Y-%m-01') as data_compra, sum(quantidade) as quantidade");
		sb.append(" FROM PRODUTO");
		sb.append(" join pedido using(id_pedido)");
		sb.append(" join livro_possui_categoria using(id_livro)");
		sb.append(" join categoria using(id_categoria)");
		sb.append(" join clientes using(id_cliente)");
		sb.append(" group by data_compra, Nome_Categoria");
		sb.append(" order by data_compra, Nome_Categoria");

		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			DadosAnaliseCategoria dadosCat;
			while(rs.next()){
				dadosCat = new DadosAnaliseCategoria();
				dadosCat.setCategoria(rs.getString("nome_categoria"));
				dadosCat.setQuantidade(rs.getInt("quantidade"));
				Calendar calendDataCompra = Calendar.getInstance();
				calendDataCompra.setTime(rs.getDate("data_compra"));
				dadosCat.setDtCompra(calendDataCompra);

				dadosGrafico.getDadosAnaliseCategoria().add(dadosCat);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		pst = null;
		sb = new StringBuilder();
		sb.append("SELECT DATE_FORMAT(data_criacao, '%Y-%m-01') as data_compra, sum(quantidade) as quantidade, genero");
		sb.append(" FROM PRODUTO");
		sb.append(" join pedido using(id_pedido)");
		sb.append(" join clientes using(id_cliente)");
		sb.append(" group by data_compra, genero");
		sb.append(" order by data_compra, genero");
		
		try{
			openConnection();
			pst = connection.prepareStatement(sb.toString());
			ResultSet rs = pst.executeQuery();
			DadosAnaliseGenero dadosGen;
			while(rs.next()){
				dadosGen = new DadosAnaliseGenero();
				dadosGen.setGenero(rs.getString("genero"));
				dadosGen.setQuantidade(rs.getInt("quantidade"));
				Calendar calendDataCompra = Calendar.getInstance();
				calendDataCompra.setTime(rs.getDate("data_compra"));
				dadosGen.setDtCompra(calendDataCompra);

				dadosGrafico.getDadosAnaliseGenero().add(dadosGen);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		dadosGraficoAnalise.add(dadosGrafico);
		return dadosGraficoAnalise;
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}
}