package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.pog.ProofObligation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRProofObligationExpression extends TRExpression {
    
    public final ProofObligation po;
    public final TRExpression poExpr;
    public final TRType poType;

    /**
     * Creates a proof obligation for the given ProofObligation. It corresponds to the transformation of 
     * the type checked PO string mapped and type checked to a TRExpression and its resulting TRType. 
     * @param po
     * @param poExpr
     * @param poType
     */
    public TRProofObligationExpression(ProofObligation po, TRExpression poExpr, TRType poType)
    {
        super(poExpr.location);
        this.po = po;
        this.poExpr = poExpr;
        this.poType = poType;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.THEOREM;
    }
    
    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        
        return sb.toString();
    }
    
    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseProofObligationExpression(this, arg);
    }
}