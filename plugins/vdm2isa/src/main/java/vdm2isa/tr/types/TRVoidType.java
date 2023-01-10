package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCVoidType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
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
    protected TRType doCopy(boolean atTLD)
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
