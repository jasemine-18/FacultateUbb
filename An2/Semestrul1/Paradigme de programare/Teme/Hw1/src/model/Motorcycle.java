package model;

public class Motorcycle implements Vehicle {
    private final String brand;
    private final String color;

    public Motorcycle(String brand, String color) {
        this.brand = brand;
        this.color = color;
    }

    @Override
    public String getBrand() {
        return brand;
    }

    @Override
    public String getColor() {
        return color;
    }

    @Override
    public String getType() {
        return "Motorcycle";
    }

    @Override
    public String toString() {
        return "Motorcycle " + brand + " of color " + color;
    }
}
