package Teste;

import java.util.Calendar;

import finalCore.dao.ClienteDAO;
import finalDominio.Cliente;

public class Principal {

	public static void main(String[] args) {
		ClienteDAO Cdao = new ClienteDAO();
		Cliente cliente = new Cliente();
		Calendar c = Calendar.getInstance();
		Calendar d = Calendar.getInstance();
		c.set(2014, 9, 6);
		d.set(2016, 9, 6);
		cliente.setNome("teste02");
		cliente.setCpf("123456789");
		cliente.setStatus(true);
		cliente.setDtnascimento(c);
		System.out.println(cliente.getDtnascimento().get(Calendar.YEAR));
		System.out.println((d.get(Calendar.DATE) < 10 ? "0" + d.get(Calendar.DATE) : d.get(Calendar.DATE)) + "/" + (d.get(Calendar.MONTH) < 10 ? "0" + d.get(Calendar.MONTH) : d.get(Calendar.MONTH)) + "/" + d.get(Calendar.YEAR));
		try {
			Cdao.salvar(cliente);
		}catch (Exception e) {
			// TODO: handle exception
		}
	}
}
