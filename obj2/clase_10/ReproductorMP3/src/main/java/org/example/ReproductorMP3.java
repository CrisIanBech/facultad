package org.example;

public class ReproductorMP3 {
    private MP3State mp3State;
    private Song song;

    public ReproductorMP3() {
        this.mp3State = new ModoSeleccionStateMP3();
        this.song = new UnselectedSong();
    }

    public void setMP3State(MP3State mp3State) {
        this.mp3State = mp3State;
    }

    public void setSong(Song song) {
        this.song = song;
    }

    public void play() throws Exception {
        mp3State.play(this, song);
    }

    public void pause() throws Exception {
        mp3State.pause(this, song);
    }

    public void stop() throws Exception {
        mp3State.stop(this, song);
    }
}
