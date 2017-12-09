<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<html>
  <head>
  
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
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
  </body>
</html>