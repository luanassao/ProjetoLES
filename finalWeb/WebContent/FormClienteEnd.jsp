<%@page import="jdk.nashorn.internal.runtime.ListAdapter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="resources/estilo.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  	<script src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
	<meta charset="UTF-8" />
  <title>
    Cadastro de clientes
  </title>
 <script type="text/javascript">
 function Cliente() {
		document.getElementById("sectionCliente").style='';
		document.getElementById("sectionEndereco").style='display:none';
		document.getElementById("sectionCartao").style='display:none';
		document.getElementById("sectionConsultaEndereco").style='display:none';
		document.getElementById("sectionConsultaCartao").style='display:none';
	}
 function Endereco() {
		document.getElementById("sectionCliente").style='display:none';
		document.getElementById("sectionEndereco").style='';
		document.getElementById("sectionCartao").style='display:none';
		document.getElementById("sectionConsultaEndereco").style='display:none';
		document.getElementById("sectionConsultaCartao").style='display:none';
	}
 function Cartao() {
		document.getElementById("sectionCliente").style='display:none';
		document.getElementById("sectionEndereco").style='display:none';
		document.getElementById("sectionCartao").style='';
		document.getElementById("sectionConsultaEndereco").style='display:none';
		document.getElementById("sectionConsultaCartao").style='display:none';
	}
 function ConsultarEndereco() {
		document.getElementById("sectionCliente").style='display:none';
		document.getElementById("sectionEndereco").style='display:none';
		document.getElementById("sectionCartao").style='display:none';
		document.getElementById("sectionConsultaEndereco").style='';
		document.getElementById("sectionConsultaCartao").style='display:none';
	}
 function ConsultarCartao() {
		document.getElementById("sectionCliente").style='display:none';
		document.getElementById("sectionEndereco").style='display:none';
		document.getElementById("sectionCartao").style='display:none';
		document.getElementById("sectionConsultaEndereco").style='display:none';
		document.getElementById("sectionConsultaCartao").style='';
	}
</script>
<script>
   $(document).ready(function(){
	   $("#divNavBar").load("NavBar.jsp");
   });
</script>
</head>
<body>
	<div id="divNavBar"></div>
  <!-- Criando a listagem -->
<ul class="abas">
    <!-- Aqui, criação da primeira aba -->
    <li class="aba" id="abaCliente">
     <a onclick="Cliente()" href="#abaCliente">${empty cliente ? "Cadastrar cliente" : "Alterar cliente"}</a>
     <a onclick="Endereco()" href="#abaEndereco">Cadastrar Endereço</a>
     <a onclick="Cartao()" href="#abaCartao">Cadastrar Cartao</a>
     <a onclick="ConsultarEndereco()" href="#abaConsultaEndereco">Cosultar endereços</a>
     <a onclick="ConsultarCartao()" href="#abaConsultaCartao">Cosultar cartoes</a>
<section class="conteudo" style="${aba == 'abaCliente' ? '' : 'display:none'}" id="sectionCliente">
	<form action="SalvarCliente" method="post" style="${empty usuario ? 'display:none' : ''}">
		<table class="table table-bordered">
			<tr><TH COLSPAN="2">Cadastro de clientes</TH></tr>
			<tr style="${empty cliente ? 'display:none' : ''}">
				<td>
					ID do cliente
				</td>
				<td>
					<input type="text" class="form-control" id="txtId" name="txtId" value="${empty usuario ? '' : usuario.getId()}" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td>
					Nome do cliente
					<br>
					<input type="text"class="form-control" id="txtNome" name="txtNome" value="${empty usuario ? '' : usuario.getNome()}" />
				</td>
				<td>
					CPF
					<br>
					<input type="text"class="form-control" id="txtCpf" name="txtCpf" value="${empty usuario ? '' : usuario.getCpf()}" />
				</td>
			</tr>
			<tr>
				<td>
					Status do Cliente
					<br>
					<div class="btn-group btn-group-toggle" data-toggle="buttons">
					  <label class="${usuario.getStatus() ? 'btn btn-outline-dark active' : 'btn btn-outline-dark'}">
					    <input type="radio" name="rdStatus" id="rdStatus" value="true" autocomplete="off" ${usuario.getStatus() ? 'checked' : ''}> Ativo
					  </label>
					  <label class="${usuario.getStatus() == false ? 'btn btn-outline-dark active' : 'btn btn-outline-dark'}">
					    <input type="radio" name="rdStatus" id="rdStatus" value="false" autocomplete="off" ${usuario.getStatus() ? '' : 'checked'}> Inativo
					  </label>
					</div>
				</td>
				<td>
					Tipo de telefone
					<br>
					<select class="btn btn-outline-dark" id="ddlTipoTel" name="ddlTipoTel">
						<option ${usuario.getTipoTelefone() == 'Residencial' ? 'selected' : '' }>Residencial</option>
						<option ${usuario.getTipoTelefone() == 'Celular' ? 'selected' : '' }>Celular</option>
						<option ${usuario.getTipoTelefone() == 'Empresarial' ? 'selected' : '' }>Empresarial</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>
					Telefone
					<br>
					<input type="text"class="form-control" id="txtTelefone" name="txtTelefone" value="${empty usuario ? '' : usuario.getTelefone()}" />
				</td>
				<td>
					Email
					<br>
					<input type="text"class="form-control" id="txtEmail" name="txtEmail" value="${empty usuario ? '' : usuario.getEmail()}" />
				</td>
			</tr>
			<tr style="${empty usuario ? '' : 'display:none'}">
				<td>
					Senha
					<br>
					<input type="text"class="form-control" id="txtSenha" name="txtSenha" value="${empty usuario ? '' : usuario.getSenha()}" />
				</td>
				<td>
					Confirme a senha
					<br>
					<input type="text"class="form-control" id="txtISBN" name="txtISBN" value="${empty usuario ? '' : usuario.getSenha()}" />
				</td>
			</tr>
			<tr>
				<td>
					Genero
					<br>
					<div class="btn-group btn-group-toggle" data-toggle="buttons">
					  <label class="${usuario.getGenero() == 'Masculino' ? 'btn btn-outline-dark active' : 'btn btn-outline-dark'}">
					    <input type="radio" name="rdGenero" id="rdGenero" value="Masculino" autocomplete="off" checked> Masculino
					  </label>
					  <label class="${usuario.getGenero() == 'Feminino' ? 'btn btn-outline-dark active' : 'btn btn-outline-dark'}">
					    <input type="radio" name="rdGenero" id="rdGenero" value="Feminino" autocomplete="off"> Feminino
					  </label>
					</div>
				</td>
				<td>
					Data de nascimento
					<br>
					<input type="${empty usuario ? 'date' : 'text'}" class="form-control"  id="txtDtNasc" name="txtDtNasc" value="${empty usuario ? '' : usuario.getDtnascFormatado()}" />
					<!--<input type="text" class="form-control"  id="txtDtNasc" name="txtDtNasc" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" />-->
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
		<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="ALTERAR">ALTERAR</button>
	</form>
	<form action="SalvarCliente" method="post" style="${empty usuario ? '' : 'display:none'}">
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
						<br>
						<input type="text"class="form-control" id="txtNome" name="txtNome" value="${empty cliente ? '' : cliente.getNome()}" />
					</td>
					<td>
						CPF
						<br>
						<input type="text"class="form-control" id="txtCpf" name="txtCpf" value="${empty cliente ? '' : cliente.getCpf()}" />
					</td>
				</tr>
				<tr>
					<td>
						Status do Cliente
						<br>
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
						  <label class="${cliente.getStatus() ? 'btn btn-outline-dark active' : 'btn btn-outline-dark'}">
						    <input type="radio" name="rdStatus" id="rdStatus" value="true" autocomplete="off" ${cliente.getStatus() ? 'checked' : ''}> Ativo
						  </label>
						  <label class="${cliente.getStatus() == false ? 'btn btn-outline-dark active' : 'btn btn-outline-dark'}">
						    <input type="radio" name="rdStatus" id="rdStatus" value="false" autocomplete="off" ${cliente.getStatus() ? '' : 'checked'}> Inativo
						  </label>
						</div>
					</td>
					<td>
						Tipo de telefone
						<br>
						<select class="btn btn-outline-dark" id="ddlTipoTel" name="ddlTipoTel">
							<option ${cliente.getTipoTelefone() == 'Residencial' ? 'selected' : '' }>Residencial</option>
							<option ${cliente.getTipoTelefone() == 'Celular' ? 'selected' : '' }>Celular</option>
							<option ${cliente.getTipoTelefone() == 'Empresarial' ? 'selected' : '' }>Empresarial</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Telefone
						<br>
						<input type="text"class="form-control" id="txtTelefone" name="txtTelefone" value="${empty cliente ? '' : cliente.getTelefone()}" />
					</td>
					<td>
						Email
						<br>
						<input type="text"class="form-control" id="txtEmail" name="txtEmail" value="${empty cliente ? '' : cliente.getEmail()}" />
					</td>
				</tr>
				<tr style="${empty cliente ? '' : 'display:none'}">
					<td>
						Senha
						<br>
						<input type="text"class="form-control" id="txtSenha" name="txtSenha" value="${empty cliente ? '' : cliente.getSenha()}" />
					</td>
					<td>
						Confirme a senha
						<br>
						<input type="text"class="form-control" id="txtISBN" name="txtISBN" value="${empty cliente ? '' : cliente.getSenha()}" />
					</td>
				</tr>
				<tr>
					<td>
						Genero
						<br>
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
						  <label class="${cliente.getGenero() == 'Masculino' ? 'btn btn-outline-dark active' : 'btn btn-outline-dark'}">
						    <input type="radio" name="rdGenero" id="rdGenero" value="Masculino" autocomplete="off" checked> Masculino
						  </label>
						  <label class="${cliente.getGenero() == 'Feminino' ? 'btn btn-outline-dark active' : 'btn btn-outline-dark'}">
						    <input type="radio" name="rdGenero" id="rdGenero" value="Feminino" autocomplete="off"> Feminino
						  </label>
						</div>
					</td>
					<td>
						Data de nascimento
						<br>
						<input type="${empty cliente ? 'date' : 'text'}" class="form-control"  id="txtDtNasc" name="txtDtNasc" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" />
						<!--<input type="text" class="form-control"  id="txtDtNasc" name="txtDtNasc" value="${empty cliente ? '' : cliente.getDtnascFormatado()}" />-->
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
			<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="ALTERAR" style="${empty cliente ? 'display:none' : ''}">ALTERAR</button>
			
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#EndCobModal"style="${empty cliente ? '' : 'display:none'}">
			  SALVAR
			</button>
			
			<!-- Modal -->
			<div class="modal fade" id="EndCobModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">Cadastrar Endereço de cobrança</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
					<table class="table table-bordered">
						<tr><TH COLSPAN="2">Cadastro de Endereço</TH></tr>
						<tr>
						<td COLSPAN="2">
							Nome do endereço
							<input type="text" class="form-control" id="txtNomeEnderecoC" name="txtNomeEnderecoC" placeholder="ex:Minha casa"/>
							</td>
						</tr>
						<tr>
							<td>
								Tipo do endereço
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoEndereco" name="ddlTipoEnderecoC">
									<option>Cobrança</option>
								</select>
							</td>
							<td>
								Tipo da residencia
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoResidencia" name="ddlTipoResidenciaC">
									<option >Casa</option>
									<option >Apartamento</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Tipo do logradouro
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoLogradouro" name="ddlTipoLogradouroC">
									<option>Avenida</option>
									<option>Rua</option>
									<option>Travessa</option>
								</select>
							</td>
							<td>
								Logradouro
								<br>
								<input type="text" class="form-control" id="txtLogradouro" name="txtLogradouroC"/>
							</td>
						</tr>
						<tr>
							<td>
								Preferencial
								<br>
								<div class="btn-group btn-group-toggle" data-toggle="buttons">
								  <label class="btn btn-outline-dark">
								    <input type="radio" name="rdPreferencialC" id="rdPreferencial" value="true" autocomplete="off" checked> Preferencial
								  </label>
								  <label class="btn btn-outline-dark">
								    <input type="radio" name="rdPreferencialC" id="rdPreferencial" value="false" autocomplete="off"> Comum
								  </label>
								</div>
							</td>
							<td>
								Número
								<br>
								<input type="text"class="form-control" id="txtNumero" name="txtNumeroC"/>
							</td>
						</tr>
						<tr>
							<td>
								Bairro
								<br>
								<input type="text"class="form-control" id="txtBairro" name="txtBairroC"/>
							</td>
							<td>
								CEP
								<br>
								<input type="text"class="form-control" id="txtCep" name="txtCepC"/>
							</td>
						</tr>
						<tr>
							<td>
								Estado
								<br>
								<input type="text"class="form-control" id="txtEstado" name="txtEstadoC"/>
							</td>
							<td>
								Cidade
								<br>
								<input type="text"class="form-control" id="txtCidade" name="txtCidadeC"/>
							</td>
						</tr>
						<tr>
							<td>
								País
								<br>
								<input type="text" class="form-control"  id="txtPais" name="txtPaisC"/>
							</td>
							<td>
								Observação
								<br>
								<input type="text" class="form-control"  id="txtObservacao" name="txtObservacaoC"/>
							</td>
						</tr>
					</table>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#EndEntModal">
					  Continuar
					</button>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
			      </div>
			    </div>
			  </div>
			</div>
			
			<!-- Modal -->
			<div class="modal fade" id="EndEntModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">Cadastrar Endereço de entrega</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
					<table class="table table-bordered">
						<tr><TH COLSPAN="2">Cadastro de Endereço</TH></tr>
						<tr>
							<td COLSPAN="2">
								Nome do endereço
								<input type="text" class="form-control" id="txtNomeEnderecoE" name="txtNomeEnderecoE" placeholder="ex:Minha casa"/>
							</td>
						</tr>
						<tr>
							<td>
								Tipo do endereço
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoEndereco" name="ddlTipoEnderecoE">
									<option>Entrega</option>
								</select>
							</td>
							<td>
								Tipo da residencia
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoResidencia" name="ddlTipoResidenciaE">
									<option >Casa</option>
									<option >Apartamento</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Tipo do logradouro
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoLogradouro" name="ddlTipoLogradouroE">
									<option>Avenida</option>
									<option>Rua</option>
									<option>Travessa</option>
								</select>
							</td>
							<td>
								Logradouro
								<br>
								<input type="text" class="form-control" id="txtLogradouro" name="txtLogradouroE"/>
							</td>
						</tr>
						<tr>
							<td>
								Preferencial
								<br>
								<div class="btn-group btn-group-toggle" data-toggle="buttons">
								  <label class="btn btn-outline-dark">
								    <input type="radio" name="rdPreferencialE" id="rdPreferencial" value="true" autocomplete="off" checked> Preferencial
								  </label>
								  <label class="btn btn-outline-dark">
								    <input type="radio" name="rdPreferencialE" id="rdPreferencial" value="false" autocomplete="off"> Comum
								  </label>
								</div>
							</td>
							<td>
								Número
								<br>
								<input type="text"class="form-control" id="txtNumero" name="txtNumeroE"/>
							</td>
						</tr>
						<tr>
							<td>
								Bairro
								<br>
								<input type="text"class="form-control" id="txtBairro" name="txtBairroE"/>
							</td>
							<td>
								CEP
								<br>
								<input type="text"class="form-control" id="txtCep" name="txtCepE"/>
							</td>
						</tr>
						<tr>
							<td>
								Estado
								<br>
								<input type="text"class="form-control" id="txtEstado" name="txtEstadoE"/>
							</td>
							<td>
								Cidade
								<br>
								<input type="text"class="form-control" id="txtCidade" name="txtCidadeE"/>
							</td>
						</tr>
						<tr>
							<td>
								País
								<br>
								<input type="text" class="form-control"  id="txtPais" name="txtPaisE"/>
							</td>
							<td>
								Observação
								<br>
								<input type="text" class="form-control"  id="txtObservacao" name="txtObservacaoE"/>
							</td>
						</tr>
					</table>
					<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="SALVAR">SALVAR</button>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
			      </div>
			    </div>
			  </div>
			</div>
			
		</form>
</section></li>
<!-- Aqui, criação da segunda aba -->
    <li class="aba" id="abaEndereco">
      
<section class="conteudo" id="sectionEndereco" style="${aba == 'abaEndereco' ? '' : 'display:none'}">
	<form  action="SalvarEndereco" method="post">
	<!-- <form style='display:none' action="SalvarEndereco" method="post" id="frmSalvarEndereco"> -->
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de Endereço</TH></tr>
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
					<td COLSPAN="2">
						Nome do endereço
						<input type="text" class="form-control" id="txtNomeEndereco" name="txtNomeEndereco" placeholder="Ex: Minha casa" value="${empty endereco ? '' : endereco.getNomeEndereco()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Tipo do endereço
						<br>
						<select class="btn btn-outline-dark" id="ddlTipoEndereco" name="ddlTipoEndereco">
							<option ${endereco.getTipo() == 'Cobranca' ? 'selected' : '' }>Cobranca</option>
							<option ${endereco.getTipo() == 'Entrega' ? 'selected' : '' }>Entrega</option>
						</select>
					</td>
					<td>
						Tipo da residencia
						<br>
						<select class="btn btn-outline-dark" id="ddlTipoResidencia" name="ddlTipoResidencia">
							<option ${endereco.getTipoResidencia() == 'Casa' ? 'selected' : '' }>Casa</option>
							<option ${endereco.getTipoResidencia() == 'Apartamento' ? 'selected' : '' }>Apartamento</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Tipo do logradouro
						<br>
						<select class="btn btn-outline-dark" id="ddlTipoLogradouro" name="ddlTipoLogradouro">
							<option ${endereco.getTipoLogradouro() == 'Avenida' ? 'selected' : '' }>Avenida</option>
							<option ${endereco.getTipoLogradouro() == 'Rua' ? 'selected' : '' }>Rua</option>
							<option ${endereco.getTipoLogradouro() == 'Travessa' ? 'selected' : '' }>Travessa</option>
						</select>
					</td>
					<td>
						Logradouro
						<br>
						<input type="text" class="form-control" id="txtLogradouro" name="txtLogradouro" value="${empty endereco ? '' : endereco.getLogradouro()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Preferencial
						<br>
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
						  <label class="btn btn-outline-dark">
						    <input type="radio" name="rdPreferencial" id="rdPreferencial" value="true" autocomplete="off" checked> Preferencial
						  </label>
						  <label class="btn btn-outline-dark">
						    <input type="radio" name="rdPreferencial" id="rdPreferencial" value="false" autocomplete="off"> Comum
						  </label>
						</div>
					</td>
					<td>
						Número
						<br>
						<input type="text"class="form-control" id="txtNumero" name="txtNumero" value="${empty endereco ? '' : endereco.getNumero()}" />
					</td>
				</tr>
				<tr>
					<td>
						Bairro
						<br>
						<input type="text"class="form-control" id="txtBairro" name="txtBairro" value="${empty endereco ? '' : endereco.getBairro()}" />
					</td>
					<td>
						CEP
						<br>
						<input type="text"class="form-control" id="txtCep" name="txtCep" value="${empty endereco ? '' : endereco.getCep()}" />
					</td>
				</tr>
				<tr>
					<td>
						Estado
						<br>
						<input type="text"class="form-control" id="txtEstado" name="txtEstado" value="${empty endereco ? '' : endereco.getEstado()}" />
					</td>
					<td>
						Cidade
						<br>
						<input type="text"class="form-control" id="txtCidade" name="txtCidade" value="${empty endereco ? '' : endereco.getCidade()}" />
					</td>
				</tr>
				<tr>
					<td>
						País
						<br>
						<input type="text" class="form-control"  id="txtPais" name="txtPais" value="${empty endereco ? '' : endereco.getPais()}" />
					</td>
					<td>
						Observação
						<br>
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
      
<section class="conteudo" id="sectionCartao" style="${aba == 'abaEndereco' ? '' : 'display:none'}">
	<form action="SalvarCartao" method="post" >
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
						<br>
						<input type="text" class="form-control" id="txtTitular" name="txtTitular" value="${empty cartao ? '' : cartao.getTitular()}"/>
					</td>
					<td>
						Numero
						<br>
						<input type="text" class="form-control" id="txtNumeroCartao" maxlength="16" name="txtNumeroCartao" value="${empty cartao ? '' : cartao.getNumero()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Codigo
						<br>
						<input type="text" class="form-control" id="txtCodigo" maxlength="3" name="txtCodigo" value="${empty cartao ? '' : cartao.getCodigo()}"/>
					</td>
					<td>
						Bandeira
						<br>
						<select class="btn btn-outline-dark" id="ddlBandeira" name="ddlBandeira">
							<option ${endereco.getTipoLogradouro() == 'Visa' ? 'selected' : '' }>Visa</option>
							<option ${endereco.getTipoLogradouro() == 'Caixa' ? 'selected' : '' }>Caixa</option>
							<option ${endereco.getTipoLogradouro() == 'Itau' ? 'selected' : '' }>Itau</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						preferencial
						<br>
					    <div class="btn-group btn-group-toggle" data-toggle="buttons">
						  <label class="btn btn-outline-dark">
						    <input type="radio" name="rdCPreferencial" id="rdCPreferencial" value="true" autocomplete="off" checked> Preferencial
						  </label>
						  <label class="btn btn-outline-dark">
						    <input type="radio" name="rdCPreferencial" id="rdCPreferencial" value="false" autocomplete="off"> Comum
						  </label>
						</div>
					</td>
					<td>
						validade
						<br>
						<input type="text"class="form-control" id="txtValidade" name="txtValidade" value="${empty cartao ? '' : cartao.getValidadeFormatado()}" />
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
<!-- Aqui, criação da segunda aba -->
    <li class="aba" id="aba-3">
      
<section class="conteudo" id="sectionConsultaEndereco" style="${aba == 'abaConsultarEnderecos' ? '' : 'display:none'}">
	<form action="SalvarEndereco" method="post">
		<table class="table table-bordered">
			<TR>
		      <TH COLSPAN="3"><BR>
		      	<H3>CONSULTAR MEUS ENDEREÇOS</H3>
		      </TH>
	   		
			</table>
			<br><input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR" />
		</form>
		<table class="table table-bordered">
		   <TR>
		      <TH COLSPAN="16"><BR>
		      	<H3>ENDERECOS</H3>
		      </TH>
		   </TR>
		   <TR>
		      <TH>Nome do endereço</TH>
		      <TH>Tipo da residencia</TH>
		      <TH>Tipo do logradouro</TH>
		      <TH>logradouro</TH>
		      <TH>Numero</TH>
		      <TH>Bairro</TH>
		      <TH>CEP</TH>
		      <TH>Estado</TH>
		      <TH>Cidade</TH>
		      <TH>Pais</TH>
		      <TH>Observação</TH>
		      <TH>Preferencial</TH>
		      <TH>Alterador</TH>
		   </TR>
		   
		   <%
		   List<EntidadeDominio> enderecos = (ArrayList<EntidadeDominio>) session.getAttribute("enderecos");
		   if (enderecos != null) {
				StringBuilder sbRegistro = new StringBuilder();
				StringBuilder sbLink = new StringBuilder();
				
				if(enderecos != null){
					try{
					for (EntidadeDominio endereco:enderecos) {
						Endereco e = (Endereco) endereco;
						sbRegistro.setLength(0);
						sbLink.setLength(0);
						
					//	<a href="nome-do-lugar-a-ser-levado">descrição</a>
						
						sbRegistro.append("<TR ALIGN='CENTER'>");
						
						
						sbLink.append("<a href=SalvarEndereco?");
							sbLink.append("txtId=");
							sbLink.append(e.getId());						
							sbLink.append("&");
							sbLink.append("operacao=");
							sbLink.append("VISUALIZAR");
							
						sbLink.append(">");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());	
						sbRegistro.append(e.getNomeEndereco());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getTipoResidencia());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getTipoLogradouro());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getLogradouro());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getNumero());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getBairro());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getCep());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getEstado());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getCidade());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getPais());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getObservacao());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getPreferencial() == true ? "Ativo" : "Inativo");
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("<TD>");
						sbRegistro.append(sbLink.toString());				
						sbRegistro.append(e.getAlterador());
						sbRegistro.append("</a>");				
						sbRegistro.append("</TD>");
						
						sbRegistro.append("</TR>");
						
						out.print(sbRegistro.toString());
						
					}
					}catch(Exception e){
						
					}
				}
			}
		   
		   %>
		</TABLE>
</section></li>
<!-- Aqui, criação da segunda aba -->
    <li class="aba" id="aba-3">
      
<section class="conteudo" id="sectionConsultaCartao" style="${aba == 'abaConsultarCartoes' ? '' : 'display:none'}">
	<form action="SalvarCartao" method="post">
		<table class="table table-bordered">
			<TR>
		      <TH COLSPAN="3"><BR>
		      	<H3>CONSULTAR Cartoes</H3>
		      </TH>
	   		
			</table>
			<br><input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR" />
		</form>
		<TABLE class="table table-sm" bordercolor="blue" BORDER="5"    WIDTH="50%"   CELLPADDING="4" CELLSPACING="3">
   <TR>
      <TH COLSPAN="16"><BR>
      	<H3>CARTÕES</H3>
      </TH>
   </TR>
   <TR>
      <TH>Titular</TH>
      <TH>Bandeira</TH>
      <TH>Numero</TH>
      <TH>Codigo</TH>
      <TH>ID do cliente</TH>
      <TH>Nivel</TH>
      <TH>Validade</TH>
      <TH>Alterador</TH>
   </TR>
   
   <%
   List<EntidadeDominio> cartoes = (ArrayList<EntidadeDominio>) session.getAttribute("cartoes");
   if (cartoes != null) {
		StringBuilder sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		
		if(cartoes != null){
			try{
			for (EntidadeDominio cartao:cartoes) {
				Cartao c = (Cartao) cartao;
				sbRegistro.setLength(0);
				sbLink.setLength(0);
				
			//	<a href="nome-do-lugar-a-ser-levado">descrição</a>
				
				sbRegistro.append("<TR ALIGN='CENTER'>");
				
				
				sbLink.append("<a href=SalvarCartao?");
					sbLink.append("txtId=");
					sbLink.append(c.getId());						
					sbLink.append("&");
					sbLink.append("operacao=");
					sbLink.append("VISUALIZAR");
					
				sbLink.append(">");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getTitular());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getBandeira());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");

				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getNumero());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getCodigo());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getID_Cliente());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getPreferencial() == true ? "Preferencial" : "Comum");
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getValidadeFormatado());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getAlterador());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("</TR>");
				
				out.print(sbRegistro.toString());
				
			}
			}catch(Exception e){
				
			}
		}
	}
   
   %>
</TABLE>
</section></li>
</ul>
</body>
</html>