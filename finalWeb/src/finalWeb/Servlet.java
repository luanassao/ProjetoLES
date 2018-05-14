package finalWeb;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import finalCore.aplicacao.Resultado;
import finalDominio.EntidadeDominio;
import finalWeb.command.ICommand;
import finalWeb.command.impl.AddCarrinhoCommand;
import finalWeb.command.impl.AlterarCommand;
import finalWeb.command.impl.AtualizarCarrinhoCommand;
import finalWeb.command.impl.ConsultarCommand;
import finalWeb.command.impl.ExcluirCommand;
import finalWeb.command.impl.LogarCommand;
import finalWeb.command.impl.SalvarCommand;
import finalWeb.command.impl.SelecionarEnderecoCommand;
import finalWeb.command.impl.VisualizarCommand;
import finalWeb.vh.IViewHelper;
import finalWeb.vh.impl.PedidoViewHelper;
import finalWeb.vh.impl.CartaoViewHelper;
import finalWeb.vh.impl.ClienteViewHelper;
import finalWeb.vh.impl.EnderecoViewHelper;
import finalWeb.vh.impl.LivroViewHelper;
import finalWeb.vh.impl.CompraViewHelper;
import finalWeb.vh.impl.DadosViewHelper;

public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static Map<String, ICommand> commands;
	private static Map<String, IViewHelper> vhs;
	
	
    /**
     * Default constructor. 
     */
    public Servlet() {
    	
    	/* Utilizando o command para chamar a fachada e indexando cada command 
    	 * pela opera��o garantimos que esta servelt atender� qualquer opera��o */
    	commands = new HashMap<String, ICommand>();
    	
    	commands.put("SALVAR", new SalvarCommand());
    	commands.put("CONSULTAR", new ConsultarCommand());
    	commands.put("ALTERAR", new AlterarCommand());
    	commands.put("ADICIONAR_AO_CARRINHO", new AlterarCommand());
    	commands.put("REMOVER_DO_CARRINHO", new AlterarCommand());
    	commands.put("VISUALIZAR", new VisualizarCommand());
    	commands.put("EXCLUIR", new ExcluirCommand());
    	commands.put("LOGAR", new LogarCommand());
    	
    	commands.put("SALVAR NOVO", new SalvarCommand());
    	commands.put("SOLICITAR TROCA", new SalvarCommand());
    	commands.put("TROCAR", new SalvarCommand());
    	commands.put("FINALIZAR", new SalvarCommand());
    	commands.put("LISTAR", new ConsultarCommand());
    	commands.put("VERIFICAR", new ConsultarCommand());
    	commands.put("CONFIRMAR", new ConsultarCommand());
    	commands.put("CHECAR", new VisualizarCommand());
    	commands.put("SELECIONAR CUPOM", new AlterarCommand());
    	commands.put("COMPRAR", new AddCarrinhoCommand());
    	commands.put("SELECIONAR", new SelecionarEnderecoCommand());
    	commands.put("ATUALIZAR", new AtualizarCarrinhoCommand());
    	
    	/* Utilizando o ViewHelper para tratar especifica��es de qualquer tela e indexando 
    	 * cada viewhelper pela url em que esta servlet � chamada no form
    	 * garantimos que esta servelt atender� qualquer entidade */
    	
    	vhs = new HashMap<String, IViewHelper>();
    	/*A chave do mapa � o mapeamento da servlet para cada form que 
    	 * est� configurado no web.xml e sendo utilizada no action do html
    	 */
    	vhs.put("/finalWeb/SalvarLivro", new LivroViewHelper());
    	vhs.put("/finalWeb/DadosLivro", new DadosViewHelper());
    	vhs.put("/finalWeb/SalvarCliente", new ClienteViewHelper());
    	vhs.put("/finalWeb/SalvarEndereco", new EnderecoViewHelper());
    	vhs.put("/finalWeb/SalvarCartao", new CartaoViewHelper());
    	vhs.put("/finalWeb/Pedido", new PedidoViewHelper());
    	vhs.put("/finalWeb/SalvarProduto", new CompraViewHelper());
    	vhs.put("/finalWeb/Logar", new ClienteViewHelper());
    	
    	
    }
    
    
    /**
     * TODO Descri��o do M�todo
     * @param req
     * @param resp
     * @throws ServletException
     * @throws IOException
     * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,
    		IOException {
    	doProcessRequest(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcessRequest(request, response);
	}
	
	
	protected void doProcessRequest(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		
		//Obt�m a uri que invocou esta servlet (O que foi definido no methdo do form html)
		String uri = request.getRequestURI();
		
		//Obt�m a opera��o executada
		String operacao = request.getParameter("operacao");
		
		//Obt�m um viewhelper indexado pela uri que invocou esta servlet
		IViewHelper vh = vhs.get(uri);
		
		//O viewhelper retorna a entidade especifica para a tela que chamou esta servlet
		EntidadeDominio entidade =  vh.getEntidade(request);

		//Obt�m o command para executar a respectiva opera��o
		ICommand command = commands.get(operacao);
		
		
		/*Executa o command que chamar� a fachada para executar a opera��o requisitada
		 * o retorno � uma inst�ncia da classe resultado que pode conter mensagens derro 
		 * ou entidades de retorno
		 */
		Resultado resultado = command.execute(entidade);
		
		/*
		 * Executa o m�todo setView do view helper espec�fico para definir como dever� ser apresentado 
		 * o resultado para o usu�rio
		 */
		vh.setView(resultado, request, response);
	
	}
}