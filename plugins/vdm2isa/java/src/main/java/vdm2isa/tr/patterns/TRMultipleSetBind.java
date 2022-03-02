package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.tc.patterns.TCMultipleSetBind;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.patterns.TCSetBind;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.TRSetRangeExpression;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;

/**
 * VDM set binds represent "x in set S". Depending on the translation context, different outcomes are needed.
 * For typing or parameters context, that is just "x : S"; whereas for comprehension contexts, it depends on
 * whether this bind is for a set or seq comprehenion, in which case certain transformations are needed.
 */
public class TRMultipleSetBind extends TRMultipleBind 
{
    private static final long serialVersionUID = 1L;

    public final TRExpression set;

    // TRSeqComp sets this to true for the case [ x | x in set S ], where S is ordered
    protected boolean seqBind;

    private static TCMultipleSetBind figureOutMultipleBind(TCSetBind tc)
    {
        TCMultipleSetBind result = null;
        if (tc != null)
        {
            TCPatternList plist = new TCPatternList();
            plist.add(tc.pattern);
            result = new TCMultipleSetBind(plist, tc.set);
        }
        return result;
    }

    public TRMultipleSetBind(TCSetBind tc, TRPattern pattern, TRExpression set)
    {
        this(figureOutMultipleBind(tc),
            pattern != null ? pattern.getPatternList() : new TRPatternList(), set);
    }

    public TRMultipleSetBind(TCMultipleSetBind tc, TRPatternList plist, TRExpression set)
    {
        super(tc, plist);
        this.set = set;
    }

    @Override 
    public void setup()
    {
        super.setup();
        // If this set bind is part of a sequence bind or not; to be set by the TRSeqCompExpression
        this.seqBind = false;
        if (this.set == null || !(this.set.getType().ultimateType() instanceof TRSetType))
            report(IsaErrorMessage.VDMSL_INVALID_EXPR_4P, 
                "set bind",
                (this.set == null ? "null" : this.set.getType().getClass().getSimpleName()),
                "1", "expected set type");
        TRNode.setup(set);
    }

    @Override
    public String toString()
    {
        return super.toString() + " " + String.valueOf(plist) + " in set " + String.valueOf(set); 
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.INSET;
    }

    /**
     * To avoid seq set bind warnings about linear orders, we can infer in some cases (and hence avoid the warning).
     * For now, that's for "x in S" where "S = {l..h}" and the set inner type is an adequate basic type. 
     * @return
     */
    public boolean linearOrderedType()
    {
        return (set instanceof TRSetRangeExpression) && getRHSType().isPossibleSetRange();
    }

    /**
     * Set bindings translation in comprehension just needs the name, given the actual bind will be in the 
     * predicate part (see TRSetCompExpression). If this bind is for a sequence comprehension, Isabelle 
     * requires the set to be ordered and to be translated to a sequence. Given VDM enforces set ordering 
     * as well, a call to "sorted_set_as_list" is issued through IsaToken.SETSEQBIND under the right circumstances.
     * Pattern only parameter is for when the bind is used in the generator field, rather than predicate field.  
     */
    @Override
    public String compTranslate(boolean vdmPatternsOnly)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(plist.translate());
        // for seq comprehension with ordered seq bind, we need the extra SETSEQBIND mapping
        // whenever it's not just for the patterns, which should never be the case any how.  
        if (!vdmPatternsOnly && seqBind)
        { 
            // On type checked VDM values the underlying type is ordered; but possibly with an ord_ clause, which might not work for Isabelle 
            String trStr = translate();
            if (!linearOrderedType())
            {
                warning(IsaWarningMessage.ISA_SEQCOMP_LINEAR_TYPEBIND_1P, trStr);
            }
            sb.append(getFormattingSeparator());
            sb.append(IsaToken.SETSEQBIND);
            sb.append(getFormattingSeparator());
            sb.append(IsaToken.parenthesise(set.translate()));
        }
        return sb.toString();
    }
    
    @Override
    public String boundExpressionTranslate(int index, boolean invTr) {
        String rhsStr = getRHS().translate(); 
        return invTr ? 
                IsaToken.parenthesise(plist.get(index).translate() + getFormattingSeparator() + isaToken().toString() + rhsStr)//if invTr issues a inv_SetElems ?
                : rhsStr;
    }

    @Override
    public TRNode getRHS() {
        return set;
    }

    /**
     * Returns the set expression inner values type, e.g. x in set S, 
     * where S = set of T, leads to x : T.
     */
    @Override 
    public TRType getRHSType()
    {
        return ((TRSetType)set.getType()).getInnerType();
    }

    @Override
    public TRMultipleBindKind getMultipleBindKind()
    {
        return TRMultipleBindKind.SET;
    }

    @Override
	public <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMultipleSetBind(this, arg);
	}
}
