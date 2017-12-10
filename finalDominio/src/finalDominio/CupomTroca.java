package finalDominio;

public class CupomTroca extends EntidadeDominio{
	private int ID_Cliente, ID_Carrinho;
	private double valor = 0.0;
	private Boolean status;
	
	public int getID_Cliente() {
		return ID_Cliente;
	}
	public void setID_Cliente(int iD_Cliente) {
		ID_Cliente = iD_Cliente;
	}
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
	public int getID_Carrinho() {
		return ID_Carrinho;
	}
	public void setID_Carrinho(int iD_Carrinho) {
		ID_Carrinho = iD_Carrinho;
	}
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
}
