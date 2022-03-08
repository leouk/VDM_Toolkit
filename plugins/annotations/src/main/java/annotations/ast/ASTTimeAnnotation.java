/*******************************************************************************
 *	Author: Leo Freitas
 ******************************************************************************/

package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTTimeAnnotation extends ASTAnnotation
{
	private static final long serialVersionUID = 1L;

	public ASTTimeAnnotation(LexIdentifierToken name)
	{
		super(name);
	}
}
