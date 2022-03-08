(* VDM to Isabelle Translation @2022-03-08T11:19:03.974356Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypes.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypes.vdmsl]
*)
theory TestV2ITypes
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: TBasic1 = nat1\<close>
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 11:5\<close>
type_synonym TBasic1 = "VDMNat1"
	

\<comment>\<open>VDM source: inv_TBasic1: (TBasic1 +> bool)
	inv_TBasic1(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 11:5\<close>
definition
	inv_TBasic1 :: "TBasic1 \<Rightarrow> bool"
where
	"inv_TBasic1 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TBasic1` specification.\<close>
		(((inv_VDMNat1 dummy0)))"

		 
lemmas inv_TBasic1_defs = inv_TBasic1_def inv_VDMNat1_def 


	
	
\<comment>\<open>VDM source: TBasic2 = nat1
	inv t == (t > 10)
	eq t1 = t2 == (t1 = t2)
	ord t1 < t2 == (t1 < t2)\<close>
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 14:5\<close>
type_synonym TBasic2 = "VDMNat1"
	

\<comment>\<open>VDM source: inv_TBasic2: (nat1 +> bool)
	inv_TBasic2(t) ==
(t > 10)\<close>
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 15:9\<close>
definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> bool"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TBasic2` specification.\<close>
		(((inv_VDMNat1 t)))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2.\<close>
		(t > (10::VDMNat1))"

		 

\<comment>\<open>VDM source: eq_TBasic2: (nat1 * nat1 +> bool)
	eq_TBasic2(t1, t2) ==
(t1 = t2)\<close>
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 16:9\<close>
definition
	eq_TBasic2 :: "TBasic2 \<Rightarrow> TBasic2 \<Rightarrow> bool"
where
	"eq_TBasic2 t1   t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TBasic2` specification.\<close>
		((inv_TBasic2 t1)  \<and>  (inv_TBasic2 t2))  \<and> 
		\<comment>\<open>User defined body of eq_TBasic2.\<close>
		(t1 = t2)"

		 

\<comment>\<open>VDM source: ord_TBasic2: (nat1 * nat1 +> bool)
	ord_TBasic2(t1, t2) ==
(t1 < t2)\<close>
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 17:9\<close>
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
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 17:9\<close>
definition
	min_TBasic2 :: "TBasic2 \<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"min_TBasic2 a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TBasic2` specification.\<close>
		(if ((inv_TBasic2 a)  \<and>  (inv_TBasic2 b)) then
			
		\<comment>\<open>User defined body of min_TBasic2.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TBasic2` call\<close>
	(ord_TBasic2 a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TBasic2` call\<close>
	(eq_TBasic2 a  b))) then
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
\<comment>\<open>in 'TestV2ITypes' (./src/test/resources/TestV2ITypes.vdmsl) at line 17:9\<close>
definition
	max_TBasic2 :: "TBasic2 \<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"max_TBasic2 a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TBasic2` specification.\<close>
		(if ((inv_TBasic2 a)  \<and>  (inv_TBasic2 b)) then
			
		\<comment>\<open>User defined body of max_TBasic2.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TBasic2` call\<close>
	(ord_TBasic2 a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TBasic2` call\<close>
	(eq_TBasic2 a  b))) then
		(b)
		else
		(a))
			else
			undefined)"

	
lemmas inv_TBasic2_defs = inv_TBasic2_def inv_VDMNat1_def 




end