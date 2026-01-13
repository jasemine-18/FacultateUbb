package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.RefValue;
import ro.jas.toy.model.value.Value;


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

        //varName trebuie să existe în SymTable
        if (!symTable.isDefined(varName)) {
            throw new MyException("wH: variable " + varName + " is not defined in the symbol table");
        }

        Value varValue = symTable.lookup(varName);

        //varName trebuie să fie de tip RefType
        if (!(varValue.getType() instanceof RefType)) {
            throw new MyException("wH: variable " + varName + " is not of RefType");
        }

        RefValue refVal = (RefValue) varValue;
        int address = refVal.getAddr();

        //adresa din RefValue trebuie să existe în Heap
        if (!heap.isDefined(address)) {
            throw new MyException("wH: address " + address + " is not defined in the heap");
        }

        //evaluam expresia
        Value evalValue = expression.eval(symTable, heap);

        //tipul rezultatului trebuie să fie egal cu locationType
        if (!evalValue.getType().equals(refVal.getLocationType())) {
            throw new MyException("wH: type mismatch. Variable "
                    + varName + " points to " + refVal.getLocationType()
                    + " but expression has type " + evalValue.getType());
        }

        //scriem în heap la adresa respectiva
        heap.update(address, evalValue);

        return state;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typeVar = typeEnv.lookup(varName);

        if (!(typeVar instanceof RefType refType)) {
            throw new MyException("wH stmt: " + varName + " is not a RefType");
        }

        Type typeExp = expression.typecheck(typeEnv);
        Type inner = refType.getInner();

        if (inner.equals(typeExp)) return typeEnv;

        throw new MyException("wH stmt: right hand side and left hand side have different types");
    }

    @Override
    public String toString() {
        return "wH(" + varName + ", " + expression+")";
    }
}
