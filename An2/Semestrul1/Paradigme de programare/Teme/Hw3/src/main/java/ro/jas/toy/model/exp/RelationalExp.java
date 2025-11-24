package ro.jas.toy.model.exp;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.type.IntType;
import ro.jas.toy.model.value.BoolValue;
import ro.jas.toy.model.value.IntValue;
import ro.jas.toy.model.value.Value;

public class RelationalExp implements Exp{
    private final Exp e1;
    private final Exp e2;
    private final String op;

    public  RelationalExp(String op, Exp e1, Exp e2){
        this.op=op;
        this.e1=e1;
        this.e2=e2;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> tbl) throws MyException{
        Value v1 =e1.eval(tbl);
        Value v2 =e2.eval(tbl);

        //ambele valori trebuie sa fie int
        if(!v1.getType().equals(new IntType()))
            throw new MyException("First operand is not an int in relational expression");
        if(!v2.getType().equals(new IntType()))
            throw new MyException("Second operand is not an int in relational expression");

        int n1=((IntValue) v1).getVal();
        int n2=((IntValue) v2).getVal();

        return switch(op){
            case "<" -> new BoolValue(n1 < n2);
            case "<=" -> new BoolValue(n1 <= n2);
            case "==" -> new BoolValue(n1 == n2);
            case "!=" -> new BoolValue(n1 != n2);
            case ">" -> new BoolValue(n1 > n2);
            case ">=" -> new BoolValue(n1 >= n2);
            default -> throw new MyException("Unknown relational operator:" + op);
        };
    }

    @Override
    public String toString(){
        return e1 + " " + op + " " + e2;
    }
}
