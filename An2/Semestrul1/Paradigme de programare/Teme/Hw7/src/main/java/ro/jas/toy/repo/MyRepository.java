package ro.jas.toy.repo;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIList;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.stmt.IStmt;
import ro.jas.toy.model.value.StringValue;
import ro.jas.toy.model.value.Value;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MyRepository implements MyIRepository {
   private List<PrgState> prgStates;
   private final String logFilePath;

   //constructor
   public MyRepository(PrgState initialPrg, String logFilePath){
       this.prgStates = new ArrayList<>();
       this.prgStates.add(initialPrg);
       this.logFilePath = logFilePath;
   }

   @Override
   public PrgState getCrtPrg(){
       return prgStates.get(0);
   }

   @Override
   public void addPrg(PrgState prg){
       prgStates.add(prg);
   }

   @Override
    public List<PrgState> getPrgList() {
       return prgStates;
   }

   @Override
   public void setPrgList(List<PrgState> prgList){
       this.prgStates = prgList;
   }

   //scrierea in fisier
   @Override
    public void logPrgState() throws MyException{
       PrgState prg = getCrtPrg();//starea curenta

       try (PrintWriter logFile = new PrintWriter(
               new BufferedWriter(
                       new FileWriter(logFilePath, true)))
       ){
           //ExeStack
           logFile.println("ExeStack:");
           MyIStack<IStmt> stack = prg.getStk();
           //iteram prin stiva si scriem fiecare instructiune
           for(IStmt stmt : stack.toList()) {
               logFile.println(stmt.toString());
           }
           //SymTable
           logFile.println("SymTable:");
           MyIDictionary<String, Value> symTable = prg.getSymTable();
           // Iteram prin mapa si scriem cheie -> valoare
           for(Map.Entry<String, Value>e : symTable.getContent().entrySet()){
               logFile.println(e.getKey() + " -> " + e.getValue());
           }
           //Scriem Lista de Ieșire (Out)
           logFile.println("Out:");
           MyIList<Value> out = prg.getOut();
           for (Value v: out.getAll()){
               logFile.println(v.toString());
           }
           //Scriem Tabela de Fișiere (FileTable)
           logFile.println("FileTable:");
           MyIDictionary<StringValue, BufferedReader> fileTable = prg.getFileTable();
           for (StringValue sv : fileTable.getContent().keySet()) {
               logFile.println(sv.toString());
           }

           logFile.println();
       }catch(IOException e){
           throw new MyException("Error while logging program state:" + e.getMessage());
       }
   }
}
