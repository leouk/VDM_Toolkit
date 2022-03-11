package annotations.tc;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCVariableExpression;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.NameScope;

/**
 * This annotation represents a global boolean value to be issued as a proof
 * obligation during POG. This is useful for users wanting to state theorems 
 * about their VDM models. The first parameter must be a string literal containing 
 * a valid identifier (for the theorem name), followed by a boolean-typed expression 
 * for the theorem that is type-checkable. The theorem name must be a new global name.    
 */
public class TCTheoremAnnotation extends TCAnnotation {

    private static final long serialVersionUID = 1L;

    public TCTheoremAnnotation(TCIdentifierToken name, TCExpressionList args) {
        super(name, args);
    }
    
    @Override
	public void tcBefore(TCModule module)
	{
		name.report(6009, "@Theorem can only appear at top-level definitions.");
	}

	@Override
	public void tcBefore(TCClassDefinition clazz)
	{
		name.report(6009, "@Theorem can only appear at top-level definitions.");
	}

	@Override
	public void tcBefore(TCExpression exp, Environment env, NameScope scope)
	{
		name.report(6009, "@Theorem can only appear at top-level definitions.");
	}

	@Override
	public void tcBefore(TCStatement stmt, Environment env, NameScope scope)
	{
		name.report(6009, "@Theorem can only appear at top-level definitions.");
	}

    @Override
	public void tcBefore(TCDefinition def, Environment env, NameScope scope)
	{
		//checkArgs(env, scope);
	}

    @Override
	public void tcAfter(TCDefinition def, TCType type, Environment env, NameScope scope)
	{
		checkArgs(env, scope);
	}

	private void checkArgs(Environment env, NameScope scope)
	{
		if (args.isEmpty())
		{
			name.report(6008, "@Theorem must start with an unique theorem name identifier argument");
		}
        // else if (args.size() > 2)
        // {
        //     name.report(6008, "@Theorem must contain exactly two arguments: the theorem name and its defining predicate");
        // }
		else
		{
            TCExpression e = args.get(0);
            if (e instanceof TCVariableExpression)
			{
                TCVariableExpression varExpr = (TCVariableExpression)e;
                //TCNameToken name =new TCNameToken(strExpr.location, strExpr.location.module, strExpr.value.value);
                //@NB should this be GLOBAL or NAMES? 
                TCDefinition d = env.findName(varExpr.name, NameScope.NAMESANDSTATE);
                if (d != null)
                {
                    varExpr.report(6008, String.format("@Theorem name `%1$s` has already been defined", varExpr.name.toString()));
                }
                else 
                {
                    for(int i = 1; i < args.size(); i++)
                    {
                        //@NB should this be NameScope.GLOBAL? Or which one? 
                        //    the theorem expr should type check as if it was defined
                        //    as a global boolean value
                        args.get(i).typeCheck(env, null, scope, null);	// Just checks scope
                    }    
                }				
			}
			else
			{
                name.report(6008, "@Theorem must start with an unique theorem name identifier argument");
			}
		}
	}
}
