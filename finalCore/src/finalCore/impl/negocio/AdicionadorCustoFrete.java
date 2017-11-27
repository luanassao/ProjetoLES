package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.Carrinho;
import finalDominio.EntidadeDominio;
import finalDominio.Produto;

public class AdicionadorCustoFrete implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Carrinho){
			Carrinho carrinho = (Carrinho)entidade;
			double preco = 0.0;
			
			for(Produto p : carrinho.getProdutos())
			{
				preco += p.getLivro().getPeso();
				preco += p.getLivro().getPeso() * p.getQuantidade();
			}
			preco += carrinho.getEnderecoEntrega().getId() % 2 == 0 ? 20 : 30;
			
			carrinho.setFrete(preco);
		}else{
			return "Deve ser registrado um Produto!";
		}
		
		
		return null;
	}

}
