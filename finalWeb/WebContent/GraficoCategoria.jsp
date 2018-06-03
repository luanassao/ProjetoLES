<%@page import="finalCore.util.GeradorDadosGrafico"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*, auxiliar.*"%>
<%
	DadosGrafico dadosGrafico = (DadosGrafico)session.getAttribute("dadosGrafico");
	GeradorDadosGrafico geradorDadosGrafico = new GeradorDadosGrafico();
	String arrayDados = geradorDadosGrafico.gerarDadosGraficoCategoria(dadosGrafico);
%>
<!DOCTYPE html>
<html>
  <head>
  	<script src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" 
    	integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
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
      selectionMode: 'multiple',
      vAxis: {title: 'Unidades'},
      hAxis: {title: 'Mes'},
      seriesType: 'line',
      //series: {5: {type: 'line'}, 6: {type: 'line'}}
    };

    var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
    chart.draw(data, options);
  }
    </script>
<script>
   $(document).ready(function(){
	   $("#divNavBar").load("NavBar.jsp");
   });
</script>
</head>
<body>
	<div id="divNavBar"></div>
  	<form action="GraficoAnalise" method="post" id="frmGrafico">
	  	<div class="row">
		  	<div class="col-lg-3">Data inicial<br><input type="month" class="form-control" id="txtDtInicio" name="txtDtInicio" placeholder="Data de inicio"></div>
		  	<div class="col-lg-1"></div>
		  	<div class="col-lg-3">Data final<br><input type="month" class="form-control" id="txtDtFim" name="txtDtFim" placeholder="Data de fim"></div>
	  		<div class="col-lg-1"></div>
	  		<div class="col-lg-3">
	  			<br>
		  		<button class="btn btn-primary" type="button" data-toggle='modal' data-target='#NomeModal'>
		  			Categorias
		  		</button>
	  		</div>
	  	</div>
	  	<br>
	  	<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR" class="btn btn-default">
			Gerar gráfico
		</button>
		&nbsp&nbsp&nbsp
		<a class="btn btn-primary" href="GraficoGenero.jsp">Gráfico por genero</a>
		<!-- Modal -->
	<div class="modal fade" id="NomeModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Dados do livro</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
              <%
	              	Resultado dado = (Resultado) session.getAttribute("dados");
					List<EntidadeDominio> entidades = dado.getEntidades();
					DadosCadLivro dados = (DadosCadLivro)entidades.get(0);
              		StringBuilder sbRegistro = new StringBuilder();
              		int cont = 0;
              		ArrayList<String> categorias = new ArrayList();
              		for(Categoria categoria:dados.getCategorias())
					{
              			categorias.add(categoria.getNome());
					}
              		Collections.sort(categorias);
              		sbRegistro.append("<div class='row'>");
					for(String categoria:categorias)
					{
						if(cont >= 3) {
							sbRegistro.append("</div>");
							sbRegistro.append("<div class='row'>");
							cont = 0;
						}
						sbRegistro.append("<div class='col-lg-4'>");
						cont ++;
						sbRegistro.append("<input type='checkbox' name='cbCategoria' value='");
						sbRegistro.append(categoria + "'/>");
						sbRegistro.append(categoria);
						sbRegistro.append("</div>");
					}
					sbRegistro.append("</div>");
					out.print(sbRegistro.toString());
              %>
	      </div>
	      <div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal">Confirmar</button>
	      </div>
	    </div>
	  </div>
	</div>
  	</form>
    <div id="chart_div" style="width: 1300px; height: 500px;"></div>
  </body>
</html>