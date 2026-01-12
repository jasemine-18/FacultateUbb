package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.StringValue;
import ro.jas.toy.model.value.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class CloseRFileStmt implements IStmt{
    private final Exp exp;

    public CloseRFileStmt(Exp exp){
        this.exp=exp;
    }

    @Override
    public PrgState execute (PrgState state) throws MyException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();
        MyIHeap<Value> heap =state.getHeap();

        //evaluam expresia trebuie sa fie string
        Value v = exp.eval(symTable, heap);
        if(!v.getType().equals(new StringType()))
            throw new MyException("closeRFile: expression is not a string");
        StringValue fileNameVal =(StringValue) v;

        //Verificm daca fișierul e deschis în FileTable
        if(!fileTable.isDefined(fileNameVal))
            throw new MyException("closeRFile: file not opened:" + fileNameVal.getVal());
        BufferedReader br = fileTable.lookup(fileNameVal);

        //inchidem fisiereul
        try{
            br.close();
        }catch(IOException e) {
            throw new MyException("closeRFile: IO error: " + e.getMessage());
        }

        //stergem intrarea din FileTable
        fileTable.remove(fileNameVal);

        return state;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type t = exp.typecheck(typeEnv);
        if (t.equals(new StringType())) return typeEnv;

        throw new MyException("closeRFile: expression is not a string");
    }

    @Override
    public String toString() {
        return "closeRFile(" + exp + ")";
    }

}
