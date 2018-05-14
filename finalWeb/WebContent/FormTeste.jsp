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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<%
	//Cliente usuario = (Cliente) session.getAttribute("usuario"); 
	ArrayList<String> lista = new ArrayList<String>();
	lista.add("Primeiro");
	lista.add("Segundo");
	lista.add("Terceiro");
%>
<script type="text/javascript">
	$(document).ready(function(){
		if(sessionStorage.body != undefined)
			document.getElementById("body").innerHTML = sessionStorage.body;
		// Store
		//localStorage.lastname = "Smith";
		// Retrieve
		//document.getElementById("result").innerHTML = localStorage.lastname;
	});
	function salvar(){
		if (typeof(Storage) !== "undefined") {
			sessionStorage.body = document.getElementById("body").innerHTML;
	    	alert(sessionStorage.body);
		} else {
		    // Sorry! No Web Storage support..
		    alert("deu não");
		}
	}
	function teste() {
		//var teste = '<= usuario.getNome()%>';
		//alert(teste);
		var texto = document.getElementById("txtTeste").value;
		alert("<%=lista.remove("")%>");
		<%for(String s : lista){%>
				if(texto == "<%=s%>")
				{
					alert("<%=lista.indexOf(s)%>");
					var x = "<%=lista.iterator().next()%>";
					alert("achou");
				}
		<%}%>
	}
	function salvarValor(){
		document.getElementById("txtTeste").setAttribute('value',document.getElementById('txtTeste').value);
		document.getElementById("txtTeste1").setAttribute('value',document.getElementById('txtTeste').value);
	}
</script>
</head>
<body id="body">
	<p><button onclick="salvar()" type="button">Salvar</button></p>
	<div id="result"></div>
	<br><br><br>
	<br><br><br>
	<input type="text" id="txtTeste" value="abcd" onchange="salvarValor()">
	<input type="text" id="txtTeste1" value="ab">
	<button onclick="teste()">testar</button>
</body>
</html>