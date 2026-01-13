package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.EmptyStackException;
import ro.jas.toy.exceptions.MyException;

import java.util.*;

/** MyStack: wrapper peste ArrayDeque. */
//STIVA DE EXECUTIE(tine instructiunile ce urmeaza a fi executate)
public class MyStack<T> implements MyIStack<T> {
    private final Deque<T> stack = new ArrayDeque<>();

    @Override
    public T pop() throws MyException {
        T v = stack.pollFirst();     //ia primul element
        if (v == null) throw new EmptyStackException();
        return v; //returnam elementul scos
    }


    // pune un element in varf si il adauga la inceputul dequeului
    @Override
    public void push(T v) {
        stack.addFirst(v);
    }

    @Override
    public boolean isEmpty() { return stack.isEmpty(); }

    @Override
    public List<T> toList() { return new ArrayList<>(stack); }

    @Override
    public List<T> getReversed() {
        List<T> result = new ArrayList<>();
        Iterator<T> it = stack.iterator();
        while (it.hasNext()) {
            result.add(it.next());
        }
        return result;
    }

    @Override
    public String toString() { return stack.toString(); }
}
