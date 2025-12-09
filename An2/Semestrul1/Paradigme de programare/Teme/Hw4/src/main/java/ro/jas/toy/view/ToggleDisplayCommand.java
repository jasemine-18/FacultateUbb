package ro.jas.toy.view;

import ro.jas.toy.controller.Controller;

public class ToggleDisplayCommand extends Command{
    private final Controller[] controllers;

    public ToggleDisplayCommand(String key, String description, Controller ... controllers){
        super(key, description);
        this.controllers = controllers;
    }

    @Override
    public void execute(){
        boolean old = controllers[0].getDisplayFlag();
        boolean newValue = !old;

        for (Controller c : controllers)
            c.setDisplayFlag(newValue);

        System.out.println("Display FLAG is now: " + (newValue ? "ON" : "OFF"));
    }
}
