package ro.jas.toy.view;

import ro.jas.toy.controller.Controller;

public class ToggleDisplayCommand extends Command {
    private final Controller[] controllers;

    public ToggleDisplayCommand(String key, String description, Controller... controllers) {
        super(key, description);
        this.controllers = controllers;
    }

    @Override
    public void execute() {
        if (controllers == null || controllers.length == 0) {
            System.out.println("No controllers provided.");
            return;
        }

        Controller firstValid = null;
        for (Controller c : controllers) {
            if (c != null) { firstValid = c; break; }
        }

        if (firstValid == null) {
            System.out.println("No valid controllers to toggle.");
            return;
        }

        boolean newValue = !firstValid.getDisplayFlag();

        for (Controller c : controllers) {
            if (c != null) c.setDisplayFlag(newValue);
        }

        System.out.println("Display FLAG is now: " + (newValue ? "ON" : "OFF"));
    }
}