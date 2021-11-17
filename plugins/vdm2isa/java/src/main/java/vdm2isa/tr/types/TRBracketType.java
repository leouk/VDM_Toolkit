package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCBracketType;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRBracketType extends TRType {

    protected final TRType type; 

    public TRBracketType(TCBracketType vdmType, TRType type) {
        super(vdmType);
        this.type = type;
    }

    @Override
    public String invTranslate(String varName) {
        return IsaToken.parenthesise(this.type.invTranslate(varName));
    }

    @Override
    public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg) {
        return visitor.caseBracketType(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.LPAREN;
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(this.type.translate());
    }    
}
