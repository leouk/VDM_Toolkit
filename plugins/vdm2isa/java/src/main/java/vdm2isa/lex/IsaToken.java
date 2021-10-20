package vdm2isa.lex;

import java.util.Map;
import java.util.HashMap;

import com.fujitsu.vdmj.lex.Dialect;
//@todo merge this into IsaToken
import com.fujitsu.vdmj.lex.Token;

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
  	TOKEN(Token.TOKEN, "VDMToken"),
	CROSSPROD(Token.TIMES, "\\<times>"),
	QUOTE(Token.QUOTE, ""),
	SET(Token.SET, "VDMSet"),
	SET1(Token.SET1, "VDMSet1"),
	SEQ(Token.SEQ, "VDMSeq"),
	SEQ1(Token.SEQ1, "VDMSeq1"),
	MAP(Token.MAP, "\\<rightharpoonup>"),
	INMAP(Token.INMAP, "\\<rightharpoonup>"),
	FUN(Token.ARROW, "\\<Rightarrow>"),
	TRUE(Token.TRUE, "True"),
	FALSE(Token.FALSE, "False"),

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
	//@todo POWER("power", "power"),

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

	INSET(Token.INSET, "\\<in>"),
	NOTINSET(Token.NOTINSET, "\\<notin>"),
	UNION(Token.UNION, "\\<union>"),
	INTER(Token.INTER, "\\<inter>"),
	SETDIFF(Token.SETDIFF, "-"),
	SUBSET(Token.SUBSET, "\\<subsetseq>"),
	PSUBSET(Token.PSUBSET, "\\<subset>"),

	CONCATENATE(Token.CONCATENATE, "@"),

	PLUSPLUS(Token.PLUSPLUS, "\\<dagger>"),
	DOMRESTO(Token.DOMRESTO, "\\<triangleleft>"),
	DOMRESBY(Token.DOMRESBY, "-\\<triangleleft>"),
	RANGERESTO(Token.RANGERESTO, "\\<triangleright>"),
	RANGERESBY(Token.RANGERESBY, "\\<triangleright>-"),
	MUNION(Token.MUNION, "\\<union>m"),	//@todo add \<sub>?
	COMP(Token.COMP, "\\<circ>m"),
	

	APPLY(null, ""),
	VARIABLE(null, ""),
	INV(null, "inv_"),
  	
	EQUALSEQUALS(Token.EQUALSEQUALS, "\\<equiv>"),
	INVERSE(Token.INVERSE, "\\<inverse>"), //@todo this is post-fix? 
	MAPLET(Token.MAPLET, "\\<mapsto>"),
	RANGE(Token.RANGE, ".."),
	//POINT("."),
	FORALL(Token.FORALL, "\\<forall>"),
	EXISTS(Token.EXISTS, "\\<exists>"),
	EXISTS1(Token.EXISTS1, "\\<exists>!"),
	IOTA(Token.IOTA, "SOME"),
	LAMBDA(Token.LAMBDA, "\\<lambda>"),
	
	SET_OPEN(Token.SET_OPEN, "{"),
	SET_CLOSE(Token.SET_CLOSE, "}"),
	SEQ_OPEN(Token.SEQ_OPEN, "["),
	SEQ_CLOSE(Token.SEQ_CLOSE, "]"),
	MAP_OPEN(Token.SET_OPEN, "["),
	MAP_CLOSE(Token.SET_CLOSE, "]"),
	COMMA(Token.COMMA, ","),

	MODULE(Token.MODULE, "theory"),
	IF(Token.IF, "if"),
	THEN(Token.THEN, "then"),
	ELSE(Token.ELSE, "else"),
	TFUN(Token.TOTAL_FUNCTION, "\\<Rightarrow>"),
	EOF(Token.EOF, "EOF");

	private final Token  vdm;
	private final String isa;

	private IsaToken(Token vdm, String isa)
	{
		assert isa != null; 
		//@nb could this be available somehow? Token.lookup(vdm.toString(), Dialect.VDM_SL)
		//if (vdm == null ||
		//	Token.lookup(vdm.toString(), Dialect.VDM_PP) != null ||
	   	//    Token.lookup(vdm.toString(), Dialect.VDM_RT) != null)
		//	   throw new IllegalArgumentException("Invalid VDM PP or RT token " + vdm.toString());
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

	public static boolean parenthesise(IsaToken i)
	{
		return false;
	}

	//@TODO fix after finalisaing Token above. 
	public static IsaToken from(Token operator)
	{
		assert operator != null; 
		switch (operator)
		{
			// binary arithmetic operators
			case PLUS			: return IsaToken.PLUS;
			case MINUS			: return IsaToken.MINUS;
			case TIMES			: return IsaToken.TIMES;
			case DIVIDE			: return IsaToken.DIVIDE;
			case REM			: return IsaToken.REM;
			case MOD			: return IsaToken.MOD;
			case DIV			: return IsaToken.DIV;
			case STARSTAR		: return IsaToken.STARSTAR;
			
			// binary relational operators
			case LT				: return IsaToken.LT;
			case LE				: return IsaToken.LE;
			case GT				: return IsaToken.GT;
			case GE				: return IsaToken.GE;
			case NE				: return IsaToken.NE;
			case EQUALS			: return IsaToken.EQUALS;
			
			//case EQUALSEQUALS: return IsaToken.;
			
			case EQUIVALENT	    : return IsaToken.EQUIVALENT;
			case IMPLIES		: return IsaToken.IMPLIES;
			
			case CARD			: return IsaToken.CARD;
			//case POWER		: return IsaToken.POWER;

			case UNION			: return IsaToken.UNION;
			case INTER			: return IsaToken.INTER;
			case SUBSET			: return IsaToken.SUBSET;
			case PSUBSET		: return IsaToken.PSUBSET;
			case INSET			: return IsaToken.INSET;
			case NOTINSET		: return IsaToken.NOTINSET;
			case SETDIFF		: return IsaToken.SETDIFF;
			
			case DOM			: return IsaToken.DOM;
			case RNG			: return IsaToken.RNG;
			case MUNION			: return IsaToken.MUNION;
			case MERGE			: return IsaToken.MERGE;
			case PLUSPLUS		: return IsaToken.PLUSPLUS;
			case RANGE			: return IsaToken.RANGE;
			case DOMRESTO		: return IsaToken.DOMRESTO;
			case DOMRESBY		: return IsaToken.DOMRESBY;
			case RANGERESTO		: return IsaToken.RANGERESTO;
			case RANGERESBY		: return IsaToken.RANGERESBY;
			
			case INVERSE		: return IsaToken.INVERSE;
			case CONCATENATE	: return IsaToken.CONCATENATE;
			case MAPLET			: return IsaToken.MAPLET;
			case LEN			: return IsaToken.LEN;
			case DINTER			: return IsaToken.DINTER;
			case ELEMS			: return IsaToken.ELEMS;
			case HEAD			: return IsaToken.HEAD;
			case TAIL			: return IsaToken.TAIL;
			case DISTCONC		: return IsaToken.DISTCONC;
			case INDS			: return IsaToken.INDS;

			case ABS			: return IsaToken.ABS;
			case FLOOR			: return IsaToken.FLOOR;
			case DUNION			: return IsaToken.DUNION;

			//case POINT		: return IsaToken.POINT;
			case COMP			: return IsaToken.COMP;
			case FORALL			: return IsaToken.FORALL;
			case EXISTS			: return IsaToken.EXISTS;
			case EXISTS1		: return IsaToken.EXISTS1;
			case IOTA			: return IsaToken.IOTA;
			case LAMBDA			: return IsaToken.LAMBDA;
			
		}
		throw new RuntimeException("Invalid VDM token for Isabelle translation " + operator.toString());  
	}
}
