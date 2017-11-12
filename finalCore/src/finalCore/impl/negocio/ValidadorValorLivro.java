package finalCore.impl.negocio;

import java.util.HashMap;
import java.util.Map;

import finalCore.IStrategy;
import finalDominio.EntidadeDominio;
import finalDominio.Livro;

public class ValidadorValorLivro implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Livro){
			Livro livro = (Livro)entidade;
			Map<Character, Double> valores;
			valores = new HashMap<Character, Double>();
			
			valores.put('A', 30.0);
			valores.put('B', 40.0);
			valores.put('C', 50.0);
			valores.put('D', 60.0);
			
			char precificacao = livro.getPrecificacao();
			double preco = livro.getPreco();
			double valor = livro.getValor();
			
			double minimo = preco + preco * (valores.get(precificacao)/100);
			if(valor < minimo)
				return "O valor do livro deve ser igual ou superior a " + minimo;
			
		}else{
			return "Deve ser registrado um Livro!";
		}
		
		
		return null;
	}
}