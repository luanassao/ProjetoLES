<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cadastro de endereço</title>
</head>
<body>
	<form action="SalvarEndereco" method="post" id="frmSalvarEndereco">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de endereço</TH></tr>
				<tr>
				<!-- <tr style="${empty cliente ? 'display:none' : ''}"> -->
					<td>
						ID
					</td>
					<td>
						<input type="text" class="form-control" id="txtId" name="txtId" value="${empty cliente ? '' : cliente.getId()}"/>
						<!-- <input type="text" class="form-control" id="txtId" name="txtId" value="${empty cliente ? '' : cliente.getId()}" readonly="readonly"/> -->
					</td>
				</tr>
				<tr>
				<!-- <tr style="${empty cliente ? 'display:none' : ''}"> -->
					<td>
						ID do cliente
					</td>
					<td>
						<input type="text" class="form-control" id="txtIdCliente" name="txtIdCliente" value="${empty cliente ? '' : cliente.getId()}"/>
						<!-- <input type="text" class="form-control" id="txtId" name="txtId" value="${empty cliente ? '' : cliente.getId()}" readonly="readonly"/> -->
					</td>
				</tr>
				<tr>
					<td>
						Tipo da residencia
					</td>
					<td>
						<select id="ddlTipoResidencia" name="ddlTipoResidencia">
							<option ${cliente.getTipoTelefone() == 'Casa' ? 'selected' : '' }>Casa</option>
							<option ${cliente.getTipoTelefone() == 'Apartamento' ? 'selected' : '' }>Apartamento</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Tipo do logradouro
					</td>
					<td>
						<select id="ddlTipoLogradouro" name="ddlTipoLogradouro">
							<option ${cliente.getTipoTelefone() == 'Avenida' ? 'selected' : '' }>Residencial</option>
							<option ${cliente.getTipoTelefone() == 'Rua' ? 'selected' : '' }>Celular</option>
							<option ${cliente.getTipoTelefone() == 'Travessa' ? 'selected' : '' }>Empresarial</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Logradouro
					</td>
					<td>
						<input type="text" class="form-control" id="txtLogradouro" name="txtLogradouro" value="${empty cliente ? '' : cliente.getId()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Preferencial
					</td>
					<td>
						Ativo    <input type="radio" id="rdPreferencial" name="rdPreferencial" value="true" checked>
					    Inativo    <input type="radio" id="rdPreferencial" name="rdPreferencial" value="false" ${cliente.getStatus() == false ? 'checked' : ''}>
					</td>
				</tr>
				<tr>
					<td>
						Número
					</td>
					<td>
						<input type="text"class="form-control" id="txtNumero" name="txtNumero" value="${empty cliente ? '' : cliente.getTelefone()}" />
					</td>
				</tr>
				<tr>
					<td>
						Bairro
					</td>
					<td>
						<input type="text"class="form-control" id="txtBairro" name="txtBairro" value="${empty cliente ? '' : cliente.getEmail()}" />
					</td>
				</tr>
				<tr>
					<td>
						CEP
					</td>
					<td>
						<input type="text"class="form-control" id="txtCep" name="txtCep" value="${empty cliente ? '' : cliente.getSenha()}" />
					</td>
				</tr>
				<tr>
					<td>
						Estado
					</td>
					<td>
						<input type="text"class="form-control" id="txtEstado" name="txtEstado" value="${empty cliente ? '' : cliente.getSenha()}" />
					</td>
				</tr>
				<tr>
					<td>
						Cidade
					</td>
					<td>
						<input type="text"class="form-control" id="txtCidade" name="txtCidade" value="${empty cliente ? '' : cliente.getSenha()}" />
					</td>
				</tr>
				<tr>
					<td>
						País
					</td>
					<td>
						<input type="text" class="form-control"  id="txtPais" name="txtPais" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" />
					</td>
				</tr>
				<tr>
					<td>
						Observação
					</td>
					<td>
						<input type="text" class="form-control"  id="txtObservacao" name="txtObservacao" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" />
					</td>
				</tr>
				<tr>
					<td>
						Responsavel
					</td>
					<td>
						<input type="text" class="form-control"  id="txtResponsavel" name="txtResponsavel" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" />
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="${empty cliente ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
		</form>
</body>
</html>