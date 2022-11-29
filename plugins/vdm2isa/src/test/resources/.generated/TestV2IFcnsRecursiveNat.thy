(* VDM to Isabelle Translation @2022-11-27T14:59:14.027Z
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcnsRecursiveNat.vdmsl' at line 1:8
files = [TestV2IFcnsRecursiveNat.vdmsl]
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
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (TestV2IFcnsRecursiveNat.vdmsl) at line 6:5\<close>

\<comment>\<open>VDM source: pre_g: (nat +> bool)
	pre_g(x) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (TestV2IFcnsRecursiveNat.vdmsl) at line 6:5\<close>
definition
	pre_g :: \<open>VDMNat \<Rightarrow> bool\<close>
where
	\<open>pre_g x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g` specification.\<close>
		((inv_VDMNat x))\<close>


\<comment>\<open>VDM source: post_g: (nat * nat +> bool)
	post_g(x, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (TestV2IFcnsRecursiveNat.vdmsl) at line 6:5\<close>
definition
	post_g :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_g x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))\<close>

declare pre_g_def [simp]
fun (domintros)
	g :: \<open>VDMNat \<Rightarrow> VDMNat\<close>
where
	\<open>g x = (if (pre_g x) then
		 
	\<comment>\<open>User defined body of g.\<close>
	(
		if ((x = (0::VDMNat))) then
		((10::VDMNat1))
		else
		(((g (x - (1::VDMNat1))) + x))) 
	else undefined)\<close>
declare pre_g_def [simp del]

	
	
\<comment>\<open>VDM source: g': (seq of (nat) -> nat)
	g'(x) ==
(if (x = [])
then 0
else ((hd x) + g'((tl x))))
	measure (len x)\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (TestV2IFcnsRecursiveNat.vdmsl) at line 10:5\<close>

\<comment>\<open>VDM source: pre_g': (seq of (nat) +> bool)
	pre_g'(x) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (TestV2IFcnsRecursiveNat.vdmsl) at line 10:5\<close>
definition
	pre_g' :: \<open>VDMNat VDMSeq \<Rightarrow> bool\<close>
where
	\<open>pre_g' x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_g'` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) x))\<close>


\<comment>\<open>VDM source: post_g': (seq of (nat) * nat +> bool)
	post_g'(x, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcnsRecursiveNat' (TestV2IFcnsRecursiveNat.vdmsl) at line 10:5\<close>
definition
	post_g' :: \<open>VDMNat VDMSeq \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_g' x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g'` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) x)  \<and>  (inv_VDMNat RESULT))\<close>

declare pre_g'_def [simp]
fun (domintros)
	g' :: \<open>VDMNat VDMSeq \<Rightarrow> VDMNat\<close>
where
	\<open>g' x = (if (pre_g' x) then
		 
	\<comment>\<open>User defined body of g'.\<close>
	(
		if ((x = [])) then
		((0::VDMNat))
		else
		(((hd x) + (g' (tl x))))) 
	else undefined)\<close>
declare pre_g'_def [simp del]



end