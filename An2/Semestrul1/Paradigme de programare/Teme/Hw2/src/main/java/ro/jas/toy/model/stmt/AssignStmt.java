package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.Type;
import ro.jas.toy.model.value.Value;

/** id = exp; verifică tipul și actualizează SymTable. */
public class AssignStmt implements IStmt {
    private final String id;
    private final Exp exp;

    public AssignStmt(String id, Exp exp) { this.id = id; this.exp = exp; }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyIDictionary<String, Value> sym = state.getSymTable();
        if (!sym.isDefined(id)) throw new MyException("variable not declared: " + id);

        Value val = exp.eval(sym);
        Type typId = sym.lookup(id).getType();
        if (!val.getType().equals(typId))
            throw new MyException("type mismatch: var " + id + " vs expression");
        sym.update(id, val);
        return state;
    }

    @Override public String toString() { return id + " = " + exp; }
}
