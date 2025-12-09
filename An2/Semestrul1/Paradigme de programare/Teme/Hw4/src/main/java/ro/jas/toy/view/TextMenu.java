package ro.jas.toy.view;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class TextMenu {
    private final Map<String, Command> commands;

    public TextMenu() {
        this.commands = new HashMap<>();
    }

    public void addCommand(Command c) {
        commands.put(c.getKey(), c);
    }

    private void printMenu() {
        System.out.println("=== Toy Language Text Menu ===");
        for (Command com : commands.values()) {
            System.out.println(com.getKey() + ") " + com.getDescription());
        }
    }

    public void run() {
        try (Scanner scanner = new Scanner(System.in)) {
            while (true) {
                printMenu();
                System.out.print("Select: ");
                String key = scanner.nextLine();
                Command com = commands.get(key);

                if (com == null) {
                    System.out.println("Invalid option!");
                } else {
                    com.execute();
                }
            }
        }
    }
}
