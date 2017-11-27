package finalWeb.command.impl;

import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;

public class AtualizarCarrinho extends AbstractCommand{

	@Override
	public Resultado execute(EntidadeDominio entidade) {
		return fachada.atualizarQuantidadeProduto(entidade);
	}

}
