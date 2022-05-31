package annotations.tc;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitOperationDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCSetEnumExpression;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.NameScope;

public class TCTheoremAttributeAnnotation extends TCAnnotation {

    public TCTheoremAttributeAnnotation(TCIdentifierToken name, TCExpressionList args) {
        super(name, args);
		assert args.size() >= 2; 
    }

	protected TCVariableExpression getDefName()
	{
		return (TCVariableExpression)args.get(0);
	}

	protected TCSetEnumExpression getDefSetEnum()
	{
		return (TCSetEnumExpression)args.get(1);
	}

	@Override
	public void tcBefore(TCDefinition def, Environment env, NameScope scope)
	{
        if (!Arrays.asList(/*NameScope.GLOBAL, NameScope.STATE,*/ NameScope.TYPENAME).contains(scope))
        {
            name.report(6009, "@TheoremAttribute only applies to global (state, type, fcns, ops) names");
        }
		else 
		{
			if (def instanceof TCTypeDefinition || def instanceof TCExplicitFunctionDefinition || def instanceof TCExplicitOperationDefinition)
			{
				TCDefinition d = env.findName(def.name, scope);
				if (!def.equals(d))
				{
					name.report(6009, String.format("@TheoremAttribute associated with wrong definition: \n\t expected %1$s;\n\t found %2$s", def, d));
				}
			} 
			else 
			{
				name.report(6009, "@TheoremAttribute only applies to type, function and operation definitions");
			}
		}
	}

	@Override
	public void tcBefore(TCModule module)
	{
		name.report(6009, "@TheoremAttribute only applies to top-level definitions, not modules");
	}

	@Override
	public void tcBefore(TCClassDefinition clazz)
	{
		name.report(6009, "@TheoremAttribute only applies to top-level definitions, not classes");
	}

	@Override
	public void tcBefore(TCExpression exp, Environment env, NameScope scope)
	{
		TCDefinition d = env.findName(getDefName().name, scope);
		if (d == null)
		{
			name.report(6009, String.format("@TheoremAttribute could not find definition for %1$s", getDefName().name));
		}
		else if (d instanceof TCExplicitFunctionDefinition)
		{
			TCExplicitFunctionDefinition edef = (TCExplicitFunctionDefinition)d;
			if (!edef.body.equals(exp))
			{
				name.report(6009, String.format("@TheoremAttribute only applies to pre/post/inv/eq/ord definitions: \n\tgiven %1$s", edef.body));
			}
		}
		else
		{
			name.report(6009, "@TheoremAttribute only applies to explicit function expressions");
		}
	}

	@Override
	public void tcBefore(TCStatement stmt, Environment env, NameScope scope)
	{
		name.report(6009, "@TheoremAttribute only applies to top-level definitions, not statements");
	}
}
