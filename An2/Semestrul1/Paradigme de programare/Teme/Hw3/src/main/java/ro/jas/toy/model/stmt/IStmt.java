package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.state.PrgState;

/** Executa o singura regula (modifica starea) și returneaza PrgState. */
public interface IStmt {
    PrgState execute(PrgState state) throws MyException;
}