package uk.ac.ncl.vdm2dafny.tr.dafny.patterns;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCMultiBindListDefinition;
import com.fujitsu.vdmj.tc.patterns.TCMultipleBind;
import com.fujitsu.vdmj.tc.patterns.TCMultipleSeqBind;
import com.fujitsu.vdmj.tc.patterns.TCMultipleSetBind;
import com.fujitsu.vdmj.tc.patterns.TCMultipleTypeBind;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeDefinition;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyTypeNames;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;

public class DafnyMultipleBind extends DafnyBind {
    private enum TYPE{SET("in"), SEQ("in"), TYPE("is"), UNKNOWN("SHOULD NOT SEE THIS");
        public String keyword;
        private TYPE(String keyword) {this.keyword = keyword;}
    };
    private TCMultipleBind bind;
    private TYPE bindType;
    private FlatEnvironment env;

    public DafnyMultipleBind(TCMultipleBind bind, FlatEnvironment env) {
        this.env = env;
        bindType = bind instanceof TCMultipleSeqBind ? TYPE.SEQ
            :   bind instanceof TCMultipleSetBind ? TYPE.SET
            :   bind instanceof TCMultipleTypeBind ? TYPE.TYPE
            :   TYPE.UNKNOWN;
        this.bind = bind;
    }

    public List<String> getPatterns() {
        switch(bindType) {
            case SEQ:  
                return DafnyPattern.from(((TCMultipleSeqBind)bind).plist)
                    .stream().map(p -> p.translate())
                    .collect(Collectors.toList());
            case SET:   
                return DafnyPattern.from(((TCMultipleSetBind)bind).plist)
                    .stream().map(p -> p.translate())
                    .collect(Collectors.toList());
            case TYPE:  
                return DafnyPattern.from(((TCMultipleTypeBind)bind).plist)
                    .stream().map(p -> p.translate())
                    .collect(Collectors.toList());
            default:
                return List.of("SHOULD NEVER EVER SEE THIS");

        }
    }

    public String getKeyword() {
        return bindType.keyword;
    }
    
    public String getBinding() {
        switch(bindType) {
            case SEQ: 
                return DafnyExpression.of(((TCMultipleSeqBind)bind).sequence, env).translate();
            case SET:   
                return DafnyExpression.of(((TCMultipleSetBind)bind).set, env).translate();
            case TYPE:  
                return DafnyTypeNames.instance().getTypeName(((TCMultipleTypeBind)bind).type);
            default:
                return "SHOULD NEVER EVER SEE THIS";

        }
    }

    public String translate() {
        return DafnyTemplates.EXPRESSIONS.render("multibind", Pair.of("bind", this));
    }

    public static List<DafnyMultipleBind> of(TCDefinition def, FlatEnvironment env) {
        assert def instanceof TCMultiBindListDefinition;
        List<DafnyMultipleBind> result = new ArrayList<>();
        for (TCMultipleBind bind: ((TCMultiBindListDefinition)def).bindings) {
            result.add(new DafnyMultipleBind(bind, env));
        }
        return result;
    }

    @Override
    public String getName() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getName'");
    }

    @Override
    public DafnyTypeDefinition getType() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getType'");
    }
}