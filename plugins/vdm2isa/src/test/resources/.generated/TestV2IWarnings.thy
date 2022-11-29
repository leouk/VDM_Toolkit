(* VDM to Isabelle Translation @2021-12-13T14:25:22.552Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IWarnings.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IWarnings.vdmsl]
*)
theory TestV2IWarnings
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: v38:[?] = nil\<close>
\<comment>\<open>in 'TestV2IWarnings' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IWarnings.vdmsl) at line 8:5\<close>
abbreviation
	v38 :: "'UNKNOWN option"
where
	"v38 \<equiv> None"

	definition
	inv_v38 :: "\<bool>"
where
	"inv_v38  \<equiv> (inv_Option inv_True
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close> v38)"

	
	
\<comment>\<open>VDM source: v96: (() -> map (nat) to (nat))
	v96() ==
{x |-> 10 | x:nat & (x < 10)}\<close>
\<comment>\<open>in 'TestV2IWarnings' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IWarnings.vdmsl) at line 15:5\<close>

\<comment>\<open>VDM source: pre_v96 = ?\<close>
\<comment>\<open>in 'TestV2IWarnings' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IWarnings.vdmsl) at line 15:5\<close>
definition
	pre_v96 :: "bool"
where
	"pre_v96  \<equiv> True"


\<comment>\<open>VDM source: post_v96 = ?\<close>
\<comment>\<open>in 'TestV2IWarnings' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IWarnings.vdmsl) at line 15:5\<close>
definition
	post_v96 :: "(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> bool"
where
	"post_v96 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_v96` specification.\<close>
		((inv_Map (inv_VDMNat) (inv_VDMNat) RESULT))"

definition
	v96 :: "(VDMNat \<rightharpoonup> VDMNat)"
where
	"v96  \<equiv> 
	\<comment>\<open>User defined body of v96.\<close>
	(\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompTypeBound\<close>
		mapCompTypeBound 
		{ x .   \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (((inv_VDMNat x)))  \<and> (x < (10::VDMNat1)) } 
		{ (10::VDMNat1) | (x :: VDMNat) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (((inv_VDMNat x)))  \<and> (x < (10::VDMNat1)) } 
		(inv_VDMNat) 
		(inv_VDMNat1) 
		(domid ) 
		(rngcnst (10::VDMNat1)) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat)  (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat dummy0DOMAIN))) \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x < (10::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x < (10::VDMNat1))))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))"

end