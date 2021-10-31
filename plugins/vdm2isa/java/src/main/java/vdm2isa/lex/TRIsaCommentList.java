package vdm2isa.lex;

import com.fujitsu.vdmj.ast.lex.LexComment;
import com.fujitsu.vdmj.ast.lex.LexCommentList;

import vdm2isa.tr.TRMappedList;

public class TRIsaCommentList extends TRMappedList<LexComment, TRIsaComment>{
    
    public TRIsaCommentList(LexCommentList from) throws Exception
    {
        super(from);
    }
}
