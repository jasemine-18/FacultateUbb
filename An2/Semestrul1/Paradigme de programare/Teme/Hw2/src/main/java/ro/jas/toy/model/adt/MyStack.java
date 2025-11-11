package ro.jas.toy.model.adt;

import ro.jas.toy.exceptions.MyException;
import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

/** MyStack: wrapper peste ArrayDeque (viteza bună). */
public class MyStack<T> implements MyIStack<T> {
    private final Deque<T> stack = new ArrayDeque<>();

    @Override
    public T pop() throws MyException {
        T v = stack.pollFirst();                 // null dacă e gol
        if (v == null) throw new MyException("Stack is empty");
        return v;
    }

    @Override
    public void push(T v) { stack.addFirst(v); }

    @Override
    public boolean isEmpty() { return stack.isEmpty(); }

    @Override
    public List<T> toList() { return new ArrayList<>(stack); }
}
