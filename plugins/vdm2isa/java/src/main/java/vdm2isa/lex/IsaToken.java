package vdm2isa.lex;

import java.util.Map;
import java.util.HashMap;

import com.fujitsu.vdmj.lex.Dialect;
//@todo merge this into IsaToken
import com.fujitsu.vdmj.lex.Token;

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

	APPLY(null, ""),
	VARIABLE(null, ""),
  	// Operators
	PLUS(Token.PLUS, "+"),
	MINUS(Token.MINUS, "-"),
	TIMES(Token.TIMES, "*"),
	DIVIDE(Token.DIVIDE, "/"),
	REM(Token.REM, "vdmrem"),
	MOD(Token.MOD, "vdmmod"),
	DIV(Token.DIV, "vdmdiv"),
	LT(Token.LT, "<"),
	LE(Token.LE, "\\<le>"),
	GT(Token.GT, ">"),
	GE(Token.GE, "\\<ge>"),
	NE(Token.NE, "\\<noteq>"),
	EQUALS(Token.EQUALS, "="),
	EQUALSEQUALS(Token.EQUALSEQUALS, "\\<equiv>"),
	EQUIVALENT(Token.EQUIVALENT, "\\<longleftrightarrow>"),
	IMPLIES(Token.IMPLIES, "\\<longrightarrow>"),
	ABS(Token.ABS, "vdm_abs"),
	STARSTAR(Token.STARSTAR, "vdmpow"), //@doc vdmpow expects real_normed_algebra_1 types only
	/*
	SUBSET("subset", "\\<subsetseq>"),
	PSUBSET("psubset", "\\<subset>"),
	INSET("in set", "\\<in>"),
	NOTINSET("not in set", "\\<notin>"),
	SETDIFF("\\", "\\"),
	MUNION("munion", "\\<union>m"),	//@todo add \<sub>?
	PLUSPLUS("++", "\\<dagger>"),
	UNION("union", "\\<union>"),
	INTER("inter", "\\<inter>"),
	INVERSE("inverse", "\\<inverse>"),
	CONCATENATE("^", "@"),
	MAPLET("|->", "\\<mapsto>"),
	RANGE("...", ".."),
	DOMRESTO("<:", "\\<triangleleft>"),
	DOMRESBY("<-:", "-\\<triangleleft>"),
	RANGERESTO(":>", "\\<triangleright>"),
	RANGERESBY(":->", "\\<triangleright>-"),
	CARD("card", "vdm_card"),
	DOM("dom", "dom"),
	LEN("len", "len"),
	//@todo POWER("power", "power"),
	RNG("rng", "rng"),
	ELEMS("elems", "elems"),
	DINTER("dinter", "\\<Inter>"),
	MERGE("merge", "vdm_merge"),
	HEAD("hd", "hd"),
	TAIL("tl", "tl"),
	FLOOR("floor", "vdm_floor"),
	DUNION("dunion", "\\<Union>"),
	DISTCONC("conc", "conc"),
	INDS("inds", "inds"),
	//POINT("."),
	COMP("comp", "\\<circ>m"),
	FORALL("forall", "\\<forall>"),
	EXISTS("exists", "\\<exists>"),
	EXISTS1("exists1", "\\<exists>!"),
	IOTA("iota", "SOME"),
	LAMBDA("lambda", "\\<lambda>"),
	*/
	IF(Token.IF, "if"),
	THEN(Token.THEN, "then"),
	ELSE(Token.ELSE, "else"),
	FUN(Token.ARROW, "\\<Rightarrow>"),
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
			/*
			case CARD		: return IsaToken.CARD;
			case POWER		: return IsaToken.POWER;

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
			case MERGE		: return IsaToken.MERGE;
			case PLUSPLUS		: return IsaToken.PLUSPLUS;
			case RANGE		: return IsaToken.RANGE;
			case DOMRESTO	: return IsaToken.DOMRESTO;
			case DOMRESBY	: return IsaToken.DOMRESBY;
			case RANGERESTO	: return IsaToken.RANGERESTO;
			case RANGERESBY	: return IsaToken.RANGERESBY;
			
			case INVERSE		: return IsaToken.INVERSE;
			case CONCATENATE	: return IsaToken.CONCATENATE;
			case MAPLET		: return IsaToken.MAPLET;
			case LEN			: return IsaToken.LEN;
			case DINTER		: return IsaToken.DINTER;
			case ELEMS		: return IsaToken.ELEMS;
			case HEAD		: return IsaToken.HEAD;
			case TAIL		: return IsaToken.TAIL;
			case DISTCONC	: return IsaToken.DISTCONC;
			case INDS		: return IsaToken.INDS;

			case ABS			: return IsaToken.ABS;
			case FLOOR		: return IsaToken.FLOOR;
			case DUNION		: return IsaToken.DUNION;

			//case POINT		: return IsaToken.POINT;
			case COMP		: return IsaToken.COMP;
			case FORALL		: return IsaToken.FORALL;
			case EXISTS		: return IsaToken.EXISTS;
			case EXISTS1		: return IsaToken.EXISTS1;
			case IOTA		: return IsaToken.IOTA;
			case LAMBDA		: return IsaToken.LAMBDA;
*/
		}
		throw new RuntimeException("Invalid VDM token for Isabelle translation " + operator.toString());  
	}
}
