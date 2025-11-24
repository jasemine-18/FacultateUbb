package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;

import java.util.Map;

public interface MyIDictionary<K, V> {
    void put(K key, V value) throws MyException;  // eroare daca e deja definit
    boolean isDefined(K key);
    V lookup(K key) throws MyException;           // citeste valoarea
    void update(K key, V value) throws MyException; // inlocuieste valoarea
    Map<K, V> getContent();
    void remove(K key) throws MyException;
}
