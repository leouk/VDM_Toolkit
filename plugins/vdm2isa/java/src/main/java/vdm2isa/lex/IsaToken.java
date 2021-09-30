package vdm2isa.lex;

import java.io.Serializable;

public enum IsaToken  implements Serializable {
	// Basic types; use VDMToolkit names 
	BOOL("bool", "\\<bool>"),
	 NAT( "nat", "VDMNat"),
 	NAT1("nat1", "VDMNat1"),
	 INT( "int", "VDMInt"),
	 RAT( "rat", "VDMRat"),
	REAL("real", "VDMReal"),
	CHAR("char", "VDMChar"),
  TOKEN("token", "VDMToken"),

  	// Operators
	PLUS("+", "+"),
	MINUS("-", "-"),
	TIMES("*", "*"),
	DIVIDE("/", "/"),
	REM("rem", "vdmrem"),
	MOD("mod", "vdmmod"),
	DIV("div", "vdmdiv"),
	LT("<", "<"),
	LE("<=", "\\<le>"),
	GT(">", ">"),
	GE(">=", "\\<ge>"),
	NE("<>", "\\<noteq>"),
	EQUALS("=", "="),
	EQUALSEQUALS("==", "\\<equiv>"),
	EQUIVALENT("<=>", "\\<longleftrightarrow>"),
	IMPLIES("=>", "\\<longrightarrow>"),
	SUBSET("subset", "\\<subsetseq>"),
	PSUBSET("psubset", "\\<subset>"),
	INSET("in set", "\\<in>"),
	NOTINSET("not in set", "\\<notin>"),
	SETDIFF("\\", "\\"),
	MUNION("munion", "\\<union>m"),	//@todo add \<sub>?
	PLUSPLUS("++", "\\<dagger>"),
	STARSTAR("**", "vdmpow"), //@doc vdmpow expects real_normed_algebra_1 types only
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
	ABS("abs", "vdm_abs"),
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
	
	EOF("", "");
  private final String vdm;
  private final String isa;
  
  private IsaToken(String vdm, String isa)
  {
	  	assert vdm != null && isa != null;
		this.vdm = vdm;
		this.isa = isa;
  }
  
  public String toString()
  {
	  return isa;
  }
  
  public String vdmString()
  {
	  return vdm;
  }

}
