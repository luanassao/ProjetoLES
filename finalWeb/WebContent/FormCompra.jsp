<%@page import="auxiliar.*"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html>
<html>

  <head>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Comprar livro</title>

    <!-- Bootstrap core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <script>
   $(document).ready(function(){
	   $("#divNavBar").load("NavBar.jsp");
   });
</script>
</head>
<body>
	<%
		@SuppressWarnings("unchecked")
		ArrayList<EntidadeDominio> livros = (ArrayList<EntidadeDominio>)session.getAttribute("livros");
		
	%>
	<div id="divNavBar"></div>

    <!-- Page Content -->
    <div class="container">

      <div class="row">

        <div class="col-lg-3">

          <h1 class="my-4">lesFinal</h1>
          <form action="SalvarLivro" method="post">
	          <div class="list-group">
	          	<input type="text" class="btn btn-outline-dark" id="txtTitulo" name="txtTitulo" placeholder="Titulo"/>
	          	<select class="btn btn-outline-dark" id="ddlAutor" name="ddlAutor">
					<option>Todos os autores</option>
					<%
						Resultado dado = (Resultado) session.getAttribute("dados");
						List<EntidadeDominio> entidades = dado.getEntidades();
					
						DadosCadLivro dados = (DadosCadLivro)entidades.get(0);
						StringBuilder sbRegistro;
						sbRegistro = new StringBuilder();
						for(Autor autor:dados.getAutores())
						{
							sbRegistro.append("<option value='");
							sbRegistro.append(autor.getId() + "'>");
							sbRegistro.append(autor.getNome());
							sbRegistro.append("</option>");
						}
						out.print(sbRegistro.toString());
					%>
				</select>
				<input type="text" class="btn btn-outline-dark" id="txtAno" name="txtAno" placeholder="Ano do livro"/>
				<select class="btn btn-outline-dark" id="ddlEditora" name="ddlEditora">
					<option>Todos</option>
					<%
						sbRegistro = new StringBuilder();
						for(Editora editora:dados.getEditoras())
						{
							sbRegistro.append("<option value='");
							sbRegistro.append(editora.getId() + "'>");
							sbRegistro.append(editora.getNome());
							sbRegistro.append("</option>");
						}
						out.print(sbRegistro.toString());
					%>
				</select>			
				<input type="text" class="btn btn-outline-dark"  id="txtISBN" name="txtISBN" placeholder="isbn/Cod.barras">			
				<select class="btn btn-outline-dark" id="hdCategorias" name="hdCategorias">
					<option>Todos</option>
					<%
						sbRegistro = new StringBuilder();
						for(Categoria categoria:dados.getCategorias())
						{
							sbRegistro.append("<option value='");
							sbRegistro.append(categoria.getId() + "'>");
							sbRegistro.append(categoria.getNome());
							sbRegistro.append("</option>");
						}
						out.print(sbRegistro.toString());
					%>
				</select>
				<input type="text" class="btn btn-outline-dark" id="txtPreco" name="txtPreco" placeholder="Preço mínimo"/>
				<input type="text" class="btn btn-outline-dark" id="txtValor" name="txtValor" placeholder="Preço máximo"/>
	          	<div class="btn-group btn-group-toggle" data-toggle="buttons">
				  <label class="btn btn-outline-dark" style="float:left;display:block;width:85px">
				    <input type="radio" name="rdStatus" id="rdStatus" value="todos" autocomplete="off"> Todos
				  </label>
				  <label class="btn btn-outline-dark" style="float:left;display:block;width:85px">
				    <input type="radio" name="rdStatus" id="rdStatus" value="true" autocomplete="off"> Ativos
				  </label>
				  <label class="btn btn-outline-dark" style="float:left;display:block;width:95px">
				    <input type="radio" name="rdStatus" id="rdStatus" value="false" autocomplete="off"> Inativos
				  </label>
				</div>
				<br><input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR" />
	          </div>
		  </form>

        </div>
        <!-- /.col-lg-3 -->

        <div class="col-lg-9">

          <div id="carouselExampleIndicators" class="carousel slide my-4" data-ride="carousel">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
              <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner" role="listbox">
              <div class="carousel-item active">
                <img class="d-block img-fluid" src="http://placehold.it/900x350" alt="First slide">
              </div>
              <div class="carousel-item">
                <img class="d-block img-fluid" src="http://placehold.it/900x350" alt="Second slide">
              </div>
              <div class="carousel-item">
                <img class="d-block img-fluid" src="http://placehold.it/900x350" alt="Third slide">
              </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
            </a>
          </div>

          <div class="row">
          
          <%
          	for(EntidadeDominio l:livros)
          	{
          		Livro livro = (Livro) l;
          		
		  	  	StringBuilder sbLink = new StringBuilder();
		  	  	sbLink.append("<a href=SalvarLivro?");
				sbLink.append("txtId=");
				sbLink.append(livro.getId());						
				sbLink.append("&");
				sbLink.append("operacao=");
				sbLink.append("VISUALIZAR");
				sbLink.append(">");
				
		   		sbRegistro = new StringBuilder();
		   		sbRegistro.append("<div class='col-lg-4 col-md-6 mb-4'>");
		   		sbRegistro.append("<div class='card h-100'>");
		   		sbRegistro.append(sbLink.toString());
		   		sbRegistro.append("<img class='card-img-top' src='http://placehold.it/700x400' alt=''></a>");
		   		sbRegistro.append("<div class='card-body'>");
		   		sbRegistro.append("<h4 class='card-title'>");
		   		sbRegistro.append(sbLink.toString());
		   		sbRegistro.append(livro.getTitulo());
		   		sbRegistro.append("</a>");
		   		sbRegistro.append("<h5>R$" + String.format("%.2f", livro.getValor()) + "</h5>");
		   		sbRegistro.append("<p class='card-text'>" + livro.getSinopse() + "</p>");
		   		sbRegistro.append("</div></div></div>");
		   		
		   		out.print(sbRegistro.toString());
			}
          %>
            <div class='col-lg-4 col-md-6 mb-4'>
              <div class='card h-100'>
                <a href='#'><img class='card-img-top' src='http://placehold.it/700x400' alt=''></a>
                <div class='card-body'>
                  <h4 class='card-title'>
                    <a href='#'>Item One</a>
                  </h4>
                  <h5>$24.99</h5>
                  <p class='card-text'>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
                </div>
              </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
              <div class="card h-100">
                <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                <div class="card-body">
                  <h4 class="card-title">
                    <a href="#">Item Two</a>
                  </h4>
                  <h5>$24.99</h5>
                  <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur! Lorem ipsum dolor sit amet.</p>
                </div>
                <div class="card-footer">
                  <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6 mb-4">
              <div class="card h-100">
                <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                <div class="card-body">
                  <h4 class="card-title">
                    <a href="#">Item Three</a>
                  </h4>
                  <h5>$24.99</h5>
                  <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
                </div>
                <div class="card-footer">
                  <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6 mb-4">
              <div class="card h-100">
                <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                <div class="card-body">
                  <h4 class="card-title">
                    <a href="#">Item Four</a>
                  </h4>
                  <h5>$24.99</h5>
                  <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
                </div>
                <div class="card-footer">
                  <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6 mb-4">
              <div class="card h-100">
                <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                <div class="card-body">
                  <h4 class="card-title">
                    <a href="#">Item Five</a>
                  </h4>
                  <h5>$24.99</h5>
                  <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur! Lorem ipsum dolor sit amet.</p>
                </div>
                <div class="card-footer">
                  <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-md-6 mb-4">
              <div class="card h-100">
                <a href="#"><img class="card-img-top" src="http://placehold.it/700x400" alt=""></a>
                <div class="card-body">
                  <h4 class="card-title">
                    <a href="#">Item Six</a>
                  </h4>
                  <h5>$24.99</h5>
                  <p class="card-text">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Amet numquam aspernatur!</p>
                </div>
                <div class="card-footer">
                  <small class="text-muted">&#9733; &#9733; &#9733; &#9733; &#9734;</small>
                </div>
              </div>
            </div>

          </div>
          <!-- /.row -->

        </div>
        <!-- /.col-lg-9 -->

      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; lesFinal 2017</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="resouces/vendor/jquery/jquery.min.js"></script>
    <script src="resouces/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
