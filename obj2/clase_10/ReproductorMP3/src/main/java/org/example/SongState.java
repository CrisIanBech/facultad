package org.example;

public interface SongState {
    void play(Song song) throws Exception;
    void stop(Song song) throws Exception;
    void pause(Song song) throws Exception;
}
