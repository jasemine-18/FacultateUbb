package ro.jas.toy.repo;

import ro.jas.toy.model.state.PrgState;

public interface MyIRepository {
    PrgState getCrtPrg();
    void setPrg(PrgState prg);
}
