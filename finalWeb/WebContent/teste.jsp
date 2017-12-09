<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script src="C:/Users/ASSAO/Desktop/HighCharts/code/highcharts.js"></script>
		<title>Highcharts Example</title>

		<style type="text/css">
#container {
	min-width: 310px;
	max-width: 800px;
	height: 400px;
	margin: 0 auto
}
		</style>
	</head>
	<body>
<script src="C:/Users/ASSAO/Desktop/HighCharts/code/highcharts.js"></script>
<script src="C:/Users/ASSAO/Desktop/HighCharts/code/modules/series-label.js"></script>
<script src="C:/Users/ASSAO/Desktop/HighCharts/code/modules/exporting.js"></script>

<div id="container"></div>



		<script type="text/javascript">
		alert("queijo");
		$(function () { 
		    var myChart = Highcharts.chart('container', {
		        chart: {
		            type: 'bar'
		        },
		        title: {
		            text: 'Fruit Consumption'
		        },
		        xAxis: {
		            categories: ['Apples', 'Bananas', 'Oranges']
		        },
		        yAxis: {
		            title: {
		                text: 'Fruit eaten'
		            }
		        },
		        series: [{
		            name: 'Jane',
		            data: [1, 0, 4]
		        }, {
		            name: 'John',
		            data: [5, 7, 3]
		        }]
		    });
		});
		</script>
	</body>
</html>
