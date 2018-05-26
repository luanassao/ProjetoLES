<%@page import="finalCore.util.GeradorDadosGrafico"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*, auxiliar.*"%>
<%
	DadosGrafico dadosGrafico = (DadosGrafico)session.getAttribute("dadosGrafico");
	GeradorDadosGrafico geradorDadosGrafico = new GeradorDadosGrafico();
	String arrayDados = geradorDadosGrafico.gerarDadosGrafico(dadosGrafico);
%>
<!DOCTYPE html>
<html>
  <head>
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" 
	  	integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" 
	  	crossorigin="anonymous">
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" 
	  	integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" 
	  	crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);

      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
         <%
         	out.print(arrayDados);
         %>
      ]);

    var options = {
      title : 'Livros vendidos por Categoria x Tempo',
      vAxis: {title: 'Unidades'},
      hAxis: {title: 'Mes'},
      seriesType: 'line',
      //series: {5: {type: 'line'}, 6: {type: 'line'}}
    };

    var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }
    </script>
  </head>
  <body>
  	<div class="row">
	  	<div class="col-lg-3">Data inicial<br><input type="month" class="form-control" id="txtDtInicio" placeholder="Data de inicio"></div>
	  	<div class="col-lg-1"></div>
	  	<div class="col-lg-3">Data final<br><input type="month" class="form-control" id="txtDtFim" placeholder="Data de fim"></div>
  	</div>
  	<br>
  	<div class="row">
  		<div class="col-lg-12">
  		<input type="checkbox"/>Terror|<input type="checkbox"/>Aventura|<input type="checkbox"/>Ação|<input type="checkbox"/>Matemática|<input type="checkbox"/>Historia
  		</div>
  	</div>
    <div id="chart_div" style="width: 1300px; height: 500px;"></div>
  </body>
</html>