package vdm2isa.messages;

public enum IsaInfoMessage {

    VDM_SOURCE_1P("VDM source: %1$s"),
    VDM_IMPLICITLY_DEFINED_INV_2P("Implicitly defined type invariant checks for %1$s `%2$s` specification."),
    VDM_EXPLICIT_FUNCTION_USER_DEFINED_BODY_1P("User defined body of %1$s."),
    VDM_EXPLICIT_FUNCTION_IMPLICIT_PARAMETER_TYPE_INV_CHECK_1P("Implicit check on generic type invariant for `%1$s`."),
    VDM_IMPLICITLY_DEFINED_QUANTIFIED_INV("Implicitly defined type invariant checks for quantified type binds"),
    VDM_CASES_TRUE_CONVERSION("VDM `cases true` expressions are translated as an and-chain of implications"),
    VDM_MAP_COMP_LAMBDA_CONVERSION_1P("VDM Map comprehension is translated as a lambda-term through %1$s"),
    VDM_SEQCOMP_BIND_PROBLEM_3P("`%1$s` %2$s This can be a problem if the target type of %3$s %2$s has a VDM ord_ predicate."),
    VDM_LAMBDA_INVARIANT("VDM function type invariant depends on its lambda definition dummy names used being equal."),
    VDM_RENAMED_IMPORT_3P("VDM import from %1$s: %2$s renamed %3$s."),
    VDM_NORMAL_NOT_TRANSLATED_2P("unqualified VDM import from %1$s: %2$s; use Isabelle qualified naming directly."),
    VDM_EXPLICIT_ORDER_PRED_1P("Transform a VDM `<` expression into an `ord_%1$s` call"),
    VDM_EXPLICIT_REVERSED_ORDER_PRED_1P("Transform a VDM `>` expression into a reversed `ord_%1$s` call"),
    VDM_EXPLICIT_EQ_PRED_1P("Transform a VDM `=` expression into an `eq_%1$s` call"),
    VDM_EXPLICIT_NOT_EQ_PRED_1P("Transform a VDM `<>` expression into an `not eq_%1$s` call"),

    ISA_PATTERN_CONTEXT_1P("Implicit pattern context projection for `%1$s`"),
    ISA_UNION_TYPE_PROJECTION("Implicit union type parameters projection"),
    ISA_UNION_TYPE_COERCIONS("Type coercions might needed at body or union selection deletion might be needed"),
    ISA_PROCESS_VDM_EXPORTS("Processing VDM exports as Isabelle hidden declarations"),
    ISA_GENERIC_TYPE_1P("VDM generic type `%1$s` will become an Isabelle type parameter. Specific instantiations require invariant checking function"),
    
    PO_IGNORE_PO_2P("VDM proof obligation `%1$s` is spurious given Isabelle's encoding of `%2$s`."),
    PO_POGLOC_USER("User defined lemmas for %1$s POs"),
    TEST("test");

    public final String message; 

    private IsaInfoMessage(String message)
    {
        assert message != null && !message.isEmpty();
        this.message = message;
    }
    
    @Override
    public String toString()
    {
        return message;
    }

    public String format(Object... args)
    {
        if (args == null)
            return message;
        else
            return String.format(message, args);
    }
}
