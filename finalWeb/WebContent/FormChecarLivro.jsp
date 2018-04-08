<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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

    <title>Checar livro</title>

    <!-- Bootstrap core CSS -->
    <link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <script>
   $(document).ready(function(){
	   $("#divNavBar").load("NavBar.jsp");
   });
</script>
</head>
<body>
	<div id="divNavBar"></div>

    <!-- Page Content -->
    <div class="container">

      <div class="row">

        <div class="col-lg-3">
          <h1 class="my-4">lesFinal</h1>
          <div class="list-group">
            <a href="FormCompra.jsp" class="btn btn-outline-primary">Voltar ao catálogo</a>
            <a href="#" class="btn btn-outline-primary">Category 2</a>
            <button href="#" class="btn btn-outline-primary">Category 3</button>
            <button class="btn btn-outline-primary" type="button" data-toggle='modal' data-target='#CategoriaModal'>Adicionar</button>
          </div>
        </div>
        <!-- /.col-lg-3 -->

        <div class="col-lg-9">

          <div class="card mt-4">
            <img class="card-img-top img-fluid" style="width: 500px; height: 500px;" src="http://livresaber.sead.ufscar.br:8080/jspui/bitstream/123456789/1354/2/icone%20livro.jpg" alt="">
            <div class="card-body">
              <h3 class="card-title">${empty livro ? '' : livro.getTitulo()}</h3>
              <h4>R$${empty livro ? '' : livro.getValor()}</h4>
              <p class="card-text">${empty livro ? '' : livro.getSinopse()}</p>
            </div>
          </div>
          <!-- /.card -->

          <div class="card card-outline-secondary my-4">
            <div class="card-header">
              Dados do livro
            </div>
            <div class="card-body">
              <table>
              	<tr>
              		<td>Autor: ${empty livro ? '' : livro.getAutor()}</td>
              		<td>Ano: ${empty livro ? '' : livro.getAno()}</td>
              	</tr>
              	<tr>
              		<td>Editora: ${empty livro ? '' : livro.getEditora().getNome()}</td>
              		<td>Edição: ${empty livro ? '' : livro.getEdicao()}</td>
              	</tr>
              </table>
              <p>Autor: ${empty livro ? '' : livro.getAutor()}</p>
              <small class="text-muted">Posted by Anonymous on 3/1/17</small>
              <hr>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
              <small class="text-muted">Posted by Anonymous on 3/1/17</small>
              <hr>
              <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Omnis et enim aperiam inventore, similique necessitatibus neque non! Doloribus, modi sapiente laboriosam aperiam fugiat laborum. Sequi mollitia, necessitatibus quae sint natus.</p>
              <small class="text-muted">Posted by Anonymous on 3/1/17</small>
              <hr>
              <a href="#" class="btn btn-success">Leave a Review</a>
            </div>
          </div>
          <!-- /.card -->

        </div>
        <!-- /.col-lg-9 -->

      </div>

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; lesFinal 2018</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>