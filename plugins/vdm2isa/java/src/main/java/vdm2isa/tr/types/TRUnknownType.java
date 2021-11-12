package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaWarningMessage;
import vdm2isa.tr.definitions.TRDefinitionList;
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

    public TRUnknownType(LexLocation location, TRDefinitionList definitions)
    {
        super(location, definitions);
    }

    @Override
    public String invTranslate(String varName) {
        // unknown type is just inv_True
        String problem = "Unknown VDM types will generate Isabelle additional type variable `a warning.";
        warning(11111, problem);
        return 
            IsaToken.INV.toString() + 
                IsaToken.TRUE.toString() +
                (varName == null ? "" : " " + varName) +
                "\n\t" + IsaToken.comment(problem);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.UNKNOWN;
    }

    @Override
    public String translate() {
        // unknown type assume polymorphic one
        return isaToken().toString();
    }    

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseUnknownType(this, arg);
	}
}
