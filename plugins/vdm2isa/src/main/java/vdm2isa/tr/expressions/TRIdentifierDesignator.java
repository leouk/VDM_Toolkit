package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRStateDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRIdentifierDesignator extends TRStateDesignator {

    public final TCNameToken name;
    
    public TRIdentifierDesignator(LexLocation location, TCNameToken name)
	{
		super(location);
        this.name = name;
	}

    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) 
    {
        return visitor.caseIdentifierDesignator(this, arg);
    }

    public String translate()
    {
        return TRStateDefinition.state.recordType.findField(name.toString()).getIsabelleTagName();
    }

    public String getName()
    {
        return name.toString();
    }

    public IsaToken isaToken()
    {
        return IsaToken.EOF;
    }

}
