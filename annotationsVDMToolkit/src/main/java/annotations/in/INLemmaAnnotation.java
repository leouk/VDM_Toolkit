package annotations.in;

import com.fujitsu.vdmj.in.expressions.INExpressionList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

public class INLemmaAnnotation extends INTheoremAnnotation {

    public INLemmaAnnotation(TCIdentifierToken name, INExpressionList args) {
        super(name, args);
    }    
}
