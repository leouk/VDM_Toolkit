package vdm2isa.tr.definitions;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaCommentList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;

public class TRProofScriptDefinition extends TRDefinition {

	private static final long serialVersionUID = 1L;

    public TRProofScriptDefinition(TRIsaCommentList comments, TRExpression poExpr)
    {
        super(poExpr.location, comments, null);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.PROOF;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.comment("Not yet handling proof scripts fully!"));
        return sb.toString();
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.caseProofScriptDefinition(this, arg);
    }
}
