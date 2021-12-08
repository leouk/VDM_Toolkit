(* VDM to Isabelle Translation @2021-12-08T09:03:19.081455Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IModules.vdmsl' at line 13:8
files = [./src/test/resources/TestV2IModules.vdmsl]
*)
theory B
imports VDMToolkit
begin


\<comment>\<open>in 'B' (./src/test/resources/TestV2IModules.vdmsl) at line 19:5\<close>

\<comment>\<open>in 'B' (./src/test/resources/TestV2IModules.vdmsl) at line 19:5\<close>
definition
	pre_F :: "VDMNat \<Rightarrow> bool"
where
	"pre_F a \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_F specification\<close>
		((inv_VDMNat a))"


\<comment>\<open>in 'B' (./src/test/resources/TestV2IModules.vdmsl) at line 19:5\<close>
definition
	post_F :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_F a  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_F specification\<close>
		((inv_VDMNat a)  \<and>  (inv_VDMNat RESULT))"

definition
	F :: "VDMNat \<Rightarrow> VDMNat"
where
	"F a \<equiv> 
	\<comment>\<open>User defined body of F\<close>
	a"

	
\<comment>\<open>in 'B' (./src/test/resources/TestV2IModules.vdmsl) at line 22:5\<close>

\<comment>\<open>in 'B' (./src/test/resources/TestV2IModules.vdmsl) at line 22:5\<close>
definition
	pre_g :: "VDMNat \<Rightarrow> bool"
where
	"pre_g a \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_g specification\<close>
		((inv_VDMNat a))"


\<comment>\<open>in 'B' (./src/test/resources/TestV2IModules.vdmsl) at line 22:5\<close>
definition
	post_g :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_g a  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_g specification\<close>
		((inv_VDMNat a)  \<and>  (inv_VDMNat RESULT))"

definition
	g :: "VDMNat \<Rightarrow> VDMNat"
where
	"g a \<equiv> 
	\<comment>\<open>User defined body of g\<close>
	((F a) - (1::VDMNat1))"

end