package org.example;

public class EncriptadorNaive {
    private EncripterStrategy encryptStrategy;

    public EncriptadorNaive(EncripterStrategy encryptStrategy) {
        this.encryptStrategy = encryptStrategy;
    }

    public void setEncryptStrategy(EncripterStrategy encryptStrategy) {
        this.encryptStrategy = encryptStrategy;
    }

    public String encriptar(String texto) {
        return encryptStrategy.encriptar(texto);
    }

    public String desencriptar(String texto) {
        return encryptStrategy.desencriptar(texto);
    }

}
