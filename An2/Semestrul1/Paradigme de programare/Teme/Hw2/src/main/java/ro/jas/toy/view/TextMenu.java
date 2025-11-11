package ro.jas.toy.view;

import ro.jas.toy.controller.Controller;
import ro.jas.toy.model.adt.*;
import ro.jas.toy.model.exp.*;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.stmt.*;
import ro.jas.toy.model.type.*;
import ro.jas.toy.model.value.*;
import ro.jas.toy.repo.*;

import java.util.Scanner;

/**
 * View minimal pentru A2: afișează 3 exemple hardcodate și rulează unul.
 * În A3 îl vom extinde cu logging, step-by-step etc.
 */
public class TextMenu {

    private IStmt example1() {
        // int v; v=2; Print(v)
        return new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(2))),
                        new PrintStmt(new VarExp("v"))
                )
        );
    }

    private IStmt example2() {
        // int a; a=2+3*5; int b; b=a-4/2+7; Print(b)
        return new CompStmt(new VarDeclStmt("a", new IntType()),
                new CompStmt(new AssignStmt("a",
                        new ArithExp('+',
                                new ValueExp(new IntValue(2)),
                                new ArithExp('*',
                                        new ValueExp(new IntValue(3)),
                                        new ValueExp(new IntValue(5)))
                        )),
                        new CompStmt(new VarDeclStmt("b", new IntType()),
                                new CompStmt(new AssignStmt("b",
                                        new ArithExp('+',
                                                new ArithExp('-',
                                                        new VarExp("a"),
                                                        new ArithExp('/',
                                                                new ValueExp(new IntValue(4)),
                                                                new ValueExp(new IntValue(2)))
                                                ),
                                                new ValueExp(new IntValue(7))
                                        )),
                                        new PrintStmt(new VarExp("b"))))));
    }


    private IStmt example3() {
        // bool a; a=false; int v; If a Then v=2 Else v=3; Print(v)
        return new CompStmt(new VarDeclStmt("a", new BoolType()),
                new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(false))),
                        new CompStmt(new VarDeclStmt("v", new IntType()),
                                new CompStmt(new IfStmt(new VarExp("a"),
                                        new AssignStmt("v", new ValueExp(new IntValue(2))),
                                        new AssignStmt("v", new ValueExp(new IntValue(3)))),
                                        new PrintStmt(new VarExp("v"))))));
    }

    private void runProgram(IStmt prgStmt) {
        MyIStack<IStmt> stk = new MyStack<>();
        MyIDictionary<String, Value> sym = new MyDictionary<>();
        MyIList<Value> out = new MyList<>();
        PrgState prg = new PrgState(stk, sym, out, prgStmt);
        MyIRepository repo = new MyRepository(prg);
        Controller ctrl = new Controller(repo);
        ctrl.setDisplayFlag(true); // 👈 afișează după fiecare pas


        try {
            ctrl.allStep();
            System.out.println("--- Final State ---");
            System.out.println(prg); // vezi Out, SymTable etc.
        } catch (Exception e) {
            System.err.println("Runtime error: " + e.getMessage());
        }
    }

    /** Pornește meniul în consolă. */
    public void run() {
        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.println("\n=== Toy Language A2 Text Menu ===");
            System.out.println("1) Example1: int v; v=2; Print(v)");
            System.out.println("2) Example2: int a; a=2+3*5; int b; b=a-4/2+7; Print(b)");
            System.out.println("3) Example3: bool a=false; if a then v=2 else v=3; Print(v)");
            System.out.println("0) Exit");
            System.out.print("Select: ");
            String opt = sc.nextLine().trim();

            switch (opt) {
                case "1" -> runProgram(example1());
                case "2" -> runProgram(example2());
                case "3" -> runProgram(example3());
                case "0" -> { System.out.println("Bye!"); return; }
                default  -> System.out.println("Invalid option.");
            }
        }
    }
}
