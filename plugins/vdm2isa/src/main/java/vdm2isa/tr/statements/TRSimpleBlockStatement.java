package vdm2isa.tr.statements;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.statements.TCSimpleBlockStatement;
import com.fujitsu.vdmj.tc.statements.TCStatement;

import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.types.TRType;

public abstract class TRSimpleBlockStatement extends TRStatement {
    public TRStatementList statements;

    public TRSimpleBlockStatement(LexLocation location, TRIsaVDMCommentList comments, TCSimpleBlockStatement exp, TRType stmttype, TRStatementList statements)
	{
		super(location, comments, (TCStatement)exp, stmttype);
		this.statements = statements;
	}

    @Override
    public void setup(){
        super.setup();
        TRNode.setup(statements);
    }

    @Override
    public String oldtranslate()
    {
        return statements.oldtranslate();
    }
}
