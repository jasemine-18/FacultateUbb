package ro.jas.toy.view;

import ro.jas.toy.controller.Controller;
import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.adt.*;
import ro.jas.toy.model.exp.*;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.stmt.*;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.*;
import ro.jas.toy.repo.MyIRepository;
import ro.jas.toy.repo.MyRepository;

import java.io.BufferedReader;

public class Interpreter {

    private static Controller buildController(IStmt program, String logFile, boolean displayFlag) throws MyException {
        // 1) Typecheck BEFORE execution
        program.typecheck(new MyDictionary<>());

        // 2) Runtime structures
        MyIStack<IStmt> stk = new MyStack<>();
        MyIDictionary<String, Value> symTable = new MyDictionary<>();
        MyIList<Value> out = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable = new MyDictionary<>();
        MyIHeap<Value> heap = new MyHeap<>();

        // 3) Program state + repo + controller
        PrgState prg = new PrgState(stk, symTable, out, fileTable, heap, program);
        MyIRepository repo = new MyRepository(prg, logFile);
        return new Controller(repo, displayFlag);
    }

    private static Controller safeBuild(IStmt program, String logFile, boolean displayFlag, String exName) {
        try {
            return buildController(program, logFile, displayFlag);
        } catch (MyException e) {
            System.out.println("[TYPECHECK ERROR] " + exName + " -> " + (e.getMessage() == null ? e : e.getMessage()));
            return null;
        }
    }

    public static void main(String[] args) {

        // === Example 1: int v; v=2; print(v)
        IStmt ex1 = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(2))),
                        new PrintStmt(new VarExp("v"))
                )
        );

        // === Example 2: int a; a=2+3*5; int b; b=a-4/2+7; print(b)
        IStmt ex2 = new CompStmt(
                new VarDeclStmt("a", new IntType()),
                new CompStmt(
                        new AssignStmt("a",
                                new ArithExp('+',
                                        new ValueExp(new IntValue(2)),
                                        new ArithExp('*',
                                                new ValueExp(new IntValue(3)),
                                                new ValueExp(new IntValue(5))
                                        )
                                )
                        ),
                        new CompStmt(
                                new VarDeclStmt("b", new IntType()),
                                new CompStmt(
                                        new AssignStmt("b",
                                                new ArithExp('+',
                                                        new VarExp("a"),
                                                        new ArithExp('-',
                                                                new ValueExp(new IntValue(7)),
                                                                new ArithExp('/',
                                                                        new ValueExp(new IntValue(4)),
                                                                        new ValueExp(new IntValue(2))
                                                                )
                                                        )
                                                )
                                        ),
                                        new PrintStmt(new VarExp("b"))
                                )
                        )
                )
        );

        // === Example 3: bool a=false; if a then v=2 else v=3; print(v)
        IStmt ex3 = new CompStmt(
                new VarDeclStmt("a", new BoolType()),
                new CompStmt(
                        new VarDeclStmt("v", new IntType()),
                        new CompStmt(
                                new AssignStmt("a", new ValueExp(new BoolValue(false))),
                                new CompStmt(
                                        new IfStmt(
                                                new VarExp("a"),
                                                new AssignStmt("v", new ValueExp(new IntValue(2))),
                                                new AssignStmt("v", new ValueExp(new IntValue(3)))
                                        ),
                                        new PrintStmt(new VarExp("v"))
                                )
                        )
                )
        );

        // === Example 4: files
        // string varf; varf="test.in"; openRFile(varf); int varc;
        // readFile(varf,varc); print(varc); readFile(varf,varc); print(varc); closeRFile(varf);
        IStmt ex4 = new CompStmt(
                new VarDeclStmt("varf", new StringType()),
                new CompStmt(
                        new AssignStmt("varf", new ValueExp(new StringValue("test.in"))),
                        new CompStmt(
                                new OpenRFileStmt(new VarExp("varf")),
                                new CompStmt(
                                        new VarDeclStmt("varc", new IntType()),
                                        new CompStmt(
                                                new ReadFileStmt(new VarExp("varf"), "varc"),
                                                new CompStmt(
                                                        new PrintStmt(new VarExp("varc")),
                                                        new CompStmt(
                                                                new ReadFileStmt(new VarExp("varf"), "varc"),
                                                                new CompStmt(
                                                                        new PrintStmt(new VarExp("varc")),
                                                                        new CloseRFileStmt(new VarExp("varf"))
                                                                )
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );

        // === Example 5: relational
        // int a; int b; a=5; b=7; if (a<b) print(a) else print(b)
        IStmt ex5 = new CompStmt(
                new VarDeclStmt("a", new IntType()),
                new CompStmt(
                        new VarDeclStmt("b", new IntType()),
                        new CompStmt(
                                new AssignStmt("a", new ValueExp(new IntValue(5))),
                                new CompStmt(
                                        new AssignStmt("b", new ValueExp(new IntValue(7))),
                                        new IfStmt(
                                                new RelationalExp("<", new VarExp("a"), new VarExp("b")),
                                                new PrintStmt(new VarExp("a")),
                                                new PrintStmt(new VarExp("b"))
                                        )
                                )
                        )
                )
        );

        // === Example 6: Heap read
        // Ref int v; new(v,20); Ref Ref int a; new(a,v); print(rH(v)); print(rH(rH(a))+5)
        IStmt ex6 = new CompStmt(
                new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(
                                        new NewStmt("a", new VarExp("v")),
                                        new CompStmt(
                                                new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                                                new PrintStmt(
                                                        new ArithExp(
                                                                '+',
                                                                new ReadHeapExp(
                                                                        new ReadHeapExp(new VarExp("a"))
                                                                ),
                                                                new ValueExp(new IntValue(5))
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );

        // === Example 7: Heap write
        // Ref int v; new(v,20); print(rH(v)); wH(v,30); print(rH(v)+5)
        IStmt ex7 = new CompStmt(
                new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                                new CompStmt(
                                        new WriteHeapStmt("v", new ValueExp(new IntValue(30))),
                                        new PrintStmt(
                                                new ArithExp(
                                                        '+',
                                                        new ReadHeapExp(new VarExp("v")),
                                                        new ValueExp(new IntValue(5))
                                                )
                                        )
                                )
                        )
                )
        );

        // === Example 8: While
        // int v; v=4; while(v>0) { print(v); v=v-1; } print(v)
        IStmt ex8 = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(4))),
                        new CompStmt(
                                new WhileStmt(
                                        new RelationalExp(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                                        new CompStmt(
                                                new PrintStmt(new VarExp("v")),
                                                new AssignStmt(
                                                        "v",
                                                        new ArithExp('-', new VarExp("v"), new ValueExp(new IntValue(1)))
                                                )
                                        )
                                ),
                                new PrintStmt(new VarExp("v"))
                        )
                )
        );

        // === Example 9: GC test (official)
        // Ref int v; new(v,20); Ref Ref int a; new(a,v); new(v,30); print(rH(rH(a)))
        IStmt ex9 = new CompStmt(
                new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(
                        new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(
                                new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(
                                        new NewStmt("a", new VarExp("v")),
                                        new CompStmt(
                                                new NewStmt("v", new ValueExp(new IntValue(30))),
                                                new PrintStmt(
                                                        new ReadHeapExp(
                                                                new ReadHeapExp(new VarExp("a"))
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );

        // === BAD Example (should FAIL typecheck): int v; v = true; print(v)
        IStmt badTypeCheck = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new BoolValue(true))), // WRONG: bool into int
                        new PrintStmt(new VarExp("v"))
                )
        );

        // === Build controllers (WITH typecheck) ===
        Controller ctr1 = safeBuild(ex1, "log1.txt", true, "Example 1");
        Controller ctr2 = safeBuild(ex2, "log2.txt", true, "Example 2");
        Controller ctr3 = safeBuild(ex3, "log3.txt", true, "Example 3");
        Controller ctr4 = safeBuild(ex4, "log4.txt", true, "Example 4");
        Controller ctr5 = safeBuild(ex5, "log5.txt", true, "Example 5");
        Controller ctr6 = safeBuild(ex6, "log6.txt", true, "Example 6");
        Controller ctr7 = safeBuild(ex7, "log7.txt", true, "Example 7");
        Controller ctr8 = safeBuild(ex8, "log8.txt", true, "Example 8");
        Controller ctr9 = safeBuild(ex9, "log9.txt", true, "Example 9");
        Controller ctrBadTypeCheck = safeBuild(badTypeCheck, "badTypeCheck.txt", true, "BadTypeCheck");

        // === Menu ===
        TextMenu menu = new TextMenu();
        menu.addCommand(new ExitCommand("0", "Exit"));

        if (ctr1 != null) menu.addCommand(new RunExample("1", "Example 1: int v; v=2; print(v)", ctr1));
        if (ctr2 != null) menu.addCommand(new RunExample("2", "Example 2: int a; a=2+3*5; int b; b=a-4/2+7; print(b)", ctr2));
        if (ctr3 != null) menu.addCommand(new RunExample("3", "Example 3: bool a=false; if a then v=2 else v=3; print(v)", ctr3));
        if (ctr4 != null) menu.addCommand(new RunExample("4", "Example 4: file example (open/read/close test.in)", ctr4));
        if (ctr5 != null) menu.addCommand(new RunExample("5", "Example 5: a=5, b=7, if a<b then print a else print b", ctr5));
        if (ctr6 != null) menu.addCommand(new RunExample("6", "Example 6: Ref int v; new(v,20); Ref Ref int a; new(a,v); print(rH(v)); print(rH(rH(a))+5)", ctr6));
        if (ctr7 != null) menu.addCommand(new RunExample("7", "Example 7: Ref int v; new(v,20); print(rH(v)); wH(v,30); print(rH(v)+5)", ctr7));
        if (ctr8 != null) menu.addCommand(new RunExample("8", "Example 8: While: int v; v=4; while(v>0){print(v);v=v-1;} print(v)", ctr8));
        if (ctr9 != null) menu.addCommand(new RunExample("9", "Example 9: GC: Ref int v; new(v,20); Ref Ref int a; new(a,v); new(v,30); print(rH(rH(a)))", ctr9));
        if (ctrBadTypeCheck != null) menu.addCommand(new RunExample("10", "BAD Example: int v; v=true; print(v)", ctrBadTypeCheck));

        menu.addCommand(new Command("10", "BAD Example (should fail typecheck)") {
            @Override
            public void execute() {
                System.out.println("This program failed typecheck, so it cannot run.");
            }
        });

        menu.addCommand(new ToggleDisplayCommand(
                "11",
                "Toggle display flag (ON/OFF)",
                ctr1, ctr2, ctr3, ctr4, ctr5, ctr6, ctr7, ctr8, ctr9
        ));

        menu.run();
    }
}