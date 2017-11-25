<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalDominio.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
		<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Cadastro de livros</title>
	</head>
	<body>
		<form action="SalvarLivro" method="post" id="frmSalvarLivro">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de livros</TH></tr>
				<tr style="display:none">
					<td>
						ID do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtId" name="txtId" value="${empty livro ? '' : livro.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td>
						Titulo do livro
					</td>
					<td>
						<label id="txtTitulo">${empty livro ? '' : livro.getTitulo()}</label>
					</td>
					<td>
						Autor do livro
					</td>
					<td>
						<input type="text"class="form-control" id="txtAutor" name="txtAutor" value="${empty livro ? '' : livro.getAutor()}" />
					</td>
				</tr>
				<tr>
					<td>
						Ano do livro
					</td>
					<td>
						<input type="text"class="form-control" id="txtAno" name="txtAno" value="${empty livro ? '' : livro.getAno()}" />
					</td>
					<td>
						Editora do livro
					</td>
					<td>
						<input type="text"class="form-control" id="txtEditora" name="txtEditora" value="${empty livro ? '' : livro.getEditora()}" />
					</td>
				</tr>
				<tr>
					<td>
						Edição do livro
					</td>
					<td>
						<input type="text"class="form-control" id="txtEdicao" name="txtEdicao" value="${empty livro ? '' : livro.getEdicao()}" />
					</td>
					<td>
						ISBN do livro
					</td>
					<td>
						<input type="text"class="form-control" id="txtISBN" name="txtISBN" value="${empty livro ? '' : livro.getISBN()}" />
					</td>
				</tr>
				<tr>
					<td>
						Número de páginas do livro
					</td>
					<td>
						<input type="text"class="form-control" id="txtPaginas" name="txtPaginas" value="${empty livro ? '' : livro.getNpaginas()}" />
					</td>
					<td>
						Sinopse do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtSinopse" name="txtSinopse" value="${empty livro ? '' : livro.getSinopse()}" />
					</td>
				</tr>
				<tr>
					<td>
						Altura do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtAltura" name="txtAltura" value="${empty livro ? '' : livro.getAltura()}" />
					</td>
					<td>
						Largura do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtLargura" name="txtLargura" value="${empty livro ? '' : livro.getLargura()}" />
					</td>
				</tr>
				<tr>
					<td>
						Peso do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtPeso" name="txtPeso" value="${empty livro ? '' : livro.getPeso()}" />
					</td>
					<td>
						Profundidade do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtProfundidade" name="txtProfundidade" value="${empty livro ? '' : livro.getProfundidade()}" />
					</td>
				</tr>
				<tr>
					<td>
						Quantidade em estoque
					</td>
					<td>
						<input type="text" class="form-control" id="txtEstoque" name="txtEstoque" value="${empty livro ? '' : livro.getEstoque()}" />
					</td>
					<td>
						Valor do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtValor" name="txtValor" value="${empty livro ? '' : livro.getValor()}" />
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="COMPRAR" class="btn btn-default" />
		</form>
	</body>
</html>