package finalWeb.command.impl;

import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;

public class SalvarCommand extends AbstractCommand{
	public Resultado execute(EntidadeDominio entidade) {
		
		return fachada.salvar(entidade);
	}
}
