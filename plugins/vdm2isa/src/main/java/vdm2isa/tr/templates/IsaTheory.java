package vdm2isa.tr.templates;

import java.time.Instant;
import java.util.List;

public class IsaTheory extends IsaAbstractTemplate {
    
    public final Instant utc;
    public final String comment;
    public final String location; 
    public final IsaIdentifier name;
    public final List<IsaIdentifier> imports;
    public final List<String> body;

    protected IsaTheory(Instant utc, String comment, String loc, IsaIdentifier name, List<IsaIdentifier> imports, List<String> body)
    {
        super(comment);
        this.utc = utc;
        this.comment = comment;
        this.location = loc;
        this.name = name;
        this.imports = IsaAbstractTemplate.createList(imports);
        this.body = IsaAbstractTemplate.createList(body);
    }

    public String getUTC() 
    {
        return utc.toString();
    }
}
