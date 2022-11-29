(* VDM to Isabelle Translation @2022-02-28T11:41:17.342915Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesNamed.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesNamed.vdmsl]
*)
theory TestV2ITypesNamed
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: TBasic1 = nat1\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 11:5\<close>
type_synonym TBasic1 = "VDMNat1"
	

\<comment>\<open>VDM source: inv_TBasic1: (TBasic1 +> bool)
	inv_TBasic1(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 11:5\<close>
definition
	inv_TBasic1 :: "TBasic1 \<Rightarrow> bool"
where
	"inv_TBasic1 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TBasic1` specification.\<close>
		(((inv_VDMNat1 dummy0)))"
 
lemmas inv_TBasic1_defs = inv_TBasic1_def inv_VDMNat1_def 


	
	
\<comment>\<open>VDM source: TBasic2 = TBasic1
	inv t == (t > 10)
	eq t1 = t2 == (t1 = t2)
	ord t1 < t2 == (t1 < t2)\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 15:5\<close>
type_synonym TBasic2 = "TBasic1"
	

\<comment>\<open>VDM source: inv_TBasic2: (TBasic1 +> bool)
	inv_TBasic2(t) ==
(t > 10)\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 17:9\<close>
definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> bool"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TBasic2` specification.\<close>
		((inv_TBasic1 t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2.\<close>
		(t > (10::VDMNat1))"

		 

\<comment>\<open>VDM source: eq_TBasic2: (TBasic1 * TBasic1 +> bool)
	eq_TBasic2(t1, t2) ==
(t1 = t2)\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 18:9\<close>
definition
	eq_TBasic2 :: "TBasic2 \<Rightarrow> TBasic2 \<Rightarrow> bool"
where
	"eq_TBasic2 t1   t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TBasic2` specification.\<close>
		((inv_TBasic2 t1)  \<and>  (inv_TBasic2 t2))  \<and> 
		\<comment>\<open>User defined body of eq_TBasic2.\<close>
		(t1 = t2)"

		 

\<comment>\<open>VDM source: ord_TBasic2: (TBasic1 * TBasic1 +> bool)
	ord_TBasic2(t1, t2) ==
(t1 < t2)\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 19:9\<close>
definition
	ord_TBasic2 :: "TBasic2 \<Rightarrow> TBasic2 \<Rightarrow> bool"
where
	"ord_TBasic2 t1   t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TBasic2` specification.\<close>
		((inv_TBasic2 t1)  \<and>  (inv_TBasic2 t2))  \<and> 
		\<comment>\<open>User defined body of ord_TBasic2.\<close>
		(t1 < t2)"

		 

\<comment>\<open>VDM source: min_TBasic2: (TBasic2 * TBasic2 +> TBasic2)
	min_TBasic2(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 19:9\<close>
definition
	min_TBasic2 :: "TBasic2 \<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"min_TBasic2 a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TBasic2` specification.\<close>
		(if ((inv_TBasic2 a)  \<and>  (inv_TBasic2 b)) then
			
		\<comment>\<open>User defined body of min_TBasic2.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TBasic2` call\<close>
	(ord_TBasic2 a   b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TBasic2` call\<close>
	(eq_TBasic2 a   b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>VDM source: max_TBasic2: (TBasic2 * TBasic2 +> TBasic2)
	max_TBasic2(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 19:9\<close>
definition
	max_TBasic2 :: "TBasic2 \<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"max_TBasic2 a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TBasic2` specification.\<close>
		(if ((inv_TBasic2 a)  \<and>  (inv_TBasic2 b)) then
			
		\<comment>\<open>User defined body of max_TBasic2.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TBasic2` call\<close>
	(ord_TBasic2 a   b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TBasic2` call\<close>
	(eq_TBasic2 a   b))) then
		(b)
		else
		(a))
			else
			undefined)"

	
lemmas inv_TBasic2_defs = inv_TBasic1_def inv_TBasic2_def inv_VDMNat1_def 


	
	
\<comment>\<open>VDM source: TBasic3 = TBasic2\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 22:5\<close>
type_synonym TBasic3 = "TBasic2"
	

\<comment>\<open>VDM source: inv_TBasic3: (TBasic3 +> bool)
	inv_TBasic3(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 22:5\<close>
definition
	inv_TBasic3 :: "TBasic3 \<Rightarrow> bool"
where
	"inv_TBasic3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TBasic3` specification.\<close>
		((inv_TBasic2 dummy0))"
 
lemmas inv_TBasic3_defs = inv_TBasic1_def inv_TBasic2_def inv_TBasic3_def inv_VDMNat1_def 


	
	
\<comment>\<open>VDM source: TBasic4 = TBasic3
	inv t == (t < 20)\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 25:5\<close>
type_synonym TBasic4 = "TBasic3"
	

\<comment>\<open>VDM source: inv_TBasic4: (TBasic3 +> bool)
	inv_TBasic4(t) ==
(t < 20)\<close>
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 27:9\<close>
definition
	inv_TBasic4 :: "TBasic4 \<Rightarrow> bool"
where
	"inv_TBasic4 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TBasic4` specification.\<close>
		((inv_TBasic3 t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic4.\<close>
		(t < (20::VDMNat1))"

		 
lemmas inv_TBasic4_defs = inv_TBasic1_def inv_TBasic2_def inv_TBasic3_def inv_TBasic4_def inv_VDMNat1_def 


end