package finalCore.impl.negocio;

import java.util.ArrayList;
import java.util.List;
import finalCore.IStrategy;
import finalCore.dao.LivroDAO;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;
import finalDominio.Produto;

public class ValidadorLivroEstoque implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Produto){
			Produto produto = (Produto)entidade;
			LivroDAO livroDAO = new LivroDAO();
			List<EntidadeDominio> livros = new ArrayList<>();
			Livro livro;
			
			livros = livroDAO.consultar(new Livro());
			for(EntidadeDominio e : livros)
			{
				livro = (Livro)e;
				if(produto.getQuantidade() > livro.getEstoque())
					return "Só há " + livro.getEstoque() + " livros disponíveis!";
			}
			
		}else{
			return "Deve ser registrado um Produto!";
		}
		
		
		return null;
	}
}