package finalWeb.vh.impl;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auxiliar.CupomDesconto;
import auxiliar.DadosCadLivro;
import finalCore.aplicacao.Resultado;
import finalDominio.Carrinho;
import finalDominio.Cartao;
import finalDominio.Cliente;
import finalDominio.Cupom;
import finalDominio.CupomTroca;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;
import finalWeb.vh.IViewHelper;

public class PedidoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Carrinho carrinho = null;
		HttpSession session = request.getSession();
		Cliente usuario = (Cliente)session.getAttribute("usuario");

		switch (operacao) {
		case "SALVAR":
			carrinho = (Carrinho)session.getAttribute("carrinho");
			String[] idsLivros = request.getParameter("txtIdLivros").split(" ");
			for(String id : idsLivros) {
				int idLivro = Integer.parseInt(id);
				for(Produto p:carrinho.getProdutos()) {
					if(idLivro == p.getLivro().getId()) {
						p.setQuantidadeAnt(p.getQuantidade() - Integer.parseInt(request.getParameter("txtQtde" + idLivro)));
						p.setQuantidade(Integer.parseInt(request.getParameter("txtQtde" + idLivro)));
					}
				}
			}
			CupomDesconto cupom = (CupomDesconto)session.getAttribute("cupom");
			
			int idEndereco = Integer.parseInt(request.getParameter("hdIdEndereco"));
			for(Endereco e:usuario.getEnderecos()) {
				if(e.getId() == idEndereco)
					carrinho.setEnderecoEntrega(e);
			}
			
			String[] idsCartoes = request.getParameter("hdIdCartao").split(" ");
			ArrayList<Cartao> cartoes = new ArrayList<>();
			for(String idCartao:idsCartoes) {
				for(Cartao c:usuario.getCartoes()) {
					if(idCartao.equals(c.getId() + "")) {
						c.setCredito(Double.parseDouble(request.getParameter("txtPagarCartao" + c.getId())));
						cartoes.add(c);
					}
				}
			}
			carrinho.setCartoes(cartoes);
			
			String idCupom = request.getParameter("hdIdCupomDesconto");
			DadosCadLivro dados = (DadosCadLivro)((Resultado) session.getAttribute("dados")).getEntidades().get(0);
			for(CupomDesconto c:dados.getCuponsDesconto()) {
				if(idCupom.equals(c.getId() + ""))
					carrinho.setCupomDesconto(c);
			}
			
			if(cupom == null)
				cupom = new CupomDesconto();
			carrinho.setID_Cliente(usuario.getId());
			carrinho.setEmail(usuario.getEmail());
			carrinho.setStatus("EM PROCESSAMENTO");
			break;
		case "CONSULTAR":
			carrinho = new Carrinho();
			if(!usuario.getAdministrador()) {
				carrinho.setID_Cliente(usuario.getId());
				carrinho.setStatus(request.getParameter("ddlStatus"));
			}
			else {
				try {
					carrinho.setId(Integer.parseInt(request.getParameter("txtIdPedido")));
				}catch (Exception e) {
					// Nenhum id informado
					carrinho.setId(0);
				}
				try {
					carrinho.setID_Cliente(Integer.parseInt(request.getParameter("txtIdCliente")));
				}catch (Exception e) {
					// Nenhum id informado
					carrinho.setID_Cliente(0);
				}
				carrinho.setEmail(request.getParameter("txtEmail"));
				carrinho.setStatus(request.getParameter("ddlStatus"));
			}
			break;
		case "VISUALIZAR":
			@SuppressWarnings("unchecked")
			ArrayList<EntidadeDominio> pedidos = (ArrayList<EntidadeDominio>)session.getAttribute("pedidos");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio c: pedidos){
				if(c.getId() == txtId){
					carrinho = (Carrinho)c;
				}
			}
			break;
		case "ALTERAR":
			Carrinho pedido = (Carrinho) request.getSession().getAttribute("carrinho");
			carrinho = new Carrinho();

			carrinho = pedido;
			if(usuario.getAdministrador()) {
				String status = request.getParameter("ddlStatus");
				carrinho.setStatus(status);
			}
			else
				carrinho.setStatus("EM TROCA");
			break;
		default:
			break;
		}
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
			carrinho.setCupomDesconto(pedido.getCupomDesconto() == null ? new CupomDesconto() : pedido.getCupomDesconto());
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
		else if(operacao.equals("ALTERARR"))
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
		else if(operacao.equals("VISUALIZARRR"))
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
		else if(operacao.equals("asd")){
			
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
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				resultado.setMsg("Carrinho cadastrado com sucesso!");
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormConsultaPedidos.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) {
			request.getSession().setAttribute("pedidos", resultado.getEntidades());
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
