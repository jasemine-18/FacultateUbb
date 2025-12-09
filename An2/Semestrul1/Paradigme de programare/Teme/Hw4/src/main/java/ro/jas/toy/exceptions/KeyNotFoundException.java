package ro.jas.toy.exceptions;

public class KeyNotFoundException extends AdtException {
    public KeyNotFoundException(String k){ super("Key not found: " + k); }
}

