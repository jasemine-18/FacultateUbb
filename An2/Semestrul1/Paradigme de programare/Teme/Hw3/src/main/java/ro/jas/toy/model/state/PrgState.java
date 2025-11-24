package ro.jas.toy.model.state;

import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIList;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.stmt.IStmt;
import ro.jas.toy.model.value.StringValue;
import ro.jas.toy.model.value.Value;

import java.io.BufferedReader;

//stiva, tabela de simboluri si lista de iesirre
public class PrgState {
    private final MyIStack<IStmt> exeStack; //stiva
    private final MyIDictionary<String, Value> symTable; //dictionarul
    private final MyIList<Value> out;
    private final IStmt originalProgram;
    private final MyIDictionary<StringValue, BufferedReader> fileTable;

    //constructorul
    public PrgState(MyIStack<IStmt> stk,
                    MyIDictionary<String, Value> symtbl,
                    MyIList<Value> ot,
                    MyIDictionary<StringValue, BufferedReader> fileTable,
                    IStmt prg) {
        this.exeStack=stk;
        this.symTable=symtbl;
        this.out=ot;
        this.originalProgram=prg;
        this.exeStack.push(prg); //cand creez o noua stare impinge tot programul pe stiva
        this.fileTable=fileTable;
    }

    //getter
    public MyIStack<IStmt> getStk() {
        return exeStack;
    }

    //getter
    public MyIDictionary<String, Value> getSymTable() {
        return symTable;
    }

    //getter
    public MyIList<Value> getOut() {
        return out;
    }

    //getter
    public MyIDictionary<StringValue, BufferedReader> getFileTable() {
        return fileTable;
    }

    @Override
    public String toString(){
        return "ExeStack=" + exeStack.toList() + System.lineSeparator() +
                "SymTable=" + symTable.getContent() +System.lineSeparator() +
                "Out=" + out.getAll() + System.lineSeparator() +
                "FileTable=" +fileTable.getContent() + System.lineSeparator();
    }
}
