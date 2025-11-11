package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;

import java.util.HashMap;
import java.util.Map;

public class MyDictionary<K, V> implements MyIDictionary<K, V> {
    private final Map<K, V> map = new HashMap<>();

    @Override public void put(K key, V value) throws MyException {
        if (map.containsKey(key)) throw new MyException("Key already defined: " + key);
        map.put(key, value);
    }

    @Override public boolean isDefined(K key) { return map.containsKey(key); }

    @Override public V lookup(K key) throws MyException {
        if (!map.containsKey(key)) throw new MyException("Key not found: " + key);
        return map.get(key);
    }

    @Override public void update(K key, V value) throws MyException {
        if (!map.containsKey(key)) throw new MyException("Key not found: " + key);
        map.put(key, value);
    }

    @Override public Map<K, V> getContent() { return map; }
}
