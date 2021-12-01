(* VDM to Isabelle Translation @2021-12-01T12:02:34.148434Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IErrors.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IErrors.vdmsl]
*)
theory TestV2IErrors
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 44:5\<close>

\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 44:5\<close>
definition
	pre_f1 :: "VDMInt \<Rightarrow> bool"
where
	"pre_f1 x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f1 specification\<close>
		((inv_VDMInt x))"


\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 44:5\<close>
definition
	post_f1 :: "VDMInt\<Rightarrow> U_ERROR  \<Rightarrow> bool"
where
	"post_f1 x  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f1 specification\<close>
		((inv_VDMInt x)  \<and>  (inv_True RESULT))"

definition
	f1 :: "VDMInt \<Rightarrow> U_ERROR "
where
	"f1 x \<equiv> 
	\<comment>\<open>User defined body of f1\<close>
	U_ERROR "

end