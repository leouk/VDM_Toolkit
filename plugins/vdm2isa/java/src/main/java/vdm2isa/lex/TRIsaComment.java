package vdm2isa.lex;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.lex.LexLocation;

import plugins.Vdm2isaPlugin;
import vdm2isa.tr.TRNode;

public class TRIsaComment extends TRNode {
	private static final long serialVersionUID = 1L;
    
    private final LexComment comment;

    public TRIsaComment(LexComment comment)
    {
        super(comment.location);
        this.comment = comment;
        setSemanticSeparator(" ");
        setFormattingSeparator("\n");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.COMMENT;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        // only print comments if desired and if sensible
        if (Vdm2isaPlugin.printVDMComments && comment.comment != null && comment.comment.length() > 0) 
		{
            if (comment.block)
            {
                sb.append(IsaToken.BLOCK_COMMENT_OPEN.toString());
            }

            if (location != null && location != LexLocation.ANY)
            {    
                sb.append("@ ");
                sb.append(location.toString());
                sb.append(getFormattingSeparator());
            }
            sb.append(comment.comment);
            sb.append(getFormattingSeparator());

            if (comment.block)
            {
                sb.append(IsaToken.BLOCK_COMMENT_CLOSE.toString());
            }
            else
            {
                sb = new StringBuilder(IsaToken.comment(sb.toString()));
            }
            sb.append(getFormattingSeparator());
		}
        return sb.toString();
    }

    @Override
    public String invTranslate() {
        return translate();
    }
}
