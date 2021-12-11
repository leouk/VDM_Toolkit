package vdm2isa.tr.annotations;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpressionList;

public class TRAnnotation extends TRNode {

    public final TCIdentifierToken name;
    public final TRExpressionList args;
    private final TCAnnotation annotation;

    protected TRAnnotation(TCAnnotation annotation, TCIdentifierToken name, TRExpressionList args) {
        super(name != null ? name.getLocation() : LexLocation.ANY);
        this.annotation = annotation;
        this.name = name;
        this.args = args;
    }

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(args);
    }

    public TCAnnotation getVDMAnnotation()
    {
        return annotation;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    @Override
    public String translate() {
        return "null";
    }
    
}
