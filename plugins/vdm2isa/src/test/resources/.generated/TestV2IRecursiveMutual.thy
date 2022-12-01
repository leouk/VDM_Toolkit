(* VDM to Isabelle Translation @2022-12-01T09:24:52.515Z
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IRecursiveMutual.vdmsl' at line 1:8
files = [TestV2IRecursiveMutual.vdmsl]
*)
theory TestV2IRecursiveMutual
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: even: (nat -> bool)
	even(n) ==
(if (n = 0)
then true
else odd((n - 1)))
	measure n\<close>
\<comment>\<open>in 'TestV2IRecursiveMutual' (TestV2IRecursiveMutual.vdmsl) at line 6:5\<close>

\<comment>\<open>VDM source: pre_even: (nat +> bool)
	pre_even(n) ==
null\<close>
\<comment>\<open>in 'TestV2IRecursiveMutual' (TestV2IRecursiveMutual.vdmsl) at line 6:5\<close>
definition
	pre_even :: \<open>VDMNat \<Rightarrow> bool\<close>
where
	\<open>pre_even n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_even` specification.\<close>
		((inv_VDMNat n))\<close>


\<comment>\<open>VDM source: post_even: (nat * bool +> bool)
	post_even(n, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IRecursiveMutual' (TestV2IRecursiveMutual.vdmsl) at line 6:5\<close>
definition
	post_even :: \<open>VDMNat \<Rightarrow> bool \<Rightarrow> bool\<close>
where
	\<open>post_even n   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_even` specification.\<close>
		((inv_VDMNat n)  \<and>  (inv_bool RESULT))\<close>


	
	
\<comment>\<open>VDM source: odd: (nat -> bool)
	odd(n) ==
(if (n = 0)
then false
else even((n - 1)))
	measure n\<close>
\<comment>\<open>in 'TestV2IRecursiveMutual' (TestV2IRecursiveMutual.vdmsl) at line 12:5\<close>

\<comment>\<open>VDM source: pre_odd: (nat +> bool)
	pre_odd(n) ==
null\<close>
\<comment>\<open>in 'TestV2IRecursiveMutual' (TestV2IRecursiveMutual.vdmsl) at line 12:5\<close>
definition
	pre_odd :: \<open>VDMNat \<Rightarrow> bool\<close>
where
	\<open>pre_odd n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_odd` specification.\<close>
		((inv_VDMNat n))\<close>


\<comment>\<open>VDM source: post_odd: (nat * bool +> bool)
	post_odd(n, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IRecursiveMutual' (TestV2IRecursiveMutual.vdmsl) at line 12:5\<close>
definition
	post_odd :: \<open>VDMNat \<Rightarrow> bool \<Rightarrow> bool\<close>
where
	\<open>post_odd n   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_odd` specification.\<close>
		((inv_VDMNat n)  \<and>  (inv_bool RESULT))\<close>




end