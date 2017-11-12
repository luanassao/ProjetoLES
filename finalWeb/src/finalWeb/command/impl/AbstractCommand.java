package finalWeb.command.impl;

import finalCore.IFachada;
import finalCore.controle.Fachada;
import finalWeb.command.ICommand;

public abstract class AbstractCommand implements ICommand{
	protected IFachada fachada = new Fachada();
}
