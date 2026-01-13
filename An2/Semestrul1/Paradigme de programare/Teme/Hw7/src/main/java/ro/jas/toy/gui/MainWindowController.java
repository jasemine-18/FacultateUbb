package ro.jas.toy.gui;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import ro.jas.toy.controller.Controller;
import ro.jas.toy.exceptions.MyException;
import ro.jas.toy.model.state.PrgState;
import ro.jas.toy.model.stmt.IStmt;
import ro.jas.toy.model.value.StringValue;
import ro.jas.toy.model.value.Value;

import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class MainWindowController {

    private Controller controller;

    // ===== FXML =====
    @FXML private TextField prgStatesCountField;
    @FXML private Button runOneStepBtn;

    @FXML private ListView<Integer> prgStateIdsList;

    @FXML private TableView<HeapEntry> heapTable;
    @FXML private TableColumn<HeapEntry, Integer> heapAddressCol;
    @FXML private TableColumn<HeapEntry, String> heapValueCol;

    @FXML private ListView<String> outList;
    @FXML private ListView<String> fileTableList;

    @FXML private TableView<SymEntry> symTable;
    @FXML private TableColumn<SymEntry, String> symVarCol;
    @FXML private TableColumn<SymEntry, String> symValueCol;

    @FXML private ListView<String> exeStackList;

    // ===== DTOs =====
    public static class HeapEntry {
        private final Integer address;
        private final String value;
        public HeapEntry(Integer address, String value) { this.address = address; this.value = value; }
        public Integer getAddress() { return address; }
        public String getValue() { return value; }
    }

    public static class SymEntry {
        private final String var;
        private final String value;
        public SymEntry(String var, String value) { this.var = var; this.value = value; }
        public String getVar() { return var; }
        public String getValue() { return value; }
    }

    @FXML
    private void initialize() {
        heapAddressCol.setCellValueFactory(c -> new SimpleIntegerProperty(c.getValue().getAddress()).asObject());
        heapValueCol.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getValue()));

        symVarCol.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getVar()));
        symValueCol.setCellValueFactory(c -> new SimpleStringProperty(c.getValue().getValue()));

        prgStateIdsList.getSelectionModel()
                .selectedItemProperty()
                .addListener((obs, oldV, newV) -> refreshSelectedPrgState());
    }

    // called from MainFX after loading FXML
    public void setController(Controller controller) {
        this.controller = controller;
        refreshAll();
        autoSelectFirst();
        refreshSelectedPrgState();
    }

    @FXML
    private void onRunOneStep() {
        try {
            controller.oneStepForAllGUI();   // <- tu implementezi asta în Controller (1 step only)
            refreshAll();
            refreshSelectedPrgState();
        } catch (MyException e) {
            if (e.getMessage().contains("ExeStack is empty")) {
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Program finished");
                alert.setHeaderText("Execution finished");
                alert.setContentText("The program has no more steps to execute.");
                alert.showAndWait();
            } else {
                showError("Execution error", e.getMessage());
            }
        } catch (Exception e) {
            showError("GUI error", e.toString());
        }
    }

    // ===== refresh main parts =====
    private void refreshAll() {
        if (controller == null) return;

        List<PrgState> prgList = controller.getPrgList(); // <- getter in Controller
        prgStatesCountField.setText(String.valueOf(prgList.size()));

        // IDs
        List<Integer> ids = prgList.stream()
                .map(PrgState::getId)
                .sorted()
                .toList();
        prgStateIdsList.setItems(FXCollections.observableArrayList(ids));

        if (prgList.isEmpty()) {
            heapTable.setItems(FXCollections.observableArrayList());
            outList.setItems(FXCollections.observableArrayList());
            fileTableList.setItems(FXCollections.observableArrayList());
            symTable.setItems(FXCollections.observableArrayList());
            exeStackList.setItems(FXCollections.observableArrayList());
            return;
        }

        // Heap (shared)
        Map<Integer, Value> heap = prgList.get(0).getHeap().getContent();
        List<HeapEntry> heapEntries = heap.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .map(e -> new HeapEntry(e.getKey(), e.getValue().toString()))
                .toList();
        heapTable.setItems(FXCollections.observableArrayList(heapEntries));

        // Out (shared)
        List<String> outValues = prgList.get(0).getOut().getList().stream()
                .map(Object::toString)
                .toList();
        outList.setItems(FXCollections.observableArrayList(outValues));

        // FileTable (shared)
        List<String> files = prgList.get(0).getFileTable().getContent().keySet().stream()
                .map(StringValue::getVal)
                .sorted()
                .toList();
        fileTableList.setItems(FXCollections.observableArrayList(files));
    }

    private void refreshSelectedPrgState() {
        if (controller == null) return;

        List<PrgState> prgList = controller.getPrgList();
        if (prgList.isEmpty()) return;

        Integer selectedId = prgStateIdsList.getSelectionModel().getSelectedItem();
        PrgState prg = prgList.get(0);

        if (selectedId != null) {
            prg = prgList.stream()
                    .filter(p -> p.getId() == selectedId)
                    .findFirst()
                    .orElse(prgList.get(0));
        }

        // SymTable (selected prg)
        List<SymEntry> symEntries = prg.getSymTable().getContent().entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .map(e -> new SymEntry(e.getKey(), e.getValue().toString()))
                .toList();
        symTable.setItems(FXCollections.observableArrayList(symEntries));

        // ExeStack (selected prg) top -> bottom
        List<String> stackStrings = prg.getStk().getReversed().stream()
                .map(IStmt::toString)
                .toList();
        exeStackList.setItems(FXCollections.observableArrayList(stackStrings));
    }

    private void autoSelectFirst() {
        if (prgStateIdsList.getItems() != null && !prgStateIdsList.getItems().isEmpty()) {
            prgStateIdsList.getSelectionModel().select(0);
        }
    }

    private void showError(String title, String msg) {
        Alert a = new Alert(Alert.AlertType.ERROR);
        a.setTitle(title);
        a.setHeaderText(title);
        a.setContentText(msg == null ? "(no details)" : msg);
        a.showAndWait();
    }
}