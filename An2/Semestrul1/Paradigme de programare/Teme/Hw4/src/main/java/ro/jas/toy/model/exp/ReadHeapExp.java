package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.type.RefType;
import ro.jas.toy.model.value.RefValue;
import ro.jas.toy.model.value.Value;

public class ReadHeapExp implements Exp {

    private final Exp expression;  // ar trebui să fie de tip Ref

    public ReadHeapExp(Exp expression) {
        this.expression = expression;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> tbl,
                      MyIHeap<Value> heap) throws MyException {

        // 1) evaluăm expresia -> trebuie să fie RefValue
        Value v = expression.eval(tbl, heap);
        if (!(v instanceof RefValue refVal)) {
            throw new MyException("rH expression is not a RefValue: " + v);
        }

        int address = refVal.getAddr();

        // 2) verificăm dacă adresa există în heap
        if (!heap.isDefined(address)) {
            throw new MyException("Heap: address " + address + " not defined in rH");
        }

        // 3) întoarcem valoarea de la acea adresă
        return heap.lookup(address);
    }

    @Override
    public String toString() {
        return "rH(" + expression.toString() + ")";
    }
}
