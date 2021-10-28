package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

/**
 * We need this for expressions like "c = nil", where type is indeed unknown.
 */
public class TRUnknownType extends TRType {
    
    private static final long serialVersionUID = 1L;
    
    public TRUnknownType(LexLocation location)
    {
        super(location);
    }

    @Override
    public String invTranslate(String varName) {
        // unknown type is just inv_True
        return 
            IsaToken.INV.toString() + 
                IsaToken.TRUE.toString() +
                (varName == null ? "" : " " + varName);

    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        // unknown type assume polymorphic one
        return IsaToken.UNKNOWN.toString();
    }    

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseUnknownType(this, arg);
	}
}
