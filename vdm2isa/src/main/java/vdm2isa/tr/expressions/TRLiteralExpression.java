/*******************************************************************************
 *	Copyright (c) 2020 Leo Freitas.
 ******************************************************************************/

package vdm2isa.tr.expressions;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

import com.fujitsu.vdmj.ast.lex.LexBooleanToken;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.tc.expressions.TCBooleanLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCCharLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCIntegerLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCQuoteLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCRealLiteralExpression;
import com.fujitsu.vdmj.tc.expressions.TCStringLiteralExpression;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRQuoteType;
import vdm2isa.tr.types.TRType;

public class TRLiteralExpression extends TRExpression
{
	private static final long serialVersionUID = 1L;
	public final IsaToken token;
	public final String exp;

	public static final Set<IsaToken> VALID_LITERAL_TOKENS = new HashSet<IsaToken>(
		Arrays.asList(IsaToken.BOOL, IsaToken.CHAR, IsaToken.NAT, IsaToken.NAT1, IsaToken.INT, 
					  IsaToken.RAT, IsaToken.REAL, IsaToken.STRING, IsaToken.VDMQUOTE));

	public static final Set<IsaToken> TYPED_LITERALS = new HashSet<IsaToken>(
        Arrays.asList(IsaToken.BOOL, IsaToken.CHAR, IsaToken.NAT, IsaToken.NAT1, 
					  IsaToken.INT));

	protected TRLiteralExpression(LexLocation location, TCExpression tc, IsaToken token, String exp, TRType exptype)
	{
		super(location, tc, exptype);
		this.token = token;
		this.exp = exp; 
	}

	public TRLiteralExpression(TCBooleanLiteralExpression exp, TRType exptype)
	{
		this(exp != null ? exp.location : null, exp, IsaToken.BOOL, 
			exp != null ? 
				exp.value != null ? 
					exp.value.value ? IsaToken.TRUE.toString() : 
									  IsaToken.FALSE.toString() 
								: IsaToken.FALSE.toString()
				 	: IsaToken.FALSE.toString(), exptype);
	}

	public TRLiteralExpression(TCCharLiteralExpression exp, TRType exptype)
	{
		this(exp != null ? exp.location : null, exp, IsaToken.CHAR, 
			IsaToken.ISACHAR.toString() + IsaToken.SPACE.toString() + 
			IsaToken.bracketit(IsaToken.ISASTR, String.valueOf(exp), IsaToken.ISASTR), exptype);
	}

	public TRLiteralExpression(TCIntegerLiteralExpression exp, TRType exptype)
	{
		this(exp != null ? exp.location : null, exp, exp != null ? exp.value != null ? 
			exp.value.value >= 0 ? (exp.value.value > 0 ? IsaToken.NAT1 : IsaToken.NAT) : IsaToken.INT : IsaToken.INT : IsaToken.INT, 
			String.valueOf(exp), exptype);
	}
	
	public TRLiteralExpression(TCRealLiteralExpression exp, TRType exptype)
	{
		this(exp != null ? exp.location : null, exp, exp != null ? exp.value != null ? exp.value.type.equals(Token.RAT) ? 
			IsaToken.RAT : IsaToken.REAL : IsaToken.REAL : IsaToken.REAL, String.valueOf(exp), exptype);		
	}

	public TRLiteralExpression(TCStringLiteralExpression exp, TRType exptype)
	{
		this(exp != null ? exp.location : null, exp, IsaToken.STRING, 
																// remove the quotes from "xxx" -> xxxx; 		assert exp.toString().length() > 1;
			IsaToken.bracketit(IsaToken.ISASTR, 
				exp != null ? exp.value != null ? exp.value.value : 
					"null" : "null", //exp.toString().substring(1, exp.toString().length() - 1), 
								IsaToken.ISASTR), exptype); 
	}

	public TRLiteralExpression(TCQuoteLiteralExpression exp, TRType exptype)
	{
		this(exp != null ? exp.location : null, exp, IsaToken.VDMQUOTE, exp != null ? exp.type != null ? exp.type.value : "null" : "null", exptype);
	}

	@Override 
	public void setup()
	{
		super.setup();
		// put in setup or here is fine. 
		if (!VALID_LITERAL_TOKENS.contains(this.token))
			report(IsaErrorMessage.ISA_TOKEN_ERROR_1P, token.toString());		
	}

	@Override
	public String translate()
	{
		TRType t = getType();
		// no casting needed for real, string, quote literals
		// avoid casting altogether to avoid confusion like s: set of real = {1,2,3} getting {1::VDMInt,...} but then have isabelle convert between int=>real!
		// nah, needs it for numeric expressions :-*
		String typeStr = TYPED_LITERALS.contains(token) ? IsaToken.TYPEOF.toString() + isaToken().toString() : "";
		// actually will never be optional for the literal, but variables? 
		return t instanceof TROptionalType ?
			IsaToken.parenthesise(IsaToken.OPTIONAL_SOME.toString() + IsaToken.parenthesise(exp + typeStr)) : 
			t instanceof TRQuoteType ? TRQuoteType.quoteLiteral(exp, (TRQuoteType)t) : 
			IsaToken.parenthesise(exp + typeStr);//exp
	}

	@Override 
	public String invTranslate()
	{
		TRType t = getType();
		String varName = translate();
		return t.invTranslate(varName);
	}

	@Override 
	protected TRType getBestGuessType()
	{
		// TRType result;
		// switch (isaToken())
		// {
		// 	case BOOL:
		// 	case CHAR:
		// 	case NAT:
		// 	case NAT1:
		// 	case INT:
		// 	case RAT:
		// 	case REAL:
		// 		result = TRBasicType.newBasicType(location, token);
		// 		break;
			
		// 	case STRING:
		// 		result = TRSeqType.newSeqType(location, TRBasicType.charType(location), !exp.isEmpty());
		// 		break;

		// 	case VDMQUOTE:	
		// 		result = TRQuoteType.newQuoteType(location, exp);
		// 		break;
			
		// 	default:
		// 		result = super.getType();
		// 		break;
		// }
		//TRNode.setup(result);
		return super.getType();
	}

	@Override
	public IsaToken isaToken() 
	{
		return token;
	}

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseLiteralExpression(this, arg);
	}

	public static final TRLiteralExpression newBooleanLiteralExpression(LexLocation l, boolean v)
	{
		assert l != null;
		return new TRLiteralExpression(
			new TCBooleanLiteralExpression(
				new LexBooleanToken(v ? Token.TRUE : Token.FALSE, l)), TRBasicType.boolType(l));
	}
}
