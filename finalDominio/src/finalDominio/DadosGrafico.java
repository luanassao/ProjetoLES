package finalDominio;

import java.util.Calendar;

public class DadosGrafico extends EntidadeDominio{
	private int id_Carrinho, id_Livro, quantidade;
	private String autor, categoria, titulo;
	private double valor_livros;
	Calendar dataCompra;
	
	public int getId_Carrinho() {
		return id_Carrinho;
	}
	public void setId_Carrinho(int id_Carrinho) {
		this.id_Carrinho = id_Carrinho;
	}
	public int getId_Livro() {
		return id_Livro;
	}
	public void setId_Livro(int id_Livro) {
		this.id_Livro = id_Livro;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public String getAutor() {
		return autor;
	}
	public void setAutor(String autor) {
		this.autor = autor;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public double getValor_livros() {
		return valor_livros;
	}
	public void setValor_livros(double valor_livros) {
		this.valor_livros = valor_livros;
	}
	public Calendar getDataCompra() {
		return dataCompra;
	}
	public void setDataCompra(Calendar dataCompra) {
		this.dataCompra = dataCompra;
	}
	public String getDtCompraFormatado() {
		String data = "";
		try {
			data += dataCompra.get(Calendar.DATE) < 10 ? "0" + dataCompra.get(Calendar.DATE) : dataCompra.get(Calendar.DATE);
			data += "/" + (dataCompra.get(Calendar.MONTH) < 10 ? "0" + dataCompra.get(Calendar.MONTH) : dataCompra.get(Calendar.MONTH));
			data += "/" + dataCompra.get(Calendar.YEAR);
		}catch (Exception e) {
			// TODO: handle exception
		}
		return data;
	}
}
