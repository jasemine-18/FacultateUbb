package repository;

import model.Vehicle;

public interface IRepository {
    void add(Vehicle v) throws RepoException;
    void remove(int index) throws RepoException;
    Vehicle[] getAll();
    int getSize();
    int getCapacity();
}
