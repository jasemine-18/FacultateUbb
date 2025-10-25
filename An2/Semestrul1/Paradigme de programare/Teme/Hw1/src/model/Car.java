package model;

public class Car implements Vehicle {
    private final String brand;
    private final String color;

    public Car(String brand, String color) {
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
        return "Car";
    }

    @Override
    public String toString() {
        return "Car " + brand + " of color " + color;
    }
}
