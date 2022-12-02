package vdm2isa.lex.templates;

import java.time.Instant;

public class IsaTheory extends IsaAbstractTemplate {
    
    public final Instant utc;
    public final String comment;
    public final String location; 
    public final String name;
    public final String imports;
    public final String body;

    public IsaTheory(String location, String name, String imports, String body)
    {
        this(Instant.now(), "", location, name, imports, body);
    }

    public IsaTheory(Instant utc, String location, String name, String imports, String body)
    {
        this(utc, "", location, name, imports, body);
    }

    public IsaTheory(Instant utc, String comment, String loc, String name, String imports, String body)
    {
        if (name == null || name.isEmpty())
            throw new IllegalArgumentException("Invalid Isabelle empty theory name");
        //TODO valid identifier check if (String.i)
        this.utc = utc;
        this.comment = comment;
        this.location = loc;
        this.name = name;
        this.imports = imports;
        this.body = body;
    }

    public String getUTC() 
    {
        return utc.toString() + " OKAY!";
    }
}
