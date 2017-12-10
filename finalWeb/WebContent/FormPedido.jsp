<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="resources/estilo.css">
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
		//Carrinho carrinho = (Carrinho)resultado.getEntidades().get(0);
		Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
		Cliente usuario = (Cliente) session.getAttribute("usuario");
		Cupom cupom = (Cupom) session.getAttribute("cupom");
		Livro livro = (Livro) session.getAttribute("livro");
		Cartao cartao = (Cartao) session.getAttribute("cartao");
		if(usuario != null)
			out.print(usuario.getNome());
		out.print("<a href='http://localhost:8080/finalWeb/Index.jsp'>Início</a>");
	%>
	<BR>
	<%
	if(resultado !=null && resultado.getMsg() != null){
		out.print(resultado.getMsg());
	}
	
	%>
<BR>

<form action="SalvarPedido" method="post">
<TABLE class="table table-sm" bordercolor="blue" BORDER="5"    WIDTH="50%"   CELLPADDING="4" CELLSPACING="3">
   <TR>
      <TH COLSPAN="17"><BR>
      	<H3><img src='https://image.freepik.com/icones-gratis/carrinho-de-compras-de-design-de-linhas-horizontais_318-50800.jpg' style='width: 50px; height: 50px;' alt='First slide'>Pedidos</H3>
      </TH>
   </TR>
   <TR>
   	  ${usuario.getAdministrador() !=  true && carrinho.getStatus() == 'ENTREGUE' ? '<TH>Trocar</TH>' : ''}
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
				
				if(!usuario.getAdministrador() && carrinho.getStatus().equals("ENTREGUE")) {
					sbRegistro.append("<TD>");
					sbRegistro.append("<input type='checkbox' name='cbTroca" + p.getId() + "' value='teste" + p.getId() + "'");
					sbRegistro.append("</TD>");
				}
				
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
				sbRegistro.append("<label id='txtQtde" + p.getLivro().getId() + "' name='txtQtde'>");
				sbRegistro.append(p.getQuantidade());
				sbRegistro.append("</label>");
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());
				sbRegistro.append("<input type='number' id='txtPreco" + p.getLivro().getId() + "' name='txtPreco" + p.getLivro().getId() + "' readonly='readonly'");
				sbRegistro.append("value='" + (p.getLivro().getValor() * p.getQuantidade()) + "'");
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
<input type="submit" style="${usuario.getAdministrador() !=  true && carrinho.getStatus() == 'ENTREGUE' ? '' : 'display:none'}" class="btn btn-primary" id="operacao" name="operacao" value="SOLICITAR TROCA" />
<input type="submit" style="${usuario.getAdministrador() !=  true && carrinho.getStatus() == 'ENTREGUE' ? '' : 'display:none'}" class="btn btn-primary" id="operacao" name="operacao" value="ALTERAR" />
<input type="submit" style="${usuario.getAdministrador() ==  true && carrinho.getStatus() == 'EM TROCA' ? '' : 'display:none'}" class="btn btn-primary" id="operacao" name="operacao" value="TROCAR" />
</form>
<BR>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Endereço de entrega
		</TH>
		<TH>
		Frete
		</TH>
		<TH>
		Desconto
		</TH>
		<TH>
		Total
		</TH>
	</TR>
	<TR>
		<TD>
		${empty carrinho ? '' : carrinho.getEnderecoEntrega().getLogradouro()} , ${empty carrinho ? '' : enderecoEntrega.getNumero()}
		<BR>
		${empty carrinho ? '' : carrinho.getEnderecoEntrega().getBairro()} - ${empty carrinho ? '' : carrinho.getEnderecoEntrega().getCidade()} -
		${empty carrinho ? '' : carrinho.getEnderecoEntrega().getEstado()}
		</TD>
		<TD>
		${empty carrinho ? '' : carrinho.getFrete()}
		</TD>
		<TD>
		${empty carrinho ? '0' : carrinho.getCupom().getValor()}
		</TD>
		<TD>
		${empty carrinho ? '' : carrinho.getValorLivros() + carrinho.getFrete() - (empty cupom ? 0 : cupom.getValor())}
		</TD>
	</TR>
</TABLE>
<BR>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Cartão
		</TH>
	</TR>
	<TR>
		<TD>
		${empty carrinho ? '' : carrinho.getCartao().getBandeira()}
		<BR>
		${empty carrinho ? '' : carrinho.getCartao().getTitular()} - ${empty carrinho ? '' : carrinho.getCartao().getNumero()} -
		${empty carrinho ? '' : carrinho.getCartao().getValidadeFormatado()}
		</TD>
	</TR>
</TABLE>
<BR>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Cupom
		</TH>
	</TR>
	<TR>
		<TD>
		Código: ${empty carrinho ? '' : carrinho.getCupom().getCodigo()}
		<BR>
		Valor do desconto: ${empty carrinho ? '' : carrinho.getCupom().getValor()}
		</TD>
	</TR>
</TABLE>
<BR>

<!-- Button trigger modal -->
<button type="button" style="${usuario.getAdministrador() ==  true ? '' : 'display:none'}" class="btn btn-primary" data-toggle="modal" data-target="#detalhesModal">
  Detalhes
</button>

<!-- Modal -->
<div class="modal fade" id="detalhesModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" style="
    width: 100%;
    height: 100%;
    /* margin: 0; */
    /* padding: 0; */
" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Endereços</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action='SalvarPedido' method='post' id='frmSalvarLivro'>
        	Status atual do pedido: ${carrinho.getStatus()}
        	<BR>
          <select style="${carrinho.getStatus() == 'ENTREGUE' ? 'display:none' : '' }" id="ddlStatus" name="ddlStatus">
			<option ${carrinho.getStatus() == 'EM PROCESSAMENTO' ? '' : 'style="display:none"' }>APROVADO</option>
			<option ${carrinho.getStatus() == 'EM PROCESSAMENTO' ? '' : 'style="display:none"' }>REPROVADO</option>
			<option ${carrinho.getStatus() == 'APROVADO' ? '' : 'style="display:none"' }>EM TRANSPORTE</option>
			<option ${carrinho.getStatus() == 'EM TRANSPORTE' ? '' : 'style="display:none"' }>ENTREGUE</option>
		  </select>
		  <input type="submit" style="${carrinho.getStatus() == 'ENTREGUE' ? 'display:none' : '' }" style="float:right" class="btn btn-success" id="operacao" name="operacao" value="ALTERAR" />
	    </form>
      </div>
      <div class="modal-footer">
      
      </div>
    </div>
  </div>
</div>

</body>
</html>