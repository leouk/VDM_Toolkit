package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import vdm2isa.lex.IsaToken;

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
        return IsaToken.QUOTE;
    }
    
    @Override
	public String invTranslate(String varName) {
        report(10000, "Not yet implemented");
        return IsaToken.ERROR.toString();
	}
}
