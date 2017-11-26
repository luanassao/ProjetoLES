package finalCore.impl.negocio;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalCore.IStrategy;
import finalCore.dao.CartaoDAO;
import finalCore.dao.ClienteDAO;
import finalCore.dao.EnderecoDAO;
import finalDominio.Cartao;
import finalDominio.Cliente;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;

public class ValidadorUsuario implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Cliente){
			Cliente cliente = (Cliente)entidade;
			ClienteDAO cliDAO = new ClienteDAO();
			EnderecoDAO endDAO = new EnderecoDAO();
			CartaoDAO cartaoDAO = new CartaoDAO();
			List<EntidadeDominio> clientes = new ArrayList<>();
			List<EntidadeDominio> enderecos = new ArrayList<>();
			List<EntidadeDominio> cartoes = new ArrayList<>();
			List<Endereco> enderecosCliente = new ArrayList<>();
			List<Cartao> cartoesCliente = new ArrayList<>();
			
			try {
				clientes = cliDAO.consultar(new Cliente());
				enderecos = endDAO.consultar(new Endereco());
				cartoes = cartaoDAO.consultar(new Cartao());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
			}
			
			String email = cliente.getEmail();
			String senha = cliente.getSenha();
			Cliente cli;
			Endereco end;
			Cartao car;
			
			for(EntidadeDominio c : clientes)
			{
				cli = (Cliente)c;
				if(cli.getEmail().equals(email) && cli.getSenha().equals(senha))
				{
					cliente.setNome(cli.getNome());
					cliente.setId(cli.getId());
					for(EntidadeDominio e : enderecos)
					{
						end = (Endereco)e;
						if(cliente.getId() == end.getID_Cliente())
							enderecosCliente.add(end);
					}
					for(EntidadeDominio cart : cartoes)
					{
						car = (Cartao)cart;
						if(cliente.getId() == car.getID_Cliente())
							cartoesCliente.add(car);
					}
					cliente.setEnderecos(enderecosCliente);
					cliente.setCartoes(cartoesCliente);
					return null;
				}
			}
			
		}else{
			return "Deve ser registrado um Cliente!";
		}
		
		
		return "Ocorreu um erro durante a autenticação!\nVerifique o email e senha digitados";
	}
}