package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCStateDefinition;
import com.fujitsu.vdmj.tc.definitions.TCTypeDefinition;
import com.fujitsu.vdmj.tc.lex.TCNameList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.annotations.TRAnnotationList;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

public class TRStateDefinition extends TRAbstractTypedDefinition {

    private final TRPattern initPattern;
    private final TRExpression initExpression;
    private final TRExplicitFunctionDefinition initdef;
    private final TRDefinitionList statedefs;
    private final boolean canBeExecuted;
    private final TRRecordType recordType;

    public TRStateDefinition(
        // all those belong to TRDefinition
        TCStateDefinition definition, 
        LexLocation location, 
        TRIsaVDMCommentList comments,
        TRAnnotationList annotations, 
        TCNameToken name, NameScope nameScope, boolean used, boolean excluded, 
        // this to abstract typed def; here is a record type instead
        TRRecordType recordType,

        // will keep it simple and rely on the TRRecordType structure for the TCStateDefinition 
        // correspondent that will work nicely, given the record translation
        TRPattern initPattern,
        TRExpression initExpression, 
        TRExplicitFunctionDefinition initdef, 
        //TRDefinitionList statedefs, 
        boolean canBeExecuted  
        ) 
    {
        super(definition, location, comments, annotations, name, nameScope, used, excluded, recordType);
        this.initPattern = initPattern;
        this.initExpression = initExpression;
        this.initdef = initdef;
        this.statedefs = null;//statedefs; 
        this.canBeExecuted = canBeExecuted; 
        // see similar exmaple in TRMapType etc. 
        this.recordType = recordType;   // super.type = this.recordType; needed for TR mapping 
    }

    @Override
    public void setup()
    {
        super.setup();
        // anything specific to check?
        // * look into TRTypeDefinition for implicitly creating init expression if empty
        // * need to worry about state invariant implicit check see TRTypeDefinition for it  
        // * arguably you could perhaps think of extending TRTypeDefinition 

        TRNode.setup(recordType, initPattern, initExpression, initdef, statedefs);
    }

    @Override 
    public String toString()
    {
        return "SteteDef = " + 
            "...";
    }

    @Override
    public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg) {
        return visitor.createStateDefinition(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override 
    public String translate()
    {
        return "STATE! = " + super.translate();
    }
}
