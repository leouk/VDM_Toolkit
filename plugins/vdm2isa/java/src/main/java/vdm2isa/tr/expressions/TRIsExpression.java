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
        System.out.println(toString());
    }

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
        String invStr = isBasicTyped() ? basictype.getName() : isNameTyped() ? typename.toString() : IsaToken.TRUE.toString();
        sb.append(IsaToken.INV.toString() + invStr);
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseIsExpression(this, arg);
	}
}
