<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="resources/estilo.css">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<!-- Criando a listagem -->
<ul class="abas">
    <!-- Aqui, criação da primeira aba -->
    <li class="aba" id="aba-1">
     <a onclick="Sumir1()" href="#aba-1">Comprar livros</a>
<section class="conteudo">
	<form style='' action="SalvarCarrinho" method="post" id="frmSalvarCarrinho">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Comprar livros</TH></tr>
				<tr style="${empty carrinho ? 'display:none' : ''}">
					<td>
						Digite sua senha
					</td>
					<td>
						<input type="text" class="form-control" id="txtSenha" name="txtSenha" value="${empty cliente ? '' : cliente.getCpf()}" />
					</td>
				</tr>
				<tr>
					<td>
						Status
					</td>
					<td>
						<select id="ddlStatus" name="ddlStatus">
							<option ${carrinho.getStatus() == 'EM PROCESSAMENTO' ? 'selected' : '' }>EM PROCESSAMENTO</option>
							<option ${carrinho.getStatus() == 'APROVADO' ? 'selected' : '' }>APROVADO</option>
							<option ${carrinho.getStatus() == 'REPROVADO' ? 'selected' : '' }>REPROVADO</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Forma de pagamento
					</td>
					<td>
						<select id="ddlPagamento" name="ddlPagamento">
							<option ${cartao.getFormaPagamento() == 'Cartao' ? 'selected' : '' }>Cartao</option>
							<option ${cartao.getFormaPagamento() == 'Cupom promocional' ? 'selected' : '' }>Cupom promocional</option>
							<option ${cartao.getFormaPagamento() == 'Cupom de troca' ? 'selected' : '' }>Cupom de troca</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Digite o id do endereço
					</td>
					<td>
						<input type="number" class="form-control" id="txtIdEndereco" name="txtIdEndereco" value="${empty cliente ? '' : cliente.getCpf()}" />
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="${empty carrinho ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
			<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormConsultaCliente.jsp">Consultar clientes</a>
		</form>
</section></li>
<!-- Aqui, criação da segunda aba -->
    <li class="aba" id="aba-2">
     <a onclick="Sumir2()" href="#aba-2">Buscar livro</a> 
<section class="conteudo">
	<form style='' action="SalvarProduto" method="post" id="frmSalvarProduto">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Comprar livros</TH></tr>
				<tr style="${empty carrinho ? 'display:none' : ''}">
					<td>
						ID do carrinho
					</td>
					<td>
						<input type="text" class="form-control" id="txtId" name="txtId" value="${empty carrinho ? '' : carrinho.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr style="${empty produto ? 'display:none' : ''}">
					<td>
						ID do produto
					</td>
					<td>
						<input type="text" class="form-control" id="txtIdProduto" name="txtIdProduto" value="${empty produto ? '' : produto.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td>
						Digite seu email
					</td>
					<td>
						<input type="text" class="form-control" id="txtEmail2" name="txtEmail" value="${empty produto ? '' : produto.getNome()}" />
					</td>
				</tr>
				<tr>
					<td>
						Digite sua senha
					</td>
					<td>
						<input type="text" class="form-control" id="txtSenha2" name="txtSenha" value="${empty produto ? '' : produto.getCpf()}" />
					</td>
				</tr>
				<tr>
					<td>
						Digite o id do livro
					</td>
					<td>
						<input type="number" class="form-control" id="txtIdLivro" name="txtIdLivro" value="${empty produto ? '' : produto.getCpf()}" />
					</td>
				</tr>
				<tr>
					<td>
						Digite o titulo do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtTitulo" name="txtTitulo" value="${empty produto ? '' : produto.getCpf()}" />
					</td>
				</tr>
				<tr>
					<td>
						Quantidade de livros
					</td>
					<td>
						<input type="number" class="form-control" id="txtQuantidade" name="txtQuantidade" value="${empty produto ? '' : produto.getCpf()}" />
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao2" name="operacao" value="${empty produto ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
			<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormConsultaCliente.jsp">Consultar clientes</a>
		</form>
</section></li>
<!-- Aqui, criação da terceira aba -->
    <li class="aba" id="aba-2">
     <a onclick="Sumir2()" href="#aba-2">Buscar livro</a> 
<section class="conteudo">
</section></li>
</ul>
</body>
</html>