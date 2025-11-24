1. Introduction

This project implements an interpreter for a simplified toy programming language, developed as part of Assignments A2 and A3 within the “Paradigms of Programming” course. The interpreter adheres to the Model–View–Controller (MVC) architectural paradigm and is structured around modular components designed for extensibility and clarity.

The language supports variable declarations, arithmetic and logical expressions, control flow statements, relational expressions, and basic file-handling operations. All runtime data structures (execution stack, symbol table, output, file table) are implemented using custom Abstract Data Types (ADTs).
2. Architectural Overview (MVC)
2.1 Model

The Model encapsulates:

Program State (PrgState)

Statements (IStmt hierarchy)

Expressions (Exp hierarchy)

Types and Values

Three generic ADTs:

MyIStack<T> / MyStack<T>

MyIDictionary<K,V> / MyDictionary<K,V>

MyIList<T> / MyList<T>

These abstractions ensure a clear, object-oriented representation of the interpreted language.

2.1.1 Types

Implemented types:

IntType

BoolType

StringType (introduced in A3)

Each type implements:

equals

toString

defaultValue() for variable initialization

2.1.2 Values

Implemented values:

IntValue

BoolValue

StringValue

Each value:

stores the associated data

implements getType() and equals().

2.1.3 Expressions

Expression classes evaluate to Value objects using the symbolic environment (SymTable):

ValueExp

VarExp

ArithExp (addition, subtraction, multiplication, division)

LogicExp (logical conjunction/disjunction)

RelationalExp (A3: <, <=, ==, !=, >, >=)

Each expression is defined by:
Value eval(MyIDictionary<String, Value> symTable) throws MyException
2.1.4 Statements

Statements define how the program evolves. Implemented statements include:

VarDeclStmt

AssignStmt

PrintStmt

CompStmt (composition)

IfStmt

NopStmt

File-related statements (A3):

OpenRFileStmt

ReadFileStmt

CloseRFileStmt

2.1.5 Program State

PrgState stores the dynamic components of an executing program:

Execution Stack (ExeStack)

Symbol Table (SymTable)

Output List (Out)

File Table (FileTable)

Original Program (deep copy)

2.2 Repository

The Repository is responsible for:

storing one or more program states

maintaining execution logs

The logging mechanism (logPrgStateExec) outputs the complete internal state after each execution step to files such as:

log1.txt
log2.txt
log3.txt
log4.txt


Each log includes:

Execution Stack

Symbol Table

Output List

File Table

2.3 Controller

The Controller manages the execution of programs through two fundamental methods:

2.3.1 oneStep(PrgState state)

Executes a single instruction from the execution stack.

2.3.2 allStep()

Executes the entire program until the execution stack becomes empty, invoking logging after each step.

2.3.3 Display Flag

A configurable flag controlling runtime visualization:

ON → displays step-by-step execution in the console

OFF → displays only the final program state

This significantly improves user experience during testing and debugging.

2.4 View (Text-Based Interface)
TextMenu

The textual interface allows the user to:

select a predefined example program

toggle the display mode

execute programs to completion

The menu includes:

0) Exit
1) Example 1
2) Example 2
3) Example 3
4) File Example
5) Relational Example
6) Toggle display flag (ON/OFF)


The interface is implemented using a set of command classes (Command, RunExampleCommand, ExitCommand, ToggleDisplayCommand).

3. Example Programs

The project includes several predefined toy-language programs illustrating:

variable declarations

complex arithmetic expressions

conditional execution

relational expressions

file reading + buffered file operations

These serve both as demonstrations and as automated tests for interpreter functionality.

4. Technologies Used

Java 21

Gradle Build System

IntelliJ IDEA

OOP / MVC Architecture

Custom Generic Data Structures

5. Status

This repository contains a complete and fully functional implementation for Assignments:

A2 — Interpreter Core + ADTs

A3 — File Handling, Logging, Relational Expressions, Display Flag

All functionalities were implemented according to the official laboratory specification.
