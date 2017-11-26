package finalCore.impl.negocio;

import java.util.ArrayList;
import java.util.List;

import finalCore.IStrategy;
import finalCore.dao.LivroDAO;
import finalDominio.Carrinho;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;

public class AdicionadorCustoFrete implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Carrinho){
			Carrinho carrinho = (Carrinho)entidade;
			double preco;
			
			for(Produto p : carrinho.getProdutos())
			{
				
			}
		}else{
			return "Deve ser registrado um Produto!";
		}
		
		
		return null;
	}

}
