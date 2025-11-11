package ro.jas.toy.repo;

import ro.jas.toy.model.state.PrgState;

public class MyRepository implements MyIRepository {
    private PrgState prg;
    public MyRepository(PrgState initial) { this.prg = initial; }
    @Override public PrgState getCrtPrg() { return prg; }
    @Override public void setPrg(PrgState prg) { this.prg = prg; }
}
