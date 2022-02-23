(* VDM to Isabelle Translation @2022-02-23T07:53:28.812479Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'recordClocks.vdmsl' at line 1:8
files = [recordClocks.vdmsl]
*)
theory recordClocks
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Real1 = real
	inv r == (r >= 0)\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 7:5\<close>
type_synonym Real1 = "VDMReal"
	

\<comment>\<open>VDM source: inv_Real1: (real +> bool)
	inv_Real1(r) ==
(r >= 0)\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 8:9\<close>
definition
	inv_Real1 :: "Real1 \<Rightarrow> bool"
where
	"inv_Real1 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Real1` specification.\<close>
		(((inv_VDMReal r)))  \<and> 
		\<comment>\<open>User defined body of inv_Real1.\<close>
		(r \<ge> (0::VDMNat))"

		 
lemmas inv_Real1_defs = inv_Real1_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: Time = compose Time of r:Real1, i:nat end
	eq a = b == (((a.r) = (b.r)) and ((a.i) = (b.i)))
	ord a < b == (((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 14:5\<close>
record Time = 
	r\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "Real1"
		 
		 i\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMNat"
	

\<comment>\<open>VDM source: inv_Time: (Time +> bool)
	inv_Time(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 14:5\<close>
definition
	inv_Time :: "Time \<Rightarrow> bool"
where
	"inv_Time dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Time` specification.\<close>
		( (((inv_Real1 (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e dummy0))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e dummy0))) ))"
 

\<comment>\<open>VDM source: eq_Time: (Time * Time +> bool)
	eq_Time(a, b) ==
(((a.r) = (b.r)) and ((a.i) = (b.i)))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 17:8\<close>
definition
	eq_Time :: "Time \<Rightarrow> Time \<Rightarrow> bool"
where
	"eq_Time a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of eq_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)))"
 

\<comment>\<open>VDM source: ord_Time: (Time * Time +> bool)
	ord_Time(a, b) ==
(((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 18:9\<close>
definition
	ord_Time :: "Time \<Rightarrow> Time \<Rightarrow> bool"
where
	"ord_Time a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of ord_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) < (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<or> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) < (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e b))))"
 
lemmas inv_Time_defs = inv_Real1_def inv_Time_def inv_VDMNat_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: ValueType = (bool | real)\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 25:5\<close>
datatype ValueType = U_bool "bool" | 
		 U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_ValueType: (ValueType +> bool)
	inv_ValueType(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 25:5\<close>
definition
	inv_ValueType :: "ValueType \<Rightarrow> bool"
where
	"inv_ValueType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ValueType` specification.\<close>
		(((case dummy0 of
		 ValueType.U_bool dummy0 \<Rightarrow> (inv_bool dummy0)
		  | ValueType.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 
lemmas inv_ValueType_defs = inv_VDMReal_def inv_ValueType_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Name = seq1 of (char)\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 31:5\<close>
type_synonym Name = "VDMChar VDMSeq1"
	

\<comment>\<open>VDM source: inv_Name: (Name +> bool)
	inv_Name(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 31:5\<close>
definition
	inv_Name :: "Name \<Rightarrow> bool"
where
	"inv_Name dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Name` specification.\<close>
		(((inv_VDMSeq1' (inv_VDMChar) dummy0)))"

		 
lemmas inv_Name_defs = inv_Name_def inv_VDMChar_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


	
	
\<comment>\<open>VDM source: Ref = nat\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 36:5\<close>
type_synonym Ref = "VDMNat"
	

\<comment>\<open>VDM source: inv_Ref: (Ref +> bool)
	inv_Ref(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 36:5\<close>
definition
	inv_Ref :: "Ref \<Rightarrow> bool"
where
	"inv_Ref dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Ref` specification.\<close>
		(((inv_VDMNat dummy0)))"
 
lemmas inv_Ref_defs = inv_Ref_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: FMIValue = compose FMIValue of fmiValue:ValueType, time:Time end
	eq mk_FMIValue(val1, t1) = mk_FMIValue(val2, t2) == ((val1 = val2) and (t1 = t2))
	ord mk_FMIValue(-, t1) < mk_FMIValue(-, t2) == (t1 < t2)\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 42:5\<close>
record FMIValue = 
	fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "ValueType"
		 
		 time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "Time"
	

\<comment>\<open>VDM source: inv_FMIValue: (FMIValue +> bool)
	inv_FMIValue(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 42:5\<close>
definition
	inv_FMIValue :: "FMIValue \<Rightarrow> bool"
where
	"inv_FMIValue dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMIValue` specification.\<close>
		( (((inv_ValueType (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0))) \<and> 
		 (inv_Time (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0)) ))"

		

\<comment>\<open>VDM source: eq_FMIValue: (FMIValue * FMIValue +> bool)
	eq_FMIValue(mk_FMIValue(val1, t1), mk_FMIValue(val2, t2)) ==
((val1 = val2) and (t1 = t2))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 45:8\<close>
definition
	eq_FMIValue :: "FMIValue \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"eq_FMIValue dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_FMIValue` specification.\<close>
		(inv_FMIValue dummy0  \<and>  inv_FMIValue dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let val1 = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); 
			val1 = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of eq_FMIValue.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		()))"

		

\<comment>\<open>VDM source: ord_FMIValue: (FMIValue * FMIValue +> bool)
	ord_FMIValue(mk_FMIValue(-, t1), mk_FMIValue(-, t2)) ==
(t1 < t2)\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 48:9\<close>
definition
	ord_FMIValue :: "FMIValue \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"ord_FMIValue dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_FMIValue` specification.\<close>
		(inv_FMIValue dummy0  \<and>  inv_FMIValue dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let dummy0_ignore = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); 
			dummy0_ignore = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of ord_FMIValue.\<close>
		\<comment>\<open>Transform a VDM `<` expression into an `ord_Time` call\<close>
	(ord_Time t1   t2))"

		
lemmas inv_FMIValue_defs = inv_FMIValue_def inv_Real1_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Environment = map (Ref) to (FMIValue)
	inv - == true\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 54:5\<close>
type_synonym Environment = "(Ref \<rightharpoonup> FMIValue)"
	

\<comment>\<open>VDM source: inv_Environment: (map (Ref) to (FMIValue) +> bool)
	inv_Environment(-) ==
true\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 55:9\<close>
definition
	inv_Environment :: "Environment \<Rightarrow> bool"
where
	"inv_Environment dummy0_ignore \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Environment` specification.\<close>
		(((inv_Map (inv_Ref) inv_FMIValue  dummy0_ignore)))  \<and> 
		\<comment>\<open>User defined body of inv_Environment.\<close>
		(True::\<bool>)"
 
lemmas inv_Environment_defs = inv_Environment_def inv_FMIValue_def inv_Map_defs inv_Real1_def inv_Ref_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Equation = (Environment -> Environment)\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 61:5\<close>
type_synonym Equation = "Environment \<Rightarrow> Environment"
	

\<comment>\<open>VDM source: inv_Equation: (Equation +> bool)
	inv_Equation(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 61:5\<close>
definition
	inv_Equation :: "Equation \<Rightarrow> bool"
where
	"inv_Equation dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Equation` specification.\<close>
		(((inv_Lambda (inv_Environment) (inv_Environment)dummy0)))"

		 
lemmas inv_Equation_defs = inv_Environment_def inv_Equation_def inv_FMIValue_def inv_Lambda_def inv_Map_defs inv_Real1_def inv_Ref_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Variable = compose Variable of name:Name, ref:Ref end\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 66:5\<close>
record Variable = 
	name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Name"
		 
		 ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref"
	

\<comment>\<open>VDM source: inv_Variable: (Variable +> bool)
	inv_Variable(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 66:5\<close>
definition
	inv_Variable :: "Variable \<Rightarrow> bool"
where
	"inv_Variable dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Variable` specification.\<close>
		( (((inv_Name (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) \<and> 
		 ((inv_Ref (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) ))"

		
lemmas inv_Variable_defs = inv_Name_def inv_Ref_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_Variable_def 


	
	
\<comment>\<open>VDM source: IOLeo = compose IOLeo of LFinput:set of (Variable), LFoutput:set of (Variable) end
	inv mk_IOLeo(LFinput, LFoutput) == ((LFinput union LFoutput) <> {})\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 71:5\<close>
record IOLeo = 
	LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o :: "Variable VDMSet"
		 
		 LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o :: "Variable VDMSet"
	

\<comment>\<open>VDM source: inv_IOLeo: (IOLeo +> bool)
	inv_IOLeo(mk_IOLeo(LFinput, LFoutput)) ==
((LFinput union LFoutput) <> {})\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 75:9\<close>
definition
	inv_IOLeo :: "IOLeo \<Rightarrow> bool"
where
	"inv_IOLeo dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_IOLeo` specification.\<close>
		( (((inv_VDMSet' inv_Variable  (LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o dummy0))) \<and> 
		 ((inv_VDMSet' inv_Variable  (LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let LFinput = (LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o dummy0); LFoutput = (LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o dummy0) in 
		\<comment>\<open>User defined body of inv_IOLeo.\<close>
		((LFinput \<union> LFoutput) \<noteq> {}))"

		
lemmas inv_IOLeo_defs = inv_IOLeo_def inv_Name_def inv_Ref_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_Variable_def 


	
	
\<comment>\<open>VDM source: FMU = compose FMU of id:nat, name:Name, io:IOLeo, env:Environment end\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 78:5\<close>
record FMU = 
	id\<^sub>F\<^sub>M\<^sub>U :: "VDMNat"
		 
		 name\<^sub>F\<^sub>M\<^sub>U :: "Name"
		 
		 io\<^sub>F\<^sub>M\<^sub>U :: "IOLeo"
		 
		 env\<^sub>F\<^sub>M\<^sub>U :: "Environment"
	

\<comment>\<open>VDM source: inv_FMU: (FMU +> bool)
	inv_FMU(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 78:5\<close>
definition
	inv_FMU :: "FMU \<Rightarrow> bool"
where
	"inv_FMU dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMU` specification.\<close>
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 ((inv_Name (name\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 (inv_IOLeo (io\<^sub>F\<^sub>M\<^sub>U dummy0)) \<and> 
		 ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U dummy0))) ))"
 
lemmas inv_FMU_defs = inv_Environment_def inv_FMIValue_def inv_FMU_def inv_IOLeo_def inv_Map_defs inv_Name_def inv_Real1_def inv_Ref_def inv_Time_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_ValueType_def inv_Variable_def inv_bool_def 


	
	
\<comment>\<open>VDM source: calculate: (Ref * Environment * Time -> FMIValue)
	calculate(ref, env, time) ==
mk_FMIValue((env(ref).fmiValue), time)
	pre ((ref in set (dom env)) and inv_Environment(env))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 88:5\<close>

\<comment>\<open>VDM source: pre_calculate: (Ref * Environment * Time +> bool)
	pre_calculate(ref, env, time) ==
((ref in set (dom env)) and inv_Environment(env))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 96:9\<close>
definition
	pre_calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_calculate ref   env   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculate` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time)  \<and> 
		\<comment>\<open>User defined body of pre_calculate.\<close>
		((ref \<in> (dom env)) \<and> (inv_Environment env))"


\<comment>\<open>VDM source: post_calculate: (Ref * Environment * Time * FMIValue +> bool)
	post_calculate(ref, env, time, RESULT) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 88:5\<close>
definition
	post_calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"post_calculate ref   env   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_calculate` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time  \<and>  inv_FMIValue RESULT)"

definition
	calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> FMIValue"
where
	"calculate ref   env   time \<equiv> 
	\<comment>\<open>User defined body of calculate.\<close>
	\<lparr>fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the((env ref)))), time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = time\<rparr>"

	
	
\<comment>\<open>VDM source: calculate2: (Ref * Environment * Time -> FMIValue)
	calculate2(ref, env, time) ==
let valueType:ValueType = (env(ref).fmiValue) in mk_FMIValue(valueType, time)
	pre (ref in set (dom env))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 98:5\<close>

\<comment>\<open>VDM source: pre_calculate2: (Ref * Environment * Time +> bool)
	pre_calculate2(ref, env, time) ==
(ref in set (dom env))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 103:13\<close>
definition
	pre_calculate2 :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_calculate2 ref   env   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculate2` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time)  \<and> 
		\<comment>\<open>User defined body of pre_calculate2.\<close>
		(ref \<in> (dom env))"


\<comment>\<open>VDM source: post_calculate2: (Ref * Environment * Time * FMIValue +> bool)
	post_calculate2(ref, env, time, RESULT) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 98:5\<close>
definition
	post_calculate2 :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"post_calculate2 ref   env   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_calculate2` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time  \<and>  inv_FMIValue RESULT)"

definition
	calculate2 :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> FMIValue"
where
	"calculate2 ref   env   time \<equiv> 
	\<comment>\<open>User defined body of calculate2.\<close>
	(
		let 
(valueType::ValueType) = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the((env ref))))
		in
			(if (((inv_ValueType ))valueType) then
			\<lparr>fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = valueType, time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = time\<rparr>
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: calculate3: (Ref * Environment * Time -> FMIValue)
	calculate3(ref, env, time) ==
let valueType:real = (env(ref).fmiValue) in mk_FMIValue(valueType, time)
	pre ((ref in set (dom env)) and inv_Environment(env))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 106:5\<close>

\<comment>\<open>VDM source: pre_calculate3: (Ref * Environment * Time +> bool)
	pre_calculate3(ref, env, time) ==
((ref in set (dom env)) and inv_Environment(env))\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 112:9\<close>
definition
	pre_calculate3 :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_calculate3 ref   env   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculate3` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time)  \<and> 
		\<comment>\<open>User defined body of pre_calculate3.\<close>
		((ref \<in> (dom env)) \<and> (inv_Environment env))"


\<comment>\<open>VDM source: post_calculate3: (Ref * Environment * Time * FMIValue +> bool)
	post_calculate3(ref, env, time, RESULT) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 106:5\<close>
definition
	post_calculate3 :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"post_calculate3 ref   env   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_calculate3` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time  \<and>  inv_FMIValue RESULT)"

definition
	calculate3 :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> FMIValue"
where
	"calculate3 ref   env   time \<equiv> 
	\<comment>\<open>User defined body of calculate3.\<close>
	(
		let 
(valueType::VDMReal) = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the((env ref))))
		in
			(if ((inv_VDMReal valueType)) then
			\<lparr>fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = ValueType.U_VDMReal valueType, time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = time\<rparr>
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: updateOutputs: (FMU * Time -> Environment)
	updateOutputs(fmu, time) ==
let outputRef:set of (Ref) = {(outputVar.ref) | outputVar in set ((fmu.io).LFoutput)} in {oValue |-> calculate(oValue, (fmu.env), time) | oValue in set ((dom (fmu.env)) inter outputRef) & pre_calculate(oValue, (fmu.env), time)}
	pre true\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 122:5\<close>

\<comment>\<open>VDM source: pre_updateOutputs: (FMU * Time +> bool)
	pre_updateOutputs(fmu, time) ==
true\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 127:9\<close>
definition
	pre_updateOutputs :: "FMU \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_updateOutputs fmu   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_updateOutputs` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time)  \<and> 
		\<comment>\<open>User defined body of pre_updateOutputs.\<close>
		(True::\<bool>)"


\<comment>\<open>VDM source: post_updateOutputs: (FMU * Time * Environment +> bool)
	post_updateOutputs(fmu, time, RESULT) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 122:5\<close>
definition
	post_updateOutputs :: "FMU \<Rightarrow> Time \<Rightarrow> Environment \<Rightarrow> bool"
where
	"post_updateOutputs fmu   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_updateOutputs` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time  \<and>  (inv_Environment RESULT))"

definition
	updateOutputs :: "FMU \<Rightarrow> Time \<Rightarrow> Environment"
where
	"updateOutputs fmu   time \<equiv> 
	\<comment>\<open>User defined body of updateOutputs.\<close>
	(
		let 
(outputRef::Ref VDMSet) = { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputVar) | outputVar .  ((outputVar \<in>(LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))))  }
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) outputRef)) then
			(\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ oValue .   ((oValue \<in>((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)))  \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time) } 
		{ (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time) | (dummy0RANGE :: FMIValue) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  ((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		)))  \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time) } 
		(inv_VDMNat) 
		
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue)))) ))
		) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat)   (dummy0RANGE :: FMIValue) .
		(if (((inv_VDMNat dummy0DOMAIN)))  \<and>  ((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		))) \<and>  ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . (((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		(dummy0RANGE)
		else
		(undefined))) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . (((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		(dummy0RANGE)
		else
		(undefined))) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . (((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		(dummy0RANGE)
		else
		(undefined))))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . (((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		(dummy0RANGE)
		else
		(undefined))) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . (((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		(dummy0RANGE)
		else
		(undefined))))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . (((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . (((
		((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) ))
		))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) ) then
			(
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat)   (dummy0RANGE :: FMIValue) .
		(if (((inv_VDMNat dummy0DOMAIN)))  \<and>  (( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<and> (inv_bool (
		if ((\<exists> oValue \<in> ((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)  . ((oValue \<in> ((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))) then
		((True::\<bool>))
		else
		(undefined))) then
			(
		if ((\<exists> oValue \<in> ((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)  . ((oValue \<in> ((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)) \<and> (pre_calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))) then
		((True::\<bool>))
		else
		(undefined))
		 else
			undefined
		)
		))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: updateOutputs2: (FMU * Time -> Environment)
	updateOutputs2(fmu, time) ==
let outputRef:set of (Ref) = {(outputVar.ref) | outputVar in set ((fmu.io).LFoutput)}, env:Environment = {oValue |-> calculate2(oValue, (fmu.env), time) | oValue in set ((dom (fmu.env)) inter outputRef) & (inv_Environment((fmu.env)) and pre_calculate2(oValue, (fmu.env), time))} in env
	pre true\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 131:5\<close>

\<comment>\<open>VDM source: pre_updateOutputs2: (FMU * Time +> bool)
	pre_updateOutputs2(fmu, time) ==
true\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 139:9\<close>
definition
	pre_updateOutputs2 :: "FMU \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_updateOutputs2 fmu   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_updateOutputs2` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time)  \<and> 
		\<comment>\<open>User defined body of pre_updateOutputs2.\<close>
		(True::\<bool>)"


\<comment>\<open>VDM source: post_updateOutputs2: (FMU * Time * Environment +> bool)
	post_updateOutputs2(fmu, time, RESULT) ==
null\<close>
\<comment>\<open>in 'recordClocks' (recordClocks.vdmsl) at line 131:5\<close>
definition
	post_updateOutputs2 :: "FMU \<Rightarrow> Time \<Rightarrow> Environment \<Rightarrow> bool"
where
	"post_updateOutputs2 fmu   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_updateOutputs2` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time  \<and>  (inv_Environment RESULT))"

definition
	updateOutputs2 :: "FMU \<Rightarrow> Time \<Rightarrow> Environment"
where
	"updateOutputs2 fmu   time \<equiv> 
	\<comment>\<open>User defined body of updateOutputs2.\<close>
	(
		let 
(outputRef::Ref VDMSet) = { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputVar) | outputVar .  ((outputVar \<in>(LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))))  }
		;
		
(env::Environment) = (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ oValue .   ((oValue \<in>((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)))  \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) } 
		{ (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time) | (dummy0RANGE :: FMIValue) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
\<comment> \<open>Problem probably here on the union type result; but have to distill the example a bit\<close>	
	 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) )))  \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) } 
		(inv_VDMNat) 
		 ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue)))) )) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat)   (dummy0RANGE :: FMIValue) .
		(if (((inv_VDMNat dummy0DOMAIN)))  \<and>  (( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<and>  ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))))) then
		(dummy0RANGE)
		else
		(undefined))) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))))) then
		(dummy0RANGE)
		else
		(undefined))) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))))) then
		(dummy0RANGE)
		else
		(undefined))))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))))) then
		(dummy0RANGE)
		else
		(undefined))) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))))) then
		(dummy0RANGE)
		else
		(undefined))))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) ) then
			(
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat)   (dummy0RANGE :: FMIValue) .
		(if (((inv_VDMNat dummy0DOMAIN)))  \<and>  (( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<and> (inv_bool (
		if ((\<exists> oValue \<in> ((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)  . ((oValue \<in> ((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		((True::\<bool>))
		else
		(undefined))) then
			(
		if ((\<exists> oValue \<in> ((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)  . ((oValue \<in> ((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<inter> outputRef)) \<and> ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (pre_calculate2 oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time))))) then
		((True::\<bool>))
		else
		(undefined))
		 else
			undefined
		)
		))
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) outputRef))
	 \<and> 
	(((inv_Map ((inv_VDMNat)) inv_FMIValue ))env) then
			env
		 else
			undefined
		)
		)"

end