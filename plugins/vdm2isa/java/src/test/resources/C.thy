(* VDM to Isabelle Translation @2021-12-11T13:29:54.849905Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IModules.vdmsl' at line 34:8
files = [./src/test/resources/TestV2IModules.vdmsl]
*)
theory C
imports "A" "B" "VDMToolkit" 
begin


\<comment>\<open>VDM source: h: (nat -> nat)
	h(a) ==
(g(a) - v)\<close>
\<comment>\<open>in 'C' (./src/test/resources/TestV2IModules.vdmsl) at line 41:5\<close>

\<comment>\<open>VDM source: pre_h = ?\<close>
\<comment>\<open>in 'C' (./src/test/resources/TestV2IModules.vdmsl) at line 41:5\<close>
definition
	pre_h :: "VDMNat \<Rightarrow> bool"
where
	"pre_h a \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_h` specification.\<close>
		((inv_VDMNat a))"


\<comment>\<open>VDM source: post_h = ?\<close>
\<comment>\<open>in 'C' (./src/test/resources/TestV2IModules.vdmsl) at line 41:5\<close>
definition
	post_h :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_h a  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_h` specification.\<close>
		((inv_VDMNat a)  \<and>  (inv_VDMNat RESULT))"

definition
	h :: "VDMNat \<Rightarrow> VDMNat"
where
	"h a \<equiv> 
	\<comment>\<open>User defined body of h.\<close>
	((B.g a) - A.v)"

end