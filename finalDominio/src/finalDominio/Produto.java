package finalDominio;

public class Produto extends EntidadeDominio{
	private int ID_Produto, ID_Carrinho, quantidade = 0, ID_Livro;
	private double preco;
	private Livro livro;
	private String mensagem;
	
	public int getID_Produto() {
		return ID_Produto;
	}
	public void setID_Produto(int iD_Produto) {
		ID_Produto = iD_Produto;
	}
	public int getID_Carrinho() {
		return ID_Carrinho;
	}
	public void setID_Carrinho(int iD_Carrinho) {
		ID_Carrinho = iD_Carrinho;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public int getID_Livro() {
		return ID_Livro;
	}
	public void setID_Livro(int iD_Livro) {
		ID_Livro = iD_Livro;
	}
	public Livro getLivro() {
		return livro;
	}
	public void setLivro(Livro livro) {
		this.livro = livro;
	}
	public double getPreco() {
		return preco;
	}
	public void setPreco(double preco) {
		this.preco = preco;
	}
	public String getMensagem() {
		return mensagem;
	}
	public void setMensagem(String mensagem) {
		this.mensagem = mensagem;
	}
}
