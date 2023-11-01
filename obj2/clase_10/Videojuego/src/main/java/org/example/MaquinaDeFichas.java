package org.example;

public class MaquinaDeFichas {

    private MaquinaState maquinaState;

    public MaquinaDeFichas() {
        this.maquinaState = new MaquinaApagadaState();
    }

    public void setMaquinaState(MaquinaState maquinaState) {
        this.maquinaState = maquinaState;
    }

    public void ingresarFicha() {
        maquinaState.ingresarFicha(this);
    }

    public void presionarBotonInicio() {
        maquinaState.presionarBotonInicio(this);
    }
}
