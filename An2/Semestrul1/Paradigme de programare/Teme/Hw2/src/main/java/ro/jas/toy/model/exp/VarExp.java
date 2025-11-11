package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.value.Value;

/** VarExp: ia valoarea variabilei din SymTable. Aruncă eroare dacă nu e definită. */
public class VarExp implements Exp {
    private final String id;
    public VarExp(String id) { this.id = id; }
    @Override public Value eval(MyIDictionary<String, Value> tbl) throws MyException { return tbl.lookup(id); }
    @Override public String toString() { return id; }
}
