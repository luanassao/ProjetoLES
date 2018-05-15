package finalDominio;

public class Produto extends EntidadeDominio{
	private int ID_Produto, ID_Pedido, quantidade = 0, ID_Livro, quantidadeAnt;
	private double preco;
	private Livro livro;
	private String mensagem;
	
	public int getID_Produto() {
		return ID_Produto;
	}
	public void setID_Produto(int iD_Produto) {
		ID_Produto = iD_Produto;
	}
	public int getID_Pedido() {
		return ID_Pedido;
	}
	public void setID_Pedido(int iD_Carrinho) {
		ID_Pedido = iD_Carrinho;
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
	public int getQuantidadeAnt() {
		return quantidadeAnt;
	}
	public void setQuantidadeAnt(int quantidadeAnt) {
		this.quantidadeAnt = quantidadeAnt;
	}
}
