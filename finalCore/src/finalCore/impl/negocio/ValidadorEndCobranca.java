package finalCore.impl.negocio;

import java.sql.SQLException;

import finalCore.IStrategy;
import finalCore.dao.EnderecoDAO;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;

public class ValidadorEndCobranca implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Endereco){
			Endereco endereco = (Endereco)entidade;
			EnderecoDAO endDAO = new EnderecoDAO();
			
			if(endereco.getTipo().equals("Cobranca"))
			{
				Endereco e = new Endereco();
				e.setNomeEndereco("Alterar enderecos");
				e.setID_Cliente(endereco.getID_Cliente());
				try {
					endDAO.alterar(e);
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			
		}else{
			return "Deve ser registrado um Endereço!";
		}
		
		
		return null;
	}
}
