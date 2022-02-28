package vdm2isa.tr.types;

import java.util.Set;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.types.TCProductType;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.messages.IsaErrorMessage;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRProductType extends TRType {
    private static final long serialVersionUID = 1L;

    public final TRTypeList types;

    public TRProductType(TCProductType vdmType, TRDefinitionList definitions, TRTypeList types)
    {
        super(vdmType, definitions);
        this.types = types;
    }

    @Override
    public void setup()
    {
        super.setup();
        setSemanticSeparator(IsaToken.COMMA.toString() + IsaToken.SPACE.toString()); //?
        TRNode.setup(types);
        assert types != null;
        types.setCurried(false);
        
    }

    @Override
    public boolean setAtTopLevelDefinition(boolean b)
    {
        // inner type at super = to type set
        return super.setAtTopLevelDefinition(b);
		//this.types.setAtTopLevelDefinition(b);
    }	

    @Override
	public TRType copy(boolean atTLD)
	{
        TRType result = this;
        if (types == null)
        {
            // this can happen if -verbose WARNINGS are not heeded? Percolate through the TRType tree.
            report(IsaErrorMessage.VDMSL_INVALID_TYPEDEF_2P, "product type", "null types list?");
        }
        else
        {
            result = new TRProductType((TCProductType)getVDMType(), definitions, types.copy(atTLD));
            TRNode.setup(result);
		    result.setAtTopLevelDefinition(atTLD);
        }
		return result;
	}   

    public static final String dummyProjection(long index, long size)
    {
        // using long because index in field num expression is a long :-()
        assert index >= 0 && index < size;
        return IsaToken.DUMMY.toString() + Long.toString(index+1) + "of" + Long.toString(size);
    }

    /**
     * Creates a dummy projection for the local lambda term (e.g. % (dummy1of3, dummy2of3, dummy3of3) . ....) 
     * @param size
     * @param sep
     * @return
     */
    public static final String dummyFullProjection(long size, String sep)
    {
        assert size > 0;
        StringBuilder sb = new StringBuilder();
        sb.append(TRProductType.dummyProjection(0, size));
        for(long index = 1; index < size; index++)
        {
            //sb.append(IsaToken.COMMA.toString());
            //sb.append(IsaToken.SPACE.toString());
            sb.append(sep);
            sb.append(TRProductType.dummyProjection(index, size));
        }
        return IsaToken.parenthesise(sb.toString()); 
    }

    /**
     * Isabelle only have tuples (or pairs). So, VDM n-tuples have to be projected out of pairs. 
     * @param index which tuple index (e.g. x.#index) adjusted to size (i.e. x.#index, where index [0,...,size[, instead of [1,...size])
     * @param size overall tuple size
     * @param varName variable name being projected out (e.g., varName.#index)
     * @return Isabelle projection as combination of multiple fst/snd expressions over varName depending on index.
     */
    public static final String fieldProjection(long index, long size, String varName)
    {
        // using long because index in field num expression is a long :-()
        assert index >= 0 && index < size && varName != null;
        StringBuilder fieldVarName = new StringBuilder();
        if (index == 0)
        {
            fieldVarName.append(IsaToken.LPAREN.toString());
            fieldVarName.append(IsaToken.FST.toString());
            fieldVarName.append(IsaToken.SPACE.toString());
            fieldVarName.append(varName);
            fieldVarName.append(IsaToken.RPAREN.toString());
        } /*
        else if (this.types.size() == 2 && index == 1)
        {
            fieldVarName.append(IsaToken.LPAREN.toString());
            fieldVarName.append(IsaToken.SND.toString());
            fieldVarName.append(" ");
            fieldVarName.append(varName);
            fieldVarName.append(IsaToken.RPAREN.toString());
        }*/
        else 
        {
            assert index > 0; // replicate(0) = ERROR! 
            // repeat (snd x) index-times
            fieldVarName.append(IsaToken.LPAREN.toString());
            fieldVarName.append(IsaToken.SND.toString());
            fieldVarName.append(IsaToken.SPACE.toString());
            if (index > 1)
            {    
                // repeats string f
                fieldVarName.append(IsaTemplates.replicate(fieldVarName.toString(), index-1));
            }
            fieldVarName.append(varName);
            fieldVarName.append(IsaTemplates.replicate(IsaToken.RPAREN.toString(), index));
            
            // add final external fst (snd .... (snd x)) or just final snd 
            if (index < size - 1) 
            {
                return fieldProjection(0, size, fieldVarName.toString());
            }
        }
        return fieldVarName.toString();
    }

    /**
     * Project the field for invariant (and other translations) taking into account whether the user requested
     * a specific var name (i.e. project the pattern out depending on the index, e.g., fst snd varName), or it's
     * a invariant translate for structured types projection (i.e. project the dummy pattern from a locally defined lambda term).
     * @param index
     * @param size
     * @param varName
     * @return
     */
    public static final String fieldFullProjection(long index, long size, String varName)
    {   
        return varName == null ? TRProductType.dummyProjection(index, size) : TRProductType.fieldProjection(index, size, varName);
    } 

    @Override 
    protected String getInvTypeString()
    {
		report(IsaErrorMessage.ISA_INVALID_INVTR_2P, getClass().getSimpleName(), "product type doesn't have inv type string");
        return "";
    }

    @Override
    public Set<String> getDefLemmas()
    {
        return types.getDefLemmas();
    }

    /**
     * If varName is null, product type invariant translate for calls over structured types (e.g. seq of product, set of product, etc.)
     * require different treatment than other types: 
     *      - suppose a type T = X*Y, S = seq of T;
     *      - it would output "inv_VDMSeq inv_T S" and that's fine (i.e. T is a named type)
     *      - not suppose the more explicit S = seq of (X*Y)
     *      - it woudl output "inv_VDMSeq (inv_X /\ inv_Y) S" in normal "invTranslate(null)" calls
     *      - for product types it has to become "inv_VDMSeq (% (x,y) . inv_X x /\ inv_Y y)"! 
     */
    @Override
	public String invTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (!this.types.isEmpty())
		{
			sb.append("\n\t\t");
            sb.append(IsaToken.LPAREN.toString());
            int size = this.types.size();

            // if varName is null, this is part of a structured type invariant translate, hence create local lambda for dummy named projection
            if (varName == null)
            {
                sb.append(IsaToken.LAMBDA.toString());
                sb.append(IsaToken.SPACE.toString());
                sb.append(TRProductType.dummyFullProjection(size, getSemanticSeparator()));
                sb.append(IsaToken.SPACE.toString());
                sb.append(IsaToken.POINT.toString());
                sb.append(IsaToken.SPACE.toString());
            }
            String fieldVarName = TRProductType.fieldFullProjection(0, size, varName);            
			sb.append(this.types.get(0).invTranslate(fieldVarName));

            // For larger products, the answer is to have fst (n-times-snd x), where snd are for all but the last.
            // x: nat * nat * nat * nat = mk_(1,2,3,4)
            // idx=0 x.#1 = fst x             = 1 = fst (1,(2,(3,4)))
            // idx=1 x.#2 = fst (snd x)       = 2 = fst (2,(3,4))
            // idx=2 x.#3 = fst (snd (snd x)) = 3 = fst (3,4)
            // idx=3 x.#4 = snd (snd (snd x)) = 4 = snd (3,4)
			for (int i=1; i < size; i++)
			{
				sb.append(IsaToken.AND.toString());
				sb.append("\n\t\t ");
                fieldVarName = TRProductType.fieldFullProjection(i, size, varName); 
                sb.append(this.types.get(i).invTranslate(fieldVarName));
			}
			sb.append("\n\t\t");
            sb.append(IsaToken.RPAREN.toString());
		}
		return sb.toString();	
	}

    @Override
    public IsaToken isaToken() {
        return IsaToken.CROSSPROD;
    }

    @Override
    public String translate() {
        return IsaToken.parenthesise(this.types.translate());
    }

	@Override
	public <R, S> R apply(TRTypeVisitor<R, S> visitor, S arg)
	{
		return visitor.caseProductType(this, arg);
	}

    @Override
    public void checkForUnionTypes() {
        types.checkForUnionTypes();//"product");
    }

    public static final TRProductType newProductType(LexLocation location, TRTypeList types)
    {
        return TRProductType.newProductType(location, new TRDefinitionList(), types);
    }

    public static final TRProductType newProductType(LexLocation location, TRDefinitionList definitions, TRTypeList types)
    {
        TRProductType result = new TRProductType(new TCProductType(location, types.getVDMTypeList()), definitions, types);
        TRNode.setup(result);
        return result;
    }
}
