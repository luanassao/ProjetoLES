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
            <button class="btn btn-outline-primary" type="button" data-toggle='modal' data-target='#NomeModal'>Exibir detalhes</button>
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
              <h5>Dados do livro</h5>
            </div>
            <div class="card-body">
              <h6>Dados gerais</h6>
              <hr>
              <div class="row">
	              <div class="col-lg-5">Autor: ${empty livro ? '' : livro.getAutor().getNome()}</div>
	              <div class="col-lg-5">Ano: ${empty livro ? '' : livro.getAno()}</div>
              </div>
              <div class="row">
	              <div class="col-lg-5">Editora: ${empty livro ? '' : livro.getEditora().getNome()}</div>
	              <div class="col-lg-5">Edição: ${empty livro ? '' : livro.getEdicao()}</div>
              </div>
              <hr>
              <h6>Dados Físicos</h6>
              <hr>
              <div class="row">
	              <div class="col-lg-4">Altura: ${empty livro ? '' : livro.getAltura()}</div>
	              <div class="col-lg-4">Largura: ${empty livro ? '' : livro.getLargura()}</div>
	              <div class="col-lg-4">Profundidade: ${empty livro ? '' : livro.getAltura()}</div>
              </div>
              <div class="row">
	              <div class="col-lg-4">Peso: ${empty livro ? '' : livro.getPeso()}</div>
	              <div class="col-lg-4">N. Páginas: ${empty livro ? '' : livro.getNpaginas()}</div>
              </div>
              <hr>
              <form action="SalvarLivro" method="post">
                Quantidade: <input type="number" class="btn btn-outline-dark" name="txtQuantidade" max="${empty livro ? '' : livro.getEstoque()}" min="0">
                <hr>
                <!-- ADICIONAR_AO_CARRINHO -->
              	<button type="submit"  class="btn btn-primary" id="operacao" name="operacao" value="ADICIONAR_AO_CARRINHO">Adicionar ao carrinho</button>
              </form>
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
              <h6>Dados gerais</h6>
              <hr>
              <div class="row">
	              <div class="col-lg-6">Autor: ${empty livro ? '' : livro.getAutor().getNome()}</div>
	              <div class="col-lg-3">Ano: ${empty livro ? '' : livro.getAno()}</div>
	              <div class="col-lg-3">Classe: ${empty livro ? '' : livro.getPrecificacao().getNome()}</div>
              </div>
              <div class="row">
	              <div class="col-lg-5">ISBN/C.Barras: ${empty livro ? '' : livro.getISBN()}</div>
	              <div class="col-lg-4">Editora: ${empty livro ? '' : livro.getEditora().getNome()}</div>
	              <div class="col-lg-3">Edição: ${empty livro ? '' : livro.getEdicao()}</div>
              </div>
              <div class="row">
	              <div class="col-lg-12">Categorias: ${empty livro ? '' : livro.getCategoriasFormatado()}</div>
              </div>
              <hr>
              <h6>Dados Físicos</h6>
              <hr>
              <div class="row">
	              <div class="col-lg-4">Altura: ${empty livro ? '' : livro.getAltura()}</div>
	              <div class="col-lg-4">Largura: ${empty livro ? '' : livro.getLargura()}</div>
	              <div class="col-lg-4">Profundidade: ${empty livro ? '' : livro.getAltura()}</div>
              </div>
              <div class="row">
	              <div class="col-lg-4">Peso: ${empty livro ? '' : livro.getPeso()}</div>
	              <div class="col-lg-4">N. Páginas: ${empty livro ? '' : livro.getNpaginas()}</div>
	              <div class="col-lg-4">Qtde. estoque: ${empty livro ? '' : livro.getEstoque()}</div>
              </div>
	      </div>
	      <div class="modal-footer">
			<button type="button" class="btn btn-primary" data-dismiss="modal">Confirmar</button>
	      </div>
	    </div>
	  </div>
	</div>
	
  </body>

</html>