package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRProductType extends TRType {
    private static final long serialVersionUID = 1L;

    private final TRTypeList types;

    public TRProductType(LexLocation location, TRTypeList types)
    {
        super(location);
        this.types = types;
        this.types.setCurried(false);
    }

    @Override
    public String invTranslate(String varName) {
        return "NYI invTranslate for productType for " + varName;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.CROSSPROD;
    }

    @Override
    public String translate() {
        return IsaToken.LPAREN.toString() + this.types.translate() + IsaToken.RPAREN.toString();
    }
}
