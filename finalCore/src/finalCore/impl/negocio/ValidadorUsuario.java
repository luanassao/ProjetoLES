package finalCore.impl.negocio;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalCore.IStrategy;
import finalCore.dao.ClienteDAO;
import finalDominio.Cliente;
import finalDominio.EntidadeDominio;

public class ValidadorUsuario implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Cliente){
			System.out.println("Validando usuario");
			Cliente cliente = (Cliente)entidade;
			ClienteDAO cliDAO = new ClienteDAO();
			List<EntidadeDominio> clientes = new ArrayList<>();
			
			try {
				clientes = cliDAO.consultar(null);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
			}
			
			String email = cliente.getEmail();
			String senha = cliente.getSenha();
			Cliente cli;
			
			for(EntidadeDominio c : clientes)
			{
				cli = (Cliente)c;
				if(cli.getEmail().equals(email) && cli.getSenha().equals(senha))
				{
					cliente.setNome(cli.getNome());
					return null;
				}
			}
			
		}else{
			return "Deve ser registrado um Cliente!";
		}
		
		
		return "Ocorreu um erro durante a autenticação!\nVerifique o email e senha digitados";
	}
}