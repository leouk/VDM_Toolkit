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
import vdm2isa.tr.patterns.TRParameterList;
import vdm2isa.tr.types.TRFunctionType;

public class TRExplicitFunctionDefinition extends TRDefinition
{
	private static final long serialVersionUID = 1L;
	private final TCNameToken name;
	private final TCNameList typeParams;
	private final TRFunctionType type;
	private final TRParameterList parameters;
	private final TRExpression body;
	private final TRExpression precondition;
	private final TRExpression postcondition;
	private final boolean isTypeInvariant;
	private final TRExpression measureExp;
	private final boolean isCurried;

	private TRExplicitFunctionDefinition predef;
	private TRExplicitFunctionDefinition postdef;
	private TCDefinitionListList paramDefinitionList;

	public boolean recursive = false;
	public boolean isUndefined = false;
	
	public TRExplicitFunctionDefinition(LexCommentList comments,
			TCAnnotationList annotations,
			TCNameToken name,
			TCNameList typeParams, TRFunctionType type,
			TRParameterList parameters, TRExpression body,
			TRExpression precondition,
			TRExpression postcondition, boolean typeInvariant, TRExpression measureExp,
			boolean isCurried, 
			TRExplicitFunctionDefinition predef,
			TRExplicitFunctionDefinition postdef,
			TCDefinitionListList paramDefinitionList)
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
		this.local = false; // LetDefExpression to set this to true if/when needed
        //System.out.println(toString());

		if (this.isCurried)
			warning(11111, "VDM (curried) explicit function definition still with some problems!");
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
			" \n\tpre         = " + (precondition != null ? precondition.translate() : "null") + 
			" \n\tpost        = " + (postcondition != null ? postcondition.translate() : "null") + 
			" \n\tisTypeInv   = " + isTypeInvariant +
			" \n\tmeasure     = " + (measureExp != null ? measureExp.translate() : "null") +
			" \n\tisCurried   = " + isCurried +
			" \n\tpredef      = " + (predef != null ? predef.translate() : "null") +
			" \n\tpostdef     = " + (postdef != null ? postdef.translate() : "null") +
			" \n\tparamDefList= " + String.valueOf(paramDefinitionList);
	
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
		
		sb.append(super.translate());
		
		sb.append(IsaTemplates.translateDefinition(
				name.toString(), 
				type.parameters.translate(), 
				type.result.translate(), 
				parameters.toString(), 
				body.translate()));

		warning(11111, "TODO: processing explicit function pre/post definitions please!");
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
