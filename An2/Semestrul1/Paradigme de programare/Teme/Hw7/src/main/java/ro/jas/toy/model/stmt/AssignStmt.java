package ro.jas.toy.model.stmt;

import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.exceptions.TypeMismatchException;
import ro.jas.toy.exceptions.VariableNotDefinedException;
import ro.jas.toy.model.adt.MyIDictionary;
import ro.jas.toy.model.adt.MyIHeap;
import ro.jas.toy.model.exp.Exp;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.type.Type;
import ro.jas.toy.model.value.Value;

// id = exp; verifica tipul si actualizeaza SymTable.
public class AssignStmt implements IStmt {
    private final String id;
    private final Exp exp;

    //constructor
    public AssignStmt(String id, Exp exp) {
        this.id = id;
        this.exp = exp;
    }

    //atribuirea unei valori(evalueaza expresia din dreapta si o adauga in SymTable)
    @Override
    public PrgState execute(PrgState state) throws MyException {
        //luam tabela de simboluri
        MyIDictionary<String, Value> sym = state.getSymTable();
        MyIHeap<Value> heap = state.getHeap();

        //verificam daca variabila a fost declarata inainte
        if (!sym.isDefined(id)) throw new VariableNotDefinedException(id);

        //evaluam expresia
        Value val = exp.eval(sym, heap);

        //vedem ce tip are variabila declarata
        Type typId = sym.lookup(id).getType();
        //verificam daca tipul rezultatului se potriveste cu tipul variabilei
        if (!val.getType().equals(typId))
            throw new TypeMismatchException("type mismatch: var " + id + " vs expression");
        sym.update(id, val);
        return state;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typeVar = typeEnv.lookup(id);
        Type typeExp = exp.typecheck(typeEnv);

        if (typeVar.equals(typeExp))
            return typeEnv;

        throw new MyException("Assignment: right hand side and left hand side have different types");
    }


    @Override public String toString() { return id + " = " + exp; }
}
