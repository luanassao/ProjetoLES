package finalWeb.command.impl;

import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;

public class ExcluirCommand  extends AbstractCommand{
	public Resultado execute(EntidadeDominio entidade) {
		
		return fachada.excluir(entidade);
	}
}
