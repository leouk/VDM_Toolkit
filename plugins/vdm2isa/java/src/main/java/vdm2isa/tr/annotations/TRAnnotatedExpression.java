package vdm2isa.tr.annotations;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotatedExpression;
import com.fujitsu.vdmj.tc.annotations.TCAnnotation;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRType;

public class TRAnnotatedExpression extends TRExpression {

    public final TRAnnotation annotation;
    public final TRExpression expression; 

    public TRAnnotatedExpression(LexLocation location, TCAnnotatedExpression exp, 
        TRAnnotation annotation, TRExpression expression, TRType exptype) {
        super(location, exp, exptype);
        this.annotation = annotation;
        this.expression = expression;
    }

    public TRAnnotatedExpression(LexLocation location, TCAnnotatedExpression exp, 
        TCAnnotation annotation, TRExpression expression, TRType exptype) {
        super(location, exp, exptype);
        this.annotation = null;//TODO! 
        this.expression = expression;
    }

    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(annotation, expression);
    }

    @Override
    public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg) {
        return visitor.caseAnnotatedExpression(this, arg);
    }

    @Override
    public IsaToken isaToken() {
        return expression.isaToken();
    }

    @Override
    public String translate() {
        return expression.translate();
    }
    
}
