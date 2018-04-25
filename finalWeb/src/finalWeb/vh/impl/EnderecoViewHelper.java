package finalWeb.vh.impl;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import finalCore.aplicacao.Resultado;
import finalDominio.Cliente;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class EnderecoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Endereco endereco = null;

		if(operacao.equals("EXCLUIR"))
		{
			endereco = new Endereco();
			int id = Integer.parseInt(request.getParameter("txtId"));
			int idc = 0;
			Boolean status = Boolean.parseBoolean(request.getParameter("txtStatus"));
			HttpSession session = request.getSession();
			Cliente cliente = (Cliente)session.getAttribute("usuario");
			idc = cliente.getId();
			endereco.setID_Cliente(idc);
			endereco.setId(id);
			endereco.setStatus(status);
		}
		else if(!operacao.equals("VISUALIZAR"))
		{
			//String idc = request.getParameter("txtIdCliente");
			String nomeEndereco = request.getParameter("txtNomeEndereco");
			String tipoRes = request.getParameter("ddlTipoResidencia");
			String tipoLog = request.getParameter("ddlTipoLogradouro");
			String logradouro = request.getParameter("txtLogradouro");
			String numero = request.getParameter("txtNumero");
			String bairro = request.getParameter("txtBairro");
			String cep = request.getParameter("txtCep");
			String estado = request.getParameter("txtEstado");
			String cidade = request.getParameter("txtCidade");
			String pais = request.getParameter("txtPais");
			String observacao = request.getParameter("txtObservacao");
			String responsavel = request.getParameter("txtResponsavel");
			String tipo = request.getParameter("ddlTipoEndereco");

			endereco = new Endereco();
			
			try {
				int id = Integer.parseInt(request.getParameter("txtId"));
				endereco.setId(id);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int idc = 0;
				HttpSession session = request.getSession();
				Cliente cliente = (Cliente)session.getAttribute("usuario");
				if(cliente.getAdministrador())
				{
					System.out.println("Administrador logado");
				}
				else
					idc = cliente.getId();
				endereco.setID_Cliente(idc);
			}catch (Exception e) {
				System.out.println("Erro ao pegar ID DO CLIENTE");
			}
			
			endereco.setNomeEndereco(nomeEndereco);
			endereco.setTipo(tipo);
			endereco.setTipoResidencia(tipoRes);
			endereco.setTipoLogradouro(tipoLog);
			endereco.setLogradouro(logradouro);
			endereco.setNumero(numero);
			endereco.setBairro(bairro);
			endereco.setCep(cep);
			endereco.setEstado(estado);
			endereco.setCidade(cidade);
			endereco.setPais(pais);
			endereco.setObservacao(observacao);
			endereco.setAlterador(responsavel);
			System.out.println(endereco.getTipo());
		}
		else{
			
			HttpSession session = request.getSession();
			List<EntidadeDominio> enderecos = (List<EntidadeDominio>) session.getAttribute("enderecos");
			
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio e: enderecos){
				if(e.getId() == txtId){
					endereco = (Endereco)e;
				}
			}
		}
		return endereco;
	}

	@Override
	public void setView(Resultado resultado, HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		RequestDispatcher d=null;
		request.getSession().setAttribute("resultado", null);
		request.getSession().setAttribute("endereco", null);
		
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				Cliente usuario = (Cliente)request.getSession().getAttribute("usuario");
				usuario.getEnderecos().add((Endereco)resultado.getEntidades().get(0));
				request.getSession().setAttribute("usuario",usuario);
				resultado.setMsg("Endereço cadastrado com sucesso!");
			}

			request.getSession().setAttribute("aba","abaConsultarEnderecos");
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormClienteEnd.jsp");			
		}
		
		if(resultado.getMsg() == null && operacao.equals("CONSULTAR")) {
			request.getSession().setAttribute("aba","abaConsultarEnderecos");
			request.getSession().setAttribute("enderecos", resultado.getEntidades());
			d= request.getRequestDispatcher("FormClienteEnd.jsp");
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")){
			request.getSession().setAttribute("aba","abaConsultarEnderecos");
			d= request.getRequestDispatcher("FormClienteEnd.jsp"); 
		}
		
		if(resultado.getMsg() == null && operacao.equals("SALVAR NOVO")){
			Cliente usuario = (Cliente)request.getSession().getAttribute("usuario");
			usuario.getEnderecos().add((Endereco)resultado.getEntidades().get(0));
			request.getSession().setAttribute("usuario",usuario);
			d= request.getRequestDispatcher("FormCarrinho.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")){
			request.getSession().setAttribute("aba","abaEndereco");
			request.setAttribute("endereco", resultado.getEntidades().get(0));
			request.getSession().setAttribute("aba","abaEndereco");
			d= request.getRequestDispatcher("FormClienteEnd.jsp");			
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			List<EntidadeDominio> enderecos = (List<EntidadeDominio>) request.getSession().getAttribute("enderecos");
			Endereco endereco = (Endereco)resultado.getEntidades().get(0);
			for(EntidadeDominio e:enderecos) {
				if(e.getId() == endereco.getId())
				{
					((Endereco)e).setStatus(endereco.getStatus());
					break;
				}
			}
			request.getSession().setAttribute("enderecos", enderecos);
			request.getSession().setAttribute("aba","abaConsultarEnderecos");
			d= request.getRequestDispatcher("FormClienteEnd.jsp"); 
		}
		
		if(resultado.getMsg() != null && (operacao.equals("SALVAR") || operacao.equals("ALTERAR"))){
			request.getSession().setAttribute("resultado", resultado);
			request.getSession().setAttribute("aba","abaConsultarEnderecos");
			d= request.getRequestDispatcher("FormClienteEnd.jsp");
		}
		d.forward(request,response);
	}

}
