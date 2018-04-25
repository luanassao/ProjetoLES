package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.Cliente;
import finalDominio.EntidadeDominio;

public class ValidadorCpf implements IStrategy {
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Cliente){
			Cliente c = (Cliente)entidade;
			
			if(c.getCpf().length() < 1){
				return "CPF deve conter 14 digitos!";
			}
			
		}else{
			return "CPF n�o pode ser v�lidado, pois entidade n�o � um cliente!";
		}
		
		
		return null;
	}
}
