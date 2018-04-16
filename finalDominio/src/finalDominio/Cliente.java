package finalDominio;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import auxiliar.Alterador;

public class Cliente extends EntidadeDominio{
	private String nome, cpf, tipoTelefone, telefone, email, senha, genero;
	private Boolean status, administrador;
	private Calendar dtnascimento, dtCadastro;
	private List<Endereco> enderecos = new ArrayList<>();
	private List<Cartao> cartoes = new ArrayList<>();
	private List<Carrinho> pedidos = new ArrayList<>();
	private List<CupomTroca> cupons = new ArrayList<>();
	private Cartao cartao;
	private Alterador alterador;
	
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
	public List<Carrinho> getPedidos() {
		return pedidos;
	}
	public void setPedidos(List<Carrinho> pedidos) {
		this.pedidos = pedidos;
	}
	public Boolean getAdministrador() {
		return administrador;
	}
	public void setAdministrador(Boolean administrador) {
		this.administrador = administrador;
	}
	public List<CupomTroca> getCupons() {
		return cupons;
	}
	public void setCupons(List<CupomTroca> cupons) {
		this.cupons = cupons;
	}
	public Alterador getAlterador() {
		return alterador;
	}
	public void setAlterador(Alterador alterador) {
		this.alterador = alterador;
	}
	
}
