package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.KeyAlreadyDefinedException;
import ro.jas.toy.exceptions.KeyNotFoundException;
import ro.jas.toy.exceptions.MyException;

import java.util.HashMap;
import java.util.Map;

public class MyDictionary<K, V> implements MyIDictionary<K, V> {
    private final Map<K, V> map = new HashMap<>();

    @Override
    public void put(K key, V value) throws MyException {
        if (map.containsKey(key))
            throw new KeyAlreadyDefinedException(String.valueOf(key));
        map.put(key, value);
    }

    @Override
    public boolean isDefined(K key) {
        return map.containsKey(key);
    }

    //citim valoarea
    @Override
    public V lookup(K key) throws MyException {
        if (!map.containsKey(key)) throw new KeyNotFoundException(String.valueOf(key));
        return map.get(key);
    }

    //inlocuim valoarea
    @Override
    public void update(K key, V value) throws MyException {
        if (!map.containsKey(key)) throw new KeyNotFoundException(String.valueOf(key));
        map.put(key, value);
    }

    @Override
    public void remove(K key) throws MyException{
        if(!map.containsKey(key))
            throw new KeyNotFoundException(String.valueOf(key));
        map.remove(key);
    }

    @Override
    public Map<K, V> getContent() {
        return map;
    }

}
