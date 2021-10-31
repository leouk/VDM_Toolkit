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
        setFormattingSeparator("\n");
    }

    @Override
    public IsaToken isaToken() {
        return IsaToken.COMMENT;
    }

    @Override
    public String translate() {
        StringBuilder sb = new StringBuilder();
        if (Vdm2isaPlugin.printVDMComments) 
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
            sb.append(comment);
            sb.append(getFormattingSeparator());

            if (comment.block)
                sb.append(IsaToken.BLOCK_COMMENT_CLOSE.toString());

            sb.append(getFormattingSeparator());
		}
        return comment.block ? sb.toString() : IsaToken.comment(sb.toString());
    }

    @Override
    public String invTranslate() {
        return translate();
    }
}
