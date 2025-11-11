package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;
import java.util.List;

public interface MyIStack<T> {
    T pop() throws MyException;  // scoate elementul din vârf; eroare dacă e gol
    void push(T v);              // pune element în vârf
    boolean isEmpty();           // e goală?
    List<T> toList();            // pentru afișare/debug (top -> bottom)
}
