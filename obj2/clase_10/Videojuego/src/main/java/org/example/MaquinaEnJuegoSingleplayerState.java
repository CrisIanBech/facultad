package org.example;

public class MaquinaEnJuegoSingleplayerState extends MaquinaEnJuegoState {
    private Player playerOne;

    public MaquinaEnJuegoSingleplayerState(MaquinaDeFichas maquinaDeFichas) {
        super(maquinaDeFichas);
    }

    @Override
    public void iniciarJuego() {
        playerOne = new PlayerImpl();
    }
}
