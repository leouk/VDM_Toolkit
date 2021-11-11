package vdm2isa.tr.types;

import java.util.TreeSet;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.ClassMapper;
import com.fujitsu.vdmj.mapper.Mappable;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCTypeSet;
import com.fujitsu.vdmj.util.Utils;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;

/**
 * This is an adjusted copy of TCTypeSet. Not sure if this is right.
 */
//TODO Implement Mappable (instead of MappableNode, for now), given you don't call translate() etc on it? 
@SuppressWarnings("serial")
public class TRTypeSet extends TreeSet<TRType> implements Mappable//MappableNode
{
	private static final long serialVersionUID = 1L;

    public TRTypeSet(TCTypeSet from) throws Exception
	{
		ClassMapper mapper = ClassMapper.getInstance(TRNode.MAPPINGS);
		
		for (TCType type: from)
		{
			add((TRType)mapper.convert(type));
		}
	}
	
	public TRTypeSet()
	{
		super();
	}

	public TRTypeSet(TRType t)
	{
		add(t);
	}

	public TRTypeSet(TRType t1, TRType t2)
	{
		add(t1);
		add(t2);
	}

	@Override
	public boolean add(TRType t)
	{
		if (t instanceof TRSeqType)
		{
			// If we add a TRSeq1Type/TRSeqType, and there is already a TRSeqType in the set
			// we ignore the TRSeq1Type.
			
			TRSeqType s1t = (TRSeqType)t;
			TRSeqType st = new TRSeqType(s1t.location, s1t.definitions, s1t.seqof, s1t.seq1);
			
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
			TRSetType st = new TRSetType(s1t.location, s1t.definitions, s1t.setof, s1t.set1);
			
			if (contains(st))
			{
				return false;	// Was already there
			}
		}
        //TODO this needs further investigation 
		// else if (t instanceof TRNumericType)
		// {
		// 	for (TRType x: this)
		// 	{
		// 		if (x instanceof TRNumericType)
		// 		{
		// 			if (x.getNumeric().getWeight() < t.getNumeric().getWeight())
		// 			{
		// 				remove(x);
		// 				break;
		// 			}
		// 			else
		// 			{
		// 				return false;	// Was already there
		// 			}
		// 		}
		// 	}
		// }
		// else if (t instanceof TROptionalType)
		// {
		// 	TROptionalType opt = (TROptionalType)t;
			
		// 	if (!opt.type.isUnknown(opt.type.location) && contains(opt.type))
		// 	{
		// 		remove(opt.type);	// Because T | [T] = [T]
		// 	}
		// }
		
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
		TRType result = null;

		if (this.size() == 1)
		{
			result = iterator().next();
		}
		else
		{
			result = new TRUnionType(location, null, this);
		}

		return (optional ? new TROptionalType(location, null, result) : result);
	}

	public TRTypeList getComposeTypes()
	{
		TRTypeList list = new TRTypeList();
		
		for (TRType type: this)
		{
			list.addAll(type.getComposeTypes());
		}
		
		return list;
	}
}