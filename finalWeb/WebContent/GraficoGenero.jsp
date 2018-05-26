<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);

      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
         ['Mes', 'Homens', 'Mulheres'],
         ['2018/01',  614,		351],
         ['2018/02',  785,		745],
         ['2018/03',  687,		138],
         ['2018/04',  785,		452],
         ['2018/05',  614,		249],
         ['2018/06',  682,		730],
         ['2018/07',  623,		530],
         ['2018/08',  684,		630],
         ['2018/09',  609,		354],
         ['2018/10',  351,		123],
         ['2018/11',  123,		630],
         ['2018/12',  569,		320]
      ]);

    var options = {
      title : 'Livros vendidos por Categoria x Gênero',
      vAxis: {title: 'Unidades'},
      hAxis: {title: 'Mes'},
      seriesType: 'line',
      //series: {1: {type: 'line'}, 2: {type: 'line'}}
    };

    var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }
    </script>
  </head>
  <body>
    <div id="chart_div" style="width: 1300px; height: 500px;"></div>
  </body>
</html>