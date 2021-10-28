package vdm2isa.tr.patterns;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.TRExpression;

/**
 * VDM set binds represent "x in set S". Depending on the translation context, different outcomes are needed.
 * For typing or parameters context, that is just "x : S"; whereas for comprehension contexts, it depends on
 * whether this bind is for a set or seq comprehenion, in which case certain transformations are needed.
 */
public class TRMultipleSetBind extends TRMultipleBind 
{
    private static final long serialVersionUID = 1L;

    private final TRExpression set;
    public boolean seqBind;

    public TRMultipleSetBind(TRPattern pattern, TRExpression set)
    {
        this(pattern.getPatternList(), set);
    }

    public TRMultipleSetBind(TRPatternList plist, TRExpression set)
    {
        super(plist);
        this.set = set;
        // If this set bind is part of a sequence bind or not; to be set by the TRSeqCompExpression
        this.seqBind = false;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.INSET;
    }

    /**
     * Set bindings translation in comprehension just needs the name, given the actual bind will be in the 
     * predicate part (see TRSetCompExpression). If this bind is for a sequence comprehension, Isabelle 
     * requires the set to be ordered and to be translated to a sequence. Given VDM enforces set ordering 
     * as well, a call to "sorted_set_as_list" is issued through IsaToken.SETSEQBIND under the right circumstances.
     * Pattern only parameter is for when the bind is used in the generator field, rather than predicate field.  
     */
    @Override
    public String compTranslate(boolean patternsOnly)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(plist.translate());
        //System.out.println("Hitting with po = " + patternsOnly + " " + sb.toString());
        // for seq comprehension with ordered seq bind, we need the extra SETSEQBIND mapping
        // whenever it's not just for the patterns, which should never be the case any how.  
        if (!patternsOnly && seqBind)
        { 
            String setbindProblem = "Translator does not have sequence bind type info. If VDM (ordered) set bind used, need to add \"\" to seq expression";
            warning(11111, setbindProblem);
            sb.append(IsaToken.SETSEQBIND);
            sb.append(" ");
            sb.append(IsaToken.parenthesise(set.translate()));
        }
        return sb.toString();
    }
    
    @Override
    public String translate() {
        return plist.translate() + " " + isaToken().toString() + " " + set.translate();
    }
}
