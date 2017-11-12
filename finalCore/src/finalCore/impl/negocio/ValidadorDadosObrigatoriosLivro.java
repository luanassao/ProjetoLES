package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;

public class ValidadorDadosObrigatoriosLivro implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Livro){
			Livro livro = (Livro)entidade;
			
			String autor = livro.getAutor();
			String ano = livro.getAno();
			String titulo = livro.getTitulo();
			String editora = livro.getEditora();
			String edicao = livro.getEdicao();
			String isbn = livro.getISBN();
			String numPaginas = livro.getNpaginas();
			String sinopse = livro.getSinopse();
			double altura = livro.getAltura();
			double peso = livro.getPeso();
			double profundidade = livro.getProfundidade();
			
			if(autor == null || ano==null || titulo == null   || editora == null  ||
					edicao == null || isbn == null || numPaginas == null || sinopse == null || altura == 0   ||  peso == 0 ||
					profundidade == 0){
				return "Todos os dados cadastrais de um livro são obrigatórios!";
				
			}
			
			if(autor.trim().equals("") || 
					ano.trim().equals("")|| titulo.trim().equals("") || editora.trim().equals("")
					|| edicao.trim().equals("") || isbn.trim().equals("") || numPaginas.trim().equals("") ||
					sinopse.trim().equals("")){
				return "Todos os dados cadastrais de um livro são obrigatórios!";
			}
			
		}else{
			return "Deve ser registrado um Livro!";
		}
		
		
		return null;
	}
}
