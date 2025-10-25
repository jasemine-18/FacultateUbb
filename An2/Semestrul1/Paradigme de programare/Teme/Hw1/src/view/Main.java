package view;

import controller.Controller;
import model.*;
import repository.*;

public class Main {
    public static void main(String[] args) {
        try {
            IRepository repo = new InMemoryRepository(10);
            Controller c = new Controller(repo);

            c.addVehicle(new Car("Toyota", "red"));
            c.addVehicle(new Car("BMW", "blue"));
            c.addVehicle(new Motorcycle("Yamaha", "red"));
            c.addVehicle(new Motorcycle("Suzuki", "black"));
            c.addVehicle(new Bicycle("Pegas", "green"));
            c.addVehicle(new Bicycle("MB", "red"));

            System.out.println("All vehicles:");
            printArray(c.getAllVehicles(), c.getSize());


            System.out.println("\nRed vehicles:");
            Vehicle[] reds = c.getRedVehicles();
            printArray(reds, reds.length);

            c.removeVehicle(2);
            System.out.println("\nAll vehicles after deleting the Yamaha Motorcycle:");
            printArray(c.getAllVehicles(), c.getSize());


        } catch (RepoException e) {
            System.out.println("Repository error: " + e.getMessage());
        }
    }

    private static void printArray(Vehicle[] arr, int size) {
        if (size == 0) {
            System.out.println("(no vehicles found)");
            return;
        }
        for (int i = 0; i < size; i++) {
            System.out.println(arr[i]);
        }
    }
}
