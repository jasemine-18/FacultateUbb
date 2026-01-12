package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.*;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.*;

/** LogicExp: and/or (op: "and"/"or"). Verifica tipurile. */
public class LogicExp implements Exp {
    private final String op;
    private final Exp e1, e2;

    //constructor
    public LogicExp(String op, Exp e1, Exp e2) {
        this.op = op;
        this.e1 = e1;
        this.e2 = e2;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> tbl,
                      MyIHeap<Value> heap) throws MyException {
        Value v1 = e1.eval(tbl, heap);
        if (!v1.getType().equals(new BoolType())) throw new TypeMismatchException("first operand is not bool");
        Value v2 = e2.eval(tbl, heap);
        if (!v2.getType().equals(new BoolType())) throw new TypeMismatchException("second operand is not bool");

        boolean b1 = ((BoolValue) v1).getVal();
        boolean b2 = ((BoolValue) v2).getVal();

        return switch (op) {
            case "and" -> new BoolValue(b1 && b2);
            case "or"  -> new BoolValue(b1 || b2);
            default    -> throw new MyException("unknown logic op: " + op);
        };
    }

    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type t1 = e1.typecheck(typeEnv);
        Type t2 = e2.typecheck(typeEnv);

        if (!t1.equals(new BoolType()))
            throw new MyException("first operand is not boolean");
        if (!t2.equals(new BoolType()))
            throw new MyException("second operand is not boolean");

        return new BoolType();
    }


    @Override public String toString() { return "(" + e1 + " " + op + " " + e2 + ")"; }
}
