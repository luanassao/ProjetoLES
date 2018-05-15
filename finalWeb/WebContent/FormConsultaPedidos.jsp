<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page
	import="finalCore.aplicacao.Resultado, finalDominio.*, java.util.*"%>
<!DOCTYPE>
<html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"
            integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
            crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
		@SuppressWarnings("unchecked")
		ArrayList<EntidadeDominio> pedidos = (ArrayList<EntidadeDominio>) session.getAttribute("pedidos");
		Cliente usuario = (Cliente) session.getAttribute("usuario");
		if(usuario != null)
			out.print(usuario.getNome());
	%>

	<form action="Pedido" method="post">
		<table class="table" bordercolor="blue" BORDER="5" >
		<TR>
		      <TH COLSPAN="4"><BR>
		      	<H3>FILTROS</H3>
		      </TH>
   		</TR>
			<tr>
				<td>
				Codigo do pedido: <input type="number" id="txtIdPedido" name="txtIdPedido" /> 
				</td>
				<td>
				Codigo do cliente:<input type="number" id="txtIdCliente" name="txtIdCliente" />
				</td>
				<td>
				Email do Cliente <input type="text" id="txtEmail" name="txtEmail"/>
				</td>
				<td>
				Status 
				<select id="ddlStatus" name="ddlStatus">
					<option value="">TODOS</option>
					<option value="EM PROCESSAMENTO">EM PROCESSAMENTO</option>
					<option value="EM TROCA">EM TROCA</option>
					<option value="APROVADO">APROVADO</option>
					<option value="REPROVADO">REPROVADO</option>
					<option value="EM TRANSPORTE">EM TRANSPORTE</option>
					<option value="ENTREGUE">ENTREGUE</option>
				</select>
				</td>
			</tr>
		</table>
		<br>
		<button type="submit" class="btn btn-primary" id="operacao" name="operacao" value="CONSULTAR">Consultar pedidos</button>
	</form>

	


	<%
	
	if(resultado !=null && resultado.getMsg() != null){
		out.print(resultado.getMsg());
	}
	
	%>
<BR>

<TABLE class="table table-sm" bordercolor="blue" BORDER="5"    WIDTH="50%"   CELLPADDING="4" CELLSPACING="3">
   <TR>
      <TH COLSPAN="17"><BR>
      	<H3>Pedidos</H3>
      </TH>
   </TR>
   <TR>
      <TH>Codigo</TH>
      <TH>Comprador</TH>
      <TH>Status</TH>
      <TH>ID do endereço</TH>
      <TH>Valor do frete</TH>
      <TH>Valor dos livros</TH>
      <TH>Valor total</TH>
   </TR>
   
   <%
   if (pedidos != null) {
		StringBuilder sbRegistro = new StringBuilder();
		StringBuilder sbLink = new StringBuilder();
		Carrinho c;
		for(EntidadeDominio e : pedidos){
			c = (Carrinho)e;
			sbRegistro.setLength(0);
			sbLink.setLength(0);
			
		//	<a href="nome-do-lugar-a-ser-levado">descrição</a>
			
			sbRegistro.append("<TR ALIGN='CENTER'>");
			
			
			sbLink.append("<a id = '");
			sbLink.append(c.getId());
			sbLink.append("' href=Pedido?");
			sbLink.append("txtId=");
			sbLink.append(c.getId());						
			sbLink.append("&");
			sbLink.append("operacao=");
			sbLink.append("VISUALIZAR");
				
			sbLink.append(">");
			
			sbRegistro.append("<TD>");
			sbRegistro.append(sbLink.toString());	
			sbRegistro.append(c.getId() == 0 ? ' ' : c.getId());
			sbRegistro.append("</a>");				
			sbRegistro.append("</TD>");

			sbRegistro.append("<TD>");
			sbRegistro.append(sbLink.toString());				
			sbRegistro.append(c.getEmail());
			sbRegistro.append("</a>");				
			sbRegistro.append("</TD>");
			
			sbRegistro.append("<TD>");
			sbRegistro.append(sbLink.toString());				
			sbRegistro.append(c.getStatus());
			sbRegistro.append("</a>");				
			sbRegistro.append("</TD>");
			
			sbRegistro.append("<TD>");
			sbRegistro.append(sbLink.toString());				
			sbRegistro.append(c.getIdEndereco());
			sbRegistro.append("</a>");				
			sbRegistro.append("</TD>");
			
			sbRegistro.append("<TD>");
			sbRegistro.append(sbLink.toString());				
			sbRegistro.append(c.getFrete() > 0 ? c.getFrete() : "Pedido de troca");
			sbRegistro.append("</a>");				
			sbRegistro.append("</TD>");
			
			sbRegistro.append("<TD>");
			sbRegistro.append(sbLink.toString());				
			sbRegistro.append(c.getValorLivros());
			sbRegistro.append("</a>");				
			sbRegistro.append("</TD>");
			
			sbRegistro.append("<TD>");
			sbRegistro.append(sbLink.toString());				
			sbRegistro.append(c.getValorTotal());
			sbRegistro.append("</a>");				
			sbRegistro.append("</TD>");
			
			sbRegistro.append("</TR>");
			
			out.print(sbRegistro.toString());
		}
		
	}
   
   %>
</TABLE>
<a class="btn btn-primary" href="http://localhost:8080/finalWeb/FormClienteEnd.jsp">Cadastrar livro</a>
</body>
</html>