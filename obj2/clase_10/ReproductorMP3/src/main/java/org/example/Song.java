package org.example;

public interface Song {
    void play() throws Exception;
    void stop() throws Exception;
    void pause() throws Exception;
    void pausarSonido() throws Exception;
    void reproducirSonido() throws Exception;
    void setState(SongState state) throws Exception;
}
