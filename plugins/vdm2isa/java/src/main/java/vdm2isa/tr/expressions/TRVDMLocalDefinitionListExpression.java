package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

/**
 * Super class for VDM expressions with declared local definitions (e.g. lambda, let, etc.) 
 */
public abstract class TRVDMLocalDefinitionListExpression extends TRExpression {
    
    private static final long serialVersionUID = 1L;
    protected final TRExpression expression;
    protected String tabs;

    public TRVDMLocalDefinitionListExpression(LexLocation location, TRExpression expression)
    {
        super(location);
        this.expression = expression;
        this.tabs = "\n\t\t";
    }

    public abstract String localInvTranslate();

    @Override
    public String invTranslate()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.LPAREN.toString());
        sb.append(IsaToken.IF.toString());
        sb.append(" ");
        sb.append(localInvTranslate());
        sb.append(" ");
        sb.append(IsaToken.THEN.toString());
        sb.append(tabs + "\t");
        sb.append(expression.translate());        
        sb.append(tabs + " ");
        sb.append(IsaToken.ELSE.toString());
        sb.append(tabs + "\t");
        sb.append(IsaToken.UNDEFINED.toString());
        sb.append(tabs); 
        sb.append(IsaToken.RPAREN.toString());
        sb.append("\n\t");
        return sb.toString();
    }
}
