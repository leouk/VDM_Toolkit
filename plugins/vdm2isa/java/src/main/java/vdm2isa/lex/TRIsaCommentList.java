package vdm2isa.lex;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;
import com.fujitsu.vdmj.lex.LexLocation;

import vdm2isa.tr.TRMappedList;

public class TRIsaCommentList extends TRMappedList<LexComment, TRIsaComment>{
    
    public TRIsaCommentList()
    {
        super();
    }

    public TRIsaCommentList(LexCommentList from) throws Exception
    {
        super(from);
    }

    public void add(LexLocation location, String comment, boolean block)
    {
        this.add(new TRIsaComment(new LexComment(location, comment, block)));
    }		
}
