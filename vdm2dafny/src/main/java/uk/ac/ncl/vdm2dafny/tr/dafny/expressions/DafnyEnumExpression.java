package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCMapEnumExpression;
import com.fujitsu.vdmj.tc.expressions.TCMkBasicExpression;
import com.fujitsu.vdmj.tc.expressions.TCSeqEnumExpression;
import com.fujitsu.vdmj.tc.expressions.TCSetEnumExpression;
import com.fujitsu.vdmj.tc.expressions.TCTupleExpression;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;

public class DafnyEnumExpression extends AbstractDafnyExpression {
    private enum Type {SET, SEQ, MAP, TUPLE, MKBASIC}
    private TCExpression exp;
    private Type type;

    public DafnyEnumExpression(TCSeqEnumExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
        this.type = Type.SEQ;
    }
    
    public DafnyEnumExpression(TCSetEnumExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
        this.type = Type.SET;
    }
    
    public DafnyEnumExpression(TCMapEnumExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
        this.type = Type.MAP;
    }

    public DafnyEnumExpression(TCTupleExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
        this.type = Type.TUPLE;
    }

    public DafnyEnumExpression(TCMkBasicExpression exp, FlatEnvironment env) {
        super(exp, env);
        this.exp = exp;
        this.type = Type.MKBASIC;
    }

    public static final boolean is(TCExpression exp) {
        return  exp instanceof TCSeqEnumExpression
            ||  exp instanceof TCSetEnumExpression
            ||  exp instanceof TCMapEnumExpression
            ||  exp instanceof TCTupleExpression
            ||  exp instanceof TCMkBasicExpression;
    }

    public static final DafnyEnumExpression of(TCExpression exp, FlatEnvironment env) {
        return  exp instanceof TCSeqEnumExpression  ? new DafnyEnumExpression((TCSeqEnumExpression)exp, env)
            :   exp instanceof TCSetEnumExpression  ? new DafnyEnumExpression((TCSetEnumExpression)exp, env)
            :   exp instanceof TCMapEnumExpression  ? new DafnyEnumExpression((TCMapEnumExpression)exp, env)
            :   exp instanceof TCTupleExpression    ? new DafnyEnumExpression((TCTupleExpression)exp, env)
            :   exp instanceof TCMkBasicExpression  ? new DafnyEnumExpression((TCMkBasicExpression)exp, env)
            :   null;
    }

    @Override
    public String translate() {
        String result;
        switch (type) {
            case MAP:
                result = "map[" + ((TCMapEnumExpression)exp).members.stream()
                    .map(e -> new DafnyMapletExpression(e, env).translate())
                    .collect(Collectors.joining(", ")) + "]";
                break;
            case SEQ:
                result = "[" + ((TCSeqEnumExpression)exp).members.stream()
                    .map(e -> DafnyExpression.of(e, env).translate())
                    .collect(Collectors.joining(", ")) + "]";
                break;
            case SET:
                result = "{" + ((TCSetEnumExpression)exp).members.stream()
                    .map(e -> DafnyExpression.of(e, env).translate())
                    .collect(Collectors.joining(", ")) + "}";
                break;
            case TUPLE:
                result = "(" + ((TCTupleExpression)exp).args.stream()
                    .map(e -> DafnyExpression.of(e, env).translate())
                    .collect(Collectors.joining(", ")) + ")";
                break;
            case MKBASIC:
                result = "mk_" + DafnyTypeNames.instance().getTypeName(((TCMkBasicExpression)exp).type) + "(" + DafnyExpression.of(((TCMkBasicExpression)exp).arg, env).translate() + ")";
                break;
            default:
                result = "Should never ever see this";
        }
        return result;
    }

    @Override
    public TCExpression getVDM() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getVDM'");
    }

}
