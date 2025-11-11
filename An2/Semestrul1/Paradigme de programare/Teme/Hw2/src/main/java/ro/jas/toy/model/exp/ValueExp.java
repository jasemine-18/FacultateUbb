package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.value.Value;

/** ValueExp: întoarce valoarea dată (ex: 2, true). */
public class ValueExp implements Exp {
    private final Value e;
    public ValueExp(Value e) { this.e = e; }
    @Override public Value eval(MyIDictionary<String, Value> tbl) throws MyException { return e; }
    @Override public String toString() { return e.toString(); }
}
