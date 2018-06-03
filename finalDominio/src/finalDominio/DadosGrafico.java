package finalDominio;

import java.util.ArrayList;
import java.util.Calendar;

import auxiliar.DadosAnaliseCategoria;
import auxiliar.DadosAnaliseGenero;

public class DadosGrafico extends EntidadeDominio{
	private ArrayList<DadosAnaliseCategoria> dadosAnaliseCategoria = new ArrayList<>();
	private ArrayList<DadosAnaliseGenero> dadosAnaliseGenero = new ArrayList<>();
	private ArrayList<String> categorias = new ArrayList<>();
	private Calendar dtInicial, dtFinal;
	
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
	public Calendar getDtInicial() {
		return dtInicial;
	}
	public String getDtInicialFormatado() {
		String data = dtInicial.get(Calendar.YEAR) + "-" + dtInicial.get(Calendar.MONTH) + "-" + "1";
		return data;
	}
	public void setDtInicial(Calendar dtInicial) {
		this.dtInicial = dtInicial;
	}
	public Calendar getDtFinal() {
		return dtFinal;
	}
	public String getDtFinalFormatado() {
		String data = dtFinal.get(Calendar.YEAR) + "-" + dtFinal.get(Calendar.MONTH) + "-" + dtFinal.getActualMaximum(Calendar.DAY_OF_MONTH);
		return data;
	}
	public void setDtFinal(Calendar dtFinal) {
		this.dtFinal = dtFinal;
	}
	public ArrayList<String> getCategorias() {
		return categorias;
	}
	public void setCategorias(ArrayList<String> categorias) {
		this.categorias = categorias;
	}
}
