package finalWeb.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;
import finalDominio.Produto;
import finalWeb.vh.IViewHelper;

public class ProdutoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Produto produto = null;

		if(!operacao.equals("VISUALIZAR"))
		{
			String email = request.getParameter("txtEmail");
			String senha = request.getParameter("txtSenha");
			String titulo = request.getParameter("txtTitulo");
			
			produto = new Produto();
			
			try {
				int id = Integer.parseInt(request.getParameter("txtId"));
				produto.setID_Carrinho(id);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int idProduto = Integer.parseInt(request.getParameter("txtIdProduto"));
				produto.setId(idProduto);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int idLivro = Integer.parseInt(request.getParameter("txtIdLivro"));
				produto.setID_Livro(idLivro);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int quantidade = Integer.parseInt(request.getParameter("txtQuantidade"));
				produto.setQuantidade(quantidade);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			produto.setEmail(email);
			produto.setSenha(senha);
			produto.setTitulo(titulo);
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
		
		if(resultado.getMsg() != null){
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				request.getSession().setAttribute("resultado", resultado);
				d= request.getRequestDispatcher("FormConsultaProduto.jsp");
			}
		}
		d.forward(request,response);
	}

}