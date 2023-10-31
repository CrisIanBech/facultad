package org.example;

public enum Vocal {
    A, E, I, O, U;

    public static Vocal fromVocalString(String vocal) {
        return valueOf(vocal.toUpperCase());
    }

    public Vocal nextVocal() {
        return Vocal.values()[this.ordinal() + 1 % Vocal.values().length];
    }

    public Vocal previousVocal() {
        return Vocal.values()[(this.ordinal() + Vocal.values().length - 1) % Vocal.values().length];
    }

    @Override
    public String toString() {
        return this.name().toLowerCase();
    }
}
