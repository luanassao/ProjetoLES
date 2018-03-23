package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;

public class ValidadorValorLivro implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Livro){
			Livro livro = (Livro)entidade;
			Double minimo = ((livro.getPrecificacao().getMargem()/100) + 1) * livro.getPreco();
			
			if(minimo < livro.getValor())
			{
				return null;
			}
			else
				return "O valor do livro deve ser igual ou superior a " + minimo;
			
		}else{
			return "Deve ser registrado um Livro!";
		}
		
	}
}