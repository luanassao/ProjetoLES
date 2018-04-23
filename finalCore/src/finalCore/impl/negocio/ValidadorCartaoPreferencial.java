package finalCore.impl.negocio;

import java.sql.SQLException;

import finalCore.IStrategy;
import finalCore.dao.CartaoDAO;
import finalDominio.Cartao;
import finalDominio.EntidadeDominio;

public class ValidadorCartaoPreferencial implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Cartao){
			Cartao cartao = (Cartao)entidade;
			CartaoDAO cartDAO = new CartaoDAO();
			
			if(cartao.getPreferencial())
			{
				Cartao c = new Cartao();
				c.setPreferencial(false);
				c.setTitular("Alterar cartoes");
				c.setID_Cliente(cartao.getID_Cliente());
				try {
					cartDAO.alterar(c);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			
		}else{
			return "Deve ser registrado um Endereço!";
		}
		
		
		return null;
	}
}
