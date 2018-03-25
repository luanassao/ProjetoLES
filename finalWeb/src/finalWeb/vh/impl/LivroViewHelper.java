package finalWeb.vh.impl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auxiliar.Alterador;
import auxiliar.Autor;
import auxiliar.Categoria;
import auxiliar.DadosCadLivro;
import auxiliar.Editora;
import auxiliar.Precificacao;
import finalCore.aplicacao.Resultado;
import finalDominio.Cliente;
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

		if(operacao.equals("EXCLUIR"))
		{
			livro = new Livro();
			int id = Integer.parseInt(request.getParameter("txtId"));
			String motivo = request.getParameter("txtMotivo");
			
			HttpSession session = request.getSession();
			Cliente usuario = (Cliente)session.getAttribute("usuario");
			
			Alterador alterador = new Alterador();
			alterador.setId(usuario.getId());
			alterador.setEmail(usuario.getEmail());
			
			if(request.getParameter("txtAcao").equals("true"))
				livro.setStatus(true);
			else
				livro.setStatus(false);
			
			livro.setAlterador(alterador);
			livro.setId(id);
			livro.setMotivo(motivo);
		}
		else if(!operacao.equals("VISUALIZAR") && !operacao.equals("CHECAR"))
		{
			String ano = request.getParameter("txtAno");
			String titulo = request.getParameter("txtTitulo");
			String edicao = request.getParameter("txtEdicao");
			String isbn = request.getParameter("txtISBN");
			String npaginas = request.getParameter("txtPaginas");
			String sinopse = request.getParameter("txtSinopse");
			
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
				// Valor inválido informado
			}
			
			HttpSession session = request.getSession();
			Cliente usuario = (Cliente)session.getAttribute("usuario");
			if(!usuario.getAdministrador())
				estoque = 1;
			
			Alterador alterador = new Alterador();
			alterador.setId(usuario.getId());
			alterador.setEmail(usuario.getEmail());
			
			Boolean status = request.getParameter("rdStatus").equals("true") ? true : false;
			status = request.getParameter("rdStatus").equals("todos") ? null : status;
			
			Resultado resultado = (Resultado) session.getAttribute("dados");
			List<EntidadeDominio> entidades = resultado.getEntidades();
			DadosCadLivro dados = (DadosCadLivro)entidades.get(0);
			
			try {
				String hdcategoria = request.getParameter("hdCategorias");
				String[] categorias = hdcategoria.split(" ");
				for(String c : categorias)
				{
					for(Categoria cat:dados.getCategorias())
					{
						if(cat.getId() == Integer.parseInt(c))
							livro.getCategorias().add(cat);
					}
				}
			}catch (Exception e) {
				// Não há valores
			}
			
			try {
				String autor = request.getParameter("ddlAutor");
				for(Autor a:dados.getAutores())
				{
					if(a.getId() == Integer.parseInt(autor))
						livro.setAutor(a);
				}
	
				String editora = request.getParameter("ddlEditora");
				for(Editora e:dados.getEditoras())
				{
					if(e.getId() == Integer.parseInt(editora))
						livro.setEditora(e);
				}
	
				String precificacao = request.getParameter("ddlPrecificacao");
				for(Precificacao p:dados.getPrecificacoes())
				{
					if(p.getId() == Integer.parseInt(precificacao))
						livro.setPrecificacao(p);
				}
			}catch (Exception e) {
				// TODO: handle exception
			}
			
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
			livro.setAno(ano);
			livro.setTitulo(titulo);
			livro.setEdicao(edicao);
			livro.setISBN(isbn);
			livro.setNpaginas(npaginas);
			livro.setSinopse(sinopse);
			livro.setStatus(status);
			livro.setAltura(altura);
			livro.setLargura(largura);
			livro.setPeso(peso);
			livro.setProfundidade(profundidade);
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
		//request.getSession().setAttribute("livro", null);
		
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR"))
			{
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
			
			request.getSession().setAttribute("livro", resultado.getEntidades().get(0));
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
