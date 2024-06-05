package annotations.po;

import com.fujitsu.vdmj.po.annotations.POAnnotation;
import com.fujitsu.vdmj.po.expressions.POExpressionList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

public class POQCExpandAnnotation extends POAnnotation
{
	private static final long serialVersionUID = 1L;
	
	public POQCExpandAnnotation(TCIdentifierToken name, POExpressionList args)
	{
		super(name, args);
	}
}
