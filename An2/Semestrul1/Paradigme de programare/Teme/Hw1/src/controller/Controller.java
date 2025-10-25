package controller;

import model.Vehicle;
import repository.IRepository;
import repository.RepoException;

public class Controller {
    private final IRepository repo;

    //constructor
    public Controller(IRepository repo){
        this.repo = repo;
    }

    public void addVehicle(Vehicle v) throws RepoException{
        repo.add(v);
    }

    public void removeVehicle(int index) throws RepoException{
        repo.remove(index);
    }

    public Vehicle[] getAllVehicles(){
        return repo.getAll();
    }

    public int getSize(){
        return repo.getSize();
    }

    public int getCapacity(){
        return repo.getCapacity();
    }

    //color filter
    public Vehicle[] getVehiclesByColor(String color){
        if (color == null) {
            return new Vehicle[0];
        }

        int count =  0;
        for(int i = 0; i< repo.getSize(); i++){
            Vehicle v = repo.getAll()[i];
            if (color.equalsIgnoreCase(v.getColor())){
                count++;
            }
        }

        Vehicle[] result = new Vehicle[count];
        int k=0;
        for (int i=0; i < repo.getSize(); i++){
            Vehicle v =repo.getAll()[i];
            if (color.equalsIgnoreCase(v.getColor())){
                result[k++] = v;
            }
        }
        return result;
    }

    public Vehicle[] getRedVehicles() {
        return getVehiclesByColor("red");
    }
}
