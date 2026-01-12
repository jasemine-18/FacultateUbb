package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.exceptions.VariableAlreadyDeclaredException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.*;

/** Declarație: introduce variabila în SymTable cu valoarea implicita (0/false). */
public class VarDeclStmt implements IStmt {
    private final String name;
    private final Type typ;

    //constructor
    public VarDeclStmt(String name, Type typ) {
        this.name = name;
        this.typ = typ;
    }

    //declara o variabila cu o valoare implicita
    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> sym = state.getSymTable();

        //verifica daca variabila exista deja
        if (sym.isDefined(name)){
            throw new VariableAlreadyDeclaredException(name);
        }

        //cream o valoare implicita bazata pe tip (int sau bool)
        Value defaultVal = typ.defaultValue();
        if (defaultVal == null) throw new MyException("unknown type: " + typ);

        //introducem perechea nume,valoare
        sym.put(name, defaultVal);
        return state;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        typeEnv.put(name, typ);
        return typeEnv;
    }

    @Override public String toString() { return typ + " " + name; }
}

