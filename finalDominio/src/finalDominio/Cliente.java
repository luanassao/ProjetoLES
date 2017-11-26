package finalDominio;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class Cliente extends EntidadeDominio{
	private String nome, cpf, tipoTelefone, telefone, email, senha, genero;
	private Boolean status;
	private Calendar dtnascimento;
	List<Endereco> enderecos = new ArrayList<>();
	List<Cartao> cartoes = new ArrayList<>();
	private Cartao cartao;
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
	public Calendar getDtnascimento() {
		return dtnascimento;
	}
	public void setDtnascimento(Calendar dtnascimento) {
		this.dtnascimento = dtnascimento;
	}
	public String getDtnascFormatado() {
		String data = "";
		data += dtnascimento.get(Calendar.DATE) < 10 ? "0" + dtnascimento.get(Calendar.DATE) : dtnascimento.get(Calendar.DATE);
		data += "/" + (dtnascimento.get(Calendar.MONTH) < 10 ? "0" + dtnascimento.get(Calendar.MONTH) : dtnascimento.get(Calendar.MONTH));
		data += "/" + dtnascimento.get(Calendar.YEAR);
		return data;
	}
	public String getCpf() {
		return cpf;
	}
	public void setCpf(String cpf) {
		this.cpf = cpf;
	}
	public String getTipoTelefone() {
		return tipoTelefone;
	}
	public void setTipoTelefone(String tipoTelefone) {
		this.tipoTelefone = tipoTelefone;
	}
	public String getTelefone() {
		return telefone;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
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
	public String getGenero() {
		return genero;
	}
	public void setGenero(String genero) {
		this.genero = genero;
	}
	public Cartao getCartao() {
		return cartao;
	}
	public void setCartao(Cartao cartao) {
		this.cartao = cartao;
	}
	public List<Endereco> getEnderecos() {
		return enderecos;
	}
	public void setEnderecos(List<Endereco> enderecos) {
		this.enderecos = enderecos;
	}
	public List<Cartao> getCartoes() {
		return cartoes;
	}
	public void setCartoes(List<Cartao> cartoes) {
		this.cartoes = cartoes;
	}
	
}
