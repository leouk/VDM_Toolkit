package annotations.tc;

import java.util.Iterator;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCStringLiteralExpression;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.statements.TCStatement;
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
		checkArgs(env, scope);
	}

    public static final boolean validIdentifier(String identifier)
    {
        //@NB what woudl be the best way to check for "valid" VDM identifiers? 
        return true;
    }


	private void checkArgs(Environment env, NameScope scope)
	{
		if (args.isEmpty())
		{
			name.report(6008, "@Theorem must start with an unique theorem name identifier (VDM string-literal) argument");
		}
		else
		{
            Iterator<TCExpression> eit = args.iterator();
            TCExpression e = eit.next();
            if (e instanceof TCStringLiteralExpression)
			{
                TCStringLiteralExpression strExpr = (TCStringLiteralExpression)e;
                if (!validIdentifier(strExpr.value.value))
                {
                    //@NB is this the right report number? 
                    strExpr.report(6008, "@Theorem name parameter must be valid Isabelle name idenfier");
                }
                else
                {
                    TCNameToken name = new TCNameToken(strExpr.location, strExpr.location.module, strExpr.value.value);
                    //@NB should this be GLOBAL or NAMES? 
                    TCDefinition d = env.findName(name, NameScope.GLOBAL);
                    if (d != null)
                    {
                        strExpr.report(6008, String.format("@Theorem name `%1$s` has already been defined", strExpr.value.value));
                    }
                    else 
                    {
                        while (eit.hasNext())
                        {
                            e = eit.next();
                            //@NB should this be NameScope.GLOBAL? Or which one? 
                            //    the theorem expr should type check as if it was defined
                            //    as a global boolean value
                            e.typeCheck(env, null, scope, null);	// Just checks scope
                        }    
                    }
                }				
			}
			else
			{
                name.report(6008, "@Theorem must start with an unique theorem name identifier (VDM string-literal) argument");
			}
		}
	}
}
