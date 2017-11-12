package finalWeb.vh.impl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import finalCore.aplicacao.Resultado;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class EnderecoViewHelper implements IViewHelper{

	@Override
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Endereco endereco = null;

		if(!operacao.equals("VISUALIZAR"))
		{
			//String idc = request.getParameter("txtIdCliente");
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

			endereco = new Endereco();
			try {
				Boolean preferencial = request.getParameter("rdPreferencial").equals("true") ? true : false;
				preferencial = request.getParameter("rdPreferencial").equals("todos") ? null : preferencial;
				endereco.setPreferencial(preferencial);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int id = Integer.parseInt(request.getParameter("txtId"));
				endereco.setId(id);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
			try {
				int idc = Integer.parseInt(request.getParameter("txtIdCliente"));
				endereco.setID_Cliente(idc);
			}catch (Exception e) {
				// TODO: handle exception
			}
			
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
		}
		else{
			
			HttpSession session = request.getSession();
			Resultado resultado = (Resultado) session.getAttribute("resultado");
			int txtId = Integer.parseInt(request.getParameter("txtId"));
			
			for(EntidadeDominio e: resultado.getEntidades()){
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
				resultado.setMsg("Endereço cadastrado com sucesso!");
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormConsultaEndereco.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("ALTERAR")){
			
			d= request.getRequestDispatcher("FormConsultaEndereco.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("VISUALIZAR")){
			
			request.setAttribute("endereco", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("FormClienteEnd.jsp"); 
			//d= request.getRequestDispatcher("FormCliente.jsp");  			
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			
			request.getSession().setAttribute("resultado", null);
			d= request.getRequestDispatcher("FormConsultaEndereco.jsp");  
		}
		
		if(resultado.getMsg() != null){
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				request.getSession().setAttribute("resultado", resultado);
				d= request.getRequestDispatcher("FormConsultaEndereco.jsp");  	
			}
		}
		d.forward(request,response);
	}

}
