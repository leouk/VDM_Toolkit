(* VDM to Isabelle Translation @2021-12-13T14:24:18.313Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl' at line 39:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl]
*)
theory C
imports "A" "B" "VDMToolkit" 
begin


\<comment>\<open>VDM source: h: (nat -> nat)
	h(a) ==
(g(a) - v)\<close>
\<comment>\<open>in 'C' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 45:5\<close>

\<comment>\<open>VDM source: pre_h = ?\<close>
\<comment>\<open>in 'C' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 45:5\<close>
definition
	pre_h :: "VDMNat \<Rightarrow> bool"
where
	"pre_h a \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_h` specification.\<close>
		((inv_VDMNat a))"


\<comment>\<open>VDM source: post_h = ?\<close>
\<comment>\<open>in 'C' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 45:5\<close>
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

\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "h"

end