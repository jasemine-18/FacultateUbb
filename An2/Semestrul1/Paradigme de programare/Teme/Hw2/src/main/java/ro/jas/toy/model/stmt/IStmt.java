package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.state.PrgState;

/** Execută o singură regulă Sx (modifică starea) și returnează PrgState. */
public interface IStmt {
    PrgState execute(PrgState state) throws MyException;
}