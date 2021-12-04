package vdm2isa.tr.expressions.visitors;

import com.fujitsu.vdmj.tc.TCVisitorSet;
import com.fujitsu.vdmj.tc.expressions.EnvTriple;
import com.fujitsu.vdmj.tc.lex.TCNameSet;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.patterns.visitors.TCGetFreeVariablesBindVisitor;
import com.fujitsu.vdmj.tc.patterns.visitors.TCGetFreeVariablesMultipleBindVisitor;

public class TCGetFreeVariablesVisitorSet extends TCVisitorSet<TCNameToken, TCNameSet, EnvTriple>
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
        this.definitionVisitor = new com.fujitsu.vdmj.tc.definitions.visitors.TCGetFreeVariablesVisitor();
        //this.definitionVisitor.visitorSet = this;
        this.expressionVisitor = new com.fujitsu.vdmj.tc.expressions.visitors.TCGetFreeVariablesVisitor(this);
        this.statementVisitor = null;//new com.fujitsu.vdmj.tc.statements.visitors.TCGetFreeVariablesVisitor(this);
        this.patternVisitor = null;//new com.fujitsu.vdmj.tc.patterns.visitors.TCGetFreeVariablesVisitor(this);
        this.typeVisitor = new com.fujitsu.vdmj.tc.types.visitors.TCGetFreeVariablesVisitor(this);
        this.bindVisitor = new TCGetFreeVariablesBindVisitor(this);
        this.multiBindVisitor = new TCGetFreeVariablesMultipleBindVisitor(this); 
    }

    @Override
    protected TCNameSet newCollection() 
    {
        return new TCNameSet();
    }

}
