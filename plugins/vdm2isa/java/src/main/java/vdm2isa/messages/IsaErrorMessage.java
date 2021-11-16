package vdm2isa.messages;

/**
 * Plugin error messages by category. "_XP" on the name hints at the number of parameters expect.
 * Do not add \"v\" within messages, but `v` instead; this is in case message is also issued as an Isabelle comment. 
 */
public enum IsaErrorMessage {
    
    //Plugin messages relate to incomplete or incompatible issues
    PLUGIN_NYI_2P(VDM2IsaError.ISABELLE_E_PLUGIN_BASE + 0, 
    "Not yet implemented %1$s for %2$s"),
    PLUGIN_MISSING_MAPPING_ERROR_2P(VDM2IsaError.ISABELLE_E_PLUGIN_BASE + 1,
    "Cannot yet convert %1$s = %2$s; %3$s"),
    PLUGIN_UNEXPECTED_ERROR_2P(VDM2IsaError.ISABELLE_E_PLUGIN_BASE + 2,
    "Unexpected exception when converting %1$s = %2$s"),
    
    //VDM messages relate to ill formed ASTs; properly (VDMJ) typechecked ASts should never raise those
    VDMSL_VDM10_ONLY        (VDM2IsaError.ISABELLE_E_VDMSL_BASE + 0, 
    "Only VDMSL supports Isabelle translation."),
    VDMSL_INVALID_PATTERN   (VDM2IsaError.ISABELLE_E_VDMSL_BASE + 1, 
    "Invalid empty bind pattern list."),
    VDMSL_INVALID_PATTERN_BIND(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 2, 
    "Cannot have null pattern and bind in TRPatternBind"),
    VDMSL_FIELD_MISSING_RECORDTYPE_1P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 3, 
    "Field %1$s does not have its record type set."),
    VDMSL_INVALID_SPECIFICATION_1P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 4,
    "Explicit funciton has declared %1$s but no definition AST."),
    VDMSL_INVALID_CURRIED_FCNTYPE_2P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 5,
    "Inconsistent curried function declaration `%1$s`: intermediate result does not have function type - %2$s"),
    VDMSL_INVALID_EXPR_4P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 6,
    "Invalid %1$s arguments for `%2$s` length(%3$s) = %4$s."),
    VDMSL_INVALID_TUPLE_TYPE_3P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 7, 
    "Invalid type for tuple projection expression %1$s.#%2$s = %3$s"),
    VDMSL_INVALID_TUPLE_PROJECTION_3P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 8,
    "Invalid tuple projection field (%1$s) is bigger than tuple size (%2$s)."), 
    VDMSL_INVALID_MKARGS_3P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 9,
    "Invalid record arguments: incompatible number of fields for VDM mk_%1$s expression. Found %2$s, expected %3$s."),
    VDMSL_INVALID_TESTEXPR_3P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 10,
    "Invalid %1$s expression: contains both type name `%2$s` and basic type `%3$s`."),
    VDMSL_INVALID_INVTYPE_2P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 11,
    "Invalid VDMSL invartiant type %1$s: %2$s."),
    VDMSL_INVALID_TYPEDEF_2P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 12, 
    "Invalid type %1$s definition for %2$s. Both pattern and expression must be present."),
    VDMSL_INVALID_VAREXPR_VARDEF_1P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 13, 
    "Invalid variable expression - null vardef."),
    VDMSL_INVALID_EXPROP_1P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 14, 
    "Invalid expression operator `%1$s`."),
    VDMSL_INVALID_EQUALSDEF_2P(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 15, 
    "Invalid VDMSL equals definition %1$s: %2$s."),
    VDMSL_INVALID_CASESEXPR(VDM2IsaError.ISABELLE_E_VDMSL_BASE + 16, 
    "Invalid VDMSL cases expression: empty cases."),


    //Isabelle message relate to difficulties or incompatibilities in translation 
    ISA_DUPLICATE_DEF_3P    (VDM2IsaError.ISABELLE_E_ISA_BASE + 0,
    "Invalid IsaItem %1$s: %2$s has already been defined in module %3$s"), 
    ISA_SEP_ERROR_2P        (VDM2IsaError.ISABELLE_E_ISA_BASE + 1,
    "Invalid %1$s separator: only %2$s characters are allowed separator"),
    ISA_TOKEN_ERROR_1P      (VDM2IsaError.ISABELLE_E_ISA_BASE + 2,
    "Unsupported VDM SL token %1$s"),
    ISA_DUMMYNAME_ERROR_1P  (VDM2IsaError.ISABELLE_E_ISA_BASE + 3,
    "Dummy var names call must be strictly positive; count = %1$s"),
    ISA_VDM_EMPTYRECORD_PATTERN_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 4,    
    "Isabelle does not allow empty patterns for VDM record pattern for record type %1$s"),
    ISA_INVALID_INVTR_2P    (VDM2IsaError.ISABELLE_E_ISA_BASE + 5, 
    "Node %1$s `%2$s` does not support VDM invariant translation to Isabelle."),
    ISA_INVALID_IMPLSPEC_2P (VDM2IsaError.ISABELLE_E_ISA_BASE + 6, 
    "Invalid implicitly generated specificaiton check for %1$s. Must be one of %2$s."),
    ISA_INVALID_COMPLEX_BIND_VALUE_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 7,
    "Multiple local names in VDM value definitions (e.g., `[A,B] = [1,2]`) cannot be translated for `%1$s`."),
    ISA_NO_EMPTYRECORD_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 8,
    "Isabelle does not allow zero-fields records for VDM mk_%1$s expression."),
    ISA_RECORD_EARLYUSE_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 9,
    "Record type %1$s must be declared before its fields are accessed. Record not been translated yet; couldn't find its fields."),
    ISA_TYPEBOUND_SEQCOMP(VDM2IsaError.ISABELLE_E_ISA_BASE + 10,
    "Type bound sequence compression is not supported in Isabelle."), 
    ISA_TYPELIST_INVTR_SIZE_3P(VDM2IsaError.ISABELLE_E_ISA_BASE + 11,
    "Inconsistent invariant translation call in type list: %1$s %2$s for %3$s." ),
    ISA_TYPE_HAS_NO_NAME_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 12,
    "VDMSL type (isaToken = %1$s) does not have an explicitly given name."),
    ISA_INVALID_IDENTIFIER_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 13, 
    "Invalid Isabelle identifier in pattern `%1$s`."),
    ISA_INVALID_RECORDNAME_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 14, 
    "Unknown record name `%1$s` - not yet declared."),
    ISA_INVALID_INVTYP_2P    (VDM2IsaError.ISABELLE_E_ISA_BASE + 15, 
    "Invalid invariant type for %1$s : %2$s."),
    ISA_INVALID_TYPEINVARIANT_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 16, 
    "Could not figure out invariant specification for type definition %1$s"),
    ISA_FIELDEXPR_RECORDNAME_2P(VDM2IsaError.ISABELLE_E_ISA_BASE + 17, 
    "Could not retrieve record type in field expression for %1$s; found %2$s type"),
    ISA_INVALID_OPTION_CASE_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 18, 
    "VDM cases other clause for option type expression `%1$s` is not allowed in Isabelle."),
    ISA_INVALID_EXPRCHAIN_TYPE_1P(VDM2IsaError.ISABELLE_E_ISA_BASE + 19,
    "Booleann expression chain for `%1$s` operator must all have boolean type."),


    //POG messages relate to difficulties during POG
    PO_PROCESSING_ERROR_4P  (VDM2IsaError.ISABELLE_E_PO_BASE + 0, 
    "VDM PO (%1$s) %2$s %3$s error `%4$s`; should never happen."),
    PO_INVALID_PO_MODULE_1P (VDM2IsaError.ISABELLE_E_PO_BASE + 1, 
    "Invalid proof obligations module %1$s"),
    PO_INVALID_DEF_ERROR    (VDM2IsaError.ISABELLE_E_PO_BASE + 2, 
    "Invalid module PO list: only PO expressions or proofs scripts are allowed"),
    PO_INVALID_POEXPR_2P(VDM2IsaError.ISABELLE_E_PO_BASE + 3, 
    "Invalid proof obligation expression: %1$s = %2$s."),

    TEST(VDM2IsaError.ISABELLE_E_PO_BASE, " ");
    
    //private static final Set<Integer> numbers = new TreeSet<Integer>(); 
                             
    public final int number;
    public final String message; 

    private IsaErrorMessage(int number, String message)
    {
        assert number >= VDM2IsaError.ISABELLE_E_PLUGIN_BASE;
        this.number = number;
        this.message = message;
    } 

    public String format(Object... args)
    {
        if (args == null)
            return message;
        else
            return String.format(message, args);
    }
}
