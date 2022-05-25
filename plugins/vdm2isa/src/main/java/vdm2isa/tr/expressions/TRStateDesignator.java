package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

// @JK
// This is built on a hack as it technically needs its own base since it seems to have no connection to Expression
public abstract class TRStateDesignator extends TRExpression{

    public TRStateDesignator(LexLocation location)
	{
		super(location, null, null);
	}

    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) 
    {
        return visitor.caseTRStateDesignator(this, arg);
    }

    public abstract String translate();

    public IsaToken isaToken() {
        return IsaToken.EOF;
    }
    
}
