package vdm2isa.lex;

import java.util.Arrays;
import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.ast.modules.ASTModule;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import plugins.GeneralisaPlugin;
import plugins.Vdm2isaPlugin;
import vdm2isa.messages.IsaErrorMessage;

//@todo Look in CZT for the kind of info needed like parenthesis, left/right assoc, etc. ? 
public enum IsaToken {
	// Basic types; use VDMToolkit names 
	BOOL(Token.BOOL, "\\<bool>"),
	NAT(Token.NAT, "VDMNat"),
 	NAT1(Token.NAT1, "VDMNat1"),
	INT(Token.INT, "VDMInt"),
	RAT(Token.RAT, "VDMRat"),
	REAL(Token.REAL, "VDMReal"),
	CHAR(Token.CHAR, "VDMChar"),
	STRING(Token.STRING, "VDMChar VDMSeq"),
  	TOKEN_TYPE(Token.TOKEN, "VDMToken"),
	TOKEN(Token.TOKEN, "Token"), // datatype 'a VDMToken = Token 'a 
	CROSSPROD(Token.TIMES, "\\<times>"),
	VDMQUOTE(Token.QUOTE, ""), // i.e. "<X>" => X (empty string for Token.QUOTE)
	VDMUNION(null, "U"),
	ISAQUOTE(null, "\""),
	SET(Token.SET, "VDMSet"),
	SET1(Token.SET1, "VDMSet1"),
	SEQ(Token.SEQ, "VDMSeq"),
	SEQ1(Token.SEQ1, "VDMSeq1"),
	MAP(Token.MAP, "\\<rightharpoonup>"),
	INMAP(Token.INMAP, "\\<rightharpoonup>"),
	FUN(Token.ARROW, "\\<Rightarrow>"),
	TRUE(Token.TRUE, "True"),
	FALSE(Token.FALSE, "False"),
	NIL(Token.NIL, "None"),
	UNKNOWN(null, "'UNKNOWN"),
	DASH(null, "'"),
	TYPEOF(null, "::"),
	PLACEHOLDER(null, "_"),
	//TUPLE(null/*mk_*/, ""),
	SEQBIND(null, "\\<leftarrow>"),
	SETSEQBIND(null, "\\<leftarrow> sorted_list_of_set"),
	UNDERSCORE(null, "_"),
	PO(null, "PO"),

	// Unary Operators
	NOT(Token.NOT, "\\<not>"),
	ABS(Token.ABS, "vdm_abs"),
	FLOOR(Token.FLOOR, "vdm_floor"),
	UPLUS(Token.PLUS, "+"),
	UMINUS(Token.MINUS, "-"),
	CARD(Token.CARD, "vdm_card"),
	DUNION(Token.DUNION, "\\<Union>"),
	DINTER(Token.DINTER, "\\<Inter>"),
	LEN(Token.LEN, "len"),
	HEAD(Token.HEAD, "hd"),
	TAIL(Token.TAIL, "tl"),
	INDS(Token.INDS, "inds"),
	ELEMS(Token.ELEMS, "elems"),				//@nb no TCElemsExpression? 
	DISTCONC(Token.DISTCONC, "conc"),
	REVERSE(Token.REVERSE, "vdm_reverse"),
	MERGE(Token.MERGE, "vdm_merge"),
	DOM(Token.DOM, "dom"),
	RNG(Token.RNG, "rng"),
	FPOWERSET(Token.POWER, "Fpow"),

	ABBREVIATION(null, "abbreviation"),
	DEFINITION(null, "definition"),
	HIDE_CONST(null, "hide_const"),
	HIDE_TYPE(null, "hide_type"),
	
	// Binary Operators
	AND(Token.AND, "\\<and>"),
	OR(Token.OR, "\\<or>"),
	IMPLIES(Token.IMPLIES, "\\<longrightarrow>"),
	EQUIVALENT(Token.EQUIVALENT, "\\<longleftrightarrow>"),

	SPACE(null, " "),
	EQUALS(Token.EQUALS, "="),
	NE(Token.NE, "\\<noteq>"),
	LT(Token.LT, "<"),
	LE(Token.LE, "\\<le>"),
	GT(Token.GT, ">"),
	GE(Token.GE, "\\<ge>"),

	PLUS(Token.PLUS, "+"),
	MINUS(Token.MINUS, "-"),
	TIMES(Token.TIMES, "*"),
	DIV(Token.DIV, "vdmdiv"),
	DIVIDE(Token.DIVIDE, "/"),
	MOD(Token.MOD, "vdmmod"),
	REM(Token.REM, "vdmrem"),
	STARSTAR(Token.STARSTAR, "vdmpow"), //@doc vdmpow expects real_normed_algebra_1 types only
	STARSTARNAT(Token.STARSTAR, "^ nat"),
	INSET(Token.INSET, "\\<in>"),
	NOTINSET(Token.NOTINSET, "\\<notin>"),
	UNION(Token.UNION, "\\<union>"),
	INTER(Token.INTER, "\\<inter>"),
	SETDIFF(Token.SETDIFF, "-"),
	SUBSET(Token.SUBSET, "\\<subseteq>"),
	PSUBSET(Token.PSUBSET, "\\<subset>"),

	CONCATENATE(Token.CONCATENATE, "@"),
	SUBSEQ(null, "$$"),

	PLUSPLUS(Token.PLUSPLUS, "\\<dagger>"),
	DOMRESTO(Token.DOMRESTO, "\\<triangleleft>"),
	DOMRESBY(Token.DOMRESBY, "-\\<triangleleft>"),
	RANGERESTO(Token.RANGERESTO, "\\<triangleright>"),
	RANGERESBY(Token.RANGERESBY, "\\<triangleright>-"),
	MUNION(Token.MUNION, "\\<union>m"),	//@todo add \<sub>?
	COMP(Token.COMP, "\\<circ>m"),
	

	APPLY(null, " "),
	SEQAPPLY(null, "$"),
	VARIABLE(null, "variable"),
	LOCAL(null, "local"),
	INV(null, "inv_"),
	PRE(Token.PRE, "pre"),
	POST(Token.POST, "post"),
	IDENTIFIER(Token.IDENTIFIER, "identifier"),
	RECORD(Token.COLONCOLON, "record"),
	UNDEFINED(Token.UNDEFINED, "undefined"),
	ISACHAR(null, "CHR"),
	ISASTR(null/*Token.STRING*/, "''"),
	DUMMY(null, "dummy"),
	ERROR(Token.ERROR, "ERROR"),
	SEMICOLON(Token.SEMICOLON, ";"),
	COLON(Token.COLON, ":"),
	VDMINT_NARROW(null, "vdm_narrow_real"),
	NARROW(null/*Token.NARROW doesn't exist?*/, "vdm_narrow"),
	ISEXPR(Token.IS, "isTest"),
	SOME(Token.LET, "SOME"),

	EQUALSEQUALS(Token.EQUALSEQUALS, "\\<equiv>"),
	INVERSE(Token.INVERSE, "vdm_inverse"),
	MAPLET(Token.MAPLET, "\\<mapsto>"),
	RECORD_MODIFIER(Token.MAPLET, ":="),
	RANGE(Token.RANGE, ".."),
	POINT(Token.POINT, "."),
	BAR(Token.PIPE, "|"),
	FORALL(Token.FORALL, "\\<forall>"),
	EXISTS(Token.EXISTS, "\\<exists>"),
	EXISTS1(Token.EXISTS1, "\\<exists>!"),
	IOTA(Token.IOTA, "THE"),
	LAMBDA(Token.LAMBDA, "\\<lambda>"),
	
	MAPCOMP_SETBOUND(null, "mapCompSetBound"),
	MAPCOMP_TYPBOUND(null, "mapCompTypeBound"),
	MAPCOMP_DOMID(null, "domid"),
	MAPCOMP_RNGID(null, "rngid"),
	MAPCOMP_DOMCNST(null, "domcnst"),
	MAPCOMP_RNGCNST(null, "rngcnst"),
	MAPCOMP_PREDCNST(null, "predcnst"),
	MAPCOMP_TRUECNST(null, "truecnst"),
	
	SET_OPEN(Token.SET_OPEN, "{"),
	SET_CLOSE(Token.SET_CLOSE, "}"),
	SEQ_OPEN(Token.SEQ_OPEN, "["),
	SEQ_CLOSE(Token.SEQ_CLOSE, "]"),
	MAP_OPEN(Token.SET_OPEN, "["),
	MAP_CLOSE(Token.SET_CLOSE, "]"),
	LPAREN(Token.BRA, "("),
	RPAREN(Token.KET, ")"),
	LRECORD(null, "\\<lparr>"),
	RRECORD(null, "\\<rparr>"),
	COMMA(Token.COMMA, ","),
	OPTIONAL(null, "option"),
	COMMENT(null, "\\<comment>"),
	ISA_OPEN(null,"\\<open>"),
	ISA_CLOSE(null, "\\<close>"),
	BLOCK_COMMENT_OPEN(null, "(*"),
	BLOCK_COMMENT_CLOSE(null, "*)"),
	FST(null, "fst"),
	SND(null, "snd"),
	AT(null, "@"),

	OPTIONAL_THE(null, "the"),
	OPTIONAL_SOME(null, "Some"),

	VDMTOOLKIT(null, "VDMToolkit"),
	ISAR_TYPEPARAM(null, "'"),
	ISAR_THEOREM(null, "theorem"),
	ISAR_LEMMA(null, "lemma"),
	ISAR_LEMMAS(null, "lemmas"),
	ISAR_LEMMAS_DEFS(null, "_defs"),
	ISAR_DEF(null, "_def"),
	ISAR_TERM(null, "term"),
	ISAR_TYP(null, "typ"),
	ISAR_THM(null, "thm"),
  	ISAR_DONE(null, "done"),
	ISAR_OOPS(null, "oops"),
	ISAR_SORRY(null, "sorry"),
	ISAR_PROOF(null, ""),
	ISAR_APPLY(null, "apply"),
	ISAR_SLEDGEHAMMER(null, "sledgehammer"),
	ISAR_TRY(null, "try"),
	ISAR_TRY0(null, "try0"),
	ISAR_NITPICK(null, "nitpick"),

	MODULE(Token.MODULE, "theory"),
	IF(Token.IF, "if"),
	THEN(Token.THEN, "then"),
	ELSE(Token.ELSE, "else"),
	ELSEIF(Token.ELSEIF, "else if"),
	CASE(Token.CASES, "case"),
	OF(null, "of"),
	TFUN(Token.TOTAL_FUNCTION, "\\<Rightarrow>"),
	LET(Token.LET, "let"),
	IN(Token.IN, "in"),
	SUBSCRIPT(null, "\\<^sub>"),
	SUPSCRIPT(null, "\\<^sup>"),
	EOF(Token.EOF, "EOF");

	private final Token  vdm;
	private final String isa;

	protected static final Set<String> ALL_ISA_TOKENS = new TreeSet<String>();

	private static final Set<String> INVALID_ISA_IDENTIFIERS = new TreeSet<String>(
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
	
	private IsaToken(Token vdm, String isa)
	{
		assert isa != null; 
		if (vdm != null && !vdm.getDialects().contains(Dialect.VDM_SL)) 
			GeneralisaPlugin.report(IsaErrorMessage.ISA_TOKEN_ERROR_1P, LexLocation.ANY, vdm.name());
		this.vdm = vdm;
		this.isa = isa;
		// all but underscore, for dummy pattern in identifiers as valid 
		if (!isa.equals("_"))
			IsaTemplates.ALL_ISA_TOKENS.add(isa);//this);
	}

	//TODO add infixlr notation here to know where/when to "pad" the string?
	@Override
	public String toString()
	{
		return isa;
	}

	public Token vdmToken()
	{
		return vdm;
	}

	public static final String parenthesise(String s)
	{
		return bracketit(IsaToken.LPAREN, s, IsaToken.RPAREN);
	}

	public static final String the(String s)
	{
		return parenthesise(IsaToken.OPTIONAL_THE.toString() + parenthesise(s));
	}


	public static final String comment(String s)
	{
		return comment(s, "");
	}

	public static final String comment(String s, String formattingSeparator)
	{
		if (Vdm2isaPlugin.printIsaComments)
			return IsaToken.COMMENT.toString() + 
				IsaToken.bracketit(IsaToken.ISA_OPEN, s, IsaToken.ISA_CLOSE) + formattingSeparator;
		else
			return "";
	}

	public static final String antiquotation(IsaToken kind, String yxml)
	{
		return IsaToken.AT.toString() +
					IsaToken.bracketit(IsaToken.SET_OPEN, 
					kind.toString() + " " + 
					IsaToken.bracketit(IsaToken.ISA_OPEN, yxml, IsaToken.ISA_CLOSE),
					IsaToken.SET_CLOSE);
	}

	public static final String bracketit(IsaToken left, String s, IsaToken right)
	{
		return left.toString() + s + right.toString();
	}

	public static final String innerSyntaxIt(String s) {
		return IsaToken.bracketit(IsaToken.ISAQUOTE, s, IsaToken.ISAQUOTE);
	}

	//TODO perhaps this means we ought to have a TRNameToken? Ohhhh nooo...
	public static final String isabelleName(TCNameToken name)
	{
		return name.getLex().explicit ? name.getLex().toString().replace('`', '.') : name.getLex().toString();
	}

	/**
	 * Valid Isabelle identifiers are non-empty/non-null, cannot start with "_", neither be any of Isabelle's keywords.
	 * @param identifier
	 * @return
	 */
    public static final boolean validIsaIdentifier(String identifier)
    {
        return identifier != null && identifier.length() > 0 && 
			!INVALID_ISA_IDENTIFIERS.contains(identifier) && 
			!IsaTemplates.ALL_ISA_TOKENS.contains(identifier) &&
			// single "_" is valid "dummy" identifier pattern! Can't have _x though. 
			(identifier.equals(IsaToken.UNDERSCORE.toString()) ||
			!identifier.startsWith(IsaToken.UNDERSCORE.toString()));
    }

	protected static long dummyCount = 0;

	private static final String dummyName(int idx, boolean requiresFreshness)
	{
		assert idx >= 0;
		// only increment the dummy count for freshness if necessary, returning
		// the earlier version onto the string. 
		String result = IsaToken.DUMMY.toString() +
			(requiresFreshness ? (IsaToken.dummyCount++) + "cnt" : "") + Long.toString(idx);
		return result;
	}

	/**
	 * Creates requested number of dummy names, where freshness is dependent of context. 
	 * @param count number of dummies to create
	 * @param requiresFreshness whether they are fresh (unique)
	 * @param location
	 * @return space separated list of dummy names
	 */
	public static final String dummyVarNames(int count, boolean requiresFreshness, LexLocation location)
	{
		StringBuilder sb = new StringBuilder();
		if (count <= 0)
			GeneralisaPlugin.report(IsaErrorMessage.ISA_DUMMYNAME_ERROR_1P, location, count);
		else
		{
			sb.append(IsaToken.dummyName(0, requiresFreshness));
			for (int i = 1; i < count; i++)
			{
				sb.append(IsaToken.SPACE.toString()); 
				sb.append(IsaToken.dummyName(i, requiresFreshness));
			}	
		}
		return sb.toString();
	}

	//@TODO fix after finalisaing Token above. 
	public static IsaToken from(LexToken operator)
	{
		assert operator != null; 
		switch (operator.type)
		{

			case NOT			: return IsaToken.NOT;
			case ABS			: return IsaToken.ABS;
			case FLOOR			: return IsaToken.FLOOR;
			//case UMINUS			: return IsaToken.UMINUS;
			//case UPLUS			: return IsaToken.UPLUS;

			case CARD			: return IsaToken.CARD;
			case POWER			: return IsaToken.FPOWERSET;
			case DUNION			: return IsaToken.DUNION;
			case DINTER			: return IsaToken.DINTER;

			case LEN			: return IsaToken.LEN;
			case HEAD			: return IsaToken.HEAD;
			case TAIL			: return IsaToken.TAIL;
			case INDS			: return IsaToken.INDS;
			case ELEMS			: return IsaToken.ELEMS;
			case DISTCONC		: return IsaToken.DISTCONC;
			case REVERSE		: return IsaToken.REVERSE;

			case DOM			: return IsaToken.DOM;
			case RNG			: return IsaToken.RNG;
			case MERGE			: return IsaToken.MERGE;
			case INVERSE		: return IsaToken.INVERSE;

			case AND			: return IsaToken.AND;
			case OR				: return IsaToken.OR;
			case IMPLIES		: return IsaToken.IMPLIES;
			case EQUIVALENT 	: return IsaToken.EQUIVALENT;

			// binary relational operators
			case LT				: return IsaToken.LT;
			case LE				: return IsaToken.LE;
			case GT				: return IsaToken.GT;
			case GE				: return IsaToken.GE;
			case NE				: return IsaToken.NE;
			case EQUALS			: return IsaToken.EQUALS;
			
			// binary arithmetic operators
			case PLUS			: return IsaToken.PLUS;
			case MINUS			: return IsaToken.MINUS;
			case TIMES			: return IsaToken.TIMES;
			case DIVIDE			: return IsaToken.DIVIDE;
			case REM			: return IsaToken.REM;
			case MOD			: return IsaToken.MOD;
			case DIV			: return IsaToken.DIV;
			//@todo needs context information to know whether to use STARSTARNAT or STARSTAR
			case STARSTAR		: return IsaToken.STARSTARNAT;
				
			//case EQUALSEQUALS: return IsaToken.;
		
			case INSET			: return IsaToken.INSET;
			case NOTINSET		: return IsaToken.NOTINSET;
			case UNION			: return IsaToken.UNION;
			case INTER			: return IsaToken.INTER;
			case SUBSET			: return IsaToken.SUBSET;
			case PSUBSET		: return IsaToken.PSUBSET;
			case SETDIFF		: return IsaToken.SETDIFF;
			
			case CONCATENATE	: return IsaToken.CONCATENATE;

			case MUNION			: return IsaToken.MUNION;
			case PLUSPLUS		: return IsaToken.PLUSPLUS;
			case DOMRESTO		: return IsaToken.DOMRESTO;
			case DOMRESBY		: return IsaToken.DOMRESBY;
			case RANGERESTO		: return IsaToken.RANGERESTO;
			case RANGERESBY		: return IsaToken.RANGERESBY;
			case COMP			: return IsaToken.COMP;
			case MAPLET			: return IsaToken.MAPLET;
			case RANGE			: return IsaToken.RANGE;
		
			//case POINT		: return IsaToken.POINT;
			//case FORALL			: return IsaToken.FORALL;
			//case EXISTS			: return IsaToken.EXISTS;
			//case EXISTS1		: return IsaToken.EXISTS1;
			//case IOTA			: return IsaToken.IOTA;
			//case LAMBDA			: return IsaToken.LAMBDA;
			default:
				// report the error
				GeneralisaPlugin.report(IsaErrorMessage.ISA_TOKEN_ERROR_1P, operator.location, operator.toString());
				return IsaToken.ERROR;
		}
	}

	public static final TCNameToken newNameToken(String name)
	{
		return IsaToken.newNameToken(LexLocation.ANY, ASTModule.defaultName(LexLocation.ANY).name, name);
	}

	public static final TCNameToken newNameToken(LexLocation location, String module, String name)
	{
		return new TCNameToken(location, module, name);
	}
}
