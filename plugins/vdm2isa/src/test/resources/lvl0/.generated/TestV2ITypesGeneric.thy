(* VDM to Isabelle Translation @2022-12-27T13:26:51.057Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesGeneric
   in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl' at line 1:8
   files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl]
*)
theory TestV2ITypesGeneric
imports VDMToolkit 
begin

\<comment>\<open>VDM source: injective[T]: (seq of (@T) +> bool)
	injective(ss) ==
((card (elems ss)) = (len ss))\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 5:5\<close>
\<comment>\<open>VDM source: pre_injective[T]: (seq of (@T) +> bool)
	pre_injective(ss) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 5:5\<close>
definition
	pre_injective :: \<open>('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool\<close>
where
	\<open>pre_injective inv_T   ss \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_injective` specification.\<close>
		((inv_VDMSeq' inv_T ss))\<close>

\<comment>\<open>VDM source: post_injective[T]: (seq of (@T) * bool +> bool)
	post_injective(ss, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 5:5\<close>
definition
	post_injective :: \<open>('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool \<Rightarrow> bool\<close>
where
	\<open>post_injective inv_T   ss   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_injective` specification.\<close>
		((inv_VDMSeq' inv_T ss)  \<and>  (inv_bool RESULT))\<close>

definition
	injective :: \<open>('T \<Rightarrow> bool) \<Rightarrow> 'T VDMSeq \<Rightarrow> bool\<close>
where
	\<open>injective inv_T   ss \<equiv> (if (pre_injective inv_T   ss) then
		 
	\<comment>\<open>User defined body of injective.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `injective`.\<close>
	(if post_injective inv_T   ss (((vdm_card (elems ss)) = (len ss))) then	((vdm_card (elems ss)) = (len ss)) else	undefined) 
	else undefined)\<close>


\<comment>\<open>VDM source: f[S, T]: (seq of (@S) -> seq of (@T))
	f(s) ==
[]\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>
\<comment>\<open>VDM source: pre_f[S, T]: (seq of (@S) +> bool)
	pre_f(s) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>
definition
	pre_f :: \<open>('S \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> bool\<close>
where
	\<open>pre_f inv_S   s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMSeq' inv_S s))\<close>

\<comment>\<open>VDM source: post_f[S, T]: (seq of (@S) * seq of (@T) +> bool)
	post_f(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 13:5\<close>
definition
	post_f :: \<open>('S \<Rightarrow> bool) \<Rightarrow> ('T \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> 'T VDMSeq \<Rightarrow> bool\<close>
where
	\<open>post_f inv_S   inv_T   s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMSeq' inv_S s)  \<and>  (inv_VDMSeq' inv_T RESULT))\<close>

definition
	f :: \<open>('S \<Rightarrow> bool) \<Rightarrow> ('T \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> 'T VDMSeq\<close>
where
	\<open>f inv_S   inv_T   s \<equiv> (if (pre_f inv_S   inv_T   s) then
		 
	\<comment>\<open>User defined body of f.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `f`.\<close>
	(if post_f inv_S   inv_T   s ([]) then	[] else	undefined) 
	else undefined)\<close>


\<comment>\<open>VDM source: g[S]: (seq of (@S) -> seq of (@S))
	g(s) ==
(f)[@S, @S](s)\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 17:5\<close>
\<comment>\<open>VDM source: pre_g[S]: (seq of (@S) +> bool)
	pre_g(s) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 17:5\<close>
definition
	pre_g :: \<open>('S \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> bool\<close>
where
	\<open>pre_g inv_S   s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g` specification.\<close>
		((inv_VDMSeq' inv_S s))\<close>

\<comment>\<open>VDM source: post_g[S]: (seq of (@S) * seq of (@S) +> bool)
	post_g(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 17:5\<close>
definition
	post_g :: \<open>('S \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> 'S VDMSeq \<Rightarrow> bool\<close>
where
	\<open>post_g inv_S   s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g` specification.\<close>
		((inv_VDMSeq' inv_S s)  \<and>  (inv_VDMSeq' inv_S RESULT))\<close>

definition
	g :: \<open>('S \<Rightarrow> bool) \<Rightarrow> 'S VDMSeq \<Rightarrow> 'S VDMSeq\<close>
where
	\<open>g inv_S   s \<equiv> (if (pre_g inv_S   s) then
		 
	\<comment>\<open>User defined body of g.\<close>
	\<comment>\<open>Implicit check on generic type invariant for `g`.\<close>
	(if post_g inv_S   s ((f inv_S  inv_S  s)) then	(f inv_S  inv_S  s) else	undefined) 
	else undefined)\<close>


\<comment>\<open>VDM source: h: (seq of (nat) -> seq of (int))
	h(s) ==
(f)[nat, int](s)\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 21:5\<close>
\<comment>\<open>VDM source: pre_h: (seq of (nat) +> bool)
	pre_h(s) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 21:5\<close>
definition
	pre_h :: \<open>VDMNat VDMSeq \<Rightarrow> bool\<close>
where
	\<open>pre_h s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_h` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s))\<close>

\<comment>\<open>VDM source: post_h: (seq of (nat) * seq of (int) +> bool)
	post_h(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesGeneric' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesGeneric.vdmsl) at line 21:5\<close>
definition
	post_h :: \<open>VDMNat VDMSeq \<Rightarrow> VDMInt VDMSeq \<Rightarrow> bool\<close>
where
	\<open>post_h s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_h` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s)  \<and>  (inv_VDMSeq' (inv_VDMInt) RESULT))\<close>

definition
	h :: \<open>VDMNat VDMSeq \<Rightarrow> VDMInt VDMSeq\<close>
where
	\<open>h s \<equiv> (if (pre_h s) then
		 
	\<comment>\<open>User defined body of h.\<close>
	(f (inv_VDMNat)  (inv_VDMInt)  s) 
	else undefined)\<close>

 

end 