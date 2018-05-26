<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
         ['Mes', 'Terror', 'Aventura', 'Ação', 'Matemática', 'Historia'],
         ['2018/01',  320,      147,         542,             998,           422],
         ['2018/02',  240,      424,         867,             654,           354],
         ['2018/03',  361,      127,         542,             852,           464],
         ['2018/04',  121,      845,         255,             572,           543],
         ['2018/05',  165,      938,         365,             998,           450],
         ['2018/06',  135,      1120,        599,             1268,          288],
         ['2018/07',  157,      1167,        587,             807,           397],
         ['2018/08',  139,      1110,        615,             968,           215],
         ['2018/09',  360,      501,		 412,             754,           942],
         ['2018/10',  114,      239,         456,             354,           551],
         ['2018/11',  120,      900,         450,             968,           215],
         ['2018/12',  136,      691,         629,             1026,          366]
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
	  	<div class="col-lg-3">Data inicial<br><input type="date" class="form-control" id="txtDtInicio" placeholder="Data de inicio"></div>
	  	<div class="col-lg-1"></div>
	  	<div class="col-lg-3">Data final<br><input type="date" class="form-control" id="txtDtFim" placeholder="Data de fim"></div>
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