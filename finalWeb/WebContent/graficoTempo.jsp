<%@page import="finalCore.util.GerarDadosGrafico"%>
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
      	List<EntidadeDominio> entidades = new ArrayList();
      	entidades = resultado.getEntidades();
      	GerarDadosGrafico geradorDados = new GerarDadosGrafico();
      	StringBuilder sbRegistro;
	%>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
    function mostrarBar(){
		document.getElementById('barchart_div').style="";
		document.getElementById('piechart_div').style="display:none";
		document.getElementById('btnBar').style="display:none";
		document.getElementById('btnPie').style="";
	}
	function mostrarPie(){
		document.getElementById('barchart_div').style="display:none";
		document.getElementById('piechart_div').style="";
		document.getElementById('btnBar').style="";
		document.getElementById('btnPie').style="display:none";
	}
      <%
      	String dadosVendaMes = geradorDados.gerarDadosVendaMes(entidades);
      
		sbRegistro = new StringBuilder();
		
      	sbRegistro.append("google.charts.load('current', {'packages':['corechart']});");
      	sbRegistro.append("google.charts.setOnLoadCallback(drawBarChart);");
		sbRegistro.append("function drawBarChart() {");
		sbRegistro.append("var data = new google.visualization.DataTable();");
		sbRegistro.append("data.addColumn('string', 'Topping');");
		sbRegistro.append("data.addColumn('number', 'Unidades');");
		sbRegistro.append("data.addRows([");
		sbRegistro.append(dadosVendaMes);
		sbRegistro.append("]);");
		sbRegistro.append("var options = {'title':'Quantidade de livros vendidos','width':900,'height':800};");
		sbRegistro.append("var chart = new google.visualization.BarChart(document.getElementById('barchart_div'));");
		sbRegistro.append("chart.draw(data, options);");
		sbRegistro.append("}");
		out.print(sbRegistro);
		
		sbRegistro = new StringBuilder();
		
      	sbRegistro.append("google.charts.load('current', {'packages':['corechart']});");
      	sbRegistro.append("google.charts.setOnLoadCallback(drawPieChart);");
		sbRegistro.append("function drawPieChart() {");
		sbRegistro.append("var data = new google.visualization.DataTable();");
		sbRegistro.append("data.addColumn('string', 'Topping');");
		sbRegistro.append("data.addColumn('number', 'Unidades');");
		sbRegistro.append("data.addRows([");
		sbRegistro.append(dadosVendaMes);
		sbRegistro.append("]);");
		sbRegistro.append("var options = {'title':'Quantidade de livros vendidos','width':900,'height':800};");
		sbRegistro.append("var chart = new google.visualization.PieChart(document.getElementById('piechart_div'));");
		sbRegistro.append("chart.draw(data, options);");
		sbRegistro.append("}");
		out.print(sbRegistro);
		%>
    </script>
  </head>

  <body>
	<a href="http://localhost:8080/finalWeb/Index.jsp">Inicio</a>
	<BR>
	<form action="SalvarProduto" method="post" id="frmGrafico">
		<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR" class="btn btn-default">
		Vendas gerais
		</button>
		<input type="hidden" name="tipo" value="geral">
	</form>
	<BR>
	<input id="btnBar" class="btn btn-primary" style="display:none" type="button" onclick="mostrarBar()" value="Barras">
	<input id="btnPie" class="btn btn-primary" style="" type="button" onclick="mostrarPie()" value="Pizza">
    <!--Div that will hold the bar chart-->
    <div style="" id="barchart_div"></div>
    <BR>
    <!--Div that will hold the pie chart-->
    <div style="display:none" id="piechart_div"></div>
  </body>
</html>