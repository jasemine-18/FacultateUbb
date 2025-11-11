package ro.jas.toy.controller;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.stmt.IStmt;
import ro.jas.toy.repo.MyIRepository;

/** Controller: oneStep + allStep. */
public class Controller {
    private final MyIRepository repo;
    private boolean displayFlag = true; // ▶ când e true, afișăm după fiecare pas


    public Controller(MyIRepository repo) {
        this.repo = repo;
    }

    public void setDisplayFlag(boolean on) {
        this.displayFlag = on;
    }


    public PrgState oneStep(PrgState state) throws MyException {
        MyIStack<IStmt> stk = state.getStk();
        if (stk.isEmpty()) throw new MyException("prgstate stack is empty");
        IStmt crt = stk.pop();
        return crt.execute(state);
    }

    public void allStep() throws MyException {
        PrgState prg = repo.getCrtPrg();
        while (!prg.getStk().isEmpty()) {
            oneStep(prg);
            if (displayFlag) {                 // 👈 afișare după fiecare pas
                System.out.println("---- step ----");
                System.out.println(prg);
            }
        }
    }
}