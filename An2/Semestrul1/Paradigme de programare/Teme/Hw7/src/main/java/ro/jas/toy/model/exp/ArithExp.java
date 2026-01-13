package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.DivisionByZeroException;
import ro.jas.toy.exceptions.*;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.*;

/** ArithExp: +, -, *, / (op: '+','-','*','/'). Verifica tipurile + div by zero. */
public class ArithExp implements Exp {
    private final char op;
    private final Exp e1, e2;

    //constructor
    public ArithExp(char op, Exp e1, Exp e2) {
        this.op = op;
        this.e1 = e1;
        this.e2 = e2;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> tbl,
                      MyIHeap<Value> heap) throws MyException {
        Value v1 = e1.eval(tbl, heap); //evalueaza operandul stang
        if (!v1.getType().equals(new IntType())) throw new TypeMismatchException("first operand is not int");
        Value v2 = e2.eval(tbl, heap); //evalueaza operandul drept
        if (!v2.getType().equals(new IntType())) throw new TypeMismatchException("second operand is not int");

        //extrage valoarea numerica
        int n1 = ((IntValue) v1).getVal();
        int n2 = ((IntValue) v2).getVal();

        return switch (op) { //alege operatia
            case '+' -> new IntValue(n1 + n2);
            case '-' -> new IntValue(n1 - n2);
            case '*' -> new IntValue(n1 * n2);
            case '/' -> {
                if (n2 == 0) throw new DivisionByZeroException();
                yield new IntValue(n1 / n2);
            }
            default -> throw new MyException("unknown arithmetic op: " + op);
        };
    }

    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type t1 = e1.typecheck(typeEnv);
        Type t2 = e2.typecheck(typeEnv);

        if (!t1.equals(new IntType()))
            throw new MyException("first operand is not an integer");
        if (!t2.equals(new IntType()))
            throw new MyException("second operand is not an integer");

        return new IntType();
    }



    @Override public String toString() { return "(" + e1 + " " + op + " " + e2 + ")"; }
}
