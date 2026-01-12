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

        //verificam ca variabila exista în SymTable
        if (!symTable.isDefined(varName)) {
            throw new MyException("Variable '" + varName + "' is not defined in the symbol table.");
        }

        // variabila trebuie sa fie de tip RefType
        Value varValue = symTable.lookup(varName);
        Type varType = varValue.getType();
        if (!(varType instanceof RefType refType)) {
            throw new MyException("Variable '" + varName + "' is not of RefType.");
        }

        // evaluam expresia
        Value evalValue = expression.eval(symTable, heap);

        // tipul valorii evaluate trebuie sa fie egal cu inner-ul lui RefType
        Type locationType = refType.getInner();
        if (!evalValue.getType().equals(locationType)) {
            throw new MyException(
                    "Type mismatch in new(" + varName + ", exp): "
                            + "expression type = " + evalValue.getType()
                            + " but locationType = " + locationType
            );
        }

        // alocam în heap o nouas adresa pentru valoarea calculata
        int address = heap.allocate(evalValue);

        // actualizam SymTable: varName -> RefValue(adresa_nouă, locationType)
        symTable.update(varName, new RefValue(address, locationType));

        return state;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typeVar = typeEnv.lookup(varName);
        Type typeExp = expression.typecheck(typeEnv);

        if (typeVar.equals(new RefType(typeExp))) {
            return typeEnv;
        }

        throw new MyException("NEW stmt: right hand side and left hand side have different types");
    }

    @Override
    public String toString() {
        return "new(" + varName + ", " + expression.toString() + ")";
    }
}
