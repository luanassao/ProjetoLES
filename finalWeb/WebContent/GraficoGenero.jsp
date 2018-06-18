<%@page import="finalCore.util.GeradorDadosGrafico"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*, auxiliar.*"%>
<%
	DadosGrafico dadosGrafico = (DadosGrafico)session.getAttribute("dadosGrafico");
	GeradorDadosGrafico geradorDadosGrafico = new GeradorDadosGrafico();
	String arrayDados = geradorDadosGrafico.gerarDadosGraficoGenero(dadosGrafico);
%>
<!DOCTYPE html>
<html>
  <head>
  	<script src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
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
      title : 'Livros vendidos por genero x Tempo',
      vAxis: {title: 'Unidades'},
      hAxis: {title: 'Mes'},
      seriesType: 'line',
      //series: {5: {type: 'line'}, 6: {type: 'line'}}
    };

    var chart = new google.visualization.ComboChart(document.getElementById('chartG_div'));
    chart.draw(data, options);
  }
    </script>
</head>
<body>
    <div id="chartG_div" style="width: 1300px; height: 500px;"></div>
  </body>
</html>