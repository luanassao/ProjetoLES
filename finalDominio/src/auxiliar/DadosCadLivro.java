package auxiliar;

import java.util.ArrayList;

import finalDominio.EntidadeDominio;

public class DadosCadLivro extends EntidadeDominio{
	private ArrayList<Autor> Autores = new ArrayList<>();
	private ArrayList<Editora> Editoras = new ArrayList<>();
	private ArrayList<Categoria> Categorias = new ArrayList<>();
	private ArrayList<Precificacao> Precificacoes = new ArrayList<>();
	private ArrayList<CategoriaAtivacao> CategoriasAtivacao = new ArrayList<>();
	private ArrayList<CategoriaInativacao> CategoriasInativacao = new ArrayList<>();
	
	public ArrayList<Autor> getAutores() {
		return Autores;
	}
	public void setAutores(ArrayList<Autor> autores) {
		Autores = autores;
	}
	public ArrayList<Editora> getEditoras() {
		return Editoras;
	}
	public void setEditoras(ArrayList<Editora> editoras) {
		Editoras = editoras;
	}
	public ArrayList<Categoria> getCategorias() {
		return Categorias;
	}
	public void setCategorias(ArrayList<Categoria> categorias) {
		Categorias = categorias;
	}
	public ArrayList<Precificacao> getPrecificacoes() {
		return Precificacoes;
	}
	public void setPrecificacoes(ArrayList<Precificacao> precificacoes) {
		Precificacoes = precificacoes;
	}
	public ArrayList<CategoriaAtivacao> getCategoriasAtivacao() {
		return CategoriasAtivacao;
	}
	public void setCategoriasAtivacao(ArrayList<CategoriaAtivacao> categoriasAtivacao) {
		CategoriasAtivacao = categoriasAtivacao;
	}
	public ArrayList<CategoriaInativacao> getCategoriasInativacao() {
		return CategoriasInativacao;
	}
	public void setCategoriasInativacao(ArrayList<CategoriaInativacao> categoriasInativacao) {
		CategoriasInativacao = categoriasInativacao;
	}
}
