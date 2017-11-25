package finalWeb.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalWeb.vh.IViewHelper;

public class LivroViewHelper implements IViewHelper{
	/** 
	 * TODO Descrição do Método
	 * @param request
	 * @param response
	 * @return
	 * @see lesWeb.vh.IViewHelper#getEntidade(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Livro livro = null;

		if(!operacao.equals("VISUALIZAR") && !operacao.equals("CHECAR"))
		{
			String autor = request.getParameter("txtAutor");
			String categoria = request.getParameter("ddlCategoria");
			String subcategoria = request.getParameter("ddlsCategoria");
			String ano = request.getParameter("txtAno");
			String titulo = request.getParameter("txtTitulo");
			String editora = request.getParameter("txtEditora");
			String edicao = request.getParameter("txtEdicao");
			String isbn = request.getParameter("txtISBN");
			String npaginas = request.getParameter("txtPaginas");
			String sinopse = request.getParameter("txtSinopse");
			String alterador = request.getParameter("txtResponsavel");
			String precificacao = request.getParameter("ddlPrecificacao");

			livro = new Livro();
			
			int estoque = 0, id = 0;
			double preco = 0.0, valor = 0.0;
			Double altura = 0.0, largura = 0.0, peso = 0.0, profundidade = 0.0;
			try {
				estoque = Integer.parseInt(request.getParameter("txtEstoque"));
				preco = Double.parseDouble(request.getParameter("txtPreco"));
				valor = Double.parseDouble(request.getParameter("txtValor"));
				altura = Double.parseDouble(request.getParameter("txtAltura"));
				largura = Double.parseDouble(request.getParameter("txtLargura"));
				peso = Double.parseDouble(request.getParameter("txtPeso"));
				profundidade = Double.parseDouble(request.getParameter("txtProfundidade"));
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			Boolean status = request.getParameter("rdStatus").equals("true") ? true : false;
			status = request.getParameter("rdStatus").equals("todos") ? null : status;
			
			
			try {
				id = Integer.parseInt(request.getParameter("txtId"));
				livro.setId(id);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			livro.setEstoque(estoque);
			livro.setPreco(preco);
			livro.setValor(valor);
			livro.setId(id);
			livro.setAutor(autor);
			livro.setCategoria(categoria);
			livro.setSubcategoria(subcategoria);
			livro.setAno(ano);
			livro.setTitulo(titulo);
			livro.setEditora(editora);
			livro.setEdicao(edicao);
			livro.setISBN(isbn);
			livro.setNpaginas(npaginas);
			livro.setSinopse(sinopse);
			livro.setStatus(status);
			livro.setAltura(altura);
			livro.setLargura(largura);
			livro.setPeso(peso);
			livro.setProfundidade(profundidade);
			livro.setPrecificacao(precificacao);
			livro.setAlterador(alterador);
		}
		else{
			
			HttpSession session = request.getSession();
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio l: resultado.getEntidades()){
				if(l.getId() == txtId){
					livro = (Livro)l;
				}
			}
		}
		return livro;
	}

	/** 
	 * TODO Descrição do Método
	 * @param request
	 * @param response
	 * @return
	 * @see lesWeb.controle.web.vh.IViewHelper#setView(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public void setView(Resultado resultado, HttpServletRequest request, 
			HttpServletResponse response)  throws IOException, ServletException {
		RequestDispatcher d=null;
		request.getSession().setAttribute("resultado", null);
		request.getSession().setAttribute("livro", null);
		
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				resultado.setMsg("Livro cadastrado com sucesso!");
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormConsultaLivro.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("LISTAR")){
			
			d= request.getRequestDispatcher("FormCompra.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")){
			
			d= request.getRequestDispatcher("FormConsultaLivro.jsp");  
		}
		
		if(resultado.getMsg() == null && (operacao.equals("VISUALIZAR") || operacao.equals("CHECAR"))){
			
			request.setAttribute("livro", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher(operacao.equals("VISUALIZAR") ? "FormLivro.jsp" : "FormChecarLivro.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			
			request.getSession().setAttribute("resultado", null);
			d= request.getRequestDispatcher("FormConsultaLivro.jsp");  
		}
		
		if(resultado.getMsg() != null){
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				request.getSession().setAttribute("resultado", resultado);
				d= request.getRequestDispatcher("FormConsultaLivro.jsp");  	
			}
		}
		d.forward(request,response);
	}
}
