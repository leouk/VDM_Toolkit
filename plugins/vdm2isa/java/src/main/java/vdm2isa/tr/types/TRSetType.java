package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCSetType;
import com.fujitsu.vdmj.tc.types.TCSet1Type;

import vdm2isa.lex.IsaToken;

public class TRSetType extends TRType
{
    private final TRType setof;
    private final boolean set1;

    public TRSetType(TCSetType owner, TRType setof)    
    {
        super(owner.location);
        this.setof = setof;
        this.set1 = false;
    }

    public TRSetType(TCSet1Type owner, TRType setof)    
    {
        super(owner.location);
        this.setof = setof;
        this.set1 = true;
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

    
}
