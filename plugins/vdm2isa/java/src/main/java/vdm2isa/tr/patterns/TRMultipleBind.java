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
}