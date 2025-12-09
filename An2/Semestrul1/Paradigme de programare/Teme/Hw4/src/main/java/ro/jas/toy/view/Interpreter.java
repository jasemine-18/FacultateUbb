package ro.jas.toy.view;

import ro.jas.toy.controller.Controller;
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

    public static void main(String[] args) {

        // === Example 1: int v; v=2; Print(v)
        IStmt ex1 = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(2))),
                        new PrintStmt(new VarExp("v"))
                )
        );

        // === Example 2: int a; a=2+3*5; int b; b=a-4/2+7; Print(b)
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

        // === Example 3: bool a=false; if a then v=2 else v=3; Print(v)
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

        // === Example 4: cu fișiere
        // string varf; varf = "test.in";
        // openRFile(varf);
        // int varc;
        // readFile(varf, varc); print(varc);
        // readFile(varf, varc); print(varc);
        // closeRFile(varf);
        IStmt ex4 =
                new CompStmt(
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

        // === Example 6: Ref int v; new(v,20); Ref Ref int a; new(a,v); print(rH(v)); print(rH(rH(a))+5)
        IStmt ex6 = new CompStmt(
                new VarDeclStmt("v", new RefType(new IntType())),                // Ref int v;
                new CompStmt(
                        new NewStmt("v", new ValueExp(new IntValue(20))),        // new(v, 20);
                        new CompStmt(
                                new VarDeclStmt("a",
                                        new RefType(new RefType(new IntType()))),   // Ref Ref int a;
                                new CompStmt(
                                        new NewStmt("a", new VarExp("v")),          // new(a, v);
                                        new CompStmt(
                                                // print(rH(v));
                                                new PrintStmt(
                                                        new ReadHeapExp(
                                                                new VarExp("v")
                                                        )
                                                ),
                                                // print(rH(rH(a)) + 5);
                                                new PrintStmt(
                                                        new ArithExp(
                                                                '+',
                                                                new ReadHeapExp(
                                                                        new ReadHeapExp(
                                                                                new VarExp("a")
                                                                        )
                                                                ),
                                                                new ValueExp(new IntValue(5))
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );

        // === Example 7: Ref int v; new(v,20); print(rH(v)); wH(v,30); print(rH(v)+5);
        IStmt ex7 = new CompStmt(
                new VarDeclStmt("v", new RefType(new IntType())),          // Ref int v;
                new CompStmt(
                        new NewStmt("v", new ValueExp(new IntValue(20))),  // new(v,20);
                        new CompStmt(
                                new PrintStmt(                             // print(rH(v));
                                        new ReadHeapExp(
                                                new VarExp("v")
                                        )
                                ),
                                new CompStmt(
                                        new WriteHeapStmt(                // wH(v,30);
                                                "v",
                                                new ValueExp(new IntValue(30))
                                        ),
                                        new PrintStmt(                     // print(rH(v)+5);
                                                new ArithExp(
                                                        '+',
                                                        new ReadHeapExp(
                                                                new VarExp("v")
                                                        ),
                                                        new ValueExp(new IntValue(5))
                                                )
                                        )
                                )
                        )
                    )
                );




        // === pentru fiecare exemplu: stări + repo + controller ===

        // ex1
        MyIStack<IStmt> stk1 = new MyStack<>();
        MyIDictionary<String, Value> symTable1 = new MyDictionary<>();
        MyIList<Value> out1 = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable1 = new MyDictionary<>();
        MyIHeap<Value> heap1 = new MyHeap<>();
        PrgState prg1 = new PrgState(stk1, symTable1, out1, fileTable1, heap1,ex1);
        MyIRepository repo1 = new MyRepository(prg1, "log1.txt");
        Controller ctr1 = new Controller(repo1, true);

        // ex2
        MyIStack<IStmt> stk2 = new MyStack<>();
        MyIDictionary<String, Value> symTable2 = new MyDictionary<>();
        MyIList<Value> out2 = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable2 = new MyDictionary<>();
        MyIHeap<Value> heap2 = new MyHeap<>();
        PrgState prg2 = new PrgState(stk2, symTable2, out2, fileTable2, heap2 ,ex2);
        MyIRepository repo2 = new MyRepository(prg2, "log2.txt");
        Controller ctr2 = new Controller(repo2, true);

        // ex3
        MyIStack<IStmt> stk3 = new MyStack<>();
        MyIDictionary<String, Value> symTable3 = new MyDictionary<>();
        MyIList<Value> out3 = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable3 = new MyDictionary<>();
        MyIHeap<Value> heap3 = new MyHeap<>();
        PrgState prg3 = new PrgState(stk3, symTable3, out3, fileTable3, heap3, ex3);
        MyIRepository repo3 = new MyRepository(prg3, "log3.txt");
        Controller ctr3 = new Controller(repo3, true);

        // ex4 (files)
        MyIStack<IStmt> stk4 = new MyStack<>();
        MyIDictionary<String, Value> symTable4 = new MyDictionary<>();
        MyIList<Value> out4 = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable4 = new MyDictionary<>();
        MyIHeap<Value> heap4 = new MyHeap<>();
        PrgState prg4 = new PrgState(stk4, symTable4, out4, fileTable4, heap4, ex4);
        MyIRepository repo4 = new MyRepository(prg4, "log4.txt");
        Controller ctr4 = new Controller(repo4, true);

        //ex5
        MyIStack<IStmt> stk5 = new MyStack<>();
        MyIDictionary<String, Value> symTable5 = new MyDictionary<>();
        MyIList<Value> out5 = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable5 = new MyDictionary<>();
        MyIHeap<Value> heap5 = new MyHeap<>();
        PrgState prg5 = new PrgState(stk5, symTable5, out5, fileTable5, heap5,ex5);
        MyIRepository repo5 = new MyRepository(prg5, "log5.txt");
        Controller ctr5 = new Controller(repo5, true);

        //ex6
        MyIStack<IStmt> stk6 = new MyStack<>();
        MyIDictionary<String, Value> symTable6 = new MyDictionary<>();
        MyIList<Value> out6 = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable6 = new MyDictionary<>();
        MyIHeap<Value> heap6 = new MyHeap<>();
        PrgState prg6 = new PrgState(stk6, symTable6, out6, fileTable6, heap6, ex6);
        MyIRepository repo6 = new MyRepository(prg6, "log6.txt");
        Controller ctr6 = new Controller(repo6, true);

        // ex7 (wH)
        MyIStack<IStmt> stk7 = new MyStack<>();
        MyIDictionary<String, Value> symTable7 = new MyDictionary<>();
        MyIList<Value> out7 = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable7 = new MyDictionary<>();
        MyIHeap<Value> heap7 = new MyHeap<>();
        PrgState prg7 = new PrgState(stk7, symTable7, out7, fileTable7, heap7, ex7);
        MyIRepository repo7 = new MyRepository(prg7, "log7.txt");
        Controller ctr7 = new Controller(repo7,true);

        // Construim meniul
        TextMenu menu = new TextMenu();

        menu.addCommand(new ExitCommand("0", "Exit"));
        menu.addCommand(new RunExample("1",
                "Example 1: int v; v=2; print(v)", ctr1));
        menu.addCommand(new RunExample("2",
                "Example 2: int a; a=2+3*5; int b; b=a-4/2+7; print(b)", ctr2));
        menu.addCommand(new RunExample("3",
                "Example 3: bool a=false; if a then v=2 else v=3; print(v)", ctr3));
        menu.addCommand(new RunExample("4",
                "Example 4: file example (open/read/close test.in)", ctr4));
        menu.addCommand(new RunExample("5",
                "Example 5: a=5, b=7, if a<b then print a else print b", ctr5));
        menu.addCommand(new RunExample("6",
                "Example 6: Ref int v; new(v,20); Ref Ref int a; new(a,v); print(rH(v)); print(rH(rH(a))+5)", ctr6));
        menu.addCommand(new RunExample("7",
                "Example 7: Ref int v; new(v,20); print(rH(v)); wH(v,30); print(rH(v)+5)", ctr7));

        menu.addCommand(new ToggleDisplayCommand("8",
                "Toggle display flag (ON/OFF)",
                ctr1, ctr2, ctr3, ctr4, ctr5, ctr6, ctr7));

        menu.run();
    }
}
