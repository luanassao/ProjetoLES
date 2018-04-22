package finalCore.impl.negocio;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;

public class Criptografador {
	public String Criptografar(String senha) {
		   
        try{

            KeyGenerator keygenerator = KeyGenerator.getInstance("DES");
            SecretKey chaveDES = keygenerator.generateKey();

            Cipher cifraDES;

            // Cria a cifra 
            cifraDES = Cipher.getInstance("DES/ECB/PKCS5Padding");

            // Inicializa a cifra para o processo de encriptação
            cifraDES.init(Cipher.ENCRYPT_MODE, chaveDES);

            // Texto puro
            byte[] textoPuro = "t".getBytes();

            System.out.println("Texto [Formato de Byte] : " + textoPuro);
            System.out.println("Texto Puro : " + new String(textoPuro));

            // Texto encriptado
            byte[] textoEncriptado = cifraDES.doFinal(textoPuro);

            System.out.println("Texto Encriptado : " + textoEncriptado);
            System.out.println("Texto Encriptado String : " + new String(textoEncriptado));
            
            // Inicializa a cifra também para o processo de decriptação
            cifraDES.init(Cipher.DECRYPT_MODE, chaveDES);

            // Decriptografa o texto
            byte[] textoDecriptografado = cifraDES.doFinal(textoEncriptado);

            System.out.println("Texto Decriptografado : " + new String(textoDecriptografado));

        }catch(Exception e){
               e.printStackTrace();
        }
        return "";
	}
}
