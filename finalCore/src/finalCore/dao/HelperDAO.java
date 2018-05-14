package finalCore.dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import auxiliar.Autor;
import auxiliar.Categoria;
import auxiliar.CategoriaAtivacao;
import auxiliar.CategoriaInativacao;
import auxiliar.CupomDesconto;
import auxiliar.DadosCadLivro;
import auxiliar.Editora;
import auxiliar.Precificacao;
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
			/*PEGANDO AUTORES*/
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
			
			/*PEGANDO CATEGORIAS*/
			sb = new StringBuilder();
			sb.append("SELECT * FROM Categoria");
			pst = connection.prepareStatement(sb.toString());
			rs = pst.executeQuery();
			ArrayList<Categoria> categorias = new ArrayList<>();
			while(rs.next()) {
				Categoria c = new Categoria();
				c.setId(rs.getInt("ID_Categoria"));
				c.setNome(rs.getString("Nome_Categoria"));
				categorias.add(c);
			}
			dado.setCategorias(categorias);

			/*PEGANDO GRUPOS DE PRECIFICAÇÃO*/
			sb = new StringBuilder();
			sb.append("SELECT * FROM Precificacao");
			pst = connection.prepareStatement(sb.toString());
			rs = pst.executeQuery();
			ArrayList<Precificacao> precificacoes = new ArrayList<>();
			while(rs.next()) {
				Precificacao p = new Precificacao();
				p.setId(rs.getInt("ID_Precificacao"));
				p.setNome(rs.getString("Nome_Precificacao"));
				p.setMargem(rs.getInt("Margem"));
				precificacoes.add(p);
			}
			dado.setPrecificacoes(precificacoes);
			
			/*PEGANDO EDITORAS*/
			sb = new StringBuilder();
			sb.append("SELECT * FROM Editora");
			pst = connection.prepareStatement(sb.toString());
			rs = pst.executeQuery();
			ArrayList<Editora> editoras = new ArrayList<>();
			while(rs.next()) {
				Editora e = new Editora();
				e.setId(rs.getInt("ID_Editora"));
				e.setNome(rs.getString("Nome_Editora"));
				editoras.add(e);
			}
			dado.setEditoras(editoras);
			
			/*PEGANDO CATEGORIAS DE ATIVAÇÃO*/
			sb = new StringBuilder();
			sb.append("SELECT * FROM categoria_ativacao");
			pst = connection.prepareStatement(sb.toString());
			rs = pst.executeQuery();
			ArrayList<CategoriaAtivacao> catsAtiv = new ArrayList<>();
			while(rs.next()) {
				CategoriaAtivacao catA = new CategoriaAtivacao();
				catA.setId(rs.getInt("ID_Cat_Ativacao"));
				catA.setNome(rs.getString("Nome_Cat_Ativacao"));
				catsAtiv.add(catA);
			}
			dado.setCategoriasAtivacao(catsAtiv);

			/*PEGANDO CATEGORIAS DE INATIVAÇÃO*/
			sb = new StringBuilder();
			sb.append("SELECT * FROM categoria_inativacao");
			pst = connection.prepareStatement(sb.toString());
			rs = pst.executeQuery();
			ArrayList<CategoriaInativacao> catsInativ = new ArrayList<>();
			while(rs.next()) {
				CategoriaInativacao catIna = new CategoriaInativacao();
				catIna.setId(rs.getInt("ID_Cat_Inativacao"));
				catIna.setNome(rs.getString("Nome_Cat_Inativacao"));
				catsInativ.add(catIna);
			}
			dado.setCategoriasInativacao(catsInativ);
			
			/*PEGANDO CUPONS DE DESCONTO*/
			sb = new StringBuilder();
			sb.append("SELECT * FROM cupom_desconto");
			pst = connection.prepareStatement(sb.toString());
			rs = pst.executeQuery();
			ArrayList<CupomDesconto> cuponsDesconto = new ArrayList<>();
			while(rs.next()) {
				CupomDesconto cupomDesc = new CupomDesconto();
				cupomDesc.setId(rs.getInt("ID_Cupom_Desconto"));
				cupomDesc.setCodigo(rs.getString("Codigo"));
				cupomDesc.setValor(rs.getDouble("valor"));
				cuponsDesconto.add(cupomDesc);
			}
			dado.setCuponsDesconto(cuponsDesconto);
			
			dados.add(dado);
			return dados;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public void excluir(EntidadeDominio entidade) throws SQLException {
		// TODO Auto-generated method stub
		
	}

}
