(* VDM to Isabelle Translation @2021-12-11T13:29:54.840960Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IModules.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IModules.vdmsl]
*)
theory A
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: v:nat = 10\<close>
\<comment>\<open>in 'A' (./src/test/resources/TestV2IModules.vdmsl) at line 8:5\<close>
abbreviation
	v :: "VDMNat"
where
	"v \<equiv> (10::VDMNat1)"

	definition
	inv_v :: "\<bool>"
where
	"inv_v  \<equiv> (inv_VDMNat v)"

	
	
\<comment>\<open>VDM source: f: (nat -> nat)
	f(a) ==
(a + 1)\<close>
\<comment>\<open>in 'A' (./src/test/resources/TestV2IModules.vdmsl) at line 11:5\<close>

\<comment>\<open>VDM source: pre_f = ?\<close>
\<comment>\<open>in 'A' (./src/test/resources/TestV2IModules.vdmsl) at line 11:5\<close>
definition
	pre_f :: "VDMNat \<Rightarrow> bool"
where
	"pre_f a \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMNat a))"


\<comment>\<open>VDM source: post_f = ?\<close>
\<comment>\<open>in 'A' (./src/test/resources/TestV2IModules.vdmsl) at line 11:5\<close>
definition
	post_f :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_f a  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMNat a)  \<and>  (inv_VDMNat RESULT))"

definition
	f :: "VDMNat \<Rightarrow> VDMNat"
where
	"f a \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	(a + (1::VDMNat1))"

end