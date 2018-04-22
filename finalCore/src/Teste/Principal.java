package Teste;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

public class Principal {

	public static void main(String[] args) {
		
        try{

        	KeyGenerator keygenerator = KeyGenerator.getInstance("DES");
            SecretKey chaveDES = keygenerator.generateKey();

            Cipher cifraDES;

            // Cria a cifra 
            cifraDES = Cipher.getInstance("DES/ECB/PKCS5Padding");

            // Inicializa a cifra para o processo de encriptação
            cifraDES.init(Cipher.ENCRYPT_MODE, chaveDES);

            // Texto puro
            byte[] textoPuro = "rtgbrgtbrg".getBytes();
            byte[] textoPuro2 = "abcdadgaee".getBytes();

            System.out.println("Texto [Formato de Byte] : " + textoPuro);
            System.out.println("Texto Puro : " + new String(textoPuro));
            
            System.out.println("Texto2 [Formato de Byte] : " + textoPuro2);
            System.out.println("Texto Puro2 : " + new String(textoPuro2));

            // Texto encriptado
            byte[] textoEncriptado = cifraDES.doFinal(textoPuro);
            byte[] textoEncriptado2 = cifraDES.doFinal(textoPuro2);

            System.out.println("Texto Encriptado : " + textoEncriptado);
            System.out.println("Texto2 Encriptado : " + textoEncriptado2);
            
            // Inicializa a cifra também para o processo de decriptação
            cifraDES.init(Cipher.DECRYPT_MODE, chaveDES);

            // Decriptografa o texto
            byte[] textoDecriptografado = cifraDES.doFinal(textoEncriptado);
            byte[] textoDecriptografado2 = cifraDES.doFinal(textoEncriptado2);

            System.out.println("Texto Decriptografado : " + new String(textoDecriptografado));
            System.out.println("Texto2 Decriptografado : " + new String(textoDecriptografado2));
            
            /*Connection conn = null;
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost/teste";
	        String user = "root";
			String password = "queijo";
			conn = DriverManager.getConnection(url, user, password);
			PreparedStatement pst = null;
			conn.setAutoCommit(false);
			StringBuilder sql = new StringBuilder();
			sql.append("INSERT INTO teste(texto)");
			sql.append("VALUES ('" + textoEncriptado + "')");
			pst = conn.prepareStatement(sql.toString());
			System.out.println(pst);
			pst.executeUpdate();			
			conn.commit();*/
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
}
