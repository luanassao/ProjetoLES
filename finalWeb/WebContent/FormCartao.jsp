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
<title>Cadastro de cartão</title>
</head>
<body>
	<form action="SalvarCartao" method="post" id="frmSalvarCartao">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de cartão</TH></tr>
				<tr>
				<!-- <tr style="${empty cliente ? 'display:none' : ''}"> -->
					<td>
						ID
					</td>
					<td>
						<input type="text" class="form-control" id="txtId" name="txtId" value="${empty cartao ? '' : cartao.getId()}"/>
						<!-- <input type="text" class="form-control" id="txtId" name="txtId" value="${empty cliente ? '' : cliente.getId()}" readonly="readonly"/> -->
					</td>
				</tr>
				<tr>
				<!-- <tr style="${empty cliente ? 'display:none' : ''}"> -->
					<td>
						ID do cliente
					</td>
					<td>
						<input type="text" class="form-control" id="txtIdCliente" name="txtIdCliente" value="${empty cartao ? '' : cartao.getId_Cliente()}"/>
						<!-- <input type="text" class="form-control" id="txtId" name="txtId" value="${empty cliente ? '' : cliente.getId()}" readonly="readonly"/> -->
					</td>
				</tr>
				<tr>
					<td>
						Titular
					</td>
					<td>
						<input type="text" class="form-control" id="txtTitular" name="txtTitular" value="${empty cartao ? '' : cartao.getTitular()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Numero
					</td>
					<td>
						<input type="text" class="form-control" id="txtNumeroCartao" name="txtNumeroCartao" value="${empty cliente ? '' : cliente.getId()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Codigo
					</td>
					<td>
						<input type="text" class="form-control" id="txtCodigo" name="txtCodigo" value="${empty cliente ? '' : cliente.getId()}"/>
					</td>
				</tr>
				<tr>
					<td>
						preferencial
					</td>
					<td>
						Ativo    <input type="radio" id="rdCPreferencial" name="rdCPreferencial" value="true" checked>
					    Inativo    <input type="radio" id="rdCPreferencial" name="rdCPreferencial" value="false" ${cliente.getStatus() == false ? 'checked' : ''}>
					</td>
				</tr>
				<tr>
					<td>
						validade
					</td>
					<td>
						<input type="text"class="form-control" id="txtValidade" name="txtValidade" value="${empty cliente ? '' : cliente.getTelefone()}" />
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