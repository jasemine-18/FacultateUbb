package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.IntType;
import ro.jas.toy.model.type.StringType;
import ro.jas.toy.model.type.Type;
import ro.jas.toy.model.value.IntValue;
import ro.jas.toy.model.value.StringValue;
import ro.jas.toy.model.value.Value;

import java.io.BufferedReader;
import java.io.IOException;

// Citeste un nr dintr-un fisier deschis. Actualizeaza o variabila din SymTable cu valoarea cititta //
public class ReadFileStmt implements IStmt{
    private final Exp exp;
    private final String varName;

    public ReadFileStmt(Exp exp, String varName) {
        this.exp=exp;
        this.varName=varName;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIDictionary<StringValue, BufferedReader> fileTable = state.getFileTable();
        MyIHeap<Value> heap =state.getHeap();

        //Validare variabila: varName trebuie sa fie declarata si de tip int
        if(!symTable.isDefined(varName))
            throw new MyException("readFile: variable not declared:" + varName);
        if (!symTable.lookup(varName).getType().equals(new IntType()))
            throw new MyException("readFile: variable " + varName + " is not int");

        //Validare nume fisier: evaluam expresia exp care trebuie sa fie string
        Value v = exp.eval(symTable, heap);
        if(!v.getType().equals(new StringType()))
            throw new MyException("readFile: expression is not a string");
        StringValue fileNameVal = (StringValue) v;

        // Validare Deschidere: Verificam daca fișierul a fost deschis anterior (daca e în FileTable).
        if (!fileTable.isDefined(fileNameVal))
            throw new MyException("readFile: file not opened: " + fileNameVal.getVal());

        BufferedReader br = fileTable.lookup(fileNameVal);

        // citim o linie din fisier
        String line;
        try {
            line = br.readLine();
        } catch (IOException e) {
            throw new MyException("readFile: IO error: " + e.getMessage());
        }

        // daca line == null → EOF → folosim 0
        // Altfel, convertim textul în int
        IntValue intVal;
        if (line == null) {
            intVal = new IntValue(0);
        } else {
            try {
                intVal = new IntValue(Integer.parseInt(line));
            } catch (NumberFormatException e) {
                throw new MyException("readFile: line is not an integer: " + line);
            }
        }

        //actualizam variabila in SymTable
        symTable.update(varName, intVal);

        return state;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type tFile = exp.typecheck(typeEnv);
        if (!tFile.equals(new StringType()))
            throw new MyException("readFile: file expression is not a string");

        Type tVar = typeEnv.lookup(varName);
        if (!tVar.equals(new IntType()))
            throw new MyException("readFile: variable " + varName + " is not of type int");

        return typeEnv;
    }

    @Override
    public String toString() {
        return "readFile(" + exp + ", " + varName + ")";
    }
}
