package ro.jas.toy.model.value;

import ro.jas.toy.model.type.RefType;
import ro.jas.toy.model.type.Type;

// RefValue = o VALOARE de forma (adresa, tipul-locației)
// Exemple:
//   (1, int)         -> valoare de tip Ref(int)
//   (10, Ref(int))   -> valoare de tip Ref(Ref(int))
public class RefValue implements Value {

    // adresa din heap (1, 2, 3, ...)
    // 0 înseamnă "null" / "nu pointează nicăieri"
    private final int address;

    // tipul valorii STOCATE la acea adresă din heap
    // ex: pentru (1, int) -> locationType = IntType
    //     pentru (10, Ref(int)) -> locationType = RefType(IntType)
    private final Type locationType;

    // constructor
    public RefValue(int address, Type locationType) {
        this.address = address;
        this.locationType = locationType;
    }

    // întoarce adresa din heap (folosită de rH și wH)
    public int getAddr() {
        return address;
    }

    // întoarce tipul locației (IntType, RefType(IntType), etc.)
    public Type getLocationType() {
        return locationType;
    }

    // tipul unui RefValue este ÎNTOTDEAUNA un RefType
    // ex:
    //   pentru (1, int)         -> getType() = Ref(int)
    //   pentru (10, Ref(int))   -> getType() = Ref(Ref(int))
    @Override
    public Type getType() {
        return new RefType(locationType);
    }

    // pentru afișare/log:
    // (adresa, tipul_locației) -> (1,int), (2,Ref(int)), etc.
    @Override
    public String toString() {
        return "(" + address + "," + locationType.toString() + ")";
    }

    // două RefValue sunt egale dacă:
    // - și celălalt este RefValue
    // - au aceeași adresă
    // - și același locationType
    @Override
    public boolean equals(Object another) {
        if (another instanceof RefValue other) {
            return this.address == other.address &&
                    this.locationType.equals(other.locationType);
        }
        return false;
    }
}
