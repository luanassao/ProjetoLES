<%@page import="auxiliar.Categoria"%>
<%@page import="auxiliar.Precificacao"%>
<%@page import="auxiliar.Editora"%>
<%@page import="auxiliar.Autor"%>
<%@page import="auxiliar.DadosCadLivro"%>
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
		<title>Cadastro de livros</title>
		<script type="text/javascript">
			function adcCategoria(id, nome) {
				document.getElementById("btn" + id).disabled = true;
				if(document.getElementById("txtCategorias").value == "")
				{
					document.getElementById("txtCategorias").value = nome;
					document.getElementById("txtCatAtuais").value = nome;
				}
				else
				{
					document.getElementById("txtCategorias").value += ", " + nome;
					document.getElementById("txtCatAtuais").value += ", " + nome;
				}
				document.getElementById("hdCategorias").value += id + " ";
			}
			function Atualizar() {
				if(document.getElementById("txtTitulo").value == '' || document.getElementById("txtAno").value == ''
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
		<%
			Resultado resultado = (Resultado) session.getAttribute("dados");
			Livro livro = (Livro) session.getAttribute("livro");
			List<EntidadeDominio> entidades = resultado.getEntidades();

			DadosCadLivro dados = (DadosCadLivro)entidades.get(0);
			StringBuilder sbRegistro;
		%>
		<form action="SalvarLivro" method="post" id="frmSalvarLivro">
			<table  class="table" bordercolor="black" BORDER="5">
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
						<input type="text"class="form-control" id="txtTitulo" name="txtTitulo" value="${empty livro ? '' : livro.getTitulo()}" />
					</td>
					<td>
						Autor do livro
						<br>
						<select class="btn btn-outline-dark" id="ddlAutor" name="ddlAutor">
							<%
								boolean testes = false;
								sbRegistro = new StringBuilder();
								for(Autor autor:dados.getAutores())
								{
									try{
										testes = (livro.getAutor().getId() == autor.getId() ? true : false);
									}catch(Exception e){
										
									}
									sbRegistro.append("<option value='");
									sbRegistro.append(autor.getId() + "'" + (testes ? "selected" : "") + ">");
									sbRegistro.append(autor.getNome());
									sbRegistro.append("</option>");
								}
								out.print(sbRegistro.toString());
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Status do livro
						<br>
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
						  <label class="btn btn-outline-dark">
						    <input type="radio" name="rdStatus" id="rdStatus" value="true" autocomplete="off" checked> Ativo
						  </label>
						  <label class="btn btn-outline-dark">
						    <input type="radio" name="rdStatus" id="rdStatus" value="false" autocomplete="off"> Inativo
						  </label>
						</div>
					</td>
					<td>
						Ano do livro
						<input type="text"class="form-control" id="txtAno" name="txtAno" value="${empty livro ? '' : livro.getAno()}" />
					</td>
				</tr>
				<tr>
					<td>
						Categorias do livro
					</td>
					<td>
						<div class="input-group mb-3">
						  <input type="text" class="form-control" id="txtCategorias" name="txtCategorias" placeholder="Adicione alguma categoria"
						  <%
								sbRegistro = new StringBuilder();
						  	int ultimo;
						  	try{
								ultimo = livro.getCategorias().size();
								for(Categoria c:livro.getCategorias())
								{
									if(!c.equals(livro.getCategorias().get(ultimo-1)))
									{
										sbRegistro.append(c.getNome() + ", ");
									}
									else
									{
										sbRegistro.append(c.getNome());
									}
								}
								out.print("value='" + sbRegistro.toString() + "'");
						  	}catch(Exception e){
						  		
						  	}
							%>
							>
						  <div class="input-group-append">
						    <button class="btn btn-outline-secondary" type="button" data-toggle='modal' data-target='#CategoriaModal'>Adicionar</button>
						  </div>
						</div>
						<input type="hidden" id="hdCategorias" name="hdCategorias"
						<%
							try{
								sbRegistro = new StringBuilder();
								ultimo = livro.getCategorias().size();
								for(Categoria c:livro.getCategorias())
								{
									if(!c.equals(livro.getCategorias().get(ultimo-1)))
									{
										sbRegistro.append(c.getId() + " ");
									}
									else
									{
										sbRegistro.append(c.getId());
									}
								}
								out.print("value='" + sbRegistro.toString() + "'");
							}catch(Exception e){
								
							}
							%>
							>
					</td>
				</tr>
				<tr>
					<td>
						Editora do livro
					<br>
						<select class="btn btn-outline-dark" id="ddlEditora" name="ddlEditora">
							<%
								testes = false;
								sbRegistro = new StringBuilder();
								for(Editora editora:dados.getEditoras())
								{
									try{
										testes = (livro.getEditora().getId() == editora.getId() ? true : false);
									}catch(Exception e){
										
									}
									sbRegistro.append("<option value='");
									sbRegistro.append(editora.getId() + "'" + (testes ? "selected" : "") + ">");
									sbRegistro.append(editora.getNome());
									sbRegistro.append("</option>");
								}
								out.print(sbRegistro.toString());
							%>
						</select>
					</td>
					<td>
						Edição do livro
					<br>
						<input type="text"class="form-control" id="txtEdicao" name="txtEdicao" value="${empty livro ? '' : livro.getEdicao()}" />
					</td>
				</tr>
				<tr>
					<td>
						ISBN do livro
					<br>
						<input type="text"class="form-control" id="txtISBN" name="txtISBN" value="${empty livro ? '' : livro.getISBN()}" />
					</td>
					<td>
						Número de páginas do livro
					<br>
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
						<input type="text" class="form-control" id="txtAltura" name="txtAltura" value="${empty livro ? '' : livro.getAltura()}" />
					</td>
					<td>
						Largura do livro
						<input type="text" class="form-control" id="txtLargura" name="txtLargura" value="${empty livro ? '' : livro.getLargura()}" />
					</td>
				</tr>
				<tr>
					<td>
						Peso do livro
						<input type="text" class="form-control" id="txtPeso" name="txtPeso" value="${empty livro ? '' : livro.getPeso()}" />
					</td>
					<td>
						Profundidade do livro
						<input type="text" class="form-control" id="txtProfundidade" name="txtProfundidade" value="${empty livro ? '' : livro.getProfundidade()}" />
					</td>
				</tr>
				<tr>
					<td>
						Quantidade em estoque
					<br>
						<input type="text" class="form-control" id="txtEstoque" name="txtEstoque" value="${empty livro ? '' : livro.getEstoque()}" />
					</td>
					<td>
						Preço do livro
					<br>
						<input type="text" class="form-control" id="txtPreco" name="txtPreco" value="${empty livro ? '' : livro.getPreco()}" />
					</td>
				</tr>
				<tr>
					<td>
						Grupo de precificação
					<br>
						<select class="btn btn-outline-dark" id="ddlPrecificacao" name="ddlPrecificacao">
							<%
								testes = false;
								sbRegistro = new StringBuilder();
								for(Precificacao precificacao:dados.getPrecificacoes())
								{
									try{
										testes = (livro.getPrecificacao().getId() == precificacao.getId() ? true : false);
									}catch(Exception e){
										
									}
									sbRegistro.append("<option value='");
									sbRegistro.append(precificacao.getId() + "'" + (testes ? "selected" : "") + ">");
									sbRegistro.append(precificacao.getNome() + " - " + precificacao.getMargem() + "%");
									sbRegistro.append("</option>");
								}
								out.print(sbRegistro.toString());
							%>
						</select>
					</td>
					<td>
						Valor do livro
					<br>
						<input type="text" class="form-control" id="txtValor" name="txtValor" value="${empty livro ? '' : livro.getValor()}" />
					</td>
				</tr>
				<tr>
					<td>
						Responsavel
					</td>
					<td>
						<input type="text" class="form-control" id="txtResponsavel" name="txtResponsavel" value="${empty livro ? '' : livro.getAlterador().getId()}" />
					</td>
				</tr>
			</table>
			<input onclick="Atualizar()" type="submit" class="btn btn-primary" id="operacao" name="operacao" value="${empty livro ? 'SALVAR' : 'ALTERAR'}" class="btn btn-default" />
		</form>
		<!-- Modal -->
		<div class="modal fade" id="CategoriaModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Adicionar categorias</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
				Clique no + para adicionar uma categoria
				<br>
				<input type="text" class="form-control" id="txtCatAtuais" placeholder="Adicione alguma categoria"
				<%
					try{
					sbRegistro = new StringBuilder();
					ultimo = livro.getCategorias().size();
					for(Categoria c:livro.getCategorias())
					{
						if(!c.equals(livro.getCategorias().get(ultimo-1)))
						{
							sbRegistro.append(c.getNome() + ", ");
						}
						else
						{
							sbRegistro.append(c.getNome());
						}
					}
					out.print("value='" + sbRegistro.toString() + "'");
					}catch(Exception e){
						
					}
				%>
				>
		      <br>
		      <table class="table" align="center">
		      	<%
					sbRegistro = new StringBuilder();
					for(Categoria categoria:dados.getCategorias())
					{
						testes = false;
						try{
							for(Categoria c:livro.getCategorias())
							{
								if(categoria.getId() == c.getId())
									testes = true;
							}
						}catch(Exception e){
							
						}
						sbRegistro.append("<tr><td>");
						sbRegistro.append(categoria.getNome());
						sbRegistro.append("</td><td>");
						sbRegistro.append("<button type='button' class='btn btn-primary' onclick='adcCategoria(`");
						sbRegistro.append(categoria.getId() + "`,`" + categoria.getNome() + "`)' id='btn" + categoria.getId() + "'"
								+ (testes ? "disabled" : "") + ">");
						sbRegistro.append("+");
						sbRegistro.append("</button>");
						sbRegistro.append("</td>");
					}
					out.print(sbRegistro.toString());
				%>
				</table>
		      </div>
		      <div class="modal-footer">
		      	<button type="button" class="btn btn-success" data-dismiss="modal">Confirmar</button>
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
		      </div>
		    </div>
		  </div>
		</div>
	</body>
</html>