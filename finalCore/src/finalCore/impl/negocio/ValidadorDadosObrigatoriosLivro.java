package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;

public class ValidadorDadosObrigatoriosLivro implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Livro){
			Livro livro = (Livro)entidade;
			
			String ano = livro.getAno();
			String titulo = livro.getTitulo();
			String edicao = livro.getEdicao();
			String isbn = livro.getISBN();
			String numPaginas = livro.getNpaginas();
			String sinopse = livro.getSinopse();
			double altura = livro.getAltura();
			double peso = livro.getPeso();
			double profundidade = livro.getProfundidade();
			
			if(ano==null || titulo == null   || edicao == null || isbn == null || 
					numPaginas == null || sinopse == null || altura == 0   ||  peso == 0 ||
					profundidade == 0){
				return "Todos os dados cadastrais de um livro são obrigatórios!";
				
			}
			
			if(ano.trim().equals("")|| titulo.trim().equals("") || edicao.trim().equals("") 
					|| isbn.trim().equals("") || numPaginas.trim().equals("") ||
					sinopse.trim().equals("")){
				return "Todos os dados cadastrais de um livro são obrigatórios!";
			}
			
			if(livro.getAutor() == null || livro.getEditora() == null || livro.getCategorias() == null 
					||  livro.getPrecificacao() == null){
				return "Todos os dados cadastrais de um livro são obrigatórios!";
			}
			
		}else{
			return "Deve ser registrado um Livro!";
		}
		
		
		return null;
	}
}
