package annotations.tc;

import java.util.Iterator;

import com.fujitsu.vdmj.tc.annotations.TCAnnotation;
import com.fujitsu.vdmj.tc.definitions.TCClassDefinition;
import com.fujitsu.vdmj.tc.definitions.TCDefinition;
import com.fujitsu.vdmj.tc.expressions.TCExpression;
import com.fujitsu.vdmj.tc.expressions.TCExpressionList;
import com.fujitsu.vdmj.tc.expressions.TCStringLiteralExpression;
import com.fujitsu.vdmj.tc.lex.TCIdentifierToken;
import com.fujitsu.vdmj.tc.lex.TCNameToken;
import com.fujitsu.vdmj.tc.modules.TCModule;
import com.fujitsu.vdmj.tc.statements.TCStatement;
import com.fujitsu.vdmj.typechecker.Environment;
import com.fujitsu.vdmj.typechecker.NameScope;

/**
 * This annotation represents a global boolean value to be issued as a proof
 * obligation during Isabelle translation. The first parameter must be a string
 * literal containing a valid Isabelle identifier (for the theorem name), followed
 * by a boolean-typed expression for the theorem that is type-checkable (and Isabelle
 * styled, e.g. all declarations defined before use).  
 */
public class TCTheoremAnnotation extends TCAnnotation {

    // allow @Theorem with any name them, ang "gate" it at isapog time 
    // //TODO generalise this? To avoid copying from IsaToken.java
    // private static final Set<String> INVALID_ISA_IDENTIFIERS = new TreeSet<String>(
    //     Arrays.asList(
	// 		// Commonly ued inner syntax names? Or all Tokens? 
	// 		"o", "SOME", "THE", "let", "in", "case", "if",
	// 		// output of print_commands:
	// 		// keywords
	// 		"abbrevs", "and", "assumes", "begin", "binder", "checking",
	// 		"class_instance", "class_relation", "code_module", "constant", "constrains", "datatypes",
	// 		"defines", "export_files", "export_prefix", "external_files", "file", "file_prefix", "fixes", "for",
	// 		"functions", "if", "imports", "in", "includes", "infix", "infixl", "infixr", "is", "keywords",
	// 		"module_name", "monos", "morphisms", "notes", "obtains", "open", "opening", "output", "overloaded",
	// 		"parametric", "pervasive", "premises", "private", "qualified", "rewrites", "shows", "structure",
	// 		"type_class", "type_constructor", "unchecked", "when", "where",
	// 		// commands
	// 		"ML", "ML_command", "ML_export", "ML_file", "ML_file_debug", "ML_file_no_debug", "ML_prf",
	// 		"ML_val", "ROOTS_file", "SML_export", "SML_file", "SML_file_debug", "SML_file_no_debug",
	// 		"SML_import", "abbreviation", "alias", "also", "apply", "apply_end", "assume", 
	// 		"attribute_setup", "axiomatization", "back", "bibtex_file", "bnf", "bundle", "by", 
	// 		"case", "chapter", "class", "class_deps", "codatatype", "code_datatype", "code_deps",
	// 		"code_identifier", "code_monad", "code_pred", "code_printing", "code_reflect", 
	// 		"code_reserved", "code_thms", "coinductive", "coinductive_set", "compile_generated_files", 
	// 		"consider", "consts", "context", "copy_bnf", "corollary", 
	// 		"datatype", "datatype_compat", "declaration", "declare", "default_sort", "defer", 
	// 		"define", "definition", "done", "end", "experiment", "export_code", 
	// 		"export_generated_files", "external_file", "extract", "extract_type", "finally", 
	// 		"find_consts", "find_theorems", "find_unused_assms", "fix", "free_constructors", 
	// 		"from", "full_prf", "fun", "fun_cases", "function", "functor", "generate_file", 
	// 		"global_interpretation", "guess", "have", "help", "hence", "hide_class", "hide_const", 
	// 		"hide_fact", "hide_type", "include", "including", "inductive", "inductive_cases", 
	// 		"inductive_set", "inductive_simps", "instance", "instantiation", "interpret", 
	// 		"interpretation", "judgment", "lemma", "lemmas", "let", "lift_bnf", "lift_definition",
	// 			"lifting_forget", "lifting_update", "local_setup", "locale", "locale_deps", 
	// 			"method_setup", "moreover", "named_theorems", "next", "nitpick", "nitpick_params", 
	// 			"no_notation", "no_syntax", "no_translations", "no_type_notation", "nonterminal", 
	// 			"notation", "note", "notepad", "nunchaku", "nunchaku_params", "obtain", 
	// 			"old_rep_datatype", "oops", "oracle", "overloading", "paragraph", "parse_ast_translation", 
	// 			"parse_translation", "partial_function", "prefer", "presume", 
	// 			"prf", "primcorec", "primcorecursive", "primrec", "print_ML_antiquotations", 
	// 			"print_abbrevs", "print_antiquotations", "print_ast_translation", "print_attributes",
	// 			"print_bnfs", "print_bundles", "print_case_translations", "print_cases", "print_claset", 
	// 			"print_classes", "print_codeproc", "print_codesetup", "print_coercions", 
	// 			"print_commands", "print_context", "print_definitions", "print_defn_rules", "print_facts", 
	// 			"print_induct_rules", "print_inductives", "print_interps", "print_locale", 
	// 			"print_locales", "print_methods", "print_options", "print_orders", "print_quot_maps", 
	// 			"print_quotconsts", "print_quotients", "print_quotientsQ3", "print_quotmapsQ3", 
	// 			"print_record", "print_rules", "print_simpset", "print_state", "print_statement", 
	// 			"print_syntax", "print_term_bindings", "print_theorems", "print_theory", 
	// 			"print_trans_rules", "print_translation", "proof", "prop", "proposition", "qed", 
	// 			"quickcheck", "quickcheck_generator", "quickcheck_params", "quotient_definition", 
	// 			"quotient_type", "realizability", "realizers", "record", "schematic_goal", "section",
	// 			"setup", "setup_lifting", "show", "simproc_setup", "sledgehammer", "sledgehammer_params", 
	// 			"smt_status", "solve_direct", "sorry", "specification", "subclass",
	// 			"subgoal", "sublocale", "subparagraph", "subsection", "subsubsection", "supply", "syntax",
	// 			"syntax_declaration", "term", "termination", "text", "text_raw", "then", 
	// 			"theorem", "theory", "thm", "thm_deps", "thm_oracles", "thus", "thy_deps", "translations", 
	// 			"try", "try0", "txt", "typ", "type_alias", "type_notation", 
	// 			"type_synonym", "typed_print_translation", "typedecl", "typedef", "ultimately", "unbundle", 
	// 			"unfolding", "unused_thms", "using", "value", "values", "welcome", "with", 
	// 			"write"
	// 	)        
    // );

    public TCTheoremAnnotation(TCIdentifierToken name, TCExpressionList args) {
        super(name, args);
    }
    
    @Override
	public void tcBefore(TCModule module)
	{
		name.report(6009, "@Theorem can only appear at top-level definitions.");
	}

	@Override
	public void tcBefore(TCClassDefinition clazz)
	{
		name.report(6009, "@Theorem can only appear at top-level definitions.");
	}

	@Override
	public void tcBefore(TCExpression exp, Environment env, NameScope scope)
	{
		name.report(6009, "@Theorem can only appear at top-level definitions.");
	}

	@Override
	public void tcBefore(TCStatement stmt, Environment env, NameScope scope)
	{
		name.report(6009, "@Theorem can only appear at top-level definitions.");
	}

    @Override
	public void tcBefore(TCDefinition def, Environment env, NameScope scope)
	{
		checkArgs(env, scope);
	}

    public static final boolean validIdentifier(String identifier)
    {
        //@NB what woudl be the best way to check for "valid" VDM identifiers? 
        return true;
    }


	private void checkArgs(Environment env, NameScope scope)
	{
		if (args.isEmpty())
		{
			name.report(6008, "@Theorem must start with an unique theorem name identifier (VDM string-literal) argument");
		}
		else
		{
            Iterator<TCExpression> eit = args.iterator();
            TCExpression e = eit.next();
            if (e instanceof TCStringLiteralExpression)
			{
                TCStringLiteralExpression strExpr = (TCStringLiteralExpression)e;
                if (!validIdentifier(strExpr.value.value))
                {
                    //@NB is this the right report number? 
                    strExpr.report(6008, "@Theorem name parameter must be valid Isabelle name idenfier");
                }
                else
                {
                    TCNameToken name = new TCNameToken(strExpr.location, strExpr.location.module, strExpr.value.value);
                    //@NB should this be GLOBAL or NAMES? 
                    TCDefinition d = env.findName(name, NameScope.GLOBAL);
                    if (d != null)
                    {
                        strExpr.report(6008, String.format("@Theorem name `%1$s` has already been defined", strExpr.value.value));
                    }
                    else 
                    {
                        while (eit.hasNext())
                        {
                            e = eit.next();
                            //@NB should this be NameScope.GLOBAL? Or which one? 
                            //    the theorem expr should type check as if it was defined
                            //    as a global boolean value
                            e.typeCheck(env, null, scope, null);	// Just checks scope
                        }    
                    }
                }				
			}
			else
			{
                name.report(6008, "@Theorem must start with an unique theorem name identifier (VDM string-literal) argument");
			}
		}
	}
}
