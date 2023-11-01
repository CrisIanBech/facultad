package org.example;

public class SongPlayingState implements SongState {
    @Override
    public void play(Song song) throws Exception {
        throw new Exception("Ya se encuentra reproduciendo una canción");
    }

    @Override
    public void stop(Song song) throws Exception {
        pauseSong(song);
    }

    private void pauseSong(Song song) throws Exception {
        song.pausarSonido();
        song.setState(new SongPausedState());
    }

    @Override
    public void pause(Song song) throws Exception {
        pauseSong(song);
    }
}
