package vdm2isa.tr.modules;

import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.tr.definitions.TRDefinitionList;

public class TRProofObligationModule extends TRModule
{
	private static final long serialVersionUID = 1L;

    public TRProofObligationModule(TCIdentifierToken name, TRDefinitionList definitions)
    {
        super(name, definitions, null);
    }

    public String getImports()
	{
		return name.toString();
	}
}
