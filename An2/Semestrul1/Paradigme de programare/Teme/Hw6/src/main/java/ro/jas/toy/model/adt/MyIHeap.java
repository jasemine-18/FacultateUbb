package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;
import java.util.Map;

//stocheza valorile alocate dianmic
// Heap generic: cheie = Integer (adresa), valoare = V (ex: Value)
public interface MyIHeap<V> {
    int allocate(V value); // aloca o noua adresa pentru valoare si o returneaza
    boolean isDefined(int address);
    V lookup(int address) throws MyException;
    void update(int address, V value) throws MyException;
    void remove(int address) throws MyException;

    // intoarce o vedere (copie) a conținutului heap-ului
    Map<Integer, V> getContent();

    // seteaza conținutul heap-ului (util la GC)
    void setContent(Map<Integer, V> newContent);
}
