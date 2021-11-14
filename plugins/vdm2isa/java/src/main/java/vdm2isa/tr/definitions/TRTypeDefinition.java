package vdm2isa.tr.definitions;

import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.typechecker.NameScope;

import plugins.Vdm2isaPlugin;
import vdm2isa.tr.definitions.visitors.TRDefinitionVisitor;
import vdm2isa.tr.expressions.TRExpression;
import vdm2isa.tr.patterns.TRBasicPattern;
import vdm2isa.tr.patterns.TRPattern;
import vdm2isa.tr.patterns.TRPatternListList;
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
import vdm2isa.tr.types.TRTypeList;
import vdm2isa.tr.types.TRUnionType;
import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.lex.TRIsaVDMCommentList;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.messages.IsaWarningMessage;  

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
	
    // those that might require implicit undeclared specification are not final
    private TRExplicitFunctionDefinition invdef;
    private TRExplicitFunctionDefinition eqdef;
    private final TRExplicitFunctionDefinition orddef;
    private final TRExplicitFunctionDefinition mindef;
    private final TRExplicitFunctionDefinition maxdef;
    
    private boolean infinite; 
	private TRDefinitionList composeDefinitions;

    public enum TRNamedTypeDefinitionKind {
        UNKNOWN, RECORD, BASIC, FUNCTION, MAP, OPTIONAL, QUOTE, SEQ, SET, UNION, RENAMED, RENAMEDRECORD
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

        setup();
        //System.out.println(toString());
    }

    @Override
    protected void setup()
    {
        super.setup();
        setInvTranslateSeparator(IsaToken.SPACE.toString() + IsaToken.AND.toString() + IsaToken.SPACE.toString());
        // only after fully class mapped
		if (this.type != null && this.nameDefKind != null)
		{
            boolean needToUpdateTypeInvDef = true;
            checkTypeDefinitionConsistency();
            // only create undeclared specification for those who need it: when invdef is null but the named type needs inv checking
            // (T = nat; inv_T x = inv_VDMNat x); which will then create it (see also TRExplicitFunctionDefinition.predef), but that
            // in itself won't have pre/predef and no body! So if not guarded here, would loop! 
            // at first pass, this is created with null type ?
            if (needsImplicitlyGeneratedUndeclaredSpecification() && !nameDefKind.equals(TRNamedTypeDefinitionKind.UNKNOWN))//&& this.type != null)
            {
                assert type != null; // wt...?!
                // the invariant type parameter is the TRInvariantType projected: inner type if named; itself if record
                TRType paramType = figureOutInvariantType();
                
                //TODO in a way, because of how TRFunctionType already works, this is somewhat redundant? 
                TRFunctionType invType = new TRFunctionType(location, type.definitions, TRTypeList.newTypeList(paramType), false, TRBasicType.boolType(location));
                TRPatternListList parameters = TRPatternListList.newPatternListList(TRBasicPattern.dummyPattern(location));
                this.invdef = TRExplicitFunctionDefinition.createUndeclaredSpecification(
                    //TCNameToken name, NameScope nameScope, boolean used, boolean excluded, TCNameList typeParams, 
                    //TRFunctionType type, boolean isCurried, TRPatternListList parameters, 
                    //TRDefinitionListList paramDefinitionList, TRSpecificationKind kind)
                    name, nameScope, used, excluded, null /*type parameters*/,
                    invType, false, parameters, 
                    /*paramDefinitionList*/new TRDefinitionListList(), TRSpecificationKind.INV); 
    
                // TRInvariantType translateTLD() takes care of the rest! 
                this.getInvariantType().setInvariantDefinition(this.invdef);
                needToUpdateTypeInvDef = false;
            }
    
            // must always have inv_T
            if (invdef == null)
                report(IsaErrorMessage.ISA_INVALID_TYPEINVARIANT_1P, name.toString());
            else if (needToUpdateTypeInvDef)
            {
                updateExplicitDefinition(invdef);
                this.getInvariantType().setInvariantDefinition(this.invdef);
            }

            //TODO update the inner parameters to call inv_T, instead of its invTranslate! 
            if (eqdef != null)
            {
                updateExplicitDefinition(eqdef);
                getInvariantType().setEqualityDefinition(eqdef);
            }
            if (orddef != null)
            {
                updateExplicitDefinition(orddef);
                getInvariantType().setOrderingDefinition(orddef);
            }
            if (Vdm2isaPlugin.translateTypeDefMinMax)
            {
                TRType ultimate = type.ultimateType();
                 if ((mindef != null || maxdef != null) && 
                      ultimate instanceof TRRecordType)
                     warning(IsaWarningMessage.ISA_TYPDEF_MINMAX_ORD_1P, name.toString());
                if (!(ultimate instanceof TRRecordType))
                {
                    if (mindef != null)
                    {
                        updateExplicitDefinition(mindef);
                    //    mindef.comments.add(location, IsaWarningMessage.ISA_TYPDEF_MINMAX_ORD_1P.format(name.toString()), false);
                    }
                    if (maxdef != null)
                    {
                        updateExplicitDefinition(maxdef);
                    //    maxdef.comments.add(location, IsaWarningMessage.ISA_TYPDEF_MINMAX_ORD_1P.format(name.toString()), false);
                    }
                }
            }
        }
    }

    private void updateExplicitDefinition(TRExplicitFunctionDefinition def)
    {
        // adjust any renamed record invdef 
        // for renamed records we have to "fix" the XXXdef type parameters to avoid 
        // calls to the defined record invariant
        // instead of its inv_R call! 
        TRType paramType = figureOutInvariantType();
        int count = def.getType().parameters.size(); 
        def.getType().parameters.clear();
        for (int i = 0; i < count; i++)
        {
            // add as many as the original signature; will have to be the same type anyhow.
            def.getType().parameters.add(paramType);
        }
    }

    protected TRType figureOutInvariantType()
    {
        TRType result;
        // record types get themselves
        if (type instanceof TRRecordType)
            result = type; 
        else if (type instanceof TRNamedType)
        {
            TRNamedType trtype = (TRNamedType)type;
            // renamed record types get themselves too
            if (nameDefKind.equals(TRNamedTypeDefinitionKind.RENAMEDRECORD) ||
                trtype.ultimateType() instanceof TRRecordType) 
            {
                trtype.setAtTopLevelDefinition(true);
                result = trtype;
            }
            // other renamed types get original type
            else    
                result = trtype;//trtype.type;
        }
        else 
        {
            result = type;
            report(IsaErrorMessage.ISA_INVALID_INVTYP_2P, name.toString(), type.getClass().getSimpleName());
        }
        return result;
    }

	protected boolean needsImplicitlyGeneratedUndeclaredSpecification()
	{
		return this.invdef == null && this.invExpression == null;
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
    
        if (type != null)
            getInvariantType().checkTypeDefinitionConsistency(invdef, eqdef, orddef);
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
        " \n\tinvPattern  = " + (invPattern != null ? invPattern.getClass().getSimpleName() + ": " + invPattern.toString() : "null") +
        " \n\tinvExpr     = " + String.valueOf(invExpression) + //(invExpression != null ? invExpression.translate() : "null") +
        " \n\teqPattern1  = " + (eqPattern1 != null ? eqPattern1.getClass().getSimpleName() + ": " + eqPattern1.toString() : "null") + 
        " \n\teqPattern2  = " + (eqPattern2 != null ? eqPattern2.getClass().getSimpleName() + ": " + eqPattern2.toString() : "null") +
        " \n\teqExpr      = " + String.valueOf(eqExpression) + //(eqExpression != null ? eqExpression.translate() : "null") +
        " \n\tordPattern1 = " + (ordPattern1 != null ? ordPattern1.getClass().getSimpleName() + ": " + ordPattern1.toString() : "null") +
        " \n\tordPattern2 = " + (ordPattern2 != null ? ordPattern1.getClass().getSimpleName() + ": " + ordPattern2.toString() : "null") +
        " \n\tordExpr     = " + String.valueOf(ordExpression) + //(ordExpression != null ? ordExpression.translate() : "null") +
        // avoid calling translate for TLD as it creates a record of what has been translated!  
        " \n\tinvdef      = " + (invdef  != null ? invdef.getClass().getSimpleName()  + ": \n\t========\n\t" + invdef.toString() + "\n\t=======\n\t"/*invdef.translate()*/  : "null") +
        " \n\teqdef       = " + (eqdef  != null ? eqdef.getClass().getSimpleName()  + ": \n\t========\n\t" + eqdef.toString() + "\n\t=======\n\t"/*eqdef.translate()*/  : "null") +
        " \n\torddef      = " + (orddef != null ? orddef.getClass().getSimpleName() + ": \n\t========\n\t" + orddef.toString() + "\n\t========\n\t"/*orddef.translate()*/ : "null") +
        " \n\tmindef      = " + (mindef  != null ? mindef.getClass().getSimpleName()  + ": \n\t========\n\t" + mindef.toString() + "\n\t=======\n\t"/*mindef.translate()*/  : "null") +
        " \n\tmaxdef      = " + (maxdef  != null ? maxdef.getClass().getSimpleName()  + ": \n\t========\n\t" + maxdef.toString() + "\n\t=======\n\t"/*maxdef.translate()*/  : "null") +
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
            else if (tnt.type instanceof TRNamedType)
                result = TRNamedTypeDefinitionKind.RENAMED;
            else if (tnt.type instanceof TRRecordType)
                result = TRNamedTypeDefinitionKind.RENAMEDRECORD;
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
            sb.append(getFormattingSeparator());
            sb.append("\n");
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
                case OPTIONAL:
                case SEQ:
                case SET:
                case MAP:
                    sb.append(IsaTemplates.translateTypeSynonymDefinition(location, name.toString(), trtype.type.translate()));
                    break;
                // get the inner type name for the synonym translation; TBasic2 = TBasic; TBasic = nat;
                case RENAMED:
                    assert trtype.type instanceof TRNamedType; 
                    //trtype = (TRNamedType)trtype.type;
                    sb.append(IsaTemplates.translateTypeSynonymDefinition(location, name.toString(), trtype.type.translate()));
                    break;
                // re-named record (e.g. TRecord' = TRecord inv r == ...; for TRecord :: ...;) requires some thinking
                case RENAMEDRECORD:
                    assert trtype.type instanceof TRNamedType && invdef != null; 
                    //trtype = (TRNamedType)trtype.type;
                    sb.append(IsaTemplates.translateTypeSynonymDefinition(location, name.toString(), trtype.type.translate()));
                    break;
                case QUOTE:
                case UNION:
                    report(IsaErrorMessage.PLUGIN_NYI_2P, "type definition", name.toString() + ": " + t.getClass().getSimpleName() + "(" + nameDefKind.name() + ")");
                    break;
                case UNKNOWN:
                case RECORD:
                default:
                    report(IsaErrorMessage.PLUGIN_NYI_2P, "invalid type definition", name.toString() + ": " + t.getClass().getSimpleName() + "(" + nameDefKind.name() + ")");
                    break;                
            }
            sb.append(getFormattingSeparator());
            sb.append("\n");
        }
        else 
            report(IsaErrorMessage.VDMSL_INVALID_INVTYPE_2P, name.toString(), t.getClass().getSimpleName());

        // issue inv / eq / ord
        if (t instanceof TRInvariantType)
        {
            sb.append(getInvariantType().translateTLD());
        }

        if (Vdm2isaPlugin.translateTypeDefMinMax)
        {
            TRType ultimate = type.ultimateType();
            if (mindef != null && !(ultimate instanceof TRRecordType))
            {
                sb.append(mindef.translate());
                sb.append(getFormattingSeparator());
                sb.append("\n");
            }

            if (maxdef != null && !(ultimate instanceof TRRecordType))
            {
                sb.append(maxdef.translate());
                sb.append(getFormattingSeparator());
                sb.append("\n");
            }
        }
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
