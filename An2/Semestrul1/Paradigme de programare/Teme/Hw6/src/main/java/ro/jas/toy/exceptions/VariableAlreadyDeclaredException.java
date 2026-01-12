package ro.jas.toy.exceptions;

public class VariableAlreadyDeclaredException extends ExecException { public VariableAlreadyDeclaredException(String id){ super("variable already declared: " + id); } }

