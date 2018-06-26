package finalWeb.vh.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import finalCore.aplicacao.Resultado;
import finalCore.util.GeradorDadosGrafico;
import finalDominio.DadosGrafico;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class AnaliseViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		DadosGrafico dadosGrafico = new DadosGrafico();
		Calendar dtInicio = Calendar.getInstance();
		String[] anoMesInicio;
		Calendar dtFim = Calendar.getInstance();
		String[] anoMesFim;
		try {
			anoMesInicio = request.getParameter("txtDtInicio").split("-");
			dtInicio.set(Integer.parseInt(anoMesInicio[0]), Integer.parseInt(anoMesInicio[1]), 1);
		}catch (Exception e) {
			dtInicio = null;
		}
		try {
			anoMesFim = request.getParameter("txtDtFim").split("-");
			dtFim.set(Integer.parseInt(anoMesFim[0]), Integer.parseInt(anoMesFim[1]), 1);
		}catch (Exception e) {
			dtFim = null;
		}
		try {
			String[] categorias = request.getParameterValues("cbCategoria");
			for(String cat:categorias) {
				dadosGrafico.getCategorias().add(cat);
			}
		}catch (Exception e) {
			dadosGrafico.setCategorias(new ArrayList<String>());
		}
		dadosGrafico.setDtInicial(dtInicio);
		dadosGrafico.setDtFinal(dtFim);
		return dadosGrafico;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		DadosGrafico dadosGrafico = (DadosGrafico)resultado.getEntidades().get(0);
		GeradorDadosGrafico geradorDadosGrafico = new GeradorDadosGrafico();
		String jsonDadosGraficoCat = geradorDadosGrafico.gerarDadosGraficoCategoria(dadosGrafico);
		String jsonDadosGraficoGen = geradorDadosGrafico.gerarDadosGraficoGenero(dadosGrafico);
		request.getSession().setAttribute("dadosGraficoCat", jsonDadosGraficoCat);
		request.getSession().setAttribute("dadosGraficoGen", jsonDadosGraficoGen);
		RequestDispatcher d = request.getRequestDispatcher("GraficoCategoria.jsp");
		d.forward(request, response);
	}

}
