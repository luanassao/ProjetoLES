package auxiliar;

import java.util.ArrayList;

import finalDominio.EntidadeDominio;

public class DadosCadLivro extends EntidadeDominio{
	private ArrayList<Autor> Autores = new ArrayList<>();
	private ArrayList<DadosBasicos> Editoras = new ArrayList<>();
	private ArrayList<DadosBasicos> Categorias = new ArrayList<>();
	private ArrayList<DadosBasicos> Precificacoes = new ArrayList<>();
	private ArrayList<DadosBasicos> CategoriasAtivacao = new ArrayList<>();
	private ArrayList<DadosBasicos> CategoriasInativacao = new ArrayList<>();
	
	public ArrayList<Autor> getAutores() {
		return Autores;
	}
	public void setAutores(ArrayList<Autor> autores) {
		Autores = autores;
	}
	public ArrayList<DadosBasicos> getEditoras() {
		return Editoras;
	}
	public void setEditoras(ArrayList<DadosBasicos> editoras) {
		Editoras = editoras;
	}
	public ArrayList<DadosBasicos> getCategorias() {
		return Categorias;
	}
	public void setCategorias(ArrayList<DadosBasicos> categorias) {
		Categorias = categorias;
	}
	public ArrayList<DadosBasicos> getPrecificacoes() {
		return Precificacoes;
	}
	public void setPrecificacoes(ArrayList<DadosBasicos> precificacoes) {
		Precificacoes = precificacoes;
	}
	public ArrayList<DadosBasicos> getCategoriasAtivacao() {
		return CategoriasAtivacao;
	}
	public void setCategoriasAtivacao(ArrayList<DadosBasicos> categoriasAtivacao) {
		CategoriasAtivacao = categoriasAtivacao;
	}
	public ArrayList<DadosBasicos> getCategoriasInativacao() {
		return CategoriasInativacao;
	}
	public void setCategoriasInativacao(ArrayList<DadosBasicos> categoriasInativacao) {
		CategoriasInativacao = categoriasInativacao;
	}
}
