package ro.jas.toy.gui;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ListCell;
import javafx.scene.control.ListView;
import javafx.stage.Stage;
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
import java.util.ArrayList;
import java.util.List;

public class ProgramSelectorController {

    @FXML
    private ListView<IStmt> programsList;

    private final List<IStmt> programs = new ArrayList<>();

    // -------------------------------
    // 1) BUILD CONTROLLER (cu typecheck)
    // -------------------------------
    private Controller buildController(IStmt program, String logFile, boolean displayFlag) throws MyException {
        // Typecheck BEFORE execution (A6 cerinta 5)
        program.typecheck(new MyDictionary<>());

        // Runtime structures (ca în Interpreter)
        MyIStack<IStmt> stk = new MyStack<>();
        MyIDictionary<String, Value> symTable = new MyDictionary<>();
        MyIList<Value> out = new MyList<>();
        MyIDictionary<StringValue, BufferedReader> fileTable = new MyDictionary<>();
        MyIHeap<Value> heap = new MyHeap<>();

        // Program state + repo + controller
        PrgState prg = new PrgState(stk, symTable, out, fileTable, heap, program);
        MyIRepository repo = new MyRepository(prg, logFile);
        return new Controller(repo, displayFlag);
    }

    // -------------------------------
    // 2) INIT: construim lista de programe
    // -------------------------------
    @FXML
    public void initialize() {
        // Ex1: int v; v=2; print(v)
        IStmt ex1 = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(2))),
                        new PrintStmt(new VarExp("v"))
                )
        );

        // Ex2: int a; a=2+3*5; int b; b=a-4/2+7; print(b)
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

        // Ex3: bool a=false; int v; a=false; if a then v=2 else v=3; print(v)
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

        // Ex4: file example
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

        // Ex5: relational
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

        // Ex6: heap read
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
                                                                new ReadHeapExp(new ReadHeapExp(new VarExp("a"))),
                                                                new ValueExp(new IntValue(5))
                                                        )
                                                )
                                        )
                                )
                        )
                )
        );

        // Ex7: heap write
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

        // Ex8: while
        IStmt ex8 = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new IntValue(4))),
                        new CompStmt(
                                new WhileStmt(
                                        new RelationalExp(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                                        new CompStmt(
                                                new PrintStmt(new VarExp("v")),
                                                new AssignStmt("v",
                                                        new ArithExp('-',
                                                                new VarExp("v"),
                                                                new ValueExp(new IntValue(1))
                                                        )
                                                )
                                        )
                                ),
                                new PrintStmt(new VarExp("v"))
                        )
                )
        );

        // Ex9: GC test (varianta “oficială” corectă)
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
                                                new PrintStmt(new ReadHeapExp(new ReadHeapExp(new VarExp("a"))))
                                        )
                                )
                        )
                )
        );

        // BAD: int v; v=true; print(v) -> trebuie să pice la typecheck
        IStmt bad = new CompStmt(
                new VarDeclStmt("v", new IntType()),
                new CompStmt(
                        new AssignStmt("v", new ValueExp(new BoolValue(true))),
                        new PrintStmt(new VarExp("v"))
                )
        );

        programs.add(ex1);
        programs.add(ex2);
        programs.add(ex3);
        programs.add(ex4);
        programs.add(ex5);
        programs.add(ex6);
        programs.add(ex7);
        programs.add(ex8);
        programs.add(ex9);
        programs.add(bad);

        programsList.setItems(FXCollections.observableArrayList(programs));

        programsList.setCellFactory(lv -> new ListCell<>() {
            @Override
            protected void updateItem(IStmt item, boolean empty) {
                super.updateItem(item, empty);
                setText(empty || item == null ? null : item.toString());
            }
        });

        // selectează primul implicit
        if (!programs.isEmpty()) {
            programsList.getSelectionModel().select(0);
        }
    }

    // -------------------------------
    // 3) OPEN PROGRAM BUTTON HANDLER
    // -------------------------------
    @FXML
    public void onOpenProgram() {
        IStmt selected = programsList.getSelectionModel().getSelectedItem();
        if (selected == null) {
            showError("No selection", "Please select a program.");
            return;
        }

        try {
            // construim controller cu typecheck (dacă nu trece -> aruncă MyException)
            Controller controller = buildController(selected, "gui-log.txt", true);

            // deschidem main window
            FXMLLoader loader = new FXMLLoader(MainFX.class.getResource("/ro/jas/toy/gui/main-window.fxml"));
            Scene scene = new Scene(loader.load(), 1100, 700);

            MainWindowController mainCtrl = loader.getController();
            mainCtrl.setController(controller); // IMPORTANT!

            Stage stage = new Stage();
            stage.setTitle("Toy Language - Execution");
            stage.setScene(scene);
            stage.show();

            // închide selectorul
            Stage current = (Stage) programsList.getScene().getWindow();
            current.close();

        } catch (MyException e) {
            // typecheck failed sau altceva
            showError("Typecheck failed", e.getMessage() == null ? e.toString() : e.getMessage());
        } catch (Exception e) {
            // FXML load error etc.
            showError("GUI error", e.getMessage() == null ? e.toString() : e.getMessage());
        }
    }

    private void showError(String title, String msg) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle("Error");
        alert.setHeaderText(title);
        alert.setContentText(msg);
        alert.showAndWait();
    }
}