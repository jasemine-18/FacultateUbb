package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.StringType;
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

        //evaluam expresia trebuie sa fie string
        Value v = exp.eval(symTable);
        if(!v.getType().equals(new StringType()))
            throw new MyException("closeRFile: expression is not a string");
        StringValue fileNameVal =(StringValue) v;

        //verificam ca fisierul este in FileTable
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
    public String toString() {
        return "closeRFile(" + exp + ")";
    }

}
