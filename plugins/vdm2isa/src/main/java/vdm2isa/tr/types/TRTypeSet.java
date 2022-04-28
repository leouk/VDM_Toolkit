package vdm2isa.tr.types;

import java.util.TreeSet;
import java.util.Iterator;
import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeSet;
import com.fujitsu.vdmj.util.Utils;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaSeparator;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.MappableNode;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRUnionContext;

/**
 * This is an adjusted copy of TCTypeSet. Not sure if this is right.
 */
//TODO Implement Mappable (instead of MappableNode, for now), given you don't call translate() etc on it? 
@SuppressWarnings("serial")
public class TRTypeSet extends TreeSet<TRType> implements MappableNode
{
	private static final long serialVersionUID = 1L;

	private String separator;
	private String formattingSeparator;
	private String invTranslateSeparator;
	private boolean prefixed;
	private boolean alreadySetup;
	private TCNameToken typename;

	public TRTypeSet()
	{
		super();
		prefixed = false;
		typename = null;
		alreadySetup = false;
	}

    public TRTypeSet(TCTypeSet from) throws Exception
	{
		this();
		ClassMapper mapper = ClassMapper.getInstance(TRNode.MAPPINGS);
		
		for (TCType type: from)
		{
			add((TRType)mapper.convert(type));
		}
	}

	public TRTypeSet(TRTypeList typs)
	{
		this();
		addAll(typs);
	}
	
	public TRTypeSet(TRType... typs)
	{
		this();
		if (typs != null)
		{
			for(TRType t : typs)
			{
				if (t != null)
					add(t);
			}
		}
	}

	@Override
	public void setup()
	{
		setFormattingSeparator("\n\t");
		setSemanticSeparator(IsaToken.SPACE.toString() + IsaToken.BAR.toString() + IsaToken.SPACE.toString());
		setInvTranslateSeparator(IsaToken.SPACE.toString() + IsaToken.BAR.toString() + IsaToken.SPACE.toString());
		for(TRType t : this)
		{
			if (t != null && !t.setupDone())
				t.setup();
		}
		alreadySetup = true;
	}

	@Override
	public final boolean setupDone()
	{
		return this.alreadySetup;
	}

	@Override
	public IsaToken isaToken()
	{
		return IsaToken.EOF;
	}

	/**
	 * Return the type of this type set if it collapses to a single type (i.e. singleton union). Null otherwise 
	 * @return
	 */
	public TRType colapses()
	{
		TRType result = null; 
		if (this.size() == 1)
		{
			assert this.iterator().hasNext();
			result = this.iterator().next();
		}
		return result;
	}

	protected void setPrefixed(boolean b)
	{
		prefixed = b;
	}

    public void setAtTopLevelDefinition(boolean b, boolean deep)
    {
        for(TRType t : this)
		{
			t.setAtTopLevelDefinition(b, deep);
		}
    }	

	public TRTypeSet copy(boolean atTLD)
	{
		TRTypeSet result = new TRTypeSet();
		for(TRType t : this)
		{
			result.add(t.copy(atTLD));
		}
		TRNode.setup(result);
		return result;
	}

	/**
	 * The outer type name this type list belongs to
	 * @param tn
	 */
	protected void setInferredNamedForType(TCNameToken tn)
	{
		typename = tn;
		for (TRType t : this)
		{
			if (t instanceof TRQuoteType)
			{
				t.setInferredNamedForType(tn);
			}
		}
	}

	public String getName()
	{
		return typename != null ? typename.toString() : null;
	}

	@Override
	public boolean add(TRType t)
	{
		if (t instanceof TRSeqType)
		{
			// If we add a TRSeq1Type/TRSeqType, and there is already a TRSeqType in the set
			// we ignore the TRSeq1Type.
			
			TRSeqType s1t = (TRSeqType)t;
			TRSeqType st = TRSeqType.newSeqType(s1t.getLocation(), s1t.getInnerType(), s1t.seq1);
			if (contains(st))
			{
				return false;	// Was already there
			}
		}
		else if (t instanceof TRSetType)
		{
			// If we add a TRSet1Type, and there is already a TRSetType in the set
			// we ignore the TRSet1Type.
			
			TRSetType s1t = (TRSetType)t;
			TRSetType st = TRSetType.newSetType(s1t.getLocation(), s1t.getInnerType(), s1t.set1);
			if (contains(st))
			{
				return false;	// Was already there
			}
		}
        //TODO this needs further investigation 
		else if (t instanceof TRBasicType && ((TRBasicType)t).isNumericType())
		{
			for (TRType x : this)
			{
				if (x.isNumericType())
				{
					// if (x.getVDMType().getNumeric().getWeight() < t.getVDMType().getNumeric().getWeight())
					// {
					// 	remove(x);
					// 	break;
					// }
					//else
					if (x.compareTo(t) == 0)
					{
						return false;	// Was already there
					}
				}
			}
		}
		else if (t instanceof TROptionalType)
		{
			TROptionalType opt = (TROptionalType)t;
			
			if (!opt.getVDMType().isUnknown(opt.getVDMType().location) && contains(opt.getInnerType()))
			{
				remove(opt.getInnerType());	// Because T | [T] = [T]
			}
		}
		else if (t instanceof TRTokenType)
		{
			TRTokenType tt = (TRTokenType)t;
			for (TRType x: this)
			{
				if (x instanceof TRTokenType)
				{
					TRTokenType xt = (TRTokenType)x;
					xt.getArgTypes().addAll(tt.getArgTypes());
					return false;	// Was already there
				}
			}
		}
		return super.add(t);
	}

	@Override
	public String toString()
	{
		return Utils.setToString(this, IsaToken.COMMA.toString());
	}

	public TRType getType(LexLocation location)
	{
		// If there are any Optional(Unknowns) these are the result of
		// nil values, which set the overall type as optional. Other
		// optional types stay.
		boolean optional = false;
		assert this.size() > 0 : "Getting type of empty TypeSet";
		TRType result = iterator().next();
		if (this.size() > 1)
		{
			TCTypeSet typeSet = new TCTypeSet();
			for(TRType t : this)
			{
				typeSet.add(t.getVDMType());
			}
			result = TRUnionType.newUnionType(location, result.definitions, this);
		}
		if (optional)
		{
			result = TROptionalType.newOptionalType(result);
		}
		return result;
	}

	public TCTypeSet getVDMTypeSet()
	{
		TCTypeSet result = new TCTypeSet();
		for(TRType t : this)
		{
			result.add(t.getVDMType());
		}
		return result;
	}

	public TRTypeList getComposeTypes()
	{
		TRTypeList result = new TRTypeList();
		for (TRType type: this)
		{
			result.addAll(type.getComposeTypes());
		}
		TRNode.setup(result);
		return result;
	}

	@Override
	public String getSemanticSeparator()
	{
		return separator;
	}

	@Override
	public String setSemanticSeparator(String sep)
	{
		String result = getSemanticSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.SEMANTIC))
		{
			separator = sep;
			// for type sets, this doesn't quite work because the inner parts have to be different (e.g. "|" versus " ")! 
			// for (TRType n : this)
			// {
			// 	n.setSemanticSeparator(sep);
			// }
		}
		return result;
	}

	@Override
	public String getFormattingSeparator()
	{
		return formattingSeparator;
	}

	@Override
	public String setFormattingSeparator(String sep)
	{
		String old = getFormattingSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.FORMATING))
		{
			formattingSeparator = sep;
			for (TRType n : this)
			{
				n.setFormattingSeparator(sep);
			}
		}
		return old;
	}

	@Override
	public String getInvTranslateSeparator()
	{
		return invTranslateSeparator;
	}

	@Override
	public String setInvTranslateSeparator(String sep)
	{
		String old = getInvTranslateSeparator();
		if (IsaTemplates.checkSeparator(getLocation(), sep, IsaSeparator.SEMANTIC))
		{
			invTranslateSeparator = sep;
			// for (TRType n : this)
			// {
			// 	n.setInvTranslateSeparator(sep);
			// }
		}	
		return old;
	}

	@Override
	public LexLocation getLocation()
	{
		return isEmpty() ? LexLocation.ANY : iterator().next().getLocation();
	}

	public static final String prefixTranslate(String typeStr, boolean prefixed, String namePrefix)
	{
		StringBuilder sb = new StringBuilder();
		if (prefixed)
		{
			// create the constant constructors for the Isabelle data type as
			// U_T for every type T in the union, where spaces are replaced by underscores in T
			// ex.  Union = nat | set of int | seq of real 
			//		=isa> 
			//		datatype Union = U_nat "VDMNat" | U_set_of_int "VDMInt VDMSet" | U_seq_of_real "VDMReal VDMSeq" 
			//
			// Constructor names won't be unique across union types, but will within fully qualified union types, so fine for now.
			//
			// Because certain VDM unions are absorbed (E.g. U1 = nat | int will only have int; U2 = int | nat | nat1 will only have int)
			// we also need the fully qualified type nname, as ince U1.U_VDMInt versus U2.U_VDMInt!
			if (namePrefix == null)
			{
				// do nothing; this is a type declaration/translate time.
			}
			else if (namePrefix.isEmpty())
			{
				//TODO ignore, this will be reported elsewhere? yes
				//report(IsaErrorMessage.ISA_INVALID_UNIONTYPE_1P, t.getName());
			}
			else
			{
				sb.append(namePrefix);
				sb.append(IsaToken.POINT.toString());
			}
			sb.append(IsaToken.VDMUNION.toString());
			sb.append(IsaToken.UNDERSCORE.toString());
			sb.append(typeStr.replace(' ', '_'));
			sb.append(IsaToken.SPACE.toString());
		}
		return sb.toString();
	}

	public String prefixTranslate(TRType t)
	{
		assert this.contains(t);
		return t instanceof TRQuoteType ? 
			t.translate() : 
			TRTypeSet.prefixTranslate(t.translate().trim(), prefixed, getName());
	}

	protected String typeTranslate(TRType t)
	{
		assert this.contains(t);
		StringBuilder sb = new StringBuilder();
		sb.append(prefixTranslate(t));
		// quote types need no change extra quoted inner parameter. Perhaps not prefix?   
		if (!(t instanceof TRQuoteType))
		{
			// add inner syntax tokens even if spurious to cope with structured union types
			// e.g. U = set of nat | real | seq of int => "VDMNat VDMSet" | "VDMReal" | "VDMInt VDMSeq"
			sb.append(IsaToken.innerSyntaxIt(t.translate()));
		}

		return sb.toString();
	}

	protected String typeInvTranslate(TRType t, String varName)
	{
		assert this.contains(t) && varName != null && !varName.isEmpty();
		StringBuilder sb = new StringBuilder();
		sb.append(prefixTranslate(t));
		// quote types do not have inner structure
		if (!(t instanceof TRQuoteType))
		{
			sb.append(varName);
		}
		sb.append(IsaToken.SPACE.toString());
		sb.append(IsaToken.FUN.toString());
		sb.append(IsaToken.SPACE.toString());
		// the var name for quotes is the outer case varname, which is the same, so this will work 
		sb.append(t.invTranslate(varName));
		return sb.toString();
	}

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			Iterator<TRType> it = iterator();
			TRType t = it.next();
			sb.append(typeTranslate(t));
			while (it.hasNext())
			{
				sb.append(getSemanticSeparator());
                sb.append(getFormattingSeparator());
				t = it.next();
				sb.append(typeTranslate(t));
			}
		}
		return sb.toString();
	}

	public Set<String> getDefLemmas()
	{
		TreeSet<String> result = new TreeSet<String>();
		for(TRType t : this)
		{
			result.addAll(t.getDefLemmas());
		}
		return result;
	}

	@Override
	public String invTranslate()
	{
		return invTranslate(IsaToken.dummyVarNames(1, false, getLocation()));
	}

	public String invTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			Iterator<TRType> it = iterator();
			TRType t = it.next();
			sb.append(typeInvTranslate(t, varName));// + Integer.valueOf(i)));
			while (it.hasNext())
			{
                sb.append(getFormattingSeparator());
				sb.append(getInvTranslateSeparator());
				t = it.next();
				sb.append(typeInvTranslate(t, varName));// + Integer.valueOf(i)));
			}
			sb.append(getFormattingSeparator());
		}
		return sb.toString();
	}

	public TRTypeList asList()
    {
        TRTypeList result = new TRTypeList();
        result.addAll(this);
		TRNode.setup(result);
        return result;
    }

	protected String unionTypeTranslate(TRType t, String varName, TRExpression body, TRUnionContext innerContext)
	{
		assert this.contains(t) && varName != null && !varName.isEmpty();
		StringBuilder sb = new StringBuilder();
		sb.append(prefixTranslate(t));
		sb.append(varName);
		sb.append(IsaToken.SPACE.toString());
		sb.append(IsaToken.FUN.toString());
		sb.append(IsaToken.SPACE.toString());
		sb.append(IsaToken.comment(IsaInfoMessage.ISA_UNION_TYPE_COERCIONS.toString(), getFormattingSeparator()));
		// if there is a context, follow it; otherwise, ready to translate the body
		String bodyStr = innerContext == null ? body.translate() : 
			getFormattingSeparator() + innerContext.unionTypesTranslate(body, innerContext.getNextUnionContext());
		sb.append(bodyStr);
		return sb.toString();
	}

	public String unionTypesTranslate(String varName, TRExpression body, TRUnionContext innerContext)
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			Iterator<TRType> it = iterator();
			TRType t = it.next();
			sb.append(unionTypeTranslate(t, varName, body, innerContext));
			while (it.hasNext())
			{
                sb.append(getFormattingSeparator());
				sb.append(getInvTranslateSeparator());
				t = it.next();
				sb.append(unionTypeTranslate(t, varName, body, innerContext));
			}
			sb.append(getFormattingSeparator());
		}
		return sb.toString();
	}
 
	// public String invTranslate(List<String> varNames)
	// {
	// 	//TODO this is dangerous?! 
	// 	return asList().invTranslate(varNames);
	// }

	@Override
	public String tldIsaComment() {
		return "";
	}

	@Override
	public void report(IsaErrorMessage message) {
		GeneralisaPlugin.report(message, getLocation());
	}

	@Override
	public void report(IsaErrorMessage message, Object... args) {
		GeneralisaPlugin.report(message, getLocation(), args);
	}

	@Override
	public void warning(IsaWarningMessage message) {
		GeneralisaPlugin.warning(message, getLocation());
	}

	@Override
	public void warning(IsaWarningMessage message, Object... args) {
		GeneralisaPlugin.warning(message, getLocation(), args);
	}
}