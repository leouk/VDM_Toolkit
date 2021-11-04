package vdm2isa.lex;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.tr.TRMappedList;

public class TRIsaVDMCommentList extends TRMappedList<LexComment, TRIsaVDMComment>{
    
    protected TRIsaVDMCommentList()
    {
        super();
    }

    public TRIsaVDMCommentList(LexCommentList from) throws Exception
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
        this.add(new TRIsaVDMComment(new LexComment(location, comment, block)));
    }

    @Override
    public String translate()
    {
        StringBuilder sb = new StringBuilder();
        // add final formatting separator to separate the last comment in the list from the remaining associated definitions
        sb.append(getFormattingSeparator());
        return sb.toString();
    }
    
    public static TRIsaVDMCommentList newComment(LexLocation location, String comment, boolean block)
    {
        TRIsaVDMCommentList result = new TRIsaVDMCommentList();
        result.add(location, comment, block);
        return result;
    }
}
