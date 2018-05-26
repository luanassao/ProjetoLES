package auxiliar;

import java.util.Calendar;

public class DadosAnaliseGenero {
	private String genero;
	private Calendar dtCompra;
	private Integer quantidade;
	
	public String getGenero() {
		return genero;
	}
	public void setGenero(String genero) {
		this.genero = genero;
	}
	public Calendar getDtCompra() {
		return dtCompra;
	}
	public String getDtCompraFormatado() {
		String data = "";
		try {
			data += (dtCompra.get(Calendar.MONTH) < 10 ? "0" + dtCompra.get(Calendar.MONTH) : dtCompra.get(Calendar.MONTH));
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
