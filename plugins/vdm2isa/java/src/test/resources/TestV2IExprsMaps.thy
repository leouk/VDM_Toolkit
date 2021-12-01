(* VDM to Isabelle Translation @2021-12-01T15:26:51.242596Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsMaps.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsMaps.vdmsl]
*)
theory TestV2IExprsMaps
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 7:5\<close>
record R = 
	x\<^sub>R :: "VDMNat"
		 y\<^sub>R :: "VDMNat"
	

\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 10:9\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_R specification\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R\<close>
		((x\<^sub>R (r)) < (y\<^sub>R (r)))"

		

	
abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

	definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"

	
	
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R v65"

	
	
abbreviation
	v95 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v95 \<equiv> "

	definition
	inv_v95 :: "\<bool>"
where
	"inv_v95  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v95)"

	
	
abbreviation
	v952 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v952 \<equiv> "

	definition
	inv_v952 :: "\<bool>"
where
	"inv_v952  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v952)"

	
	
abbreviation
	v953 :: "(R \<rightharpoonup> VDMNat1)"
where
	"v953 \<equiv> "

	definition
	inv_v953 :: "\<bool>"
where
	"inv_v953  \<equiv> (inv_Map inv_R  (inv_VDMNat1) v953)"

	
	
abbreviation
	v954 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v954 \<equiv> "

	definition
	inv_v954 :: "\<bool>"
where
	"inv_v954  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v954)"

	
	
abbreviation
	v97 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v97 \<equiv> "

	definition
	inv_v97 :: "\<bool>"
where
	"inv_v97  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v97)"

	
	
abbreviation
	v98 :: "(VDMNat \<rightharpoonup> VDMNat1)"
where
	"v98 \<equiv> "

	definition
	inv_v98 :: "\<bool>"
where
	"inv_v98  \<equiv> (inv_Map (inv_VDMNat) (inv_VDMNat1) v98)"

	
	
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 24:5\<close>

\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 24:5\<close>
definition
	pre_v96 :: "bool"
where
	"pre_v96  \<equiv> True"


\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 24:5\<close>
definition
	post_v96 :: "(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> bool"
where
	"post_v96 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_v96 specification\<close>
		((inv_Map (inv_VDMNat) (inv_VDMNat) RESULT))"

definition
	v96 :: "(VDMNat \<rightharpoonup> VDMNat)"
where
	"v96  \<equiv> 
	\<comment>\<open>User defined body of v96\<close>
	"

	
\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 27:5\<close>

\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 27:5\<close>
definition
	pre_v961 :: "bool"
where
	"pre_v961  \<equiv> True"


\<comment>\<open>in 'TestV2IExprsMaps' (./src/test/resources/TestV2IExprsMaps.vdmsl) at line 27:5\<close>
definition
	post_v961 :: "(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> bool"
where
	"post_v961 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_v961 specification\<close>
		((inv_Map (inv_VDMNat) (inv_VDMNat) RESULT))"

definition
	v961 :: "(VDMNat \<rightharpoonup> VDMNat)"
where
	"v961  \<equiv> 
	\<comment>\<open>User defined body of v961\<close>
	"

end