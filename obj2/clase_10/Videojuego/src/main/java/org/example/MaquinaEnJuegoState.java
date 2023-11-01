package org.example;

public abstract class MaquinaEnJuegoState implements MaquinaState {

    private MaquinaDeFichas maquinaDeFichas;

    public MaquinaEnJuegoState(MaquinaDeFichas maquinaDeFichas) {
        this.maquinaDeFichas = maquinaDeFichas;
    }

    @Override
    public void ingresarFicha(MaquinaDeFichas maquinaDeFichas) {}

    @Override
    public void presionarBotonInicio(MaquinaDeFichas maquinaDeFichas) {
        iniciarJuego();
    }

    public abstract void iniciarJuego();

    public void terminarJuego() {
        maquinaDeFichas.setMaquinaState(new MaquinaEncendidaState());
    }

}
