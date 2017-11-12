package finalWeb.command;

import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;

public interface ICommand {
	public Resultado execute(EntidadeDominio entidade);
}
