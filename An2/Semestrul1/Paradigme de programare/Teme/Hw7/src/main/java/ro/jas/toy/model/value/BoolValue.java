package ro.jas.toy.model.value;

import ro.jas.toy.model.type.*;

public class BoolValue implements Value {
    private final boolean val;

    //constructor
    public BoolValue(boolean v) {
        this.val = v;
    }

    //getter
    public boolean getVal() {
        return val;
    }
    @Override
    public Type getType() {
        return new BoolType();
    }

    @Override
    public String toString() {

        return Boolean.toString(val);
    }

    @Override
    public boolean equals(Object another){
        if(!(another instanceof BoolValue other))
            return false;
        return this.val == other.val;
    }

}