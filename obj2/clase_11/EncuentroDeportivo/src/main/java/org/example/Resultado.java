package org.example;

import java.util.List;

public class Resultado {

    private String resultado;
    private List<String> contrincantes;
    private Deporte deporte;

    public Resultado(String resultado, List<String> contrincantes, Deporte deporte) {
        this.resultado = resultado;
        this.contrincantes = contrincantes;
        this.deporte = deporte;
    }

    public String getResultado() {
        return resultado;
    }

    public List<String> getContrincantes() {
        return contrincantes;
    }

    public Deporte getDeporte() {
        return deporte;
    }
}
