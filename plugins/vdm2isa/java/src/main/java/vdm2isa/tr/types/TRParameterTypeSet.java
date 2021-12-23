package vdm2isa.tr.types;

public class TRParameterTypeSet extends TRTypeSet
{
    public TRParameterTypeSet()
    {
        super();
    }    

    @Override
    public boolean add(TRType t)
    {
        return t instanceof TRParameterType ? super.add(t) : false;
    }
}
