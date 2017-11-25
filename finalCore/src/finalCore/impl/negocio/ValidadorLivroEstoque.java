package finalCore.impl.negocio;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import finalCore.IStrategy;
import finalCore.dao.LivroDAO;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;

public class ValidadorLivroEstoque implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Livro){
			Livro livro = (Livro)entidade;
			LivroDAO livroDAO = new LivroDAO();
			List<EntidadeDominio> livros = new ArrayList<>();
			
			livros = livroDAO.consultar(null);
			
			
		
			
		}else{
			return "Deve ser registrado um Livro!";
		}
		
		
		return null;
	}
}