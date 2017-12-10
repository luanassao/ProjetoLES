package finalCore.impl.negocio;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalCore.IStrategy;
import finalCore.dao.CartaoDAO;
import finalCore.dao.ClienteDAO;
import finalCore.dao.CupomTrocaDAO;
import finalCore.dao.EnderecoDAO;
import finalDominio.Cartao;
import finalDominio.Cliente;
import finalDominio.CupomTroca;
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
			CupomTrocaDAO cupomDAO = new CupomTrocaDAO();
			List<EntidadeDominio> clientes = new ArrayList<>();
			List<EntidadeDominio> enderecos = new ArrayList<>();
			List<EntidadeDominio> cartoes = new ArrayList<>();
			List<EntidadeDominio> cupons = new ArrayList<>();
			List<Endereco> enderecosCliente = new ArrayList<>();
			List<Cartao> cartoesCliente = new ArrayList<>();
			List<CupomTroca> cuponsCliente = new ArrayList<>();
			
			try {
				clientes = cliDAO.consultar(new Cliente());
				enderecos = endDAO.consultar(new Endereco());
				cartoes = cartaoDAO.consultar(new Cartao());
				cupons = cupomDAO.consultar(new CupomTroca());
			} catch (SQLException e) {
				// TODO Auto-generated catch block
			}
			
			String email = cliente.getEmail();
			String senha = cliente.getSenha();
			Cliente cli;
			Endereco end;
			Cartao car;
			CupomTroca cupo;
			
			for(EntidadeDominio c : clientes)
			{
				cli = (Cliente)c;
				if(cli.getEmail().equals(email) && cli.getSenha().equals(senha))
				{
					cliente.setNome(cli.getNome());
					cliente.setId(cli.getId());
					cliente.setAdministrador(cli.getAdministrador());
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
					for(EntidadeDominio cup : cupons)
					{
						cupo = (CupomTroca)cup;
						if(cliente.getId() == cupo.getID_Cliente()) {
							System.out.println("ID: " + cupo.getId() +
									" ID_Cliente: " + cupo.getID_Cliente() +
									" Valor: " + cupo.getValor());
							cuponsCliente.add(cupo);
						}
					}
					cliente.setEnderecos(enderecosCliente);
					cliente.setCartoes(cartoesCliente);
					cliente.setCupons(cuponsCliente);
					return null;
				}
			}
			
		}else{
			return "Deve ser registrado um Cliente!";
		}
		
		
		return "Ocorreu um erro durante a autenticação!\nVerifique o email e senha digitados";
	}
}