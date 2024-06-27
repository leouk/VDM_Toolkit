package uk.ac.ncl.vdm2dafny.lex;

import java.util.Arrays;
import java.util.Set;
import java.util.TreeSet;

import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.ast.modules.ASTModule;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.lex.Token;
import com.fujitsu.vdmj.tc.lex.TCNameToken;

import uk.ac.ncl.plugins.IsaProperties;
import uk.ac.ncl.plugins.commands.DafnyCommand;
import uk.ac.ncl.util.DafnyTemplates;
import uk.ac.ncl.vdm2dafny.messages.DafnyErrorMessage;
import uk.ac.ncl.vdm2dafny.tr.dafny.definitions.DafnyIdentifiers;

//@todo Look in CZT for the kind of info needed like parenthesis, left/right assoc, etc. ? 
public enum DafnyToken {
	
	// Basic types; use VDMToolkit names 
	BOOL(Token.BOOL, "bool"),
	NAT(Token.NAT, "nat"),
 	NAT1(Token.NAT1, "vdm.nat1"),
	INT(Token.INT, "int"),
	RAT(Token.RAT, "real"),
	REAL(Token.REAL, "real"),
	CHAR(Token.CHAR, "char"),
	STRING(Token.STRING, "string"),
  	TOKEN_TYPE(Token.TOKEN, "token"),
	TOKEN(Token.TOKEN, "token"), // datatype 'a VDMToken = Token 'a 
	PRODUCT(Token.TIMES, ", "),
	CROSSPROD(Token.TIMES, "*"),
	VDMQUOTE(Token.QUOTE, ""), // i.e. "<X>" => X (empty string for Token.QUOTE)
	VDMUNION(null, "+"),
	DAFNYQUOTE(null, "\""),
	SET(Token.SET, "set"),
	SET1(Token.SET1, "vdm.set1"),
	SEQ(Token.SEQ, "seq"),
	SEQ1(Token.SEQ1, "seq1"),
	MAP(Token.MAP, "map"),
	MAP_EMPTY(null, "map[]"),
	INMAP(Token.INMAP, "map"),
	FUN(Token.ARROW, "-->"), // @AW assuming this is a partial function?
	TRUE(Token.TRUE, "true"),
	FALSE(Token.FALSE, "false"),
	NIL(Token.NIL, "null"),
	UNKNOWN(Token.QMARK, "*"),
	DASH(null, "'"),
	TYPEOF(null, "?"),
	PLACEHOLDER(null, "_"),
	//TUPLE(null/*mk_*/, ""),
	SEQBIND(null, "seq"),
	SETBIND(null, "set"),
	MAPBIND(null, "map"),
	UNDERSCORE(null, "_"),
	VOID(null, ""),
	ANNO(null, ""),

	// Unary Operators
	NOT(Token.NOT, "!"),
	ABS(Token.ABS, "|"),
	FLOOR(Token.FLOOR, ".Floor"),
	UPLUS(Token.PLUS, ""),
	UMINUS(Token.MINUS, "-"),
	CARD(Token.CARD, "|"),
	DUNION(Token.DUNION, "vdm.dunion"),
	DINTER(Token.DINTER, "vdm.dinter"),
	LEN(Token.LEN, "|"),
	HEAD(Token.HEAD, "[0]"),
	TAIL(Token.TAIL, "[1..]"),
	INDS(Token.INDS, "vdm.inds"),
	ELEMS(Token.ELEMS, "vdm.elems"),				
	DISTCONC(Token.DISTCONC, "vdm.conc"),
	REVERSE(Token.REVERSE, "vdm.reverse"),
	MERGE(Token.MERGE, "vdm.merge"),
	DOM(Token.DOM, ".Keys"),
	RNG(Token.RNG, ".Values"),
	FPOWERSET(Token.POWER, "vdm.powerset"),

	// ABBREVIATION(null, "abbreviation"),
	// DEFINITION(null, "definition"),
	// HIDE_CONST(null, "hide_const"),
	// HIDE_TYPE(null, "hide_type"),
	PARAMETER_TYPE(Token.AT, ""),
	MU(null, ""),
	
	// Binary Operators
	AND(Token.AND, "&&"),
	OR(Token.OR, "||"),
	IMPLIES(Token.IMPLIES, "==>"),
	EQUIVALENT(Token.EQUIVALENT, "<==>"),

	SPACE(null, " "),
	EQUALS(Token.EQUALS, "=="),
	NE(Token.NE, "!="),
	LT(Token.LT, "<"),
	LE(Token.LE, "<="),
	GT(Token.GT, ">"),
	GE(Token.GE, ">="),

	PLUS(Token.PLUS, "+"),
	MINUS(Token.MINUS, "-"),
	TIMES(Token.TIMES, "*"),
	DIV(Token.DIV, "vdm.div"),
	DIVIDE(Token.DIVIDE, "/"),
	MOD(Token.MOD, "%"),
	REM(Token.REM, "vdm.rem"),
	POW(Token.STARSTAR, "vdm.pow"), //@doc vdmpow expects real_normed_algebra_1 types only
	FITERATE(Token.STARSTAR, "vdm.iterate"), //@doc vdmpow expects real_normed_algebra_1 types only
	MITERATE(Token.STARSTAR, "vdm.mapIterate"), //@doc vdmpow expects real_normed_algebra_1 types only
	// STARSTARNAT(Token.STARSTAR, ""), // @aw ?
	INSET(Token.INSET, "in"),
	NOTINSET(Token.NOTINSET, "!in"),
	UNION(Token.UNION, "+"),
	INTER(Token.INTER, "*"),
	SETDIFF(Token.SETDIFF, "-"),
	SUBSET(Token.SUBSET, "<"),
	PSUBSET(Token.PSUBSET, ">"),
	SUBSEQ(null, "vdm.subseq"),

	CONCATENATE(Token.CONCATENATE, "+"),

	PLUSPLUS(Token.PLUSPLUS, "vdm.override"),
	DOMRESTO(Token.DOMRESTO, "vdm.domainRestriction"),
	DOMRESBY(Token.DOMRESBY, "vdm.domainExclusion"),
	RANGERESTO(Token.RANGERESTO, "vdm.rangeRestriction"),
	RANGERESBY(Token.RANGERESBY, "vdm.rangeExclusion"),
	MUNION(Token.MUNION, "vdm.munion"),	//@todo add \<sub>?
	COMP(Token.COMP, "?"),
	

	APPLY(null, " "),
	// SEQAPPLY(null, "$"),
	CONST(null, "const"),
	// LOCAL(null, "local"),
	INV(null, "inv"),
	PRE(Token.PRE, "requires"),
	POST(Token.POST, "ensures"),
	//TODO this must be the proper fules for VDM identifiers!!!!
	IDENTIFIER(Token.IDENTIFIER, "__"),//DafnyToken.IDENTIFIER_TAG),
	RECORD(Token.COLONCOLON, "datatype"),
	ALIAS(Token.EQUALS, "type"),
	UNDEFINED(Token.UNDEFINED, "?"),
	FIELD(null, ""),
	FIELDNUMBER(null, ""),
	// ISACHAR(null, "CHR"),
	// ISASTR(null/*Token.STRING*/, "''"),
	DUMMY(null, "dummy"),
	ERROR(Token.ERROR, "ERROR"),
	SEMICOLON(Token.SEMICOLON, ";"),
	COLON(Token.COLON, ":"),
	// VDMINT_NARROW(null, "vdm_narrow_real"),
	// NARROW(null/*Token.NARROW doesn't exist?*/, "vdm_narrow"),
	ISEXPR(Token.IS, "is"),
	// SOME(Token.LET, "var"),

	EQUALSEQUALS(Token.EQUALSEQUALS, "=="),
	INVERSE(Token.INVERSE, "vdm.inverse"),
	MAPLET(Token.MAPLET, ":="),
	// RECORD_MODIFIER(Token.MAPLET, ":="),
	RANGE(Token.RANGE, ".Values"),
	POINT(Token.POINT, "."),
	BAR(Token.PIPE, "|"),
	FORALL(Token.FORALL, "forall"),
	EXISTS(Token.EXISTS, "exists"),
	EXISTS1(Token.EXISTS1, "vdm.exists1"),
	IOTA(Token.IOTA, "vdm.iota"),
	LAMBDA(Token.LAMBDA, ""), // defined just as a value i.e. (a, b) -> thing
	NARROW(null, ""), // defined just as a value i.e. (a, b) -> thing
	 
	// MAPCOMP_SETBOUND(null, "mapCompSetBound"),
	// MAPCOMP_TYPBOUND(null, "mapCompTypeBound"),
	// MAPCOMP_DOMID(null, "domid"),
	// MAPCOMP_RNGID(null, "rngid"),
	// MAPCOMP_DOMCNST(null, "domcnst"),
	// MAPCOMP_RNGCNST(null, "rngcnst"),
	// MAPCOMP_PREDCNST(null, "predcnst"),
	// MAPCOMP_TRUECNST(null, "truecnst"),
	
	SET_OPEN(Token.SET_OPEN, "{"),
	SET_CLOSE(Token.SET_CLOSE, "}"),
	SEQ_OPEN(Token.SEQ_OPEN, "["),
	SEQ_CLOSE(Token.SEQ_CLOSE, "]"),
	MAP_OPEN(Token.SET_OPEN, "map["),
	MAP_CLOSE(Token.SET_CLOSE, "]"),
	LPAREN(Token.BRA, "("),
	RPAREN(Token.KET, ")"),
	COMMA(Token.COMMA, ","),
	OPTIONAL(null, "vdm.Optional"),
	COMMENT(null, "//"),
	BLOCK_COMMENT_OPEN(null, "/*"),
	BLOCK_COMMENT_CLOSE(null, "*/"),
	AT(null, "@"),

	VDMTOOLKIT(null, "VDMToolkit"),
	VDMDEFAULT(null, "DEFAULT"),
	// ISAR_TYPEPARAM(null, "'"),
	// ISAR_THEOREM(null, "theorem"),
	// ISAR_LEMMA(null, "lemma"),
	// ISAR_LEMMAS(null, "lemmas"),
	// ISAR_LEMMAS_DEFS(null, "_defs"),
	// ISAR_DEF(null, "_def"),
	// ISAR_TERM(null, "term"),
	// ISAR_TYP(null, "typ"),
	// ISAR_THM(null, "thm"),
  	// ISAR_DONE(null, "done"),
	// ISAR_OOPS(null, "oops"),
	// ISAR_SORRY(null, "sorry"),
	// ISAR_PROOF(null, ""),
	// ISAR_APPLY(null, "apply"),
	// ISAR_SLEDGEHAMMER(null, "sledgehammer"),
	// ISAR_TRY(null, "try"),
	// ISAR_TRY0(null, "try0"),
	// ISAR_NITPICK(null, "nitpick"),
	// ISAR_UNFOLD_LOCALES(null, "unfold_locales"),
	// ISAR_SIMP(null, "simp"),
	// ISAR_SIMP_ALL(null, "simp_all"),
	// ISAR_BY(null, "by"),

	MODULE(Token.MODULE, "module"),
	IF(Token.IF, "if"),
	THEN(Token.THEN, "then"),
	ELSE(Token.ELSE, "else"),
	ELSEIF(Token.ELSEIF, "else if"),
	CASES(Token.CASES, "match"),
	CASE(Token.CASES, "case"),
	// OF(null, "of"),
	TFUN(Token.TOTAL_FUNCTION, "->"),
	LET(Token.LET, "var"),
	BE(Token.BE, ":|"),
	ST(Token.ST, ":|"),
	IN(Token.IN, ";"),
	
    
    DAFNY_OPEN(null, "<open>"),
	DAFNY_CLOSE(null, "<close>"),
    
	MK(null, ""),
	CONS(null, ""),
	MAPCOMP(null, "map"),
	VARIABLE(null, "const"),
	SETRANGE(null, "vdm.setRange"),
	SETCOMP(null, "set"),
	SEQCOMP(null, "seq"),

	// CUSTOM
	PRINTLN(null, "print"),
	PRINT(null, "print"),
	PRINTF(null, "printf"),

    ;
	// EOF(Token.EOF, "EOF");

	public final Token  vdm;
	public final String dafny;

	// private static final String IDENTIFIER_TAG;
	// private static long idCount;

	protected static long dummyCount;

	static {
		try
		{					
			// IDENTIFIER_TAG = "__";
			// idCount = 0;

			dummyCount = 0;
			// Invalid identifiers are handled elsewhere.
			// Semantic separation is handled in string templates.
		}
		catch (Throwable t)
		{
			System.err.println("DafnyToken class loading error?! " + t.getMessage());
			t.printStackTrace();
			throw t;
		}
	}

	private DafnyToken(Token vdm, String dafny)
	{
		assert dafny != null; 
		if (vdm != null && !vdm.getDialects().contains(Dialect.VDM_SL)) 
			DafnyCommand.report(DafnyErrorMessage.ISA_TOKEN_ERROR_1P, LexLocation.ANY, vdm.name());
		this.vdm = vdm;
		// if (isa.equals("__"))
		// 	this.isa = createNewId();
		// else
        this.dafny = dafny;
		// all but underscore, for dummy pattern in identifiers as valid 
		if (!dafny.equals("_") && !dafny.isEmpty())
		{
			//IsaTemplates.ALL_ISA_TOKENS.add(isa);
			// ALL_ISA_TOKENS.add(dafny);
			// if (dafny.equals("__"))
			// 	IsaIdentifier.addIsaToken(dafny);
		}
	}

	// private static final String createNewId()
	// {
	// 	String result = "id" + idCount;
	// 	idCount++;
	// 	return result;
	// }

	//TODO add infixlr notation here to know where/when to "pad" the string?
	@Override
	public String toString()
	{
		return dafny;
	}

	public Token vdmToken()
	{
		return vdm;
	}

	public static final String parenthesise(String s)
	{
		return bracketit(DafnyToken.LPAREN, s, DafnyToken.RPAREN);
	}

	// public static final String the(String s)
	// {
	// 	return parenthesise(DafnyToken.OPTIONAL_THE.toString() + parenthesise(s));
	// }


	public static final String comment(String s)
	{
		return comment(s, "");
	}

	public static final String comment(String s, String formattingSeparator)
	{
		if (IsaProperties.vdm2isa_print_isa_comments)
			return DafnyToken.COMMENT.toString() + 
				DafnyToken.bracketit(DafnyToken.DAFNY_OPEN, s, DafnyToken.DAFNY_CLOSE) + formattingSeparator;
		else
			return "";
	}

	public static final String antiquotation(DafnyToken kind, String yxml)
	{
		return DafnyToken.AT.toString() +
					DafnyToken.bracketit(DafnyToken.SET_OPEN, 
					kind.toString() + " " + 
					DafnyToken.bracketit(DafnyToken.DAFNY_OPEN, yxml, DafnyToken.DAFNY_CLOSE),
					DafnyToken.SET_CLOSE);
	}

	public static final String bracketit(DafnyToken left, String s, DafnyToken right)
	{
		return left.toString() + s + right.toString();
	}

	public static final String innerSyntaxIt(String s) {
		return DafnyToken.bracketit(DafnyToken.DAFNYQUOTE, s, DafnyToken.DAFNYQUOTE);
	}

	//TODO perhaps this means we ought to have a TRNameToken? Ohhhh nooo...
	public static final String isabelleName(TCNameToken name)
	{
		return name.getLex().explicit ? name.getLex().toString().replace('`', '.') : name.getLex().toString();
	}

	private static final String dummyName(int idx, boolean requiresFreshness)
	{
		assert idx >= 0;
		// only increment the dummy count for freshness if necessary, returning
		// the earlier version onto the string. 
		String result = DafnyToken.DUMMY.toString() +
			(requiresFreshness ? (DafnyToken.dummyCount++) + "cnt" : "") + Long.toString(idx);
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
			DafnyCommand.report(DafnyErrorMessage.ISA_DUMMYNAME_ERROR_1P, location, count);
		else
		{
			sb.append(DafnyToken.dummyName(0, requiresFreshness));
			for (int i = 1; i < count; i++)
			{
				sb.append(DafnyToken.SPACE.toString()); 
				sb.append(DafnyToken.dummyName(i, requiresFreshness));
			}	
		}
		return sb.toString();
	}

	//@TODO fix after finalisaing Token above. 
	public static DafnyToken from(LexToken operator)
	{
		assert operator != null; 
		switch (operator.type)
		{

			case NOT			: return DafnyToken.NOT;
			case ABS			: return DafnyToken.ABS;
			case FLOOR			: return DafnyToken.FLOOR;
			//case UMINUS			: return DafnyToken.UMINUS;
			//case UPLUS			: return DafnyToken.UPLUS;

			case CARD			: return DafnyToken.CARD;
			case POWER			: return DafnyToken.FPOWERSET;
			case DUNION			: return DafnyToken.DUNION;
			case DINTER			: return DafnyToken.DINTER;

			case LEN			: return DafnyToken.LEN;
			case HEAD			: return DafnyToken.HEAD;
			case TAIL			: return DafnyToken.TAIL;
			case INDS			: return DafnyToken.INDS;
			case ELEMS			: return DafnyToken.ELEMS;
			case DISTCONC		: return DafnyToken.DISTCONC;
			case REVERSE		: return DafnyToken.REVERSE;

			case DOM			: return DafnyToken.DOM;
			case RNG			: return DafnyToken.RNG;
			case MERGE			: return DafnyToken.MERGE;
			case INVERSE		: return DafnyToken.INVERSE;

			case AND			: return DafnyToken.AND;
			case OR				: return DafnyToken.OR;
			case IMPLIES		: return DafnyToken.IMPLIES;
			case EQUIVALENT 	: return DafnyToken.EQUIVALENT;

			// binary relational operators
			case LT				: return DafnyToken.LT;
			case LE				: return DafnyToken.LE;
			case GT				: return DafnyToken.GT;
			case GE				: return DafnyToken.GE;
			case NE				: return DafnyToken.NE;
			case EQUALS			: return DafnyToken.EQUALS;
			
			// binary arithmetic operators
			case PLUS			: return DafnyToken.PLUS;
			case MINUS			: return DafnyToken.MINUS;
			case TIMES			: return DafnyToken.TIMES;
			case DIVIDE			: return DafnyToken.DIVIDE;
			case REM			: return DafnyToken.REM;
			case MOD			: return DafnyToken.MOD;
			case DIV			: return DafnyToken.DIV;
			//@todo needs context information to know whether to use STARSTARNAT or STARSTAR
			// case STARSTAR		: return DafnyToken.STARSTARNAT;
				
			//case EQUALSEQUALS: return DafnyToken.;
		
			case INSET			: return DafnyToken.INSET;
			case NOTINSET		: return DafnyToken.NOTINSET;
			case UNION			: return DafnyToken.UNION;
			case INTER			: return DafnyToken.INTER;
			case SUBSET			: return DafnyToken.SUBSET;
			case PSUBSET		: return DafnyToken.PSUBSET;
			case SETDIFF		: return DafnyToken.SETDIFF;
			
			case CONCATENATE	: return DafnyToken.CONCATENATE;

			case MUNION			: return DafnyToken.MUNION;
			case PLUSPLUS		: return DafnyToken.PLUSPLUS;
			case DOMRESTO		: return DafnyToken.DOMRESTO;
			case DOMRESBY		: return DafnyToken.DOMRESBY;
			case RANGERESTO		: return DafnyToken.RANGERESTO;
			case RANGERESBY		: return DafnyToken.RANGERESBY;
			case COMP			: return DafnyToken.COMP;
			case MAPLET			: return DafnyToken.MAPLET;
			case RANGE			: return DafnyToken.RANGE;
		
			//case POINT		: return DafnyToken.POINT;
			//case FORALL			: return DafnyToken.FORALL;
			//case EXISTS			: return DafnyToken.EXISTS;
			//case EXISTS1		: return DafnyToken.EXISTS1;
			//case IOTA			: return DafnyToken.IOTA;
			//case LAMBDA			: return DafnyToken.LAMBDA;
			default:
			// report the error
			DafnyCommand.report(DafnyErrorMessage.ISA_TOKEN_ERROR_1P, operator.location, operator.toString());
			return DafnyToken.ERROR;
		}
	}
	
    public final String render(String... body) {
		// assert body.length <= 2 : "Can only have 2 length or less for body parameters (2 only allowed for binary expressions)";
		
        switch(this) {
			// Patterns which are just the token
            case CHAR:		return TranslationStrategies.PARAMETERISE.render("'", body[0], "'");
            case STRING:	return TranslationStrategies.PARAMETERISE.render("\"", body[0], "\"");
            case UPLUS:
			case UMINUS:	return TranslationStrategies.PREFIX.render(dafny, body[0]);
			
            case BOOL:		return Boolean.valueOf(body[0]) ? "true" : "false";
			
            case INT:		
            case NAT:		
            case NAT1:		
            case RAT:		
			case PARAMETER_TYPE:
			case VDMQUOTE:
            case REAL:		return body[0];

            case OPTIONAL:	return TranslationStrategies.PARAMETERISE.render("vdm.Optional.of(", body[0], ")");

            
            case AT:        
            case DASH:
            case COMMA:
            case COLON:
            case DUMMY:
            case COMMENT:
            case ERROR:
            case FUN:
            case PLACEHOLDER:
            case UNDEFINED:
            case TFUN:
            case TOKEN:
            case TOKEN_TYPE:
            case TRUE:
            case FALSE:
            case RECORD:
            case SPACE:
            case UNDERSCORE:
            case SEMICOLON:
            case UNKNOWN:
            case BAR:
            case THEN:
            case NIL:
            case VDMDEFAULT:
            case VDMTOOLKIT:
            case MAP_EMPTY:
            case INV:
            case POINT:
            case MAPBIND: 
            case SEQBIND:
            case SETBIND:
            case APPLY:     return TranslationStrategies.LITERAL.render(dafny);
            case IDENTIFIER:return TranslationStrategies.LITERAL.render(DafnyIdentifiers.instance().transform(body[0]));
            
            // map<A, B>
            case INMAP:
            case MAP:       return TranslationStrategies.TYPEPARAM2.render(dafny, body[0], body[1]);
            
            // tok<T>
            case SET:
            case SET1:
            case SEQ:
            case SEQ1:      return TranslationStrategies.TYPEPARAM.render(dafny, body[0]);
            
            // tok body tok
            case LEN:
            case CARD:
            case DAFNYQUOTE:
            case ABS:       return TranslationStrategies.PARAMETERISE_SPACE.render(dafny, body[0], dafny);
            
            // binary expressions
            case ISEXPR:
            case DIVIDE:
            case EQUALS:
            case EQUALSEQUALS:
            case EQUIVALENT:
            case CROSSPROD:
            case GE:
            case GT:
            case IMPLIES:
            case INSET:
            case INTER:
            case LE:
            case LT:
            case MINUS:
            case MOD:
            case NE:
            case NOTINSET:
            case OR:
            case PLUS:
            case PLUSPLUS:
            case PSUBSET:
            case SETDIFF:
            case SUBSET:
            case TIMES:
            case TYPEOF:
            case UNION:
            case VDMUNION:
            case CONCATENATE:
            case MAPLET:
            case AND:       return TranslationStrategies.PARAMETERISE_SPACE.render(body[0], dafny, body[1]);
            
            // prefix expressions
            
            case FORALL:
            case EXISTS:
            case NOT:
            case POST:
            case PRE:
            case CASES:     return TranslationStrategies.PREFIX_SPACE.render(dafny, body[0]);
            
            // suffix expressions
            case DOM:
            case FLOOR:
            case RNG:
            case RANGE:
            case TAIL:
            case HEAD:      return TranslationStrategies.SUFFIX.render("", body[0], dafny);
            
            // custom calls 
            case INDS:
            case INVERSE:
            case MERGE:
            case MUNION:
            case IOTA:
            case REVERSE:
            case DINTER:
            case DUNION:
            case ELEMS:
            case EXISTS1:
            case REM:
			case FPOWERSET:
            case DISTCONC:  return TranslationStrategies.CALL.render(dafny, body[0]);
            case FITERATE:  return TranslationStrategies.CALL2.render(dafny, body[0], body[1] + " as nat");
            case RANGERESBY:
            case RANGERESTO:
            case DOMRESBY:
            case DOMRESTO:
            case MITERATE:  
			case DIV:
            case POW:  return TranslationStrategies.CALL2.render(dafny, body[0], body[1]);
            
            // non-mirrored calls
            case BLOCK_COMMENT_OPEN:
            case BLOCK_COMMENT_CLOSE:   return TranslationStrategies.PARAMETERISE.render(BLOCK_COMMENT_OPEN.dafny, body[0], BLOCK_COMMENT_CLOSE.dafny);
            
            case IF:
            case ELSEIF:                return TranslationStrategies.PARAMETERISE.render(dafny, body[0], THEN.dafny);
            case ELSE:                  return TranslationStrategies.PREFIX_SPACE.render(dafny, body[0]);
            
            case LET:
            case IN:                    return TranslationStrategies.PARAMETERISE.render(LET.dafny + " ", body[0], IN.dafny);
            case CONST:                 return TranslationStrategies.PARAMETERISE.render(dafny, body[0], IN.dafny);
            
            case CASE:                  return TranslationStrategies.PARAMETERISE.render(dafny, body[0], "=> " + body[1]); // not sure about this?
            
            case MAP_OPEN:
            case MAP_CLOSE:             return TranslationStrategies.PARAMETERISE.render(MAP_OPEN.dafny, body[0], MAP_CLOSE.dafny);
            
            case SEQ_OPEN:
            case SEQ_CLOSE:             return TranslationStrategies.PARAMETERISE.render(SEQ_OPEN.dafny, body[0], SEQ_CLOSE.dafny);
            
            case SET_OPEN:
            case SET_CLOSE:             return TranslationStrategies.PARAMETERISE.render(SET_OPEN.dafny, body[0], SET_CLOSE.dafny);
            
            case LPAREN:
            case RPAREN:                return TranslationStrategies.PARAMETERISE.render(LPAREN.dafny, body[0], RPAREN.dafny);
			
			case DAFNY_OPEN:
			case DAFNY_CLOSE:			return TranslationStrategies.PARAMETERISE.render(DAFNY_OPEN.dafny, body[0], DAFNY_CLOSE.dafny);
            
			case BE:

			case MK:
			case CONS:

            case LAMBDA: // does dafny have these?
			case MAPCOMP:
            
			case MODULE:
            case COMP:					// TODO unknown
				return TranslationStrategies.LITERAL.render(dafny);
			case SEQCOMP:
			case SETCOMP:
			case SETRANGE:
			case ST:
			case VARIABLE:
			case ALIAS:
			case MU:
			case PRINT:
			case PRINTF:
			case PRINTLN:
			case PRODUCT:
			case SUBSEQ:
			case VOID:
			default:
        }
		return "@vdm.error(You should never see this)";
    }

	public final String getName() {
		switch (this){
            case NAT: 
            case NAT1:
            case CHAR:
            case INT: 
            case REAL:
            case RAT: 
            case BOOL:  return dafny;
			default: return UNDEFINED.dafny;
		}
	}

	public static final TCNameToken newNameToken(String name)
	{
		return DafnyToken.newNameToken(LexLocation.ANY, ASTModule.defaultName(LexLocation.ANY).name, name);
	}

	public static final TCNameToken newNameToken(LexLocation location, String module, String name)
	{
		return new TCNameToken(location, module, name);
	}
}
