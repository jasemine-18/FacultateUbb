package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.exceptions.NonBooleanConditionException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.BoolType;
import ro.jas.toy.model.type.Type;
import ro.jas.toy.model.value.BoolValue;
import ro.jas.toy.model.value.Value;


//Daca exp este false => iesim din while (nu mai punem nimic pe stiva)
//Daca exp este true  => punem pe stiva: stmt; while(exp) stmt
public class WhileStmt implements IStmt {

    private final Exp exp;    // conditia de continuare
    private final IStmt stmt; // corpul buclei

    public WhileStmt(Exp exp, IStmt stmt) {
        this.exp = exp;
        this.stmt = stmt;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        var symTable = state.getSymTable();
        MyIHeap<Value> heap = state.getHeap();

        // evaluam condiția folosind SymTable + Heap
        Value condVal = exp.eval(symTable, heap);

        // verificam ca e BoolType
        if (!condVal.getType().equals(new BoolType())) {
            throw new NonBooleanConditionException();
        }

        BoolValue boolCond = (BoolValue) condVal;
        MyIStack<IStmt> stk = state.getStk();

        if (boolCond.getVal()) {
            // Pe stiva punem intai while, apoi stmt
            stk.push(new WhileStmt(exp, stmt));
            stk.push(stmt);
        }
        // daca e false, nu mai punem nimic pe stiva => bucla se termina

        return state;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typeExp = exp.typecheck(typeEnv);

        if (typeExp.equals(new BoolType())) {
            stmt.typecheck(typeEnv.deepCopy());
            return typeEnv;
        }

        throw new MyException("The condition of WHILE has not the type bool");
    }

    @Override
    public String toString() {
        return "while(" + exp + ") { " + stmt + " }";
    }
}
