package vdm2isa.tr.types;

import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.lex.IsaToken;

public class TRProductType extends TRType {
    private static final long serialVersionUID = 1L;

    private final TRTypeList types;

    public TRProductType(LexLocation location, TRTypeList types)
    {
        super(location);
        this.types = types;
        this.types.setCurried(false);
    }

    @Override
	public String invTranslate(String varName)
	{
		StringBuilder sb = new StringBuilder();
		if (!this.types.isEmpty())
		{
			sb.append("(");
            String fieldVarName = varName == null ? "" : IsaToken.LPAREN.toString() + IsaToken.FST.toString() + " " + varName + IsaToken.RPAREN.toString(); 
			sb.append(this.types.get(0).invTranslate(fieldVarName));

			for (int i=1; i< this.types.size(); i++)
			{
				sb.append(IsaToken.AND.toString());
				sb.append("\n\t\t");
                // odd indices are even fields: 
                // 4 fields = fst x, (fst (snd x)) 
                //@todo! 
                //if (i / 2 != 0)
				sb.append(this.types.get(i).invTranslate(fieldVarName));
                sb.append(IsaToken.COMMENT.toString());
                sb.append(IsaToken.COMMENT_OPEN.toString());
                sb.append("TODO! This is messy, but easy: fst, fst snd, fst snd snd, snd snd snd say for 4-tuple");
                sb.append(IsaToken.COMMENT_CLOSE.toString());
                
			}
			sb.append(")");
		}
		return sb.toString();	
	}

    @Override
    public IsaToken isaToken() {
        return IsaToken.CROSSPROD;
    }

    @Override
    public String translate() {
        return IsaToken.LPAREN.toString() + this.types.translate() + IsaToken.RPAREN.toString();
    }
}
