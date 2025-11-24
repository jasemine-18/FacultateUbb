package ro.jas.toy.model.adt;

import java.util.ArrayList;
import java.util.List;

public class MyList<T> implements MyIList<T> {
    private final List<T> list = new ArrayList<>();
    @Override public void add(T value) {
        list.add(value);
    }
    @Override public List<T> getAll() {
        return list;
    }
}
