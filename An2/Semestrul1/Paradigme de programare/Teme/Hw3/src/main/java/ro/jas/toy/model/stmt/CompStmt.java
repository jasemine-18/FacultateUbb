package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.state.PrgState;

/** S1; S2: impinge mai intai S2, apoi S1, ca S1 sa se execute primul. */
public class CompStmt implements IStmt {
    private final IStmt first, snd;

    //constructor
    public CompStmt(IStmt first, IStmt snd) {
        this.first = first;
        this.snd = snd;
    }

    //pregateste ordinea instructiunilor punandu le in stiva
    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIStack<IStmt> stk = state.getStk(); //luam stiva de executie din starea programului
        stk.push(snd); //adaugam s2 mai intai
        stk.push(first); //dupa adaugam s1
        return state;
    }

    @Override public String toString() { return "(" + first + "; " + snd + ")"; }
}
