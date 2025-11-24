 🧠 Toy Language Interpreter — Assignments A2 & A3
Paradigms of Programming — UBB Informatics

This project implements an interpreter for a simplified Toy Language, following the Model–View–Controller (MVC) architecture.
It fulfills all requirements for Assignments A2 and A3, including ADTs, expressions, statements, file operations, execution logging, and an interactive text-based menu.

🏛️ Architecture Overview (MVC)
📌 Model

Defines all language elements and runtime structures.

✔ Types

Supported types:

IntType

BoolType

StringType (A3)

public interface Type {
    Value defaultValue();
}

✔ Values

Runtime representations:

IntValue

BoolValue

StringValue

public interface Value {
    Type getType();
    boolean equals(Object other);
}

✔ Expressions

Expressions compute values using the symbol table.

Included:

ValueExp

VarExp

ArithExp

LogicExp

RelationalExp (A3)

Value eval(MyIDictionary<String, Value> tbl) throws MyException;

✔ Statements

Statements modify the program state.

Implemented:

VarDeclStmt

AssignStmt

PrintStmt

IfStmt

CompStmt

NopStmt

File-related statements (A3):

OpenRFileStmt

ReadFileStmt

CloseRFileStmt

PrgState execute(PrgState state) throws MyException;

✔ Abstract Data Types (ADTs)

Custom implementations used to model runtime structures.

MyStack<T>

MyDictionary<K,V>

MyList<T>

public interface MyIStack<T> {
    void push(T value);
    T pop() throws MyException;
}

✔ Program State (PrgState)

Stores the current execution environment.

class PrgState {
    MyIStack<IStmt> exeStack;
    MyIDictionary<String,Value> symTable;
    MyIList<Value> out;
    MyIDictionary<StringValue, BufferedReader> fileTable;
}

📦 Repository

Manages program states and logs execution.

✔ Execution Logging

After each step, the repository outputs:

Execution Stack

Symbol Table

Output List

File Table

void logPrgStateExec() throws MyException;

🎮 Controller

Executes program instructions.

✔ One-step execution
PrgState oneStep(PrgState state);

✔ Full program execution
void allStep();

✔ Display Flag

Controls console verbosity.

boolean displayFlag; // ON or OFF

🖥️ View — Text Menu Interface

Interactive console menu using the Command design pattern.

Menu options:

0) Exit
1) Example 1
2) Example 2
3) Example 3
4) File Example
5) Relational Example
6) Toggle display flag (ON/OFF)

abstract class Command {
    String key;
    String description;
    abstract void execute();
}

📚 Example Programs

Examples demonstrate:

variable declarations

arithmetic evaluation

conditional branching

relational operations

file reading (A3)

IStmt example = new CompStmt(
    new VarDeclStmt("v", new IntType()),
    new CompStmt(
        new AssignStmt("v", new ValueExp(new IntValue(2))),
        new PrintStmt(new VarExp("v"))
    )
);

⚙️ Technologies

Java 21

Gradle

IntelliJ IDEA

MVC Architecture

Custom Generic ADTs

✔️ Assignment Completion
A2

ADTs

Expressions

Statements

Program State

Interpreter Core

A3

File Operations

Execution Logging

Relational Expressions

Display Flag

Extended Examples

All requirements from the laboratory specification are fully implemented.
