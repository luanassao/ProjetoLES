package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;

public class ValidadorDadosAtivInativ implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Livro){
			Livro livro = (Livro)entidade;
			
			if(livro.getMotivo() == null || livro.getMotivo().trim().equals(""))
				return "É necessário informar um motivo!";
			
			if(livro.getStatus() && (livro.getCatAtivacao() == null))
				return "É necessário selecionar uma categoria de ativação";
			
			if((!livro.getStatus()) && livro.getCatInativacao() == null)
				return "É necessario selecionar uma categoria de inativação";
			
		}else{
			return "Deve ser registrado um Livro!";
		}
		
		
		return null;
	}
}