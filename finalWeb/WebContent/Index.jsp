<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pagina principal</title>
</head>
<body>
	<%
		Resultado resultado = (Resultado) session.getAttribute("resultado");
		Cliente usuario = (Cliente) session.getAttribute("usuario");
	%>
	<%
	if(resultado !=null && resultado.getMsg() != null){
		out.print(resultado.getMsg());
	}
	else if(usuario != null){
		out.print("Bem vindo, " + usuario.getNome());
	}
	else if(usuario == null)
		out.print("<a href='http://localhost:8080/finalWeb/FormLogin.jsp'>Fazer Login</a>");
	%>
	<table class="table table-bordered">
		<tr><TH COLSPAN="2">Pagina principal</TH></tr>
		<tr style="${usuario.getAdministrador() ==  true ? '' : 'display:none'}">
			<td>
				<form action="DadosLivro" method="post">
				<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR" >Cadastrar Livro</button>
				</form>
				<!--<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormLivro.jsp">Cadastrar Livro</a>-->
			</td>
		</tr>
		<tr style="${usuario.getAdministrador() ==  true ? '' : 'display:none'}">
			<td>
				<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormConsultaLivro.jsp">Consultar Livros</a>
			</td>
		</tr>
		<tr style="${usuario.getAdministrador() ==  true ? '' : 'display:none'}">
			<td>
				<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormClienteEnd.jsp">Cadastrar cliente</a>
			</td>
		</tr>
		<tr>
			<td>
				<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormConsultaCliente.jsp">
				${usuario.getAdministrador() ==  true ? 'Consultar cliente' : 'Meus dados'}</a>
			</td>
		</tr>
		<tr style="${usuario.getAdministrador() ==  true ? '' : 'display:none'}">
			<td>
				<form action="SalvarProduto" method="post" id="frmGrafico">
				<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR" class="btn btn-default">
				Graficos de análise
				</button>
				<input type="hidden" name="tipo" value="geral">
				</form>
			</td>
		</tr>
		<tr style="${usuario.getAdministrador() ==  true ? 'display:none' : ''}">
			<td>
				<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormCompra.jsp">Comprar livro</a>
			</td>
		</tr>
		<tr style="${usuario.getAdministrador() ==  true ? 'display:none' : ''}">
			<td>
				<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormCarrinho.jsp">Carrinho</a>
			</td>
		</tr>
		<tr>
			<td>
				<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormConsultaPedidos.jsp">
				${usuario.getAdministrador() ==  true ? 'Pedidos' : 'Meus pedidos'}</a>
			</td>
		</tr>
	</table>
</body>
</html>