package finalCore.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import auxiliar.Categoria;
import auxiliar.DadosAnaliseCategoria;
import auxiliar.DadosAnaliseGenero;
import finalCore.dao.CategoriaDAO;
import finalDominio.DadosGrafico;
import finalDominio.EntidadeDominio;

public class GeradorDadosGrafico {
	public String gerarDadosGraficoCategoria(DadosGrafico dadosGrafico) {
		CategoriaDAO categoriaDAO = new CategoriaDAO();
		ArrayList<String> categorias = new ArrayList<>();
		try {
			List<EntidadeDominio> consultaCat = categoriaDAO.consultar(new Categoria());
			for(EntidadeDominio e : consultaCat) {
				categorias.add(((Categoria)e).getNome());
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		/*
		 * Iniciando a criação do JSON
		 * Inserindo linha de menu
		 */
		StringBuilder sbDados = new StringBuilder();
		sbDados.append("['Data'");
		if(dadosGrafico.getCategorias().size() > 0)
			categorias = dadosGrafico.getCategorias();
		for(String c:categorias) {
			sbDados.append(", '" + c + "'");
		}
		sbDados.append("],\n");
		
		int indiceCategoria = 0;
		Boolean flgDadoCorreto = true;
		Calendar dtAtual = dadosGrafico.getDadosAnaliseCategoria().get(0).getDtCompra();
		/*
		 * Inserindo linhas de dados para gerar o JSON
		 */
		for(DadosAnaliseCategoria dados:dadosGrafico.getDadosAnaliseCategoria()) {
			if(indiceCategoria == 0) {
				dtAtual = dados.getDtCompra();
				sbDados.append("['" + dados.getDtCompraFormatado() + "'");
			}
			do {
				if(dados.getCategoria().equals(categorias.get(indiceCategoria)) && dados.getDtCompra().equals(dtAtual)) {
					sbDados.append(", ");
					sbDados.append(dados.getQuantidade());
					flgDadoCorreto = false;
					if(indiceCategoria == categorias.size() - 1) {
						indiceCategoria = 0;
						sbDados.append("],\n");
					}
					else
						indiceCategoria++;
				}
				else {
					if(indiceCategoria == categorias.size() - 1) {
						indiceCategoria = 0;
						flgDadoCorreto = false;
						sbDados.append("],\n");
					}
					else
						indiceCategoria++;
					sbDados.append(", ");
					sbDados.append(0);
					flgDadoCorreto = true;
				}
			}while(flgDadoCorreto);
		}
		sbDados.deleteCharAt(sbDados.length()-2);
		System.out.println(sbDados.toString());
		return sbDados.toString();
	}
	public String gerarDadosGraficoGenero(DadosGrafico dadosGrafico) {
		ArrayList<String> generos = new ArrayList<>();
		generos.add("Feminino");
		generos.add("Masculino");
		/*
		 * Iniciando a criação do JSON
		 * Inserindo linha de menu
		 */
		StringBuilder sbDados = new StringBuilder();
		sbDados.append("['Data'");
		for(String g:generos) {
			sbDados.append(", '" + g + "'");
		}
		sbDados.append("],\n");
		
		int indiceGenero = 0;
		Boolean flgDadoCorreto = true;
		Calendar dtAtual = dadosGrafico.getDadosAnaliseGenero().get(0).getDtCompra();
		/*
		 * Inserindo linhas de dados para gerar o JSON
		 */
		for(DadosAnaliseGenero dados:dadosGrafico.getDadosAnaliseGenero()) {
			if(indiceGenero == 0) {
				dtAtual = dados.getDtCompra();
				sbDados.append("['" + dados.getDtCompraFormatado() + "'");
			}
			do {
				System.out.println(indiceGenero);
				if(dados.getGenero().equals(generos.get(indiceGenero)) && dados.getDtCompra().equals(dtAtual)) {
					sbDados.append(", ");
					sbDados.append(dados.getQuantidade());
					flgDadoCorreto = false;
					if(indiceGenero == generos.size() - 1) {
						indiceGenero = 0;
						sbDados.append("],\n");
					}
					else
						indiceGenero++;
				}
				else {
					flgDadoCorreto = true;
					if(indiceGenero == generos.size() - 1) {
						indiceGenero = 0;
						sbDados.append(", ");
						sbDados.append(0);
						flgDadoCorreto = false;
						sbDados.append("],\n");
					}
					else {
						indiceGenero++;
						sbDados.append(", ");
						sbDados.append(0);
					}
				}
			}while(flgDadoCorreto);
		}
		sbDados.deleteCharAt(sbDados.length()-2);
		System.out.println(sbDados.toString());
		return sbDados.toString();
	}
}
