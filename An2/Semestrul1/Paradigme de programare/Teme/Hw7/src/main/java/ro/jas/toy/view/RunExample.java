package ro.jas.toy.view;

import ro.jas.toy.controller.Controller;
import ro.jas.toy.exceptions.MyException;

public class RunExample extends Command{
    //fiecare comanda are propriul controller
    private final Controller controller;

    public RunExample(String key, String desc, Controller controller){
        super(key, desc);
        this.controller=controller;
    }

    @Override
    public void execute(){
        try{
            //apeleaza executia completa a programului
            controller.allStep();
        }catch(MyException e){
            System.out.println("Error during execution:" + e.getMessage());
        }
    }
}
