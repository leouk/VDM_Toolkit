package annotations.po;

import com.fujitsu.vdmj.po.expressions.POExpressionList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

public class POLemmaAnnotation extends POTheoremAnnotation {

    public POLemmaAnnotation(TCIdentifierToken name, POExpressionList args) {
        super(name, args);
    }    
}
