package annotations.tc;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.NameScope;

public class TCQCExpandAnnotation extends TCAnnotation
{
	private static final long serialVersionUID = 1L;
	
	public TCQCExpandAnnotation(TCIdentifierToken name, TCExpressionList args)
	{
		super(name, args);
	}

	@Override
	public void tcBefore(TCExpression exp, Environment env, NameScope scope)
	{
		checkArgs(env, scope);
	}

	@Override
	public void tcBefore(TCStatement stmt, Environment env, NameScope scope)
	{
		checkArgs(env, scope);
	}

	private void checkArgs(Environment env, NameScope scope)
	{
		for (TCExpression arg: args)
		{
			arg.typeCheck(env, null, scope, null);	// Just checks scope
		}
	}

	@Override
	public void tcBefore(TCModule m)
	{
		name.report(6001, "@QCExpand does not apply to module definitions");
	}

	@Override
	public void tcBefore(TCClassDefinition m)
	{
		name.report(6001, "@QCExpand does not apply to class definitions");
	}
}
