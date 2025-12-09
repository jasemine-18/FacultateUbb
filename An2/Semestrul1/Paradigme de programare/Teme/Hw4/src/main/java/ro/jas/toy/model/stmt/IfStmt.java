package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.exceptions.NonBooleanConditionException;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.BoolType;
import ro.jas.toy.model.value.BoolValue;
import ro.jas.toy.model.value.Value;

/** If (exp) then S1 else S2: evaluează exp (trebuie bool), împinge ramura pe stivă. */
public class IfStmt implements IStmt {
    private final Exp exp;
    private final IStmt thenS;
    private final IStmt elseS;

    // constructor
    public IfStmt(Exp exp, IStmt thenS, IStmt elseS) {
        this.exp = exp;
        this.thenS = thenS;
        this.elseS = elseS;
    }

    // evaluează expresia condiției -> și pune pe stivă doar ramura potrivită
    @Override
    public PrgState execute(PrgState state) throws MyException {
        // tabela de simboluri + heap-ul curent
        var symTable = state.getSymTable();
        MyIHeap<Value> heap = state.getHeap();

        // evaluăm condiția folosind SymTable + Heap
        Value cond = exp.eval(symTable, heap);

        // verificăm dacă rezultatul este de tip BoolType
        if (!cond.getType().equals(new BoolType())) {
            throw new NonBooleanConditionException();
        }

        // luăm stiva de execuție
        MyIStack<IStmt> stk = state.getStk();

        // dacă e true → împingem ramura then, altfel ramura else
        if (((BoolValue) cond).getVal())
            stk.push(thenS);
        else
            stk.push(elseS);

        return state;
    }

    @Override
    public String toString() {
        return "IF(" + exp + ") THEN(" + thenS + ") ELSE(" + elseS + ")";
    }
}
