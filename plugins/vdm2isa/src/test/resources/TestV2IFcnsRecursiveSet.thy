(* VDM to Isabelle Translation @2022-11-27T14:59:14.030Z
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcnsRecursiveSet.vdmsl' at line 1:8
files = [TestV2IFcnsRecursiveSet.vdmsl]
*)
theory TestV2IFcnsRecursiveSet
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: f: (set of (nat) -> nat)
	f(s) ==
(if (s = {})
then 0
else let x in set s in (f((s \ {x})) + x))
	measure (card s)\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveSet' (TestV2IFcnsRecursiveSet.vdmsl) at line 5:5\<close>

\<comment>\<open>VDM source: pre_f: (set of (nat) +> bool)
	pre_f(s) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveSet' (TestV2IFcnsRecursiveSet.vdmsl) at line 5:5\<close>
definition
	pre_f :: \<open>VDMNat VDMSet \<Rightarrow> bool\<close>
where
	\<open>pre_f s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) s))\<close>


\<comment>\<open>VDM source: post_f: (set of (nat) * nat +> bool)
	post_f(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveSet' (TestV2IFcnsRecursiveSet.vdmsl) at line 5:5\<close>
definition
	post_f :: \<open>VDMNat VDMSet \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_f s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) s)  \<and>  (inv_VDMNat RESULT))\<close>

find_theorems name:some
declare pre_f_def [simp]
fun (domintros)
	f :: \<open>VDMNat VDMSet \<Rightarrow> VDMNat\<close>
where
	\<open>f s = (if (pre_f s) then
		 
	\<comment>\<open>User defined body of f.\<close>
	(
		if ((s = {})) then
		((0::VDMNat))
		else
		((
		SOME (dummy0::VDMNat) .(dummy0 \<in> { ((f (s - {x})) + x) | x .  ((x \<in>s))  })))) 
	else undefined)\<close>
declare pre_f_def [simp del]
find_theorems "\<some> _. _" 
	
	
\<comment>\<open>VDM source: f': (set of (nat) -> nat)
	f'(s) ==
(cases s :
{} -> 0,
{x} union xs -> (x + f'(xs))
end)
	measure (card s)\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveSet' (TestV2IFcnsRecursiveSet.vdmsl) at line 9:5\<close>

\<comment>\<open>VDM source: pre_f': (set of (nat) +> bool)
	pre_f'(s) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveSet' (TestV2IFcnsRecursiveSet.vdmsl) at line 9:5\<close>
definition
	pre_f' :: \<open>VDMNat VDMSet \<Rightarrow> bool\<close>
where
	\<open>pre_f' s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f'` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) s))\<close>


\<comment>\<open>VDM source: post_f': (set of (nat) * nat +> bool)
	post_f'(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveSet' (TestV2IFcnsRecursiveSet.vdmsl) at line 9:5\<close>
definition
	post_f' :: \<open>VDMNat VDMSet \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_f' s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f'` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) s)  \<and>  (inv_VDMNat RESULT))\<close>

declare pre_f'_def [simp]
fun (domintros)
	f' :: \<open>VDMNat VDMSet \<Rightarrow> VDMNat\<close>
where
	\<open>f' s = (if (pre_f' s) then
		 
	\<comment>\<open>User defined body of f'.\<close>
	(
		 \<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. optional, union, etc.) for `VDMNat VDMSet` VDM type.\<close>) 
	else undefined)\<close>
declare pre_f'_def [simp del]



end