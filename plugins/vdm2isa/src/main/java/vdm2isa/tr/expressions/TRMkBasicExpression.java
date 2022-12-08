package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCMkBasicExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRMkBasicExpression extends TRExpression {
    
    private static final long serialVersionUID = 1L;
	public final TRType type;
	public final TRExpression arg;

    public TRMkBasicExpression(LexLocation location, TCMkBasicExpression exp, TRType type, TRExpression arg, TRType exptype) {
        super(location, exp, exptype);
        this.type = type;
        this.arg = arg;
    }

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(type, arg);
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseMkBasicExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.TOKEN;
    }

    @Override
    public String oldtranslate() {
        StringBuilder sb = new StringBuilder();
        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(arg.oldtranslate());
        return IsaToken.parenthesise(sb.toString());
    }
}
