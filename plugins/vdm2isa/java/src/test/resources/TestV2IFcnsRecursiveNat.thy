(* VDM to Isabelle Translation @2021-12-22T09:01:33.114Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcnsRecursiveNat.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcnsRecursiveNat.vdmsl]
*)
theory TestV2IFcnsRecursiveNat
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: g: (nat -> nat)
	g(x) ==
(if (x = 0)
then 10
else (g((x - 1)) + x))
	measure x\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcnsRecursiveNat.vdmsl) at line 6:5\<close>

\<comment>\<open>VDM source: pre_g: (nat +> bool)
	pre_g(x) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcnsRecursiveNat.vdmsl) at line 6:5\<close>
definition
	pre_g :: "VDMNat \<Rightarrow> bool"
where
	"pre_g x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g` specification.\<close>
		((inv_VDMNat x))"


\<comment>\<open>VDM source: post_g: (nat * nat +> bool)
	post_g(x, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcnsRecursiveNat.vdmsl) at line 6:5\<close>
definition
	post_g :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_g x  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))"

fun
	g :: "VDMNat \<Rightarrow> VDMNat"
where
	"g x = 
	\<comment>\<open>User defined body of g.\<close>
	(
		if ((x = (0::VDMNat))) then
		((10::VDMNat1))
		else
		(((g (x - (1::VDMNat1))) + x)))"

	
\<comment>\<open>VDM source: g': (seq of (nat) -> nat)
	g'(x) ==
(if (x = [])
then 0
else ((hd x) + g'((tl x))))
	measure (len x)\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcnsRecursiveNat.vdmsl) at line 10:5\<close>

\<comment>\<open>VDM source: pre_g': (seq of (nat) +> bool)
	pre_g'(x) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcnsRecursiveNat.vdmsl) at line 10:5\<close>
definition
	pre_g' :: "VDMNat VDMSeq \<Rightarrow> bool"
where
	"pre_g' x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g'` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) x))"


\<comment>\<open>VDM source: post_g': (seq of (nat) * nat +> bool)
	post_g'(x, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcnsRecursiveNat.vdmsl) at line 10:5\<close>
definition
	post_g' :: "VDMNat VDMSeq\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_g' x  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g'` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) x)  \<and>  (inv_VDMNat RESULT))"

fun
	g' :: "VDMNat VDMSeq \<Rightarrow> VDMNat"
where
	"g' x = 
	\<comment>\<open>User defined body of g'.\<close>
	(
		if ((x = [])) then
		((0::VDMNat))
		else
		(((hd x) + (g' (tl x)))))"

end