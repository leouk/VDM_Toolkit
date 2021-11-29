package vdm2isa.tr.patterns;


import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.types.TRType;

public class TRMultipleTypeBind extends TRMultipleBind {
    
    private static final long serialVersionUID = 1L;

    public final TRType type;

    public TRMultipleTypeBind(TRPattern pattern, TRType type)
    {
        this(pattern != null ? pattern.getPatternList() : new TRPatternList(), type);
    }

    public TRMultipleTypeBind(TRPatternList plist, TRType type)
    {
        super(plist);
        this.type = type;
    }
    @Override 
    public void setup()
    {
        super.setup();
        TRNode.setup(type);
    }

    @Override
    public String toString()
    {
        return super.toString() + " " + String.valueOf(plist) + ": " + String.valueOf(type); 
    }

    @Override
    public boolean getParenthesise()
    {
        return true;//always parenthesise type binds, regardless
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.TYPEOF;
    }

    @Override
    public String compTranslate(boolean vdmPatternsOnly)
    {
        StringBuilder sb = new StringBuilder();
        sb.append(plist.translate());
        sb.append(getFormattingSeparator());
        sb.append(isaToken().toString());
        sb.append(getFormattingSeparator());
        sb.append(getRHS().translate());
        return IsaToken.parenthesise(sb.toString());
    }

    @Override
    public String boundExpressionTranslate(int index, boolean invTr) {
        assert index >= 0 && index < plist.size();
        return invTr ? IsaToken.parenthesise(type.invTranslate(plist.get(index).translate())) : type.translate();
    }

    @Override
    public TRNode getRHS() {
        return type;
    }

    @Override 
    public TRType getRHSType()
    {
        return type;
    }

	@Override
	public <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMultipleTypeBind(this, arg);
	}
}
