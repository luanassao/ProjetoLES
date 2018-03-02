package auxiliar;

import java.util.ArrayList;

public class CategoriasAutores {
	private ArrayList<IdDesc> Autores = new ArrayList<>();
	private ArrayList<IdDesc> Categorias = new ArrayList<>();
	
	public ArrayList<IdDesc> getAutores() {
		return Autores;
	}
	public void setAutores(ArrayList<IdDesc> autores) {
		Autores = autores;
	}
	public ArrayList<IdDesc> getCategorias() {
		return Categorias;
	}
	public void setCategorias(ArrayList<IdDesc> categorias) {
		Categorias = categorias;
	}
}
