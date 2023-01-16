package vdm2isa.messages;

/*
 * Plugin warning messages by category. "_XP" on the name hints at the number of parameters expect.
 * Do not add \"v\" within messages, but `v` instead; this is in case message is also issued as an Isabelle comment. 
 */
public enum IsaWarningMessage {

    //Plugin messages relate to incomplete or incompatible issues
    PLUGIN_NYI_2P(VDM2IsaWarning.ISABELLE_W_PLUGIN_BASE + 0, 
        "Not yet implemented %1$s for %2$s"),
    
    VDMSL_VDM10_ONLY(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 0, 
    "Isabelle translation is optimal for VDM_10. You might encounter problems with CLASSIC release."),
    VDMSL_MISSING_RESULT_IN_POST_1P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 1, 
    "Could not find `%1$s` variable in implicit post condition specification definition."),
    VDMSL_SETCOMP_TYPEBOUND(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 2, 
    "Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!"),
    VDMSL_MISSING_RESULTVAR_1P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 3, 
    "Could not find `%1$s` variable in implicit post condition specification definition."),
    VDMSL_EMPTY_MODULE_FILES_1P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 4,  
    "Empty file(s) for module %1$s: Isabelle theory file must have a name"),
    VDMSL_INVALID_EXPR_TYPE_2P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 5,
    "%1$s expression invalid type (`%2$s`)? VDMJ might still figure it out."),      
    VDMSL_INVALID_EXPR_4P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 6,
    "Invalid %1$s arguments for `%2$s` length(%3$s) = %4$s."),
    VDMSL_FIND_BINDING_OF_DUPLICATE_PATTERN_NAME_2P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 7,
    "Found binding `%1$s` named `%2$s` in binding list where there are duplicate names."),

    VDMSL_EXU_MISSING_SPECCALL_3P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 50,
    "Definition of `%1$s` %2$s depends on `%3$s` yet does not call `pre_%3$s`."),
    VDMSL_EXU_MISSING_INVCALL_3P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 51,
    "Definition of `%1$s` %2$s depends on `%3$s` yet `%1$s` does not check input type invariants for `%3$s` when arguments are not subtype compatible! Better to have a call to `pre_%3$s` with corresponding arguments in the definition of `%1$s`."),
    VDMSL_EXU_MISSING_TYPEDEF_SPEC_1P(VDM2IsaWarning.ISABELLE_W_VDMSL_BASE + 52,
    "Type definition for type `%1$s` requires both eq and ord specifications; otherwise, it will require Isabelle `ord` type class instantiation!"),

    ISA_UNKNOWN_VDM_TYPE(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 0, 
    "Unknown VDM types will generate Isabelle additional type variable `a warning."),
    ISA_OPTIONALTYPE_VARIABLE_3P(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 1, 
    "Optional type variable `%1$s` might not need extra @{term the} operator!"),
    ISA_TYPDEF_ORD_1P(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 2, 
    "Type definition for type `%1$s` specification might requires Isabelle type to instantiate `ord` class!"),
    ISA_TYPED_NARROW_1P(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 3, 
    "VDM narrow expressions of type %1$s might create Isabelle type errors!"),
    ISA_SEQCOMP_LINEAR_TYPEBIND_1P(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 4, 
    "Set bind `%1$s` in sequence comprehension requires its Isabelle type to instantiate class linorder."),
    ISA_POWEROP_TYPEDEP(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 5,
    "Result of the power operator is context dependenant on second argument type being nat or real."),
    ISA_USE_BEFORE_DECL_2P(VDM2IsaWarning.ISABELLE_W_ISA_BASE + 6,
    "Type `%1$s` used before being defined might generate translation errors; managed to figure out it is a `%2$s` type."),
    ISA_MAP_COMP_TYPE_BINDINGS(VDM2IsaError.ISABELLE_W_ISA_BASE + 7,
    "Map comprehension with type bindings will generate difficult map finiteness proof."),
    ISA_INVALID_MODULE_NAME_2P(VDM2IsaError.ISABELLE_W_ISA_BASE + 8, 
    "Module `%1$s` translation will be saved in a file with the same name instead of the one in \n\tFiles = %2$s"),

    PO_NOT_TRANSLATED_POS_LEFT_UNPROCESSED_1P(VDM2IsaError.ISABELLE_W_PO_BASE + 0,
    "PO conversion failed because of an unexpected VDMJ error. They were converted to Isabelle as comments. \n\t%1$s"),    
    PO_UNEXPECTED_PROOFSTEP_1P(VDM2IsaWarning.ISABELLE_W_PO_BASE + 1, 
    "Attempting to create proof step with definition %1$s.");

    public final int number;
    public final String message; 

    private IsaWarningMessage(int number, String message)
    {
        assert number >= VDM2IsaError.ISABELLE_WARNING_BASE;
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
