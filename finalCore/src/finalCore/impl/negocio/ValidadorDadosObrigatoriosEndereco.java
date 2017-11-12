package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.Endereco;
import finalDominio.EntidadeDominio;

public class ValidadorDadosObrigatoriosEndereco implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Endereco){
			Endereco endereco = (Endereco)entidade;
			
			String tipoResidencia = endereco.getTipoResidencia();
			String tipoLogradouro = endereco.getTipoLogradouro();
			String logradouro = endereco.getLogradouro();
			String numero = endereco.getNumero();
			String bairro = endereco.getBairro();
			String cep = endereco.getCep();
			String estado = endereco.getEstado();
			String cidade = endereco.getCidade();
			String pais = endereco.getPais();
			String observacao = endereco.getObservacao();
			
			if(tipoResidencia == null || tipoLogradouro==null || logradouro == null   || numero == null  ||
					bairro == null || cep == null || estado == null || cidade == null || pais == null   ||  observacao == null){
				return "Todos os dados cadastrais de um endereço são obrigatórios!";
				
			}
			
			if(tipoResidencia.trim().equals("") || 
					tipoLogradouro.trim().equals("")|| logradouro.trim().equals("") || numero.trim().equals("")
					|| bairro.trim().equals("") || cep.trim().equals("") || estado.trim().equals("") ||
					cidade.trim().equals("") || pais.trim().equals("") || observacao.trim().equals("")){
				return "Todos os dados cadastrais de um endereço são obrigatórios!";
			}
			
		}else{
			return "Deve ser registrado um Livro!";
		}
		
		
		return null;
	}
}
