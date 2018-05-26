package finalWeb.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auxiliar.DadosAnaliseCategoria;
import finalCore.aplicacao.Resultado;
import finalDominio.DadosGrafico;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class AnaliseViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		DadosGrafico dadosGrafico = new DadosGrafico();
		return dadosGrafico;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		DadosGrafico dadosGrafico = (DadosGrafico)resultado.getEntidades().get(0);
		for(DadosAnaliseCategoria d:dadosGrafico.getDadosAnaliseCategoria()) {
			System.out.println("Categoria: " + d.getCategoria() + "\tData da compra: " + d.getDtCompraFormatado() + "\tQuantidade: " + d.getQuantidade());
		}
		request.getSession().setAttribute("dadosGrafico", dadosGrafico);
		RequestDispatcher d = request.getRequestDispatcher("GraficoCategoria.jsp");
		d.forward(request, response);
	}

}
