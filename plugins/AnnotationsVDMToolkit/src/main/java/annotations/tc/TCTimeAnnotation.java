/*******************************************************************************
 *	Author: Leo Freitas
 ******************************************************************************/
 
package annotations.tc;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCStringLiteralExpression;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.NameScope;

public class TCTimeAnnotation extends TCAnnotation
{
	private static final long serialVersionUID = 1L;

	public TCTimeAnnotation(TCIdentifierToken name, TCExpressionList args)
	{
		super(name, args);
	}

	@Override
	public void tcBefore(TCDefinition def, Environment env, NameScope scope)
	{
		name.report(6009, "@Time only applies to statements and expressions");
	}

	@Override
	public void tcBefore(TCModule module)
	{
		name.report(6009, "@Time only applies to statements and expressions");
	}

	@Override
	public void tcBefore(TCClassDefinition clazz)
	{
		name.report(6009, "@Time only applies to statements and expressions");
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
		if (args.isEmpty())
		{
			name.report(6008, "@Time must start with a string argument");
		}
		else
		{
			if (args.get(0) instanceof TCStringLiteralExpression)
			{
				for (TCExpression arg: args)
				{
					arg.typeCheck(env, null, scope, null);	// Just checks scope
				}
				
				TCStringLiteralExpression str = (TCStringLiteralExpression)args.get(0);
				String format = str.value.value;
				
				int timeParamIndex = format.indexOf("%1s");
				if (timeParamIndex == -1)
				{
                    try
                    {
                        // Try to format with string arguments to check they are all %s (up to 20)
                        Object[] args = new String[20];
                        Arrays.fill(args, "A string");
                        String.format(format, args);
                    }
                    catch (IllegalArgumentException e)
                    {
                        name.report(6008, "@Time must use %[arg$][width]s conversions starting from %2s");
                    }
                }
                else
                {
                    name.report(6008, "@Time format string must not contain %1s in it");
                }
			}
			else
			{
				name.report(6008, "@Time must start with a string argument");
			}
		}
	}
}
