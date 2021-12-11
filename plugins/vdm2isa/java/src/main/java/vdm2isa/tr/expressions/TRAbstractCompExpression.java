package vdm2isa.tr.expressions;

import java.util.concurrent.atomic.AtomicBoolean;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCDefinitionList;
import com.fujitsu.vdmj.tc.expressions.EnvTriple;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.visitors.TCGetFreeVariablesVisitor;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinition;
import vdm2isa.tr.expressions.visitors.TCGetFreeVariablesVisitorSet;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.patterns.TRMultipleBindList;
import vdm2isa.tr.types.TRType;

public abstract class TRAbstractCompExpression extends TRExpression {

    public final TRExpression first;
    public final TRMultipleBindList bindings;
    public final TRExpression predicate;
    public final TRDefinition def;

    public TRAbstractCompExpression(LexLocation location, TCExpression exp,
        TRExpression first, TRMultipleBindList bindings, 
        TRExpression predicate, TRDefinition def, TRType exptype) {
        super(location, exp, exptype);
        this.first = first;
        this.bindings = bindings;
        this.predicate = predicate; 
        this.def = def;
    }

    public TRAbstractCompExpression(LexLocation location, 
        TRExpression first, TRMultipleBindList bindings, 
        TRExpression predicate, TRDefinition def, TRType exptype) 
    {
        this(location, null, first, bindings, predicate, def, exptype);
    }

    @Override 
    public void setup()
    {
        super.setup();
        setFormattingSeparator(IsaToken.SPACE.toString());
        TRNode.setup(first, bindings, predicate, def);
        //System.out.println(toString());
    }

    protected boolean isSynthethic()
    {
        return def == null;
    }

    //TODO?!
    // @Override
    // public TRPatternListList getPatternListList() {
    //     TRPatternListList result = super.getPatternListList();
    //     result.addAll(first.getPatternListList());
    //     result.addAll(predicate.getPatternListList());
    //     bindings.
    //     return result;
    // }


    @Override
    public String toString()
    {
        return getClass().getSimpleName() + 
            "\n\t first = " + String.valueOf(first) + 
            "\n\t binds = " + String.valueOf(bindings) +
            "\n\t pred  = " + String.valueOf(predicate) +
            "\n\t def   = " + String.valueOf(def) +
            "\n\t loc   = " + String.valueOf(getLocation());
    }   
    
    @Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseCompExpression(this, arg);
	}

}
