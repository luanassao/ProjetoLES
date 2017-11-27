package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.Carrinho;
import finalDominio.EntidadeDominio;
import finalDominio.Produto;

public class AtualizadorPrecoCarrinho implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Carrinho){
			Carrinho carrinho = (Carrinho)entidade;
			double preco = 0.0;
			
			for(Produto p : carrinho.getProdutos())
			{
				preco += p.getLivro().getValor() * p.getQuantidade();
			}
			carrinho.setValorLivros(preco);
			preco += carrinho.getFrete();
			carrinho.setValorTotal(preco - carrinho.getCupom().getValor());
		}else{
			return "Deve ser registrado um Produto!";
		}
		
		
		return null;
	}

}
