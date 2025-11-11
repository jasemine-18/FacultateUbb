package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.state.PrgState;

/** S1; S2: împinge mai întâi S2, apoi S1, ca S1 să se execute primul. */
public class CompStmt implements IStmt {
    private final IStmt first, snd;
    public CompStmt(IStmt first, IStmt snd) { this.first = first; this.snd = snd; }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIStack<IStmt> stk = state.getStk();
        stk.push(snd);
        stk.push(first);
        return state;
    }

    @Override public String toString() { return "(" + first + "; " + snd + ")"; }
}
