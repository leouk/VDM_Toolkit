package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRType;

public class TRPreExpression extends TRExpression {
    
    private TRExpression function;
    private TRExpressionList args;

    public TRPreExpression(LexLocation location, TRExpression function, TRExpressionList args, TRType exptype)
    {
        super(location, exptype);
        this.function = function;
        this.args = args;
    }

    @Override
    public TRType getType()
    {
        return TRBasicType.boolType(location);
    }
    
    @Override
    public IsaToken isaToken() {
        return IsaToken.PRE;
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.casePreExpression(this, args);
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(isaToken().toString());
        sb.append(IsaToken.UNDERSCORE.toString());
        sb.append(IsaToken.LPAREN.toString());
        sb.append(function.translate());
        sb.append(args.getSemanticSeparator());
        sb.append(args.getFormattingSeparator());
        sb.append(args.translate());
        sb.append(IsaToken.RPAREN.toString());
        report(IsaErrorMessage.PLUGIN_NYI_2P, "translation", "function pre expression");
        return sb.toString();
    } 
}
