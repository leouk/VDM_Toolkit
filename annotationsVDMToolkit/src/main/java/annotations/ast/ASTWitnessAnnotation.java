package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTWitnessAnnotation extends ASTAnnotation
{
	private static final long serialVersionUID = 1L;

	public ASTWitnessAnnotation(LexIdentifierToken name)
	{
		super(name);
	}
}
