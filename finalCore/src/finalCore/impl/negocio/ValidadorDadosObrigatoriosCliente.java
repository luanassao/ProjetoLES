package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.Cliente;
import finalDominio.EntidadeDominio;

public class ValidadorDadosObrigatoriosCliente implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Cliente){
			Cliente cliente = (Cliente)entidade;
			
			String nome = cliente.getNome();
			String cpf = cliente.getCpf();
			String tipoTelefone = cliente.getTipoTelefone();
			String telefone = cliente.getTelefone();
			String email = cliente.getEmail();
			String genero = cliente.getGenero();
			
			if(nome == null || cpf==null || tipoTelefone == null   || telefone == null  ||
					email == null || genero == null){
				return "Todos os dados cadastrais de um cliente são obrigatórios!";
				
			}
			
			if(nome.trim().equals("") || 
					cpf.trim().equals("")|| tipoTelefone.trim().equals("") || telefone.trim().equals("")
					|| email.trim().equals("") || genero.trim().equals("")){
				return "Todos os dados cadastrais de um cliente são obrigatórios!";
			}
			
		}else{
			return "Deve ser registrado um Cliente!";
		}
		
		
		return null;
	}
}
