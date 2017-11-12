package finalCore.impl.negocio;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalCore.IStrategy;
import finalCore.dao.CarrinhoDAO;
import finalDominio.Carrinho;
import finalDominio.EntidadeDominio;
import finalDominio.Produto;

public class ValidadorDonoCarrinho implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Produto){
			Produto produto = (Produto)entidade;
			CarrinhoDAO caDAO = new CarrinhoDAO();
			List<EntidadeDominio> carrinhos = new ArrayList<>();
			Carrinho carrinho = new Carrinho();
			
			try {
				carrinhos = caDAO.consultar(carrinho);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
			}
			
			int id = produto.getID_Carrinho();
			String email = produto.getEmail();
			String senha = produto.getSenha();
			Carrinho ca;
			System.out.println("Buscando carrinho id: " + id + " email: " + email + " senha: " + senha);
			
			for(EntidadeDominio c : carrinhos)
			{
				ca = (Carrinho)c;
				System.out.println(ca.getId());
				System.out.println(ca.getEmail());
				System.out.println(ca.getSenha());
				if(ca.getEmail().equals(email) && ca.getSenha().equals(senha) && ca.getId() == id)
					return null;
			}
			
		}else{
			return "Deve ser registrado um Carrinho!";
		}
		
		
		return "Erro na autenticação de dono do carrinho!\nVerifique o email e senha digitados";
	}
}