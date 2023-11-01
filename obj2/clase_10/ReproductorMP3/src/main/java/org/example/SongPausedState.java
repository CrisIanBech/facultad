package org.example;

public class SongPausedState implements SongState {
    @Override
    public void play(Song song) throws Exception {
        throw new Exception("Canción ya seleccionada");
    }

    @Override
    public void stop(Song song) throws Exception {
        song.pausarSonido();
    }

    @Override
    public void pause(Song song) throws Exception {
        song.reproducirSonido();
    }
}
