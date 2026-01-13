package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.RefValue;
import ro.jas.toy.model.value.Value;

public class ReadHeapExp implements Exp {

    private final Exp expression;  // trebui să fie de tip Ref

    public ReadHeapExp(Exp expression) {
        this.expression = expression;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> tbl,
                      MyIHeap<Value> heap) throws MyException {

        //evaluam expresia -> trebuie să fie RefValue
        Value v = expression.eval(tbl, heap);
        if (!(v instanceof RefValue refVal)) {
            throw new MyException("rH expression is not a RefValue: " + v);
        }

        int address = refVal.getAddr();

        //verificam daca adresa exista în heap
        if (!heap.isDefined(address)) {
            throw new MyException("Heap: address " + address + " not defined in rH");
        }

        // intoarcem valoarea de la acea adresa
        return heap.lookup(address);
    }

    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type t = expression.typecheck(typeEnv);

        if (!(t instanceof RefType))
            throw new MyException("the rH argument is not a Ref Type");

        RefType rt = (RefType) t;
        return rt.getInner();
    }



    @Override
    public String toString() {
        return "rH(" + expression.toString() + ")";
    }
}
