package ro.jas.toy.model.type;

import ro.jas.toy.model.value.RefValue;
import ro.jas.toy.model.value.Value;

// RefType reprezintă un TIP de forma Ref(T)
public class RefType implements Type {

    // Ref(int)  -> inner = IntType
    // Ref(bool) -> inner = BoolType
    // Ref(Ref(int)) -> inner = RefType(IntType)
    private final Type inner;

    // constructor
    public RefType(Type inner) {
        this.inner = inner;
    }

    // getter
    public Type getInner() {
        return inner;
    }

    @Override
    public boolean equals(Object another) {
        if (another instanceof RefType rt) {
            return inner.equals(rt.inner);
        }
        return false;
    }

    @Override
    public String toString() {
        return "Ref(" + inner.toString() + ")";
    }

    @Override
    public Value defaultValue() {
        return new RefValue(0, inner);
    }
}
