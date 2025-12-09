package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.KeyAlreadyDefinedException;
import ro.jas.toy.exceptions.KeyNotFoundException;
import ro.jas.toy.exceptions.MyException;

import java.util.HashMap;
import java.util.Map;

public class MyDictionary<K, V> implements MyIDictionary<K, V> {
    private final Map<K, V> map = new HashMap<>();


    //folosit la declararaea variabilelor. nu putem declara o variablia cu acelasi nume
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

    //folosit la folosirea variabilelor . daca x nu e definit eroare
    @Override
    public V lookup(K key) throws MyException {
        if (!map.containsKey(key)) throw new KeyNotFoundException(String.valueOf(key));
        return map.get(key);
    }

    //folosit la assignare x=5 variabila trebuie sa existe deja
    @Override
    public void update(K key, V value) throws MyException {
        if (!map.containsKey(key)) throw new KeyNotFoundException(String.valueOf(key));
        map.put(key, value);
    }

    //folosit la closeRFile pentru a sterge fisierul din FileTable
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
