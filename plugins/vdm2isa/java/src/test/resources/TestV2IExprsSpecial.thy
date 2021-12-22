(* VDM to Isabelle Translation @2021-12-22T10:38:08.567Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl]
*)
theory TestV2IExprsSpecial
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: V = compose V of x:nat end\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 5:5\<close>
record V = 
	x\<^sub>V :: "VDMNat"
	

\<comment>\<open>VDM source: inv_V: (V +> bool)
	inv_V(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 5:5\<close>
definition
	inv_V :: "V \<Rightarrow> bool"
where
	"inv_V dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_V` specification.\<close>
		( (((inv_VDMNat (x\<^sub>V dummy0))) ))"

		

	
\<comment>\<open>VDM source: N = nat1\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 6:5\<close>
type_synonym N = "VDMNat1"
	

\<comment>\<open>VDM source: inv_N: (N +> bool)
	inv_N(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 6:5\<close>
definition
	inv_N :: "N \<Rightarrow> bool"
where
	"inv_N dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_N` specification.\<close>
		(((inv_VDMNat1 dummy0)))"
 

	
\<comment>\<open>VDM source: M = map (N) to (V)\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 7:5\<close>
type_synonym M = "(N \<rightharpoonup> V)"
	

\<comment>\<open>VDM source: inv_M: (M +> bool)
	inv_M(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 7:5\<close>
definition
	inv_M :: "M \<Rightarrow> bool"
where
	"inv_M dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_M` specification.\<close>
		(((inv_Map (inv_N) inv_V  dummy0)))"
 

	
\<comment>\<open>VDM source: U = (bool | nat)\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 9:5\<close>
datatype U = U_bool "bool" | 
		 U_VDMNat "VDMNat"
	

\<comment>\<open>VDM source: inv_U: (U +> bool)
	inv_U(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 9:5\<close>
definition
	inv_U :: "U \<Rightarrow> bool"
where
	"inv_U dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_U` specification.\<close>
		(((case dummy0 of
		 U.U_bool dummy0 \<Rightarrow> (inv_bool dummy0)
		  | U.U_VDMNat dummy0 \<Rightarrow> (inv_VDMNat dummy0)
		 )))"

		 

	
\<comment>\<open>VDM source: T = compose T of u:U end\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 10:5\<close>
record T = 
	u\<^sub>T :: "U"
	

\<comment>\<open>VDM source: inv_T: (T +> bool)
	inv_T(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 10:5\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_T` specification.\<close>
		( (((inv_U (u\<^sub>T dummy0))) ))"

		

	
\<comment>\<open>VDM source: P = map (N) to (T)\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 11:5\<close>
type_synonym P = "(N \<rightharpoonup> T)"
	

\<comment>\<open>VDM source: inv_P: (P +> bool)
	inv_P(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 11:5\<close>
definition
	inv_P :: "P \<Rightarrow> bool"
where
	"inv_P dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_P` specification.\<close>
		(((inv_Map (inv_N) inv_T  dummy0)))"
 

	
\<comment>\<open>VDM source: Q = compose Q of p:P end\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 12:5\<close>
record Q = 
	p\<^sub>Q :: "P"
	

\<comment>\<open>VDM source: inv_Q: (Q +> bool)
	inv_Q(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 12:5\<close>
definition
	inv_Q :: "Q \<Rightarrow> bool"
where
	"inv_Q dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Q` specification.\<close>
		( (((inv_P (p\<^sub>Q dummy0))) ))"
 

	
\<comment>\<open>VDM source: g: (M * N -> nat1)
	g(m, n) ==
((m(n).x) + n)
	pre (n in set (dom m))\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 16:5\<close>

\<comment>\<open>VDM source: pre_g: (M * N +> bool)
	pre_g(m, n) ==
(n in set (dom m))\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 18:11\<close>
definition
	pre_g :: "M\<Rightarrow> N \<Rightarrow> bool"
where
	"pre_g m  n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_g` specification.\<close>
		((inv_M m)  \<and>  (inv_N n))  \<and> 
		\<comment>\<open>User defined body of pre_g.\<close>
		(n \<in> (dom m))"


\<comment>\<open>VDM source: post_g: (M * N * nat1 +> bool)
	post_g(m, n, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 16:5\<close>
definition
	post_g :: "M\<Rightarrow> N\<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"post_g m  n  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g` specification.\<close>
		((inv_M m)  \<and>  (inv_N n)  \<and>  (inv_VDMNat1 RESULT))"

definition
	g :: "M\<Rightarrow> N \<Rightarrow> VDMNat1"
where
	"g m  n \<equiv> 
	\<comment>\<open>User defined body of g.\<close>
	((x\<^sub>V ((the(m n)))) + n)"

	
\<comment>\<open>VDM source: g': (M * N -> nat1)
	g'(m, n) ==
let r:V = m(n) in ((r.x) + n)
	pre (n in set (dom m))\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 21:5\<close>

\<comment>\<open>VDM source: pre_g': (M * N +> bool)
	pre_g'(m, n) ==
(n in set (dom m))\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 23:11\<close>
definition
	pre_g' :: "M\<Rightarrow> N \<Rightarrow> bool"
where
	"pre_g' m  n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_g'` specification.\<close>
		((inv_M m)  \<and>  (inv_N n))  \<and> 
		\<comment>\<open>User defined body of pre_g'.\<close>
		(n \<in> (dom m))"


\<comment>\<open>VDM source: post_g': (M * N * nat1 +> bool)
	post_g'(m, n, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 21:5\<close>
definition
	post_g' :: "M\<Rightarrow> N\<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"post_g' m  n  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_g'` specification.\<close>
		((inv_M m)  \<and>  (inv_N n)  \<and>  (inv_VDMNat1 RESULT))"

definition
	g' :: "M\<Rightarrow> N \<Rightarrow> VDMNat1"
where
	"g' m  n \<equiv> 
	\<comment>\<open>User defined body of g'.\<close>
	(
		let 
(r::V) = (the(m n))
		in
			(if (inv_V r) then
			((x\<^sub>V (r)) + n)
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: h: (P * N -> P)
	h(p, n) ==
(p ++ {n |-> mk_T(n)})\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 26:5\<close>

\<comment>\<open>VDM source: pre_h: (P * N +> bool)
	pre_h(p, n) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 26:5\<close>
definition
	pre_h :: "P\<Rightarrow> N \<Rightarrow> bool"
where
	"pre_h p  n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_h` specification.\<close>
		((inv_P p)  \<and>  (inv_N n))"


\<comment>\<open>VDM source: post_h: (P * N * P +> bool)
	post_h(p, n, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 26:5\<close>
definition
	post_h :: "P\<Rightarrow> N\<Rightarrow> P \<Rightarrow> bool"
where
	"post_h p  n  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_h` specification.\<close>
		((inv_P p)  \<and>  (inv_N n)  \<and>  (inv_P RESULT))"

definition
	h :: "P\<Rightarrow> N \<Rightarrow> P"
where
	"h p  n \<equiv> 
	\<comment>\<open>User defined body of h.\<close>
	(p \<dagger> [n\<mapsto>\<lparr>u\<^sub>T = U.U_VDMNat n\<rparr>])"

	
\<comment>\<open>VDM source: q: (Q * N -> Q)
	q(q0, n) ==
mu(q0, p |-> h((q0.p), n))\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 30:5\<close>

\<comment>\<open>VDM source: pre_q: (Q * N +> bool)
	pre_q(q0, n) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 30:5\<close>
definition
	pre_q :: "Q\<Rightarrow> N \<Rightarrow> bool"
where
	"pre_q q0  n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_q` specification.\<close>
		(inv_Q q0  \<and>  (inv_N n))"


\<comment>\<open>VDM source: post_q: (Q * N * Q +> bool)
	post_q(q0, n, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 30:5\<close>
definition
	post_q :: "Q\<Rightarrow> N\<Rightarrow> Q \<Rightarrow> bool"
where
	"post_q q0  n  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_q` specification.\<close>
		(inv_Q q0  \<and>  (inv_N n)  \<and>  inv_Q RESULT)"

definition
	q :: "Q\<Rightarrow> N \<Rightarrow> Q"
where
	"q q0  n \<equiv> 
	\<comment>\<open>User defined body of q.\<close>
	(q0)\<lparr>p\<^sub>Q := (the(h (p\<^sub>Q (q0))  n))\<rparr>"

	
\<comment>\<open>VDM source: f: (nat -> nat)
	f(x) ==
(x + 1)\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 34:5\<close>

\<comment>\<open>VDM source: pre_f: (nat +> bool)
	pre_f(x) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 34:5\<close>
definition
	pre_f :: "VDMNat \<Rightarrow> bool"
where
	"pre_f x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMNat x))"


\<comment>\<open>VDM source: post_f: (nat * nat +> bool)
	post_f(x, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 34:5\<close>
definition
	post_f :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_f x  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))"

definition
	f :: "VDMNat \<Rightarrow> VDMNat"
where
	"f x \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	(x + (1::VDMNat1))"

	
\<comment>\<open>VDM source: v1:nat = let x:nat = f(1) in x\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 39:5\<close>
abbreviation
	v1 :: "VDMNat"
where
	"v1 \<equiv> (
		let 
(x::VDMNat) = (f (1::VDMNat1))
		in
			(if ((inv_VDMNat x)) then
			x
		 else
			undefined
		)
		)"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_VDMNat v1)"

	
	
\<comment>\<open>VDM source: v2:nat = let x:nat1 = f(1) in x\<close>
\<comment>\<open>in 'TestV2IExprsSpecial' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IExprsSpecial.vdmsl) at line 41:5\<close>
abbreviation
	v2 :: "VDMNat"
where
	"v2 \<equiv> (
		let 
(x::VDMNat1) = (f (1::VDMNat1))
		in
			(if ((inv_VDMNat1 x)) then
			x
		 else
			undefined
		)
		)"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_VDMNat v2)"

	
end