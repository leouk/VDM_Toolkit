package vdm2isa.tr.expressions.visitors;

import com.fujitsu.vdmj.tc.TCVisitorSet;
import com.fujitsu.vdmj.tc.expressions.visitors.TCFreeVariableExpressionVisitor;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.patterns.visitors.TCFreeVariableBindVisitor;
import com.fujitsu.vdmj.tc.patterns.visitors.TCFreeVariableMultipleBindVisitor;
import com.fujitsu.vdmj.tc.types.visitors.TCFreeVariableTypeVisitor;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.tc.definitions.visitors.TCFreeVariableDefinitionVisitor;

public class TCGetFreeVariablesVisitorSet extends TCVisitorSet<TCNameToken, TCNameSet, Environment>
{
    public TCGetFreeVariablesVisitorSet()
    {
        super();
    }

    @Override
    protected void setVisitors() 
    {
        // ExprVisitor
        // MultiBindVisitor
        //      TypeVisitor
        //      ExprVisitor
        // BindVisitor
        // DefVisitor
        // PatternVisitor
        this.definitionVisitor = new TCFreeVariableDefinitionVisitor(this);
        this.expressionVisitor = new TCFreeVariableExpressionVisitor(this);
        this.statementVisitor = null;//new TCFreeVariableStatementVisitor(this);
        this.patternVisitor = null;//new TCFreeVariablePatternVisitor(this);
        this.typeVisitor = new TCFreeVariableTypeVisitor();//(this);?
        this.bindVisitor = new TCFreeVariableBindVisitor(this);
        this.multiBindVisitor = new TCFreeVariableMultipleBindVisitor(this); 
    }

    @Override
    protected TCNameSet newCollection() 
    {
        return new TCNameSet();
    }

}
