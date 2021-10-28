package vdm2isa.tr.patterns;

import vdm2isa.tr.TRNode;

public abstract class TRMultipleBind extends TRNode
{
    private static final long serialVersionUID = 1L;

    public final TRPatternList plist; 

    public TRMultipleBind(TRPatternList plist)
    {
        super(plist.get(0).location);
        this.plist = plist;
    }

    public TRMultipleBindList getMultipleBindList()
    {
      TRMultipleBindList list = new TRMultipleBindList();
      list.add(this);
      return list;
    }

    /**
     * Binds do not support invariant translation in general. Some type-bound binds do and can extend this behaviour.
     */
    @Override
    public String invTranslate()
    {
        report(11111, "Multiple bind \"" + plist.translate() + "\" does not support Isabelle invariant translation.");
        return "";
    }

    /**
     * Binds that allow translation within in comprehension expressions. 
     * @param patternsOnly whether to consider binding type/expr (if availale) or patterns only  
     */
    public abstract String compTranslate(boolean patternsOnly);

}