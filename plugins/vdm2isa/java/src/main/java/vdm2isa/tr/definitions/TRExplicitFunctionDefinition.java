/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionListList;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPatternListList;
import vdm2isa.tr.types.TRFunctionType;

public class TRExplicitFunctionDefinition extends TRDefinition
{
	private static final long serialVersionUID = 1L;
	private final TCNameToken name;
	private final TCNameList typeParams;
	private final TRFunctionType type;
	private final TRPatternListList parameters;
	private final TRExpression body;
	private final TRExpression precondition;
	private final TRExpression postcondition;
	private final boolean isTypeInvariant;
	private final TRExpression measureExp;
	private final boolean isCurried;
	private final boolean recursive;
	private final boolean isUndefined;
	
	private TRExplicitFunctionDefinition predef;
	private TRExplicitFunctionDefinition postdef;
	private TCDefinitionListList paramDefinitionList;

	public TRExplicitFunctionDefinition(LexCommentList comments,
			TCAnnotationList annotations,
			TCNameToken name,
			TCNameList typeParams, TRFunctionType type,
			TRPatternListList parameters, TRExpression body,
			TRExpression precondition,
			TRExpression postcondition, boolean typeInvariant, TRExpression measureExp,
			boolean isCurried, 
			TRExplicitFunctionDefinition predef,
			TRExplicitFunctionDefinition postdef,
			TCDefinitionListList paramDefinitionList,
			boolean recursive,
			boolean isUndefined)
	{
		super(name.getLocation(), comments, annotations);
		this.name = name;
		this.typeParams = typeParams;
		this.type = type;
		this.parameters = parameters;
		this.body = body;
		this.precondition = precondition;
		this.postcondition = postcondition;
		this.isTypeInvariant = typeInvariant;
		this.measureExp = measureExp;
		this.isCurried = isCurried;
		this.predef = predef;
		this.postdef = postdef;
		this.paramDefinitionList = paramDefinitionList;
		this.recursive = recursive;
		this.isUndefined = isUndefined;
		this.local = false; // LetDefExpression to set this to true if/when needed
        
		//TODO type parameters are comma separated?	

		// parameters are curried not "," separated
		this.parameters.setSeparator(" ");
		
		System.out.println(toString());

		if (precondition != null && predef == null)
			report(11111, "Explicit funciton has declared precondition but no pre definition.");
		if (postcondition != null && postdef == null)
			report(11111, "Explicit funciton has declared postcondition but no post definition.");

		if (this.isCurried)
		{
			warning(11111, "VDM (curried) explicit function definition still with some problems!");
		}
    }

    @Override
	public String toString()
	{
		return "TRExplicitFuncDef for " + 
			" \n\tname        = " + String.valueOf(name) +
			" \n\tlocal		  = " + local + 
			" \n\ttype params = " + String.valueOf(typeParams) + 
			" \n\ttype        = " + (type != null ? type.translate() : "null") + 
			" \n\tparameters  = " + String.valueOf(parameters) + //TODO make this properly
			" \n\tbody        = " + (body != null ? body.translate() : "null") + 
			" \n\tpre         = " + (precondition  != null ? precondition.getClass().getName()  + ": " + precondition.translate()  : "null") + 
			" \n\tpost        = " + (postcondition != null ? postcondition.getClass().getName() + ": " + postcondition.translate() : "null") + 
			" \n\tisTypeInv   = " + isTypeInvariant +
			" \n\tmeasure     = " + (measureExp != null ? measureExp.getClass().getName() + ": " + measureExp.translate() : "null") +
			" \n\tisCurried   = " + isCurried +
			// avoid calling translate for TLD as it creates a record of what has been translated!  
			" \n\tpredef      = " + (predef  != null ? predef.getClass().getName()  + ": \n========" + predef.toString() + "\n========"/*predef.translate()*/  : "null") +
			" \n\tpostdef     = " + (postdef != null ? postdef.getClass().getName() + ": \n========" + postdef.toString() + "\n========"/*postdef.translate()*/ : "null") +
			" \n\tparamDefList= " + String.valueOf(paramDefinitionList) +
			" \n\trecursive   = " + recursive +
			" \n\tisUndefined = " + isUndefined;
	
		// f: nat -> nat
		// f(x) == x + 1;
		//
		// TRExplicitFuncDef for f 
		// 	type params = null 
		// 	type        = VDMNat \<Rightarrow> VDMNat 
		// 	parameters  = [x] 
		// 	body        = (x + (1::VDMNat1)) 
		// 	pre         = null 
		// 	post        = null 
		// 	isTypeInv   = false 
		// 	measure     = null 
		// 	isCurried   = false 
		// 	predef      = null 
		// 	postdef     = null 
		// 	paramDefList= [x = nat]
	}

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		
		// add any comments and annotations
		sb.append(super.translate());
		
		//TODO implcit type invariant checks on both pre and post

		// translate the precondition
		if (predef != null) 
		{
			sb.append(predef.translate());
			sb.append("\n");
		}

		// translate the postcondition
		if (postdef != null)
		{
			sb.append(postdef.translate());
			sb.append("\n");
		}

		// translate the explicit function definition
		sb.append(IsaTemplates.translateDefinition(
				name.toString(), 
				type.parameters.translate(), 
				type.result.translate(), 
				parameters.translate(), 
				body.translate()));
		
		return sb.toString();
	}

	@Override
	public String invTranslate() {
		StringBuilder sb = new StringBuilder();
		warning(11111, "TODO: processing explicit function invTranslate please!");
		return sb.toString();
	}

	@Override
	public IsaToken isaToken() {
		return IsaToken.FUN;
	}

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseExplicitFunctionDefinition(this, arg);
	}
}
