<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
		Resultado resultado = (Resultado) session.getAttribute("resultado");
	%>

	<form action="SalvarCarrinho" method="post">
		<table class="table" bordercolor="blue" BORDER="5" >
		<TR>
		      <TH COLSPAN="3"><BR>
		      	<H3>FILTROS</H3>
		      </TH>
   		</TR>
			<tr>
				<td>
				TITULO: <input type="text" id="txtTitulo" name="txtTitulo" /> 
				</td>
				<td>
				AUTOR:<input type="text" id="txtAutor" name="txtAutor" />
				</td>
				<td>
				Status 
				<select id="rdStatus" name="rdStatus">
					<option value="todos">Todos</option>
					<option value="true">Ativos</option>
					<option value="false">Inativos</option>
				</select>
				</td>
			</tr>
			<tr>
				<td>
				Ano <input type="text" id="txtAno" name="txtAno"/>
				</td>
				<td>
				Editora <input type="text" id="txtEditora" name="txtEditora">
				</td>
				<td>
				ISBN <input type="text" id="txtISBN" name="txtISBN">
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
      	<H3>Carrinhos</H3>
      </TH>
   </TR>
   <TR>
      <TH>Codigo</TH>
      <TH>Comprador</TH>
      <TH>Status</TH>
      <TH>Forma de pagamento</TH>
      <TH>ID do endereço</TH>
      <TH>Valor do frete</TH>
      <TH>Valor dos livros</TH>
      <TH>Valor total</TH>
   </TR>
   
   <%
   if (resultado != null) {
		List<EntidadeDominio> entidades = resultado.getEntidades();
		StringBuilder sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		
		if(entidades != null){
			try{
			for (int i = 0; i < entidades.size(); i++) {
				Carrinho c = (Carrinho) entidades.get(i);
				sbRegistro.setLength(0);
				sbLink.setLength(0);
				
			//	<a href="nome-do-lugar-a-ser-levado">descrição</a>
				
				sbRegistro.append("<TR ALIGN='CENTER'>");
				
				
				sbLink.append("<a id = '");
					sbLink.append(c.getId());
					sbLink.append("' href=SalvarCarrinho?");
					sbLink.append("txtId=");
					sbLink.append(c.getId());						
					sbLink.append("&");
					sbLink.append("operacao=");
					sbLink.append("VISUALIZAR");
					
				sbLink.append(">");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());	
				sbRegistro.append(c.getId() == 0 ? ' ' : c.getId());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");

				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getStatus());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getFormaPagamento());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getIdEndereco());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getFrete());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getValorLivros());
				sbRegistro.append("</a>");				
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(c.getValorTotal());
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
<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormClienteEnd.jsp">Cadastrar livro</a>
</body>
</html>