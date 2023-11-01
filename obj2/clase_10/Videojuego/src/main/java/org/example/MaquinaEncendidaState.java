package org.example;

public class MaquinaEncendidaState implements MaquinaState {

    private int cantidadDeFichas = 0;

    @Override
    public void ingresarFicha(MaquinaDeFichas maquinaDeFichas) {
        cantidadDeFichas++;
    }

    @Override
    public void presionarBotonInicio(MaquinaDeFichas maquinaDeFichas) {
        if(cantidadDeFichas == 1) {
            maquinaDeFichas.setMaquinaState(new MaquinaEnJuegoSingleplayerState(maquinaDeFichas));
        } else if(cantidadDeFichas > 1) {
            maquinaDeFichas.setMaquinaState(new MaquinaEnJuegoMultiplayerState(maquinaDeFichas));
        }
    }
}
