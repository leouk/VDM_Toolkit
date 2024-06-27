package uk.ac.ncl.vdm2dafny.tr.dafny;

import com.fujitsu.vdmj.ast.lex.LexComment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;

public class DafnyVDMComment {
    private LexComment comment;
    public DafnyVDMComment(LexComment comment) {
        this.comment = comment;
    }

    private boolean isBlock() {
        return comment.block;
    }

    public String getMessage() {
        if (isBlock()) {
            return DafnyTemplates.MESSAGES.render("block", Pair.of("message", comment.comment));
        }
        else {
            return DafnyTemplates.MESSAGES.render("comment", Pair.of("message", comment.comment));
        }
    }
}
