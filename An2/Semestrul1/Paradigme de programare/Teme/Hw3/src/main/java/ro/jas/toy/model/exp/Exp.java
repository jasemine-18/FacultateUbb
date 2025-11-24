package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.value.Value;

/** orice expresie evalueaza intr-un Value, folosind SymTable. */
public interface Exp {
    Value eval(MyIDictionary<String, Value> tbl) throws MyException;
}
