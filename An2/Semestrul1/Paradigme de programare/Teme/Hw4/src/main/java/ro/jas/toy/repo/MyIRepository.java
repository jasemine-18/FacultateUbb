package ro.jas.toy.repo;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.state.PrgState;

import java.util.List;

public interface MyIRepository {
    PrgState getCrtPrg();
    void addPrg(PrgState prg);
    List<PrgState> getPrgList();
    void setPrgList(List<PrgState> prgList);
    void logPrgState() throws MyException;
}
