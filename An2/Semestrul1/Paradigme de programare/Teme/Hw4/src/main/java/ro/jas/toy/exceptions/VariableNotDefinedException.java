package ro.jas.toy.exceptions;

public class VariableNotDefinedException extends EvalException { public VariableNotDefinedException(String id){ super("variable not declared: " + id); } }

