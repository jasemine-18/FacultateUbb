package ro.jas.toy.controller;

import ro.jas.toy.exceptions.EmptyExecutionStackException;
import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.stmt.IStmt;
import ro.jas.toy.repo.MyIRepository;

public class Controller {
    private final MyIRepository repo; //referinta catre repo
    private boolean displayFlag; // cannd e true, afisam dupa fiecare pas


    //constructor
    public Controller(MyIRepository repo, boolean displayFlag) {
        this.repo = repo;
        this.displayFlag = displayFlag;
    }

    public void setDisplayFlag(boolean value) {
        this.displayFlag = value;
    }

    public boolean getDisplayFlag(){
        return this.displayFlag;
    }


    public PrgState oneStep(PrgState state) throws MyException {
        MyIStack<IStmt> stk = state.getStk();
        if (stk.isEmpty()) throw new EmptyExecutionStackException();
        IStmt crt = stk.pop();
        return crt.execute(state);
    }

    //repeta oneStep pana cand stiva devine goala
    public void allStep() throws MyException {
        PrgState prg = repo.getCrtPrg();

        //log initial
        repo.logPrgState();

        while (!prg.getStk().isEmpty()) {
            oneStep(prg);
            repo.logPrgState(); // log dupa fiecare pas
            // daca flag e on afiseaza starea programului dupa fiecare pas
            if (displayFlag) {
                System.out.println("---- step ----");
                System.out.println(prg);
            }
        }
        if (!displayFlag) {
            System.out.println("--- Final State ---");
            System.out.println(prg);
        }
    }
}