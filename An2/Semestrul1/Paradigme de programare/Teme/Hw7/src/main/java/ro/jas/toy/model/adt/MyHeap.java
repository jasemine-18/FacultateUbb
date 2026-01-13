package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;

import java.util.HashMap;
import java.util.Map;

public class MyHeap<V> implements MyIHeap<V> {

    // map-ul efectiv care reține perechi (adresa - valoare)
    private Map<Integer, V> heap;
    private int nextFreeAddress;

    public MyHeap() {
        this.heap = new HashMap<>();
        this.nextFreeAddress = 1;
    }

    @Override
    public int allocate(V value) {
        int address = nextFreeAddress;
        heap.put(address, value);
        nextFreeAddress++;
        return address;
    }

    @Override
    public boolean isDefined(int address) {
        return heap.containsKey(address);
    }

    @Override
    public V lookup(int address) throws MyException {
        if (!heap.containsKey(address)) {
            throw new MyException("Heap: address " + address + " not defined");
        }
        return heap.get(address);
    }

    @Override
    public void update(int address, V value) throws MyException {
        if (!heap.containsKey(address)) {
            throw new MyException("Heap: cannot update, address " + address + " not defined");
        }
        heap.put(address, value);
    }

    @Override
    public void remove(int address) throws MyException {
        if (!heap.containsKey(address)) {
            throw new MyException("Heap: cannot remove, address " + address + " not defined");
        }
        heap.remove(address);
    }

    @Override
    public Map<Integer, V> getContent() {
        return heap;
    }

    //pentru GarbageCollector - permite inlocuirea intregului map
    @Override
    public void setContent(Map<Integer, V> newContent) {
        this.heap = newContent;
    }

    @Override
    public String toString() {
        return heap.toString();
    }
}
