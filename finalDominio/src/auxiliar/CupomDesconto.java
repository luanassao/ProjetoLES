package auxiliar;

import finalDominio.EntidadeDominio;

public class CupomDesconto  extends EntidadeDominio{
	private String codigo;
	private double valor;
	
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public double getValor() {
		return valor;
	}
	public void setValor(double valor) {
		this.valor = valor;
	}
}
