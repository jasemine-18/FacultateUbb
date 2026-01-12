package ro.jas.toy.model.value;

import ro.jas.toy.model.type.StringType;
import ro.jas.toy.model.type.Type;

public class StringValue  implements Value{

    private final String val;

    public StringValue(String v) {
        this.val = v;
    }

    public String getVal() {
        return val;
    }

    @Override
    public Type getType(){
        return new StringType();
    }

    @Override
    public String toString(){
        return val;
    }

    @Override
    public boolean equals(Object another) {
        // doua stringValue sunt egale daca ambele sunt StringValue , au acelasi string intern
        if(!(another instanceof StringValue other))
            return false;
        return this.val.equals(other.val);
    }
}
