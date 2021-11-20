package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.types.TRDataType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeSet;
import vdm2isa.tr.types.TRUnionType;

public class TRCasesExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    private final TRExpression exp;
    private final TRCaseAlternativeList cases;

    public TRCasesExpression(LexLocation location, TRExpression exp, TRCaseAlternativeList cases, TRExpression others, TRType exptype) {
        super(location, exptype);
        this.exp = exp;
        this.cases = cases;
        // add others as a case alternative
        if (others != null)
        {
            if (exp.getType() instanceof TROptionalType)
            {
                report(IsaErrorMessage.ISA_INVALID_OPTION_CASE_1P, exp.getClass().getSimpleName());
            }
            this.cases.add(new TRCaseAlternative(location, TRBasicPattern.underscore(location), others));
        }
        if (this.cases.isEmpty())
        {
            report(IsaErrorMessage.VDMSL_INVALID_CASESEXPR);
        }
    }

    @Override
    protected TRType getBestGuessType()
    {
        TRTypeSet typeSet = cases.getTypes();
        return new TRUnionType(new TCUnionType(location, typeSet.getVDMTypeSet()), new TRDefinitionList(), typeSet);
    }
    
    @Override 
    public String toString()
    {
        return "case " + String.valueOf(exp) + " of " + String.valueOf(cases);
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseCaseExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.CASE;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        TRType eType = exp.getType();
        if (eType.isDataType())
        {
            TRDataType dt = (TRDataType)eType;
            //dt.getDataTypeConstructors().size() == cases.size() 
            sb.append(getFormattingSeparator());
            sb.append(isaToken().toString());
            sb.append(IsaToken.SPACE.toString());
            sb.append(exp.translate());
            sb.append(IsaToken.SPACE.toString());
            sb.append(IsaToken.OF.toString());
            sb.append(IsaToken.SPACE.toString());
            sb.append(getFormattingSeparator());
            sb.append(cases.translate());    
        }
        else
        {
            warning(IsaWarningMessage.ISA_CASES_PATTERN_LIMITATION);
            sb.append(IsaToken.comment(IsaWarningMessage.ISA_CASES_PATTERN_LIMITATION.message));
        }        
        return IsaToken.parenthesise(sb.toString());
    }
    
}
