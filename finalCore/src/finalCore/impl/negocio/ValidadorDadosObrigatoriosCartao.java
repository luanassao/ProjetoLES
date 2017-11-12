package finalCore.impl.negocio;

import finalCore.IStrategy;
import finalDominio.Cartao;
import finalDominio.EntidadeDominio;

public class ValidadorDadosObrigatoriosCartao implements IStrategy{
	@Override
	public String processar(EntidadeDominio entidade) {
		
		if(entidade instanceof Cartao){
			Cartao cartao = (Cartao)entidade;
			
			String titular = cartao.getTitular();
			String numero = cartao.getNumero();
			String codigo = cartao.getCodigo();
			
			if(titular == null || numero==null || codigo == null){
				return "Todos os dados cadastrais de um cliente são obrigatórios!";
			}
			
			if(titular.trim().equals("") || numero.trim().equals("")|| codigo.trim().equals("")){
				return "Todos os dados cadastrais de um cliente são obrigatórios!";
			}
			
		}else{
			return "Deve ser registrado um Cartao!";
		}
		
		
		return null;
	}
}