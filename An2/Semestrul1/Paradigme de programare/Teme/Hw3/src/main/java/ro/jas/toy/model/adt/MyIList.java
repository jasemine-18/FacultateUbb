package ro.jas.toy.model.adt;

import java.util.List;

public interface MyIList<T> {
    void add(T value); //adauga un element la final
    List<T> getAll();
}
