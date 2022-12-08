package vdm2isa.tr.templates;

import java.time.Instant;
import java.util.List;

import org.stringtemplate.v4.ST;

public class IsaTheory extends IsaAbstractTemplate {
    
    public final Instant utc;
    public final String comment;
    public final String location; 
    public final IsaIdentifier name;
    public final List<IsaIdentifier> imports;
    public final List<ST> body;
    public final List<IsaVDMTheoryExport> exports;

    protected IsaTheory(Instant utc, String comment, String loc, IsaIdentifier name, List<IsaIdentifier> imports, List<ST> body, List<IsaVDMTheoryExport> exports) 
    {
        super(comment);
        this.utc = utc;
        this.comment = comment;
        this.location = loc;
        this.name = name;
        this.imports = IsaAbstractTemplate.createList(imports);
        this.body = IsaAbstractTemplate.createList(body);
        this.exports = IsaAbstractTemplate.createList(exports);
    }

    public String getUTC() 
    {
        return utc.toString();
    }
}
