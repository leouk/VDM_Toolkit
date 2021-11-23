package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCInMapType;
import com.fujitsu.vdmj.tc.types.TCMapType;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRMapType extends TRAbstractInnerTypedType
{
    private static final long serialVersionUID = 1L;
	private final TRType from;
    public final boolean injective;

    public TRMapType(TCType vdmType, TRDefinitionList definitions, TRType from, TRType to, boolean injective)
	{
        super(vdmType, definitions, to);
        this.from = from;
        this.injective = injective;
    }

	public TRMapType(TCMapType owner, TRDefinitionList definitions, TRType from, TRType to)
	{
		this(owner, definitions, from, to, false);
	}

	public TRMapType(TCInMapType owner, TRDefinitionList definitions, TRType from, TRType to)
	{
		this(owner, definitions, from, to, true);
	}

    public TRType getFromType()
    {
        return from;
    }

    public TRType getToType()
    {
        return getInnerType();
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(from.translate());
        sb.append(getFormattingSeparator());
        sb.append(isaToken().toString());
        sb.append(getFormattingSeparator());
        sb.append(getToType().translate());
        return IsaToken.parenthesise(sb.toString());
    }

    @Override
    public String invTranslate(String varName) 
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.INV.toString());
        // transform "map" => "Map" for inv_Map call
        //          "inmap"=> "Inmap" for inv_Inmap call
        int i = sb.length();
        sb.append(isaToken().vdmToken().toString());
        sb.setCharAt(i, Character.toUpperCase(sb.charAt(i)));
        sb.append(IsaToken.SPACE.toString());
        // make sure we get the inv check without var name (e.g. inv_VDMNat1 instea of inv_VDMNat1 x)
        sb.append(from.invTranslate(null));
        sb.append(IsaToken.SPACE.toString());
        sb.append(getToType().invTranslate(null));
        sb.append(IsaToken.SPACE.toString());
        sb.append(varName);        
        return IsaToken.parenthesise(sb.toString());
    }

	@Override
	public TRType copy(boolean atTLD)
	{
		TRType result = new TRMapType((TCMapType)getVDMType(), definitions, getFromType().copy(true), getToType().copy(true), injective);
		result.setAtTopLevelDefinition(atTLD);
		return result;
	}
    
    @Override
    public IsaToken isaToken() {
        return injective ? IsaToken.INMAP : IsaToken.MAP;
    }    

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMapType(this, arg);
	}

    public TRFunctionType getFunctionType()
    {
        return TRFunctionType.getIsabelleMapType(this);
    }

    @Override
    public void checkForUnionTypes() {
        from.checkForUnionTypes();
        super.checkForUnionTypes();
        //getToType().checkForUnionTypes();
    } 
}
