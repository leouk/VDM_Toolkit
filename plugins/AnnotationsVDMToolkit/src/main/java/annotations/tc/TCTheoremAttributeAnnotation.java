package annotations.tc;

import java.util.Arrays;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.NameScope;

public class TCTheoremAttributeAnnotation extends TCAnnotation {

    public TCTheoremAttributeAnnotation(TCIdentifierToken name, TCExpressionList args) {
        super(name, args);
    }

    @Override
	public void tcBefore(TCDefinition def, Environment env, NameScope scope)
	{
        // if (!Arrays.asList(NameScope.GLOBAL, NameScope.STATE, NameScope.TYPENAME).contains(scope))
        // {
        //     name.report(6009, "@TheoremAttribute only applies to global (state, type, fcns, ops) names");
        // }
        //@NB should this be findMatches or findName? From TCVariableExperssion.typeCheck, seems to be findName?
        //else if (env.findMatches(def.name))
        {
            env.findMatches(def.name);
        };
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
		TCDefinition d = env.findName(((TCVariableExpression)this.args.get(0)).name, scope);
		if (d == null)
		{
		}
		else if (d instanceof TCExplicitFunctionDefinition)
		{
			TCExplicitFunctionDefinition edef = (TCExplicitFunctionDefinition)d;
			boolean r = edef.body.equals(exp);
		}
		name.report(6009, "@TheoremAttribute only applies to top-level definitions, not expressions");
	}

	@Override
	public void tcBefore(TCStatement stmt, Environment env, NameScope scope)
	{
		name.report(6009, "@TheoremAttribute only applies to top-level definitions, not statements");
	}
}
