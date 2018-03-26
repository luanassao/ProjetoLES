<%@page import="auxiliar.Categoria"%>
<%@page import="auxiliar.Editora"%>
<%@page import="auxiliar.CategoriaInativacao"%>
<%@page import="auxiliar.CategoriaAtivacao"%>
<%@page import="auxiliar.Autor"%>
<%@page import="auxiliar.DadosCadLivro"%>
<%@page import="java.io.IOException"%>
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
<title>Consultar livro</title>
<script type="text/javascript">
 function IdLivroExcluir(id, status) {
	 	document.getElementById("txtId").value = id;
	 	document.getElementById("lblId").innerHTML = id;
	 	document.getElementById("txtAcao").value = status;
	 	
	 	if(status == true)
	 	{
	 		document.getElementById("lblAcao").innerHTML = "Ativar";
	 		document.getElementById("ddlCategoriaAtiv").style = "";
	 		document.getElementById("ddlCategoriaInativ").style = "display:none";
	 	}
	 	else
	 	{
	 		document.getElementById("lblAcao").innerHTML = "Inativar";
	 		document.getElementById("ddlCategoriaAtiv").style = "display:none";
	 		document.getElementById("ddlCategoriaInativ").style = "";
	 	}
	}
</script>
</head>
<body>

	<%
		Resultado resultado = (Resultado) session.getAttribute("resultado");
	%>

	<form action="SalvarLivro" method="post">
		<table class="table" bordercolor="black" BORDER="5" >
		<TR>
		      <TH COLSPAN="3"><BR>
		      	<H3>FILTROS</H3>
		      </TH>
   		</TR>
			<tr>
				<td>
				TITULO: <br>
				<input type="text" class="form-control" id="txtTitulo" name="txtTitulo" /> 
				</td>
				<td>
				AUTOR:<br>
				<select class="btn btn-outline-dark" id="ddlAutor" name="ddlAutor">
					<option>Todos</option>
							<%
								Resultado dado = (Resultado) session.getAttribute("dados");
								List<EntidadeDominio> entidades = dado.getEntidades();
							
								DadosCadLivro dados = (DadosCadLivro)entidades.get(0);
								StringBuilder sbRegistro;
								sbRegistro = new StringBuilder();
								for(Autor autor:dados.getAutores())
								{
									sbRegistro.append("<option value='");
									sbRegistro.append(autor.getId() + "'>");
									sbRegistro.append(autor.getNome());
									sbRegistro.append("</option>");
								}
								out.print(sbRegistro.toString());
							%>
						</select>
				</td>
				<td>
				Status <br>
				<div class="btn-group btn-group-toggle" data-toggle="buttons">
				  <label class="btn btn-outline-dark">
				    <input type="radio" name="rdStatus" id="rdStatus" value="todos" autocomplete="off"> Todos
				  </label>
				  <label class="btn btn-outline-dark">
				    <input type="radio" name="rdStatus" id="rdStatus" value="true" autocomplete="off"> Ativos
				  </label>
				  <label class="btn btn-outline-dark">
				    <input type="radio" name="rdStatus" id="rdStatus" value="false" autocomplete="off"> Inativos
				  </label>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				Ano <br>
				<input type="text" class="form-control" id="txtAno" name="txtAno"/>
				</td>
				<td>
				Editora <br>
				<select class="btn btn-outline-dark" id="ddlEditora" name="ddlEditora">
					<option>Todos</option>
							<%
								sbRegistro = new StringBuilder();
								for(Editora editora:dados.getEditoras())
								{
									sbRegistro.append("<option value='");
									sbRegistro.append(editora.getId() + "'>");
									sbRegistro.append(editora.getNome());
									sbRegistro.append("</option>");
								}
								out.print(sbRegistro.toString());
							%>
						</select>
				</td>
				<td>
				ISBN <br>
				<input type="text" class="form-control" id="txtISBN" name="txtISBN">
				</td>
			</tr>
			<tr>
				<td>
				Categoria <br>
				<select class="btn btn-outline-dark" id="hdCategorias" name="hdCategorias">
					<option>Todos</option>
					<%
						sbRegistro = new StringBuilder();
						for(Categoria categoria:dados.getCategorias())
						{
							sbRegistro.append("<option value='");
							sbRegistro.append(categoria.getId() + "'>");
							sbRegistro.append(categoria.getNome());
							sbRegistro.append("</option>");
						}
						out.print(sbRegistro.toString());
					%>
				</select>
				</td>
				<td>
				Preço mínimo: <br>
				<input type="text" class="form-control" id="txtPreco" name="txtPreco" />
				</td>
				<td>
				Preço máximo: <br>
				<input type="text" class="form-control" id="txtValor" name="txtValor" />
				</td>
			</tr>
		</table>
		<br><input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR" />
	</form>

	


	<%
	
	if(resultado !=null && resultado.getMsg() != null){
		out.print(resultado.getMsg());
	}
	
	%>
<BR>

<TABLE class="table table-sm" bordercolor="blue" BORDER="5"    WIDTH="50%"   CELLPADDING="4" CELLSPACING="3">
   <TR>
      <TH COLSPAN="17"><BR>
      	<H3>Livros</H3>
      </TH>
   </TR>
   <TR>
      <TH>Codigo</TH>
      <TH>Titulo</TH>
      <TH>Autor</TH>
      <TH>Valor</TH>
      <TH>Status</TH>
      <TH>Ano</TH>
      <TH>Editora</TH>
      <TH>Edicao</TH>
      <TH>ISBN</TH>
      <TH>Alterador</TH>
      <TH>-</TH>
   </TR>
   
   <%
   if (resultado != null) {
		entidades = resultado.getEntidades();
		sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		
		if(entidades != null){
			try
			{
			for (int i = 0; i < entidades.size(); i++) {
				Livro l = (Livro) entidades.get(i);
				sbRegistro.setLength(0);
				sbLink.setLength(0);
				
			//	<a href="nome-do-lugar-a-ser-levado">descrição</a>
				
				sbRegistro.append("<TR ALIGN='CENTER'>");
				
				
				sbLink.append("<a href=SalvarLivro?");
					sbLink.append("txtId=");
					sbLink.append(l.getId());						
					sbLink.append("&");
					sbLink.append("operacao=");
					sbLink.append("VISUALIZAR");
					
				sbLink.append(">");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());	
				sbRegistro.append(l.getId() == 0 ? ' ' : l.getId());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());			
				sbRegistro.append(l.getTitulo());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(l.getAutor().getNome());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(l.getValor());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(l.getStatus() == true ? "Ativo" : "Inativo");
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(l.getAno());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(l.getEditora().getNome());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(l.getEdicao());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(l.getISBN());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(l.getAlterador().getEmail());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");

				sbRegistro.append("<TD>");
				sbRegistro.append("<button type='button' class='btn btn-primary' data-toggle='modal' data-target='#MotivoModal'" +
					"onclick='IdLivroExcluir(" + l.getId() + "," + !l.getStatus() + ")'>" + (l.getStatus() ? "Inativar" : "Ativar") + "</button>");
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
<form action="SalvarLivro" method="post">
	<!-- Modal -->
	<div class="modal fade" id="MotivoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Desativar livro</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
			Código do livro:
			<label id="lblId"></label>
			<input type="hidden" id="txtId" name="txtId" value="0">
			<input type="hidden" id="txtAcao" name="txtAcao" value=false>
			<br><br>
			<select class="btn btn-outline-dark" id="ddlCategoriaAtiv" name="ddlCategoriaAtiv">
				<%
					sbRegistro = new StringBuilder();
					for(CategoriaAtivacao catA:dados.getCategoriasAtivacao())
					{
						sbRegistro.append("<option value='");
						sbRegistro.append(catA.getId() + "'>");
						sbRegistro.append(catA.getNome());
						sbRegistro.append("</option>");
					}
					out.print(sbRegistro.toString());
				%>
			</select>
			<select class="btn btn-outline-dark" id="ddlCategoriaInativ" name="ddlCategoriaInativ">
				<%
					sbRegistro = new StringBuilder();
					for(CategoriaInativacao catI:dados.getCategoriasInativacao())
					{
						sbRegistro.append("<option value='");
						sbRegistro.append(catI.getId() + "'>");
						sbRegistro.append(catI.getNome());
						sbRegistro.append("</option>");
					}
					out.print(sbRegistro.toString());
				%>
			</select>
			<br><br>
			Motivo:
			<input type="text" id="txtMotivo" name="txtMotivo"/>
	      </div>
	      <div class="modal-footer">
	      	<button type="submit" class="btn btn-primary" name="operacao" value="EXCLUIR"><label id="lblAcao"></label> </button>
	      </div>
	    </div>
	  </div>
	</div>
</form>
<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormLivro.jsp">Cadastrar livro</a>
</body>
</html>