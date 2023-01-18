package vdm2isa.tr.templates;

import java.time.Instant;
import java.util.Arrays;
import java.util.List;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.FileList;

public class IsaTheory extends IsaAbstractTemplate {
    
    public final Instant utc;
    public final LexLocation location; 
    public final FileList files;
    public final IsaIdentifier name;
    public final List<IsaIdentifier> imports;
    public final List<String> body;
    public final List<IsaVDMTheoryExport> exports;

    protected IsaTheory(Instant utc, String comment, LexLocation loc, FileList files, IsaIdentifier name, List<IsaIdentifier> imports, List<String> body, List<IsaVDMTheoryExport> exports) 
    {
        super(Arrays.asList(comment));
        this.utc = utc;
        this.location = loc;
        this.files = files;
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
