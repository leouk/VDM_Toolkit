package vdm2isa.lex;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.tr.TRMappedList;

public class TRIsaCommentList extends TRMappedList<LexComment, TRIsaComment>{
    
    protected TRIsaCommentList()
    {
        super();
    }

    public TRIsaCommentList(LexCommentList from) throws Exception
    {
        super(from);
    }

    @Override
    protected void setup()
    {
        super.setup();
        // set format separator as \n given it's called even with one element
        setSemanticSeparator(" ");
        setFormattingSeparator("\n");
    }

    public void add(LexLocation location, String comment, boolean block)
    {
        this.add(new TRIsaComment(new LexComment(location, comment, block)));
    }
    
    public static TRIsaCommentList newComment(LexLocation location, String comment, boolean block)
    {
        TRIsaCommentList result = new TRIsaCommentList();
        result.add(location, comment, block);
        return result;
    }
}
