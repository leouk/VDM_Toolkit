package vdm2isa.lex;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.tr.TRMappedList;

public class TRIsaCommentList extends TRMappedList<LexComment, TRIsaComment>{
    
    public TRIsaCommentList()
    {
        super();
        setup();
    }

    public TRIsaCommentList(LexCommentList from) throws Exception
    {
        super(from);
        setup();
    }

    private void setup()
    {
        // set format separator as \n given it's called even with one element
        setSeparator(" ");
        setFormattingSeparator("\n");
    }

    public void add(LexLocation location, String comment, boolean block)
    {
        this.add(new TRIsaComment(new LexComment(location, comment, block)));
    }		
}
