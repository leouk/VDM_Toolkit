(* VDM to Isabelle Translation @2021-12-23T11:10:32.380Z
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
	pre_injective :: "('T \<Rightarrow> bool)\<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"pre_injective ss \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_injective` specification.\<close>
		((inv_Lambda  \<comment>\<open>VDM generic type `T` will become an Isabelle type parameter. Specific instantiations require invariant checking function\<close> inv_T (inv_bool)ss))"


\<comment>\<open>VDM source: post_injective[T]: (seq of (@T) * bool +> bool)
	post_injective(ss, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 5:5\<close>
definition
	post_injective :: "('T \<Rightarrow> bool)\<Rightarrow> 'T VDMSeq\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_injective ss  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_injective` specification.\<close>
		((inv_Lambda  \<comment>\<open>VDM generic type `T` will become an Isabelle type parameter. Specific instantiations require invariant checking function\<close> inv_T (inv_bool)ss)  \<and>  (inv_VDMSeq' 
	\<comment>\<open>VDM generic type `T` will become an Isabelle type parameter. Specific instantiations require invariant checking function\<close>
	inv_T RESULT))"

definition
	injective :: "('T \<Rightarrow> bool)\<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"injective ss \<equiv> 
	\<comment>\<open>User defined body of injective.\<close>
	((vdm_card (elems ss)) = (len ss))"

	
\<comment>\<open>VDM source: f[S, T]: (seq of (@S) -> seq of (@T))
	f(s) ==
[]\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>

\<comment>\<open>VDM source: pre_f[S, T]: (seq of (@S) +> bool)
	pre_f(s) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>
definition
	pre_f :: "('S \<Rightarrow> bool)\<Rightarrow> 'S VDMSeq \<Rightarrow> bool"
where
	"pre_f s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_Lambda  \<comment>\<open>VDM generic type `S` will become an Isabelle type parameter. Specific instantiations require invariant checking function\<close> inv_S (inv_bool)s))"


\<comment>\<open>VDM source: post_f[S, T]: (seq of (@S) * seq of (@T) +> bool)
	post_f(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>
definition
	post_f :: "('S \<Rightarrow> bool)\<Rightarrow> 'S VDMSeq\<Rightarrow> ('T \<Rightarrow> bool)\<Rightarrow> 'T VDMSeq \<Rightarrow> bool"
where
	"post_f inv_S s inv_T RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_Lambda  \<comment>\<open>VDM generic type `S` will become an Isabelle type parameter. Specific instantiations require invariant checking function\<close> inv_S (inv_bool)s)  \<and>  (inv_VDMSeq' 
	\<comment>\<open>VDM generic type `S` will become an Isabelle type parameter. Specific instantiations require invariant checking function\<close>
	inv_S RESULT))"

definition
	f :: "('S \<Rightarrow> bool)\<Rightarrow> 'S VDMSeq\<Rightarrow> ('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq"
where
	"f inv_S s inv_T \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	[]"

end