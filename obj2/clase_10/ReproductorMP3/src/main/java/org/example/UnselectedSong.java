package org.example;

public class UnselectedSong implements Song {
    @Override
    public void play() throws Exception {
        throw new Exception("Canción no inicializada");
    }

    @Override
    public void stop() throws Exception {
        throw new Exception("Canción no inicializada");
    }

    @Override
    public void pause() throws Exception {
        throw new Exception("Canción no inicializada");
    }

    @Override
    public void pausarSonido() throws Exception {
        throw new Exception("Canción no inicializada");
    }

    @Override
    public void reproducirSonido() throws Exception {
        throw new Exception("Canción no inicializada");
    }

    @Override
    public void setState(SongState state) throws Exception {
        throw new Exception("Canción no inicializada");
    }
}
