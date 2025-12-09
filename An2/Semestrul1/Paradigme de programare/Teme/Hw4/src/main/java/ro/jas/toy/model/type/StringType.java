package ro.jas.toy.model.type;

import ro.jas.toy.model.value.StringValue;
import ro.jas.toy.model.value.Value;

public class StringType  implements  Type{

    @Override
    public boolean equals(Object another) {
        //doua tipuri sunt egale daca sunt amandoua StringType
        return another instanceof StringType;
    }

    @Override
    public String toString() {
        return "string";
    }

    @Override
    public Value defaultValue(){
        return new StringValue("");
    }
}
