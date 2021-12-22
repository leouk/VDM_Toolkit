package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCParameterType;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRParameterType extends TRType {

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
        return "ParamType " + String.valueOf(name) + "\n\t paramDef = " + String.valueOf(paramdef);
    }

    @Override
    public void setup()
    {
        super.setup();
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
    public String invTranslate(String varName) {
        return isaToken().toString() + name.toString();
    }

    @Override
    public String translate() {
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
