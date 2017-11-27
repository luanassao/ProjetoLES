<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Comprar livro</title>
<script>
	function atualizar(id, preco, maximo) {
		var quantidade = document.getElementById("txtQtde" + id).value;
		if(quantidade > maximo)
		{
			document.getElementById("txtQtde" + id).value = maximo;
			quantidade = maximo;
		}
		document.getElementById("txtQtdeH" + id).value = quantidade;
		document.getElementById("txtPreco" + id).value = quantidade*preco;
	}
</script>
</head>
<body>

	<%
		Resultado resultado = (Resultado) session.getAttribute("resultado");
		Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
		Cliente usuario = (Cliente) session.getAttribute("usuario");
		Livro livro = (Livro) session.getAttribute("livro");
		if(usuario != null)
			out.print(usuario.getNome());
	%>
	<%
	
	if(resultado !=null && resultado.getMsg() != null){
		out.print(resultado.getMsg());
	}
	
	%>
<BR>

<TABLE class="table table-sm" bordercolor="blue" BORDER="5"    WIDTH="50%"   CELLPADDING="4" CELLSPACING="3">
   <TR>
      <TH COLSPAN="17"><BR>
      	<H3><img src='https://image.freepik.com/icones-gratis/carrinho-de-compras-de-design-de-linhas-horizontais_318-50800.jpg' style='width: 50px; height: 50px;' alt='First slide'>Carrinho</H3>
      </TH>
   </TR>
   <TR>
   	  <TH>#</TH>
      <TH>Titulo</TH>
      <TH>Preço unitário</TH>
      <TH>Quantidade</TH>
      <TH>SubTotal</TH>
   </TR>
   
   <%
   if (carrinho != null) {
		StringBuilder sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		
		if(carrinho.getProdutos().size() > 0){
			try
			{
			for (Produto p : carrinho.getProdutos()) {
				sbRegistro.setLength(0);
				sbLink.setLength(0);
				
			//	<a href="nome-do-lugar-a-ser-levado">descrição</a>
				
				sbRegistro.append("<TR ALIGN='CENTER'>");
				
				sbRegistro.append("<TD><img src='http://livresaber.sead.ufscar.br:8080/jspui/bitstream/123456789/1354/2/icone%20livro.jpg' style='width: 50px; height: 50px;' alt='First slide'></TD>");
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());	
				sbRegistro.append(p.getLivro().getTitulo());	
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());				
				sbRegistro.append(p.getLivro().getValor());			
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());
				sbRegistro.append("<form action='SalvarProduto' method='post' id='frmSalvarLivro'>");
				sbRegistro.append("<input type='number' id='txtQtde" + p.getLivro().getId() + "' name='txtQtde'");
				sbRegistro.append("value='" + p.getQuantidade() + "'");
				sbRegistro.append("onchange='this.form.submit()'");
				sbRegistro.append("onload='atualizar(" + p.getLivro().getId() + "," + p.getLivro().getValor() + "," + p.getLivro().getEstoque() + ")'");
				sbRegistro.append("max='" + p.getLivro().getEstoque() + "'/>");
				sbRegistro.append("<input type='hidden' name='txtIdLivro' value='" + p.getLivro().getId() + "'>");
				sbRegistro.append("<input type='hidden' name='operacao' value='ATUALIZAR'>");
				sbRegistro.append("</form>");
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());
				sbRegistro.append("<input type='number' id='txtPreco" + p.getLivro().getId() + "' name='txtPreco" + p.getLivro().getId() + "' readonly='readonly'");
				sbRegistro.append(p.getPreco());
				sbRegistro.append("</TD>");
				
				sbRegistro.append("</TR>");
				
				out.print(sbRegistro.toString());
				
			}
			}catch(Exception e){
				
			}
		}
	}
   %>
</TABLE>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Endereço de entrega
		</TH>
		<TH>
		Frete
		</TH>
		<TH>
		Total
		</TH>
	</TR>
	<TR>
		<TD>
		${empty enderecoEntrega ? '' : enderecoEntrega.getLogradouro()} , ${empty enderecoEntrega ? '' : enderecoEntrega.getNumero()}
		<BR>
		${empty enderecoEntrega ? '' : enderecoEntrega.getBairro()} - ${empty enderecoEntrega ? '' : enderecoEntrega.getCidade()} -
		${empty enderecoEntrega ? '' : enderecoEntrega.getEstado()}
		</TD>
		<TD>
		${empty carrinho? '' : carrinho.getFrete()}
		</TD>
		<TD>
		${empty carrinho? '' : carrinho.getValorTotal()}
		</TD>
	</TR>
</TABLE>
<BR>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#enderecoModal">
  Escolher endereço
</button>

<!-- Modal -->
<div class="modal fade" id="enderecoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Endereços</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<%
  		if (resultado != null) {
		List<Endereco> enderecos = usuario.getEnderecos();
		StringBuilder sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		
		if(enderecos.size() > 0){
			try
			{
			int i = 0;
			for (Endereco e : enderecos) {
				sbRegistro.setLength(0);
				sbLink.setLength(0);
				
				sbRegistro.append(sbLink.toString());	
				sbRegistro.append(e.getLogradouro() + ", " + e.getNumero());
				sbRegistro.append("<BR>");
				sbRegistro.append(e.getBairro() + ", " + e.getCidade() + ", " + e.getEstado());			
				sbRegistro.append("<BR>");
				sbRegistro.append(e.getCep());
				sbRegistro.append("<BR>");
				sbRegistro.append("<form action='SalvarProduto' method='post' id='frmSalvarLivro'>");
				if (carrinho != null) {
					//sbRegistro = new StringBuilder();
					sbLink = new StringBuilder();
					
					if(carrinho.getProdutos().size() > 0){
						try
						{
						for (Produto p : carrinho.getProdutos()) {
							//sbRegistro.setLength(0);
							sbLink.setLength(0);
										
							sbRegistro.append("<input type='hidden' id='txtQtdeH" + p.getLivro().getId() + "' name='txtQtde" + p.getLivro().getId() + "'/>");
							
							//out.print(sbRegistro.toString());
							
						}
						}catch(Exception ex){
							
						}
					}
				}
				sbRegistro.append("<input type='hidden' name='txtIndice' value='" + i + "'>");
				sbRegistro.append("<input class='btn btn-success' type='submit' id='operacao' name='operacao' value='SELECIONAR'>");
				sbRegistro.append("</form>");
				
				out.print(sbRegistro.toString());
				i++;
			}
			}catch(Exception e){
				
			}
		}
	}
   %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cupomModal">
  Inserir cupom
</button>

<!-- Modal -->
<div class="modal fade" id="cupomModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Cartões</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <form action="SalvarProduto">
      	<input type="text" id="txtCupom" name="txtCupom">
      	<input type="submit" id="btnVerificar" name="btnVerificar" value="VERIFICAR">
      </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormCompra.jsp">Adicionar mais produtos</a>
<input type="submit" style="float:right" class="btn btn-success" class="btn btn-primary" id="operacao" name="operacao" value="FINALIZAR" class="btn btn-default" />
</body>
</html>