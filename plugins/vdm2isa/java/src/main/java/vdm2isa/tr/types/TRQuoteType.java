package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRQuoteType extends TRType
{
	private static final long serialVersionUID = 1L;
    private final String value;

    public TRQuoteType(LexLocation location, String value) {
        super(location);
        this.value = value;
    }

    @Override
    public String translate() {
        return value;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.VDMQUOTE;
    }
    
    @Override
	public String invTranslate(String varName) {
        report(10000, "Not yet implemented");
        return IsaToken.ERROR.toString();
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseQuoteType(this, arg);
	}
}
