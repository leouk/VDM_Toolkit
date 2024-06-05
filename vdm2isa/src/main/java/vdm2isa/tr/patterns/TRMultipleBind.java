package vdm2isa.tr.patterns;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.patterns.TCBind;
import com.fujitsu.vdmj.tc.patterns.TCMultipleBind;
import com.fujitsu.vdmj.tc.patterns.TCPattern;
import com.fujitsu.vdmj.tc.patterns.TCSeqBind;
import com.fujitsu.vdmj.tc.patterns.TCSetBind;
import com.fujitsu.vdmj.tc.patterns.TCTypeBind;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRDefinitionSet;
import vdm2isa.tr.definitions.TRLocalDefinition;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.types.TRType;

public abstract class TRMultipleBind extends TRNode implements TRPatternContext
{
    private static final long serialVersionUID = 1L;

    public final TRPatternList plist;
    private boolean parenthesise;  

    /**
     * PO binds have to be treated carefully, as the implicit checks for their type invariants have to be taken into account.
     * Moreover, depending on the bind and on the bounded expression it belongs to, various adjustments are needed. 
     * e.g., forall x, y in set S & P =>
     */
    public boolean poBind;

    private final TCMultipleBind vdmBind;

    public TRMultipleBind(TCMultipleBind b, TRPatternList plist)
    {
        super(plist != null && !plist.isEmpty() ? plist.get(0).location : LexLocation.ANY);
        this.vdmBind = b;
        this.plist = plist;
        this.poBind = false;
        this.parenthesise = true;
    }

    public TCMultipleBind getVDMMultipleBind()
    {
        return vdmBind; 
    }

    public TCBind getVDMBind()
    {
        TCBind result = null;
        if (plist.size() == 1)
        {
            TCPattern p = plist.get(0).getVDMPattern();
            switch (getMultipleBindKind())
            {
                case SET:
                    TRExpression set = (TRExpression)getRHS();
                    result = new TCSetBind(p, set.getVDMExpr());
                    break;
                case SEQ:
                    TRExpression seq = (TRExpression)getRHS();
                    result = new TCSeqBind(p, seq.getVDMExpr());
                    break;
                case TYPE: 
                    TRType type = (TRType)getRHS();
                    result = new TCTypeBind(p, type.getVDMType());
                    break;
            }
        }
        return result;
    }

    @Override 
    public void setup()
    {
        super.setup();
        // multiple type binds are space (not comma) separated
        setSemanticSeparator(IsaToken.SPACE.toString());
        setFormattingSeparator(IsaToken.SPACE.toString());
        setInvTranslateSeparator(getFormattingSeparator() + IsaToken.AND.toString() + getFormattingSeparator());
        TRNode.setup(plist);
        this.plist.setInvTranslateSeparator(getInvTranslateSeparator());
    }

    public boolean getParenthesise()
    {
        return parenthesise;
    }

    public final boolean setParenthesise(boolean b)
    {
        boolean old = parenthesise;
        parenthesise = b;
        return old;
    }

    public TRMultipleBindList getMultipleBindList()
    {
        TRMultipleBindList result = new TRMultipleBindList();
        result.add(this);
        TRNode.setup(result);
        return result;
    }

    /**
     * Binds that allow translation within in comprehension expressions. 
     * @param vdmPatternsOnly whether to consider binding type/expr (if availale) 
     * or VDM patterns only. This is important for the existential set comprehension case in Isabelle 
     * (i.e. all comprehension where expr is not a pattern, e.g., { x+x | bind & pred }).
     */
    public abstract String compTranslate(boolean vdmPatternsOnly);

    /**
     * Binds within certain expressions require a combination of translation + invariant translation. 
     * For example, "x:nat" requires also an inv_VDMNat x. Moreover, for multiple pattern binds, we 
     * need individual translations per pattern associated with the bound expression, instead of all in one
     * (e.g. makes sure that "x, y in set S" becomes "x : S" "y : S" with the chosen semantic separator)!  
     * @param owner
     * @return
     */
    public final String translate()
    {
        StringBuilder sb = new StringBuilder();
        if (plist.isEmpty())
        {   
            // is this even possible as typechecked VDM AST? 
            report(IsaErrorMessage.VDMSL_INVALID_PATTERN);
        }
        else
		{
            sb.append(patternTranslate(0, false));
    		for (int i = 1; i < plist.size(); i++)
			{
				sb.append(getSemanticSeparator());
				sb.append(getFormattingSeparator());
				sb.append(patternTranslate(i, false));
			}
		}
        return sb.toString();
    }

    /**
     * Multiple type binds invariant translate have to issue the inv_T check where needed
     * e.g., "forall x:T . P(x)" => "! (x::T) . inv_T x /\ P(x)"
     */
    @Override
    public String invTranslate()
    {
        StringBuilder sb = new StringBuilder();
		if (plist.isEmpty())
        {   
            report(IsaErrorMessage.VDMSL_INVALID_PATTERN);
        }
        else
        {
            sb.append(patternTranslate(0, true));
    		for (int i = 1; i < plist.size(); i++)
			{
				sb.append(getInvTranslateSeparator());
				sb.append(getFormattingSeparator());
				sb.append(patternTranslate(i, true));
			}
		}
		return sb.toString();
    }

    /**
     * Translate given pattern index within the bind; each pattern gets a translate call to allow for more complex pattern translation overriding chances
     * For example, quantified/bound expressions must issue different quantifier tokens per bind pattern, rather than per bind! 
     * e.g. "forall x, y in set S & P" => "! x : S . ! y : S . P"
     * @param index
     * @return
     */
    public String patternTranslate(int index, boolean invTr) {
        assert index >= 0 && index < plist.size();
        StringBuilder sb = new StringBuilder();
        if (invTr)
        {
            //TODO might have to add invTranslate (as just translate?) for TRPattern
            //sb.append(plist.get(index).invTranslate());
            // the bound expression will handle it all
        }
        else
        {
            sb.append(plist.get(index).translate());
            sb.append(getFormattingSeparator());
            sb.append(isaToken().toString());
            sb.append(getFormattingSeparator());
        }
        sb.append(boundExpressionTranslate(index, invTr));
        // for bounded expressions binds, parenthesise must be false 
        return parenthesise ? IsaToken.parenthesise(sb.toString()) : sb.toString();
    }

    /**
     * [binds] [token] [expression], e.g. x in set S; this returns S.translate
     * @param index which bind pattern index it is
     * @param invTr determines whether this is a translate or an invariant translate call
     * @return
     */
    protected abstract String boundExpressionTranslate(int index, boolean invTr);

    /**
     * RHS can be a TRExpression (for set/seq) of TRType (for type) binds
     * @return
     */
    public abstract TRNode getRHS();

    /**
     * RHS type is either the binding declared type (for type binds), or the
     * inner set/seq type for set/seq binds  
     * @return
     */
    public abstract TRType getRHSType();

    /**
     * This is akin to an "instanceof" test, but would be neater in switch statements. Derived classes know what kind they are.
     * This will also be useful for #TMultipleBindList.figureBindsOut()
     * @return
     */
    public abstract TRMultipleBindKind getMultipleBindKind();

	public abstract <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg);

    @Override
    public boolean needsPatternContext() {
        return plist.needsPatternContext();
    }

    @Override
    public String patternContextTranslate(String varName)
    {
        return plist.patternContextTranslate(varName);
    }

    /**
     * For every pattern in the multiple bind, build a TRTypeBindList, which is 
     * used in lambda expression bindings. That is, for set/seq bindings, use the
     * inner type, whereas for type bindings, use the type directly. See getRHSType(). 
     * @return
     */
    public TRTypeBindList getTypeBindList()
    {
        // there can't be duplication in the named binds, so a list is fine.
        TRTypeBindList result = new TRTypeBindList();
        for(TRPattern p : this.plist)
        {
            result.add(TRMultipleTypeBind.newMultipleTypeBind(p, getRHSType()));
        }
        TRNode.setup(result);
        return result;
    }

    public TRDefinitionList getDefinitions()
    {
        TRDefinitionSet result = new TRDefinitionSet();
        for(TRPattern p : this.plist)
        {
            LexLocation loc = p.getLocation();
            TCNameToken name = IsaToken.newNameToken(loc, loc.module, p.patternTranslate());
            TRLocalDefinition localdef = TRLocalDefinition.newLocalDefinition(location, name, getRHSType());
            result.add(localdef);
        }
        TRDefinitionSet.setup(result);
        return result.asList();
    }
}
