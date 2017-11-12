package finalWeb.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import finalCore.aplicacao.Resultado;
import finalDominio.Carrinho;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class CarrinhoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Carrinho carrinho = null;

		if(!operacao.equals("VISUALIZAR"))
		{
			String email = request.getParameter("txtEmail");
			String senha = request.getParameter("txtSenha");
			String status = request.getParameter("ddlStatus");
			String formaPagamento = request.getParameter("ddlPagamento");
			
			carrinho = new Carrinho();
			
			try {
				int id = Integer.parseInt(request.getParameter("txtId"));
				carrinho.setId(id);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int idEndereco = Integer.parseInt(request.getParameter("txtIdEndereco"));
				carrinho.setIdEndereco(idEndereco);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			carrinho.setEmail(email);
			carrinho.setSenha(senha);
			carrinho.setStatus(status);
			carrinho.setFormaPagamento(formaPagamento);
		}
		else{
			
			HttpSession session = request.getSession();
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio c: resultado.getEntidades()){
				if(c.getId() == txtId){
					carrinho = (Carrinho)c;
				}
			}
		}
		return carrinho;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d=null;
		request.getSession().setAttribute("resultado", null);
		request.getSession().setAttribute("carrinho", null);
		
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				resultado.setMsg("Carrinho cadastrado com sucesso!");
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormConsultaCarrinho.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")){
			
			d= request.getRequestDispatcher("FormConsultaCarrinho.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")){
			
			request.setAttribute("carrinho", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("FormCompra.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			
			request.getSession().setAttribute("resultado", null);
			d= request.getRequestDispatcher("FormConsultaCarrinho.jsp");  
		}
		
		if(resultado.getMsg() != null){
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				request.getSession().setAttribute("resultado", resultado);
				d= request.getRequestDispatcher("FormConsultaCarrinho.jsp");  	
			}
		}
		d.forward(request,response);
	}

}
