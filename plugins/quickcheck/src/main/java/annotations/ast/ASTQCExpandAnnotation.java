package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTQCExpandAnnotation extends ASTAnnotation
{
	private static final long serialVersionUID = 1L;
	
	public ASTQCExpandAnnotation(LexIdentifierToken name)
	{
		super(name);
	}
}
