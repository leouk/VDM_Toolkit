package vdm2isa.tr.types;

import java.util.Arrays;
import java.util.TreeSet;
import java.util.Iterator;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.tc.types.TCOptionalType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeSet;
import com.fujitsu.vdmj.tc.types.TCUnionType;
import com.fujitsu.vdmj.util.Utils;

import plugins.GeneralisaPlugin;
import vdm2isa.lex.IsaSeparator;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.MappableNode;
import vdm2isa.tr.TRNode;

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

	public TRTypeSet()
	{
		super();
		prefixed = false;
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
	
	public TRTypeSet(TRType... typs)
	{
		this();
		if (typs != null)
			for(TRType t : typs)
			{
				if (t != null)
					add(t);
			}
		//addAll(Arrays.asList(typs));
	}

	@Override
	public void setup()
	{
		setFormattingSeparator("");
		setSemanticSeparator(" " + IsaToken.BAR.toString() + " ");
		setInvTranslateSeparator(" " + IsaToken.BAR.toString() + " ");
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

	protected void setPrefixed(boolean b)
	{
		prefixed = b;
	}

    public void setAtTopLevelDefinition(boolean b)
    {
        for(TRType t : this)
		{
			t.setAtTopLevelDefinition(b);
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

	@Override
	public boolean add(TRType t)
	{
		if (t instanceof TRSeqType)
		{
			// If we add a TRSeq1Type/TRSeqType, and there is already a TRSeqType in the set
			// we ignore the TRSeq1Type.
			
			TRSeqType s1t = (TRSeqType)t;
			TRSeqType st = new TRSeqType(s1t.getVDMType(), s1t.definitions, s1t.getInnerType(), s1t.seq1);
			TRNode.setup(st);
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
			TRSetType st = new TRSetType(s1t.getVDMType(), s1t.definitions, s1t.getInnerType(), s1t.set1);
			TRNode.setup(st);
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
					if (x.getVDMType().getNumeric().getWeight() < x.getVDMType().getNumeric().getWeight())
					{
						remove(x);
						break;
					}
					else
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
			result = new TRUnionType(new TCUnionType(location, typeSet), result.definitions, this);
			TRNode.setup(result);
		}
		if (optional)
		{
			result = new TROptionalType(new TCOptionalType(location, result.getVDMType()), result.definitions, result);
			TRNode.setup(result);
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
			for (TRType n : this)
			{
				n.setSemanticSeparator(sep);
			}
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
			for (TRType n : this)
			{
				n.setInvTranslateSeparator(sep);
			}
		}	
		return old;
	}

	@Override
	public LexLocation getLocation()
	{
		return isEmpty() ? LexLocation.ANY : iterator().next().getLocation();
	}

	protected String prefixTranslate(TRType t)
	{
		assert this.contains(t);
		StringBuilder sb = new StringBuilder();
		String typeStr = t.translate().trim();
		if (prefixed)
		{
			// create the constant constructors for the Isabelle data type as
			// U_T for every type T in the union, where spaces are replaced by underscores in T
			// ex.  Union = nat | set of int | seq of real 
			//		=isa> 
			//		datatype Union = U_nat "VDMNat" | U_set_of_int "VDMInt VDMSet" | U_seq_of_real "VDMReal VDMSeq" 
			//
			// Constructor names won't be unique across union types, but will within fully qualified union types, so fine for now.
			sb.append(IsaToken.VDMUNION.toString());
			sb.append(IsaToken.UNDERSCORE.toString());
			sb.append(typeStr.replace(' ', '_'));
			sb.append(IsaToken.SPACE.toString());
		}
		return sb.toString();
	}

	protected String typeTranslate(TRType t)
	{
		assert this.contains(t);
		StringBuilder sb = new StringBuilder();
		sb.append(prefixTranslate(t));
		// add inner syntax tokens even if spurious to cope with structured union types
		// e.g. U = set of nat | real | seq of int => "VDMNat VDMSet" | "VDMReal" | "VDMInt VDMSeq"
		sb.append(IsaToken.bracketit(IsaToken.ISAQUOTE, t.translate(), IsaToken.ISAQUOTE));
		return sb.toString();
	}

	protected String typeInvTranslate(TRType t, String varName)
	{
		assert this.contains(t) && varName != null && !varName.isEmpty();
		StringBuilder sb = new StringBuilder();
		sb.append(prefixTranslate(t));
		sb.append(varName);
		sb.append(IsaToken.SPACE.toString());
		sb.append(IsaToken.FUN.toString());
		sb.append(IsaToken.SPACE.toString());
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

	@Override
	public String invTranslate()
	{
		return invTranslate(IsaToken.dummyVarNames(1, getLocation()));
	}

	public String invTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (!isEmpty())
		{
			Iterator<TRType> it = iterator();
			TRType t = it.next();
			int i = 1;
			// change the inner dummy name! 
			sb.append(typeInvTranslate(t, varName + Integer.valueOf(i)));
			while (it.hasNext())
			{
                sb.append(getFormattingSeparator());
				sb.append(getInvTranslateSeparator());
				t = it.next();
				i++;
				sb.append(typeInvTranslate(t, varName + Integer.valueOf(i)));
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