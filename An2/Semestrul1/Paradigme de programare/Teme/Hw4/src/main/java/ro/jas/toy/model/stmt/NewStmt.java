package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.RefType;
import ro.jas.toy.model.type.Type;
import ro.jas.toy.model.value.RefValue;
import ro.jas.toy.model.value.Value;

// new(varName, exp)
// Alocă o locație în heap pentru rezultatul expresiei și
// pune în variabila varName o referință către acea locație.
public class NewStmt implements IStmt {

    private final String varName;
    private final Exp expression;

    public NewStmt(String varName, Exp expression) {
        this.varName = varName;
        this.expression = expression;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        // SymTable: pentru variabile
        MyIDictionary<String, Value> symTable = state.getSymTable();
        // Heap: pentru memorie dinamică
        MyIHeap<Value> heap = state.getHeap();

        // 1) verificăm că variabila există în SymTable
        if (!symTable.isDefined(varName)) {
            throw new MyException("Variable '" + varName + "' is not defined in the symbol table.");
        }

        // 2) variabila trebuie să fie de tip RefType
        Value varValue = symTable.lookup(varName);
        Type varType = varValue.getType();
        if (!(varType instanceof RefType refType)) {
            throw new MyException("Variable '" + varName + "' is not of RefType.");
        }

        // 3) evaluăm expresia
        Value evalValue = expression.eval(symTable, heap);  // deocamdată eval nu folosește heap-ul

        // 4) tipul valorii evaluate trebuie să fie egal cu inner-ul lui RefType
        Type locationType = refType.getInner();
        if (!evalValue.getType().equals(locationType)) {
            throw new MyException(
                    "Type mismatch in new(" + varName + ", exp): "
                            + "expression type = " + evalValue.getType()
                            + " but locationType = " + locationType
            );
        }

        // 5) alocăm în heap o nouă adresă pentru valoarea calculată
        int address = heap.allocate(evalValue);

        // 6) actualizăm SymTable: varName -> RefValue(adresa_nouă, locationType)
        symTable.update(varName, new RefValue(address, locationType));

        return state;
    }

    @Override
    public String toString() {
        return "new(" + varName + ", " + expression.toString() + ")";
    }
}
