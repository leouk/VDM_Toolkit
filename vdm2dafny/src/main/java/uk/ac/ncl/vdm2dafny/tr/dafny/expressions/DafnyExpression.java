package uk.ac.ncl.vdm2dafny.tr.dafny.expressions;

import java.util.List;
import java.util.stream.Collectors;

import com.fujitsu.vdmj.tc.annotations.TCAnnotatedExpression;
import com.fujitsu.vdmj.tc.expressions.*;
import com.fujitsu.vdmj.typechecker.FlatEnvironment;

import uk.ac.ncl.vdm2dafny.lex.DafnyToken;
import uk.ac.ncl.vdm2dafny.tr.dafny.AbstractDafnyNode;
import uk.ac.ncl.vdm2dafny.tr.dafny.DafnyVDMComment;
import uk.ac.ncl.vdm2dafny.tr.dafny.expressions.dummy.DafnyDummyExpression;

public abstract class DafnyExpression extends AbstractDafnyNode {
    public abstract String translate();
    public abstract TCExpression getVDM();

    public static DafnyExpression of(TCExpression exp, FlatEnvironment fenv) {
        DafnyExpression dfyExp = null;

        // Cover all binary expressions
        if (DafnyCompareExpression.is(exp)) {
            if (DafnyQuoteComparison.is(exp)) {
                dfyExp = new DafnyQuoteComparison((TCEqualsExpression)exp, fenv);
            }
            else {
                dfyExp = DafnyCompareExpression.of(exp, fenv);
            }
        }
        else if (exp instanceof TCBinaryExpression) {
            dfyExp = new DafnyBinaryExpression((TCBinaryExpression)exp, fenv);
        }
        // Cover literals
        else if (DafnyLiteralExpression.isLiteral(exp)) {
            dfyExp = new DafnyLiteralExpression(exp, fenv);
        }
        // Cover Unary expressions
        else if (exp instanceof TCUnaryExpression) {
            dfyExp = new DafnyUnaryExpression((TCUnaryExpression)exp, fenv);
        }
        // Cover let expressions
        else if (exp instanceof TCLetDefExpression) {
            dfyExp = new DafnyLetDefExpression((TCLetDefExpression)exp, fenv);
        }
        else if (exp instanceof TCLetBeStExpression) {
            dfyExp = new DafnyLetBeStExpression((TCLetBeStExpression)exp, fenv);
        }
        else if (exp instanceof TCApplyExpression) {
            dfyExp = new DafnyApplyExpression((TCApplyExpression)exp, fenv);
        }
        else if (exp instanceof TCSubseqExpression) {
            dfyExp = new DafnySubseqExpression((TCSubseqExpression)exp, fenv);
        }
        else if (DafnyComprehensionExpression.isComp(exp)) {
            dfyExp = DafnyComprehensionExpression.of(exp, fenv);
        }
        else if (exp instanceof TCSetRangeExpression) {
            dfyExp = new DafnySetRangeExpression((TCSetRangeExpression)exp, fenv);
        }
        else if (exp instanceof TCCasesExpression) {
            dfyExp = new DafnyCasesExpression((TCCasesExpression)exp, fenv);
        }
        else if (DafnyEnumExpression.is(exp)) {
            dfyExp = DafnyEnumExpression.of(exp, fenv);
        }
        else if (exp instanceof TCIfExpression) {
            dfyExp = new DafnyIfThenElseExpression((TCIfExpression)exp, fenv);
        }
        else if (exp instanceof TCElseIfExpression) {
            // Shouldn't really ever run this branch, as elseif branches are handled in the if case.
            dfyExp = new DafnyElseIfExpression((TCElseIfExpression)exp, fenv);
        }
        else if (exp instanceof TCMkTypeExpression) {
            // Shouldn't really ever run this branch, as elseif branches are handled in the if case.
            dfyExp = new DafnyMkTypeExpression((TCMkTypeExpression)exp, fenv);
        }
        else if (exp instanceof TCFieldExpression) {
            // Shouldn't really ever run this branch, as elseif branches are handled in the if case.
            dfyExp = new DafnyFieldExpression((TCFieldExpression)exp, fenv);
        }
        else if (exp instanceof TCFieldNumberExpression) {
            // Shouldn't really ever run this branch, as elseif branches are handled in the if case.
            dfyExp = new DafnyFieldNumberExpression((TCFieldNumberExpression)exp, fenv);
        }
        else if (exp instanceof TCExistsExpression) {
            dfyExp = new DafnyIteratorExpression((TCExistsExpression)exp, fenv);
        }
        else if (exp instanceof TCExists1Expression) {
            dfyExp = new DafnyIteratorExpression((TCExistsExpression)exp, fenv);
        }
        else if (exp instanceof TCForAllExpression) {
            dfyExp = new DafnyIteratorExpression((TCForAllExpression)exp, fenv);
        }
        else if (exp instanceof TCPreOpExpression) {
            dfyExp = DafnyExpression.of(((TCPreOpExpression)exp).expression, fenv);
        }
        else if (exp instanceof TCPostOpExpression) {
            dfyExp = new DafnyPostOpExpression((TCPostOpExpression)exp, fenv);
        }
        else if (exp instanceof TCAnnotatedExpression) {
            dfyExp = new DafnyAnnotatedExpression((TCAnnotatedExpression)exp, fenv);
        }
        else if (exp instanceof TCFuncInstantiationExpression) {
            dfyExp = new DafnyFuncInstantiationExpression((TCFuncInstantiationExpression)exp, fenv);
        }
        else if (exp instanceof TCUndefinedExpression) {
            dfyExp = new DafnyUndefinedExpression((TCUndefinedExpression)exp, fenv);
        }
        else if (exp instanceof TCNotYetSpecifiedExpression) {
            dfyExp = new DafnyNotYetSpecified((TCNotYetSpecifiedExpression)exp, fenv);
        }
        else if (exp instanceof TCIsExpression) {
            dfyExp = new DafnyIsExpression((TCIsExpression)exp, fenv);
        }
        else if (exp instanceof TCNarrowExpression) {
            dfyExp = new DafnyNarrowExpression((TCNarrowExpression)exp, fenv);
        }
        else if (exp instanceof TCLambdaExpression) {
            dfyExp = new DafnyLambdaExpression((TCLambdaExpression)exp, fenv);
        }
        else if (exp instanceof TCMuExpression) {
            dfyExp = new DafnyMuExpression((TCMuExpression)exp, fenv);
        }
        else {
            if (exp != null) {
                // System.out.printf("Class not in cases: %s\n", exp.getClass().getSimpleName());
                dfyExp = new DafnyDummyExpression(exp, fenv);
            }
        }

        return dfyExp;
        // Cover comprehensions ?
    }

    public static DafnyToken getToken(TCMapletExpression maplet) {
        return DafnyToken.MAPLET;
    }

    public static DafnyToken getToken(TCCaseAlternative cases) {
        return DafnyToken.CASE;
    }

    public static DafnyToken getToken(TCExpression exp) {
        return  
        //Unary
            exp instanceof TCAbsoluteExpression             ? DafnyToken.ABS
            :   exp instanceof TCLenExpression                  ? DafnyToken.LEN
            
            :   exp instanceof TCNotExpression                  ? DafnyToken.NOT
            
            :   exp instanceof TCApplyExpression                ? DafnyToken.APPLY
            
            :   exp instanceof TCFloorExpression                ? DafnyToken.FLOOR
            
            :   exp instanceof TCHeadExpression                 ? DafnyToken.HEAD
            :   exp instanceof TCTailExpression                 ? DafnyToken.TAIL
            
            :   exp instanceof TCElementsExpression             ? DafnyToken.ELEMS
            :   exp instanceof TCIndicesExpression              ? DafnyToken.INDS
            
            :   exp instanceof TCDistConcatExpression           ? DafnyToken.DISTCONC
            :   exp instanceof TCDistMergeExpression            ? DafnyToken.MERGE
            :   exp instanceof TCDistIntersectExpression        ? DafnyToken.DINTER
            :   exp instanceof TCDistUnionExpression            ? DafnyToken.DUNION
            
            :   exp instanceof TCMapInverseExpression           ? DafnyToken.INVERSE
            :   exp instanceof TCMapRangeExpression             ? DafnyToken.RANGE
            :   exp instanceof TCMapDomainExpression            ? DafnyToken.DOM
            
            :   exp instanceof TCIsOfBaseClassExpression        ? DafnyToken.ISEXPR
            :   exp instanceof TCIsExpression                   ? DafnyToken.ISEXPR
            :   exp instanceof TCPowerSetExpression             ? DafnyToken.FPOWERSET
            
            
            :   exp instanceof TCUnaryMinusExpression           ? DafnyToken.UMINUS
            :   exp instanceof TCUnaryPlusExpression            ? DafnyToken.UPLUS
            // Binary
            :   exp instanceof TCDivExpression                  ? DafnyToken.DIV
            :   exp instanceof TCDivideExpression               ? DafnyToken.DIVIDE
            :   exp instanceof TCTimesExpression                ? DafnyToken.TIMES
            :   exp instanceof TCNotInSetExpression             ? DafnyToken.NOTINSET
            :   exp instanceof TCMapUnionExpression             ? DafnyToken.MUNION
            :   exp instanceof TCEqualsExpression               ? DafnyToken.EQUALS
            :   exp instanceof TCAndExpression                  ? DafnyToken.AND
            :   exp instanceof TCCardinalityExpression          ? DafnyToken.CARD
            :   exp instanceof TCDomainResByExpression          ? DafnyToken.DOMRESBY
            :   exp instanceof TCDomainResToExpression          ? DafnyToken.DOMRESTO
            :   exp instanceof TCRangeResByExpression           ? DafnyToken.RANGERESBY
            :   exp instanceof TCRangeResToExpression           ? DafnyToken.RANGERESTO
            :   exp instanceof TCEquivalentExpression           ? DafnyToken.EQUIVALENT
            :   exp instanceof TCGreaterEqualExpression         ? DafnyToken.GE
            :   exp instanceof TCGreaterExpression              ? DafnyToken.GT
            :   exp instanceof TCImpliesExpression              ? DafnyToken.IMPLIES
            :   exp instanceof TCInSetExpression                ? DafnyToken.INSET
            :   exp instanceof TCCompExpression                 ? DafnyToken.COMP
            :   exp instanceof TCLessEqualExpression            ? DafnyToken.LE
            :   exp instanceof TCLessExpression                 ? DafnyToken.LT
            :   exp instanceof TCModExpression                  ? DafnyToken.MOD
            :   exp instanceof TCNotEqualExpression             ? DafnyToken.NE
            :   exp instanceof TCOrExpression                   ? DafnyToken.OR
            :   exp instanceof TCPlusExpression                 ? DafnyToken.PLUS
            :   exp instanceof TCPlusPlusExpression             ? DafnyToken.PLUSPLUS
            :   exp instanceof TCProperSubsetExpression         ? DafnyToken.PSUBSET
            :   exp instanceof TCRemExpression                  ? DafnyToken.REM
            :   exp instanceof TCReverseExpression              ? DafnyToken.REVERSE
            :   exp instanceof TCSeqConcatExpression            ? DafnyToken.CONCATENATE
            :   exp instanceof TCSetIntersectExpression         ? DafnyToken.INTER
            :   exp instanceof TCSetUnionExpression             ? DafnyToken.UNION 
            :   exp instanceof TCStarStarExpression             ? 
                                                                    ((TCStarStarExpression)exp).ltype.isFunction(exp.location) ? DafnyToken.FITERATE
                                                                :   ((TCStarStarExpression)exp).ltype.isMap(exp.location) ? DafnyToken.MITERATE
                                                                :   DafnyToken.POW
            :   exp instanceof TCSubseqExpression               ? DafnyToken.SUBSEQ
            :   exp instanceof TCSubsetExpression               ? DafnyToken.SUBSET
            :   exp instanceof TCSubtractExpression             ? DafnyToken.MINUS
            // :   exp instanceof TCCaseAlternative                ? DafnyToken.CASE // TCNODE AGAIN
            
            // Special cases
            :   exp instanceof TCCasesExpression                ? DafnyToken.CASES
            
            :   exp instanceof TCSeqCompExpression              ? DafnyToken.SEQCOMP
            :   exp instanceof TCSetCompExpression              ? DafnyToken.SETCOMP
            :   exp instanceof TCMapCompExpression              ? DafnyToken.MAPCOMP
            
            :   exp instanceof TCIfExpression                   ? DafnyToken.IF
            :   exp instanceof TCElseIfExpression               ? DafnyToken.ELSEIF
            :   exp instanceof TCExists1Expression              ? DafnyToken.EXISTS1
            :   exp instanceof TCExistsExpression               ? DafnyToken.EXISTS
            :   exp instanceof TCForAllExpression               ? DafnyToken.FORALL
            :   exp instanceof TCFuncInstantiationExpression    ? DafnyToken.FUN // WHAT IS THIS?
            
            :   exp instanceof TCLambdaExpression               ? DafnyToken.LAMBDA
            :   exp instanceof TCIotaExpression                 ? DafnyToken.IOTA
            
            :   exp instanceof TCLetBeStExpression              ? DafnyToken.BE
            :   exp instanceof TCLetDefExpression               ? DafnyToken.LET
            
            :   exp instanceof TCSetRangeExpression             ? DafnyToken.SETRANGE
            :   exp instanceof TCPreExpression                  ? DafnyToken.PRE
            :   exp instanceof TCPreOpExpression                ? DafnyToken.PRE
            :   exp instanceof TCPostOpExpression               ? DafnyToken.POST

            :   exp instanceof TCVariableExpression             ? DafnyToken.VARIABLE
            //Literals
            :   exp instanceof TCCharLiteralExpression          ? DafnyToken.CHAR
            :   exp instanceof TCBooleanLiteralExpression       ? DafnyToken.BOOL
            :   exp instanceof TCIntegerLiteralExpression       ? DafnyToken.INT
            :   exp instanceof TCNilExpression                  ? DafnyToken.NIL
            :   exp instanceof TCMkBasicExpression              ? DafnyToken.MK
            :   exp instanceof TCMkTypeExpression               ? DafnyToken.CONS
            :   exp instanceof TCQuoteLiteralExpression         ? DafnyToken.VDMQUOTE
            :   exp instanceof TCNotYetSpecifiedExpression      ? DafnyToken.UNDEFINED
            :   exp instanceof TCRealLiteralExpression          ? DafnyToken.REAL
            :   exp instanceof TCStringLiteralExpression        ? DafnyToken.STRING
            
            // Grouped literals.
            :   exp instanceof TCMapEnumExpression              ? DafnyToken.MAP
            :   exp instanceof TCSeqEnumExpression              ? DafnyToken.SEQ
            :   exp instanceof TCSetEnumExpression              ? DafnyToken.SET
            :   exp instanceof TCTupleExpression                ? DafnyToken.MK
            :   exp instanceof TCSetDifferenceExpression        ? DafnyToken.SETDIFF
            :   exp instanceof TCFieldExpression                ? DafnyToken.FIELD
            :   exp instanceof TCFieldNumberExpression          ? DafnyToken.FIELDNUMBER
            // :   exp instanceof TCHistoryExpression              ? DafnyToken.HISTORY
            // :   exp instanceof TCIsOfClassExpression            ? DafnyToken.IS // NOT SL? 
            // :   exp instanceof TCMapEnumExpression              ? DafnyToken.MAPENUM // ?
            // :   exp instanceof TCMapletExpression               ? DafnyToken.MAPLET // WHY IS THIS A TCNODE???
            :   exp instanceof TCMuExpression                   ? DafnyToken.MU
            :   exp instanceof TCNarrowExpression               ? DafnyToken.NARROW
            :   exp instanceof TCAnnotatedExpression             ? DafnyToken.ANNO
            // :   exp instanceof TCPostOpExpression
            // :   exp instanceof TCSeqEnumExpression              ? 
            // :   exp instanceof TCStateInitExpression            ? DafnyToken.STATEINIT  // dafny doesnt have state :/

            :   DafnyToken.UNDEFINED;
    }

    public List<DafnyVDMComment> getComments() {
        return getVDM().comments.stream().map(comment -> new DafnyVDMComment(comment)).collect(Collectors.toList());
    }
}
