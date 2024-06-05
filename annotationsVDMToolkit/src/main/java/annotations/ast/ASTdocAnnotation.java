package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTdocAnnotation extends ASTAnnotation {

    public ASTdocAnnotation(LexIdentifierToken name) {
        super(name);
    }
    
    // /**
	//  * Override the default parse, and look for @TheoremAttribute <name> = <exp>;
	//  */
	// @Override
	// public ASTExpressionList parse(LexTokenReader ltr) throws LexException, ParserException
	// {
	// 	ltr.nextToken();
	// 	ASTExpressionList args = new ASTExpressionList();
	// 	ExpressionReader er = new ExpressionReader(ltr);
	// 	ASTExpression exp = er.readExpression();
		
	// 	if (exp instanceof ASTEqualsExpression)		// Should parse as an equals expression
	// 	{
	// 		ASTEqualsExpression eqexp = (ASTEqualsExpression)exp;
			
	// 		if (eqexp.left instanceof ASTVariableExpression)
	// 		{
	// 			args.add(eqexp.left);
	// 			args.add(eqexp.right);
	// 		}
	// 		else
	// 		{
	// 			//parseException("expecting <name> = <exp>;", eqexp.location);
	// 		}
	// 	}
	// 	else
	// 	{
	// 		//parseException("expecting <name> = <exp>;", exp.location);
	// 	}
		
	// 	if (ltr.getLast().isNot(Token.SEMICOLON))
	// 	{
	// 		//parseException("missing ;", ltr.getLast().location);
	// 	}
		
	// 	return args;
	// }
}
