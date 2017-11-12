<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>	
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/css/jasny-bootstrap.min.css">
	<!-- Latest compiled and minified JavaScript -->
	<script src="//cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/js/jasny-bootstrap.min.js"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Cadastro de clientes</title>
</head>
<body>
	<form action="SalvarCliente" method="post" id="frmSalvarCliente">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de livros</TH></tr>
				<tr style="${empty cliente ? 'display:none' : ''}">
					<td>
						ID do cliente
					</td>
					<td>
						<input type="text" class="form-control" id="txtId" name="txtId" value="${empty cliente ? '' : cliente.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td>
						Nome do cliente
					</td>
					<td>
						<input type="text"class="form-control" id="txtNome" name="txtNome" value="${empty cliente ? '' : cliente.getNome()}" />
					</td>
				</tr>
				<tr>
					<td>
						CPF
					</td>
					<td>
						<input type="text"class="form-control" id="txtCpf" name="txtCpf" value="${empty cliente ? '' : cliente.getCpf()}" />
					</td>
				</tr>
				<tr>
					<td>
						Status do Cliente
					</td>
					<td>
						Ativo    <input type="radio" id="rdStatus" name="rdStatus" value="true" checked>
					    Inativo    <input type="radio" id="rdStatus" name="rdStatus" value="false" ${cliente.getStatus() == false ? 'checked' : ''}>
					</td>
				</tr>
				<tr>
					<td>
						Tipo de telefone
					</td>
					<td>
						<select id="ddlTipoTel" name="ddlTipoTel">
							<option ${cliente.getTipoTelefone() == 'Residencial' ? 'selected' : '' }>Residencial</option>
							<option ${cliente.getTipoTelefone() == 'Celular' ? 'selected' : '' }>Celular</option>
							<option ${cliente.getTipoTelefone() == 'Empresarial' ? 'selected' : '' }>Empresarial</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Telefone
					</td>
					<td>
						<input type="text"class="form-control" id="txtTelefone" name="txtTelefone" value="${empty cliente ? '' : cliente.getTelefone()}" />
					</td>
				</tr>
				<tr>
					<td>
						Email
					</td>
					<td>
						<input type="text"class="form-control" id="txtEmail" name="txtEmail" value="${empty cliente ? '' : cliente.getEmail()}" />
					</td>
				</tr>
				<tr>
					<td>
						Senha
					</td>
					<td>
						<input type="text"class="form-control" id="txtSenha" name="txtSenha" value="${empty cliente ? '' : cliente.getSenha()}" />
					</td>
				</tr>
				<tr style="${empty cliente ? 'display:none' : ''}">
					<td>
						Confirme a senha
					</td>
					<td>
						<input type="text"class="form-control" id="txtISBN" name="txtISBN" value="${empty cliente ? '' : cliente.getSenha()}" />
					</td>
				</tr>
				<tr>
					<td>
						Genero
					</td>
					<td>
						Masculino    <input type="radio" id="rdGenero" name="rdGenero" value="Masculino" checked>
					    Feminino    <input type="radio" id="rdGenero" name="rdGenero" value="Feminino" ${cliente.getGenero().equals("Feminino") ? 'checked' : ''}>
					</td>
				</tr>
				<tr>
					<td>
						Data de nascimento
					</td>
					<td>
						<input type="${empty cliente ? 'date' : 'text'}" class="form-control"  id="txtDtNasc" name="txtDtNasc" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" />
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="${empty cliente ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
		</form>
</body>
</html>