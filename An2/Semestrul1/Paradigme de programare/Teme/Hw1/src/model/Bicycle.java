package model;

public class Bicycle implements Vehicle {
    private final String brand;
    private final String color;

    public Bicycle(String brand, String color) {
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
        return "Bicycle";
    }

    @Override
    public String toString() {
        return "Bicycle " + brand + " of color " + color;
    }
}
