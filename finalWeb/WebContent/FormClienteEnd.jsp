<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd%22%3E
<html>
<head>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="resources/estilo.css">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  <title>
    Criando Abas
  </title>
  <meta charset="UTF-8" />
 <script type="text/javascript">
 function Sumir1() {
		document.getElementById("frmSalvarCliente").style='';
		document.getElementById("frmSalvarEndereco").style='display:none';
		document.getElementById("frmSalvarCartao").style='display:none';
	}
 function Sumir2() {
		document.getElementById("frmSalvarCliente").style='display:none';
		document.getElementById("frmSalvarEndereco").style='';
		document.getElementById("frmSalvarCartao").style='display:none';
	}
 function Sumir3() {
		document.getElementById("frmSalvarCliente").style='display:none';
		document.getElementById("frmSalvarEndereco").style='display:none';
		document.getElementById("frmSalvarCartao").style='';
	}
</script>
</head>
<body>
  <!-- Criando a listagem -->
<ul class="abas">
    <!-- Aqui, criação da primeira aba -->
    <li class="aba" id="aba-1">
     <a onclick="Sumir1()" href="#aba-1">${empty cliente ? "Cadastrar cliente" : "Alterar cliente"}</a>
<section class="conteudo">
	<form style='' action="SalvarCliente" method="post" id="frmSalvarCliente">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de clientes</TH></tr>
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
						<!-- <input type="${empty cliente ? 'date' : 'text'}" class="form-control"  id="txtDtNasc" name="txtDtNasc" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" /> -->
						<input type="text" class="form-control"  id="txtDtNasc" name="txtDtNasc" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" />
					</td>
				</tr>
				<tr>
					<td>
						Responsavel
					</td>
					<td>
						<!-- <input type="${empty cliente ? 'date' : 'text'}" class="form-control"  id="txtDtNasc" name="txtDtNasc" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" /> -->
						<input type="text" class="form-control"  id="txtAlterador" name="txtAlterador"/>
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="${empty cliente ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
			<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormConsultaCliente.jsp">Consultar clientes</a>
		</form>
</section></li>
<!-- Aqui, criação da segunda aba -->
    <li class="aba" id="aba-2">
     <a onclick="Sumir2()" href="#aba-2">Cadastrar Endereço</a> 
<section class="conteudo">
	<form style='display:none' action="SalvarEndereco" method="post" id="frmSalvarEndereco">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de livros</TH></tr>
				<tr style="${empty cliente ? 'display:none' : ''}">
					<td>
						ID
					</td>
					<td>
						<input type="text" class="form-control" id="txtId" name="txtId" value="${empty endereco ? '' : endereco.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr style="${empty cliente ? 'display:none' : ''}">
					<td>
						ID do cliente
					</td>
					<td>
						<input type="text" class="form-control" id="txtIdCliente" name="txtIdCliente" value="${empty cliente ? '' : cliente.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td>
						Tipo da residencia
					</td>
					<td>
						<select id="ddlTipoResidencia" name="ddlTipoResidencia">
							<option ${endereco.getTipoResidencia() == 'Casa' ? 'selected' : '' }>Casa</option>
							<option ${endereco.getTipoResidencia() == 'Apartamento' ? 'selected' : '' }>Apartamento</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Tipo do logradouro
					</td>
					<td>
						<select id="ddlTipoLogradouro" name="ddlTipoLogradouro">
							<option ${endereco.getTipoLogradouro() == 'Avenida' ? 'selected' : '' }>Avenida</option>
							<option ${endereco.getTipoLogradouro() == 'Rua' ? 'selected' : '' }>Rua</option>
							<option ${endereco.getTipoLogradouro() == 'Travessa' ? 'selected' : '' }>Travessa</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Logradouro
					</td>
					<td>
						<input type="text" class="form-control" id="txtLogradouro" name="txtLogradouro" value="${empty endereco ? '' : endereco.getLogradouro()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Preferencial
					</td>
					<td>
						Ativo    <input type="radio" id="rdPreferencial" name="rdPreferencial" value="true" checked>
					    Inativo    <input type="radio" id="rdPreferencial" name="rdPreferencial" value="false" ${endereco.getPreferencial() == false ? 'checked' : ''}>
					</td>
				</tr>
				<tr>
					<td>
						Número
					</td>
					<td>
						<input type="text"class="form-control" id="txtNumero" name="txtNumero" value="${empty endereco ? '' : endereco.getNumero()}" />
					</td>
				</tr>
				<tr>
					<td>
						Bairro
					</td>
					<td>
						<input type="text"class="form-control" id="txtBairro" name="txtBairro" value="${empty endereco ? '' : endereco.getBairro()}" />
					</td>
				</tr>
				<tr>
					<td>
						CEP
					</td>
					<td>
						<input type="text"class="form-control" id="txtCep" name="txtCep" value="${empty endereco ? '' : endereco.getCep()}" />
					</td>
				</tr>
				<tr>
					<td>
						Estado
					</td>
					<td>
						<input type="text"class="form-control" id="txtEstado" name="txtEstado" value="${empty endereco ? '' : endereco.getEstado()}" />
					</td>
				</tr>
				<tr>
					<td>
						Cidade
					</td>
					<td>
						<input type="text"class="form-control" id="txtCidade" name="txtCidade" value="${empty endereco ? '' : endereco.getCidade()}" />
					</td>
				</tr>
				<tr>
					<td>
						País
					</td>
					<td>
						<input type="text" class="form-control"  id="txtPais" name="txtPais" value="${empty endereco ? '' : endereco.getPais()}" />
					</td>
				</tr>
				<tr>
					<td>
						Observação
					</td>
					<td>
						<input type="text" class="form-control"  id="txtObservacao" name="txtObservacao" value="${empty endereco ? '' : endereco.getObservacao()}" />
					</td>
				</tr>
				<tr>
					<td>
						Responsavel
					</td>
					<td>
						<input type="text" class="form-control"  id="txtResponsavel" name="txtResponsavel" value="${empty endereco ? '' : ''}" />
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="${empty endereco ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
		</form>
</section></li>
<!-- Aqui, criação da segunda aba -->
    <li class="aba" id="aba-3">
     <a onclick="Sumir3()" href="#aba-3">Cadastrar Cartao</a> 
<section class="conteudo">
	<form style='display:none' action="SalvarCartao" method="post" id="frmSalvarCartao">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de cartão</TH></tr>
				<tr style="${empty cliente ? 'display:none' : ''}">
					<td>
						ID
					</td>
					<td>
						<input type="text" class="form-control" id="txtId" name="txtId" value="${empty cartao ? '' : cartao.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr style="${empty cliente ? 'display:none' : ''}">
					<td>
						ID do cliente
					</td>
					<td>
						<input type="text" class="form-control" id="txtIdCliente" name="txtIdCliente" value="${empty cartao ? empty cliente ? '' : cliente.getId() : cartao.getID_Cliente()}" readonly="readonly"/>
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
						<input type="text" class="form-control" id="txtNumeroCartao" name="txtNumeroCartao" value="${empty cartao ? '' : cartao.getNumero()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Codigo
					</td>
					<td>
						<input type="text" class="form-control" id="txtCodigo" name="txtCodigo" value="${empty cartao ? '' : cartao.getCodigo()}"/>
					</td>
				</tr>
				<tr>
					<td>
						preferencial
					</td>
					<td>
						Preferencial    <input type="radio" id="rdCPreferencial" name="rdCPreferencial" value="true" ${cartao.getPreferencial() == true ? 'checked' : ''}>
					    Comum    <input type="radio" id="rdCPreferencial" name="rdCPreferencial" value="false" checked>
					</td>
				</tr>
				<tr>
					<td>
						validade
					</td>
					<td>
						<input type="text"class="form-control" id="txtValidade" name="txtValidade" value="${empty cartao ? '' : cartao.getValidadeFormatado()}" />
					</td>
				</tr>
				<tr>
					<td>
						Bandeira
					</td>
					<td>
						<select id="ddlBandeira" name="ddlBandeira">
							<option ${endereco.getTipoLogradouro() == 'Visa' ? 'selected' : '' }>Visa</option>
							<option ${endereco.getTipoLogradouro() == 'Caixa' ? 'selected' : '' }>Caixa</option>
							<option ${endereco.getTipoLogradouro() == 'Itau' ? 'selected' : '' }>Itau</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Responsavel
					</td>
					<td>
						<input type="text" class="form-control"  id="txtResponsavel" name="txtResponsavel" value="${empty cartao ? '' : cartao.getAlterador()}" />
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="${empty cartao ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
		</form>
</section></li>
</ul>
</body>
</html>