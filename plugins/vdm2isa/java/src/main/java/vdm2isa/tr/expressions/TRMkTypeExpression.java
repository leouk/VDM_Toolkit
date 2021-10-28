package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.TypeChecker;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRFieldList;
import vdm2isa.tr.types.TRRecordType;

public class TRMkTypeExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    //private final TCNameToken typename;
    private final TRFieldList fields; 
    private final TRExpressionList args;

    public TRMkTypeExpression(TCNameToken typename, TRExpressionList args)
    {
        super(typename.getLocation());
        //this.typename = typename;
        this.args = args;
        this.fields = TRRecordType.fieldsOf(typename);
        if (this.fields == null)
            report(10005, "Record type " + typename.toString() + " has not been translated yet; couldn't find its fields.");
        else if (this.fields.size() != this.args.size())
            report(10006, "Invalid record arguments: incompatible number of fields for VDM mk_" + typename.toString() + " expression.");
        else if (this.args.size() == 0)
            report(10007, "Isabelle does not allow empty records for VDM mk_" + typename.toString() + " expression.");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.EOF;
    }

    protected String translateField(int index)
    {
        assert index >= 0 && index < this.fields.size(); 
        StringBuilder sb = new StringBuilder();
        //TODO check whether there are any errors before proceeding?
        sb.append(this.fields.get(index).getTagName().toString());
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
