package vdm2isa.tr.templates;

import com.fujitsu.vdmj.lex.LexLocation;

public class IsaTemplateException extends RuntimeException {

    public final LexLocation location;
    public IsaTemplateException(LexLocation loc, String msg)
    {
        super(msg);
        location = loc;
    }    
}
