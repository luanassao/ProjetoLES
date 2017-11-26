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
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;
import finalWeb.vh.IViewHelper;

public class CompraViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Produto produto = null;

		if(operacao.equals("SELECIONAR"))
		{
			HttpSession session = request.getSession();
			Carrinho carrinho = (Carrinho)session.getAttribute("carrinho");
			Cliente cliente = (Cliente)session.getAttribute("usuario");
			int indice = Integer.parseInt(request.getParameter("txtIndice"));
			carrinho.setEnderecoEntrega(cliente.getEnderecos().get(indice));
			return carrinho;
		}
		if(!operacao.equals("VISUALIZAR"))
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
		request.getSession().setAttribute("produto", null);
		
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
		
		if(resultado.getMsg() != null){
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				request.getSession().setAttribute("resultado", resultado);
				d= request.getRequestDispatcher("FormConsultaProduto.jsp");
			}
		}
		d.forward(request,response);
	}

}