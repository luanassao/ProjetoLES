package finalWeb.vh.impl;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import finalCore.aplicacao.Resultado;
import finalDominio.Carrinho;
import finalDominio.Cartao;
import finalDominio.Cliente;
import finalDominio.Cupom;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;
import finalWeb.vh.IViewHelper;

public class CompraViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Produto produto = null;

		if(operacao.equals("FINALIZAR")) {
			HttpSession session = request.getSession();
			Carrinho carrinho = (Carrinho)session.getAttribute("carrinho");
			Endereco endereco = (Endereco)session.getAttribute("enderecoEntrega");
			Cliente cliente = (Cliente)session.getAttribute("usuario");
			Cartao cartao = (Cartao)session.getAttribute("cartao");
			Cupom cupom = (Cupom)session.getAttribute("cupom");
			if(cupom == null)
				cupom = new Cupom();
			carrinho.setID_Cliente(cliente.getId());
			carrinho.setEmail(cliente.getEmail());
			carrinho.setCupom(cupom);
			carrinho.setCartao(cartao);
			carrinho.setEnderecoEntrega(endereco);
			return carrinho;
		}
		else if(operacao.equals("ATUALIZAR")) {
			HttpSession session = request.getSession();
			Carrinho carrinho = (Carrinho)session.getAttribute("carrinho");
			Cupom cupom = (Cupom)session.getAttribute("cupom");
			if(cupom == null)
				cupom = new Cupom();
			carrinho.setCupom(cupom);
			int idLivro = Integer.parseInt(request.getParameter("txtIdLivro"));
			int quantidade = Integer.parseInt(request.getParameter("txtQtde"));
			for(Produto p : carrinho.getProdutos())
			{
				if(p.getLivro().getId() == idLivro)
					p.setQuantidade(quantidade);
			}
			return carrinho;
		}
		else if(operacao.equals("VERIFICAR")) {
			Cupom cupom = new Cupom();
			cupom.setCodigo(request.getParameter("txtCupom"));
			return cupom;
		}
		else if(operacao.equals("CONFIRMAR")) {
			HttpSession session = request.getSession();
			Carrinho carrinho = (Carrinho)session.getAttribute("carrinho");
			Cliente cliente = (Cliente)session.getAttribute("usuario");
			int indice = Integer.parseInt(request.getParameter("txtIndice"));
			carrinho.setCartao(cliente.getCartoes().get(indice));
			return carrinho.getCartao();
		}
		else if(operacao.equals("SELECIONAR"))
		{
			HttpSession session = request.getSession();
			Carrinho carrinho = (Carrinho)session.getAttribute("carrinho");
			Cliente cliente = (Cliente)session.getAttribute("usuario");
			int indice = Integer.parseInt(request.getParameter("txtIndice"));
			carrinho.setEnderecoEntrega(cliente.getEnderecos().get(indice));
			return carrinho;
		}
		else if(!operacao.equals("VISUALIZAR"))
		{
			HttpSession session = request.getSession();
			Livro livro = (Livro) session.getAttribute("livro");
			if(livro == null)
				System.out.println("Livro nulo");
			produto = new Produto();
			
			produto.setLivro(livro);
			
		}
		else{
			
			HttpSession session = request.getSession();
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio p: resultado.getEntidades()){
				if(p.getId() == txtId){
					produto = (Produto)p;
				}
			}
		}
		return produto;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d=null;
		request.getSession().setAttribute("resultado", null);
		
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				resultado.setMsg("Produto cadastrado com sucesso!");
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormConsultaProduto.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")){
			
			d= request.getRequestDispatcher("FormConsultaProduto.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")){
			
			request.setAttribute("produto", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("FormCompra.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			
			request.getSession().setAttribute("resultado", null);
			d= request.getRequestDispatcher("FormConsultaProduto.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("COMPRAR")){
			Carrinho carrinho = (Carrinho)request.getSession().getAttribute("carrinho");
			Livro livro = (Livro)request.getSession().getAttribute("livro");
			int i;
			if(carrinho == null)
				carrinho = new Carrinho();
			for(i = 0; i < carrinho.getProdutos().size(); i++)
			{
				if(livro.getTitulo().equals(carrinho.getProdutos().get(i).getLivro().getTitulo()))
				{
					carrinho.getProdutos().get(i).setQuantidade(carrinho.getProdutos().get(i).getQuantidade()+1);
					break;
				}
			}
			if(i >= carrinho.getProdutos().size())
			{
				Produto produto = new Produto();
				produto.setLivro(livro);
				carrinho.AdicionarLivro(produto);
			}
			request.getSession().setAttribute("carrinho", carrinho);
			d= request.getRequestDispatcher("FormCarrinho.jsp");
		}
		
		if(resultado.getMsg() == null && (operacao.equals("ATUALIZAR") || operacao.equals("SELECIONAR"))){
			
			request.getSession().setAttribute("enderecoEntrega", ((Carrinho)resultado.getEntidades().get(0)).getEnderecoEntrega());
			request.getSession().setAttribute("carrinho", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("FormCarrinho.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("VERIFICAR")){
			try {
				request.getSession().setAttribute("cupom", resultado.getEntidades().get(0));
			}catch (Exception e) {
				request.getSession().setAttribute("cupom", new Cupom());
			}
			d= request.getRequestDispatcher("FormCarrinho.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONFIRMAR")){
			
			request.getSession().setAttribute("cartao", ((Carrinho)request.getSession().getAttribute("carrinho")).getCartao());
			d= request.getRequestDispatcher("FormCarrinho.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("FINALIZAR")){
			Cliente usuario = (Cliente)request.getSession().getAttribute("usuario");
			usuario.getPedidos().add((Carrinho)resultado.getEntidades().get(0));
			request.setAttribute("usuario",usuario);
			request.getSession().setAttribute("pedidos", usuario.getPedidos());
			d= request.getRequestDispatcher("FormPedidos.jsp");
		}
		
		if(resultado.getMsg() != null){
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				request.getSession().setAttribute("resultado", resultado);
				d= request.getRequestDispatcher("FormConsultaProduto.jsp");
			}
		}
		d.forward(request,response);
	}

}