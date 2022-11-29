package annotations.ast;

import com.fujitsu.vdmj.ast.annotations.ASTAnnotation;
import com.fujitsu.vdmj.ast.lex.LexIdentifierToken;

public class ASTtodoAnnotation extends ASTAnnotation {
    
    public ASTtodoAnnotation(LexIdentifierToken name) {
        super(name);
    }
}
