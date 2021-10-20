package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRRecordType;

public class TRTypeDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;

    private final TCNameToken name;
    private final TRInvariantType type;
    private final TRExpression invExpr;

    public TRTypeDefinition(TCAnnotationList annotations, TCNameToken name, TRInvariantType type, TRExpression invExpression)
    {
        super(null, annotations);
        this.name = name;
        this.type = type;
        this.invExpr = invExpression;
    }

    @Override 
    public String translate()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(super.translate());
        if (type instanceof TRRecordType)
            sb.append(type.translate());
        return sb.toString();
    }
}
