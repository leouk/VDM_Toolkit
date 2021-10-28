/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.definitions.TCAccessSpecifier;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionListList;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.patterns.TCPatternListList;
import com.fujitsu.vdmj.tc.types.TCFunctionType;
import com.fujitsu.vdmj.tc.types.TCTypeList;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRParameterList;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRTypeList;

public class TRExplicitFunctionDefinition extends TRDefinition
{
	private static final long serialVersionUID = 1L;
	public final TCNameToken name;
	public final TCNameList typeParams;
	public final TRFunctionType type;
	public final TRParameterList parameters;
	public final TRExpression body;
	public final TRExpression precondition;
	public final TRExpression postcondition;
	public final boolean isTypeInvariant;
	public final TRExpression measureExp;
	public TCExplicitFunctionDefinition predef;
	public TCExplicitFunctionDefinition postdef;
	public TCDefinitionListList paramDefinitionList;

	public boolean recursive = false;
	public boolean isUndefined = false;
	
	public TRExplicitFunctionDefinition(LexCommentList comments,
			TCAnnotationList annotations,
			TCNameToken name,
			TCNameList typeParams, TRFunctionType type,
			TRParameterList parameters, TRExpression body,
			TRExpression precondition,
			TRExpression postcondition, boolean typeInvariant, TRExpression measureExp)
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
        //System.out.println(toString());
    }

    @Override
	public String toString()
	{
		return "TRExplicitFuncDef for " + name.toString() + 
			" type " + type.getClass().getName() + " TODO";
	}

	@Override
	public String translate()
	{
		StringBuilder sb = new StringBuilder();
		
		sb.append(super.translate());
		/*
		sb.append(IsaTemplates.translateValueDefinition(pattern, type.translate(), exp.translate()));
		IsaTemplates.explicitFunctionDefnition(
			name.toString(),
			type.getParameters().translate() 
			inTypeSig, outTypeSig, inParam, exp)
		sb.append(type.getResult().translate() + " " + name.getName() + "(");
		TRTypeList ptypes = type.getParameters();
		
		for (int i=0; i<ptypes.size(); i++)
		{
			sb.append(ptypes.get(i).translate());
			sb.append(" ");
			sb.append(parameters.get(i));
		}
		
		sb.append(")\n");
		sb.append("{\n    return ");
		sb.append(body.translate());
		sb.append(";\n}\n");
		*/
		return sb.toString();
	}

	@Override
	public String invTranslate() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public IsaToken isaToken() {
		// TODO Auto-generated method stub
		return null;
	}
}
