package vdm2isa.tr.patterns;


import com.fujitsu.vdmj.tc.patterns.TCMultipleTypeBind;
import com.fujitsu.vdmj.tc.patterns.TCPatternList;
import com.fujitsu.vdmj.tc.patterns.TCTypeBind;
import com.fujitsu.vdmj.tc.patterns.TCTypeBindList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;
import vdm2isa.tr.types.TRType;

public class TRMultipleTypeBind extends TRMultipleBind {
    
    private static final long serialVersionUID = 1L;

    public final TRType type;

    private static TCMultipleTypeBind figureOutMultipleBind(TCTypeBind tc)
    {
        TCMultipleTypeBind result = null;
        if (tc != null)
        {
            TCPatternList plist = new TCPatternList();
            plist.add(tc.pattern);
            result = new TCMultipleTypeBind(plist, tc.type);
        }
        return result;
    }

    public TRMultipleTypeBind(TCTypeBind tc, TRPattern pattern, TRType type)
    {
        this(figureOutMultipleBind(tc), 
            pattern != null ? pattern.getPatternList() : new TRPatternList(), type);
    }

    public TRMultipleTypeBind(TCMultipleTypeBind tc, TRPatternList plist, TRType type)
    {
        super(tc, plist);
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

    /**
     * TRMultipleTypeBind coalesces TCTypeBind and TCMultipleTypeBind
     * @return
     */
    public TCTypeBindList getTCTypeBindList()
    {
        TCTypeBindList result = new TCTypeBindList();
        for(TRPattern p : plist)
        {
            result.add(new TCTypeBind(p.getVDMPattern(), type.getVDMType()));            
        }
        return result;
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
        // for bounded typed expressions, make sure we use the "inv_T" (atTLD) instead of its parts! 
        boolean old = type.setAtTopLevelDefinition(true, true);
        String result = invTr ? IsaToken.parenthesise(type.invTranslate(plist.get(index).translate())) : type.translate();
        type.setAtTopLevelDefinition(old, true);
        return result;
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
    public TRMultipleBindKind getMultipleBindKind()
    {
        return TRMultipleBindKind.TYPE;
    }

	@Override
	public <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg)
	{
		return visitor.caseMultipleTypeBind(this, arg);
	}

    public static final TRMultipleTypeBind newMultipleTypeBind(TRPattern p, TRType t)
    {   
        TRMultipleTypeBind result = new TRMultipleTypeBind(new TCTypeBind(p.getVDMPattern(), t.getVDMType()), p, t);
        TRNode.setup(result);
        return result;
    }

    public static final TRMultipleTypeBind newMultipleTypeBind(TRPatternList plist, TRType t)
    {   
        TRMultipleTypeBind result = new TRMultipleTypeBind(new TCMultipleTypeBind(plist.getVDMPatternList(), t.getVDMType()), plist, t);
        TRNode.setup(result);
        return result;
    }

}
