package vdm2isa.tr.expressions;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.expressions.TCMkTypeExpression;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.expressions.visitors.TRExpressionVisitor;
import vdm2isa.tr.types.TRField;
import vdm2isa.tr.types.TRFieldList;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRTypeComparator;
import vdm2isa.tr.types.TRTypeSet;
import vdm2isa.tr.types.TRUnionType;

public class TRMkTypeExpression extends TRExpression {
    private static final long serialVersionUID = 1L;

    public final TCNameToken typename;
    private TRFieldList fields; 
    public final TRExpressionList args;

    public TRMkTypeExpression(TCMkTypeExpression tc, TCNameToken typename, TRExpressionList args, TRType exptype)
    {
        super(typename != null ? typename.getLocation() : LexLocation.ANY, tc, exptype);
        this.typename = typename;
        this.args = args;
        this.fields = null;
    }

    @Override 
    public void setup()
    {
        super.setup();
        assert typename != null;
        this.fields = TRRecordType.fieldsOf(typename);
        if (this.fields == null)
            report(IsaErrorMessage.ISA_RECORD_EARLYUSE_1P, typename.toString());
        else if (this.fields.size() != this.args.size())
            report(IsaErrorMessage.VDMSL_INVALID_MKARGS_3P, typename.toString(), args.size(), fields.size()); 
        else if (this.args.size() == 0)
            report(IsaErrorMessage.ISA_NO_EMPTYRECORD_1P, typename.toString());
        TRNode.setup(fields, args);
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
        assert index >= 0 && index < fields.size() && index < args.size(); 
        StringBuilder sb = new StringBuilder();
        TRField field = fields.get(index);
        TRExpression arg = args.get(index);
        sb.append(field.getIsabelleTagName());
        sb.append(" ");
        sb.append(IsaToken.EQUALS.toString());
        sb.append(" ");
        // if field is a union, but argument isn't, then add union tag
        if (field.isUnion())
        {
            // field is indeed a union compatible with given argument
            assert field.getInnerType().ultimateType() instanceof TRUnionType;
            TRUnionType utype = (TRUnionType)field.getInnerType().ultimateType(); 
            TRType argtype = arg.getType();
            assert utype.compatible(argtype);

            // calculate their class mapped TRType intersection (if any), then translate the prefix
            TRType uinter = TRTypeComparator.intersect(utype, argtype);
            TRTypeSet utypeset = utype.getDataTypeConstructors();
            if (uinter == null || !utypeset.contains(uinter))
            {
                report(IsaErrorMessage.VDMSL_FIELD_INCOMPATIBLE_UNION_TYPE_4P, 
                    typename.toString(), index, utype.translate(), argtype.translate());
            }
            else 
            {
                sb.append(utypeset.prefixTranslate(uinter));
            }
        }
        else
        {
            sb.append(arg.translate());
        }
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
