package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTTheoremAnnotation extends ASTAnnotation {

    private static final long serialVersionUID = 1L;

    public ASTTheoremAnnotation(LexIdentifierToken name) {
        super(name);
    }
    
}
