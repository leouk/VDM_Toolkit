package vdm2isa.tr.statements;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.statements.TCBlockStatement;

import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRBlockStatement extends TRSimpleBlockStatement
{
    public TRDefinitionList assignmentDefs;

    public TRBlockStatement(LexLocation location, TRIsaVDMCommentList comments,TCBlockStatement exp, TRType stmttype, TRStatementList statements, TRDefinitionList assignmentDefs)
    {
        super(location, comments, exp, stmttype, statements);
        this.assignmentDefs = assignmentDefs;
    }

    @Override
    public void setup(){
        super.setup();
        TRNode.setup(assignmentDefs);
    }

    @Override
    public String translate()
    {
        return assignmentDefs.translate() + super.translate();
    }

    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) 
    {
        return visitor.caseBlockStatement(this, arg);
    }

}
