package finalCore.impl.negocio;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import finalCore.IStrategy;
import finalCore.dao.CarrinhoDAO;
import finalCore.dao.LivroDAO;
import finalDominio.Carrinho;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;

public class AdicionadorCustoCompra implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Produto){
			Produto produto = (Produto)entidade;
			CarrinhoDAO caDAO = new CarrinhoDAO();
			LivroDAO liDAO = new LivroDAO();
			List<EntidadeDominio> carrinhos = new ArrayList<>();
			List<EntidadeDominio> livros = new ArrayList<>();
			Livro livro = new Livro();
			Carrinho carrinho = new Carrinho();
			
			try {
				carrinhos = caDAO.consultar(carrinho);
				livros = liDAO.consultar(livro);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
			}
			
			int id = produto.getID_Carrinho();
			String email = produto.getEmail();
			String senha = produto.getSenha();
			Carrinho ca;
			Livro li;
			
			for(EntidadeDominio l : livros)
			{
				li = (Livro)l;
				if(produto.getTitulo().equals(li.getTitulo()))
				{
					produto.setID_Livro(li.getId());
					livro = li;
				}
			}
			for(EntidadeDominio l : livros)
			{
				li = (Livro)l;
				if(produto.getID_Livro() == li.getId())
					livro = li;
			}
			
			for(EntidadeDominio c : carrinhos)
			{
				ca = (Carrinho)c;
				System.out.println("AdicionadorCusto");
				if(ca.getEmail().equals(email) && ca.getSenha().equals(senha) && ca.getId() == id)
				{
					ca.setFrete(ca.getIdEndereco()%2==0? 20 : 40);
					ca.setValorLivros(ca.getValorLivros() + (livro.getValor() * produto.getQuantidade()));
					ca.setValorTotal(ca.getValorTotal() + ca.getFrete());
					ca.setValorTotal(ca.getValorTotal() + ca.getValorLivros());
					System.out.println("id do carrinho: " + id + " Valor total: " + ca.getValorTotal());
					try {
						caDAO.alterar(ca);
					} catch (SQLException e) {
						
					}
					return null;
				}
			}
			
		}else{
			return "Deve ser registrado um produto!";
		}
		
		
		return "Erro na atualização de custo!";
	}
}