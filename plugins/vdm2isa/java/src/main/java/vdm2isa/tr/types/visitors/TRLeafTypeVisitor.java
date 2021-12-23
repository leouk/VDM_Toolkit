package vdm2isa.tr.types.visitors;

import java.util.Collection;

import vdm2isa.tr.TRVisitorSet;
import vdm2isa.tr.types.TRBracketType;
import vdm2isa.tr.types.TRField;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRNamedType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRProductType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeSet;
import vdm2isa.tr.types.TRUnionType;

/**
 * This TCType visitor visits all of the leaves of a type tree and calls
 * the basic processing methods for the simple types.
 */
public abstract class TRLeafTypeVisitor<E, C extends Collection<E>, S> extends TRTypeVisitor<C, S>
{
	protected TRVisitorSet<E, C, S> visitorSet = new TRVisitorSet<E, C, S>()
	{
		@Override
		protected void setVisitors()
		{
			typeVisitor = TRLeafTypeVisitor.this;
		}

		@Override
		protected C newCollection()
		{
			return TRLeafTypeVisitor.this.newCollection();
		}
	};
	
	/**
	 * We have to collect the nodes that have already been visited since types can be recursive,
	 * and the visitor will otherwise blow the stack. Note that this means you need a new visitor
	 * instance for every use (or only re-use with care!). This is tested and modified in the
	 * NamedType and RecordType entries.
	 */
	protected TRTypeSet done = new TRTypeSet();
	
	@Override
	public C caseBracketType(TRBracketType node, S arg)
	{
		return node.getInnerType().apply(this, arg);
	}
	
	@Override
	public C caseFunctionType(TRFunctionType node, S arg)
	{
		C all = newCollection();
		
		for (TRType param: node.parameters)
		{
			all.addAll(param.apply(this, arg));
		}
		
		all.addAll(node.getResultType().apply(this, arg));
		return all;
	}

	@Override
	public C caseMapType(TRMapType node, S arg)
	{
		C all = newCollection();
		all.addAll(node.getFromType().apply(this, arg));
		all.addAll(node.getToType().apply(this, arg));
		return all;
	}

	@Override
	public C caseNamedType(TRNamedType node, S arg)
	{
		if (done.contains(node))
		{
			return newCollection();
		}
		else
		{
			done.add(node);
			return node.type.apply(this, arg);
		}
	}

	// @Override
	// public C caseOperationType(TROperationType node, S arg)
	// {
	// 	C all = newCollection();
		
	// 	for (TRType param: node.parameters)
	// 	{
	// 		all.addAll(param.apply(this, arg));
	// 	}
		
	// 	all.addAll(node.result.apply(this, arg));
	// 	return all;
	// }

	@Override
	public C caseOptionalType(TROptionalType node, S arg)
	{
		return node.getInnerType().apply(this, arg);
	}

	@Override
	public C caseProductType(TRProductType node, S arg)
	{
		C all = newCollection();
		
		for (TRType param: node.types)
		{
			all.addAll(param.apply(this, arg));
		}
		
		return all;
	}

	@Override
	public C caseRecordType(TRRecordType node, S arg)
	{
		if (done.contains(node))
		{
			return newCollection();
		}
		else
		{
			done.add(node);
			C all = newCollection();
			
			for (TRField field: node.getFields())
			{
				all.addAll(caseField(field, arg));
			}
			
			return all;
		}
	}

    @Override
	public C caseField(TRField node, S arg)
    {
        return node.getInnerType().apply(this, arg);
    }

	@Override
	public C caseSeqType(TRSeqType node, S arg)
	{
		C all = newCollection();
		all.addAll(node.getInnerType().apply(this, arg));
		return all;
	}

	@Override
	public C caseSetType(TRSetType node, S arg)
	{
		C all = newCollection();
		all.addAll(node.getInnerType().apply(this, arg));
		return all;
	}

	@Override
	public C caseUnionType(TRUnionType node, S arg)
	{
		C all = newCollection();
		
		for (TRType param: node.getDataTypeConstructors())
		{
			all.addAll(param.apply(this, arg));
		}
		
		return all;
	}
	
	abstract protected C newCollection();
}