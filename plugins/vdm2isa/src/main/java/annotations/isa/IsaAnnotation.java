package annotations.isa;

import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.mapper.MappingOptional;

import vdm2isa.tr.TRNode;

public abstract class IsaAnnotation extends TRNode implements MappingOptional {

    protected IsaAnnotation(LexLocation location) {
        super(location);
        //TODO Auto-generated constructor stub
    }
    
}
