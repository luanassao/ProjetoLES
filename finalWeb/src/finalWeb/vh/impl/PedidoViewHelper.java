package finalWeb.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import finalCore.aplicacao.Resultado;
import finalDominio.Carrinho;
import finalDominio.Cliente;
import finalDominio.Cupom;
import finalDominio.CupomTroca;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class PedidoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Carrinho carrinho = null;

		if(operacao.equals("TROCAR")) {
			Carrinho pedido = (Carrinho) request.getSession().getAttribute("carrinho");
			CupomTroca cupom = new CupomTroca();
			cupom.setID_Carrinho(pedido.getId());
			cupom.setValor(pedido.getValorLivros());
			cupom.setID_Cliente(pedido.getID_Cliente());
			return cupom;
		}
		else if(operacao.equals("SOLICITAR TROCA")) {
			Carrinho pedido = (Carrinho) request.getSession().getAttribute("carrinho");
			Cliente cliente = (Cliente) request.getSession().getAttribute("usuario");
			carrinho = new Carrinho();
			carrinho.setEmail(cliente.getEmail());
			carrinho.setID_Cliente(cliente.getId());
			carrinho.setStatus("EM TROCA");
			carrinho.setCupom(pedido.getCupom() == null ? new Cupom() : pedido.getCupom());
			carrinho.setEnderecoEntrega(pedido.getEnderecoEntrega());
			carrinho.setIdPedido(pedido.getId());
			carrinho.setCartao(pedido.getCartao());
			System.out.println("Solicitando troca!");
			for(int i = 0; i < pedido.getProdutos().size(); i++) {
				System.out.println(request.getParameter("cbTroca" + pedido.getProdutos().get(i).getId()));
				if(request.getParameter("cbTroca" + pedido.getProdutos().get(i).getId()) != null)
					carrinho.getProdutos().add(pedido.getProdutos().get(i));
			}
		}
		else if(operacao.equals("ALTERAR"))
		{
			Cliente cliente = (Cliente) request.getSession().getAttribute("usuario");
			Carrinho pedido = (Carrinho) request.getSession().getAttribute("carrinho");
			carrinho = new Carrinho();

			carrinho = pedido;
			if(cliente.getAdministrador()) {
				String status = request.getParameter("ddlStatus");
				carrinho.setStatus(status);
			}
			else
				carrinho.setStatus("EM TROCA");
		}
		else if(!operacao.equals("VISUALIZAR"))
		{
			String status = request.getParameter("ddlStatus");
			String email = request.getParameter("txtEmail");
			Cliente cliente = (Cliente) request.getSession().getAttribute("usuario");
			
			carrinho = new Carrinho();
			
			try {
				int id = Integer.parseInt(request.getParameter("txtId"));
				carrinho.setId(id);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int idC = Integer.parseInt(request.getParameter("txtIdCliente"));
				carrinho.setID_Cliente(idC);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int idEndereco = Integer.parseInt(request.getParameter("txtIdEndereco"));
				carrinho.setIdEndereco(idEndereco);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			if(!cliente.getAdministrador())
				carrinho.setEmail(cliente.getEmail());
			else
				carrinho.setEmail(email);
			carrinho.setStatus(status);
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
		
		String operacao = request.getParameter("operacao");
		System.out.println(resultado.getMsg());
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				resultado.setMsg("Carrinho cadastrado com sucesso!");
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormConsultaPedidos.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")){
			
			d= request.getRequestDispatcher("FormConsultaPedidos.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")){
			
			request.getSession().setAttribute("carrinho", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("FormPedido.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			
			request.getSession().setAttribute("resultado", null);
			d= request.getRequestDispatcher("FormConsultaPedidos.jsp");
		}
		
		if(resultado.getMsg() != null){
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				request.getSession().setAttribute("resultado", resultado);
				d= request.getRequestDispatcher("FormConsultaPedidos.jsp");  	
			}
		}
		d.forward(request,response);
	}

}
