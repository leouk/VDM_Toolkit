(* VDM to Isabelle Translation @2022-02-23T14:10:48.544676Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'recordClocks1.vdmsl' at line 1:8
files = [recordClocks1.vdmsl]
*)
theory recordClocks1
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Real1 = real
	inv r == (r >= 0)\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 6:5\<close>
type_synonym Real1 = "VDMReal"
	

\<comment>\<open>VDM source: inv_Real1: (real +> bool)
	inv_Real1(r) ==
(r >= 0)\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 7:9\<close>
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
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 13:5\<close>
record Time = 
	r\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "Real1"
		 
		 i\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMNat"
	

\<comment>\<open>VDM source: inv_Time: (Time +> bool)
	inv_Time(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 13:5\<close>
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
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 16:8\<close>
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
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 17:9\<close>
definition
	ord_Time :: "Time \<Rightarrow> Time \<Rightarrow> bool"
where
	"ord_Time a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of ord_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) < (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<or> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) < (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e b))))"
 
lemmas inv_Time_defs = inv_Real1_def inv_Time_def inv_VDMNat_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: ValueType = nat\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 22:5\<close>
type_synonym ValueType = "VDMNat"
	

\<comment>\<open>VDM source: inv_ValueType: (ValueType +> bool)
	inv_ValueType(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 22:5\<close>
definition
	inv_ValueType :: "ValueType \<Rightarrow> bool"
where
	"inv_ValueType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ValueType` specification.\<close>
		(((inv_VDMNat dummy0)))"

		 
lemmas inv_ValueType_defs = inv_VDMNat_def inv_ValueType_def 


	
	
\<comment>\<open>VDM source: Ref = nat\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 24:5\<close>
type_synonym Ref = "VDMNat"
	

\<comment>\<open>VDM source: inv_Ref: (Ref +> bool)
	inv_Ref(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 24:5\<close>
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
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 30:5\<close>
record FMIValue = 
	fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "ValueType"
		 
		 time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "Time"
	

\<comment>\<open>VDM source: inv_FMIValue: (FMIValue +> bool)
	inv_FMIValue(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 30:5\<close>
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
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 33:8\<close>
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
		((val1 = val2) \<and> \<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time t1   t2)))"

		

\<comment>\<open>VDM source: ord_FMIValue: (FMIValue * FMIValue +> bool)
	ord_FMIValue(mk_FMIValue(-, t1), mk_FMIValue(-, t2)) ==
(t1 < t2)\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 36:9\<close>
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

		
lemmas inv_FMIValue_defs = inv_FMIValue_def inv_Real1_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def 


	
	
\<comment>\<open>VDM source: Environment = map (Ref) to (FMIValue)
	inv - == true\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 42:5\<close>
type_synonym Environment = "(Ref \<rightharpoonup> FMIValue)"
	

\<comment>\<open>VDM source: inv_Environment: (map (Ref) to (FMIValue) +> bool)
	inv_Environment(-) ==
true\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 43:9\<close>
definition
	inv_Environment :: "Environment \<Rightarrow> bool"
where
	"inv_Environment dummy0_ignore \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Environment` specification.\<close>
		(((inv_Map (inv_Ref) inv_FMIValue  dummy0_ignore)))  \<and> 
		\<comment>\<open>User defined body of inv_Environment.\<close>
		(True::\<bool>)"

		 
lemmas inv_Environment_defs = inv_Environment_def inv_FMIValue_def inv_Map_defs inv_Real1_def inv_Ref_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def 


	
	
\<comment>\<open>VDM source: Variable = compose Variable of ref:Ref end\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 48:5\<close>
record Variable = 
	ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref"
	

\<comment>\<open>VDM source: inv_Variable: (Variable +> bool)
	inv_Variable(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 48:5\<close>
definition
	inv_Variable :: "Variable \<Rightarrow> bool"
where
	"inv_Variable dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Variable` specification.\<close>
		( (((inv_Ref (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) ))"

		
lemmas inv_Variable_defs = inv_Ref_def inv_VDMNat_def inv_Variable_def 


	
	
\<comment>\<open>VDM source: FMU = compose FMU of id:nat, env:Environment end\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 52:5\<close>
record FMU = 
	id\<^sub>F\<^sub>M\<^sub>U :: "VDMNat"
		 
		 env\<^sub>F\<^sub>M\<^sub>U :: "Environment"
	

\<comment>\<open>VDM source: inv_FMU: (FMU +> bool)
	inv_FMU(dummy0) ==
null\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 52:5\<close>
definition
	inv_FMU :: "FMU \<Rightarrow> bool"
where
	"inv_FMU dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMU` specification.\<close>
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U dummy0))) ))"
 
lemmas inv_FMU_defs = inv_Environment_def inv_FMIValue_def inv_FMU_def inv_Map_defs inv_Real1_def inv_Ref_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def 


	
	
\<comment>\<open>VDM source: updateOutputs_Types: (FMU * Time -> Environment)
	updateOutputs_Types(fmu, time) ==
let nat_values:set of (nat) = {oValue | oValue in set (dom (fmu.env)) & is_(oValue, nat)}, mapValues:set of (FMIValue) = {mk_FMIValue(oValue, time) | oValue in set nat_values} in {oValue |-> mapValue | oValue in set nat_values, mapValue in set mapValues}
	pre true\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 70:5\<close>

\<comment>\<open>VDM source: pre_updateOutputs_Types: (FMU * Time +> bool)
	pre_updateOutputs_Types(fmu, time) ==
true\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 77:9\<close>
definition
	pre_updateOutputs_Types :: "FMU \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_updateOutputs_Types fmu   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_updateOutputs_Types` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time)  \<and> 
		\<comment>\<open>User defined body of pre_updateOutputs_Types.\<close>
		(True::\<bool>)"


\<comment>\<open>VDM source: post_updateOutputs_Types: (FMU * Time * Environment +> bool)
	post_updateOutputs_Types(fmu, time, RESULT) ==
null\<close>
\<comment>\<open>in 'recordClocks1' (recordClocks1.vdmsl) at line 70:5\<close>
definition
	post_updateOutputs_Types :: "FMU \<Rightarrow> Time \<Rightarrow> Environment \<Rightarrow> bool"
where
	"post_updateOutputs_Types fmu   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_updateOutputs_Types` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time  \<and>  (inv_Environment RESULT))"

definition
  ex :: "FMU \<Rightarrow> Time \<Rightarrow> VDMNat VDMSet \<Rightarrow> FMIValue VDMSet \<Rightarrow> Environment"
  where
  "ex \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ oValue .   ((oValue \<in>nat_values))  } 
		{ mapValue .   ((mapValue \<in>mapValues))  } 
		(inv_VDMNat) 
		
		((((inv_VDMNat (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue)))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue)))) ))
		) 
		(domid ) 
		(rngid ) 
		(truecnst ))"


definition
	updateOutputs_Types :: "FMU \<Rightarrow> Time \<Rightarrow> Environment"
where
	"updateOutputs_Types fmu   time \<equiv> 
	\<comment>\<open>User defined body of updateOutputs_Types.\<close>
	(
		let 
(nat_values::VDMNat VDMSet) = { oValue .   ((oValue \<in>(dom (env\<^sub>F\<^sub>M\<^sub>U fmu))))  \<and> isTest (oValue) (inv_VDMNat) }
		;
		
(mapValues::FMIValue VDMSet) = { \<lparr>fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = oValue, time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = time\<rparr> | oValue .  ((oValue \<in>nat_values))  }
		in
			(if ((inv_VDMSet' (inv_VDMNat) nat_values))
	 \<and> 
	((inv_VDMSet' inv_FMIValue  mapValues)) then
			Map.empty
		 else
			undefined
		)
		)"

end