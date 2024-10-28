package kr.co.sist.dao;

import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class DataEncryption {

	 // AES 암호화 메소드
    public static String encrypt(String plainText, String key) throws Exception {
        // AES 알고리즘을 사용하기 위해 Cipher 인스턴스 생성
        Cipher cipher = Cipher.getInstance("AES");

        // 키를 바이트 배열로 변환
        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "AES");

        // Cipher를 암호화 모드로 초기화
        cipher.init(Cipher.ENCRYPT_MODE, keySpec);

        // 평문을 암호화
        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes());

        // 암호화된 데이터를 Base64로 인코딩하여 문자열로 변환
        return Base64.getEncoder().encodeToString(encryptedBytes);
    }

    // AES 복호화 메소드
    public static String decrypt(String encryptedText, String key) throws Exception {
        // AES 알고리즘을 사용하기 위해 Cipher 인스턴스 생성
        Cipher cipher = Cipher.getInstance("AES");

        // 키를 바이트 배열로 변환
        SecretKeySpec keySpec = new SecretKeySpec(key.getBytes(), "AES");

        // Cipher를 복호화 모드로 초기화
        cipher.init(Cipher.DECRYPT_MODE, keySpec);

        // 암호화된 텍스트를 Base64로 디코딩
        byte[] decodedBytes = Base64.getDecoder().decode(encryptedText);

        // 복호화
        byte[] decryptedBytes = cipher.doFinal(decodedBytes);

        // 복호화된 데이터를 문자열로 변환
        return new String(decryptedBytes);
    }

    public static void main(String[] args) {
        try {
            // 16바이트(128비트) 키 생성 (AES-128 사용)
            String key = "1234567890123456";  // 실제로는 랜덤하게 생성된 안전한 키를 사용해야 합니다.

            // 암호화할 평문
            String plainText = "Hello, world!";

            // 암호화
            String encryptedText = encrypt(plainText, key);
            System.out.println("Encrypted: " + encryptedText);

            // 복호화
            String decryptedText = decrypt(encryptedText, key);
            System.out.println("Decrypted: " + decryptedText);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
