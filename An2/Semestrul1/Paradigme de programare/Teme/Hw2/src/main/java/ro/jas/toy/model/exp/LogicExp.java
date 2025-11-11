package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.type.BoolType;
import ro.jas.toy.model.value.*;

/** LogicExp: and/or (op: "and"/"or"). Verifică tipurile. */
public class LogicExp implements Exp {
    private final String op;
    private final Exp e1, e2;

    public LogicExp(String op, Exp e1, Exp e2) { this.op = op; this.e1 = e1; this.e2 = e2; }

    @Override
    public Value eval(MyIDictionary<String, Value> tbl) throws MyException {
        Value v1 = e1.eval(tbl);
        if (!v1.getType().equals(new BoolType())) throw new MyException("first operand is not bool");
        Value v2 = e2.eval(tbl);
        if (!v2.getType().equals(new BoolType())) throw new MyException("second operand is not bool");

        boolean b1 = ((BoolValue) v1).getVal();
        boolean b2 = ((BoolValue) v2).getVal();

        return switch (op) {
            case "and" -> new BoolValue(b1 && b2);
            case "or"  -> new BoolValue(b1 || b2);
            default    -> throw new MyException("unknown logic op: " + op);
        };
    }

    @Override public String toString() { return "(" + e1 + " " + op + " " + e2 + ")"; }
}
