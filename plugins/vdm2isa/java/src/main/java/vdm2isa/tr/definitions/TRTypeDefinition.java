package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRNamedType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRType;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;  

public class TRTypeDefinition extends TRDefinition {
    private static final long serialVersionUID = 1L;

    private final TRInvariantType type;
    private final TRPattern invPattern;
    private final TRExpression invExpression;
    private final TRPattern eqPattern1;
    private final TRPattern eqPattern2;
    private final TRExpression eqExpression;
    private final TRPattern ordPattern1;
    private final TRPattern ordPattern2;
    private final TRExpression ordExpression;
	
    private final TRExplicitFunctionDefinition invdef;
    private final TRExplicitFunctionDefinition eqdef;
    private final TRExplicitFunctionDefinition orddef;
    private final TRExplicitFunctionDefinition mindef;
    private final TRExplicitFunctionDefinition maxdef;
    
    private boolean infinite; 
	private TRDefinitionList composeDefinitions;

    public TRTypeDefinition(TRIsaVDMCommentList comments, 
        TCAnnotationList annotations, 
        TCNameToken name, 
        NameScope nameScope,
        boolean used,
        boolean excluded,
        TRInvariantType type,
        TRPattern invPattern,  
        TRExpression invExpression,
        TRPattern eqPattern1,
        TRPattern eqPattern2,
        TRExpression eqExpression,
        TRPattern ordPattern1,
        TRPattern ordPattern2,
        TRExpression ordExpression,
        TRExplicitFunctionDefinition invdef,
        TRExplicitFunctionDefinition eqdef,
        TRExplicitFunctionDefinition orddef,
        TRExplicitFunctionDefinition mindef,
        TRExplicitFunctionDefinition maxdef,
        boolean infinite,
        TRDefinitionList composeDefinitions
        )
    {
        super(name.getLocation(), comments, annotations, name, nameScope, used, excluded);
        this.type = type;
        this.invPattern = invPattern;
        this.invExpression = invExpression;
        this.eqPattern1 = eqPattern1;
        this.eqPattern2 = eqPattern2;
        this.eqExpression = eqExpression;
        this.ordPattern1 = ordPattern1;
        this.ordPattern2 = ordPattern2;
        this.ordExpression = ordExpression;
        this.invdef = invdef;
        this.eqdef = eqdef;
        this.orddef = orddef;
        this.mindef = mindef;
        this.maxdef = maxdef;
        this.infinite = infinite;
        this.composeDefinitions = composeDefinitions;
        System.out.println(toString());
    }

    @Override
	public String toString()
	{
        return "TRTypeDef for " + 
        " \n\tname        = " + String.valueOf(name) +
        " \n\tlocal	      = " + local + 
        " \n\tused	      = " + used + 
        " \n\texcluded    = " + excluded + 
        " \n\tinfinite    = " + infinite +
        " \n\tnamescope	  = " + (nameScope != null ? nameScope.name() : "?") +
        " \n\ttype        = " + (type != null ? type.translate() : "null") + 
        " \n\tinvPattern  = " + (invPattern != null ? invPattern.translate() + " [" + invPattern.getClass().getName() + "]": "null") +
        " \n\tinvExpr     = " + (invExpression != null ? invExpression.translate() : "null") +
        " \n\teqPattern1  = " + (eqPattern1 != null ? eqPattern1.translate() + " [" + eqPattern1.getClass().getName() + "]": "null") + 
        " \n\teqPattern2  = " + (eqPattern2 != null ? eqPattern2.translate() + " [" + eqPattern2.getClass().getName() + "]": "null") +
        " \n\teqExpr      = " + (eqExpression != null ? eqExpression.translate() : "null") +
        " \n\tordPattern1 = " + (ordPattern1 != null ? ordPattern1.translate() + " [" + ordPattern1.getClass().getName() + "]": "null") +
        " \n\tordPattern2 = " + (ordPattern2 != null ? ordPattern2.translate() + " [" + ordPattern2.getClass().getName() + "]": "null") +
        " \n\tordExpr     = " + (ordExpression != null ? ordExpression.translate() : "null") +
        // avoid calling translate for TLD as it creates a record of what has been translated!  
        " \n\tinvdef      = " + (invdef  != null ? invdef.getClass().getName()  + ": \n\t========\n\t" + invdef.toString() + "\n\t=======\n\t"/*invdef.translate()*/  : "null") +
        " \n\teqdef       = " + (eqdef  != null ? eqdef.getClass().getName()  + ": \n\t========\n\t" + eqdef.toString() + "\n\t=======\n\t"/*eqdef.translate()*/  : "null") +
        " \n\torddef      = " + (orddef != null ? orddef.getClass().getName() + ": \n\t========\n\t" + orddef.toString() + "\n\t========\n\t"/*orddef.translate()*/ : "null") +
        " \n\tmindef      = " + (mindef  != null ? mindef.getClass().getName()  + ": \n\t========\n\t" + mindef.toString() + "\n\t=======\n\t"/*mindef.translate()*/  : "null") +
        " \n\tmaxdef      = " + (maxdef  != null ? maxdef.getClass().getName()  + ": \n\t========\n\t" + maxdef.toString() + "\n\t=======\n\t"/*maxdef.translate()*/  : "null") +
        " \n\tcomposeDefs = " + (composeDefinitions != null ? composeDefinitions.toString() : "") +//composeDefinitions.getFlatDefinitionList().toString() : "null") +
        " \n\tin		  = " + location.toString();
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
        else if (type instanceof TRNamedType)
        {
            // named type translation is relative to what kind of type it is 
            TRNamedType trtype = (TRNamedType)type;

            // translate named type definition
            
        }
        else 
            report(IsaErrorMessage.VDMSL_INVALID_INVTYPE_2P, name.toString(), type.getClass().getName());
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
