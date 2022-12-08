package vdm2isa.tr.statements;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.statements.TCStatement;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

// @JK
// Is it ok that we are fudging it into an expression?
public abstract class TRStatement extends TRExpression {

    TRIsaVDMCommentList comments;

    TCStatement expS;

    public TRStatement(LexLocation location, TRIsaVDMCommentList comments, TCStatement exp, TRType stmttype)
	{
		super(location, null, stmttype);
        this.expS = exp;
        this.comments = comments;
	}

    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) 
    {
        return visitor.caseStatement(this, arg);
    }

    public String oldtranslate(){
        return comments.oldtranslate();// + TRStateDefinition.state.recordType.getInvDef().getParameters().patternContextTranslate(null) + "\n\t";
    }

    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    
    // public TRExpression(LexLocation location, TCExpression exp, TRType exptype)
	// {
	// 	super(location);
    //     this.exp = exp;
    //     this.exptype = exptype;
    //     this.hasWarnedAboutUnknownType = false;
    //     this.hasWarnedAboutNullType = false;
    //     this.exprFVV = new TCFreeVariableExpressionVisitor(new TCGetFreeVariablesVisitorSet());
    //     //this.fvvENV = new EnvTriple(new FlatEnvironment(new TCDefinitionList()), new FlatEnvironment(new TCDefinitionList()), new AtomicBoolean(false)); 
    //     this.fvvENV = new FlatEnvironment(new TCDefinitionList());
	// }

}
