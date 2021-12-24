(* VDM to Isabelle Translation @2021-12-24T09:58:13.767Z
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

	
	
\<comment>\<open>VDM source: g[S]: (seq of (@S) -> seq of (@S))
	g(s) ==
(f)[@S, @S](s)\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 17:5\<close>

\<comment>\<open>VDM source: pre_g[S]: (seq of (@S) +> bool)
	pre_g(s) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 17:5\<close>
definition
	pre_g :: "('S \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> bool"
where
	"pre_g inv_S   s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g` specification.\<close>
		((inv_VDMSeq' inv_S s))"


\<comment>\<open>VDM source: post_g[S]: (seq of (@S) * seq of (@S) +> bool)
	post_g(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 17:5\<close>
definition
	post_g :: "('S \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> 'S VDMSeq \<Rightarrow> bool"
where
	"post_g inv_S   s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g` specification.\<close>
		((inv_VDMSeq' inv_S s)  \<and>  (inv_VDMSeq' inv_S RESULT))"

definition
	g :: "('S \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> 'S VDMSeq"
where
	"g inv_S   s \<equiv> 
	\<comment>\<open>User defined body of g.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `g`.\<close>
	(if post_g inv_S   s ((f inv_S   inv_S   s)) then	(f inv_S   inv_S   s) else	undefined)"

	
	
\<comment>\<open>VDM source: h: (seq of (nat) -> seq of (int))
	h(s) ==
(f)[nat, int](s)\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 21:5\<close>

\<comment>\<open>VDM source: pre_h: (seq of (nat) +> bool)
	pre_h(s) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 21:5\<close>
definition
	pre_h :: "VDMNat VDMSeq \<Rightarrow> bool"
where
	"pre_h s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_h` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s))"


\<comment>\<open>VDM source: post_h: (seq of (nat) * seq of (int) +> bool)
	post_h(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2ITypesGeneric.vdmsl) at line 21:5\<close>
definition
	post_h :: "VDMNat VDMSeq \<Rightarrow> VDMInt VDMSeq \<Rightarrow> bool"
where
	"post_h s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_h` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s)  \<and>  (inv_VDMSeq' (inv_VDMInt) RESULT))"

definition
	h :: "VDMNat VDMSeq \<Rightarrow> VDMInt VDMSeq"
where
	"h s \<equiv> 
	\<comment>\<open>User defined body of h.\<close>
	(f (inv_VDMNat)   (inv_VDMInt)   s)"

end