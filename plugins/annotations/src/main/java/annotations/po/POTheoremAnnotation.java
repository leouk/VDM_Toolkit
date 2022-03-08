package annotations.po;

import com.fujitsu.vdmj.po.annotations.POAnnotation;
import com.fujitsu.vdmj.po.expressions.POExpressionList;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;

public class POTheoremAnnotation extends POAnnotation {

    public POTheoremAnnotation(TCIdentifierToken name, POExpressionList args) {
        super(name, args);
    }
    
}
