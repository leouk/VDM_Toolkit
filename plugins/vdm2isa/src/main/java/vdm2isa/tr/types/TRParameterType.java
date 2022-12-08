package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCParameterType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRParameterType extends TRType {

    private static final long serialVersionUID = 1L;
    private final TCNameToken name;
    private final TRDefinition paramdef;

    public TRParameterType(TCParameterType vdmType, TRDefinitionList definitions, TCNameToken pname, TRDefinition paramdef) {
        super(vdmType, definitions);
        this.name = pname;
        this.paramdef = paramdef;
    }

    @Override 
    public String toString()
    {
        return "ParamType " + String.valueOf(name);// + "\n\t paramDef = " + String.valueOf(paramdef); funny loop
    }

    @Override
    public void setup()
    {
        super.setup();
        setFormattingSeparator("\n\t");
        TRNode.setup(paramdef);
    }

    @Override
    public TRType copy(boolean atTLD) {
        TRType result = new TRParameterType((TCParameterType)getVDMType(), definitions, name, paramdef);
        TRNode.setup(result);
        result.setAtTopLevelDefinition(atTLD);    
        return result;
    }

    @Override
	protected String getInvTypeString()
	{
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.INV.toString());
        sb.append(name.toString());//IsaToken.TRUE.toString());
        return sb.toString();
    }    

    /**
     * Parametric types invariant translate expects that the caller will have an "inv_NAME" in context to check
     * the specific invariant specification call for the instantiated parameter. This has to come from 
     * TRExplicitFunctionDefinition.  
     */
    @Override
    public String invTranslate(String varName) {
        StringBuilder sb = new StringBuilder();
        sb.append(getInvTypeString());
        sb.append(varName != null ? IsaToken.SPACE.toString() + varName : "");
        return sb.toString();
    }

    @Override
    public String oldtranslate() {
        return isaToken().toString() + name.toString();
    }

    @Override
    public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg) {
        return visitor.caseParameterType(this, arg);
    }

    @Override
    public void checkForUnionTypes() {
        // do nothing
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.ISAR_TYPEPARAM;
    }
    
}
