package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;

import java.util.Map;

public interface MyIDictionary<K, V> {
    void put(K key, V value) throws MyException;  // eroare dacă e deja definit
    boolean isDefined(K key);
    V lookup(K key) throws MyException;           // eroare dacă NU e definit
    void update(K key, V value) throws MyException; // eroare dacă NU e definit
    Map<K, V> getContent();
}
