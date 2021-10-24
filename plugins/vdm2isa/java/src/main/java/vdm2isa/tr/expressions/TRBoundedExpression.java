package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCExists1Expression;
import com.fujitsu.vdmj.tc.expressions.TCExistsExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCForAllExpression;
import com.fujitsu.vdmj.tc.expressions.TCIotaExpression;
import com.fujitsu.vdmj.tc.expressions.TCLambdaExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.patterns.TRMultipleBind;
import vdm2isa.tr.patterns.TRMultipleBindList;

public class TRBoundedExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
	private final TRMultipleBindList bindList;
	private final TRExpression predicate;
    private final IsaToken owner;
     
    public TRBoundedExpression(TCIotaExpression owner, TRMultipleBind bind, TRExpression predicate)
    {
        super(owner.location);
        this.bindList = bind.getMultipleBindList();
        this.predicate = predicate;
        this.owner = IsaToken.IOTA;
    }

    public TRBoundedExpression(TCExists1Expression owner, TRMultipleBind bind, TRExpression predicate)
    {
        super(owner.location);
        this.bindList = bind.getMultipleBindList();
        this.predicate = predicate;
        this.owner = IsaToken.EXISTS1;
    }

    public TRBoundedExpression(TCExistsExpression owner, TRMultipleBindList bindList, TRExpression predicate)
    {
        super(owner.location);
        this.bindList = bindList;
        this.predicate = predicate;
        this.owner = IsaToken.EXISTS;
    }

    public TRBoundedExpression(TCForAllExpression owner, TRMultipleBindList bindList, TRExpression predicate)
    {
        super(owner.location);
        this.bindList = bindList;
        this.predicate = predicate;
        this.owner = IsaToken.FORALL;
    }

    @Override
    public IsaToken isaToken() {
        return owner;
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(isaToken().toString() + " " + 
            bindList.translate() + IsaToken.POINT + " " + predicate.translate());
    }
}
