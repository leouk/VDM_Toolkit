package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTWitnessAnnotation extends ASTAnnotation
{
	public ASTWitnessAnnotation(LexIdentifierToken name)
	{
		super(name);
	}
}
