package vdm2isa.tr.types;

import java.util.Set;

import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.types.TCNamedType;

import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.definitions.TRExplicitFunctionDefinition;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRNamedType extends TRInvariantType
{
	private static final long serialVersionUID = 1L;
    public final TRType type;

    public TRNamedType(TCNamedType vdmType, TCNameToken typename, TRDefinitionList definitions, TRType type, TRExplicitFunctionDefinition invdef, TRExplicitFunctionDefinition eqdef, TRExplicitFunctionDefinition orddef)
    {
        super(vdmType, typename, definitions, invdef, eqdef, orddef);
        this.type = type;
    }
    @Override
    public void setup()
    {
        super.setup();
        setSemanticSeparator(IsaToken.SPACE.toString());
        TRNode.setup(type);
    }

    @Override
    protected void setInferredNamedForType(TCNameToken tn)
	{
        // this already has a named type!
        super.setInferredNamedForType(tn);
        if (getName().equals(String.valueOf(tn)))
        {
            type.setInferredNamedForType(tn);
        }
	}

    @Override
    public boolean setAtTopLevelDefinition(boolean b, boolean deep)
    {
        // inner type at super = to type set
        boolean old = super.setAtTopLevelDefinition(b, deep);
		if (deep)
        {
            this.type.setAtTopLevelDefinition(b, deep);
        }
        return old;
    }	

    @Override
    public TRType copy(boolean atTLD)
    {
        TRType result = this;
        if (type == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, getName(), "null type?");
        }
        else
        {
            // inner type of structured or multiply renamed named type is always "top-level" (i.e. always use it's invariant name rather than its parts!)
            result = new TRNamedType((TCNamedType)getVDMType(), typename, definitions, type.copy(true), getInvDef(), getEqDef(), getOrdDef());
            TRNode.setup(result);
            // only named types set inferred named types! 
            ((TRNamedType)result).type.setInferredNamedForType(typename);
            result.setAtTopLevelDefinition(atTLD);
        }
        return result;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.IDENTIFIER;
    }

    /**
     * Chase the type renaming chain
     * @return
     */
    @Override
    public TRType ultimateType()
    {
        TRType result = type;
        while (result instanceof TRNamedType)
        {
            result = ((TRNamedType)result).type;
        }
        // if (result instanceof TRNamedType)
        //     result = ((TRNamedType)result).ultimateType();
        return result;
    }

    @Override
    public TRInvariantType ultimateInvariantType()
    {
        TRInvariantType result = super.ultimateInvariantType();
        if (result == null)
            result = type.ultimateInvariantType();
        return result;
    }

    /**
     * Depending on the context where this is called, you will want just the RHS; so only return the RHS, and use the typename for LHS where needed.
     */
    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        type.setInferredNamedForType(typename);
        // Hide LHS
        // sb.append(getName());
        // sb.append(getSemanticSeparator());
        // sb.append(IsaToken.EQUALS.toString());
        // sb.append(getSemanticSeparator());
        // if (type instanceof TRNamedType)
        // {
        //     TRNamedType tnt = (TRNamedType)type;
        //     // for VDM named type synonyms (e.g. T = nat; T2 = T;); ISAQUOTE is to be done externally, given context where RHS is used! 
        //     //sb.append(IsaToken.innerSyntaxIt(tnt.getName()));
        //     sb.append(tnt.getName());
        // }
        // else
        // {
        //     // for new types (e.g. T = nat, T = set of X, etc.)
        //     //sb.append(IsaToken.innerSyntaxIt(type.translate());
        //     sb.append(type.translate());
        // }
        sb.append(getName());//type.translate());
        return sb.toString();
    }

    @Override
    public Set<String> getDefLemmas()
    {
        Set<String> result = super.getDefLemmas();
        result.addAll(type.getDefLemmas());
        return result;
    }
        
    @Override
	public String invTranslate(String varName) {

        StringBuilder sb = new StringBuilder();
        
        //TODO not sure if this is to be set here or after new StringBuilder? 
        // set the inferred named type at inv translate as well given
        // at PO generation this might be the only one called
        type.setInferredNamedForType(typename);

        // for named or record types, use name
        // at TLD use the type name as well; 
        // ex T = nat
        //    inv t = P(t) eq t1 = t2 == Q(t1,t2)
        //inv_T t       = inv_VDMNat t /\ P(t)
        //eq_T t1 t2    = inv_T t1 /\ inv_T t1 /\ Q(t1,t2)  <--- don't call inv_VDMNat here
        //
        // don't forget to get the inner type @TLD flag as well, given we might get something like
        // TSet = set of nat1  -- not TSet.atTLD  => inv_VDMNat1  
        // TSet3 = set of TSet -- not TSet3.atTLD => TSet3.type.atTLD ? then inv_VDMSet' inv_TSet instead of inv_VDMSet' inv_VDMNat1!
        if (type instanceof TRInvariantType || atTopLevelDefinition())
        {
            if (varName != null)
            {
                sb.append(IsaToken.LPAREN.toString());
            }
            sb.append(IsaToken.INV.toString());
            // for record types on RHS, get the name as well 
            sb.append(atTopLevelDefinition() ? getName() : type.getName());
            if (varName != null)
            {
                sb.append(getSemanticSeparator());
                sb.append(varName);
                sb.append(IsaToken.RPAREN.toString());
            }
        }
        // "ultimate" types, delegate to their invTranslate
        else 
        {
            
            // TRType utype = ultimateType();
            // if (utype.equals(type))
            // {
            //     report(IsaErrorMessage.ISA_INVALID_INVTYP_2P, getName(), "ultimate type `" + utype.translate() + "`");
            // }
            sb.append(IsaToken.parenthesise(type.invTranslate(varName)));
        }
        return sb.toString();
        // if (atTopLevelDefinition() || ultimateType() instanceof TRRecordType)
        //     sb.append(IsaToken.parenthesise(IsaToken.INV.toString() + type.getName() + (varName != null ? getSemanticSeparator() + varName : ""))); 
        // else if (//atTopLevelDefinition() || 
        //          type instanceof TRNamedType) 
        //     sb.append(IsaToken.parenthesise(IsaToken.INV.toString() + getName() + (varName != null ? getSemanticSeparator() + varName : ""))); 
        // else
        //     sb.append(type.invTranslate(varName));
        //return sb.toString();
        //TODO not all type.getName() will directly work! Needs to take into account structure types etc. Okay for now. 
        // renamed records are slightly different: you call the inv_Type of the record itself, which must have been previously defined.  
//        TRType utype = type;//ultimateType();//type;
 //       String nameStr = atTopLevelDefinition() ? utype.invTranslate(varName) : getName();//getName();//utype instanceof TRRecordType ? utype.getName() : getName();
        // return atTopLevelDefinition() ? utype.invTranslate(varName) : 
        //     IsaToken.parenthesise(
        //         IsaToken.INV.toString() + nameStr +
        //         (varName != null ? getSemanticSeparator() + varName : ""));
	}

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseNamedType(this, arg);
	}

    @Override
    public void checkForUnionTypes() {
        // union types are allowed in named types, so okay. 
    }
}
