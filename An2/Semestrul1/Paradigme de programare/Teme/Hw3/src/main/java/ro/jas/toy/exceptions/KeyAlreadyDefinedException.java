package ro.jas.toy.exceptions;

public class KeyAlreadyDefinedException extends AdtException { public KeyAlreadyDefinedException(String k){ super("Key already defined: " + k); } }

