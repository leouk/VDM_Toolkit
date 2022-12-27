(* VDM to Isabelle Translation @2022-12-27T12:31:49.952Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2IDeclBeforeUse
   in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl' at line 1:8
   files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl]
*)
theory TestV2IDeclBeforeUse
imports VDMToolkit 
begin

\<comment>\<open>VDM source: head: (seq of (nat) -> nat)
	head(s) ==
(hd s)
	pre ((len s) > 0)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 5:5\<close>
\<comment>\<open>VDM source: pre_head: (seq of (nat) +> bool)
	pre_head(s) ==
((len s) > 0)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 7:15\<close>
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
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 5:5\<close>
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

\<comment>\<open>VDM source: tail: (seq1 of (nat) -> seq of (nat))
	tail(s) ==
(tl s)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 9:5\<close>
\<comment>\<open>VDM source: pre_tail: (seq1 of (nat) +> bool)
	pre_tail(s) ==
null\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 9:5\<close>
definition
	pre_tail :: \<open>VDMNat VDMSeq1 \<Rightarrow> bool\<close>
where
	\<open>pre_tail s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_tail` specification.\<close>
		((inv_VDMSeq1' (inv_VDMNat) s))\<close>

\<comment>\<open>VDM source: post_tail: (seq1 of (nat) * seq of (nat) +> bool)
	post_tail(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 9:5\<close>
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

\<comment>\<open>VDM source: sum_elems: (seq of (nat) -> nat)
	sum_elems(s) ==
(if (s = [])
then 0
else (head(s) + sum_elems(tail(s))))
	measure (len s)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 12:5\<close>
\<comment>\<open>VDM source: pre_sum_elems: (seq of (nat) +> bool)
	pre_sum_elems(s) ==
null\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 12:5\<close>
definition
	pre_sum_elems :: \<open>VDMNat VDMSeq \<Rightarrow> bool\<close>
where
	\<open>pre_sum_elems s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_sum_elems` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) s))\<close>

\<comment>\<open>VDM source: post_sum_elems: (seq of (nat) * nat +> bool)
	post_sum_elems(s, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 12:5\<close>
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


\<comment>\<open>VDM source: T = seq1 of (nat)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 19:5\<close>
type_synonym T = \<open>VDMNat VDMSeq1\<close>
	
\<comment>\<open>VDM source: inv_T: (T +> bool)
	inv_T(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 19:5\<close>
definition
	inv_T :: \<open>T \<Rightarrow> bool\<close>
where
	\<open>inv_T dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_T` specification.\<close>
		(((inv_VDMSeq1' (inv_VDMNat) dummy0)))\<close>
 
lemmas inv_T_defs = inv_T_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 



\<comment>\<open>VDM source: S = T
	inv s == ((len tail(s)) > 0)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 24:5\<close>
type_synonym S = \<open>T\<close>
	
\<comment>\<open>VDM source: inv_S: (T +> bool)
	inv_S(s) ==
((len tail(s)) > 0)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 27:21\<close>
definition
	inv_S :: \<open>S \<Rightarrow> bool\<close>
where
	\<open>inv_S s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_S` specification.\<close>
		((inv_T s))  \<and> 
		\<comment>\<open>User defined body of inv_S.\<close>
		((len (tail s)) > (0::VDMNat))\<close>
 
lemmas inv_S_defs = inv_S_def inv_T_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 



\<comment>\<open>VDM source: R = S
	inv r == (sum_elems(r) < 5)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 30:5\<close>
type_synonym R = \<open>S\<close>
	
\<comment>\<open>VDM source: inv_R: (S +> bool)
	inv_R(r) ==
(sum_elems(r) < 5)\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 33:22\<close>
definition
	inv_R :: \<open>R \<Rightarrow> bool\<close>
where
	\<open>inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_R` specification.\<close>
		((inv_S r))  \<and> 
		\<comment>\<open>User defined body of inv_R.\<close>
		((sum_elems r) < (5::VDMNat1))\<close>

		 
lemmas inv_R_defs = inv_R_def inv_S_def inv_T_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 



\<comment>\<open>VDM source: Rec = compose Rec of s:S, t:T, r:R end
	inv mk_Rec(s, t, r) == ((sum_elems(s) > sum_elems(t)) and ((len r) > 1))\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 36:5\<close>
record Rec = 
		s\<^sub>R\<^sub>e\<^sub>c :: "S"
		 
		 t\<^sub>R\<^sub>e\<^sub>c :: "T"
		 
		 r\<^sub>R\<^sub>e\<^sub>c :: "R"
		
\<comment>\<open>VDM source: inv_Rec: (Rec +> bool)
	inv_Rec(mk_Rec(s, t, r)) ==
((sum_elems(s) > sum_elems(t)) and ((len r) > 1))\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 41:37\<close>
definition
	inv_Rec :: \<open>Rec \<Rightarrow> bool\<close>
where
	\<open>inv_Rec dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Rec` specification.\<close>
		( (((inv_S (s\<^sub>R\<^sub>e\<^sub>c dummy0))) \<and> 
		 ((inv_T (t\<^sub>R\<^sub>e\<^sub>c dummy0))) \<and> 
		 ((inv_R (r\<^sub>R\<^sub>e\<^sub>c dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context projection for `function parameters`\<close>
		(\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	
			let s = (s\<^sub>R\<^sub>e\<^sub>c dummy0); t = (t\<^sub>R\<^sub>e\<^sub>c dummy0); r = (r\<^sub>R\<^sub>e\<^sub>c dummy0) in 
		\<comment>\<open>User defined body of inv_Rec.\<close>
		(((sum_elems s) > (sum_elems t)) \<and> ((len r) > (1::VDMNat1))))\<close>

		
lemmas inv_Rec_defs = inv_R_def inv_Rec_def inv_S_def inv_T_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


\<comment>\<open>VDM source: Map = map (S) to (Rec)
	inv m == ((dom m) = {})\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 43:5\<close>
type_synonym Map = \<open>(S \<rightharpoonup> Rec)\<close>
	
\<comment>\<open>VDM source: inv_Map: (map (S) to (Rec) +> bool)
	inv_Map(m) ==
((dom m) = {})\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IDeclBeforeUse.vdmsl) at line 44:20\<close>
definition
	inv_Map :: \<open>Map \<Rightarrow> bool\<close>
where
	\<open>inv_Map m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Map` specification.\<close>
		(((inv_VDMMap inv_S inv_Rec  m)))  \<and> 
		\<comment>\<open>User defined body of inv_Map.\<close>
		((dom m) = {})\<close>

		 
lemmas inv_Map_defs = inv_Map_def inv_R_def inv_Rec_def inv_S_def inv_T_def inv_VDMMap_defs inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


 

end 