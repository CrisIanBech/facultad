package org.example;

public interface MP3State {
    void play(ReproductorMP3 reproductorMP3, Song song) throws Exception;
    void pause(ReproductorMP3 reproductorMP3, Song song) throws Exception;
    void stop(ReproductorMP3 reproductorMP3, Song song) throws Exception;
}
