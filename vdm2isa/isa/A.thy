(* VDM to Isabelle Translation @2021-12-13T14:25:22.354Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl]
*)
theory A
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: v:nat = 10\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 9:5\<close>
abbreviation
	v :: "VDMNat"
where
	"v \<equiv> (10::VDMNat1)"

	definition
	inv_v :: "\<bool>"
where
	"inv_v  \<equiv> (inv_VDMNat v)"

	
	
\<comment>\<open>VDM source: p:nat = 10\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 10:5\<close>
abbreviation
	p :: "VDMNat"
where
	"p \<equiv> (10::VDMNat1)"

	definition
	inv_p :: "\<bool>"
where
	"inv_p  \<equiv> (inv_VDMNat p)"

	
	
\<comment>\<open>VDM source: T = nat
	inv t == (t > v)\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 12:5\<close>
type_synonym T = "VDMNat"
	

\<comment>\<open>VDM source: inv_T: (nat +> bool)
	inv_T(t) ==
(t > v)\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 12:17\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_T` specification.\<close>
		(((inv_VDMNat t)))  \<and> 
		\<comment>\<open>User defined body of inv_T.\<close>
		(t > v)"

		 

	
\<comment>\<open>VDM source: S = nat
	inv s == (s < v)\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 13:5\<close>
type_synonym S = "VDMNat"
	

\<comment>\<open>VDM source: inv_S: (nat +> bool)
	inv_S(s) ==
(s < v)\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 13:17\<close>
definition
	inv_S :: "S \<Rightarrow> bool"
where
	"inv_S s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_S` specification.\<close>
		(((inv_VDMNat s)))  \<and> 
		\<comment>\<open>User defined body of inv_S.\<close>
		(s < v)"

		 

	
\<comment>\<open>VDM source: Q = nat
	inv q == (q > 0)\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 14:5\<close>
type_synonym Q = "VDMNat"
	

\<comment>\<open>VDM source: inv_Q: (nat +> bool)
	inv_Q(q) ==
(q > 0)\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 14:17\<close>
definition
	inv_Q :: "Q \<Rightarrow> bool"
where
	"inv_Q q \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Q` specification.\<close>
		(((inv_VDMNat q)))  \<and> 
		\<comment>\<open>User defined body of inv_Q.\<close>
		(q > (0::VDMNat))"

		 

	
\<comment>\<open>VDM source: f: (nat -> nat)
	f(a) ==
(a + 1)\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 16:5\<close>

\<comment>\<open>VDM source: pre_f = ?\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 16:5\<close>
definition
	pre_f :: "VDMNat \<Rightarrow> bool"
where
	"pre_f a \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMNat a))"


\<comment>\<open>VDM source: post_f = ?\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 16:5\<close>
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

	
\<comment>\<open>VDM source: h: (nat -> nat)
	h(a) ==
a\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 21:5\<close>

\<comment>\<open>VDM source: pre_h = ?\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 21:5\<close>
definition
	pre_h :: "VDMNat \<Rightarrow> bool"
where
	"pre_h a \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_h` specification.\<close>
		((inv_VDMNat a))"


\<comment>\<open>VDM source: post_h = ?\<close>
\<comment>\<open>in 'A' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IModules.vdmsl) at line 21:5\<close>
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
	a"

\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "p"
hide_type "Q"
hide_const "h"
hide_const "inv_T"
hide_const "inv_S"
hide_const "inv_Q"

end