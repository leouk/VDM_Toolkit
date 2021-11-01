package vdm2isa.tr.patterns;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.types.TRType;

public class TRMultipleTypeBind extends TRMultipleBind {
    
    private static final long serialVersionUID = 1L;

    private final TRType type;

    public TRMultipleTypeBind(TRPattern pattern, TRType type)
    {
        this(pattern.getPatternList(), type);
    }

    public TRMultipleTypeBind(TRPatternList plist, TRType type)
    {
        super(plist);
        this.type = type;
        setSemanticSeparator(" ");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.INSET;
    }

    protected String invTranslate(int index)
    {
        assert index >= 0 && index < plist.size();
        return IsaToken.parenthesise(IsaToken.INV + type.translate() + " " + plist.get(index).translate());
    }

    @Override
    public String invTranslate()
    {
        StringBuilder sb = new StringBuilder();
		if (!plist.isEmpty())
		{
			sb.append(invTranslate(0));
            for (int i=1; i<plist.size(); i++)
			{
                sb.append(" " + IsaToken.AND.toString() + " ");
				sb.append(invTranslate(i));
			}
		}
		return sb.toString();
    }

    @Override
    public String compTranslate(boolean patternsOnly)
    {
        return IsaToken.parenthesise(plist.translate() + " " + IsaToken.TYPEOF + " " + type.translate());
    }

    protected String translate(int index, String typeStr)
    {
        assert index >= 0 && index < plist.size();
        return IsaToken.parenthesise(plist.get(index).translate() + typeStr);
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
		if (!plist.isEmpty())
		{
            // translate each item with it's type case, e.g. "(x::VDMNat)"
            String typeStr = IsaToken.TYPEOF.toString() + type.translate();
			sb.append(translate(0, typeStr));

            for (int i = 1; i < plist.size(); i++)
			{
                //TODO doesn't this need a separator? Like " "?
                sb.append(getSemanticSeparator());
                sb.append(getFormattingSeparator());
				sb.append(translate(i, typeStr));
			}
		}
		return sb.toString();
    }

    @Override
    public TRNode getRHS() {
        return type;
    }

	@Override
	public <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMultipleTypeBind(this, arg);
	}
}
