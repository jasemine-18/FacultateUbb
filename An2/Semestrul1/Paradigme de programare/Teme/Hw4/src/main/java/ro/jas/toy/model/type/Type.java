package ro.jas.toy.model.type;

import ro.jas.toy.model.value.Value;

/** descrie tipul variabilei  */
public interface Type {
    boolean equals(Object another);
    String toString();

    Value defaultValue();
}
