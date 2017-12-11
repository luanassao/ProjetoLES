package finalWeb.vh.impl;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import finalCore.aplicacao.Resultado;
import finalDominio.Cartao;
import finalDominio.Cliente;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class CartaoViewHelper  implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Cartao cartao = null;

		if(!operacao.equals("VISUALIZAR"))
		{
			String titular = request.getParameter("txtTitular");
			String numero = request.getParameter("txtNumeroCartao");
			String codigo = request.getParameter("txtCodigo");
			String responsavel = request.getParameter("txtResponsavel");
			String bandeira = request.getParameter("ddlBandeira");
			
			Calendar validade = Calendar.getInstance();
			System.out.println(request.getParameter("txtDtNasc"));
			try
			{
				String[] dtNasc = request.getParameter("txtValidade").split("-");
				int dia = Integer.parseInt(dtNasc[2]);
				int mes = Integer.parseInt(dtNasc[1]);
				int ano = Integer.parseInt(dtNasc[0]);
				validade.set(ano, mes, dia);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			cartao = new Cartao();
			
			try {
				Boolean preferencial = request.getParameter("rdCPreferencial").equals("true") ? true : false;
				preferencial = request.getParameter("rdCPreferencial").equals("todos") ? null : preferencial;
				cartao.setPreferencial(preferencial);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int idc;
				HttpSession session = request.getSession();
				Cliente cliente = (Cliente)session.getAttribute("usuario");
				if(cliente.getAdministrador())
					idc = Integer.parseInt(request.getParameter("txtIdCliente"));
				else
					idc = cliente.getId();
				cartao.setID_Cliente(idc);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			cartao.setBandeira(bandeira);
			cartao.setTitular(titular);
			cartao.setNumero(numero);
			cartao.setCodigo(codigo);
			cartao.setAlterador(responsavel);
			cartao.setValidade(validade);
		}
		else{
			
			HttpSession session = request.getSession();
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio c: resultado.getEntidades()){
				if(c.getId() == txtId){
					cartao = (Cartao)c;
				}
			}
		}
		return cartao;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d=null;
		request.getSession().setAttribute("resultado", null);
		request.getSession().setAttribute("cartao", null);
		
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				resultado.setMsg("Cartao cadastrado com sucesso!");
				Cliente usuario = (Cliente)request.getSession().getAttribute("usuario");
				usuario.getCartoes().add((Cartao)resultado.getEntidades().get(0));
				request.getSession().setAttribute("usuario", usuario);
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormConsultaCartao.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")){
			
			d= request.getRequestDispatcher("FormConsultaCartao.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("SALVAR NOVO")){
			Cliente usuario = (Cliente)request.getSession().getAttribute("usuario");
			usuario.getCartoes().add((Cartao)resultado.getEntidades().get(0));
			request.getSession().setAttribute("usuario",usuario);
			d= request.getRequestDispatcher("FormCarrinho.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")){
			
			request.setAttribute("cartao", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("FormClienteEnd.jsp"); 
			//d= request.getRequestDispatcher("FormCliente.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			
			request.getSession().setAttribute("resultado", null);
			d= request.getRequestDispatcher("FormConsultaCartao.jsp");  
		}
		
		if(resultado.getMsg() != null){
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				request.getSession().setAttribute("resultado", resultado);
				d= request.getRequestDispatcher("FormConsultaCartao.jsp");
			}
		}
		d.forward(request,response);
	}

}