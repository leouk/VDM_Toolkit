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
        if (!Arrays.asList(/*NameScope.GLOBAL, NameScope.STATE, NameScope.TYPENAME, */NameScope.NAMES).contains(scope))
        {
            name.report(6601, String.format("@TheoremAttribute name scope error. It applies to global (state, type, fcns, ops) names only \n\t name %1$s scope %2$s\n", getDefName().name, scope));
        }
		else 
		{
			//@NB TCTypeDefinition env.findName fails, despite the name being there? 
			if (/*def instanceof TCTypeDefinition || */def instanceof TCExplicitFunctionDefinition || def instanceof TCExplicitOperationDefinition)
			{
				TCDefinition d = env.findName(def.name, scope);
				if (!def.equals(d))
				{
					name.report(6601, String.format("@TheoremAttribute associated with wrong definition name %1$s: \n\t expected %2$s;\n\t found %3$s\n", getDefName(), def, d));
				}
			} 
			else 
			{
				name.report(6600, "@TheoremAttribute only applies to type, function and operation definitions\n");
			}
		}
	}

	@Override
	public void tcBefore(TCModule module)
	{
		name.report(6600, "@TheoremAttribute only applies to top-level definitions, not modules\n");
	}

	@Override
	public void tcBefore(TCClassDefinition clazz)
	{
		name.report(6600, "@TheoremAttribute only applies to top-level definitions, not classes\n");
	}

	@Override
	public void tcBefore(TCExpression exp, Environment env, NameScope scope)
	{
		TCDefinition d = env.findName(getDefName().name, scope);
		if (d == null)
		{
			name.report(6003, String.format("@TheoremAttribute could not find definition for %1$s\n", getDefName().name));
		}
		else if (d instanceof TCExplicitFunctionDefinition)
		{
			TCExplicitFunctionDefinition edef = (TCExplicitFunctionDefinition)d;
			// declared name must match 
			if (!edef.name.matches(getDefName().name))
			{
				name.report(6004, String.format("@TheoremAttribute only applies to pre/post/inv/eq/ord definitions: \n\tname %1$s yet given %2$s\n", getDefName(), edef.name));
			}
			// declared expression must match so that the name is indeed attached to write body being translated
			else if (!edef.body.equals(exp))
			{
				name.report(6004, String.format("@TheoremAttribute only applies to pre/post/inv/eq/ord definitions: \n\tgiven %1$s\n", edef.body));
			}
		}
		else
		{
			name.report(6000, "@TheoremAttribute only applies to explicit function expressions\n");
		}
	}

	@Override
	public void tcBefore(TCStatement stmt, Environment env, NameScope scope)
	{
		name.report(6000, "@TheoremAttribute only applies to top-level definitions, not statements\n");
	}
}
