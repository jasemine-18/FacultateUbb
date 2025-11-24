package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.exceptions.NonBooleanConditionException;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.BoolType;
import ro.jas.toy.model.value.*;

/** If (exp) then S1 else S2: evalueaza exp (trebuie bool), impinge ramura pe stiva. */
public class IfStmt implements IStmt {
    private final Exp exp;
    private final IStmt thenS;
    private final IStmt elseS;

    //constructor
    public IfStmt(Exp exp, IStmt thenS, IStmt elseS) {
        this.exp = exp;
        this.thenS = thenS;
        this.elseS = elseS;
    }

    //evalueaza expresia conditiei -> si pune pe stiva doar ramura potrivita
    @Override
    public PrgState execute(PrgState state) throws MyException {
        Value cond = exp.eval(state.getSymTable());
        if (!cond.getType().equals(new BoolType()))
            throw new NonBooleanConditionException();
        MyIStack<IStmt> stk = state.getStk();
        if (((BoolValue) cond).getVal())
            stk.push(thenS);
        else
            stk.push(elseS);
        return state;
    }

    @Override public String toString() { return "IF(" + exp + ") THEN(" + thenS + ") ELSE(" + elseS + ")"; }
}
