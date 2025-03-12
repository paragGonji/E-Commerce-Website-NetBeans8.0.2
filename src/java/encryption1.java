import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;
import java.util.Scanner;

public class encryption1 {

    // Decrypt the given encrypted text using AES
    public static String decrypt(String encryptedText, String encodedKey) throws Exception {
        byte[] decodedKey = Base64.getDecoder().decode(encodedKey); // Decode the base64 key
        SecretKey secretKey = new SecretKeySpec(decodedKey, 0, decodedKey.length, "AES");

        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decodedBytes = Base64.getDecoder().decode(encryptedText);
        byte[] decryptedBytes = cipher.doFinal(decodedBytes);
        return new String(decryptedBytes);
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        try {
            // Get encrypted text and decryption key from user input
            System.out.print("Enter the encrypted text: ");
            String encryptedText = scanner.nextLine();
            
            System.out.print("Enter the decryption key (Base64 encoded): ");
            String decryptionKey = scanner.nextLine();

            // Decrypt the text
            String decryptedText = decrypt(encryptedText, decryptionKey);
            System.out.println("Decrypted Text: " + decryptedText);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            scanner.close();
        }
    }
}
