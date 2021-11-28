package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

/**
 * This represents "is_T(x)" or "is_(x, T)"; both have same structure as:
 * = typename if T is defined named type; basictype otherwise; never both. 
 * = test = x
 */
public class TRIsExpression extends TRVDMTestExpression {

	private static final long serialVersionUID = 1L;

    public TRIsExpression(LexLocation location, TCNameToken typename, TRType basictype, TRExpression test, TRDefinition typedef, TRType exptype)
    {
        super(location, typename, basictype, test, typedef, exptype);
    }

    // @Override 
    // public void setup()
    // {
    //     super.setup();
    //     //System.out.println(toString());
    // }

    @Override
    public IsaToken isaToken() {
        return IsaToken.ISEXPR;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        sb.append(isaToken().toString());
        sb.append(IsaToken.SPACE.toString());
        sb.append(IsaToken.parenthesise(test.translate()));
        sb.append(IsaToken.SPACE.toString());
        // is_T(s)              => inv_T s      (for any named type)
        // is_nat(s)            => inv_VDMNat s (for any basic type)
        // is_(s, set of nat)   => basictype.invTranslate! (for other basic type invTranslte; or just basicType.invTranslate!)
        //String invStr = isNameTyped() ? typename.toString() : isBasicTyped() ? basictype.getName() : IsaToken.TRUE.toString();
        //sb.append(IsaToken.INV.toString() + invStr);
        if (isNameTyped())
        {
            sb.append(IsaToken.INV.toString());
            sb.append(typename.toString());
        }
        else 
        {
            sb.append(basictype.invTranslate());
        }
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseIsExpression(this, arg);
	}
}
