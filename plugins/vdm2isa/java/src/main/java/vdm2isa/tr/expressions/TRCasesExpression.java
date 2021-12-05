package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCCasesExpression;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeSet;
import vdm2isa.tr.types.TRUnionType;

public class TRCasesExpression extends TRExpression {

	private static final long serialVersionUID = 1L;
    public final TRExpression exp;
    public final TRCaseAlternativeList cases;
    public final TRExpression others;

    public TRCasesExpression(LexLocation location, TCCasesExpression tc, TRExpression exp, TRCaseAlternativeList cases, TRExpression others, TRType exptype) {
        super(location, tc, exptype);
        this.exp = exp;
        this.cases = cases;
        this.others = others;
    }

    @Override
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t\t ");
        assert exp != null;
        // add others as a case alternative if exp is not boolean, given cases true is treated differently
        if (others != null && !exp.getType().isBooleanType())
        {
            if (exp.getType() instanceof TROptionalType)
            {
                report(IsaErrorMessage.ISA_INVALID_OPTION_CASE_1P, exp.getClass().getSimpleName());
            }
            //TODO: will this "null" be a problem? 
            this.cases.add(new TRCaseAlternative(location, null, TRBasicPattern.underscore(location), others));
        }
        if (this.cases.isEmpty())
        {
            report(IsaErrorMessage.VDMSL_INVALID_CASESEXPR);
        }
        TRNode.setup(exp, cases);
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
        return visitor.caseCasesExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.CASE;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        TRType eType = exp.getType();
        sb.append(getFormattingSeparator());
        if (eType.isBooleanType())
        {
            // for boolean cases, every case *must* be is_expr, so create a chain of conjoined implications, ignoring exp
            sb.append(IsaToken.comment("`cases true` expressions are translated as an and-chain of implications or others", getFormattingSeparator()));
            boolean old = cases.setCasesTrueAlternative(true);
            sb.append(cases.translate());
            cases.setCasesTrueAlternative(old);
            if (others != null)
            {
                sb.append (getFormattingSeparator());
                sb.append(IsaToken.SPACE.toString() + IsaToken.OR.toString() + IsaToken.SPACE.toString());
                sb.append(others.translate());
            }
        }
        else if (eType.isDataType())
        {
            //TRDataType dt = (TRDataType)eType;
            //assert dt.getDataTypeConstructors().size() == cases.size(); 
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
            String typeStr = eType.translate();
            report(IsaErrorMessage.ISA_CASES_PATTERN_LIMITATION_1P, typeStr);
            sb.append(IsaToken.comment(IsaErrorMessage.ISA_CASES_PATTERN_LIMITATION_1P.format(typeStr)));
        }        
        return IsaToken.parenthesise(sb.toString());
    }
    
}
