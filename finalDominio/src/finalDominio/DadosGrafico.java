package finalDominio;

import java.util.ArrayList;
import auxiliar.DadosAnaliseCategoria;
import auxiliar.DadosAnaliseGenero;

public class DadosGrafico extends EntidadeDominio{
	private ArrayList<DadosAnaliseCategoria> dadosAnaliseCategoria = new ArrayList<>();
	private ArrayList<DadosAnaliseGenero> dadosAnaliseGenero = new ArrayList<>();
	
	public ArrayList<DadosAnaliseCategoria> getDadosAnaliseCategoria() {
		return dadosAnaliseCategoria;
	}
	public void setDadosAnaliseCategoria(ArrayList<DadosAnaliseCategoria> dadosAnaliseCategoria) {
		this.dadosAnaliseCategoria = dadosAnaliseCategoria;
	}
	public ArrayList<DadosAnaliseGenero> getDadosAnaliseGenero() {
		return dadosAnaliseGenero;
	}
	public void setDadosAnaliseGenero(ArrayList<DadosAnaliseGenero> dadosAnaliseGenero) {
		this.dadosAnaliseGenero = dadosAnaliseGenero;
	}
}
