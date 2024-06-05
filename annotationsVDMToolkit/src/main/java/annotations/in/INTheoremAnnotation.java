package annotations.in;

import com.fujitsu.vdmj.in.annotations.INAnnotation;
import com.fujitsu.vdmj.in.expressions.INExpression;
import com.fujitsu.vdmj.in.expressions.INExpressionList;
import com.fujitsu.vdmj.messages.Console;
import com.fujitsu.vdmj.runtime.Context;
import com.fujitsu.vdmj.runtime.ContextException;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.values.Value;

public class INTheoremAnnotation extends INAnnotation {

    public INTheoremAnnotation(TCIdentifierToken name, INExpressionList args) {
        super(name, args);
    }

    @Override
    protected void doInit(Context ctxt)
    {
        INExpression e = args.get(0);
        Console.out.print("Attempting proof by symbolic execution for @" + name.getName() + 
            " " + e.toString() + " in " + e.getLocation().module + " " + args.get(0).getLocation().toShortString());
        for(int i = 1; i < args.size(); i++)
        {
            try 
            {
                Value v = args.get(i).eval(ctxt);
                Console.out.println("\t= " + v.toString());
            }
            catch (ContextException t)
            {
                // not executable
                Console.out.println("\t= theorem is not executable");
            }
        }

    }
}
