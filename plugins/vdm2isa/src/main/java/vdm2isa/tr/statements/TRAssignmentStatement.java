package vdm2isa.tr.statements;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.statements.TCAssignmentStatement;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.definitions.TRStateDefinition;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.patterns.TRRecordPattern;
import vdm2isa.tr.types.TRType;


public class TRAssignmentStatement extends TRStatement {

    public TRExpression exp;
    public TRStateDesignator target;
    public TRType targetType;
	public TRType expType;

    public TRAssignmentStatement(LexLocation location, TRIsaVDMCommentList comments, TCAssignmentStatement as, TRType stmttype, TRStateDesignator target, TRExpression exp, TRType targetType, TRType expType)
	{
		super(location, comments, as, stmttype);
        this.exp = exp;
        this.target = target;
        this.expType = expType;
        this.targetType = targetType;
	}

    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) 
    {
        return visitor.caseAssignmentStatement(this, arg);
    }

    public String oldtranslate()
    {
        TRPatternListList patternContextProjection = TRPatternListList.newPatternListList(TRRecordPattern.RecordPatternGenerator(TRStateDefinition.state.recordType,TRStateDefinition.state.recordType.location));
        // Check Parattern context is the correct dummy?
        String StateParamName = "dummy0";

        StringBuilder sb = new StringBuilder();
        sb.append(super.oldtranslate());
        sb.append(IsaToken.LET.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(StateParamName);
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.EQUALS.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(StateParamName);
        sb.append(IsaToken.LRECORD.toString());
        sb.append(target.oldtranslate());
        sb.append(IsaToken.RECORD_MODIFIER.toString() );
        sb.append(exp.oldtranslate());
        sb.append(IsaToken.RRECORD.toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.IN.toString());
        sb.append(getFormattingSeparator());
        sb.append(patternContextProjection.patternContextTranslate(null));

        return sb.toString();


        // return super.translate() +  IsaToken.LET.toString() + IsaToken.SPACE.toString() + 
        // // TRStateDefinition.state.name.toString() + 
        // StateParamName +
        // IsaToken.SPACE.toString() + IsaToken.EQUALS.toString() + IsaToken.SPACE.toString() +
        // // TRStateDefinition.state.name.toString() + // Got to be same name as state param
        // StateParamName +
        // IsaToken.LPAREN.toString() + target.translate() + IsaToken.RECORD_MODIFIER.toString() + exp.translate() + IsaToken.RPAREN.toString() +
        // IsaToken.SPACE.toString() + IsaToken.IN.toString() + getFormattingSeparator() +
        // patternContextProjection.patternContextTranslate(null);
    }

    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    
}
