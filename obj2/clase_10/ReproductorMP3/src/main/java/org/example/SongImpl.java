package org.example;

public class SongImpl implements Song {
    private SongState songState;

    public SongImpl() {
        this.songState = new SongPausedState();
    }

    @Override
    public void play() throws Exception {
        songState.play(this);
    }

    @Override
    public void stop() throws Exception {
        songState.stop(this);
    }

    @Override
    public void pause() throws Exception {
        songState.pause(this);
    }

    @Override
    public void pausarSonido() {
        // Dummy
    }

    @Override
    public void reproducirSonido() {
        // Dummy
    }

    @Override
    public void setState(SongState state) {
        songState = state;
    }
}
