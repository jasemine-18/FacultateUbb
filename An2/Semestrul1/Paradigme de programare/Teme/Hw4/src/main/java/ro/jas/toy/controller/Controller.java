package ro.jas.toy.controller;

import ro.jas.toy.exceptions.EmptyExecutionStackException;
import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIHeap;
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
    private final MyIRepository repo; // referință către repo
    private boolean displayFlag;      // când e true, afișăm după fiecare pas

    // constructor
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

    // execută un singur pas al programului (un statement)
    public PrgState oneStep(PrgState state) throws MyException {
        MyIStack<IStmt> stk = state.getStk();
        if (stk.isEmpty()) {
            throw new EmptyExecutionStackException();
        }
        IStmt crt = stk.pop();      // scoatem statement-ul din vârful stivei
        return crt.execute(state);  // îl executăm
    }

    /**
     * Adrese „vii” direct din SymTable (doar pentru RefValue).
     * Exemplu: v = (1,int) -> 1 e o adresă vie.
     */
    private List<Integer> getAddrFromSymTable(Collection<Value> symTableValues) {
        return symTableValues.stream()
                .filter(v -> v instanceof RefValue)
                .map(v -> ((RefValue) v).getAddr())
                .toList();
    }

    /**
     * Adrese vii din SymTable + tot lanțul de referințe din heap.
     * Dacă heap[2] = RefValue(1, IntType) și 2 e viu, atunci și 1 devine viu.
     */
    private List<Integer> getAllReferencedAddresses(Collection<Value> symVals,
                                                    Map<Integer, Value> heap) {
        // adrese vii direct din SymTable
        List<Integer> result = new ArrayList<>(getAddrFromSymTable(symVals));
        boolean changed;

        do {
            changed = false;

            // pentru fiecare intrare (addr, val) din heap:
            // dacă addr este deja în result și val este RefValue,
            // atunci adresa din val devine și ea vie
            List<Integer> newOnes =
                    heap.entrySet().stream()
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

    /**
     * Repetă oneStep până când stiva devine goală.
     * După fiecare pas rulează garbage collector-ul.
     */
    public void allStep() throws MyException {
        PrgState prg = repo.getCrtPrg();

        // log inițial (starea de la început)
        repo.logPrgState();

        while (!prg.getStk().isEmpty()) {
            // un pas de execuție
            oneStep(prg);

            // GARBAGE COLLECTOR:
            // păstrăm în heap doar adresele vii (din SymTable + lanț de referințe)
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

            // log după collector
            repo.logPrgState();

            // dacă flag e ON -> afișăm starea programului după fiecare pas
            if (displayFlag) {
                System.out.println("---- step ----");
                System.out.println(prg);
            }
        }

        // dacă flag e OFF -> afișăm doar starea finală
        if (!displayFlag) {
            System.out.println("--- Final State ---");
            System.out.println(prg);
        }
    }
}
