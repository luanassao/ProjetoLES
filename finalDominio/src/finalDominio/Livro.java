package finalDominio;

import java.util.ArrayList;

import auxiliar.Alterador;
import auxiliar.Autor;
import auxiliar.Categoria;
import auxiliar.Editora;
import auxiliar.Precificacao;

public class Livro extends EntidadeDominio{
	private String ano, titulo, edicao, ISBN, npaginas, sinopse;
	private Boolean status;
	private double altura, largura, peso, profundidade, preco, valor;
	private int estoque;
	private String motivo;
	private Autor autor;
	private Editora editora;
	private Precificacao precificacao;
	private Alterador alterador;
	private ArrayList<Categoria> categorias = new ArrayList<>();

	public Alterador getAlterador() {
		return alterador;
	}

	public void setAlterador(Alterador alterador) {
		this.alterador = alterador;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}

	public String getAno() {
		return ano;
	}

	public void setAno(String ano) {
		this.ano = ano;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getEdicao() {
		return edicao;
	}

	public void setEdicao(String edicao) {
		this.edicao = edicao;
	}

	public String getISBN() {
		return ISBN;
	}

	public void setISBN(String iSBN) {
		ISBN = iSBN;
	}

	public String getNpaginas() {
		return npaginas;
	}

	public void setNpaginas(String npaginas) {
		this.npaginas = npaginas;
	}

	public String getSinopse() {
		return sinopse;
	}

	public void setSinopse(String sinopse) {
		this.sinopse = sinopse;
	}

	public double getAltura() {
		return altura;
	}

	public void setAltura(double altura) {
		this.altura = altura;
	}

	public double getLargura() {
		return largura;
	}

	public void setLargura(double largura) {
		this.largura = largura;
	}

	public double getPeso() {
		return peso;
	}

	public void setPeso(double peso) {
		this.peso = peso;
	}

	public double getProfundidade() {
		return profundidade;
	}

	public void setProfundidade(double profundidade) {
		this.profundidade = profundidade;
	}

	public double getPreco() {
		return preco;
	}

	public void setPreco(double preco) {
		this.preco = preco;
	}

	public double getValor() {
		return valor;
	}

	public void setValor(double valor) {
		this.valor = valor;
	}

	public int getEstoque() {
		return estoque;
	}

	public void setEstoque(int estoque) {
		this.estoque = estoque;
	}

	public String getMotivo() {
		return motivo;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

	public ArrayList<Categoria> getCategorias() {
		return categorias;
	}

	public void setCategorias(ArrayList<Categoria> categorias) {
		this.categorias = categorias;
	}

	public Autor getAutor() {
		return autor;
	}

	public void setAutor(Autor autor) {
		this.autor = autor;
	}

	public Editora getEditora() {
		return editora;
	}

	public void setEditora(Editora editora) {
		this.editora = editora;
	}

	public Precificacao getPrecificacao() {
		return precificacao;
	}

	public void setPrecificacao(Precificacao precificacao) {
		this.precificacao = precificacao;
	}
	
}
