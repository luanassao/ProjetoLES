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
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;
import finalWeb.vh.IViewHelper;

public class ClienteViewHelper implements IViewHelper{
	/** 
	 * TODO Descrição do Método
	 * @param request
	 * @param response
	 * @return
	 * @see lesWeb.vh.IViewHelper#getEntidade(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	public EntidadeDominio getEntidade(HttpServletRequest request) {
		String operacao = request.getParameter("operacao");
		Cliente cliente = null;
		Cliente usuario;
		String nome, cpf, tipotel, telefone, genero, email, senha;
		String[] dtNasc;
		Calendar nasc = Calendar.getInstance();
		HttpSession session = request.getSession();
		Boolean status;
		Alterador alterador;
		
		switch (operacao) {
			case "SALVAR":
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
				usuario = new Cliente();
				alterador = new Alterador();
				try {
					usuario = (Cliente)session.getAttribute("usuario");
					alterador.setId(usuario.getId());
					alterador.setEmail(usuario.getEmail());
					int id = Integer.parseInt(request.getParameter("txtId"));
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
				
				String nomeEndereco = request.getParameter("txtNomeEnderecoE");
				String tipoRes = request.getParameter("ddlTipoResidenciaE");
				String tipoLog = request.getParameter("ddlTipoLogradouroE");
				String logradouro = request.getParameter("txtLogradouroE");
				String numero = request.getParameter("txtNumeroE");
				String bairro = request.getParameter("txtBairroE");
				String cep = request.getParameter("txtCepE");
				String estado = request.getParameter("txtEstadoE");
				String cidade = request.getParameter("txtCidadeE");
				String pais = request.getParameter("txtPaisE");
				String observacao = request.getParameter("txtObservacaoE");
				String responsavel = request.getParameter("txtResponsavelE");
				String tipo = request.getParameter("ddlTipoEnderecoE");

				Endereco enderecoE = new Endereco();

				enderecoE.setNomeEndereco(nomeEndereco);
				enderecoE.setTipo(tipo);
				enderecoE.setTipoResidencia(tipoRes);
				enderecoE.setTipoLogradouro(tipoLog);
				enderecoE.setLogradouro(logradouro);
				enderecoE.setNumero(numero);
				enderecoE.setBairro(bairro);
				enderecoE.setCep(cep);
				enderecoE.setEstado(estado);
				enderecoE.setCidade(cidade);
				enderecoE.setPais(pais);
				enderecoE.setObservacao(observacao);
				enderecoE.setAlterador(responsavel);
				
				nomeEndereco = request.getParameter("txtNomeEnderecoC");
				tipoRes = request.getParameter("ddlTipoResidenciaC");
				tipoLog = request.getParameter("ddlTipoLogradouroC");
				logradouro = request.getParameter("txtLogradouroC");
				numero = request.getParameter("txtNumeroC");
				bairro = request.getParameter("txtBairroC");
				cep = request.getParameter("txtCepC");
				estado = request.getParameter("txtEstadoC");
				cidade = request.getParameter("txtCidadeC");
				pais = request.getParameter("txtPaisC");
				observacao = request.getParameter("txtObservacaoC");
				responsavel = request.getParameter("txtResponsavelC");
				tipo = request.getParameter("ddlTipoEnderecoC");
				
				Endereco enderecoC = new Endereco();

				enderecoC.setNomeEndereco(nomeEndereco);
				enderecoC.setTipo(tipo);
				enderecoC.setTipoResidencia(tipoRes);
				enderecoC.setTipoLogradouro(tipoLog);
				enderecoC.setLogradouro(logradouro);
				enderecoC.setNumero(numero);
				enderecoC.setBairro(bairro);
				enderecoC.setCep(cep);
				enderecoC.setEstado(estado);
				enderecoC.setCidade(cidade);
				enderecoC.setPais(pais);
				enderecoC.setObservacao(observacao);
				enderecoC.setAlterador(responsavel);
				
				cliente.getEnderecos().add(enderecoE);
				cliente.getEnderecos().add(enderecoC);
				
			break;
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
			case "EXCLUIR":
				usuario = (Cliente)session.getAttribute("usuario");
				if(usuario.getAdministrador())
				{
					cliente = new Cliente();
					int id = Integer.parseInt(request.getParameter("txtId"));
					cliente.setId(id);
					cliente.setStatus(Boolean.parseBoolean(request.getParameter("txtStatus")));
				}
				else
					cliente = (Cliente)session.getAttribute("usuario");
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
				
				try
				{
					status = request.getParameter("rdStatus").equals("true") ? true : false;
					status = request.getParameter("rdStatus").equals("todos") ? null : status;
				}catch (Exception e) {
					status = null;
				}
				
				cliente = new Cliente();
				usuario = new Cliente();
				alterador = new Alterador();
				try {
					int id = Integer.parseInt(request.getParameter("txtId"));
					usuario = (Cliente)session.getAttribute("usuario");
					alterador.setId(usuario.getId());
					alterador.setEmail(usuario.getEmail());
					if(usuario.getAdministrador())
						id = Integer.parseInt(request.getParameter("txtId"));
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
		request.getSession().setAttribute("cliente", null);
		
		String operacao = request.getParameter("operacao");
		
		if(resultado.getMsg() != null){
			request.getSession().setAttribute("resultado", resultado);
			if(operacao.equals("SALVAR") || operacao.equals("ALTERAR")){
				d= request.getRequestDispatcher("FormClienteEnd.jsp");  	
			}
			else if(operacao.equals("LOGAR")) {
				d= request.getRequestDispatcher("Index.jsp");
			}
		}
		
		if(resultado.getMsg() == null){
			if(operacao.equals("SALVAR")){
				resultado.setMsg("Cliente cadastrado com sucesso!");
			}
			
			request.getSession().setAttribute("resultado", resultado);
			d= request.getRequestDispatcher("FormLogin.jsp");
			if(operacao.equals("CONSULTAR"))
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
			request.getSession().setAttribute("resultado", resultado);
			request.getSession().setAttribute("usuario", resultado.getEntidades().get(0));
			d= request.getRequestDispatcher("Index.jsp");  
		}
		
		if(resultado.getMsg() == null && operacao.equals("EXCLUIR")){
			
			request.getSession().setAttribute("resultado", null);
			d= request.getRequestDispatcher("FormLogin.jsp");  
		}
		
		d.forward(request,response);
	}
}
