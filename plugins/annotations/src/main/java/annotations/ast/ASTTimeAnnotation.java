/*******************************************************************************
 *	Author: Leo Freitas
 ******************************************************************************/

package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTTimeAnnotation extends ASTAnnotation
{
	public ASTTimeAnnotation(LexIdentifierToken name)
	{
		super(name);
	}
}
