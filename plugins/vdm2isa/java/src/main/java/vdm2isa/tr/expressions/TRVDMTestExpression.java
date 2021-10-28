package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRType;

/**
 * Super class for VDM is_X and narrow expressions.
 */
public abstract class TRVDMTestExpression extends TRExpression {
    
	private static final long serialVersionUID = 1L;
    protected final TCNameToken typename;
    protected final TRType basictype;
    protected final TRExpression test;

    public TRVDMTestExpression(LexLocation location, TCNameToken typename, TRType basictype, TRExpression test)
    {
        super(location);
        this.typename = typename;
        this.basictype = basictype;
        this.test = test;
        if (basictype != null && typename != null)
            report(10008, "Invalid " + getClass().getName() + " expression - contains both type name and basic type information");
        if (basictype != null && !(basictype instanceof TRBasicType))
            report(10009, getClass().getName() + " expression basic type invalid class " + basictype.getClass().getName());      
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    public boolean isBasicTyped()
    {
        return basictype != null && basictype instanceof TRBasicType && typename == null;
    }

    public boolean isNameTyped()
    {
        return basictype == null && typename != null;
    }
}
