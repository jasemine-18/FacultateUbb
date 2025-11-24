package ro.jas.toy.model.type;

import ro.jas.toy.model.value.BoolValue;
import ro.jas.toy.model.value.Value;

public class BoolType implements Type {
    @Override
    public boolean equals(Object another) {
        return another instanceof BoolType;
    }
    @Override
    public String toString() {
        return "bool";
    }

    @Override
    public Value defaultValue(){
        return new BoolValue(false);
    }
}
