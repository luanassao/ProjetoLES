package finalCore.impl.negocio;

import java.util.ArrayList;
import java.util.List;
import finalCore.IStrategy;
import finalCore.dao.LivroDAO;
import finalDominio.Carrinho;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;

public class ValidadorLivroEstoque implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Carrinho){
			Carrinho carrinho = (Carrinho)entidade;
			LivroDAO livroDAO = new LivroDAO();
			List<EntidadeDominio> livros = new ArrayList<>();
			List<Produto> produtos = new ArrayList<>();
			produtos = carrinho.getProdutos();
			Livro livro;
			
			livros = livroDAO.consultar(new Livro());
			
			for(Produto p : produtos)
			{
				for(EntidadeDominio e : livros)
				{
					livro = (Livro)e;
					if(p.getLivro().getId() == livro.getId())
					{
						if(p.getQuantidade() > livro.getEstoque())
						{
							p.setMensagem("Só há " + livro.getEstoque() + " livros disponíveis!");
							break;
						}
					}
					
					
				}
			}
			
			
		}else{
			return "Deve ser registrado um Carrinho!";
		}
		
		
		return null;
	}
}