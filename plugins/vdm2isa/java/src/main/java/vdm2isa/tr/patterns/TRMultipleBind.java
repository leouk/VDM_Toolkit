package vdm2isa.tr.patterns;

import vdm2isa.tr.TRNode;
import vdm2isa.tr.patterns.visitors.TRMultipleBindVisitor;

public abstract class TRMultipleBind extends TRNode
{
    private static final long serialVersionUID = 1L;

    public final TRPatternList plist; 

    /**
     * PO binds have to be treated carefully, as the implicit checks for their type invariants have to be taken into account.
     * Moreover, depending on the bind and on the bounded expression it belongs to, various adjustments are needed. 
     * e.g., forall x, y in set S & P =>
     */
    public boolean poBind;

    public TRMultipleBind(TRPatternList plist)
    {
        super(plist.get(0).location);
        this.plist = plist;
        this.poBind = false;
    }

    public TRMultipleBindList getMultipleBindList()
    {
      TRMultipleBindList list = new TRMultipleBindList();
      list.add(this);
      return list;
    }

    /**
     * Binds that allow translation within in comprehension expressions. 
     * @param patternsOnly whether to consider binding type/expr (if availale) or patterns only  
     */
    public abstract String compTranslate(boolean patternsOnly);

    public abstract TRNode getRHS();

	public abstract <R, S> R apply(TRMultipleBindVisitor<R, S> visitor, S arg);
}
