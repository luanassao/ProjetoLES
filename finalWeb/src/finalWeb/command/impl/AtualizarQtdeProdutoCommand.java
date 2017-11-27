package finalWeb.command.impl;

import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;

public class AtualizarQtdeProdutoCommand extends AbstractCommand{

	@Override
	public Resultado execute(EntidadeDominio entidade) {
		return fachada.atualizarQuantidadeProduto(entidade);
	}

}
