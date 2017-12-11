package finalCore.util;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import finalDominio.DadosGrafico;
import finalDominio.EntidadeDominio;

public class GerarDadosGrafico {
	public String gerarDadosLivros(List<EntidadeDominio> entidades) {
		ArrayList<DadosGrafico> dados = new ArrayList<DadosGrafico>();
		int i = 0;
      	boolean flag;
      	for(EntidadeDominio e : entidades)
		{
      		flag = false;
      		i = 0;
			DadosGrafico dado = (DadosGrafico)e;
			for(DadosGrafico d : dados)
			{
				if(dado.getTitulo().equals(d.getTitulo()))
				{
					dados.get(i).setQuantidade(dados.get(i).getQuantidade() + dado.getQuantidade());
					flag = true;
		      		break;
				}
	      		i++;
			}
			if (!flag)
			{
				dados.add((DadosGrafico)e);
			}
		}
      	StringBuilder sbRegistro = new StringBuilder();
      	for(DadosGrafico d : dados)
      	{
			sbRegistro.append("['" + d.getTitulo() + "', " + d.getQuantidade() + "],");
      	}
		sbRegistro.deleteCharAt(sbRegistro.length()-1);
		return sbRegistro.toString();
	}
	public String gerarDadosVendaMes(List<EntidadeDominio> entidades) {
		ArrayList<DadosGrafico> dados = new ArrayList<DadosGrafico>();
		int i = 0;
      	boolean flag;
      	for(EntidadeDominio e : entidades)
		{
      		flag = false;
      		i = 0;
			DadosGrafico dado = (DadosGrafico)e;
			for(DadosGrafico d : dados)
			{
				if(dado.getDataCompra().get(Calendar.DATE) == d.getDataCompra().get(Calendar.DATE))
				{
					System.out.println("Encontrado: " + dado.getDtCompraFormatado() + " e: " + d.getDtCompraFormatado() +
							" Quantidade: " + dado.getQuantidade());
					System.out.println("Livro: " + d.getTitulo() + ": " + dados.get(i).getQuantidade() +
							" = " + dados.get(i).getQuantidade() + " + " + dado.getQuantidade());
					dados.get(i).setQuantidade(dados.get(i).getQuantidade() + dado.getQuantidade());
					flag = true;
		      		break;
				}
				i++;
			}
			if (!flag)
			{
				System.out.println("Inserindo Livro: " + dado.getTitulo() + " quantidade: " + dado.getQuantidade());
				dados.add((DadosGrafico)e);
			}
		}
      	StringBuilder sbRegistro = new StringBuilder();
      	for(DadosGrafico d : dados)
      	{
			sbRegistro.append("['" + d.getDtCompraFormatado() + "', " + d.getQuantidade() + "],");
      	}
		sbRegistro.deleteCharAt(sbRegistro.length()-1);
		return sbRegistro.toString();
	}
}
