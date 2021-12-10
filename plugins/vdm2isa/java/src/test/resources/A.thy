(* VDM to Isabelle Translation @2021-12-08T09:03:19.065793Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IModules.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IModules.vdmsl]
*)
theory A
imports VDMToolkit
begin


\<comment>\<open>in 'A' (./src/test/resources/TestV2IModules.vdmsl) at line 6:5\<close>

\<comment>\<open>in 'A' (./src/test/resources/TestV2IModules.vdmsl) at line 6:5\<close>
definition
	pre_f :: "VDMNat \<Rightarrow> bool"
where
	"pre_f a \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f specification\<close>
		((inv_VDMNat a))"


\<comment>\<open>in 'A' (./src/test/resources/TestV2IModules.vdmsl) at line 6:5\<close>
definition
	post_f :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_f a  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f specification\<close>
		((inv_VDMNat a)  \<and>  (inv_VDMNat RESULT))"

definition
	f :: "VDMNat \<Rightarrow> VDMNat"
where
	"f a \<equiv> 
	\<comment>\<open>User defined body of f\<close>
	(a + (1::VDMNat1))"

end