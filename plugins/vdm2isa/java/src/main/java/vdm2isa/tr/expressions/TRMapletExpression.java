package vdm2isa.tr.expressions;

import vdm2isa.lex.IsaToken;

public class TRMapletExpression extends TRExpression 
{
    private final TRExpression left;
    private final TRExpression right; 

    public TRMapletExpression(TRExpression left, TRExpression right)
    {
        super(left);
        this.left = left;
        this.right = right;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.MAPLET;
    }

    @Override
    public String translate() {
        //@todo add spacing control on the Isa token?
        return left.translate() + IsaToken.MAPLET + right.translate();
    }


}
