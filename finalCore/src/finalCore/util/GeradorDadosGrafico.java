package finalCore.util;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import auxiliar.Categoria;
import auxiliar.DadosAnaliseCategoria;
import finalCore.dao.CategoriaDAO;
import finalDominio.DadosGrafico;
import finalDominio.EntidadeDominio;

public class GeradorDadosGrafico {
	public String gerarDadosGrafico(DadosGrafico dadosGrafico) {
		/*
		['Mes', 'Terror', 'Aventura', 'Ação', 'Matemática', 'Historia'],
        ['2018/01',  320,      147,         542,             998,           422],
        ['2018/02',  240,      424,         867,             654,           354],
        ['2018/03',  361,      127,         542,             852,           464],
        ['2018/04',  121,      845,         255,             572,           543],
        ['2018/05',  165,      938,         365,             998,           450],
        ['2018/06',  135,      1120,        599,             1268,          288],
        ['2018/07',  157,      1167,        587,             807,           397],
        ['2018/08',  139,      1110,        615,             968,           215],
        ['2018/09',  360,      501,		 412,             754,           942],
        ['2018/10',  114,      239,         456,             354,           551],
        ['2018/11',  120,      900,         450,             968,           215],
        ['2018/12',  136,      691,         629,             1026,          366]
        */
		System.out.println("Gerador dados gráfico!");
		CategoriaDAO categoriaDAO = new CategoriaDAO();
		ArrayList<String> categorias = new ArrayList<>();
		try {
			List<EntidadeDominio> consultaCat = categoriaDAO.consultar(new Categoria());
			for(EntidadeDominio e : consultaCat) {
				categorias.add(((Categoria)e).getNome());
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		/*
		 * Iniciando a criação do JSON
		 * Inserindo linha de menu
		 */
		StringBuilder sbDados = new StringBuilder();
		sbDados.append("['Data'");
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
				System.out.println("Comparando: Categoria - " + dados.getCategoria() + " com - " + categorias.get(indiceCategoria));
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
				System.out.println(sbDados.toString() + "\n\n\n");
			}while(flgDadoCorreto);
		}
		sbDados.deleteCharAt(sbDados.length()-2);
		System.out.println(sbDados.toString());
		return sbDados.toString();
	}
}
