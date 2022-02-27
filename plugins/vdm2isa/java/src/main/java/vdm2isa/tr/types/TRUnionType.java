package vdm2isa.tr.types;


import java.util.Iterator;
import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCProductType;
import com.fujitsu.vdmj.tc.types.TCUnionType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRUnionType extends TRType implements TRDataType {
    private static final long serialVersionUID = 1L;
   
    private TRTypeSet types; 
    private boolean expanded;
	private boolean enumerated; 
    
    public TRUnionType(TCUnionType vdmType, TRDefinitionList definitions, TRTypeSet types)
	{
		super(vdmType, definitions);
		this.types = types;
		this.expanded = false;
		this.enumerated = false;
	}

	@Override
	public void setup()
	{
		super.setup();
		setFormattingSeparator("\n\t\t ");
		setSemanticSeparator(IsaToken.SPACE.toString() + isaToken().toString() + IsaToken.SPACE.toString());
		setInvTranslateSeparator(IsaToken.SPACE.toString() + IsaToken.AND.toString() + IsaToken.SPACE.toString());
		assert types != null;
        //TODO not sure whether this is needed, given the TRTypeSet passed will already have been 
        //      expanded within its TCUnionType owner? This also highlights that I will indeed need
        //      the TRDefinitionList wihtin all types, which caused trouble earlier!!!! 
		expand();
		TRNode.setup(types);
		this.types.setPrefixed(true);
		types.setFormattingSeparator(getFormattingSeparator());
		this.enumerated = figureOutEnumeratedUnion();
		//System.out.println(toString());
	}

	private boolean figureOutEnumeratedUnion()
	{
		boolean result = true;
		Iterator<TRType> titer = types.iterator();
		while (titer.hasNext() && result)
		{
			TRType t = titer.next();
			result = t instanceof TRQuoteType;
		}
		return result;
	}

	@Override 
	public String toString()
	{
		return "Union " + 
			"\n\t tset = " + String.valueOf(types) + 
			"\n\t loc  = " + String.valueOf(getLocation());
	}

	@Override
    protected void setInferredNamedForType(TCNameToken tn)
	{
        super.setInferredNamedForType(tn);
		types.setInferredNamedForType(tn);
	}

	@Override
    public boolean setAtTopLevelDefinition(boolean b)
    {
        // inner type at super = to type set
        return super.setAtTopLevelDefinition(b);
		//this.types.setAtTopLevelDefinition(b);
    }	

	@Override
    public TRType copy(boolean atTLD)
    {
		TRType result = this;
        if (types == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "union type", "null types set?");
        }
        else
        {
            result = new TRUnionType((TCUnionType)getVDMType(), definitions, types.copy(true));
			TRNode.setup(result);
            result.setAtTopLevelDefinition(atTLD);
        }
        return result;
    }

	@Override
	public TRTypeSet getDataTypeConstructors()
	{
		return types;
	}

	@Override
	public boolean isEnumerated()
	{
		return this.enumerated;
	}

    private void expand()
	{
		if (expanded) return;
		TRTypeSet exptypes = new TRTypeSet();

		for (TRType t: types)
		{
    		if (t instanceof TRUnionType)
    		{
    			TRUnionType ut = (TRUnionType)t;
  				ut.expand();
   				exptypes.addAll(ut.types);
    		}
    		else
    		{
    			exptypes.add(t);
    		}
		}

		types = exptypes;
		expanded = true;
		definitions = new TRDefinitionList();

		for (TRType t: types)
		{
			if (t.definitions != null)
			{
				definitions.addAll(t.definitions);
			}
		}
		TRNode.setup(types, definitions);
	}

	@Override
	public boolean isUnion()
	{
		return true;
	}
	
	@Override
	public boolean isDataType()
	{
		return true;
	}

	@Override
	public boolean isProductType()
	{
		assert getVDMType() instanceof TCUnionType;
		return getVDMType().isProduct(location);
	}

	@Override 
	public TRProductType getProduct()
	{
		TRProductType result = null;
		if (isProductType())
		{
			TCProductType p = getVDMType().getProduct();
			ClassMapper mapper = ClassMapper.getInstance(TRNode.MAPPINGS);
			try 
			{
				result = (TRProductType)mapper.convert(p);
			}
			catch (Exception e)
			{
				result = null;
				report(IsaErrorMessage.PLUGIN_MISSING_MAPPING_ERROR_3P, location, 
					p.getClass().getSimpleName(), 
					this.getClass().getSimpleName(),
					e.toString());
			}
		}
		return result;
	}

    @Override
    public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg) {
        return visitor.caseUnionType(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.BAR; 
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
		sb.append(types.translate());
		return sb.toString();
    }

	@Override 
    protected String getInvTypeString()
    {
		report(IsaErrorMessage.ISA_INVALID_INVTR_2P, getClass().getSimpleName(), "union type doesn't have inv type string");
        return "";
    }

	@Override
	public Set<String> getDefLemmas()
	{
		return types.getDefLemmas();
	}

	@Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
		// at this stage, the type union name must be known, given it's already been declared. 
		// if not known, getName() will issue the error.
		String tname = getName();
		if (varName != null)
		{
			// enum types it's just inv_True
			if (enumerated)
			{
				assert !types.isEmpty();
				TRType t = types.iterator().next();
				sb.append(t.invTranslate(varName));
			}
			else
			{
				//TODO construct a TRCasesExpression? Nah...
				sb.append(IsaToken.CASE.toString());
				sb.append(IsaToken.SPACE.toString());
				sb.append(varName);
				sb.append(IsaToken.SPACE.toString());
				sb.append(IsaToken.OF.toString());
				sb.append(getFormattingSeparator());
				sb.append(types.invTranslate(varName));
			}
		}
		else if (tname != null && !tname.isEmpty())
		{
			sb.append(IsaToken.INV.toString());
			sb.append(tname);
			sb.append(IsaToken.SPACE.toString());
		}
		else
		{
			// this will generate an error that the type needs a name! take the hint :-)
			// this will happen for all ill-formed unions, e.g. set of (nat | int), which should be set of U for U = nat | int
			report(IsaErrorMessage.ISA_INVALID_UNIONTYPE_1P, "inner types");
		}
		return IsaToken.parenthesise(sb.toString());		
    }

	@Override
	public void checkForUnionTypes() {
        report(IsaErrorMessage.ISA_INVALID_UNIONTYPE_1P, "union type");   
	}

	/**
	 * Singleton typeset returns that as the type
	 * @param location
	 * @param types
	 * @return
	 */
	public static final TRType newUnionType(LexLocation location, TRTypeSet types)
	{
		return TRUnionType.newUnionType(location, new TRDefinitionList(), types);
	}

	public static final TRType newUnionType(LexLocation location, TRDefinitionList definitions, TRTypeSet types)
	{
		TRType union = types.colapses();
		TRType result = union != null ? union.copy(union.atTopLevelDefinition()) : new TRUnionType(new TCUnionType(location, types.getVDMTypeSet()), definitions, types);
		TRNode.setup(result);
		return result;
	}
}
