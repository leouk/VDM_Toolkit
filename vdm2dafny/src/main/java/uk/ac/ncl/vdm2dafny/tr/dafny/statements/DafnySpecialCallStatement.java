package uk.ac.ncl.vdm2dafny.tr.dafny.statements;

import java.util.Map;

import com.fujitsu.vdmj.ast.lex.LexNameToken;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.statements.TCCallStatement;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.lex.DafnyToken;

public class DafnySpecialCallStatement extends DafnyCallStatement {
    private static Map<TCNameToken, DafnyToken> tokMap = Map.of(
        new TCNameToken(new LexNameToken("IO", "println", LexLocation.ANY)), DafnyToken.PRINTLN,
        new TCNameToken(new LexNameToken("IO", "printf", LexLocation.ANY)), DafnyToken.PRINTF,
        new TCNameToken(new LexNameToken("IO", "print", LexLocation.ANY)), DafnyToken.PRINT
    );
    public static final boolean is(TCCallStatement stmt) {
        return tokMap.containsKey(stmt.name);
    }
    
    
    public DafnySpecialCallStatement(TCCallStatement stmt, FlatEnvironment env) {
        super(stmt, env);
    }
}
