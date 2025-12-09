package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.exceptions.NonBooleanConditionException;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.adt.MyIStack;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.BoolType;
import ro.jas.toy.model.value.BoolValue;
import ro.jas.toy.model.value.Value;

/**
 * while (exp) stmt
 *
 * Regula:
 *  - Daca exp este false => iesim din while (nu mai punem nimic pe stiva)
 *  - Daca exp este true  => punem pe stiva: stmt; while(exp) stmt
 *    (intai se executa stmt, apoi din nou while)
 */
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

        // evaluăm condiția folosind SymTable + Heap
        Value condVal = exp.eval(symTable, heap);

        // verificam ca e BoolType
        if (!condVal.getType().equals(new BoolType())) {
            throw new NonBooleanConditionException();
        }

        BoolValue boolCond = (BoolValue) condVal;
        MyIStack<IStmt> stk = state.getStk();

        if (boolCond.getVal()) {
            // while (exp) stmt   se rescrie ca:
            // stmt ; while(exp) stmt
            // Pe stiva punem intai while, apoi stmt (LIFO: stmt se va executa primul)
            stk.push(new WhileStmt(exp, stmt)); // va rula dupa ce termina corpul curent
            stk.push(stmt);                     // corpul curent al while-ului
        }
        // daca e false, nu mai punem nimic pe stiva => bucla se termina

        return state;
    }

    @Override
    public String toString() {
        return "while(" + exp + ") { " + stmt + " }";
    }
}
