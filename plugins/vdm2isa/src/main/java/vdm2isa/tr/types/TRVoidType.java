package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCVoidType;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;
import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaInfoMessage;

import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRStateDefinition;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRAbstractInnerTypedType;
import vdm2isa.tr.types.TRTypeList;

import vdm2isa.tr.types.visitors.TRTypeVisitor;


public class TRVoidType extends TRType{
    
    public TRVoidType(TCVoidType vdmType, TRDefinitionList definitions)
	{
		super(vdmType, definitions);
	}

    @Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseVoidType(this, arg);
	}
    
    @Override
    public String translate()
    {
        return "()";
    }

    @Override
	public String invTranslate(String varName) 
    {
        return "()";
    }

    protected String getInvTypeString()
    {
        return "()";
    }


    @Override
    public TRType copy(boolean atTLD)
    {
        //TODO need to actually implement this deep copy
        return this;
    }

    @Override
    public IsaToken isaToken() 
    {
        return IsaToken.NIL;
    }

    @Override
    public void checkForUnionTypes()
    {

    }


}
