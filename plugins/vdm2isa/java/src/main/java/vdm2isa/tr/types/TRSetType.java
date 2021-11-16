package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCSetType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCSet1Type;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRSetType extends TRType
{
	private static final long serialVersionUID = 1L;
    public final TRType setof;
    public final boolean set1;

    /**
     * Constructor needed for TRUnionType
     * @param location
     * @param seqof
     * @param seq1
     */
    public TRSetType(TCType vdmType, TRDefinitionList definitions, TRType setof, boolean set1)
    {
        super(vdmType, definitions);
        this.setof = setof;
        this.set1 = set1;
    }

    public TRSetType(TCSetType owner, TRDefinitionList definitions, TRType setof)    
    {
       this(owner, definitions, setof, false);
    }

    public TRSetType(TCSet1Type owner, TRDefinitionList definitions, TRType setof)    
    {
        this(owner, definitions, setof, true);
    }

    @Override
    public IsaToken isaToken() {
        return set1 ? IsaToken.SET1 : IsaToken.SET;
    }

    @Override
    public String translate() {
        return setof.translate() + " " + isaToken().toString();
    }

    //lemma "inv_VDMSeq' (inv_VDMSeq' inv_VDMNat1) [[1,2],[1,2]]"
    @Override
    public String invTranslate(String varName) {
        return IsaToken.parenthesise( 
            IsaToken.INV.toString() + isaToken().toString() + "' " + 
            setof.invTranslate(null) + (varName != null ? " " + varName : ""));
    }

    

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseSetType(this, arg);
	}
}
