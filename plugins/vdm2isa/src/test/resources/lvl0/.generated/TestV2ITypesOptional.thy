(* VDM to Isabelle Translation @2022-12-27T13:26:51.071Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesOptional
   in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOptional.vdmsl' at line 1:8
   files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOptional.vdmsl]
*)
theory TestV2ITypesOptional
imports VDMToolkit 
begin

\<comment>\<open>VDM source: TOptional = [nat1]
	inv o1 == ((o1 <> nil) => (o1 > 10))\<close>
\<comment>\<open>in 'TestV2ITypesOptional' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOptional.vdmsl) at line 6:5\<close>
type_synonym TOptional = \<open>VDMNat1 option\<close>
	
\<comment>\<open>VDM source: inv_TOptional: ([nat1] +> bool)
	inv_TOptional(o1) ==
((o1 <> nil) => (o1 > 10))\<close>
\<comment>\<open>in 'TestV2ITypesOptional' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOptional.vdmsl) at line 7:25\<close>
definition
	inv_TOptional :: \<open>TOptional \<Rightarrow> bool\<close>
where
	\<open>inv_TOptional o1 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TOptional` specification.\<close>
		(((inv_Option (inv_VDMNat1) o1)))  \<and> 
		\<comment>\<open>User defined body of inv_TOptional.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		(case o1 of
			o1 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
	((o1 \<noteq> None) \<longrightarrow> (o1 > (10::VDMNat1)))
	 | o1 \<Rightarrow> \<comment>\<open>Type coercions might needed at body or union selection deletion might be needed\<close>
	((o1 \<noteq> None) \<longrightarrow> (o1 > (10::VDMNat1)))
	))\<close>

		 
lemmas inv_TOptional_defs = inv_Option_def inv_TOptional_def inv_VDMNat1_def 


 

end 