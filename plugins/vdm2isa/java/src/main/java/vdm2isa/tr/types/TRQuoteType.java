package vdm2isa.tr.types;

import java.util.Arrays;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCQuoteType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRQuoteType extends TRType
{
	private static final long serialVersionUID = 1L;
    protected final String value;

    // allQuoteValues = dunion quoteTypeNames.values()
    // keep the set to avoid multiple recalculations
    private static final Set<String> allQuoteValues = new TreeSet<String>();
    private static final Map<String, Set<String>> quoteTypeNames = new TreeMap<String, Set<String>>();

    public TRQuoteType(TCQuoteType vdmType, TRDefinitionList definitions, String value) {
        super(vdmType, definitions);
        this.value = value;
    }

    public static final void reset()
    {
        quoteTypeNames.clear();
        allQuoteValues.clear();
    }

    @Override
    protected void setInferredNamedForType(TCNameToken tn)
    {
        super.setInferredNamedForType(tn);
        String key = String.valueOf(tn);
        // this is called a couple of times: 
        //      * one at TRTypeDefinition figuring it out 
        //       * one at calculated definitions within TRType.definitions = TRModule.definitions!  
        // no duplicate quotes across type keys, as this generates non-comparable enumerations
        // T1 = <A> | <B>; T2 = int | <A>; in VDM <A>:T1 = <A>:T2; in Isabelle they can't/aren't! 
        if (quoteTypeNames.keySet().contains(key))
        {
            // if (allQuoteValues.contains(value)) // quoteTypeNames.get(key).contains(value))
            // {
            //      report(IsaErrorMessage.ISA_INVALID_QUOTETYPE_2P, value, key);
            // }
            // else
            {
                quoteTypeNames.get(key).add(value);
            }
        }
        else
        {
            if (allQuoteValues.contains(value)) // quoteTypeNames.get(key).contains(value))
            {
                report(IsaErrorMessage.ISA_INVALID_QUOTETYPE_3P, value, key, TRQuoteType.findPreviouslyDeclaredTypeFor(value, key));
            }
            else   
            {
                quoteTypeNames.put(key, new TreeSet<String>(Arrays.asList(value)));
            }
        }
        allQuoteValues.add(value);
    }

    private static String findPreviouslyDeclaredTypeFor(String v, String ignoreThisKey) 
    {
        assert allQuoteValues.contains(v) && !quoteTypeNames.keySet().contains(ignoreThisKey);
        String result = null;
        for (Map.Entry<String, Set<String>> entry : quoteTypeNames.entrySet())
        {
            //if (!entry.getKey().equals(ignoreThisKey))
            //{
                if (entry.getValue().contains(v))
                {
                    result = entry.getKey();
                }
            //}
        }
        return result;
    }

    private void figureOutTypeName()
    {
        if (getInferredNamedForType() == null)
        {
            for(Map.Entry<String, Set<String>> entry : quoteTypeNames.entrySet())
            {
                if (entry.getValue().contains(value))
                {
                    // force the name for this quote literal type; no need to update quoteTypeNames as it's the info source
                    super.setInferredNamedForType(new TCNameToken(location, location.module, entry.getKey()));
                }
            }
        }
    }
    
    @Override
    public TRType copy(boolean atTLD)
    {
        TRType result = new TRQuoteType((TCQuoteType)getVDMType(), definitions, value);
        TRNode.setup(result);
        result.setAtTopLevelDefinition(atTLD);
        return result;
    }

    // Do not implement this: the type name *must* come from inference through declared quote literal as a named type! 
    // @Override 
    // public String getName()
    // {
    //     return value;
    // }
    
    @Override
    public String translate() 
    {
       return TRTypeSet.prefixTranslate(value, true, getInferredNamedForType());
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.VDMQUOTE;
    }
    
    @Override
	public String invTranslate(String varName) {
		// there is no "inv_True" in the translation for completeness. 
		String typeStr = IsaToken.INV.toString() + IsaToken.TRUE.toString();
        return IsaToken.parenthesise(typeStr + (varName == null ? "" : IsaToken.SPACE.toString() + varName));
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseQuoteType(this, arg);
	}

    /**
     *  Repeated quoted types across different types won't be allowed either (i.e. quote type must be part of)
     */
    @Override
    public void checkForUnionTypes() {
        report(IsaErrorMessage.ISA_INVALID_UNIONTYPE_1P, "quote type");   
    }

    /**
     * Quote literals have quote type, which has the quote (i.e. literal = type). 
     * But we also need the fully qualified type name for the literal?s
     * @param exp
     * @param exptype
     * @return
     */
    public static String quoteLiteral(String exp, TRQuoteType qtype) 
    {
        assert qtype.value.equals(String.valueOf(exp));  
        qtype.figureOutTypeName();
        return qtype.translate();
    }
}
