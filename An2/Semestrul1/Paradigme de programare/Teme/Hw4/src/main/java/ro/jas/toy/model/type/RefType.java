package ro.jas.toy.model.type;

import ro.jas.toy.model.value.RefValue;
import ro.jas.toy.model.value.Value;

// RefType reprezintă un TIP de forma Ref(T)
// Exemple: Ref(int), Ref(bool), Ref(Ref(int)), etc.
public class RefType implements Type {

    // inner reprezintă tipul "dinăuntru"
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

    // două tipuri sunt egale dacă:
    // - și celălalt este tot RefType
    // - iar inner-urile lor sunt egale (ex: Ref(int) == Ref(int))
    @Override
    public boolean equals(Object another) {
        if (another instanceof RefType rt) {
            return inner.equals(rt.inner);
        }
        return false;
    }

    // cum va apărea la afișare / log:
    // Ref(int), Ref(bool), Ref(Ref(int)), etc.
    @Override
    public String toString() {
        return "Ref(" + inner.toString() + ")";
    }

    // valoarea implicită pentru un RefType:
    // adresa = 0 (NULL), locationType = inner
    // ex: pentru Ref(int) -> (0, int)
    @Override
    public Value defaultValue() {
        return new RefValue(0, inner);
    }
}
