package auxiliar;

import java.util.Calendar;

public class DadosAnaliseCategoria {
	private String categoria;
	private Calendar dtCompra;
	private Integer quantidade;
	
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public Calendar getDtCompra() {
		return dtCompra;
	}
	public String getDtCompraFormatado() {
		String data = "";
		try {
			data += (dtCompra.get(Calendar.MONTH) + 1 < 10 ? "0" + (dtCompra.get(Calendar.MONTH) + 1) : (dtCompra.get(Calendar.MONTH)) + 1);
			data += "/" + dtCompra.get(Calendar.YEAR);
		}catch (Exception e) {
			// TODO: handle exception
		}
		return data;
	}
	public void setDtCompra(Calendar dtCompra) {
		this.dtCompra = dtCompra;
	}
	public Integer getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}
}
