package vdm2isa.tr.patterns;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.types.TRType;

public class TRMultipleTypeBind extends TRMultipleBind {
    
    private static final long serialVersionUID = 1L;

    private TRType type;

    public TRMultipleTypeBind(TRPattern pattern, TRType type)
    {
        this(pattern.getPatternList(), type);
    }

    public TRMultipleTypeBind(TRPatternList plist, TRType type)
    {
        super(plist);
        this.type = type;
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.INSET;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
		
		if (!plist.isEmpty())
		{
            String typeStr = IsaToken.TYPEOF.toString() + type.translate();
			sb.append(IsaToken.LPAREN.toString());
            sb.append(plist.get(0).translate());
            sb.append(typeStr);
            sb.append(IsaToken.RPAREN.toString());

            for (int i=1; i<plist.size(); i++)
			{
				sb.append(IsaToken.LPAREN.toString());
                sb.append(plist.get(0).translate());
                sb.append(typeStr);
                sb.append(IsaToken.RPAREN.toString());
			}
		}
		return sb.toString();
    }
}
