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
		<script type="text/javascript">
			function Atualizar() {
				if(document.getElementById("txtTitulo").value == '' || document.getElementById("txtAutor").value == ''
					|| document.getElementById("txtAno").value == '' || document.getElementById("txtEditora").value == ''
					|| document.getElementById("txtEdicao").value == '' || document.getElementById("txtISBN").value == ''
					|| document.getElementById("txtPaginas").value == '' || document.getElementById("txtSinopse").value == '')
				{
					alert("Todos os campos são de preenchimento obrigatório!");
					window.location.reload();
				}
			}
		</script>
	</head>
	<body>
		<form action="SalvarLivro" method="post" id="frmSalvarLivro">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de livros</TH></tr>
				<tr style="${empty livro ? 'display:none' : ''}">
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
						<input type="text"class="form-control" id="txtTitulo" name="txtTitulo" value="${empty livro ? '' : livro.getTitulo()}" />
					</td>
				</tr>
				<tr>
					<td>
						Autor do livro
					</td>
					<td>
						<input type="text"class="form-control" id="txtAutor" name="txtAutor" value="${empty livro ? '' : livro.getAutor()}" />
					</td>
				</tr>
				<tr>
					<td>
						Status do livro
					</td>
					<td>
						Ativo    <input type="radio" id="rdStatus" name="rdStatus" value="true" checked>
					    Inativo    <input type="radio" id="rdStatus" name="rdStatus" value="false" ${livro.getStatus() == false ? 'checked' : ''}>
					</td>
				</tr>
				<tr>
					<td>
						Categoria do livro
					</td>
					<td>
						<select id="ddlCategoria" name="ddlCategoria">
							<option ${empty livro ? 'selected' : '' }>Didatico</option>
							<option ${livro.getCategoria() == 'Aventura' ? 'selected' : '' }>Aventura</option>
							<option ${livro.getCategoria() == 'Comedia' ? 'selected' : '' }>Comedia</option>
							<option ${livro.getCategoria() == 'Terror' ? 'selected' : '' }>Terror</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Subcategoria do livro
					</td>
					<td>
						<select id="ddlsCategoria" name="ddlsCategoria">
							<option ${empty livro ? 'selected' : '' }>Matematica</option>
							<option ${livro.getSubcategoria() == 'Fantasia' ? 'selected' : '' }>Fantasia</option>
							<option ${livro.getSubcategoria() == 'Cientifico' ? 'selected' : '' }>Cientifico</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Ano do livro
					</td>
					<td>
						<input type="text"class="form-control" id="txtAno" name="txtAno" value="${empty livro ? '' : livro.getAno()}" />
					</td>
				</tr>
				<tr>
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
				</tr>
				<tr>
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
				</tr>
				<tr>
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
				</tr>
				<tr>
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
				</tr>
				<tr>
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
				</tr>
				<tr>
					<td>
						Preço do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtPreco" name="txtPreco" value="${empty livro ? '' : livro.getPreco()}" />
					</td>
				</tr>
				<tr>
					<td>
						Grupo de precificação
					</td>
					<td>
						<select id="ddlPrecificacao" name="ddlPrecificacao">
							<option value="A" ${empty livro ? 'selected' : '' }>A - 30%</option>
							<option value="B" ${livro.getPrecificacao() == 'B' ? 'selected' : '' }>B - 40%</option>
							<option value="C" ${livro.getPrecificacao() == 'C' ? 'selected' : '' }>C - 50%</option>
							<option value="D" ${livro.getPrecificacao() == 'D' ? 'selected' : '' }>D - 60%</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Valor do livro
					</td>
					<td>
						<input type="text" class="form-control" id="txtValor" name="txtValor" value="${empty livro ? '' : livro.getValor()}" />
					</td>
				</tr>
				<tr>
					<td>
						Responsavel
					</td>
					<td>
						<input type="text" class="form-control" id="txtResponsavel" name="txtResponsavel" value="${empty livro ? '' : livro.getAlterador()}" />
					</td>
				</tr>
			</table>
			<input onclick="Atualizar()" type="submit" class="btn btn-primary" id="operacao" name="operacao" value="${empty livro ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
		</form>
	</body>
</html>