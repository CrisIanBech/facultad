package org.example;

public class ReproduciendoCancionMP3State implements MP3State {
    @Override
    public void play(ReproductorMP3 reproductorMP3, Song song) throws Exception {
        throw new Exception("Ya se encuentra reproduciendo una canción");
    }

    @Override
    public void pause(ReproductorMP3 reproductorMP3, Song song) throws Exception {
        song.pause();
    }

    @Override
    public void stop(ReproductorMP3 reproductorMP3, Song song) throws Exception {
        song.stop();
        reproductorMP3.setMP3State(new ModoSeleccionStateMP3());
    }
}
