package ro.jas.toy.model.stmt;

import ro.jas.toy.model.state.PrgState;

/** nop: nu face nimic. */
public class NopStmt implements IStmt {
    @Override public PrgState execute(PrgState state) { return state; }
    @Override public String toString() { return "nop"; }
}