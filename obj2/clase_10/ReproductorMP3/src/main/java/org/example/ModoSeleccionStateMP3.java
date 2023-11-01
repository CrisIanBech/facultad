package org.example;

public class ModoSeleccionStateMP3 implements MP3State {
    @Override
    public void play(ReproductorMP3 reproductorMP3, Song song) throws Exception {
        reproductorMP3.setMP3State(new ReproduciendoCancionMP3State());
        song.play();
    }

    @Override
    public void pause(ReproductorMP3 reproductorMP3, Song song) throws Exception {
        throw new Exception("No hay cancion para pausar");
    }

    @Override
    public void stop(ReproductorMP3 reproductorMP3, Song song) throws Exception {
        throw new Exception("No hay cancion para detener");
    }
}
