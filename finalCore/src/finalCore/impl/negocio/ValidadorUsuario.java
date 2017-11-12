package finalCore.impl.negocio;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalCore.IStrategy;
import finalCore.dao.ClienteDAO;
import finalDominio.Carrinho;
import finalDominio.Cliente;
import finalDominio.EntidadeDominio;

public class ValidadorUsuario implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Carrinho){
			Carrinho carrinho = (Carrinho)entidade;
			ClienteDAO cliDAO = new ClienteDAO();
			List<EntidadeDominio> clientes = new ArrayList<>();
			
			try {
				clientes = cliDAO.consultar(null);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
			}
			
			String email = carrinho.getEmail();
			String senha = carrinho.getSenha();
			Cliente cli;
			
			for(EntidadeDominio c : clientes)
			{
				cli = (Cliente)c;
				if(cli.getEmail().equals(email) && cli.getSenha().equals(senha))
					return null;
			}
			
		}else{
			return "Deve ser registrado um Carrinho!";
		}
		
		
		return "Ocorreu um erro durante a autenticação!\nVerifique o email e senha digitados";
	}
}