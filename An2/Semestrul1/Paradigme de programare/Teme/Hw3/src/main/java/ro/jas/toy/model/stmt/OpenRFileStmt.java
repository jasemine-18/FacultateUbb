package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.StringType;
import ro.jas.toy.model.value.StringValue;
import ro.jas.toy.model.value.Value;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;


public class OpenRFileStmt implements IStmt{
    private final Exp exp;

    public OpenRFileStmt(Exp exp){
        this.exp=exp;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException{
        //SymTable cu variabile
        MyIDictionary<String, Value> symTable = state.getSymTable();
        //FileTable
        MyIDictionary<StringValue, BufferedReader>fileTable = state.getFileTable();

        //evaluam expresia si verificam tipul
        Value v = exp.eval(symTable);
        if (!v.getType().equals(new StringType()))
            throw new MyException("openRFile: expression is not a string");
        StringValue fileNameVal=(StringValue) v;

        //verificam daca fisierul nu e deja in FileTable
        if(fileTable.isDefined(fileNameVal))
            throw new MyException("openRFile: file already opened:" + fileNameVal.getVal());

        //deschidem fisierul
        try{
            BufferedReader br = new BufferedReader(new FileReader(fileNameVal.getVal()));
            //il adaugam in FileTable
            fileTable.put(fileNameVal, br);
        }catch(IOException e){
            throw new MyException("openRFile: could not open file" +
                    fileNameVal.getVal() + "(" + e.getMessage() + ")");
        }

        return state;
    }

    @Override
    public String toString(){
        return "openRFile(" + exp + ")";
    }
}
