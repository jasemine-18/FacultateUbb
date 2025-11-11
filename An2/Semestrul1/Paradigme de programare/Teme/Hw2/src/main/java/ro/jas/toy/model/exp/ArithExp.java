package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.type.IntType;
import ro.jas.toy.model.value.*;

/** ArithExp: +, -, *, / (op: '+','-','*','/'). Verifică tipurile + div by zero. */
public class ArithExp implements Exp {
    private final char op;
    private final Exp e1, e2;

    public ArithExp(char op, Exp e1, Exp e2) { this.op = op; this.e1 = e1; this.e2 = e2; }

    @Override
    public Value eval(MyIDictionary<String, Value> tbl) throws MyException {
        Value v1 = e1.eval(tbl);
        if (!v1.getType().equals(new IntType())) throw new MyException("first operand is not int");
        Value v2 = e2.eval(tbl);
        if (!v2.getType().equals(new IntType())) throw new MyException("second operand is not int");

        int n1 = ((IntValue) v1).getVal();
        int n2 = ((IntValue) v2).getVal();

        return switch (op) {
            case '+' -> new IntValue(n1 + n2);
            case '-' -> new IntValue(n1 - n2);
            case '*' -> new IntValue(n1 * n2);
            case '/' -> {
                if (n2 == 0) throw new MyException("division by zero");
                yield new IntValue(n1 / n2);
            }
            default -> throw new MyException("unknown arithmetic op: " + op);
        };
    }

    @Override public String toString() { return "(" + e1 + " " + op + " " + e2 + ")"; }
}
