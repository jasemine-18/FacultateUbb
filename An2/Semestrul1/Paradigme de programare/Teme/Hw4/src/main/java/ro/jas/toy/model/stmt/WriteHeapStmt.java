package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.RefType;
import ro.jas.toy.model.value.RefValue;
import ro.jas.toy.model.value.Value;

/**
 * wH(varName, expression):
 *  - varName: variabilă de tip Ref(...)
 *  - expression: noua valoare ce va fi scrisă în heap la adresa din varName.
 */
public class WriteHeapStmt implements IStmt {

    private final String varName;
    private final Exp expression;

    public WriteHeapStmt(String varName, Exp expression) {
        this.varName = varName;
        this.expression = expression;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIHeap<Value> heap = state.getHeap();

        // 1) varName trebuie să existe în SymTable
        if (!symTable.isDefined(varName)) {
            throw new MyException("wH: variable " + varName + " is not defined in the symbol table");
        }

        Value varValue = symTable.lookup(varName);

        // 2) varName trebuie să fie de tip RefType
        if (!(varValue.getType() instanceof RefType)) {
            throw new MyException("wH: variable " + varName + " is not of RefType");
        }

        RefValue refVal = (RefValue) varValue;
        int address = refVal.getAddr();

        // 3) adresa din RefValue trebuie să existe în Heap
        if (!heap.isDefined(address)) {
            throw new MyException("wH: address " + address + " is not defined in the heap");
        }

        // 4) evaluăm expresia
        Value evalValue = expression.eval(symTable, heap);

        // 5) tipul rezultatului trebuie să fie egal cu locationType
        if (!evalValue.getType().equals(refVal.getLocationType())) {
            throw new MyException("wH: type mismatch. Variable "
                    + varName + " points to " + refVal.getLocationType()
                    + " but expression has type " + evalValue.getType());
        }

        // 6) scriem în heap la adresa respectivă
        heap.update(address, evalValue);

        return state;
    }

    @Override
    public String toString() {
        return "wH(" + varName + ", " + expression+")";
    }
}
