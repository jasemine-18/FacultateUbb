package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.adt.MyIList;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.Type;
import ro.jas.toy.model.value.Value;

/** Print(exp): evalueaza exp si adauga în Out. */
public class PrintStmt implements IStmt {
    private final Exp exp;

    // constructor
    public PrintStmt(Exp exp) {
        this.exp = exp;
    }

    // afișare a valorii în lista de ieșire Out
    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIList<Value> out = state.getOut();
        MyIHeap<Value> heap = state.getHeap();

        // evaluam expresia folosind SymTable + Heap
        Value v = exp.eval(state.getSymTable(), heap);

        // adaugam valoarea în out
        out.add(v);
        return state;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        exp.typecheck(typeEnv);
        return typeEnv;
    }


    @Override
    public String toString() {
        return "print(" + exp + ")";
    }
}
