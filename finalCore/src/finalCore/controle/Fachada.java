package finalCore.controle;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import finalCore.IDAO;
import finalCore.IFachada;
import finalCore.IStrategy;
import finalCore.aplicacao.Resultado;
import finalCore.dao.CarrinhoDAO;
import finalCore.dao.CartaoDAO;
import finalCore.dao.ClienteDAO;
import finalCore.dao.EnderecoDAO;
import finalCore.dao.LivroDAO;
import finalCore.impl.negocio.ValidadorCpf;
import finalCore.impl.negocio.ValidadorDadosObrigatoriosCartao;
import finalCore.impl.negocio.ValidadorDadosObrigatoriosCliente;
import finalCore.impl.negocio.ValidadorDadosObrigatoriosEndereco;
import finalCore.impl.negocio.ValidadorDadosObrigatoriosLivro;
import finalCore.impl.negocio.ValidadorUsuario;
import finalCore.impl.negocio.ValidadorValorLivro;
import finalDominio.Carrinho;
import finalDominio.Cartao;
import finalDominio.Cliente;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;

public class Fachada implements IFachada{
	/** 
	 * Mapa de DAOS, será indexado pelo nome da entidade 
	 * O valor é uma instância do DAO para uma dada entidade; 
	 */
	private Map<String, IDAO> daos;
	
	/**
	 * Mapa para conter as regras de negócio de todas operações por entidade;
	 * O valor é um mapa que de regras de negócio indexado pela operação
	 */
	private Map<String, Map<String, List<IStrategy>>> rns;
	
	private Resultado resultado;
	
	
	public Fachada(){
		/* Intânciando o Map de DAOS */
		daos = new HashMap<String, IDAO>();
		/* Intânciando o Map de Regras de Negócio */
		rns = new HashMap<String, Map<String, List<IStrategy>>>();
		
		/* Criando instâncias dos DAOs a serem utilizados*/
		LivroDAO livroDAO = new LivroDAO();
		ClienteDAO clienteDAO = new ClienteDAO();
		EnderecoDAO enderecoDAO = new EnderecoDAO();
		CartaoDAO cartaoDAO = new CartaoDAO();
		CarrinhoDAO carrinhoDAO = new CarrinhoDAO();
		
		/* Adicionando cada dao no MAP indexando pelo nome da classe */
		daos.put(Livro.class.getName(), livroDAO);
		daos.put(Cliente.class.getName(), clienteDAO);
		daos.put(Endereco.class.getName(), enderecoDAO);
		daos.put(Cartao.class.getName(), cartaoDAO);
		daos.put(Carrinho.class.getName(), carrinhoDAO);
		
		/* Criando instâncias de regras de negócio a serem utilizados*/
		ValidadorDadosObrigatoriosLivro vrDadosObrigatoriosLivro = new ValidadorDadosObrigatoriosLivro();
		ValidadorValorLivro vrValidadorValorLivro = new ValidadorValorLivro();
		ValidadorCpf vCpf = new ValidadorCpf();
		ValidadorDadosObrigatoriosCliente vrDadosObrigatoriosCliente = new ValidadorDadosObrigatoriosCliente();
		ValidadorDadosObrigatoriosEndereco vrDadosObrigatoriosEndereco = new ValidadorDadosObrigatoriosEndereco();
		ValidadorDadosObrigatoriosCartao vrDadosObrigatoriosCartao = new ValidadorDadosObrigatoriosCartao();
		ValidadorUsuario vrUsuario = new ValidadorUsuario();
		
		/* Criando uma lista para conter as regras de negócio de livro
		 * quando a operação for salvar
		 */
		List<IStrategy> rnsSalvarLivro = new ArrayList<IStrategy>();
		/* Adicionando as regras a serem utilizadas na operação salvar do livro*/
		rnsSalvarLivro.add(vrDadosObrigatoriosLivro);
		rnsSalvarLivro.add(vrValidadorValorLivro);
		
		/* Cria o mapa que poderá conter todas as listas de regras de negócio específica 
		 * por operação  do livro
		 */
		Map<String, List<IStrategy>> rnsLivro = new HashMap<String, List<IStrategy>>();
		/*
		 * Adiciona a listra de regras na operação salvar no mapa do livro (lista criada na linha 70)
		 */
		rnsLivro.put("SALVAR", rnsSalvarLivro);
		rnsLivro.put("ALTERAR", rnsSalvarLivro);
		/* Adiciona o mapa(criado na linha 73) com as regras indexadas pelas operações no mapa geral indexado 
		 * pelo nome da entidade
		 */
		rns.put(Livro.class.getName(), rnsLivro);
		
		/* Criando uma lista para conter as regras de negócio de cliente
		 * quando a operação for salvar
		 */
		List<IStrategy> rnsSalvarCliente = new ArrayList<IStrategy>();
		/* Adicionando as regras a serem utilizadas na operação salvar do cliente */
		rnsSalvarCliente.add(vCpf);
		rnsSalvarCliente.add(vrDadosObrigatoriosCliente);
		
		/* Cria o mapa que poderá conter todas as listas de regras de negócio específica 
		 * por operação do cliente
		 */
		Map<String, List<IStrategy>> rnsCliente = new HashMap<String, List<IStrategy>>();
		/*
		 * Adiciona a listra de regras na operação salvar no mapa do cliente (lista criada na linha 93)
		 */
		rnsCliente.put("SALVAR", rnsSalvarCliente);
		rnsCliente.put("ALTERAR", rnsSalvarCliente);
		/* Adiciona o mapa(criado na linha 101) com as regras indexadas pelas operações no mapa geral indexado 
		 * pelo nome da entidade. Observe que este mapa (rns) é o mesmo utilizado na linha 88.
		 */
		rns.put(Cliente.class.getName(), rnsCliente);
		
		/* Criando uma lista para conter as regras de negócio de endereço
		 * quando a operação for salvar
		 */
		List<IStrategy> rnsSalvarEndereco = new ArrayList<IStrategy>();
		/* Adicionando as regras a serem utilizadas na operação salvar do cliente */
		rnsSalvarEndereco.add(vrDadosObrigatoriosEndereco);
		
		/* Cria o mapa que poderá conter todas as listas de regras de negócio específica 
		 * por operação do cliente
		 */
		Map<String, List<IStrategy>> rnsEndereco = new HashMap<String, List<IStrategy>>();
		/*
		 * Adiciona a listra de regras na operação salvar no mapa do cliente (lista criada na linha 93)
		 */
		rnsEndereco.put("SALVAR", rnsSalvarEndereco);
		rnsEndereco.put("ALTERAR", rnsSalvarEndereco);
		/* Adiciona o mapa(criado na linha 101) com as regras indexadas pelas operações no mapa geral indexado 
		 * pelo nome da entidade. Observe que este mapa (rns) é o mesmo utilizado na linha 88.
		 */
		rns.put(Endereco.class.getName(), rnsEndereco);
		
		/* Criando uma lista para conter as regras de negócio de endereço
		 * quando a operação for salvar
		 */
		List<IStrategy> rnsSalvarCartao = new ArrayList<IStrategy>();
		/* Adicionando as regras a serem utilizadas na operação salvar do cliente */
		rnsSalvarCartao.add(vrDadosObrigatoriosCartao);
		
		/* Cria o mapa que poderá conter todas as listas de regras de negócio específica 
		 * por operação do cliente
		 */
		Map<String, List<IStrategy>> rnsCartao = new HashMap<String, List<IStrategy>>();
		/*
		 * Adiciona a listra de regras na operação salvar no mapa do cliente (lista criada na linha 93)
		 */
		rnsCartao.put("SALVAR", rnsSalvarCartao);
		rnsCartao.put("ALTERAR", rnsSalvarCartao);
		/* Adiciona o mapa(criado na linha 101) com as regras indexadas pelas operações no mapa geral indexado 
		 * pelo nome da entidade. Observe que este mapa (rns) é o mesmo utilizado na linha 88.
		 */
		rns.put(Cartao.class.getName(), rnsCartao);
		
		/* Criando uma lista para conter as regras de negócio de carrinho
		 * quando a operação for salvar
		 */
		List<IStrategy> rnsSalvarCarrinho = new ArrayList<IStrategy>();
		/* Adicionando as regras a serem utilizadas na operação salvar do carrinho*/
		
		
		/* Cria o mapa que poderá conter todas as listas de regras de negócio específica 
		 * por operação  do carrinho
		 */
		Map<String, List<IStrategy>> rnsCarrinho = new HashMap<String, List<IStrategy>>();
		/*
		 * Adiciona a listra de regras na operação salvar no mapa do carrinho (lista criada na linha 70)
		 */
		rnsCarrinho.put("SALVAR", rnsSalvarCarrinho);
		rnsCarrinho.put("ALTERAR", rnsSalvarCarrinho);
		/* Adiciona o mapa(criado na linha 73) com as regras indexadas pelas operações no mapa geral indexado 
		 * pelo nome da entidade
		 */
		rns.put(Carrinho.class.getName(), rnsCarrinho);
		
		/* Criando uma lista para conter as regras de negócio de produto
		 * quando a operação for salvar
		 */
		List<IStrategy> rnsLogar = new ArrayList<IStrategy>();
		/* Adicionando as regras a serem utilizadas na operação salvar do carrinho*/
		rnsLogar.add(vrUsuario);
		
		/* Cria o mapa que poderá conter todas as listas de regras de negócio específica 
		 * por operação  do livro
		 */
		Map<String, List<IStrategy>> rnsLogin = new HashMap<String, List<IStrategy>>();
		/*
		 * Adiciona a listra de regras na operação salvar no mapa do livro (lista criada na linha 70)
		 */
		rnsLogin.put("LOGAR", rnsLogar);
		
		/* Adiciona o mapa(criado na linha 73) com as regras indexadas pelas operações no mapa geral indexado 
		 * pelo nome da entidade
		 */
		rns.put(Cliente.class.getName(), rnsLogin);
	}
	
	
	@Override
	public Resultado salvar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String nmClasse = entidade.getClass().getName();
		
		String msg = executarRegras(entidade, "SALVAR");
		
		
		if(msg == null){
			IDAO dao = daos.get(nmClasse);
			try {
				dao.salvar(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possível realizar o registro!");
				
			}
		}else{
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado consultar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String nmClasse = entidade.getClass().getName();	
		
		String msg = executarRegras(entidade, "EXCLUIR");
		
		
		if(msg == null){
			IDAO dao = daos.get(nmClasse);
			try {
				
				resultado.setEntidades(dao.consultar(entidade));
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possível realizar a consulta!");
				
			}
		}else{
			resultado.setMsg(msg);
			
		}
		
		return resultado;

	}
	
	@Override
	public Resultado visualizar(EntidadeDominio entidade) {
		resultado = new Resultado();
		resultado.setEntidades(new ArrayList<EntidadeDominio>(1));
		resultado.getEntidades().add(entidade);		
		return resultado;

	}

	
	private String executarRegras(EntidadeDominio entidade, String operacao){
		String nmClasse = entidade.getClass().getName();		
		StringBuilder msg = new StringBuilder();
		
		Map<String, List<IStrategy>> regrasOperacao = rns.get(nmClasse);
		
		
		if(regrasOperacao != null){
			List<IStrategy> regras = regrasOperacao.get(operacao);
			
			if(regras != null){
				for(IStrategy s: regras){			
					String m = s.processar(entidade);			
					
					if(m != null){
						msg.append(m);
						msg.append("\n");
					}			
				}	
			}			
			
		}
		
		if(msg.length()>0)
			return msg.toString();
		else
			return null;
	}


	@Override
	public Resultado alterar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String nmClasse = entidade.getClass().getName();	
		
		String msg = executarRegras(entidade, "ALTERAR");
	
		if(msg == null){
			IDAO dao = daos.get(nmClasse);
			try {
				dao.alterar(entidade);
				List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
				entidades.add(entidade);
				resultado.setEntidades(entidades);
			} catch (SQLException e) {
				e.printStackTrace();
				resultado.setMsg("Não foi possível realizar o registro!");
				
			}
		}else{
			resultado.setMsg(msg);
		}
		return resultado;
	}
	
	
	@Override
	public Resultado excluir(EntidadeDominio entidade) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public Resultado logar(EntidadeDominio entidade) {
		resultado = new Resultado();
		String msg = executarRegras(entidade, "LOGAR");
		
		if(msg == null){
			List<EntidadeDominio> entidades = new ArrayList<EntidadeDominio>();
			entidades.add(entidade);
			resultado.setEntidades(entidades);
		}else{
			resultado.setMsg(msg);
		}
		return resultado;
	}

	@Override
	public Resultado adicionarAoCarrinho(EntidadeDominio entidade) {
		
		return null;
	}
	
	
}
