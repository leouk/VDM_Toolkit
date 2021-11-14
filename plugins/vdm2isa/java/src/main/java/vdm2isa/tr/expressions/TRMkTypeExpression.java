package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRFieldList;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;

public class TRMkTypeExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    protected final TCNameToken typename;
    private final TRFieldList fields; 
    private final TRExpressionList args;

    public TRMkTypeExpression(TCNameToken typename, TRExpressionList args, TRType exptype)
    {
        super(typename.getLocation(), exptype);
        //this.typename = typename;
        this.args = args;
        this.typename = typename;
        this.fields = TRRecordType.fieldsOf(typename);
        if (this.fields == null)
            report(IsaErrorMessage.ISA_RECORD_EARLYUSE_1P, typename.toString());
        else if (this.fields.size() != this.args.size())
            report(IsaErrorMessage.VDMSL_INVALID_MKARGS_3P, typename.toString(), args.size(), fields.size()); 
        else if (this.args.size() == 0)
            report(IsaErrorMessage.ISA_NO_EMPTYRECORD_1P, typename.toString());
    }

    @Override 
    protected TRType getBestGuessType()
    {
        return TRRecordType.recordTypeFor(typename);
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.RECORD;
    }

    protected String translateField(int index)
    {
        assert index >= 0 && index < this.fields.size(); 
        StringBuilder sb = new StringBuilder();
        sb.append(this.fields.get(index).getIsabelleTagName());
        sb.append(" ");
        sb.append(IsaToken.EQUALS.toString());
        sb.append(" ");
        sb.append(this.args.get(index).translate());
        return sb.toString();
    }

    @Override
    public String translate() {
        assert this.fields.size() == this.args.size();
        String separator = IsaToken.COMMA.toString() + " ";
        StringBuilder sb = new StringBuilder();
        sb.append(IsaToken.LRECORD.toString());
        sb.append(translateField(0));
        for (int i = 1; i < fields.size(); i++)
        {
            sb.append(separator);
            sb.append(translateField(i));
        }
        sb.append(IsaToken.RRECORD.toString());
        return sb.toString(); 
    }

    

	@Override
	public <R, S> R apply(TRExpressionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMkTypeExpression(this, arg);
	}
}
