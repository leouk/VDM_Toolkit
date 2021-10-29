package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;  

public class TRTypeDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;

    private final TCNameToken name;
    private final TRInvariantType type;
    private final TRExpression invExpr;

    public TRTypeDefinition(TCAnnotationList annotations, TCNameToken name, TRInvariantType type, TRExpression invExpression)
    {
        super(name.getLocation(), null, annotations);
        this.name = name;
        this.type = type;
        this.invExpr = invExpression;
        //System.out.println(toString());
    }

    @Override
	public String toString()
	{
		return "TRTypeDef for \"" + name.toString() + 
			"\" type " + type.toString() + 
            " inv " + String.valueOf(invExpr);
	}

    @Override
    public IsaToken isaToken()
    {
        return IsaToken.TYPEOF;
    }

    @Override 
    public String translate()
    {
        StringBuilder sb = new StringBuilder();
        sb.append(super.translate());
        if (type instanceof TRRecordType)
        {
            sb.append(type.translate());
            String varName = "x";
            sb.append(IsaTemplates.translateInvariantDefinition(
                    name.toString(), name.toString(), varName, 
                    type.invTranslate(varName)));
        }
        return sb.toString();
    }

    @Override
    public String invTranslate() {
        // TODO Auto-generated method stub
        return null;
    }

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseTypeDefinition(this, arg);
	}

	public TRExpression getInvExpression()
	{
		return null;	// TODO!
	}

	public TRExpression getEqExpression()
	{
		return null;	// TODO!
	}

	public TRExpression getOrdExpression()
	{
		return null;	// TODO!
	}

	public TRType getType()
	{
		return type;
	}
}
