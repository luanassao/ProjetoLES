<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <a class="navbar-brand" href="#">lesFinal</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="Index.jsp">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="DadosLivro?operacao=CONSULTAR&target=FormLivro.jsp">Cadastrar livro</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Livros
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="DadosLivro?operacao=CONSULTAR&target=FormLivro.jsp">Cadastrar livro</a>
          <a class="dropdown-item" href="DadosLivro?operacao=CONSULTAR&target=FormConsultaLivro.jsp">Consultar livros</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Clientes
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="DadosLivro?operacao=CONSULTAR&target=FormClienteEnd.jsp">Cadastrar cliente</a>
          <a class="dropdown-item" href="DadosLivro?operacao=CONSULTAR&target=FormConsultaCliente.jsp">Consultar clientes</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
    </ul>
    <ul class="navbar-nav ml-auto">
       <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          ${empty usuario ? '' : usuario.getNome()}
        </a>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="FormClienteEnd.jsp" onclick="<%session.setAttribute("aba", "abaCliente");%>">Meus Dados</a>
          <a class="dropdown-item" href="SalvarEndereco?operacao=CONSULTAR">Meus Endereços</a>
          <a class="dropdown-item" href="SalvarCartao?operacao=CONSULTAR">Meus Cartões</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" data-toggle="modal" href="" data-target="#ModalAlterarSenha">Alterar senha</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" data-toggle="modal" href="" data-target="#ModalInativar">Inativar meu cadastro</a>
          <div class="dropdown-divider"></div>
          <a id="ddlDeslogar" class="dropdown-item" href="FormLogin.jsp">Deslogar</a>
        </div>
      </li>
    </ul>
  </div>
</nav>
<!-- Modal -->
<div class="modal fade" id="ModalInativar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">EXCLUIR CADASTRO</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		DESEJA REALMENTE EXCLUIR SEU CADASTRO?
		<hr>
		Esta é uma operação sem volta, caso você clique em confirmar sua conta será permanentemente inativada.
		<hr>
		Caso queira reativar a conta, será necessario entrar em contato com um administrador.
		<hr>
		Obs. O administrador nao terá obrigação nenhuma de reativar a conta
      </div>
      <div class="modal-footer">
      	Confirmar exclusão de conta?
      	<a class="btn btn-success" href="SalvarCliente?operacao=EXCLUIR">Confirmar</a>
      	<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="ModalAlterarSenha" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">ALTERAR SENHA</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
		<script type="text/javascript">
			function validarSenha(){
			   senha = document.getElementById('txtSenha').value;
			   senha2 = document.getElementById('txtSenha2').value;
			
			   if(senha!= senha2) {
				   document.getElementById('txtSenha2').setCustomValidity("Senhas diferentes!");
				   return true; 
			   }
			   else{
				   return false; 
			   }
			}
		</script>
		<form action="SalvarCliente" method="post">
	      <div class="modal-body">
				Senha
				<br>
				<input type="password"class="form-control" id="txtSenha" name="txtSenha" required="required"/>
				Confirme a senha
				<br>
				<input type="password"class="form-control" id="txtSenha2" name="txtSenha2" required="required"/>
	      </div>
	      <div class="modal-footer">
				<button type="button" class="btn btn-primary" value="ALTERAR" onclick="return validarSenha()">Alterar senha</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
	      </div>
		</form>
    </div>
  </div>
</div>
</body>
</html>