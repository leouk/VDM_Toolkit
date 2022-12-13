package vdm2isa.tr.templates;

import java.util.List;

public class IsaIfThenElse extends IsaAbstractTemplate {
    
    public final String test;
    public final String then;
    public final String els; 

    protected IsaIfThenElse(List<String> comment, String test, String then, String els)
    {
        super(comment);
        this.test = test;
        this.then = then;
        this.els  = els;
    }
}
