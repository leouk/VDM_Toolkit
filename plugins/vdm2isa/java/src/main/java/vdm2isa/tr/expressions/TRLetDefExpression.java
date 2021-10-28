package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRLetDefExpression extends TRVDMLocalDefinitionListExpression {

    private static final long serialVersionUID = 1L;
    private final TRDefinitionList localDefs;

    public TRLetDefExpression(LexLocation location, TRDefinitionList localDefs, TRExpression expression)
    {
        super(location, expression);
        this.localDefs = localDefs;
        //TODO add this to IsaToken? see the reporting library 
        this.localDefs.separator = IsaToken.SEMICOLON.toString() + this.tabs;
        this.localDefs.setLocal(true);

        //System.out.println(toString());
    }

    @Override
    public String toString()
    {
        return "LetDef (" + localDefs.size() + ")[" + localDefs.get(0).getClass().getName() + "] = \n" +
            localDefs.toString() + " in " + expression.toString();
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
        sb.append("\n\t");
        sb.append(isaToken().toString());
        sb.append(" ");
        sb.append(localDefs.translate());
        sb.append("\n\t");
        sb.append(IsaToken.IN.toString());
        sb.append(tabs);
        sb.append(invTranslate());
        return IsaToken.parenthesise(sb.toString());
    }

    /**
     * Local definitions invariant translation
     */
    @Override
    public String localInvTranslate()
    {
        String old = localDefs.separator; 
        localDefs.separator = " " + IsaToken.AND.toString() + this.tabs;
        String result = localDefs.invTranslate();
        localDefs.separator = old;
        return result;
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLetDefExpression(this, arg);
	}
}
