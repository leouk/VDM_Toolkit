package vdm2isa.lex.templates;

import java.util.Arrays;
import java.util.Set;
import java.util.TreeSet;

import vdm2isa.lex.IsaToken;

public class IsaIdentifier extends IsaAbstractTemplate {

    public final String name; 

    public static final Set<String> INVALID_ISA_IDENTIFIERS = new TreeSet<String>(
        Arrays.asList(
			// Commonly ued inner syntax names? Or all Tokens? 
			"o", "SOME", "THE", "let", "in", "case", "if",
			// output of print_commands:
			// keywords
			"abbrevs", "and", "assumes", "begin", "binder", "checking",
			"class_instance", "class_relation", "code_module", "constant", "constrains", "datatypes",
			"defines", "export_files", "export_prefix", "external_files", "file", "file_prefix", "fixes", "for",
			"functions", "if", "imports", "in", "includes", "infix", "infixl", "infixr", "is", "keywords",
			"module_name", "monos", "morphisms", "notes", "obtains", "open", "opening", "output", "overloaded",
			"parametric", "pervasive", "premises", "private", "qualified", "rewrites", "shows", "structure",
			"type_class", "type_constructor", "unchecked", "when", "where",
			// commands
			"ML", "ML_command", "ML_export", "ML_file", "ML_file_debug", "ML_file_no_debug", "ML_prf",
			"ML_val", "ROOTS_file", "SML_export", "SML_file", "SML_file_debug", "SML_file_no_debug",
			"SML_import", "abbreviation", "alias", "also", "apply", "apply_end", "assume", 
			"attribute_setup", "axiomatization", "back", "bibtex_file", "bnf", "bundle", "by", 
			"case", "chapter", "class", "class_deps", "codatatype", "code_datatype", "code_deps",
			"code_identifier", "code_monad", "code_pred", "code_printing", "code_reflect", 
			"code_reserved", "code_thms", "coinductive", "coinductive_set", "compile_generated_files", 
			"consider", "consts", "context", "copy_bnf", "corollary", 
			"datatype", "datatype_compat", "declaration", "declare", "default_sort", "defer", 
			"define", "definition", "done", "end", "experiment", "export_code", 
			"export_generated_files", "external_file", "extract", "extract_type", "finally", 
			"find_consts", "find_theorems", "find_unused_assms", "fix", "free_constructors", 
			"from", "full_prf", "fun", "fun_cases", "function", "functor", "generate_file", 
			"global_interpretation", "guess", "have", "help", "hence", "hide_class", "hide_const", 
			"hide_fact", "hide_type", "include", "including", "inductive", "inductive_cases", 
			"inductive_set", "inductive_simps", "instance", "instantiation", "interpret", 
			"interpretation", "judgment", "lemma", "lemmas", "let", "lift_bnf", "lift_definition",
			"lifting_forget", "lifting_update", "local_setup", "locale", "locale_deps", 
			"method_setup", "moreover", "named_theorems", "next", "nitpick", "nitpick_params", 
			"no_notation", "no_syntax", "no_translations", "no_type_notation", "nonterminal", 
			"notation", "note", "notepad", "nunchaku", "nunchaku_params", "obtain", 
			"old_rep_datatype", "oops", "oracle", "overloading", "paragraph", "parse_ast_translation", 
			"parse_translation", "partial_function", "prefer", "presume", 
			"prf", "primcorec", "primcorecursive", "primrec", "print_ML_antiquotations", 
			"print_abbrevs", "print_antiquotations", "print_ast_translation", "print_attributes",
			"print_bnfs", "print_bundles", "print_case_translations", "print_cases", "print_claset", 
			"print_classes", "print_codeproc", "print_codesetup", "print_coercions", 
			"print_commands", "print_context", "print_definitions", "print_defn_rules", "print_facts", 
			"print_induct_rules", "print_inductives", "print_interps", "print_locale", 
			"print_locales", "print_methods", "print_options", "print_orders", "print_quot_maps", 
			"print_quotconsts", "print_quotients", "print_quotientsQ3", "print_quotmapsQ3", 
			"print_record", "print_rules", "print_simpset", "print_state", "print_statement", 
			"print_syntax", "print_term_bindings", "print_theorems", "print_theory", 
			"print_trans_rules", "print_translation", "proof", "prop", "proposition", "qed", 
			"quickcheck", "quickcheck_generator", "quickcheck_params", "quotient_definition", 
			"quotient_type", "realizability", "realizers", "record", "schematic_goal", "section",
			"setup", "setup_lifting", "show", "simproc_setup", "sledgehammer", "sledgehammer_params", 
			"smt_status", "solve_direct", "sorry", "specification", "subclass",
			"subgoal", "sublocale", "subparagraph", "subsection", "subsubsection", "supply", "syntax",
			"syntax_declaration", "term", "termination", "text", "text_raw", "then", 
			"theorem", "theory", "thm", "thm_deps", "thm_oracles", "thus", "thy_deps", "translations", 
			"try", "try0", "txt", "typ", "type_alias", "type_notation", 
			"type_synonym", "typed_print_translation", "typedecl", "typedef", "ultimately", "unbundle", 
			"unfolding", "unused_thms", "using", "value", "values", "welcome", "with", 
			"write"
		)        
    );

    // Has to be here and not in IsaToken, because cannot be in Enum initialiser + constructor
    private static final Set<String> ALL_ISA_TOKENS = new TreeSet<String>();

    public static final void addIsaToken(String token)
    {
        assert token != null && !token.isEmpty();
        ALL_ISA_TOKENS.add(token);
    }
    
    public static final boolean validIsaIdentifier(String identifier)
    {
        return identifier != null && identifier.length() > 0 && 
			!INVALID_ISA_IDENTIFIERS.contains(identifier) && 
			!ALL_ISA_TOKENS.contains(identifier) &&
			// single "_" is valid "dummy" identifier pattern! Can't have _x though. 
			(identifier.equals(IsaToken.PLACEHOLDER.toString()) || 
            !identifier.startsWith(IsaToken.UNDERSCORE.toString()));
    }

    public static final IsaIdentifier valueOf(String name)
    {
        return new IsaIdentifier(name);
    }

    protected IsaIdentifier(String name)
    {
        super();
		this.name = name; 
        if (!validIsaIdentifier(this.name))
            throw new IsaTemplateException("Invalid Isabelle identifer name " + this.name);
    }

    public final String getName()
    {
        return name;
    }

    @Override
    public final String toString()
    {
        return getName();
    }
}
