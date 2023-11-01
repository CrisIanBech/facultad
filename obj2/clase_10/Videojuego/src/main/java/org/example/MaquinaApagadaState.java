package org.example;

public class MaquinaApagadaState implements MaquinaState {
    @Override
    public void ingresarFicha(MaquinaDeFichas maquinaDeFichas) {}

    @Override
    public void presionarBotonInicio(MaquinaDeFichas maquinaDeFichas) {
        maquinaDeFichas.setMaquinaState(new MaquinaEncendidaState());
    }
}
