package finalDominio;

public class Produto extends EntidadeDominio{
	private int ID_Produto, ID_Carrinho, quantidade, ID_Livro;
	private String titulo, email, senha;
	
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
	public String getTitulo() {
		return titulo;
	}
	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSenha() {
		return senha;
	}
	public void setSenha(String senha) {
		this.senha = senha;
	}
}
