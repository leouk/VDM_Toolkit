package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.patterns.TRMultipleBind;

public class TRIotaExpression extends TRExpression {

    private TRMultipleBind bind;
    private TRExpression predicate;
    
    public TRIotaExpression(LexLocation location, TRMultipleBind bind, TRExpression predicate)
    {
        super(location);
        this.bind = bind;
        this.predicate = predicate;
    }

    @Override
    public IsaToken isaToken() {
       return IsaToken.IOTA;
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(isaToken().toString() + " " + 
            bind.plist.get(0).translate() + IsaToken.POINT.toString() + " " + 
            IsaToken.parenthesise(bind.translate()) + IsaToken.AND.toString() +
            predicate.translate());
    }

}
