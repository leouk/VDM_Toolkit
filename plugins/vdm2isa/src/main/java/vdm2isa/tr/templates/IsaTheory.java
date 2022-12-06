package vdm2isa.tr.templates;

import java.time.Instant;
import java.util.List;

public class IsaTheory extends IsaAbstractTemplate {
    
    public final Instant utc;
    public final String comment;
    public final String location; 
    public final String name;
    public final List<String> imports;
    public final String body;

    public IsaTheory(String location, String name, String body, String... imports)
    {
        this(Instant.now(), "", location, name, body, imports);
    }

    public IsaTheory(Instant utc, String location, String name, String body, String... imports)
    {
        this(utc, "", location, name, body, imports);
    }

    public IsaTheory(Instant utc, String comment, String loc, String name, String body, String... imports)
    {
        if (name == null || name.isEmpty())
            throw new IllegalArgumentException("Invalid Isabelle empty theory name");
        //TODO valid identifier check if (String.i)
        this.utc = utc;
        this.comment = comment;
        this.location = loc;
        this.name = name;
        this.imports = IsaAbstractTemplate.createList(imports);
        this.body = body;
    }

    public String getUTC() 
    {
        return utc.toString();
    }
}
