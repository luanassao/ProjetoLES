package finalWeb.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auxiliar.DadosCadLivro;
import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class DadosViewHelper implements IViewHelper{
	/** 
	 * TODO Descrição do Método
	 * @param request
	 * @param response
	 * @return
	 * @see lesWeb.vh.IViewHelper#getEntidade(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		// TODO Auto-generated method stub
		
		DadosCadLivro dados = new DadosCadLivro();
		return dados;
	}

	/** 
	 * TODO Descrição do Método
	 * @param request
	 * @param response
	 * @return
	 * @see lesWeb.controle.web.vh.IViewHelper#setView(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		request.getSession().setAttribute("livro", null);
		String operacao = request.getParameter("target");
			EntidadeDominio e = resultado.getEntidades().get(0);
			DadosCadLivro dados = (DadosCadLivro)e;
			request.getSession().setAttribute("autores", dados.getAutores());
		request.getSession().setAttribute("dados", resultado);
		RequestDispatcher d= request.getRequestDispatcher(operacao);
		d.forward(request,response);
	}

}
