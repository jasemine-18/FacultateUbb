package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;
import java.util.List;

public interface MyIStack<T> {
    T pop() throws MyException;  // scoate elementul din varf; eroare dacă e gol
    void push(T v);              // pune element în varf
    boolean isEmpty();           // verifica daca stiva e goala
    List<T> toList();            // pentru afișare (top > bottom)
}
