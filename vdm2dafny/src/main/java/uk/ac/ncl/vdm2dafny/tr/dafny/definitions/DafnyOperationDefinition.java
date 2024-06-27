package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitOperationDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitOperationDefinition;
import com.fujitsu.vdmj.tc.definitions.TCLocalDefinition;
import com.fujitsu.vdmj.tc.statements.TCExternalClause;
import com.fujitsu.vdmj.tc.statements.TCNotYetSpecifiedStatement;
import com.fujitsu.vdmj.tc.types.TCUndefinedType;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyParamPattern;
import uk.ac.ncl.vdm2dafny.tr.dafny.statements.DafnyStatement;

public class DafnyOperationDefinition extends DafnyDefinition{
    private TCDefinition op;
    
    private DafnyFunctionDefinition predef;
    private DafnyFunctionDefinition postdef;
    private DafnyStatement body;
    private String returnType;
    // private List<String> typeParams;
    private List<DafnyParamDefinition> paramList;
    private List<DafnyExternalDefinition> exts;

    /**
     * Constructor operations are ignored as they are only in PP/RT, which are not targeted in this tool.
     * @param op Operation definition.
     */
    public DafnyOperationDefinition(TCDefinition op) {
        if (op == null) return;
        this.op = op;
        FlatEnvironment env = DafnyEnvironment.instance().globalEnv();
        if (isImplicit()) {
            final TCImplicitOperationDefinition iop = implicit();
            this.predef         = new DafnyFunctionDefinition(iop.predef);
            this.postdef        = new DafnyFunctionDefinition(iop.postdef);
            this.body           = iop.body == null ? null : DafnyStatement.of(iop.body, env);
            this.paramList     = iop.paramDefinitions != null ? 
                iop.paramDefinitions.stream()
                    .filter(definition -> definition instanceof TCLocalDefinition)
                    .map(definition -> new DafnyParamDefinition(definition))
                    .collect(Collectors.toList()) : List.of();

            this.exts = 
                iop.externals == null ? List.of() :
                iop.externals.stream()
                    .map(ext -> new DafnyExternalDefinition((TCExternalClause)ext))
                    .collect(Collectors.toList());
            this.returnType     = DafnyTypeNames.instance().getTypeName(iop.type.result);
        }
        else if (isExplicit()) {
            final TCExplicitOperationDefinition eop = explicit();
            this.predef         = new DafnyFunctionDefinition(eop.predef);
            this.postdef        = new DafnyFunctionDefinition(eop.postdef);
            this.body           = eop.body == null ? null : DafnyStatement.of(eop.body, env);
            this.paramList     = eop.paramDefinitions != null ? 
                eop.paramDefinitions.stream()
                    .map(definition -> new DafnyParamDefinition(definition))
                    .collect(Collectors.toList()) : List.of();
            // this.paramList      = DafnyParamDefinition.from(eop.paramDefinitions);
            this.exts = List.of();
            this.returnType     = DafnyTypeNames.instance().getTypeName(eop.type.result);
        }
    }

    private TCImplicitOperationDefinition implicit() {
        assert isImplicit();
        return (TCImplicitOperationDefinition)op;
    }
    
    private TCExplicitOperationDefinition explicit() {
        assert isExplicit();
        return (TCExplicitOperationDefinition)op;
    }

    private boolean isExplicit() {
        return op instanceof TCExplicitOperationDefinition;
    }
    
    private boolean isImplicit() {
        return op instanceof TCImplicitOperationDefinition;
    }

    @Override
    public String translate() {
        return DafnyTemplates.DEFINITIONS.render("operation", Pair.of("op", this));
    }

    @Override
    public TCDefinition getVDM() {
        return op;
    }

    @Override
    public boolean isLocal() {
        return false;
    }
    

    public String getName() {
        return DafnyIdentifiers.instance().transform(op.name);
    }


    public String getPredef() {
        return predef.translate();
    }

    public DafnyFunctionDefinition getPreDefObj() {
        return predef;
    }

    public String getPostdef() {
        return postdef.translate();
    }
    
    public DafnyFunctionDefinition getPostDefObj() {
        return postdef;
    }

    public List<DafnyParamDefinition> getParams() {
        return paramList;
    }

    public boolean hasPrecondition() {
        return this.postdef != null;
    }

    public boolean hasPostcondition() {
        return this.predef != null;
    }

    public boolean hasBodyStatement() {
        return this.body != null || this.body.getVDM() instanceof TCNotYetSpecifiedStatement;
    }

    public String getBody() {
        return body.translate();
    }

    public boolean hasReturn() {
        if (isExplicit()) {
            return explicit().type.result instanceof TCUndefinedType;
        }
        else {
            assert isImplicit();
            return implicit().type.result instanceof TCUndefinedType;
        }
    }

    public String getReturnType() {
        return returnType;
    }

    public boolean hasSig() {
        return hasPrecondition() || hasPostcondition();
    }

    public boolean hasReconcilablePatterns() {
        return paramList.stream().anyMatch(p -> p.reconciliations.size() > 0);
    }

    public List<String> getReconciledPatterns() {
        return paramList.stream().filter(p -> p.reconciliations.size() > 0).flatMap(p -> p.reconciliations.stream().map(pattern -> pattern.translate())).collect(Collectors.toList());
        // return paramPatterns.stream().filter(pattern -> pattern.isReconcilable()).map(pattern -> pattern.translate()).collect(Collectors.toList());
    }

    public String getReconciliation() {
        List<DafnyParamPattern> pa = paramList.stream().filter(p -> p.reconciliations.size() > 0).flatMap(p -> p.reconciliations.stream()).collect(Collectors.toList());
        return pa.stream()
        .map(p -> 
            DafnyTemplates.DEFINITIONS.render("reconcile",
                Pair.of("pattern", p.internal.translate()),
                Pair.of("valid", !p.internal.checkValidAssignment()),
                Pair.of("value", p.reconciledVar),
                Pair.of("vars",  p.internal.getVariables())
            )
        ).collect(Collectors.joining("\n"));
    }

    public List<DafnyExternalDefinition> getExt() {
        return exts;
    }
    
    public boolean hasExternals() {
        return exts.size() > 0;
    }

    public boolean isSpecified() {
        return hasBodyStatement();
    }
}
