package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;  

public class TRTypeDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;

    private final TRInvariantType type;
    private final TRExpression invExpr;

    // public TCInvariantType type;
	// public final TCTypeList unresolved;
	// public final TCPattern invPattern;
	// public final TCExpression invExpression;
	// public final TCPattern eqPattern1;
	// public final TCPattern eqPattern2;
	// public final TCExpression eqExpression;
	// public final TCPattern ordPattern1;
	// public final TCPattern ordPattern2;
	// public final TCExpression ordExpression;
	
	// public TCExplicitFunctionDefinition invdef;
	// public TCExplicitFunctionDefinition eqdef;
	// public TCExplicitFunctionDefinition orddef;
	// public TCExplicitFunctionDefinition mindef;
	// public TCExplicitFunctionDefinition maxdef;
	
	// public boolean infinite = false;
	// private TCDefinitionList composeDefinitions;

    public TRTypeDefinition(TRIsaVDMCommentList comments, 
        TCAnnotationList annotations, 
        TCNameToken name, 
        NameScope nameScope,
        boolean used,
        boolean excluded,
        TRInvariantType type, 
        TRExpression invExpression)
    {
        super(name.getLocation(), comments, annotations, name, nameScope, used, excluded);
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
        // TLD for records
        if (type instanceof TRRecordType)
        {
            TRRecordType trtype = (TRRecordType)type;
            
            // translate record definition 
            sb.append(trtype.isaToken().toString() + " "); 
            sb.append(trtype.translate());
            sb.append(" ");
            sb.append(IsaToken.EQUALS.toString());
            sb.append(" ");
            sb.append(getFormattingSeparator());
            sb.append(trtype.getFields().translate());
            sb.append(getFormattingSeparator() + getFormattingSeparator());

            // translate implicit record type invariant
            String varName = IsaToken.dummyVarNames(1, name.getLocation());
            sb.append(IsaTemplates.translateInvariantDefinition(getLocation(),
                    name.toString(), name.toString(), varName, 
                    trtype.invTranslate(varName), false));            
        }
        //TODO user defined invariant on TLD 
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
