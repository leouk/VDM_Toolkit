(* VDM to Isabelle Translation @2021-11-28T06:54:35.710309Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IErrors.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IErrors.vdmsl]
*)
theory TestV2IErrors
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 7:5\<close>
record S = 
	
	

\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 7:5\<close>
definition
	inv_S :: "S \<Rightarrow> \<bool>"
where
	"inv_S dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_S specification\<close>
		( ( ))"

		

	
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 9:5\<close>
record R = 
	x\<^sub>R :: "VDMNat"
		 y\<^sub>R :: "VDMNat"
	

\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 12:9\<close>
definition
	inv_R :: "R \<Rightarrow> \<bool>"
where
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_R specification\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R\<close>
		((x\<^sub>R (r)) < (y\<^sub>R (r)))"

		

	
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 15:5\<close>
type_synonym TUnion = "U_VDMReal "VDMReal" VDMSet"
	

\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 15:5\<close>
definition
	inv_TUnion :: "TUnion \<Rightarrow> \<bool>"
where
	"inv_TUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TUnion specification\<close>
		(((inv_VDMSet' () dummy0)))"

		 

	
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 17:5\<close>
datatype TInnerUnion = U_VDMReal "VDMReal"
	

\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 17:5\<close>
definition
	inv_TInnerUnion :: "TInnerUnion \<Rightarrow> \<bool>"
where
	"inv_TInnerUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TInnerUnion specification\<close>
		(((case dummy0 of
		 TInnerUnion.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 18:5\<close>
type_synonym TInnerUnion' = "TInnerUnion VDMSet"
	

\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 18:5\<close>
definition
	inv_TInnerUnion' :: "TInnerUnion' \<Rightarrow> \<bool>"
where
	"inv_TInnerUnion' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TInnerUnion' specification\<close>
		(((inv_VDMSet' (inv_TInnerUnion) dummy0)))"

		 

	
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 22:5\<close>

\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 22:5\<close>
definition
	pre_vc33 :: "\<bool>"
where
	"pre_vc33  \<equiv> True"


\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 22:5\<close>
definition
	post_vc33 :: "VDMNat VDMSeq \<Rightarrow> \<bool>"
where
	"post_vc33 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc33 specification\<close>
		((inv_VDMSeq' (inv_VDMNat) RESULT))"

definition
	vc33 :: "VDMNat VDMSeq"
where
	"vc33  \<equiv> 
	\<comment>\<open>User defined body of vc33\<close>
	[ x . \<comment>\<open>Type bound sequence compression is not supported in Isabelle.\<close>  (((inv_VDMNat x))) , (x > (10::VDMNat1)) ]"

	
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R v65"

	
	
abbreviation
	v830 :: "VDMNat VDMSeq"
where
	"v830 \<equiv> [ (let x = (x\<^sub>R dummy0); _ = (y\<^sub>R dummy0) in x) . dummy0 \<leftarrow> sorted_list_of_set ({v65}) , ((dummy0 \<in>{v65})) , (let x = (x\<^sub>R dummy0); _ = (y\<^sub>R dummy0) in ((0::VDMNat) < x)) ]
	\<comment>\<open>Set bind `(dummy0 \<in> {v65})` in sequence comprehension requires its Isabelle type to instantiate class linorder.  This can be a problem if the target type of @{term \<open>{v65}\<close>}  has a VDM ord_ predicate.\<close> "

	definition
	inv_v830 :: "\<bool>"
where
	"inv_v830  \<equiv> (inv_VDMSeq' (inv_VDMNat) v830)"

	
end