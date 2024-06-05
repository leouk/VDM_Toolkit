package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTLemmaAnnotation extends ASTAnnotation {

    private static final long serialVersionUID = 1L;

    public ASTLemmaAnnotation(LexIdentifierToken name) {
        super(name);
    }
    
}
