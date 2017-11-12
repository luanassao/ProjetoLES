package finalCore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
	public static Connection getConnection() 
			throws ClassNotFoundException, SQLException
	{
		Connection conn = null;
		Class.forName("com.mysql.jdbc.Driver");
		System.out.println("Conectando ao banco");
		String url = "jdbc:mysql://localhost/lesfinal";
        String user = "root";
		String password = "queijo";
		conn = DriverManager.getConnection(url, user, password);
		System.out.println("Conectado ao banco de dados");
		return conn;
	}
}
