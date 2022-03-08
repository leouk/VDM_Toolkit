package annotations.tc;

import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

public class TCLemmaAnnotation extends TCTheoremAnnotation {

    private static final long serialVersionUID = 1L;

    public TCLemmaAnnotation(TCIdentifierToken name, TCExpressionList args) {
        super(name, args);
    }
}
