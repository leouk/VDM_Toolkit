(* VDM to Isabelle Translation @2021-12-01T15:26:51.260679Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesOptional.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesOptional.vdmsl]
*)
theory TestV2ITypesOptional
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesOptional' (./src/test/resources/TestV2ITypesOptional.vdmsl) at line 6:5\<close>
type_synonym TOptional = "VDMNat1 option"
	

\<comment>\<open>in 'TestV2ITypesOptional' (./src/test/resources/TestV2ITypesOptional.vdmsl) at line 7:9\<close>
definition
	inv_TOptional :: "TOptional \<Rightarrow> bool"
where
	"inv_TOptional o1 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TOptional specification\<close>
		(((inv_Option (inv_VDMNat1) o1)))  \<and> 
		\<comment>\<open>User defined body of inv_TOptional\<close>
		(
		\<comment>\<open>Implicit union type parameters projection conversion\<close>
		(case o1 of
			o1 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
	((\<comment>\<open>Optional type variable `o1` might not need extra @{term the} operator!\<close>(the(o1)) \<noteq> None) \<longrightarrow> (\<comment>\<open>Optional type variable `o1` might not need extra @{term the} operator!\<close>(the(o1)) > (10::VDMNat1)))
	 | o1 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
	((\<comment>\<open>Optional type variable `o1` might not need extra @{term the} operator!\<close>(the(o1)) \<noteq> None) \<longrightarrow> (\<comment>\<open>Optional type variable `o1` might not need extra @{term the} operator!\<close>(the(o1)) > (10::VDMNat1)))
	))"

		 

end