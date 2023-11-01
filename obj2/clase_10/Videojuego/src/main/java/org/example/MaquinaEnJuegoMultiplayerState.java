package org.example;

public class MaquinaEnJuegoMultiplayerState extends MaquinaEnJuegoState {
    private Player playerOne;
    private Player playerTwo;

    public MaquinaEnJuegoMultiplayerState(MaquinaDeFichas maquinaDeFichas) {
        super(maquinaDeFichas);
    }

    @Override
    public void iniciarJuego() {
        playerOne = new PlayerImpl();
        playerTwo = new PlayerImpl();
    }
}
