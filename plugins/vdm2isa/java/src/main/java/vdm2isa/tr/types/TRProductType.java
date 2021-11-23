package vdm2isa.tr.types;

import com.fujitsu.vdmj.tc.types.TCProductType;

import vdm2isa.lex.IsaTemplates;
import vdm2isa.lex.IsaToken;
import vdm2isa.tr.definitions.TRDefinitionList;
import vdm2isa.tr.types.visitors.TRTypeVisitor;

public class TRProductType extends TRType {
    private static final long serialVersionUID = 1L;

    public final TRTypeList types;

    public TRProductType(TCProductType vdmType, TRDefinitionList definitions, TRTypeList types)
    {
        super(vdmType, definitions);
        this.types = types;
        this.types.setCurried(false);
    }

    @Override
	public TRType copy(boolean atTLD)
	{
		TRType result = new TRProductType((TCProductType)getVDMType(), definitions, types.copy(atTLD));
		result.setAtTopLevelDefinition(atTLD);
		return result;
	}   

    /**
     * Isabelle only have tuples (or pairs). So, VDM n-tuples have to be projected out of pairs. 
     * @param index which tuple index (e.g. x.#index) adjusted to size (i.e. x.#index, where index [0,...,size[, instead of [1,...size])
     * @param size overall tuple size
     * @param varName variable name being projected out (e.g., varName.#index)
     * @return Isabelle projection as combination of multiple fst/snd expressions over varName depending on index.
     */
    public static String fieldProjection(long index, long size, String varName)
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

    @Override
	public String invTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (!this.types.isEmpty())
		{
			sb.append("\n\t\t");
            sb.append(IsaToken.LPAREN.toString());
            int size = this.types.size();
            String fieldVarName = varName == null ? "" : TRProductType.fieldProjection(0, size, varName); 
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
                fieldVarName = varName == null ? "" : TRProductType.fieldProjection(i, size, varName); 
                sb.append(this.types.get(i).invTranslate(fieldVarName));
                //sb.append(IsaToken.COMMENT.toString());
                //sb.append(IsaToken.COMMENT_OPEN.toString());
                //sb.append("This is messy, but easy: fst, fst snd, fst snd snd, snd snd snd say for 4-tuple");
                //sb.append(IsaToken.COMMENT_CLOSE.toString()); 
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
}
