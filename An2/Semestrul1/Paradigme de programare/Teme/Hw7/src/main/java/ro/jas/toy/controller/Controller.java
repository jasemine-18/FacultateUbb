package ro.jas.toy.controller;

import ro.jas.toy.exceptions.EmptyExecutionStackException;
import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.stmt.IStmt;
import ro.jas.toy.model.value.RefValue;
import ro.jas.toy.model.value.Value;
import ro.jas.toy.repo.MyIRepository;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Controller {
    private final MyIRepository repo;
    private boolean displayFlag;

    public Controller(MyIRepository repo, boolean displayFlag) {
        this.repo = repo;
        this.displayFlag = displayFlag;
    }

    public void setDisplayFlag(boolean value) {
        this.displayFlag = value;
    }

    public boolean getDisplayFlag() {
        return this.displayFlag;
    }

    public PrgState getCurrentProgram() {
        return repo.getCrtPrg();
    }

    private List<Integer> getAddrFromSymTable(Collection<Value> symTableValues) {
        return symTableValues.stream()
                .filter(v -> v instanceof RefValue)
                .map(v -> ((RefValue) v).getAddr())
                .toList();
    }

    private List<Integer> getAllReferencedAddresses(Collection<Value> symVals, Map<Integer, Value> heap) {
        List<Integer> result = new ArrayList<>(getAddrFromSymTable(symVals));
        boolean changed;

        do {
            changed = false;

            List<Integer> newOnes = heap.entrySet().stream()
                    .filter(e -> result.contains(e.getKey()))
                    .filter(e -> e.getValue() instanceof RefValue)
                    .map(e -> ((RefValue) e.getValue()).getAddr())
                    .filter(addr -> addr != 0 && !result.contains(addr))
                    .toList();

            if (!newOnes.isEmpty()) {
                result.addAll(newOnes);
                changed = true;
            }
        } while (changed);

        return result;
    }

    public PrgState oneStep(PrgState state) throws MyException {
        MyIStack<IStmt> stk = state.getStk();
        if (stk.isEmpty()) throw new EmptyExecutionStackException();
        IStmt crt = stk.pop();
        return crt.execute(state);
    }

    public void allStep() throws MyException {
        PrgState prg = repo.getCrtPrg();

        repo.logPrgState();

        while (!prg.getStk().isEmpty()) {
            oneStep(prg);
            repo.logPrgState();

            List<Integer> alive = getAllReferencedAddresses(
                    prg.getSymTable().getContent().values(),
                    prg.getHeap().getContent()
            );

            Map<Integer, Value> newHeapContent = prg.getHeap().getContent().entrySet().stream()
                    .filter(e -> alive.contains(e.getKey()))
                    .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

            prg.getHeap().setContent(newHeapContent);

            repo.logPrgState();

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

    public List<PrgState> getPrgList() {
        // A6: repository ține un singur program (crt)
        return List.of(repo.getCrtPrg());
    }

    public void oneStepForAllGUI() throws MyException {
        PrgState prg = repo.getCrtPrg();

        // dacă programul e terminat, nu mai facem nimic
        if (prg.getStk().isEmpty()) {
            throw new MyException("Program finished (ExeStack is empty).");
        }

        // executăm EXACT un pas
        oneStep(prg);

        // rulează GC-ul tău (același ca în allStep)
        List<Integer> alive = getAllReferencedAddresses(
                prg.getSymTable().getContent().values(),
                prg.getHeap().getContent()
        );

        Map<Integer, Value> newHeapContent =
                prg.getHeap().getContent().entrySet().stream()
                        .filter(e -> alive.contains(e.getKey()))
                        .collect(Collectors.toMap(
                                Map.Entry::getKey,
                                Map.Entry::getValue
                        ));

        prg.getHeap().setContent(newHeapContent);

        // log după pas (ca să vezi și în fișiere)
        repo.logPrgState();
    }
}