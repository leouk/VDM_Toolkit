(* VDM to Isabelle Translation @2021-12-02T09:40:51.812Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IErrors.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IErrors.vdmsl]
*)
theory TestV2IErrors
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IErrors' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IErrors.vdmsl) at line 7:5\<close>
type_synonym T = "VDMNat VDMSet"
	

\<comment>\<open>in 'TestV2IErrors' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IErrors.vdmsl) at line 8:9\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T {a,  b,  c} \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_T specification\<close>
		(((inv_VDMSet' (inv_VDMNat) {a,  b,  c})))  \<and> 
		\<comment>\<open>User defined body of inv_T\<close>
		((a < b) \<and> (b < c))"

		 

end