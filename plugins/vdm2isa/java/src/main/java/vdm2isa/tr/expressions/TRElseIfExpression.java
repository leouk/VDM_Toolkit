package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeSet;
import vdm2isa.tr.types.TRUnionType;

public class TRElseIfExpression extends TRExpression {
    
    private final TRExpression elseIfExp;
    private final TRExpression thenExp;

    public TRElseIfExpression(LexLocation location, TRExpression elseIfExp, TRExpression thenExp, TRType exptype)
    {
        super(location, exptype);
        this.elseIfExp = elseIfExp;
        this.thenExp = thenExp;
    }

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(elseIfExp, thenExp);
    }

    /**
	 * Choose the then type, is the resulting type (could not have been else); this is to attempt to solve the "(the (pattern))" problem
	 */
	@Override
	protected TRType getBestGuessType()
	{
        //NB what is the right VDM type for the elseif union?
        TRTypeSet typeSet = new TRTypeSet(thenExp.getType(), elseIfExp.getType());
		TRUnionType result = new TRUnionType(new TCUnionType(location, typeSet.getVDMTypeSet()), 
            new TRDefinitionList(), 
			new TRTypeSet(thenExp.getType(), elseIfExp.getType()));
        TRNode.setup(result);
        return result;
	}

    @Override
    public IsaToken isaToken() {
        return IsaToken.ELSEIF;
    }
    
    @Override
    public String translate() {
		StringBuilder sb = new StringBuilder();
        sb.append(getFormattingSeparator());
		sb.append(isaToken().toString());
		sb.append(" ");
		sb.append(IsaToken.parenthesise(elseIfExp.translate()));
		sb.append(" ");
		sb.append(IsaToken.THEN.toString());
		sb.append(getFormattingSeparator());
		sb.append(IsaToken.parenthesise(thenExp.translate()));
		return sb.toString();
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseElseIfExpression(this, arg);
    }
}
