package repository;

import model.Vehicle;

public class InMemoryRepository implements IRepository{
    //toate vehiculele
    private final Vehicle[] data;
    //locuri ocupate
    private int size;

    //constructor
    public InMemoryRepository(int capacity){
        if(capacity <= 0 ){
            throw  new IllegalArgumentException("Capacity must be > 0");
        }
        this.data=new Vehicle[capacity];
        this.size = 0;
    }

    //adauga vehicul
    @Override
    public void add(Vehicle v) throws RepoException{
        if(v==null){
            throw new RepoException("Cannot add null vehicle");
        }
        if (size >= data.length) {
            throw new RepoException("Repository is full (capacity=" + data.length + ")");
        }
        data[size++] = v;
    }

    //stergem o masina
    @Override
    public void remove(int index) throws RepoException{
        if(index < 0 || index >= size){
            throw new RepoException("Invalid index: " + index);
        }

        for(int i =index; i<size-1; i++){
            data[i] = data[i+1];
        }
        data[--size] = null;
    }

    @Override
    public Vehicle[] getAll(){
        return data;
    }

    @Override
    public int getSize(){
        return size;
    }

    @Override
    public int getCapacity(){
        return data.length;
    }
}
