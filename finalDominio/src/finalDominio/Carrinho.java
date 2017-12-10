package finalDominio;

import java.util.ArrayList;
import java.util.List;

public class Carrinho extends EntidadeDominio{
	private ArrayList<Produto> produtos = new ArrayList<>();
	private List<CupomTroca> cupons = new ArrayList<>();
	private Endereco enderecoEntrega;
	private Cartao cartao;
	private int ID_Cliente, idEndereco, idPedido;
	private double frete = 0.0, valorLivros = 0.0, valorTotal = 0.0;
	private String formaPagamento, status, email;
	private Cupom cupom;
	private CupomTroca cupomTroca;
	
	public void AdicionarLivro(Produto produto)
	{
		produtos.add(produto);
	}

	public ArrayList<Produto> getProdutos() {
		return produtos;
	}

	public void setProdutos(ArrayList<Produto> produtos) {
		this.produtos = produtos;
	}

	public Endereco getEnderecoEntrega() {
		return enderecoEntrega;
	}

	public void setEnderecoEntrega(Endereco enderecoEntrega) {
		this.enderecoEntrega = enderecoEntrega;
	}

	public int getID_Cliente() {
		return ID_Cliente;
	}

	public void setID_Cliente(int iD_Cliente) {
		ID_Cliente = iD_Cliente;
	}

	public double getFrete() {
		return frete;
	}

	public void setFrete(double frete) {
		this.frete = frete;
	}

	public double getValorLivros() {
		return valorLivros;
	}

	public void setValorLivros(double valorLivros) {
		this.valorLivros = valorLivros;
	}

	public double getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(double valorTotal) {
		this.valorTotal = valorTotal;
	}

	public String getFormaPagamento() {
		return formaPagamento;
	}

	public void setFormaPagamento(String formaPagamento) {
		this.formaPagamento = formaPagamento;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getIdEndereco() {
		return idEndereco;
	}

	public void setIdEndereco(int idEndereco) {
		this.idEndereco = idEndereco;
	}

	public int getIdPedido() {
		return idPedido;
	}

	public void setIdPedido(int idPedido) {
		this.idPedido = idPedido;
	}

	public Cupom getCupom() {
		return cupom;
	}

	public void setCupom(Cupom cupom) {
		this.cupom = cupom;
	}

	public Cartao getCartao() {
		return cartao;
	}

	public void setCartao(Cartao cartao) {
		this.cartao = cartao;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public CupomTroca getCupomTroca() {
		return cupomTroca;
	}

	public void setCupomTroca(CupomTroca cupomTroca) {
		this.cupomTroca = cupomTroca;
	}

	public ArrayList<CupomTroca> getCupons() {
		return (ArrayList<CupomTroca>) cupons;
	}

	public void setCupons(ArrayList<CupomTroca> cupons) {
		this.cupons = cupons;
	}
}
