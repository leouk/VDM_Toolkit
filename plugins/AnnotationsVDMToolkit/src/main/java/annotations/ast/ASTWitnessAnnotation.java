package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.expressions.ASTExpression;
import com.fujitsu.vdmj.ast.expressions.ASTExpressionList;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;
import com.fujitsu.vdmj.config.Properties;
import com.fujitsu.vdmj.lex.LexException;
import com.fujitsu.vdmj.lex.LexTokenReader;
import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.syntax.ExpressionReader;
import com.fujitsu.vdmj.syntax.ParserException;

public class ASTWitnessAnnotation extends ASTAnnotation
{
	private static final long serialVersionUID = 1L;

	public ASTWitnessAnnotation(LexIdentifierToken name)
	{
		super(name);
	}

	// /**
	//  * Override the default parse, and look for @TheoremAttribute <name> = <set-enum>;
	//  */
	// @Override
	// public ASTExpressionList parse(LexTokenReader ltr) throws LexException, ParserException
	// {
	// 	ASTExpressionList args = new ASTExpressionList();
	
	// 	if (ltr.nextToken().is(Token.BRA))
	// 	{
	// 		if (ltr.nextToken().isNot(Token.KET))
	// 		{
	// 			//@NB perhaps this could inner bit could be a method in ASTAnnotation?
	// 			ExpressionReader er = new ExpressionReader(ltr);
	// 			Properties.annotations_debug = true;
	// 			ASTExpression exp = er.readExpression();
	// 			args.add(er.readExpression());
		
	// 			while (ltr.getLast().is(Token.COMMA))
	// 			{
	// 				ltr.nextToken();
	// 				args.add(er.readExpression());
	// 			}
	// 		}
	
	// 		if (ltr.getLast().isNot(Token.KET))
	// 		{
	// 			parseException("Expecting ')' after annotation", ltr.getLast().location);
	// 		}
	// 	}
	// 	return args;
	// }
}
