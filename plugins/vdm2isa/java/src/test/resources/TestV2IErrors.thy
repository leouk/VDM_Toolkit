(* VDM to Isabelle Translation @2021-12-01T11:52:43.041004Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IErrors.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IErrors.vdmsl]
*)
theory TestV2IErrors
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 39:5\<close>

\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 39:5\<close>
definition
	pre_f1 :: "VDMInt \<Rightarrow> bool"
where
	"pre_f1 x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f1 specification\<close>
		((inv_VDMInt x))"


\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 39:5\<close>
definition
	post_f1 :: "VDMInt\<Rightarrow> U_ERROR | 
		 U_bool "bool" \<Rightarrow> bool"
where
	"post_f1 x  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f1 specification\<close>
		((inv_VDMInt x)  \<and>  (case RESULT of U_ERRORRESULT \<Rightarrow> (inv_True RESULT)
		  | U_bool RESULT \<Rightarrow> (inv_bool RESULT)
		 ))"

definition
	f1 :: "VDMInt \<Rightarrow> U_ERROR | 
		 U_bool "bool""
where
	"f1 x \<equiv> 
	\<comment>\<open>User defined body of f1\<close>
	(
		if ((x > 10)) then
		(U_ERROR )
		else
		(False))"

end