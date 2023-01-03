(* VDM to Isabelle Translation @2023-01-02T09:27:45.816Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2IUseBeforeDecl
   in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl' at line 1:8
   files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl]
*)
theory TestV2IUseBeforeDecl
imports VDMToolkit 
begin


\<comment>\<open>VDM source: tail: (seq1 of (nat) -> seq of (nat))
	tail(s) ==
(tl s)\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 35:5\<close>
\<comment>\<open>VDM source: pre_tail: (seq1 of (nat) +> bool)
	pre_tail(s) ==
null\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 35:5\<close>
definition
	pre_tail :: \<open>VDMNat VDMSeq1 \<Rightarrow> bool\<close>
where
	\<open>pre_tail s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_tail` specification.\<close>
		((inv_VDMSeq1' (inv_VDMNat) s))\<close>

\<comment>\<open>VDM source: post_tail: (seq1 of (nat) * seq of (nat) +> bool)
	post_tail(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 35:5\<close>
definition
	post_tail :: \<open>VDMNat VDMSeq1 \<Rightarrow> VDMNat VDMSeq \<Rightarrow> bool\<close>
where
	\<open>post_tail s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_tail` specification.\<close>
		((inv_VDMSeq1' (inv_VDMNat) s)  \<and>  (inv_VDMSeq' (inv_VDMNat) RESULT))\<close>

definition
	tail :: \<open>VDMNat VDMSeq1 \<Rightarrow> VDMNat VDMSeq\<close>
where
	\<open>tail s \<equiv> (if (pre_tail s) then
		 
	\<comment>\<open>User defined body of tail.\<close>
	(tl s) 
	else undefined)\<close>

\<comment>\<open>VDM source: head: (seq of (nat) -> nat)
	head(s) ==
(hd s)
	pre ((len s) > 0)\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 42:5\<close>
\<comment>\<open>VDM source: pre_head: (seq of (nat) +> bool)
	pre_head(s) ==
((len s) > 0)\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 44:15\<close>
definition
	pre_head :: \<open>VDMNat VDMSeq \<Rightarrow> bool\<close>
where
	\<open>pre_head s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_head` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s))  \<and> 
		\<comment>\<open>User defined body of pre_head.\<close>
		((len s) > (0::VDMNat))\<close>

\<comment>\<open>VDM source: post_head: (seq of (nat) * nat +> bool)
	post_head(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 42:5\<close>
definition
	post_head :: \<open>VDMNat VDMSeq \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_head s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_head` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s)  \<and>  (inv_VDMNat RESULT))\<close>

definition
	head :: \<open>VDMNat VDMSeq \<Rightarrow> VDMNat\<close>
where
	\<open>head s \<equiv> (if (pre_head s) then
		 
	\<comment>\<open>User defined body of head.\<close>
	(hd s) 
	else undefined)\<close>

\<comment>\<open>VDM source: sum_elems: (seq of (nat) -> nat)
	sum_elems(s) ==
(if (s = [])
then 0
else (head(s) + sum_elems(tail(s))))
	measure (len s)\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 38:5\<close>
\<comment>\<open>VDM source: pre_sum_elems: (seq of (nat) +> bool)
	pre_sum_elems(s) ==
null\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 38:5\<close>
definition
	pre_sum_elems :: \<open>VDMNat VDMSeq \<Rightarrow> bool\<close>
where
	\<open>pre_sum_elems s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_sum_elems` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s))\<close>

\<comment>\<open>VDM source: post_sum_elems: (seq of (nat) * nat +> bool)
	post_sum_elems(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IUseBeforeDecl.vdmsl) at line 38:5\<close>
definition
	post_sum_elems :: \<open>VDMNat VDMSeq \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_sum_elems s   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_sum_elems` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s)  \<and>  (inv_VDMNat RESULT))\<close>

declare pre_sum_elems_def [simp]
fun (domintros)
	sum_elems :: \<open>VDMNat VDMSeq \<Rightarrow> VDMNat\<close>
where
	\<open>sum_elems s = (if (pre_sum_elems s) then
		 
	\<comment>\<open>User defined body of sum_elems.\<close>
	(
		if ((s = [])) then
		((0::VDMNat))
		else
		(((head s) + (sum_elems (tail s))))) 
	else undefined)\<close>
declare pre_sum_elems_def [simp del]

 

end 