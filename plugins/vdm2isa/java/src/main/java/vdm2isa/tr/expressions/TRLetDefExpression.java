package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCDefExpression;
import com.fujitsu.vdmj.tc.expressions.TCLetDefExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRLetDefExpression extends TRVDMLocalDefinitionListExpression {

    private static final long serialVersionUID = 1L;
    public final TRDefinitionList localDefs;
    public final boolean isDefExpression;

    public TRLetDefExpression(LexLocation location, TCLetDefExpression tc, TRDefinitionList localDefs, TRExpression expression, TRType exptype, boolean isDefExpression)
    {
        super(location, tc, expression, exptype);
        this.localDefs = localDefs;
        //TODO limit the scope of things? Or not need, because VDMJ already does that? 
        this.isDefExpression = isDefExpression;
    }

    public TRLetDefExpression(TCLetDefExpression letdef, LexLocation location, TRDefinitionList localDefs, TRExpression expression, TRType exptype)
    {
        this(location, letdef, localDefs, expression, exptype, false);
    }

    public TRLetDefExpression(TCDefExpression def, LexLocation location, TRDefinitionList localDefs, TRExpression expression, TRType exptype)
    {
        this(location, def, localDefs, expression, exptype, true);
    }

    @Override
    public void setup()
	{
        super.setup();
        TRNode.setup(localDefs);
        setFormattingSeparator("\n\t\t");
	 	setInvTranslateSeparator(IsaToken.SPACE.toString() + IsaToken.AND.toString() + IsaToken.SPACE.toString());
        this.localDefs.setSemanticSeparator(IsaToken.SEMICOLON.toString());
        //System.out.println(toString());
	}

    @Override
    public String toString()
    {
        String exprStr = String.valueOf(expression);
        if (localDefs != null)
            return getClass().getSimpleName() + 
                " (" + localDefs.size() + ")" + 
                "\n\t defs = " + localDefs.toString() + " in " + 
                "\n\t exp  = " + exprStr +
                "\n\t loc  = " + String.valueOf(getLocation());
        else 
            return getClass().getSimpleName() + " (0)[null] = null in " + exprStr +
                "\n\t loc  = " + String.valueOf(getLocation()); 
    }

    @Override
    public IsaToken isaToken() {
       return IsaToken.LET;
    }

    public String translate() {
        StringBuilder sb = new StringBuilder();
        // let x: T1 = v1, y: T2 = v2 in exp(x, y)
        // =
        // (let x = v1; y = v2 in (x::VDMNat) (y::VDMNat1) in 
        //      exp(x, y)
        // )
        sb.append(getFormattingSeparator());
        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE.toString());
        String old = localDefs.setFormattingSeparator(getFormattingSeparator());        
        sb.append(localDefs.translate());
        sb.append(getFormattingSeparator());
        sb.append(IsaToken.IN.toString());
        sb.append(getFormattingSeparator() + "\t");
        // TRDefinitionList.patternContextTranslate for the let TRValueDefinition won't issue pattern for TRStructuredPattern
        // It works for records well because they don't have pattern list (i.e. it's themselves in the pattern),
        // TRStructuredPattern on the other hand, have a plist of basic (or other) patterns.  
        sb.append(localDefs.patternContextTranslate(null));
        sb.append(getFormattingSeparator() + "\t");
        localDefs.setFormattingSeparator(old);
        sb.append(invTranslate());
        return IsaToken.parenthesise(sb.toString());
    }

    /**
     * Local definitions invariant translation
     */
    @Override
    public String localInvTranslate()
    {
        String old = localDefs.setInvTranslateSeparator(getInvTranslateSeparator());
        String result = localDefs.invTranslate();
        localDefs.setInvTranslateSeparator(old);
        return result;
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLetDefExpression(this, arg);
	}
}
