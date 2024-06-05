package vdm2isa.tr.templates;

import com.fujitsu.vdmj.lex.LexLocation;

public class IsaVDMSource extends IsaAbstractTemplate {
    
    public final String source; 
    public final LexLocation location; 

    protected IsaVDMSource(String source, LexLocation location)
    {
        super(null);
        this.source = source;
        this.location = LexLocation.ANY.equals(location) ? null : location; 
    }
}
