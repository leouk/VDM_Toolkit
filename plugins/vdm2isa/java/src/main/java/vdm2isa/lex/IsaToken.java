package vdm2isa.lex;

import com.fujitsu.vdmj.ast.lex.LexToken;
import com.fujitsu.vdmj.lex.Dialect;
import com.fujitsu.vdmj.lex.LexLocation;
import com.fujitsu.vdmj.lex.Token;

import plugins.Vdm2isaPlugin;

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
  	TOKEN(Token.TOKEN, "VDMToken"),
	CROSSPROD(Token.TIMES, "\\<times>"),
	VDMQUOTE(Token.QUOTE, ""), // i.e. "<X>" => X (empty string for Token.QUOTE)
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
	TYPEOF(null, "::"),
	PLACEHOLDER(null, "_"),
	//TUPLE(null/*mk_*/, ""),
	SEQBIND(null, "\\<leftarrow>"),
	SETSEQBIND(null, "\\<leftarrow> sorted_list_of_set"),

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
	POWER(Token.POWER, "Fpow"),

	// Binary Operators
	AND(Token.AND, "\\<and>"),
	OR(Token.OR, "\\<or>"),
	IMPLIES(Token.IMPLIES, "\\<longrightarrow>"),
	EQUIVALENT(Token.EQUIVALENT, "\\<longleftrightarrow>"),

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
	ISEXPR(Token.IS, "is"),

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

	VDMTOOLKIT(null, "VDMToolkit"),
	THEOREM(null, "theorem"),
	LEMMA(null, "lemma"),
	LEMMAS(null, "lemmas"),
	TERM(null, "term"),
	TYP(null, "typ"),
	THM(null, "thm"),
  	DONE(null, "done"),
	OOPS(null, "oops"),
	SORRY(null, "sorry"),
	PROOF(null, ""),

	MODULE(Token.MODULE, "theory"),
	IF(Token.IF, "if"),
	THEN(Token.THEN, "then"),
	ELSE(Token.ELSE, "else"),
	ELSEIF(Token.ELSEIF, "else if"),
	TFUN(Token.TOTAL_FUNCTION, "\\<Rightarrow>"),
	LET(Token.LET, "let"),
	IN(Token.IN, "in"),
	SUBSCRIPT(null, "\\<^sub>"),
	SUPSCRIPT(null, "\\<^sup>"),
	EOF(Token.EOF, "EOF");

	private final Token  vdm;
	private final String isa;

	private IsaToken(Token vdm, String isa)
	{
		assert isa != null; 
		if (vdm != null && !vdm.getDialects().contains(Dialect.VDM_SL)) 
			Vdm2isaPlugin.report(10011, "Invalid VDM SL token " + vdm.name(), LexLocation.ANY);
		this.vdm = vdm;
		this.isa = isa;
	}

	//@todo add infixlr notation here to know where/when to "pad" the string! 
	public String toString()
	{
		return isa;
	}

	public Token vdmToken()
	{
		return vdm;
	}

	public static String parenthesise(String s)
	{
		return bracketit(IsaToken.LPAREN, s, IsaToken.RPAREN);
	}

	public static String comment(String s)
	{
		return comment(s, "");
	}

	public static String comment(String s, String formattingSeparator)
	{
		if (Vdm2isaPlugin.printIsaComments)
			return IsaToken.COMMENT.toString() + 
				IsaToken.bracketit(IsaToken.ISA_OPEN, s, IsaToken.ISA_CLOSE) + formattingSeparator;
		else
			return "";
	}

	public static String antiquotation(IsaToken kind, String yxml)
	{
		return IsaToken.AT.toString() +
					IsaToken.bracketit(IsaToken.SET_OPEN, 
					kind.toString() + " " + 
					IsaToken.bracketit(IsaToken.ISA_OPEN, yxml, IsaToken.ISA_CLOSE),
					IsaToken.SET_CLOSE);
	}

	public static String bracketit(IsaToken left, String s, IsaToken right)
	{
		return left.toString() + s + right.toString();
	}

	public static String innerSyntaxIt(String s) {
		return IsaToken.bracketit(IsaToken.ISAQUOTE, s, IsaToken.ISAQUOTE);
	}

	public static String dummyVarNames(int count, LexLocation location)
	{
		StringBuilder sb = new StringBuilder();
		if (count <= 0)
			Vdm2isaPlugin.report(10012, "Dummy var names call must be strictly positive; count = " + count, location);
		else
		{
			sb.append(IsaToken.DUMMY.toString() + Integer.toString(0));
			for (int i = 1; i < count; i++)
			{
				sb.append(" "); 
				sb.append(IsaToken.DUMMY.toString() + Integer.toString(i));
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
			case POWER			: return IsaToken.POWER;
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
			
		}
		Vdm2isaPlugin.report(10010, "Invalid VDM token for Isabelle translation " + operator.toString(), operator.location);  
		return IsaToken.ERROR;
	}
}
