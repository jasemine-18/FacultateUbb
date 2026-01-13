package ro.jas.toy.gui;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class MainFX extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader(MainFX.class.getResource("/ro/jas/toy/gui/program-selector.fxml"));
        Scene scene = new Scene(loader.load(), 800, 500);

        primaryStage.setTitle("Toy Language - Select Program");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}