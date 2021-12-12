package vdm2isa.tr.annotations;

import com.fujitsu.vdmj.tc.annotations.TCNoAnnotation;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

import vdm2isa.tr.expressions.TRExpressionList;

public class TRNoAnnotation extends TRAnnotation {

    public TRNoAnnotation(TCNoAnnotation annotation, TCIdentifierToken name, TRExpressionList args) {
        super(annotation, name, args);
    }
}
