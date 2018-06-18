<%@page import="auxiliar.CupomDesconto"%>
<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*, auxiliar.DadosCadLivro"%>
<%
		Resultado resultado = (Resultado) session.getAttribute("resultado");
		Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
		Cliente usuario = (Cliente) session.getAttribute("usuario");
		Cupom cupom = (Cupom) session.getAttribute("cupom");
		Livro livro = (Livro) session.getAttribute("livro");
		Cartao cartao = (Cartao) session.getAttribute("cartao");
	%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="resources/estilo.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Carrinho de compra</title>
<script>
	$(document).ready(function(){
		if(sessionStorage.body != undefined)
		{
			<%
			try{
			for (Produto p : carrinho.getProdutos()) {
				out.print("document.getElementById('txtQtde" + p.getLivro().getId() + 
						"').setAttribute('value',sessionStorage.qtdeLivro" + p.getLivro().getId() + ");");
			}
			}catch(Exception e){
				
			}
			%>
			document.getElementById("body").innerHTML = sessionStorage.body;
		}
	});
	function salvarEstado(){
		if (typeof(Storage) !== "undefined") {
			sessionStorage.body = document.getElementById("body").innerHTML;
	    	alert(sessionStorage.body);
		} else {
		    // Sorry! No Web Storage support..
		    alert("web storage bugou");
		}
	}
	function removerLivro(id) {
		//txtIdLivros
		<%
		try{
		for (Produto p : carrinho.getProdutos()) {
			out.print("document.getElementById('txtQtde" + p.getLivro().getId() + "').setAttribute('value',document.getElementById('txtQtde" + p.getLivro().getId() + "').value);");
			out.print("sessionStorage.qtdeLivro" + p.getLivro().getId() + "=document.getElementById('txtQtde" + 
					p.getLivro().getId() + "').value;");
		}
		}catch(Exception e){
			
		}
		%>
		var tabela = document.getElementById("tableCartao").innerHTML;
		document.getElementById("trLivro" + id).remove();
		var livros = document.getElementById("txtIdLivros").value;
		var removido = livros.replace((id), "");
		document.getElementById("txtIdLivros").setAttribute('value',removido);
	}
	function atualizarEndereco(id, endereco) {
		if(document.getElementById("hdIdEndereco").value == 0)
		{//document.getElementById("hdFrete").setAttribute('value',valor);
			if(id % 2 == 0)
			{
				var valor = document.getElementById("hdFrete").value * 1 + 20;
				document.getElementById("hdFrete").setAttribute('value',valor);
				document.getElementById("divFrete").innerHTML = valor;
				var precoTotal = document.getElementById("hdTotal").value * 1 + 20;
				document.getElementById("hdTotal").setAttribute('value',precoTotal);
				document.getElementById("divTotal").innerHTML = precoTotal;
			}
			else
			{
				var valor = document.getElementById("hdFrete").value * 1 + 30;
				document.getElementById("hdFrete").setAttribute('value',valor);
				document.getElementById("divFrete").innerHTML = valor;
				var precoTotal = document.getElementById("hdTotal").value * 1 + 30;
				document.getElementById("hdTotal").setAttribute('value',precoTotal);
				document.getElementById("divTotal").innerHTML = precoTotal;
			}
		}
		else
		{
			if(document.getElementById("hdIdEndereco").value % 2 == 0)
			{
				if(id % 2 != 0)
				{
					var valor = document.getElementById("hdFrete").value * 1 + 10;
					document.getElementById("hdFrete").value = valor;
					document.getElementById("divFrete").innerHTML = valor;
					var precoTotal = document.getElementById("hdTotal").value * 1 + 10;
					document.getElementById("hdTotal").value = precoTotal;
					document.getElementById("divTotal").innerHTML = precoTotal;
				}
			}
			else
			{
				if(id % 2 == 0)
				{
					var valor = document.getElementById("hdFrete").value * 1 - 10;
					document.getElementById("hdFrete").value = valor;
					document.getElementById("divFrete").innerHTML = valor;
					var precoTotal = document.getElementById("hdTotal").value * 1 - 10;
					document.getElementById("hdTotal").value = precoTotal;
					document.getElementById("divTotal").innerHTML = precoTotal;
				}
			}
		}
		document.getElementById("divEndereco").innerHTML = endereco;
		document.getElementById("hdIdEndereco").setAttribute('value',id);
		document.getElementById("btnCancelarEndereco").click();
	}
	function calcularFrete() {
		var ids = (document.getElementById("txtIdLivros").value).split(" ");
		var preco = 0;
		var precoTotal = 0.0;
		for (var id in ids) {
			var peso = document.getElementById("txtPesoLivro" + ids[id]).value;
			var quantidade = document.getElementById("txtQtde" + ids[id]).value;
			preco += (peso * quantidade);
			precoTotal += document.getElementById("txtPreco" + ids[id]).value * 1;
		}
		var frete = 0.0;
		if(document.getElementById("hdIdEndereco").value > 0)
			frete = preco * 1 + (document.getElementById("hdIdEndereco").value % 2 == 0 ? 20 : 30);
		else
			frete = preco * 1;
		document.getElementById("hdFrete").value = frete;
		document.getElementById("divFrete").innerHTML = frete;
		precoTotal += frete;
		document.getElementById("hdTotal").value = precoTotal;
		document.getElementById("divTotal").innerHTML = precoTotal;
	}
	function adicionarCartao(id, dados) {
		var tabela = document.getElementById("tableCartao").innerHTML;
		document.getElementById("hdIdCartao").value += id + " ";
		tabela += "<TR id='trCartao" + id + "'><TD>" + dados + "</TD><TD><input type='number' class='form form-control' " + 
			"step='0.5' id='txtPagarCartao" + id + "' name='txtPagarCartao" + id + "' min='10'></TD><TD><button type='button' class='btn btn-primary' " +
			"onclick='removerCartao(`" + id + "`)'>Remover</button></TD><TR>";
		document.getElementById("tableCartao").innerHTML = tabela;
		document.getElementById("btnSelecionarCartao" + id).disabled = true;
	}
	function removerCartao(id) {
		var tabela = document.getElementById("tableCartao").innerHTML;
		document.getElementById("trCartao" + id).remove();
		var cartoes = document.getElementById("hdIdCartao").value;
		var removido = cartoes.replace((id + " "), "");
		document.getElementById("hdIdCartao").value = removido;
		document.getElementById("btnSelecionarCartao" + id).disabled = false;
	}
	function consultarCupomDesconto() {
		var codigo = document.getElementById("txtCodigoDesconto").value;
		if(codigo == '0')
		{
			document.getElementById('tdCupomDesconto').innerHTML = '';
			document.getElementById('hdIdCupomDesconto').value = '';
		}
		<%
			DadosCadLivro dados = (DadosCadLivro)((Resultado) session.getAttribute("dados")).getEntidades().get(0);
			StringBuilder sbCuponsDesconto = new StringBuilder();
			for(CupomDesconto c : dados.getCuponsDesconto()){
				sbCuponsDesconto.append("else if(codigo == '" + c.getCodigo() + "'){\n\t");
				sbCuponsDesconto.append("document.getElementById('tdCupomDesconto').innerHTML='");
				sbCuponsDesconto.append("Código: " + c.getCodigo() + "<BR>");
				sbCuponsDesconto.append("Desconto: " + c.getValor() + "';");
				sbCuponsDesconto.append("document.getElementById('hdIdCupomDesconto').setAttribute('value','" + c.getId() + "');");
				sbCuponsDesconto.append("\n}");
			}
			out.print(sbCuponsDesconto.toString());
		%>
		else
		{
			document.getElementById('tdCupomDesconto').innerHTML = '';
			document.getElementById('hdIdCupomDesconto').value = '';
		}
	}
	function adicionarCupomTroca(id, valor) {
		var tabela = document.getElementById("tableCupomTroca").innerHTML;
		document.getElementById("hdIdCupomTroca").value += id + " ";
		tabela += "<TR id='trCupomTroca" + id + "'><TD>Valor do cupom: " + valor + "</TD><TD><button type='button' class='btn btn-primary' " +
			"onclick='removerCupomTroca(`" + id + "`)'>Remover</button></TD><TR>";
		document.getElementById("tableCupomTroca").innerHTML = tabela;
		document.getElementById("btnSelecionarCupomTroca" + id).disabled = true;
	}
	function removerCupomTroca(id) {
		var tabela = document.getElementById("tableCupomTroca").innerHTML;
		document.getElementById("trCupomTroca" + id).remove();
		var cartoes = document.getElementById("hdIdCupomTroca").value;
		var removido = cartoes.replace((id + " "), "");
		document.getElementById("hdIdCupomTroca").value = removido;
		document.getElementById("btnSelecionarCupomTroca" + id).disabled = false;
	}
	function atualizar(id, preco, maximo) {
		alert("atualizar");
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
<script>
   $(document).ready(function(){
	   $("#divNavBar").load("NavBar.jsp");
   });
</script>
</head>
<body>
	<div id="divNavBar"></div>
	<%
	if(usuario != null)
		out.print(usuario.getNome());
	if(resultado !=null && resultado.getMsg() != null){
		out.print(resultado.getMsg());
	}
	
	%>
<BR>
<form action='Pedido' method='post' id='frmSalvarLivro'>
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
      <TH>#</TH>
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
				String js = "document.getElementById(`txtPreco" + p.getLivro().getId() + "`).value=document.getElementById(`txtQtde" + p.getLivro().getId() + "`).value*" + p.getLivro().getValor();
				
				//document.getElementById('txtNumero').value = document.getElementById('txtTeste').value*2;alert('teste')
			//	<a href="nome-do-lugar-a-ser-levado">descrição</a>
				
				sbRegistro.append("<TR id='trLivro" + p.getLivro().getId() + "' ALIGN='CENTER'>");
				
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
				sbRegistro.append("\n<input type='number' class='btn btn-outline-dark' id='txtQtde" + p.getLivro().getId() + "' name='txtQtde" + p.getLivro().getId() + "'");
				sbRegistro.append("value='" + p.getQuantidade() + "'");
				sbRegistro.append("onchange='" + js + ";calcularFrete()'");
				sbRegistro.append("max='" + p.getLivro().getEstoque() + "' min='0'/>");
				sbRegistro.append("\n<input type='hidden' id='txtPesoLivro" + p.getLivro().getId() + "' value='" + p.getLivro().getPeso() + "'/>");
				sbRegistro.append("\n<input type='hidden' name='txtIdLivro' value='" + p.getLivro().getId() + "'/>");
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append(sbLink.toString());
				sbRegistro.append("\n<input type='number' class='btn btn-outline-dark' id='txtPreco" + p.getLivro().getId() + "' name='txtPreco" + p.getLivro().getId() + "' readonly='readonly'");
				sbRegistro.append("value='" + (p.getLivro().getValor() * p.getQuantidade()) + "'/>");
				sbRegistro.append("</TD>");
				
				sbRegistro.append("<TD>");
				sbRegistro.append("<a class='btn btn-danger' onclick='removerLivro(`" + p.getLivro().getId() + "`);salvarEstado()' href=SalvarLivro?");
				sbRegistro.append("txtId=");
				sbRegistro.append(p.getLivro().getId());						
				sbRegistro.append("&");
				sbRegistro.append("operacao=");
				sbRegistro.append("REMOVER_DO_CARRINHO");
				sbRegistro.append("&");
				sbRegistro.append("txtQuantidade=");
				sbRegistro.append(p.getQuantidade());
				sbRegistro.append(">REMOVER</a>");
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
<% 
if (carrinho != null) {
	StringBuilder sbRegistro = new StringBuilder();
	sbRegistro.append("<input type='hidden' id='txtIdLivros' name='txtIdLivros' value='");
			
	if(carrinho.getProdutos().size() > 0){
		try
		{
		for (Produto p : carrinho.getProdutos()) {
			sbRegistro.append(p.equals(carrinho.getProdutos().get(0)) ? "" : " ");
			sbRegistro.append(p.getLivro().getId());
		}
		}catch(Exception e){
			
		}
	}
	sbRegistro.append("'>");
	out.print(sbRegistro.toString());
}
%>
<div id="body">
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
		<div id="divEndereco"></div>
		<input type="hidden" id="hdIdEndereco" name="hdIdEndereco" value="0"/>
		</TD>
		<TD>
		<div id="divFrete"></div>
		<input type="hidden" id="hdFrete" name="hdFrete" value="0"/>
		</TD>
		<TD>
		${empty cupom ? '0' : cupom.getValor()}
		</TD>
		<TD>
		<div id="divTotal"></div>
		<input type="hidden" id="hdTotal" name="hdTotal" value="0.0"/>
		</TD>
	</TR>
</TABLE>
<BR>
<input type='checkbox' name='cbGarantirCompra' value='true'>Corrigir o preço no ultimo cartão (Garante o pagamento da compra com o ultimo cartão)
<TABLE id="tableCartao" bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Cartão
		</TH>
		<TH>
		Valor a pagar
		</TH>
		<TH>
		#
		</TH>
	</TR>
</TABLE>
<input type="hidden" id="hdIdCartao" name="hdIdCartao">
<BR>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Cupom de desconto
		</TH>
	</TR>
	<TR>
		<TD id="tdCupomDesconto">
		
		</TD>
	</TR>
</TABLE>
<input type="hidden" id="hdIdCupomDesconto" name="hdIdCupomDesconto"/>
<BR>

<TABLE id="tableCupomTroca" bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Cupom de troca
		</TH>
		<TH>
		#
		</TH>
	</TR>
</TABLE>
<input type="hidden" id="hdIdCupomTroca" name="hdIdCupomTroca">
<BR>

<!-- Button trigger modal -->
<button name="btnEndereco" type="button" class="btn btn-primary" data-toggle="modal" data-target="#enderecoModal">
  Selecionar endereço
</button>

<!-- Button trigger modal -->
<button name="btnCartao" type="button" class="btn btn-primary" data-toggle="modal" data-target="#cartaoModal">
  Selecionar cartão
</button>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cupomTModal">
  Selecionar cupom de troca
</button>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cupomModal">
  Inserir cupom
</button>

</div>
<a name="hrAMP" class="btn btn-primary" href="http://localhost:8080/finalWeb/FormCompra.jsp">Adicionar mais produtos</a>
<a style="${empty usuario ? '' : 'display:none'}" class="btn btn-primary" href="http://localhost:8080/finalWeb/FormLogin.jsp">Fazer Login</a>
	<button type="submit" style="float:right" class="btn btn-success" id="operacao" name="operacao" value="SALVAR">FINALIZAR</button>
</form>

<!-- Modal de Endreço -->
<div class="modal fade" id="enderecoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
      <%
  		if (usuario != null) {
			List<Endereco> enderecos = usuario.getEnderecos();
			StringBuilder sbRegistro = new StringBuilder();
			
			if(enderecos.size() > 0){
				try
				{
				for (Endereco e : enderecos) {
					if(e.getTipo().equals("Entrega"))
					{
					sbRegistro.setLength(0);
					String js = "atualizarEndereco(" + e.getId() + ",`" + e.getLogradouro() + ", " + e.getNumero() + 
							"<br>" + e.getBairro() + " - " + e.getCidade() + " - " + e.getEstado() + "`)";
					
					sbRegistro.append(e.getLogradouro() + ", " + e.getNumero());
					sbRegistro.append("<BR>");
					sbRegistro.append(e.getBairro() + ", " + e.getCidade() + ", " + e.getEstado());			
					sbRegistro.append("<BR>");
					sbRegistro.append(e.getCep());
					sbRegistro.append("<BR>\n");
					sbRegistro.append("<button id='btnEnd" + e.getId() + "' name='btnEnd" + e.getId() + "' type='button' class='btn btn-success' onclick='" + js + "'>Selecionar</button>");
					sbRegistro.append("<br>\n\t");
					
					out.print(sbRegistro.toString());
					}
				}
				}catch(Exception e){
					
				}
			}
		}
	   %>
	   
      </div>
      <div class="modal-footer">
        <button type="button" id="btnCancelarEndereco" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
        
		<!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#novoEnderecoModal">
		  Novo endereço
		</button>
		
		<!-- Modal -->
		<div class="modal fade" style='width:100%' id="novoEnderecoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Cadastrar Endereço de entrega</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      <form action="SalvarEndereco" method="post" id="frmSalvarEndereco">
				<table class="table table-bordered">
						<tr><TH COLSPAN="2">Cadastro de Endereço</TH></tr>
						<tr>
							<td COLSPAN="2">
								Nome do endereço
								<input type="text" class="form-control" id="txtNomeEndereco" name="txtNomeEndereco" placeholder="ex:Minha casa" required="required"/>
							</td>
						</tr>
						<tr>
							<td>
								Tipo do endereço
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoEndereco" name="ddlTipoEndereco">
									<option>Entrega</option>
								</select>
							</td>
							<td>
								Tipo da residencia
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoResidencia" name="ddlTipoResidencia">
									<option >Casa</option>
									<option >Apartamento</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>
								Tipo do logradouro
								<br>
								<select class="btn btn-outline-dark" id="ddlTipoLogradouro" name="ddlTipoLogradouro">
									<option>Avenida</option>
									<option>Rua</option>
									<option>Travessa</option>
								</select>
							</td>
							<td>
								Logradouro
								<br>
								<input type="text" class="form-control" id="txtLogradouro" name="txtLogradouro" required="required"/>
							</td>
						</tr>
						<tr>
							<td>
								Número
								<br>
								<input type="text"class="form-control" id="txtNumero" name="txtNumero" required="required"/>
							</td>
						</tr>
						<tr>
							<td>
								Bairro
								<br>
								<input type="text"class="form-control" id="txtBairro" name="txtBairro" required="required"/>
							</td>
							<td>
								CEP
								<br>
								<input type="text"class="form-control" id="txtCep" name="txtCep" required="required"/>
							</td>
						</tr>
						<tr>
							<td>
								Estado
								<br>
								<input type="text"class="form-control" id="txtEstado" name="txtEstado" required="required"/>
							</td>
							<td>
								Cidade
								<br>
								<input type="text"class="form-control" id="txtCidade" name="txtCidade" required="required"/>
							</td>
						</tr>
						<tr>
							<td>
								País
								<br>
								<input type="text" class="form-control"  id="txtPais" name="txtPais" required="required"/>
							</td>
							<td>
								Observação
								<br>
								<input type="text" class="form-control"  id="txtObservacao" name="txtObservacao"/>
							</td>
						</tr>
					</table>
					<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="SALVAR">SALVAR</button>
			</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
      </div>
    </div>
  </div>
</div>

<!-- Modal de Cartão-->
<div class="modal fade" id="cartaoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Cartões</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <%
  		if (usuario != null) {
		List<Cartao> cartoes = usuario.getCartoes();
		StringBuilder sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		String dadosCartao;
		
		if(cartoes.size() > 0){
			try
			{
			Calendar calend = Calendar.getInstance();
			int i = 0;
			for (Cartao c : cartoes) {
				if(c.getValidade().after( calend))
				{
				sbRegistro.setLength(0);
				sbLink.setLength(0);
				dadosCartao = "`" + c.getBandeira() + "<BR>" + c.getTitular() + ", " + c.getNumero() + "<BR>Validade: " + c.getValidadeFormatado() + "`";
				
				sbRegistro.append(sbLink.toString());	
				sbRegistro.append(c.getBandeira());
				sbRegistro.append("<BR>");
				sbRegistro.append(c.getTitular() + ", " + c.getNumero());			
				sbRegistro.append("<BR>");
				sbRegistro.append("Validade: " + c.getValidadeFormatado());
				sbRegistro.append("<BR>");
				sbRegistro.append("<button id='btnCar" + c.getId() + "' type='button' id='btnSelecionarCartao" + c.getId() + "' class='btn btn-success' onclick='adicionarCartao(`" + c.getId() + "`," + dadosCartao + ")'>Selecionar</button>");
				sbRegistro.append("<BR>");
				
				out.print(sbRegistro.toString());
				}
				i++;
			}
			}catch(Exception e){
				
			}
		}
	}
   %>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
        <!-- Button trigger modal -->
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#novoCartaoModal">
		  Novo cartão
		</button>
		
		<!-- Modal -->
		<div class="modal fade" style='width:100%' id="novoCartaoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Endereços</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      <form action="SalvarCartao" method="post" id="frmSalvarCartao">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de cartão</TH></tr>
				<tr style="${empty cliente ? 'display:none' : ''}">
					<td>
						ID
					</td>
					<td>
						<input type="text" class="form-control" id="txtId" name="txtId" value="${empty cartao ? '' : cartao.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr style="${empty cliente ? 'display:none' : ''}">
					<td>
						ID do cliente
					</td>
					<td>
						<input type="text" class="form-control" id="txtIdCliente" name="txtIdCliente" value="${empty usuario ? '' : usuario.getId()}" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td>
						Titular
					</td>
					<td>
						<input type="text" class="form-control" id="txtTitular" name="txtTitular" value="${empty cartao ? '' : cartao.getTitular()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Numero
					</td>
					<td>
						<input type="text" class="form-control" id="txtNumeroCartao" name="txtNumeroCartao" value="${empty cartao ? '' : cartao.getNumero()}"/>
					</td>
				</tr>
				<tr>
					<td>
						Codigo
					</td>
					<td>
						<input type="text" class="form-control" id="txtCodigo" name="txtCodigo" value="${empty cartao ? '' : cartao.getCodigo()}"/>
					</td>
				</tr>
				<tr>
					<td>
						preferencial
					</td>
					<td>
						Preferencial    <input type="radio" id="rdCPreferencial" name="rdCPreferencial" value="true" ${cartao.getPreferencial() == true ? 'checked' : ''}>
					    Comum    <input type="radio" id="rdCPreferencial" name="rdCPreferencial" value="false" checked>
					</td>
				</tr>
				<tr>
					<td>
						validade
					</td>
					<td>
						<input type="text"class="form-control" id="txtValidade" name="txtValidade" value="${empty cartao ? '' : cartao.getValidadeFormatado()}" />
					</td>
				</tr>
				<tr>
					<td>
						Bandeira
					</td>
					<td>
						<select id="ddlBandeira" name="ddlBandeira">
							<option ${endereco.getTipoLogradouro() == 'Visa' ? 'selected' : '' }>Visa</option>
							<option ${endereco.getTipoLogradouro() == 'Caixa' ? 'selected' : '' }>Caixa</option>
							<option ${endereco.getTipoLogradouro() == 'Itau' ? 'selected' : '' }>Itau</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Responsavel
					</td>
					<td>
						<input type="text" class="form-control"  id="txtResponsavel" name="txtResponsavel" value="${empty cartao ? '' : cartao.getAlterador()}" />
					</td>
				</tr>
			</table>
			<input type="submit" class="btn btn-primary" id="operacao" name="operacao" value="SALVAR NOVO" class="btn btn-default" />
		</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
      </div>
    </div>
  </div>
</div>

<!-- Modal de cupom de troca -->
<div class="modal fade" id="cupomTModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Cupons de troca</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <%
  		if (usuario != null) {
		List<CupomTroca> cupons = usuario.getCupons();
		StringBuilder sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		
		if(cupons.size() > 0){
			try
			{
			int i = 0;
			for (CupomTroca c : cupons) {
				sbRegistro.setLength(0);
				sbLink.setLength(0);
				
				sbRegistro.append(sbLink.toString());
				sbRegistro.append("Valor do cupom: ");
				sbRegistro.append(c.getValor());
				sbRegistro.append("<BR>");
				sbRegistro.append("Status: ");
				sbRegistro.append(c.getStatus() == true ? "Utilizavel" : "Já utilizado");
				sbRegistro.append("<BR>");
				sbRegistro.append("<button type='button' class='btn btn-success' id='btnSelecionarCupomTroca" + c.getId() + "'");
				sbRegistro.append("onclick='adicionarCupomTroca(`" + c.getId() + "`,`" + c.getValor() + "`)'>SELECIONAR</button>");
				sbRegistro.append("<BR>");
				
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
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal cupom de desconto -->
<div class="modal fade" id="cupomModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Cupom de desconto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<input type="text" id="txtCodigoDesconto" name="txtCodigoDesconto">
      </div>
      <div class="modal-footer">
        <button type="button" onclick="consultarCupomDesconto()" class="btn btn-primary">Confirmar</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>