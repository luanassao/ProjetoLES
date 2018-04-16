package finalWeb.vh.impl;

import java.io.IOException;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auxiliar.Alterador;
import finalCore.aplicacao.Resultado;
import finalDominio.Carrinho;
import finalDominio.Cliente;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class ClienteViewHelper implements IViewHelper{
	/** 
	 * TODO Descri��o do M�todo
	 * @param request
	 * @param response
	 * @return
	 * @see lesWeb.vh.IViewHelper#getEntidade(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Cliente cliente = null;
		String nome, cpf, tipotel, telefone, genero, email, senha;
		String[] dtNasc;
		Calendar nasc = Calendar.getInstance();
		HttpSession session = request.getSession();
		Boolean status;
		Alterador alterador;
		
		switch (operacao) {
			case "LOGAR":
				email = request.getParameter("txtEmail");
				senha = request.getParameter("txtSenha");
				
				cliente = new Cliente();
				
				cliente.setEmail(email);
				cliente.setSenha(senha);
			break;
			case "VISUALIZAR":
				Resultado resultado = (Resultado) session.getAttribute("resultado");
				int txtId = Integer.parseInt(request.getParameter("txtId"));
				
				for(EntidadeDominio c: resultado.getEntidades()){
					if(c.getId() == txtId){
						cliente = (Cliente)c;
					}
				}
			break;
			default:
				nome = request.getParameter("txtNome");
				cpf = request.getParameter("txtCpf");
				tipotel = request.getParameter("ddlTipoTel");
				telefone = request.getParameter("txtTelefone");
				genero = request.getParameter("rdGenero");
				email = request.getParameter("txtEmail");
				senha = request.getParameter("txtSenha");
				nasc = Calendar.getInstance();
				System.out.println(request.getParameter("txtDtNasc"));
				try
				{
					dtNasc = request.getParameter("txtDtNasc").split("-");
					int dia = Integer.parseInt(dtNasc[2]);
					int mes = Integer.parseInt(dtNasc[1]);
					int ano = Integer.parseInt(dtNasc[0]);
					nasc.set(ano, mes, dia);
				}catch (Exception e) {
					// TODO: handle exception
				}
				
				status = request.getParameter("rdStatus").equals("true") ? true : false;
				status = request.getParameter("rdStatus").equals("todos") ? null : status;
				
				cliente = new Cliente();
				Cliente usuario = new Cliente();
				alterador = new Alterador();
				try {
					int id = Integer.parseInt(request.getParameter("txtId"));
					usuario = (Cliente)session.getAttribute("usuario");
					alterador.setId(usuario.getId());
					alterador.setEmail(usuario.getEmail());
					if(usuario.getAdministrador())
						id = Integer.parseInt(request.getParameter("txtIdCliente"));
					else
						id = usuario.getId();
					cliente.setId(id);
				}catch (Exception e) {
					// TODO: handle exception
				}
				cliente.setNome(nome);
				cliente.setCpf(cpf);
				cliente.setGenero(genero);
				cliente.setTipoTelefone(tipotel);
				cliente.setTelefone(telefone);
				cliente.setEmail(email);
				cliente.setSenha(senha);
				cliente.setStatus(status);
				cliente.setDtnascimento(nasc);
				cliente.setAlterador(alterador);
			break;
		}

		return cliente;
	}

	/** 
	 * TODO Descri��o do M�todo
	 * @param request
	 * @param response
	 * @return
	 * @see lesWeb.controle.web.vh.IViewHelper#setView(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public void setView(Resultado resultado, HttpServletRequest request, 
			HttpServletResponse response)  throws IOException, ServletException {
		RequestDispatcher d=null;
		request.getSession().setAttribute("resultado", null);
		request.getSession().setAttribute("cliente", null);
		
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				resultado.setMsg("Cliente cadastrado com sucesso!");
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormConsultaCliente.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")){
			
			d= request.getRequestDispatcher("FormConsultaCliente.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")){
			
			request.setAttribute("cliente", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("FormClienteEnd.jsp");			
		}
		
		if(resultado.getMsg() == null && operacao.equals("LOGAR")){
			request.getSession().setAttribute("carrinho", new Carrinho());
			request.getSession().setAttribute("usuario", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("Index.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			
			request.getSession().setAttribute("resultado", null);
			d= request.getRequestDispatcher("FormConsultaCliente.jsp");  
		}
		
		if(resultado.getMsg() != null){
			request.getSession().setAttribute("resultado", resultado);
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				d= request.getRequestDispatcher("FormConsultaCliente.jsp");  	
			}
			else if(operacao.equals("LOGAR")) {
				d= request.getRequestDispatcher("Index.jsp");
			}
		}
		d.forward(request,response);
	}
}
