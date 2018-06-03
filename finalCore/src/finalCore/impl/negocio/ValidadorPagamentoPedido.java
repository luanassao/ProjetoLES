package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.Carrinho;
import finalDominio.Cartao;
import finalDominio.CupomTroca;
import finalDominio.EntidadeDominio;

public class ValidadorPagamentoPedido implements IStrategy{

	@Override
	public String processar(EntidadeDominio entidade) {
		if(entidade instanceof Carrinho){
			Carrinho pedido = (Carrinho)entidade;
			if(pedido.getId() > 0)
				return null;
			Double pagamentoCartao = 0.0, pagamentoCupom = 0.0;
			Double pagamentoTotal = 0.0;
			
			for(Cartao c:pedido.getCartoes()) {
				pagamentoCartao += c.getCredito();
			}
			
			for(CupomTroca c:pedido.getCuponsTroca()) {
				pagamentoCupom += c.getValor();
			}
			
			pagamentoTotal = pagamentoCartao + pagamentoCupom;
			
			if(pagamentoTotal < pedido.getValorTotal())
			{
				if(pedido.getFlgCorretorPreco()) {
					int indice = pedido.getCartoes().size() - 1;
					Double adicionar = pedido.getCartoes().get(indice).getCredito() + pedido.getValorTotal() - pagamentoTotal;
					if(pedido.getCupomDesconto() != null && pedido.getCupomDesconto().getValor() > 0)
						adicionar -= pedido.getCupomDesconto().getValor();
					pedido.getCartoes().get(indice).setCredito(adicionar);
				}
				else
					return "Forma de pagamento invalida, o total informado é inferior ao preço da compra";
			}
			
		}else{
			return "Deve ser registrado um Carrinho!";
		}
		
		
		return null;
	}

}
