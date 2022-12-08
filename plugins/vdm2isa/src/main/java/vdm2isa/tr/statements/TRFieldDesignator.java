package vdm2isa.tr.statements;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRFieldDesignator extends TRStateDesignator {

    TRStateDesignator object; 
    TCIdentifierToken field;

    public TRFieldDesignator(LexLocation location, TRStateDesignator object, TCIdentifierToken field)
	{
		super(location);
        this.object = object;
        this.field = field;
	}

    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) 
    {
        return visitor.caseFieldDesignator(this, arg);
    }

    public String oldtranslate(){
        // TODO
        return "Designator Field";
    }

    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    
}
