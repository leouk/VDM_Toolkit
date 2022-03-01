/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCApplyExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionListList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeList;

public class TRApplyExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	public final TRType type;
	public final TRExpression root;
	public TRExpressionList args;
	public TRTypeList argtypes;
	public final TRDefinitionListList recursiveCycles;
	
	public TRApplyExpression(TCApplyExpression tc, TRType type, TRExpression root, TRExpressionList args, 
		TRTypeList argtypes, TRDefinitionListList recursiveCycles, TRType exptype)
	{
		super(root != null ? root.location : LexLocation.ANY, tc, exptype);
		this.type = type;
		this.root = root;
		this.args = args;
		this.argtypes = argtypes;
		this.recursiveCycles = recursiveCycles;
	}

	@Override
	public void setup()
	{
		super.setup();
		expandApplyArguments();
		TRNode.setup(type, root, args, argtypes, recursiveCycles); 
		//depending on the root: f(x) is different from list(x). map(x) also requires attention!  
		this.setSemanticSeparator(type instanceof TRSeqType ? IsaToken.SEQAPPLY.toString() : IsaToken.APPLY.toString());
		//System.out.println(toString());
	}

	/**
	 * Function instantiation requires expansion of parametric types as invariant checking input parameters.
	 * These will be variable expresssions referring to invariant type calls
	 */
	protected void expandApplyArguments()
	{
		if (root instanceof TRFunctionInstantiationExpression)
		{
			TRFunctionInstantiationExpression froot = (TRFunctionInstantiationExpression)root;
			// recreate arguments and their types based on unique actual types passed
			TRExpressionList newArgs = new TRExpressionList();
			TRTypeList newArgTypes = new TRTypeList();
			// have to repeat the same invariant call multiple times, given that the funct instantiation requires at least as many even if the same
			//TRTypeSet actualTypes = new TRTypeSet(froot.actualTypes);
			for(TRType tparam : froot.actualTypes)
			{
				// for every unique actual type create an invariant function call to that type as the leading parameters
				TRType invCallType = TRFunctionType.newFunctionType(TRBasicType.boolType(tparam.location), tparam);
				TRExpression invCall = TRVariableExpression.newVariableExpr(tparam.location, tparam.invTranslate(), invCallType);
				newArgTypes.add(invCallType);
				newArgs.add(invCall);
			}
			// setup + update the underlying apply expression arguments to include type parameters invariant check calls
			newArgTypes.addAll(argtypes);
			newArgs.addAll(args);
			TRNode.setup(newArgTypes, newArgs);
			argtypes = newArgTypes;
			args = newArgs;
		}
	}

	/**
	 * The best guess of the apply expression type, is the type of its root; 
	 * wait! No, that can be union type. Oh dear. Can't quite figure out
	 */
	@Override
	protected TRType getBestGuessType()
	{
		return root != null ? root.getBestGuessType() : type;
	}

	//TODO push this all the way to TRNode and TRExpression etc ! 
	public static final String toSimpleString(TRNode e)
	{
		if (e instanceof TRVariableExpression)
		{
			TRVariableExpression ev = (TRVariableExpression)e;
			return String.valueOf(ev.name) + ": " + String.valueOf(ev.exptype);
		}
		else
			return String.valueOf(e);
	}

	@Override
    public String toString()
    {
        return "ApplyExpr " + 
			"\n\t root = " + TRApplyExpression.toSimpleString(root) +
			"\n\t args = " + String.valueOf(args) + 
			"\n\t argty= " + String.valueOf(argtypes) + 
			"\n\t type = " + String.valueOf(type) +
			"\n\t exptp= " + String.valueOf(exptype) +
			"\n\t loc  = " + String.valueOf(location);
    }

	@Override
	public String translate()
	{
		StringBuilder call = new StringBuilder();
		call.append(root.translate());
		call.append(getSemanticSeparator());
		call.append(args.translate());
	
		StringBuilder sb = new StringBuilder();
		// for map applications, we need to add "the" for optional removal
		// Hum. It depends on the result type where this will land. So, only them can know whether to "add" it or not 
		if (type.ultimateType() instanceof TRMapType)
		{
			sb.append(IsaToken.the(call.toString()));
		}
		else
		{
			sb.append(call.toString());
		}
		return IsaToken.parenthesise(sb.toString());
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.APPLY;
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseApplyExpression(this, arg);
	}

	public static final TRApplyExpression newApplyExpression(
		String functionName, TRExpressionList args, TRType resultType)
	{
		TRFunctionType ftype = TRFunctionType.newFunctionType(resultType, args.getTypeList(), true);
		return TRApplyExpression.newApplyExpression(
			TRVariableExpression.newVariableExpr(resultType.location, functionName, ftype), args, resultType);
	}

	public static final TRApplyExpression newApplyExpression(
			TRExpression root, TRExpressionList args, TRType resultType)
	{
		TRApplyExpression result = new TRApplyExpression(
				new TCApplyExpression(root.getVDMExpr(), args.getVDMExpressionList()), 
				root.getType(), root, args, args.getTypeList(), new TRDefinitionListList(), resultType);
		TRNode.setup(result);
		return result;
	}
}
