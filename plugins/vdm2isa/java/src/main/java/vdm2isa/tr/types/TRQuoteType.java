package vdm2isa.tr.types;

import java.util.Arrays;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;

import com.fujitsu.vdmj.tc.expressions.TCQuoteLiteralExpression;
import com.fujitsu.vdmj.tc.lex.TCNameList;
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

    private static final Map<String, Set<String>> quoteTypeNames = new TreeMap<String, Set<String>>();

    public TRQuoteType(TCQuoteType vdmType, TRDefinitionList definitions, String value) {
        super(vdmType, definitions);
        this.value = value;
    }

    @Override
    protected void setInferredNamedForType(TCNameToken tn)
    {
        super.setInferredNamedForType(tn);
        String key = String.valueOf(tn);
        if (quoteTypeNames.keySet().contains(key))
        {
            quoteTypeNames.get(key).add(value);
        }
        else
        {
            quoteTypeNames.put(key, new TreeSet<String>(Arrays.asList(value)));
        }
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
