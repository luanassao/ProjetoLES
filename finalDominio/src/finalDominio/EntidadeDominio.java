package finalDominio;

import java.util.Calendar;

public class EntidadeDominio implements IEntidade{
	private int id = 0;
	private String alterador;
	private Calendar dtCadastro;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAlterador() {
		return alterador;
	}

	public void setAlterador(String alterador) {
		this.alterador = alterador;
	}

	public Calendar getDtCadastro() {
		return dtCadastro;
	}

	public void setDtCadastro(Calendar dtCadastro) {
		this.dtCadastro = dtCadastro;
	}
	public String getDtCadFormatado() {
		String data = "";
		try {
			data += dtCadastro.get(Calendar.DATE) < 10 ? "0" + dtCadastro.get(Calendar.DATE) : dtCadastro.get(Calendar.DATE);
			data += "/" + (dtCadastro.get(Calendar.MONTH) < 10 ? "0" + dtCadastro.get(Calendar.MONTH) : dtCadastro.get(Calendar.MONTH));
			data += "/" + dtCadastro.get(Calendar.YEAR);
		}catch (Exception e) {
			// TODO: handle exception
		}
		return data;
	}
}
