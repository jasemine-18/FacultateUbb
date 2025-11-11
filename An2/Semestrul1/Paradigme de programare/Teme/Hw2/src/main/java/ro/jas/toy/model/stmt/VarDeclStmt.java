package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.*;

/** Declarație: introduce variabila în SymTable cu valoarea implicită (0/false). */
public class VarDeclStmt implements IStmt {
    private final String name;
    private final Type typ;

    public VarDeclStmt(String name, Type typ) { this.name = name; this.typ = typ; }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> sym = state.getSymTable();
        if (sym.isDefined(name)) throw new MyException("variable already declared: " + name);

        Value defaultVal = (typ instanceof IntType) ? new IntValue(0)
                : (typ instanceof BoolType) ? new BoolValue(false)
                : null;
        if (defaultVal == null) throw new MyException("unknown type: " + typ);

        sym.put(name, defaultVal);
        return state;
    }

    @Override public String toString() { return typ + " " + name; }
}

