package vdm2isa.tr.annotations;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.annotations.TCAnnotationList;

import vdm2isa.lex.IsaToken;
import vdm2isa.tr.TRMappedList;

public class TRAnnotationList extends TRMappedList<TCAnnotation, TRAnnotation> {
    
    public TRAnnotationList()
    {
        super();
    }

    public TRAnnotationList(TCAnnotationList from) throws Exception
    {
        super(from);
    }

    @Override
    public void setup()
    {
        super.setup();
        // set format separator as \n given it's called even with one element
        setSemanticSeparator(IsaToken.SPACE.toString());
        setFormattingSeparator("\n");
    }

    public TCAnnotationList getVDMAnnotationList()
    {
        TCAnnotationList result = new TCAnnotationList();
        for(TRAnnotation a : this)
        {
            result.add(a.getVDMAnnotation());
        }
        return result;
    }
}
