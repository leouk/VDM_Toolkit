package vdm2isa.lex;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.tr.TRMappedList;
import vdm2isa.tr.TRNode;

public class TRIsaVDMCommentList extends TRMappedList<LexComment, TRIsaVDMComment>{
    
    public TRIsaVDMCommentList()
    {
        super();
    }

    public TRIsaVDMCommentList(LexCommentList from) throws Exception
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

    public void add(LexLocation location, String comment, boolean block)
    {
        this.add(TRIsaVDMComment.newIsaVDMComment(new LexComment(location, comment, block)));
    }

    @Override
    public String translate()
    {
        StringBuilder sb = new StringBuilder();
        // add final formatting separator to separate the last comment in the list from the remaining associated definitions
        sb.append(getFormattingSeparator());
        return sb.toString();
    }
    
    public static final TRIsaVDMCommentList newComment(LexLocation location, String comment, boolean block)
    {
        TRIsaVDMCommentList result = new TRIsaVDMCommentList();
        result.add(location, comment, block);
        TRNode.setup(result);
        return result;
    }
}
