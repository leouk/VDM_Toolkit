package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.expressions.ASTEqualsExpression;
import com.fujitsu.vdmj.ast.expressions.ASTExpression;
import com.fujitsu.vdmj.ast.expressions.ASTExpressionList;
import com.fujitsu.vdmj.ast.expressions.ASTSetEnumExpression;
import com.fujitsu.vdmj.ast.expressions.ASTVariableExpression;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;
import com.fujitsu.vdmj.lex.LexException;
import com.fujitsu.vdmj.lex.LexTokenReader;
import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.syntax.ExpressionReader;
import com.fujitsu.vdmj.syntax.ParserException;

/**
 * @TheoremAttribute(ThmName = {XYZ, ABC, etc.};)
 */
public class ASTTheoremAttributeAnnotation extends ASTAnnotation {

    private static final long serialVersionUID = 1L;

    public ASTTheoremAttributeAnnotation(LexIdentifierToken name) {
        super(name);
    }
    
    /**
	 * Override the default parse, and look for @TheoremAttribute <name> = <set-enum>;
	 */
	@Override
	public void parse(LexTokenReader ltr) throws LexException, ParserException
	{
		this.args = new ASTExpressionList();
		
		ltr.nextToken();
		ExpressionReader er = new ExpressionReader(ltr);
		ASTExpression exp = er.readExpression();
		
		if (exp instanceof ASTEqualsExpression)		//Should parse as an equals expression
		{
			ASTEqualsExpression eqexp = (ASTEqualsExpression)exp;
			
			if (eqexp.left instanceof ASTVariableExpression)
			{
				args.add(eqexp.left);
				if (eqexp.right instanceof ASTSetEnumExpression)
				{
					args.add(eqexp.right);
				}
				else 
				{
					parseException("expecting <name> = <set-enum>", eqexp.right.location);
				}
			}
			else
			{
				parseException("expecting <name> = <set-enum>;", eqexp.left.location);
			}
		}
		else
		{
			parseException("expecting <name> = <set-enum>;", exp.location);
		}
		
		if (ltr.getLast().isNot(Token.SEMICOLON))
		{
			parseException("missing ;", ltr.getLast().location);
		}
	}
}
