(* VDM to Isabelle Translation @2021-12-23T14:35:16.338Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl]
*)
theory TestV2ITypesGeneric
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: injective[T]: (seq of (@T) +> bool)
	injective(ss) ==
((card (elems ss)) = (len ss))\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 5:5\<close>

\<comment>\<open>VDM source: pre_injective[T]: (seq of (@T) +> bool)
	pre_injective(ss) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 5:5\<close>
definition
	pre_injective :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"pre_injective inv_T   ss \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_injective` specification.\<close>
		((inv_VDMSeq' inv_T ss))"


\<comment>\<open>VDM source: post_injective[T]: (seq of (@T) * bool +> bool)
	post_injective(ss, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 5:5\<close>
definition
	post_injective :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_injective inv_T   ss   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_injective` specification.\<close>
		((inv_VDMSeq' inv_T ss)  \<and>  (inv_bool RESULT))"

definition
	injective :: "('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"injective inv_T   ss \<equiv> 
	\<comment>\<open>User defined body of injective.\<close>
	
	\<comment>\<open>Implicit check on generic type invariant for `injective`.\<close>
	(if post_injective inv_T   ss (((vdm_card (elems ss)) = (len ss))) then	((vdm_card (elems ss)) = (len ss)) else	undefined)"

	
	
\<comment>\<open>VDM source: f[S, T]: (seq of (@S) -> seq of (@T))
	f(s) ==
[]\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>

\<comment>\<open>VDM source: pre_f[S, T]: (seq of (@S) +> bool)
	pre_f(s) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>
definition
	pre_f :: "('S \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> bool"
where
	"pre_f inv_S   s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMSeq' inv_S s))"


\<comment>\<open>VDM source: post_f[S, T]: (seq of (@S) * seq of (@T) +> bool)
	post_f(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>
definition
	post_f :: "('S \<Rightarrow> bool) \<Rightarrow> ('T \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"post_f inv_S   inv_T   s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMSeq' inv_S s)  \<and>  (inv_VDMSeq' inv_T RESULT))"

definition
	f :: "('S \<Rightarrow> bool) \<Rightarrow> ('T \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> 'T VDMSeq"
where
	"f inv_S   inv_T   s \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	
	\<comment>\<open>Implicit check on generic type invariant for `f`.\<close>
	(if post_f inv_S   inv_T   s ([]) then	[] else	undefined)"

end