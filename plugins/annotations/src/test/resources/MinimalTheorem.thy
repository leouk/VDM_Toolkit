(* VDM to Isabelle Translation @2022-03-11T08:19:20.803Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl]
*)
theory MinimalTheorem
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: T = nat
	inv t == (t > 10)\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 13:5\<close>
type_synonym T = "VDMNat"
	

\<comment>\<open>VDM source: inv_T: (nat +> bool)
	inv_T(t) ==
(t > 10)\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 14:9\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_T` specification.\<close>
		(((inv_VDMNat t)))  \<and> 
		\<comment>\<open>User defined body of inv_T.\<close>
		(t > (10::VDMNat1))"

		 
lemmas inv_T_defs = inv_T_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: f: (nat * nat1 -> nat1)
	f(x, y) ==
(x + y)\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 20:5\<close>

\<comment>\<open>VDM source: pre_f: (nat * nat1 +> bool)
	pre_f(x, y) ==
null\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 20:5\<close>
definition
	pre_f :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_f x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))"


\<comment>\<open>VDM source: post_f: (nat * nat1 * nat1 +> bool)
	post_f(x, y, RESULT) ==
null\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 20:5\<close>
definition
	post_f :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"post_f x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat1 RESULT))"

definition
	f :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"f x   y \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	(x + y)"



end