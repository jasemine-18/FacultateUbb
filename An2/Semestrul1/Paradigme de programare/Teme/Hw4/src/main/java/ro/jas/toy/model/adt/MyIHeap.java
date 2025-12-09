package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;
import java.util.Map;

// Heap generic: cheie = Integer (adresa), valoare = V (ex: Value)
public interface MyIHeap<V> {

    // alocă o nouă adresă pentru valoare și o returnează
    int allocate(V value);

    // verifică dacă o adresă există în heap
    boolean isDefined(int address);

    // citește valoarea de la o adresă
    V lookup(int address) throws MyException;

    // scrie/actualizează valoarea la o adresă EXISTENTĂ
    void update(int address, V value) throws MyException;

    // șterge o intrare din heap (pentru garbage collector)
    void remove(int address) throws MyException;

    // întoarce o vedere (copie) a conținutului heap-ului
    Map<Integer, V> getContent();

    // setează conținutul heap-ului (util la GC)
    void setContent(Map<Integer, V> newContent);
}
