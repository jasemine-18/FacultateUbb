package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIList;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.value.Value;

/** Print(exp): evaluează exp și adaugă în Out. */
public class PrintStmt implements IStmt {
    private final Exp exp;
    public PrintStmt(Exp exp) { this.exp = exp; }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIList<Value> out = state.getOut();
        Value v = exp.eval(state.getSymTable());
        out.add(v);
        return state;
    }

    @Override public String toString() { return "print(" + exp + ")"; }
}