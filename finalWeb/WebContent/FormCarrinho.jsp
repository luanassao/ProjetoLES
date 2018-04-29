<%@page import="java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
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
		Carrinho carrinho = (Carrinho) session.getAttribute("carrinho");
		Cliente usuario = (Cliente) session.getAttribute("usuario");
		Cupom cupom = (Cupom) session.getAttribute("cupom");
		Livro livro = (Livro) session.getAttribute("livro");
		Cartao cartao = (Cartao) session.getAttribute("cartao");
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
				sbRegistro.append("<input type='number' class='btn btn-outline-dark' id='txtQtde" + p.getLivro().getId() + "' name='txtQtde'");
				sbRegistro.append("value='" + p.getQuantidade() + "'");
				sbRegistro.append("onchange='this.form.submit()'");
				sbRegistro.append("onload='atualizar(" + p.getLivro().getId() + "," + p.getLivro().getValor() + "," + p.getLivro().getEstoque() + ")'");
				sbRegistro.append("max='" + p.getLivro().getEstoque() + "' min='0'/>");
				sbRegistro.append("<input type='hidden' name='txtIdLivro' value='" + p.getLivro().getId() + "'>");
				sbRegistro.append("<input type='hidden' name='operacao' value='ATUALIZAR'>");
				sbRegistro.append("</form>");
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
		${empty enderecoEntrega ? '' : enderecoEntrega.getLogradouro()} , ${empty enderecoEntrega ? '' : enderecoEntrega.getNumero()}
		<BR>
		${empty enderecoEntrega ? '' : enderecoEntrega.getBairro()} - ${empty enderecoEntrega ? '' : enderecoEntrega.getCidade()} -
		${empty enderecoEntrega ? '' : enderecoEntrega.getEstado()}
		</TD>
		<TD>
		${empty carrinho ? '' : carrinho.getFrete()}
		</TD>
		<TD>
		${empty cupom ? '0' : cupom.getValor()}
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
		Cart�o
		</TH>
	</TR>
	<TR>
		<TD>
		${empty cartao ? '' : cartao.getBandeira()}
		<BR>
		${empty cartao ? '' : cartao.getTitular()} - ${empty cartao ? '' : cartao.getNumero()} -
		${empty cartao ? '' : cartao.getValidadeFormatado()}
		</TD>
	</TR>
</TABLE>
<BR>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Cupom de desconto
		</TH>
	</TR>
	<TR>
		<TD>
		C�digo: ${empty cupom ? '' : cupom.getCodigo()}
		<BR>
		Valor do desconto: ${empty cupom ? '' : cupom.getValor()}
		</TD>
	</TR>
</TABLE>
<BR>

<TABLE bordercolor="blue" BORDER="5" WIDTH="40%" CELLPADDING="4" CELLSPACING="3">
	<TR>
		<TH>
		Cupom de troca
		</TH>
	</TR>
	<%
	try{
	if (carrinho.getCupons() != null) {
		List<CupomTroca> cupons = carrinho.getCupons();
		StringBuilder sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		
		if(cupons.size() > 0){
			try
			{
			for (CupomTroca c : cupons) {
				sbRegistro.setLength(0);
				sbLink.setLength(0);
				
				sbRegistro.append(sbLink.toString());
				sbRegistro.append("<TR>");
				sbRegistro.append("<TD>");
				sbRegistro.append("Valor do cupom: ");
				sbRegistro.append(c.getValor());
				sbRegistro.append("<BR>");
				sbRegistro.append("Status: ");
				sbRegistro.append(c.getStatus());
				sbRegistro.append("</TD>");
				sbRegistro.append("</TR>");
				
				out.print(sbRegistro.toString());
			}
			}catch(Exception e){
				
			}
		}
	}
	}catch(Exception e){
		out.print("ERRO!");
	}
	%>
</TABLE>
<BR>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#enderecoModal">
  Escolher endere�o
</button>

<!-- Modal -->
<div class="modal fade" id="enderecoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
      <%
  		if (usuario != null) {
			List<Endereco> enderecos = usuario.getEnderecos();
			StringBuilder sbRegistro = new StringBuilder();
			StringBuilder sbLink = new StringBuilder();
			
			if(enderecos.size() > 0){
				try
				{
				int i = 0;
				for (Endereco e : enderecos) {
					//if(e.getTipo().equals("Entrega"))
					//{
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
					//}
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
		<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#novoEnderecoModal">
		  Novo endere�o
		</button>
		
		<!-- Modal -->
		<div class="modal fade" style='width:100%' id="novoEnderecoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Endere�os</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      <form action="SalvarEndereco" method="post" id="frmSalvarEndereco">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de endere�o</TH></tr>
				<tr style="${empty usuario ? 'display:none' : ''}">
					<td>
						ID do cliente
					</td>
					<td>
						<input type="text" class="form-control" id="txtIdCliente" name="txtIdCliente" value="${empty usuario ? '' : usuario.getId()}" readonly="readonly"/>
						<input type="hidden" name="ddlTipoEndereco" value="Entrega">
					</td>
				</tr>
				<tr>
					<td>
						Tipo da residencia
					</td>
					<td>
						<select id="ddlTipoResidencia" name="ddlTipoResidencia">
							<option>Casa</option>
							<option>Apartamento</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Tipo do logradouro
					</td>
					<td>
						<select id="ddlTipoLogradouro" name="ddlTipoLogradouro">
							<option>Avenida</option>
							<option>Rua</option>
							<option>Travessa</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>
						Logradouro
					</td>
					<td>
						<input type="text" class="form-control" id="txtLogradouro" name="txtLogradouro"/>
					</td>
				</tr>
				<tr>
					<td>
						Preferencial
					</td>
					<td>
						Ativo    <input type="radio" id="rdPreferencial" name="rdPreferencial" value="true">
					    Inativo    <input type="radio" id="rdPreferencial" name="rdPreferencial" value="false" checked>
					</td>
				</tr>
				<tr>
					<td>
						N�mero
					</td>
					<td>
						<input type="text"class="form-control" id="txtNumero" name="txtNumero" />
					</td>
				</tr>
				<tr>
					<td>
						Bairro
					</td>
					<td>
						<input type="text"class="form-control" id="txtBairro" name="txtBairro" />
					</td>
				</tr>
				<tr>
					<td>
						CEP
					</td>
					<td>
						<input type="text"class="form-control" id="txtCep" name="txtCep" />
					</td>
				</tr>
				<tr>
					<td>
						Estado
					</td>
					<td>
						<input type="text"class="form-control" id="txtEstado" name="txtEstado"/>
					</td>
				</tr>
				<tr>
					<td>
						Cidade
					</td>
					<td>
						<input type="text"class="form-control" id="txtCidade" name="txtCidade" />
					</td>
				</tr>
				<tr>
					<td>
						Pa�s
					</td>
					<td>
						<input type="text" class="form-control"  id="txtPais" name="txtPais"/>
					</td>
				</tr>
				<tr>
					<td>
						Observa��o
					</td>
					<td>
						<input type="text" class="form-control"  id="txtObservacao" name="txtObservacao"/>
					</td>
				</tr>
				<tr>
					<td>
						Responsavel
					</td>
					<td>
						<input type="text" class="form-control"  id="txtResponsavel" name="txtResponsavel" value="${empty usuario ? '' : ''}"/>
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

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cartaoModal">
  Selecionar cart�o
</button>

<!-- Modal -->
<div class="modal fade" id="cartaoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Cart�es</h5>
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
				
				sbRegistro.append(sbLink.toString());	
				sbRegistro.append(c.getBandeira());
				sbRegistro.append("<BR>");
				sbRegistro.append(c.getTitular() + ", " + c.getNumero());			
				sbRegistro.append("<BR>");
				sbRegistro.append("Validade: " + c.getValidadeFormatado());
				sbRegistro.append("<BR>");
				sbRegistro.append("<form action='SalvarProduto' method='post' id='frmSalvarLivro'>");
				sbRegistro.append("<input type='hidden' name='txtIndice' value='" + i + "'>");
				sbRegistro.append("<input class='btn btn-success' type='submit' id='operacao' name='operacao' value='CONFIRMAR'>");
				sbRegistro.append("</form>");
				
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
		  Novo cart�o
		</button>
		
		<!-- Modal -->
		<div class="modal fade" style='width:100%' id="novoCartaoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Endere�os</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      <form action="SalvarCartao" method="post" id="frmSalvarCartao">
			<table class="table table-bordered">
				<tr><TH COLSPAN="2">Cadastro de cart�o</TH></tr>
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

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#cupomTModal">
  Selecionar cupom de troca
</button>

<!-- Modal -->
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
				sbRegistro.append(c.getStatus() == true ? "Utilizavel" : "J� utilizado");
				sbRegistro.append("<form action='SalvarProduto' method='post' id='frmSalvarLivro'>");
				sbRegistro.append("<input type='hidden' name='txtIndice' value='" + i + "'>");
				if(c.getStatus())
					sbRegistro.append("<input class='btn btn-success' type='submit' id='operacao' name='operacao' value='SELECIONAR CUPOM'>");
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
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
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
        <h5 class="modal-title" id="exampleModalLabel">Cupom</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      <form action="SalvarProduto">
      	<input type="text" id="txtCupom" name="txtCupom">
      	<input class="btn btn-primary" type="submit" id="btnVerificar" name="operacao" value="VERIFICAR">
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
<a style="${empty usuario ? '' : 'display:none'}" class="btn btn-primary" href="http://localhost:8080/finalWeb/FormLogin.jsp">Fazer Login</a>
<form action='SalvarProduto' method='post' id='frmSalvarLivro'>
	<input type="submit" style="float:right" ${empty usuario ? 'disabled' : ''} ${empty cartao ? 'disabled' : ''} ${empty enderecoEntrega ? 'disabled' : ''} class="btn btn-success" class="btn btn-primary" id="operacao" name="operacao" value="FINALIZAR" class="btn btn-default" />
</form>
</body>
</html>