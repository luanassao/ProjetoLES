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
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pedido</title>
<script>
	function atualizar() {
		var troca = document.getElementsByName('cbTroca');
		var flgTrocaTotal = true;
		var flgNenhumSelecionado = true;
	    for (var i = 0; i < troca.length; i++){
	    	if(!troca[i].checked)
	    		flgTrocaTotal = false;
	    	else
	    		flgNenhumSelecionado = false;
	    }
	    if(flgTrocaTotal)
	    	document.getElementById('operacao').setAttribute('value', 'ALTERAR');
	    else
	    	document.getElementById('operacao').setAttribute('value', 'SALVAR');
	    if(flgNenhumSelecionado)
	    	document.getElementById('operacao').disabled = true;
	    else
	    	document.getElementById('operacao').disabled = false;
	}
	function mudarValue(id){
		/*if(!document.getElementById('cbTroca' + id).checked)
			document.getElementById('cbTroca' + id).setAttribute('value', '');
		else
			document.getElementById('cbTroca' + id).setAttribute('value', id);*/
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

	<%
		Resultado resultado = (Resultado) session.getAttribute("resultado");
		//Carrinho carrinho = (Carrinho)resultado.getEntidades().get(0);
		Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
		Cliente usuario = (Cliente) session.getAttribute("usuario");
		Cupom cupom = (Cupom) session.getAttribute("cupom");
		Livro livro = (Livro) session.getAttribute("livro");
		Cartao cartao = (Cartao) session.getAttribute("cartao");
	%>
	<BR>
	<%
	if(resultado !=null && resultado.getMsg() != null){
		out.print(resultado.getMsg());
	}
	
	%>
<BR>

<form action="Pedido" method="post">
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
      <TH>Pre�o unit�rio</TH>
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
				
			//	<a href="nome-do-lugar-a-ser-levado">descri��o</a>
				
				sbRegistro.append("<TR ALIGN='CENTER'>");
				
				if(!usuario.getAdministrador() && carrinho.getStatus().equals("ENTREGUE")) {
					sbRegistro.append("<TD>");
					//sbRegistro.append("<input type='checkbox' name='cbTroca" + p.getId() + "' value='teste" + p.getId() + "'>");
					sbRegistro.append("<input type='checkbox' name='cbTroca' id='cbTroca" + p.getId() + "' value='" + p.getId() + "' onchange='");
					sbRegistro.append("mudarValue(`" + p.getId() + "`);atualizar()'>");
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
				sbRegistro.append("<input type='number' name='txtQtde" + p.getId() + "' id='txtQtde' value='");
				sbRegistro.append(p.getQuantidade());
				sbRegistro.append("'/>");
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());
				sbRegistro.append("<input type='number' id='txtPreco" + p.getLivro().getId() + "' name='txtPreco" + p.getLivro().getId() + "' readonly='readonly'");
				sbRegistro.append("value='" + (p.getLivro().getValor() * p.getQuantidade()) + "'");
				sbRegistro.append("</TD>");
				
				sbRegistro.append("</TR>\n");
				
				out.print(sbRegistro.toString());
				
			}
			}catch(Exception e){
				
			}
		}
	}
   %>
</TABLE>
<%
	if(!usuario.getAdministrador() && carrinho.getStatus().equals("ENTREGUE")){
		out.print("<button type='submit' class='btn btn-primary' id='operacao' name='operacao' value='ALTERAR'>Solicitar Troca</button>");
	}
%>
</form>
<BR>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Endere�o de entrega
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
		${empty carrinho ? '0' : carrinho.getCupomDesconto().getValor()}
		</TD>
		<TD>
		${empty carrinho ? '' : carrinho.getValorLivros() + carrinho.getFrete() - (empty carrinho.getCupomDesconto() ? 0 : carrinho.getCupomDesconto().getValor())}
		</TD>
	</TR>
</TABLE>
<BR>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Cart�o
		</TH>
		<TH>
		Pagamento
		</TH>
	</TR>
	<% 
		StringBuilder sbRegistro = new StringBuilder();
		if(carrinho != null && carrinho.getCartoes() != null && carrinho.getCartoes().size() > 0)
		{
			for(Cartao c:carrinho.getCartoes()){
				sbRegistro.setLength(0);
				sbRegistro.append("<TR><TD>");
				sbRegistro.append(c.getBandeira());
				sbRegistro.append("<BR>");
				sbRegistro.append(c.getTitular() + " - ");
				sbRegistro.append(c.getNumero());
				sbRegistro.append("<BR>");
				sbRegistro.append(c.getValidadeFormatado());
				sbRegistro.append("</TD><TD>");
				sbRegistro.append(c.getCredito());
				sbRegistro.append("</TD></TR>");
				
				out.print(sbRegistro.toString());
			}
		}
		else{
			
		}
	%>
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
		C�digo: ${empty carrinho ? '' : carrinho.getCupomDesconto().getCodigo()}
		<BR>
		Valor do desconto: ${empty carrinho ? '' : carrinho.getCupomDesconto().getValor()}
		</TD>
	</TR>
</TABLE>
<BR>

<!-- Button trigger modal -->
<button id="btnDetalhes" type="button" style="${usuario.getAdministrador() ==  true ? '' : 'display:none'}" class="btn btn-primary" data-toggle="modal" data-target="#detalhesModal">
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
        <h5 class="modal-title" id="exampleModalLabel">Endere�os</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action='Pedido' method='post' id='frmSalvarLivro'>
        	Status atual do pedido: ${carrinho.getStatus()}
        	<BR>
        	<div ${carrinho.getStatus() == 'TROCA APROVADA' ? '' : 'style="display:none"'}>
	        	<input type='checkbox' name='cbReporEstoque' value='true'>
	        	Repor os livros no estoque
        	</div>
        	<BR>
          <select style="${carrinho.getStatus() == 'ENTREGUE' ? 'display:none' : '' }" id="ddlStatus" name="ddlStatus">
          	<% 
				sbRegistro = new StringBuilder();
				if(carrinho != null)
				{
					String status = carrinho.getStatus();
					if(status.equals("EM PROCESSAMENTO")){
						sbRegistro.append("<option id='APROVADO'>APROVADO</option>");
						sbRegistro.append("<option id='REPROVADO'>REPROVADO</option>");
					}
					else if(status.equals("APROVADO")){
						sbRegistro.append("<option id='EMTRANSPORTE'>EM TRANSPORTE</option>");
					}
					else if(status.equals("REPROVADO")){
						sbRegistro.append("<option id='APROVADO'>APROVADO</option>");
					}
					else if(status.equals("EM TRANSPORTE")){
						sbRegistro.append("<option id='ENTREGUE'>ENTREGUE</option>");
					}
					else if(status.equals("EM TROCA")){
						sbRegistro.append("<option id='TROCAAPROVADA'>TROCA APROVADA</option>");
						sbRegistro.append("<option id='TROCAREPROVADA'>TROCA REPROVADA</option>");
					}
					else if(status.equals("TROCA APROVADA")){
						sbRegistro.append("<option id='TROCADO'>TROCADO</option>");
					}
					out.print(sbRegistro.toString());
				}
				else{
			/*<option id="APROVADO" ${carrinho.getStatus() == 'EM PROCESSAMENTO' ? '' : 'style="display:none"' }>APROVADO</option>
			<option id="REPROVADO" ${carrinho.getStatus() == 'EM PROCESSAMENTO' ? '' : 'style="display:none"' }>REPROVADO</option>
			<option id="EMTRANSPORTE" ${carrinho.getStatus() == 'APROVADO' ? '' : 'style="display:none"' }>EM TRANSPORTE</option>
			<option id="ENTREGUE" ${carrinho.getStatus() == 'EM TRANSPORTE' ? '' : 'style="display:none"' }>ENTREGUE</option>
			<option id="TROCAAPROVADA" ${carrinho.getStatus() == 'EM TROCA' ? '' : 'style="display:none"' }>TROCA APROVADA</option>
			<option id="TROCADO" ${carrinho.getStatus() == 'TROCA APROVADA' ? '' : 'style="display:none"' }>TROCADO</option>
			*/
				}
			%>
			
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