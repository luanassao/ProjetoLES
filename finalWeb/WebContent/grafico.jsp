<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
  	<%
		Resultado resultado = (Resultado) session.getAttribute("resultado");
		Cliente usuario = (Cliente) session.getAttribute("usuario");
	%>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">

      <%
		
		StringBuilder sbRegistro = new StringBuilder();
		
      	sbRegistro.append("google.charts.load('current', {'packages':['corechart']});");
      	sbRegistro.append("google.charts.setOnLoadCallback(drawChart);");
		sbRegistro.append("function drawChart() {");
		sbRegistro.append("var data = new google.visualization.DataTable();");
		sbRegistro.append("data.addColumn('string', 'Topping');");
		sbRegistro.append("data.addColumn('number', 'Slices');");
		sbRegistro.append("data.addRows([['Mushrooms', 3],['Onions', 1],['Olives', 1],['Zucchini', 1],['Pepperoni', 2],['queijo', 5]]);");
		sbRegistro.append("var options = {'title':'How Much Pizza I Ate Last Night','width':400,'height':300};");
		sbRegistro.append("var chart = new google.visualization.BarChart(document.getElementById('chart_div'));");
		sbRegistro.append("chart.draw(data, options);");
		sbRegistro.append("}");
		out.print(sbRegistro);
		%>
    </script>
  </head>

  <body>
	<%
	if(usuario != null)
		out.print(usuario.getNome());
	%>
	<form action="SalvarProduto" method="post">
		<table class="table" bordercolor="blue" BORDER="5" >
			<TR>
			      <TH COLSPAN="4"><BR>
			      	<H3>OPÇÕES DE GRÁFICOS</H3>
			      </TH>
	   		</TR>
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
				Codigo do pedido: <input type="text" id="txtId" name="txtId" /> 
				</td>
				<td>
				Codigo do cliente:<input type="text" id="txtIdCliente" name="txtIdCliente" />
				</td>
				<td>
				Email do Cliente <input type="text" id="txtEmail" name="txtEmail"/>
				</td>
				<td>
				Status 
				<select id="ddlStatus" name="ddlStatus">
					<option value="">TODOS</option>
					<option value="EM PROCESSAMENTO">EM PROCESSAMENTO</option>
					<option value="EM TROCA">EM TROCA</option>
					<option value="APROVADO">APROVADO</option>
					<option value="REPROVADO">REPROVADO</option>
					<option value="EM TRANSPORTE">EM TRANSPORTE</option>
					<option value="ENTREGUE">ENTREGUE</option>
				</select>
				</td>
			</tr>
			<tr style="display:none">
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
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
  </body>
</html>