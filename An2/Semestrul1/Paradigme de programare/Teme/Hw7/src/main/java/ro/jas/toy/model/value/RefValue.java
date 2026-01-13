package ro.jas.toy.model.value;

import ro.jas.toy.model.type.RefType;
import ro.jas.toy.model.type.Type;

// RefValue = o VALOARE de forma (adresa, tipul-locației)
public class RefValue implements Value {
    private final int address;

    // tipul valorii STOCATE la acea adresa din heap
    private final Type locationType;

    // constructor
    public RefValue(int address, Type locationType) {
        this.address = address;
        this.locationType = locationType;
    }

    // intoarce adresa din heap (folosita de rH și wH)
    public int getAddr() {
        return address;
    }

    // intoarce tipul locației (IntType, RefType(IntType), ...)
    public Type getLocationType() {
        return locationType;
    }

    // tipul unui RefValue este INTOTDEAUNA un RefType
    @Override
    public Type getType() {
        return new RefType(locationType);
    }

    // pentru afisare/log:
    // (adresa, tipul_locației) -> (1,int), (2,Ref(int)), etc.
    @Override
    public String toString() {
        return "(" + address + "," + locationType.toString() + ")";
    }

    @Override
    public boolean equals(Object another) {
        if (another instanceof RefValue other) {
            return this.address == other.address &&
                    this.locationType.equals(other.locationType);
        }
        return false;
    }
}
