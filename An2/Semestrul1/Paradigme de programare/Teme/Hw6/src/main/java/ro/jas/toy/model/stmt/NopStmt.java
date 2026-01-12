package ro.jas.toy.model.stmt;

import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.Type;

// nop: nu face nimic.
public class NopStmt implements IStmt {
    @Override public PrgState execute(PrgState state) {
        return state;
    }
    @Override public String toString() {
        return "nop";
    }
    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) {
        return typeEnv;
    }
}