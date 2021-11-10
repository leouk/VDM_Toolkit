package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.types.TRBasicType;
import vdm2isa.tr.types.TRFunctionType;
import vdm2isa.tr.types.TRInvariantType;
import vdm2isa.tr.types.TRMapType;
import vdm2isa.tr.types.TRNamedType;
import vdm2isa.tr.types.TROptionalType;
import vdm2isa.tr.types.TRQuoteType;
import vdm2isa.tr.types.TRRecordType;
import vdm2isa.tr.types.TRSeqType;
import vdm2isa.tr.types.TRSetType;
import vdm2isa.tr.types.TRType;
import vdm2isa.tr.types.TRUnionType;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;  

public class TRTypeDefinition extends TRAbstractTypedDefinition {
    private static final long serialVersionUID = 1L;

    private final TRPattern invPattern;
    private final TRExpression invExpression;
    private final TRPattern eqPattern1;
    private final TRPattern eqPattern2;
    private final TRExpression eqExpression;
    private final TRPattern ordPattern1;
    private final TRPattern ordPattern2;
    private final TRExpression ordExpression;
    private final TRNamedTypeDefinitionKind nameDefKind;
	
    private final TRExplicitFunctionDefinition invdef;
    private final TRExplicitFunctionDefinition eqdef;
    private final TRExplicitFunctionDefinition orddef;
    private final TRExplicitFunctionDefinition mindef;
    private final TRExplicitFunctionDefinition maxdef;
    
    private boolean infinite; 
	private TRDefinitionList composeDefinitions;

    public enum TRNamedTypeDefinitionKind {
        UNKNOWN, RECORD, BASIC, FUNCTION, MAP, OPTIONAL, QUOTE, SEQ, SET, UNION  
    }

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
        super(name.getLocation(), comments, annotations, name, nameScope, used, excluded, type);
        this.local = false; // Type definitions are never local? 
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
        this.nameDefKind = figureOutTypeDefinitionKind();

        checkTypeDefinitionConsistency();
        System.out.println(toString());
    }

    private void checkTypeDefinitionConsistency()
    {
        //(invPattern == null <=> invExpression == null)
        //=
        //(invPattern == null => invExpression == null) && (invExpression == null => invPattern == null)
        //=
        //(invPattern != null || invExpression == null) && (invExpression != null || invPattern == null)
        //=
        //((invPattern != null || invExpression == null) && invExpression != null) || 
        //((invPattern != null || invExpression == null) && invPattern == null)
        //=
        //((invPattern != null && invExpression != null) || (invExpression == null && invExpression != null)) ||
        //((invPattern != null && invPattern == null) || (invExpression == null && invPattern == null))
        //= 
        //((invPattern != null && invExpression != null) || (invExpression == null && invPattern == null))
        //
        //now negate it to check for inconsistency
        //
        //!(invPattern != null && invExpression != null) && !(invExpression == null && invPattern == null)
        //=
        //(invPattern == null || invExpression == null) && (invExpression != null || invPattern != null)
        //
        //rather be explicit than rely on confusing xor, particularly with three operands?
        if (invPattern == null ^ invExpression == null)
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "invariant", name.toString());
        if ((eqPattern1 == null ^ eqExpression == null) || (eqPattern1 == null ^ eqPattern2 == null) || (eqPattern2 == null ^ eqExpression == null))
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "equality", name.toString());
        if ((ordPattern1 == null ^ ordExpression == null) || (ordPattern1 == null ^ ordPattern2 == null) || (ordPattern2 == null ^ ordExpression == null))
           report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "ordering", name.toString());

        			// check stuff is consistent to expectations
		if ((invExpression != null && invdef == null) || (invExpression == null && invdef != null))
            report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_1P, "invariant");
        if ((eqExpression != null && eqdef == null) || (eqExpression == null && eqdef != null))
            report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_1P, "equality");
        if ((ordExpression != null && orddef == null) || (ordExpression == null && orddef != null))
            report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_1P, "ordering");
        if ((ordExpression != null && mindef == null) || (ordExpression == null && mindef != null))
            report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_1P, "minimum");
        if ((ordExpression != null && maxdef == null) || (ordExpression == null && maxdef != null))
            report(IsaErrorMessage.VDMSL_INVALID_SPECIFICATION_1P, "maximum");
    }


    @Override 
    protected void setup()
    {
        super.setup();
        setInvTranslateSeparator(IsaToken.SPACE.toString() + IsaToken.AND.toString() + IsaToken.SPACE.toString());
    }

    /**
     * From construction, we know that the type is an invariant type, so this is safe
     * @return
     */
    public TRInvariantType getInvariantType()
    {
        return (TRInvariantType)getType();
    }

    @Override
	public String toString()
	{
        return "TRTypeDef for " + 
        " \n\tname        = " + String.valueOf(name) +
        " \n\tlocal	      = " + local + 
        " \n\tkind        = " + nameDefKind + 
        " \n\tused	      = " + used + 
        " \n\texcluded    = " + excluded + 
        " \n\tinfinite    = " + infinite +
        " \n\tnamescope	  = " + (nameScope != null ? nameScope.name() : "?") +
        " \n\ttype        = " + String.valueOf(getType()) + //(getType() != null ? getType().translate() : "null") + 
        " \n\tinvPattern  = " + (invPattern != null ? invPattern.getClass().getName() + ": " + invPattern.toString() : "null") +
        " \n\tinvExpr     = " + String.valueOf(invExpression) + //(invExpression != null ? invExpression.translate() : "null") +
        " \n\teqPattern1  = " + (eqPattern1 != null ? eqPattern1.getClass().getName() + ": " + eqPattern1.toString() : "null") + 
        " \n\teqPattern2  = " + (eqPattern2 != null ? eqPattern2.getClass().getName() + ": " + eqPattern2.toString() : "null") +
        " \n\teqExpr      = " + String.valueOf(eqExpression) + //(eqExpression != null ? eqExpression.translate() : "null") +
        " \n\tordPattern1 = " + (ordPattern1 != null ? ordPattern1.getClass().getName() + ": " + ordPattern1.toString() : "null") +
        " \n\tordPattern2 = " + (ordPattern2 != null ? ordPattern1.getClass().getName() + ": " + ordPattern2.toString() : "null") +
        " \n\tordExpr     = " + String.valueOf(ordExpression) + //(ordExpression != null ? ordExpression.translate() : "null") +
        // avoid calling translate for TLD as it creates a record of what has been translated!  
        " \n\tinvdef      = " + (invdef  != null ? invdef.getClass().getName()  + ": \n\t========\n\t" + invdef.toString() + "\n\t=======\n\t"/*invdef.translate()*/  : "null") +
        " \n\teqdef       = " + (eqdef  != null ? eqdef.getClass().getName()  + ": \n\t========\n\t" + eqdef.toString() + "\n\t=======\n\t"/*eqdef.translate()*/  : "null") +
        " \n\torddef      = " + (orddef != null ? orddef.getClass().getName() + ": \n\t========\n\t" + orddef.toString() + "\n\t========\n\t"/*orddef.translate()*/ : "null") +
        " \n\tmindef      = " + (mindef  != null ? mindef.getClass().getName()  + ": \n\t========\n\t" + mindef.toString() + "\n\t=======\n\t"/*mindef.translate()*/  : "null") +
        " \n\tmaxdef      = " + (maxdef  != null ? maxdef.getClass().getName()  + ": \n\t========\n\t" + maxdef.toString() + "\n\t=======\n\t"/*maxdef.translate()*/  : "null") +
        " \n\tcomposeDefs = " + String.valueOf(composeDefinitions) + //(composeDefinitions != null ? composeDefinitions.toString() : "") +//composeDefinitions.getFlatDefinitionList().toString() : "null") +
        " \n\tin		  = " + location.toString();
	}
    
    private TRNamedTypeDefinitionKind figureOutTypeDefinitionKind()
    {
        TRNamedTypeDefinitionKind result = TRNamedTypeDefinitionKind.UNKNOWN;
        TRType t = getType(); 
        if (t instanceof TRRecordType)
            result = TRNamedTypeDefinitionKind.RECORD;
        else if (t instanceof TRNamedType)
        {
            TRNamedType tnt = (TRNamedType)t;
            if (tnt.type instanceof TRBasicType)
                result = TRNamedTypeDefinitionKind.BASIC;
            else if (tnt.type instanceof TRFunctionType)
                result = TRNamedTypeDefinitionKind.FUNCTION;
            else if (tnt.type instanceof TRMapType)
                result = TRNamedTypeDefinitionKind.MAP;
            else if (tnt.type instanceof TROptionalType)
                result = TRNamedTypeDefinitionKind.OPTIONAL;
            else if (tnt.type instanceof TRQuoteType)
                result = TRNamedTypeDefinitionKind.QUOTE;
            else if (tnt.type instanceof TRSeqType)
                result = TRNamedTypeDefinitionKind.SEQ;
            else if (tnt.type instanceof TRSetType)
                result = TRNamedTypeDefinitionKind.SET;
            else if (tnt.type instanceof TRUnionType)
                result = TRNamedTypeDefinitionKind.UNION;
        }
        return result;
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
        TRType t = getType();
        sb.append(super.translate());
        // TLD for records
        if (t instanceof TRRecordType)
        {
            TRRecordType trtype = (TRRecordType)t;
            
            // translate record definition 
            sb.append(trtype.isaToken().toString() + " "); 
            sb.append(trtype.translate());
            sb.append(" ");
            sb.append(IsaToken.EQUALS.toString());
            sb.append(" ");
            sb.append(getFormattingSeparator());
            sb.append(trtype.getFields().translate());
            sb.append(getFormattingSeparator() + getFormattingSeparator());

            //TODO this has to take into account invPattern if one exists, as well as the AND True when it doesn't!
            // translate implicit record type invariant
            String varName = IsaToken.dummyVarNames(1, name.getLocation());
            sb.append(IsaTemplates.translateInvariantDefinition(getLocation(),
                    name.toString(), name.toString(), varName, 
                    trtype.invTranslate(varName), false));            
        }
        else if (t instanceof TRNamedType)
        {
            // named type translation is relative to what kind of type it is 
            TRNamedType trtype = (TRNamedType)t;
            // translate named type TLD 
            switch (nameDefKind)
            {
                // straightforward type synonym cases
                case BASIC:
                case FUNCTION:
                case MAP:
                case OPTIONAL:
                case SEQ:
                case SET:
                    //TODO @NB is there a case where name is diffeerent from trtype.typename? 
                    sb.append(IsaTemplates.translateTypeSynonymDefinition(location, name.toString(), trtype.translate()));
                    break;
                case QUOTE:
                case UNION:
                    report(IsaErrorMessage.PLUGIN_NYI_2P, "type definition", name.toString() + ": " + t.getClass().getName());
                    break;
                case RECORD:
                case UNKNOWN:
                default:
                    report(IsaErrorMessage.PLUGIN_NYI_2P, "invalid type definition", name.toString() + ": " + t.getClass().getName());
                    break;                
            }
            sb.append(getFormattingSeparator());
            sb.append("\n");

            //TODO this has to take into account invPattern if one exists, as well as the AND True when it doesn't!
            // translate named type specification definition   
            String inType = trtype.type.translate();
            String inv = invTranslate();
            sb.append(IsaTemplates.translateInvariantTypeSynonym(location, name.toString(), inType, dummyVarNames(), inv));

            String varName = IsaToken.dummyVarNames(1, name.getLocation());
            sb.append(IsaTemplates.translateInvariantDefinition(getLocation(),
                    name.toString(), name.toString(), varName, 
                    trtype.invTranslate(varName), false));            

            /* 
            T = nat
            inv t == t > 10;

            type_synonym T = "VDMNat"

            definition
               inv_T :: "VDMNat => bool"
            where
               "inv_T dummy == inv_VDMNat dummy"
            */

        }
        else 
            report(IsaErrorMessage.VDMSL_INVALID_INVTYPE_2P, name.toString(), t.getClass().getName());
        //TODO user defined invariant on TLD 
        return sb.toString();
    }

	@Override
	public <R, S> R apply(TRDefinitionVisitor<R, S> visitor, S arg)
	{
		return visitor.caseTypeDefinition(this, arg);
	}

	public TRExpression getInvExpression()
	{
		return invExpression;
	}

	public TRExpression getEqExpression()
	{
		return eqExpression;
	}

	public TRExpression getOrdExpression()
	{
		return ordExpression;
	}
}
