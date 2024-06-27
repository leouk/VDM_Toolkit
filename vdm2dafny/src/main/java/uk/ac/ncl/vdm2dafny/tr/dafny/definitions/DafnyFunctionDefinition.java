package uk.ac.ncl.vdm2dafny.tr.dafny.definitions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.definitions.TCExplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.definitions.TCImplicitFunctionDefinition;
import com.fujitsu.vdmj.tc.expressions.TCNotYetSpecifiedExpression;
import com.fujitsu.vdmj.tc.types.TCBooleanType;
import com.fujitsu.vdmj.tc.types.TCNamedType;
import com.fujitsu.vdmj.tc.types.TCQuoteType;
import com.fujitsu.vdmj.tc.types.TCType;
import com.fujitsu.vdmj.tc.types.TCUnionType;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;
import com.fujitsu.vdmj.typechecker.NameScope;

import uk.ac.ncl.plugins.commands.DafnyTranslateCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.util.Pair;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.env.DafnyEnvironment;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.DafnyExpression;
import uk.ac.ncl.vdm2dafny.tr.dafny.patterns.DafnyParamPattern;

public class DafnyFunctionDefinition extends DafnyDefinition {
    private TCDefinition func;
    private NameScope scope; 


    private DafnyFunctionDefinition predef;
    private DafnyExpression precondition;
    private DafnyFunctionDefinition postdef;
    private DafnyExpression postcondition;
    private DafnyExpression body;
    private DafnyExpression measure;
    private String returnType;
    private List<String> typeParams;
    private List<DafnyParamDefinition> paramList;

    
    public DafnyFunctionDefinition(TCDefinition func) {
        if (func == null) return;
        this.func = func;
        this.scope = func.nameScope;
        FlatEnvironment env = DafnyEnvironment.instance().globalEnv();
        if (isImplicit()) {
            final TCImplicitFunctionDefinition ifunc = implicit();
            this.predef         = new DafnyFunctionDefinition(ifunc.predef);
            this.precondition   = DafnyExpression.of(ifunc.precondition, env);   
            this.postcondition  = DafnyExpression.of(ifunc.postcondition, env);
            this.body           = DafnyExpression.of(ifunc.body, env);
            this.measure        = DafnyExpression.of(ifunc.measureExp, env);
            this.typeParams     = ifunc.typeParams != null ? ifunc.typeParams.stream().map(type -> DafnyTypeNames.instance().getTypeName(type)).collect(Collectors.toList()) : List.of();
            this.paramList      = DafnyParamDefinition.from(ifunc);
            if (ifunc.type.result instanceof TCUnionType) {
                DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, ifunc.type.result.location, "union returns", ifunc.type.result.toString());
            }
            this.returnType     = DafnyTypeNames.instance().getTypeName(ifunc.type.result);
        }
        else if (isExplicit()) {
            final TCExplicitFunctionDefinition efunc = explicit();
            this.predef         = efunc.predef != null ? new DafnyFunctionDefinition(efunc.predef) : null;
            this.precondition   = DafnyExpression.of(efunc.precondition, env);   
            this.postdef        = efunc.postdef != null ? new DafnyFunctionDefinition(efunc.postdef) : null;
            this.postcondition  = DafnyExpression.of(efunc.postcondition, env);
            this.body           = DafnyExpression.of(efunc.body, env);
            this.measure        = DafnyExpression.of(efunc.measureExp, env);   
            this.typeParams     = efunc.typeParams != null ? efunc.typeParams.stream().map(type -> DafnyTypeNames.instance().getTypeName(type)).collect(Collectors.toList()) : List.of();
            this.paramList      = DafnyParamDefinition.from(efunc);
            // this.paramPatterns  = DafnyParamPattern.from(efunc);
            if (efunc.type.result instanceof TCUnionType) {
                DafnyTranslateCommand.report(DafnyErrorMessage.DAFNY_UNSUPPORTED_2P, efunc.type.result.location, "union return", efunc.type.result.toString());
            }
            this.returnType     = DafnyTypeNames.instance().getTypeName(efunc.type.result);
        }
        isUnionReturn();
    }

    public boolean isUnionReturn() {
        if (isImplicit()) {
            final TCExplicitFunctionDefinition efunc = explicit();
            
            if (!efunc.body.getType().equals(efunc.type.result)) {
                if (efunc.type.result instanceof TCNamedType) {
                    if (((TCNamedType)efunc.type.result).type instanceof TCUnionType) {
                        TCUnionType unType = (TCUnionType)(((TCNamedType)efunc.type.result).type);
                        return unType.types.contains(efunc.body.getType()) && !(efunc.body.getType() instanceof TCQuoteType);
                    }
                }
            }
        }
        if (isExplicit()) {
            final TCExplicitFunctionDefinition efunc = explicit();
            
            if (!efunc.body.getType().equals(efunc.type.result)) {
                if (efunc.type.result instanceof TCNamedType) {
                    if (((TCNamedType)efunc.type.result).type instanceof TCUnionType) {
                        TCUnionType unType = (TCUnionType)(((TCNamedType)efunc.type.result).type);
                        return unType.types.contains(efunc.body.getType()) && !(efunc.body.getType() instanceof TCQuoteType);
                    }
                }
            }
        }
        return false;
    }

    public String getUnionCons() {
        assert isUnionReturn();
        TCType type = null;
        if (isImplicit()) {
            final TCImplicitFunctionDefinition ifunc = implicit();
            type = ifunc.body.getType();
            
        }
        if (isExplicit()) {
            final TCExplicitFunctionDefinition efunc = explicit();
            type = efunc.body.getType();
        }
        return DafnyRecord.unionReturn(type);
    }

    private TCImplicitFunctionDefinition implicit() {
        assert isImplicit();
        return (TCImplicitFunctionDefinition)func;
    }
    
    private TCExplicitFunctionDefinition explicit() {
        assert isExplicit();
        return (TCExplicitFunctionDefinition)func;
    }

    private boolean isExplicit() {
        return func instanceof TCExplicitFunctionDefinition;
    }
    
    private boolean isImplicit() {
        return func instanceof TCImplicitFunctionDefinition;
    }

    private boolean isPredicate() {
        return isExplicit() 
            ?   explicit().type.result instanceof TCBooleanType 
            :   implicit().type.result instanceof TCBooleanType;
    }

    private boolean isLemma() {
        return false;
        // return isExplicit()
        //     ?   !explicit().type.partial && isPredicate()
        //     :   !implicit().type.partial && isPredicate();
    }

    @Override
    public String translate() {
        // explicit().actualResult instanceof TCBooleanType;
        String template = isLemma() ? "lemma" : isPredicate() ? "predicate" : "function";
        return DafnyTemplates.FUNCTIONS.render(template, Pair.of("func", this));
    }

    @Override
    public TCDefinition getVDM() {
        return func;
    }

    public String getName() {
        return DafnyIdentifiers.instance().transform(func.name);
    }

    @Override
    public boolean isLocal() {
        return scope.equals(NameScope.LOCAL);
    }

    public TCDefinition getFunc() {
        return func;
    }

    public NameScope getScope() {
        return scope;
    }

    public String getPredef() {
        return predef.translate();
    }

    public String getPostdef() {
        return postdef.translate();
    }

    public List<DafnyParamDefinition> getParamList() {
        return paramList;
    }

    public boolean hasParameters() {
        return paramList.size() > 0;
    }
    
    // public void addPatternDefinition() {
    //     int idx = 0;
    //     if (isImplicit()) {
    //         TCImplicitFunctionDefinition ifunc = implicit();
    //         for (TCPatternListTypePair def: ifunc.parameterPatterns) {
    //             def.patterns.toString();
    //             for (TCPattern pattern: def.patterns) {
    //                 DafnyPattern dfyPattern = DafnyLiteralPattern.of(pattern);
    //             }
    //         }
    //     }
    // }

    public boolean isParmaterisedFunction() {
        return typeParams.size() > 0;
    }

    public List<String> getTypeParams() {
        return typeParams;
    }

    public boolean hasPrecondition() {
        return this.precondition != null;
    }

    public boolean hasPostcondition() {
        return this.postcondition != null;
    }

    public boolean hasMeasureExpression() {
        return this.measure != null;
    }

    public boolean hasBodyExpression() {
        return this.body != null ||  this.body.getVDM() instanceof TCNotYetSpecifiedExpression;
    }

    public String getPre() {
        return precondition.translate();
    }

    public String getPost() {
        return postcondition.translate();
    }

    public String getBody() {
        if (isExplicit()) {
            if (!explicit().type.result.equals(explicit().body.getType()) && DafnyTypeDefinition.isLiteral(explicit().type.result)) {
                return body.translate() + " as " + getReturnType();
            }
        }
        else if (isImplicit()) {
            if (!implicit().type.result.equals(implicit().body.getType()) && DafnyTypeDefinition.isLiteral(explicit().type.result)) {
                return body.translate() + " as " + getReturnType();
            }
        }
        return body.translate();
    }

    public String getMeasure() {
        return measure.translate();
    }

    public String getReturnType() {
        return returnType;
    }

    public boolean hasReconcilablePatterns() {
        return paramList.stream().anyMatch(p -> p.reconciliations.size() > 0);
    }

    public List<String> getReconciledPatterns() {
        return paramList.stream().filter(p -> p.reconciliations.size() > 0).flatMap(p -> p.reconciliations.stream().map(pattern -> pattern.translate())).collect(Collectors.toList());
        // return paramPatterns.stream().filter(pattern -> pattern.isReconcilable()).map(pattern -> pattern.translate()).collect(Collectors.toList());
    }

    public boolean isSpecified() {
        return hasBodyExpression();
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
}
