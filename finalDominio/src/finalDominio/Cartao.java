package finalDominio;

import java.util.Calendar;

public class Cartao extends EntidadeDominio {
	
	private String titular, numero, codigo;
	private int ID_Cliente;
	private Boolean preferencial;
	private Calendar validade;
	
	public String getTitular() {
		return titular;
	}
	public void setTitular(String titular) {
		this.titular = titular;
	}
	public String getNumero() {
		return numero;
	}
	public void setNumero(String numero) {
		this.numero = numero;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public int getID_Cliente() {
		return ID_Cliente;
	}
	public void setID_Cliente(int iD_Cliente) {
		ID_Cliente = iD_Cliente;
	}
	public Calendar getValidade() {
		return validade;
	}
	public String getValidadeFormatado() {
		String data = "";
		data += validade.get(Calendar.DATE) < 10 ? "0" + validade.get(Calendar.DATE) : validade.get(Calendar.DATE);
		data += "/" + (validade.get(Calendar.MONTH) < 10 ? "0" + validade.get(Calendar.MONTH) : validade.get(Calendar.MONTH));
		data += "/" + validade.get(Calendar.YEAR);
		return data;
	}
	public void setValidade(Calendar validade) {
		this.validade = validade;
	}
	public Boolean getPreferencial() {
		return preferencial;
	}
	public void setPreferencial(Boolean preferencial) {
		this.preferencial = preferencial;
	}
}
