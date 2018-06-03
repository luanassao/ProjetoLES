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
			if(carrinho.getId() > 0) {
				ArrayList<Produto> produtosTroca = new ArrayList<>();
				String[] idProdutos = request.getParameterValues("cbTroca");
				int idProduto, quantidade;
				try {
					for(String s:idProdutos) {
						idProduto = Integer.parseInt(s);
						for(Produto p:carrinho.getProdutos()) {
							if(idProduto == p.getId()) {
								quantidade = Integer.parseInt(request.getParameter("txtQtde" + p.getId()));
								p.setQuantidade(quantidade);
								produtosTroca.add(p);
							}
						}
					}
				}catch (Exception e) {
					e.printStackTrace();
				}
				carrinho.setProdutos(produtosTroca);
				Double valorTroca = 0.0;
				for(Produto p:carrinho.getProdutos()) {
					System.out.println("Trocar: " + p.getId() + " Quantidade: " + p.getQuantidade());
					valorTroca += p.getLivro().getValor() * p.getQuantidade();
				}
				carrinho.setValorLivros(valorTroca);
				carrinho.setValorTotal(valorTroca);
				carrinho.setFrete(0.0);
				carrinho.setStatus("EM TROCA");
			}
			else {
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
							try {
								c.setCredito(Double.parseDouble(request.getParameter("txtPagarCartao" + c.getId())));
							}catch (Exception e) {
								c.setCredito(10.0);
							}
							cartoes.add(c);
						}
					}
				}
				carrinho.setCartoes(cartoes);
				
				String[] idsCuponsTroca = request.getParameter("hdIdCupomTroca").split(" ");
				ArrayList<CupomTroca> cuponsTroca = new ArrayList<>();
				for(String idCUpomTroca:idsCuponsTroca) {
					for(CupomTroca c:usuario.getCupons()) {
						if(idCUpomTroca.equals(c.getId() + "")) {
							cuponsTroca.add(c);
						}
					}
				}
				carrinho.setCuponsTroca(cuponsTroca);
				
				String idCupom = request.getParameter("hdIdCupomDesconto");
				DadosCadLivro dados = (DadosCadLivro)((Resultado) session.getAttribute("dados")).getEntidades().get(0);
				for(CupomDesconto c:dados.getCuponsDesconto()) {
					if(idCupom.equals(c.getId() + "")) {
						carrinho.setCupomDesconto(c);
					}
				}
				
				String garantirCompra = request.getParameter("cbGarantirCompra");
				try {
					if(garantirCompra.equals("true")) {
						carrinho.setFlgCorretorPreco(true);
					}
				}catch (Exception e) {
					carrinho.setFlgCorretorPreco(false);
				}
				
				if(cupom == null)
					cupom = new CupomDesconto();
				carrinho.setID_Cliente(usuario.getId());
				carrinho.setEmail(usuario.getEmail());
				carrinho.setStatus("EM PROCESSAMENTO");
			}
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
				try {
					String repor = request.getParameter("cbReporEstoque");
					if(status.equals("TROCADO") && repor.equals("true")) {
						carrinho.setFlgReporEstoque(true);
					}
				}catch (Exception e) {
					carrinho.setFlgReporEstoque(false);
				}
					
				carrinho.setStatus(status);
			}
			else
				carrinho.setStatus("EM TROCA");
			break;
		default:
			break;
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
				request.getSession().setAttribute("carrinho", new Carrinho());
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
