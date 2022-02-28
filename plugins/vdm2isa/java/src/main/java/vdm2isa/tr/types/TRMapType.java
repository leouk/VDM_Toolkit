package vdm2isa.tr.types;

import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.tc.types.TCInMapType;
import com.fujitsu.vdmj.tc.types.TCMapType;
import com.fujitsu.vdmj.tc.types.TCType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
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

    @Override
    public void setup()
    {
        super.setup();
        TRNode.setup(from);
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
    public boolean setAtTopLevelDefinition(boolean b, boolean deep)
    {
        // inner type at super = to type set
        boolean old = super.setAtTopLevelDefinition(b, deep);
        if (deep)
        {
            this.getFromType().setAtTopLevelDefinition(b, deep);
            //on super call
            //this.getToType().setAtTopLevelDefinition(b, deep);
        }
        return old;
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
    public Set<String> getDefLemmas()
    {
        TreeSet<String> result = new TreeSet<String>();
        result.add(getInvTypeString() + IsaToken.ISAR_LEMMAS_DEFS.toString());
        result.addAll(from.getDefLemmas());
        result.addAll(getToType().getDefLemmas());
        return result;
    }

    @Override
    protected String getInvTypeString()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.INV.toString());
        // transform "map" => "Map" for inv_Map call
        //          "inmap"=> "Inmap" for inv_Inmap call
        int i = sb.length();
        sb.append(isaToken().vdmToken().toString());
        sb.setCharAt(i, Character.toUpperCase(sb.charAt(i)));
        return sb.toString();
    }

    @Override
    public String invTranslate(String varName) 
    {
        StringBuilder sb = new StringBuilder();
        sb.append(getInvTypeString());
        sb.append(IsaToken.SPACE.toString());
        // make sure we get the inv check without var name (e.g. inv_VDMNat1 instea of inv_VDMNat1 x)
        sb.append(from.invTranslate(null));
        sb.append(IsaToken.SPACE.toString());
        sb.append(getToType().invTranslate(null));
        if (varName != null)
        {
            sb.append(IsaToken.SPACE.toString());
            sb.append(varName);        
        }
        return IsaToken.parenthesise(sb.toString());
    }

	@Override
	public TRType copy(boolean atTLD)
	{
        TRType result = this;
        if (getFromType() == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "map type", "null domain type?");
        }
        else if (getToType() == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "map type", "null range type?");
        }
        else
        {
            result = new TRMapType((TCMapType)getVDMType(), definitions, getFromType().copy(true), getToType().copy(true), injective);
            TRNode.setup(result);
		    result.setAtTopLevelDefinition(atTLD);
        }
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

    public static final TRMapType newMapType(TRType left, TRType right, boolean injective)
    {
        TRMapType result = new TRMapType(new TCMapType(left.location, left.getVDMType(), right.getVDMType()), new TRDefinitionList(), left, right, injective);
        TRNode.setup(result);
        return result;
    }
}
