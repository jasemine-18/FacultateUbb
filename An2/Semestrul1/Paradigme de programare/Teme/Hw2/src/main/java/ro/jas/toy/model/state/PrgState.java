package ro.jas.toy.model.state;

import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIList;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.stmt.IStmt;
import ro.jas.toy.model.value.Value;

public class PrgState {
    private final MyIStack<IStmt> exeStack;
    private final MyIDictionary<String, Value> symTable;
    private final MyIList<Value> out;
    private final IStmt originalProgram;

    public PrgState(MyIStack<IStmt> stk,
                    MyIDictionary<String, Value> symtbl,
                    MyIList<Value> ot,
                    IStmt prg) {
        this.exeStack=stk;
        this.symTable=symtbl;
        this.out=ot;
        this.originalProgram=prg;
        this.exeStack.push(prg);
    }

    public MyIStack<IStmt> getStk() {
        return exeStack;
    }

    public MyIDictionary<String, Value> getSymTable() {
        return symTable;
    }

    public MyIList<Value> getOut() {
        return out;
    }

    @Override
    public String toString(){
        return "ExeStack=" + exeStack.toList() + System.lineSeparator() +
                "SymTable=" + symTable.getContent() +System.lineSeparator() +
                "Out=" + out.getAll() + System.lineSeparator();
    }
}
