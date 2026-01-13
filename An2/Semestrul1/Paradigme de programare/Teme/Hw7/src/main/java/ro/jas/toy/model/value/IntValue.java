package ro.jas.toy.model.value;

import ro.jas.toy.model.type.*;

public class IntValue implements Value {
    private final int val;

    //constructor
    public IntValue(int v) {
        this.val = v;
    }

    //getter
    public int getVal() {
        return val;
    }

    @Override
    public Type getType() {

        return new IntType();
    }

    @Override
    public String toString() {

        return Integer.toString(val);
    }

    @Override
    public boolean equals(Object another) {
        if(!(another instanceof IntValue other))
            return false;
        return this.val== other.val;
    }


}
