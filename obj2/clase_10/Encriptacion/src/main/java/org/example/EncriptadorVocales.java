package org.example;

public class EncriptadorVocales implements EncripterStrategy {
    @Override
    public String encriptar(String texto) {
        StringBuilder encryptedText = new StringBuilder();
        for(int i = 0; i < texto.length(); i++) {
            encryptedText.append(caracterEncriptado(texto.charAt(i)));
        }
        return encryptedText.toString();
    }

    private String caracterEncriptado(char character) {
        if(esVocal(character)) {
            Vocal vocal = Vocal.fromVocalString(String.valueOf(character));
            return vocal.nextVocal().toString();
        } else {
            return String.valueOf(character);
        }
    }

    private boolean esVocal(char character) {
        return character == 'a' || character == 'e' || character == 'i' || character == 'o' || character == 'u';
    }

    @Override
    public String desencriptar(String texto) {
        StringBuilder descencryptedText = new StringBuilder();
        for(int i = 0; i < texto.length(); i++) {
            descencryptedText.append(caracterDesencriptado(texto.charAt(i)));
        }
        return descencryptedText.toString();
    }

    private String caracterDesencriptado(char character) {
        if(esVocal(character)) {
            return Vocal.fromVocalString(String.valueOf(character)).previousVocal().toString();
        } else {
            return String.valueOf(character);
        }
    }
}
