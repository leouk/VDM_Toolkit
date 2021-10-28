package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

/**
 * Super class for VDM expressions with declared local definitions (e.g. lambda, let, etc.) 
 */
public abstract class TRVDMLocalDefinitionListExpression extends TRExpression {
    
    private static final long serialVersionUID = 1L;
    protected String tabs;

    public TRVDMLocalDefinitionListExpression(LexLocation location)
    {
        super(location);
        this.tabs = "\n\t\t";
    }
}
