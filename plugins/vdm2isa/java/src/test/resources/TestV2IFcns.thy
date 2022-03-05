(* VDM to Isabelle Translation @2022-03-05T08:34:11.681Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: const: (() -> nat)
	const() ==
10\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 7:5\<close>

\<comment>\<open>VDM source: pre_const: (() +> bool)
	pre_const() ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 7:5\<close>
definition
	pre_const :: "bool"
where
	"pre_const  \<equiv> True"


\<comment>\<open>VDM source: post_const: (nat +> bool)
	post_const(RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 7:5\<close>
definition
	post_const :: "VDMNat \<Rightarrow> bool"
where
	"post_const RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_const` specification.\<close>
		((inv_VDMNat RESULT))"

definition
	const :: "VDMNat"
where
	"const  \<equiv> 
	\<comment>\<open>User defined body of const.\<close>
	(10::VDMNat1)"

	
	
\<comment>\<open>VDM source: constS: (() -> nat)
	constS() ==
10
	pre (10 > 5)
	post (RESULT > 0)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 11:5\<close>

\<comment>\<open>VDM source: pre_constS: (() +> bool)
	pre_constS() ==
(10 > 5)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 13:12\<close>
definition
	pre_constS :: "bool"
where
	"pre_constS  \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_constS` specification.\<close>
		
		\<comment>\<open>User defined body of pre_constS.\<close>
		((10::VDMNat1) > (5::VDMNat1))"


\<comment>\<open>VDM source: post_constS: (nat +> bool)
	post_constS(RESULT) ==
(RESULT > 0)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 14:17\<close>
definition
	post_constS :: "VDMNat \<Rightarrow> bool"
where
	"post_constS RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_constS` specification.\<close>
		((inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_constS.\<close>
		(RESULT > (0::VDMNat))"

definition
	constS :: "VDMNat"
where
	"constS  \<equiv> 
	\<comment>\<open>User defined body of constS.\<close>
	(10::VDMNat1)"

	
	
\<comment>\<open>VDM source: f: (nat * nat1 -> nat1)
	f(x, y) ==
(x + y)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 17:5\<close>

\<comment>\<open>VDM source: pre_f: (nat * nat1 +> bool)
	pre_f(x, y) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 17:5\<close>
definition
	pre_f :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_f x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))"


\<comment>\<open>VDM source: post_f: (nat * nat1 * nat1 +> bool)
	post_f(x, y, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 17:5\<close>
definition
	post_f :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"post_f x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat1 RESULT))"

definition
	f :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"f x   y \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	(x + y)"

	
	
\<comment>\<open>VDM source: g: (nat * nat1 -> nat1)
	g(x, y) ==
(x + y)
	pre ((x > 10) and (y > 20))
	post (x < RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 21:5\<close>

\<comment>\<open>VDM source: pre_g: (nat * nat1 +> bool)
	pre_g(x, y) ==
((x > 10) and (y > 20))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 23:16\<close>
definition
	pre_g :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_g x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))  \<and> 
		\<comment>\<open>User defined body of pre_g.\<close>
		((x > (10::VDMNat1)) \<and> (y > (20::VDMNat1)))"


\<comment>\<open>VDM source: post_g: (nat * nat1 * nat1 +> bool)
	post_g(x, y, RESULT) ==
(x < RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 24:12\<close>
definition
	post_g :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"post_g x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat1 RESULT))  \<and> 
		\<comment>\<open>User defined body of post_g.\<close>
		(x < RESULT)"

definition
	g :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"g x   y \<equiv> 
	\<comment>\<open>User defined body of g.\<close>
	(x + y)"

	
	
\<comment>\<open>VDM source: h: (nat -> nat)
	h(x) ==
g(x, x)
	pre (pre_g(x, x) and (x < 20))
	post (post_g(x, x, RESULT) and (x > 20))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 27:5\<close>

\<comment>\<open>VDM source: pre_h: (nat +> bool)
	pre_h(x) ==
(pre_g(x, x) and (x < 20))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 29:21\<close>
definition
	pre_h :: "VDMNat \<Rightarrow> bool"
where
	"pre_h x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_h` specification.\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h.\<close>
		((pre_g x  x) \<and> (x < (20::VDMNat1)))"


\<comment>\<open>VDM source: post_h: (nat * nat +> bool)
	post_h(x, RESULT) ==
(post_g(x, x, RESULT) and (x > 20))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 30:31\<close>
definition
	post_h :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_h x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_h` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h.\<close>
		((post_g x  x  RESULT) \<and> (x > (20::VDMNat1)))"

definition
	h :: "VDMNat \<Rightarrow> VDMNat"
where
	"h x \<equiv> 
	\<comment>\<open>User defined body of h.\<close>
	(g x  x)"

	
	
\<comment>\<open>VDM source: h': (nat -> nat)
	h'(x) ==
g(x, x)
	pre (x < 20)
	post (x > 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 33:5\<close>

\<comment>\<open>VDM source: pre_h': (nat +> bool)
	pre_h'(x) ==
(x < 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 35:11\<close>
definition
	pre_h' :: "VDMNat \<Rightarrow> bool"
where
	"pre_h' x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_h'` specification.\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h'.\<close>
		(x < (20::VDMNat1))"


\<comment>\<open>VDM source: post_h': (nat * nat +> bool)
	post_h'(x, RESULT) ==
(x > 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 36:12\<close>
definition
	post_h' :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_h' x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_h'` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h'.\<close>
		(x > (20::VDMNat1))"

definition
	h' :: "VDMNat \<Rightarrow> VDMNat"
where
	"h' x \<equiv> 
	\<comment>\<open>User defined body of h'.\<close>
	(g x  x)"

	
	
\<comment>\<open>VDM source: h'': (nat -> nat)
	h''(x) ==
g(x, x)
	pre (x < 20)
	post (pre_g(x, RESULT) and (x > 20))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 39:5\<close>

\<comment>\<open>VDM source: pre_h'': (nat +> bool)
	pre_h''(x) ==
(x < 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 41:11\<close>
definition
	pre_h'' :: "VDMNat \<Rightarrow> bool"
where
	"pre_h'' x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_h''` specification.\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h''.\<close>
		(x < (20::VDMNat1))"


\<comment>\<open>VDM source: post_h'': (nat * nat +> bool)
	post_h''(x, RESULT) ==
(pre_g(x, RESULT) and (x > 20))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 42:26\<close>
definition
	post_h'' :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_h'' x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_h''` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h''.\<close>
		((pre_g x  RESULT) \<and> (x > (20::VDMNat1)))"

definition
	h'' :: "VDMNat \<Rightarrow> VDMNat"
where
	"h'' x \<equiv> 
	\<comment>\<open>User defined body of h''.\<close>
	(g x  x)"

	
	
\<comment>\<open>VDM source: curried: (nat -> (nat -> nat))
	curried(x)(y) ==
(x + y)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 45:5\<close>

\<comment>\<open>VDM source: pre_curried: (nat +> (nat +> bool))
	pre_curried(x)(y) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 45:5\<close>
definition
	pre_curried :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_curried x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_curried` specification.\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))"


\<comment>\<open>VDM source: post_curried: (nat +> (nat * nat +> bool))
	post_curried(x)(y, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 45:5\<close>
definition
	post_curried :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_curried x y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_curried` specification.\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))"

definition
	curried :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"curried x y \<equiv> 
	\<comment>\<open>User defined body of curried.\<close>
	(x + y)"

	
	
\<comment>\<open>VDM source: curriedS: (nat -> (nat -> nat))
	curriedS(x)(y) ==
(x + y)
	pre (x > y)
	post ((x < RESULT) and (y < RESULT))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 49:5\<close>

\<comment>\<open>VDM source: pre_curriedS: (nat +> (nat +> bool))
	pre_curriedS(x)(y) ==
(x > y)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 51:11\<close>
definition
	pre_curriedS :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_curriedS x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_curriedS` specification.\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))  \<and> 
		\<comment>\<open>User defined body of pre_curriedS.\<close>
		(x > y)"


\<comment>\<open>VDM source: post_curriedS: (nat +> (nat * nat +> bool))
	post_curriedS(x)(y, RESULT) ==
((x < RESULT) and (y < RESULT))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 52:21\<close>
definition
	post_curriedS :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_curriedS x y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_curriedS` specification.\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))  \<and> 
		\<comment>\<open>User defined body of post_curriedS.\<close>
		((x < RESULT) \<and> (y < RESULT))"

definition
	curriedS :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"curriedS x y \<equiv> 
	\<comment>\<open>User defined body of curriedS.\<close>
	(x + y)"

	
	
\<comment>\<open>VDM source: static private implicit((x, y:nat), (z:set of (nat)))r:seq of (nat)
	pre ((x < y) and (x in set z))
	post (x > (len r))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 54:5\<close>

\<comment>\<open>VDM source: pre_implicit: (nat * nat * set of (nat) +> bool)
	pre_implicit(x, y, z) ==
((x < y) and (x in set z))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 55:15\<close>
definition
	pre_implicit :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> bool"
where
	"pre_implicit x   y   z \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_implicit` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMSet' (inv_VDMNat) z))  \<and> 
		\<comment>\<open>User defined body of pre_implicit.\<close>
		((x < y) \<and> (x \<in> z))"


\<comment>\<open>VDM source: post_implicit: (nat * nat * set of (nat) * seq of (nat) +> bool)
	post_implicit(x, y, z, r) ==
(x > (len r))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 56:12\<close>
definition
	post_implicit :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> VDMNat VDMSeq \<Rightarrow> bool"
where
	"post_implicit x   y   z   r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_implicit` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMSet' (inv_VDMNat) z)  \<and>  (inv_VDMSeq' (inv_VDMNat) r))  \<and> 
		\<comment>\<open>User defined body of post_implicit.\<close>
		(x > (len r))"


	
	
\<comment>\<open>VDM source: static private implicitexplicit((x, y:nat), (z:set of (nat)))r:seq of (nat) ==
	[x, y]
	pre ((x < y) and (x in set z))
	post (x > (len r))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 58:5\<close>

\<comment>\<open>VDM source: pre_implicitexplicit: (nat * nat * set of (nat) +> bool)
	pre_implicitexplicit(x, y, z) ==
((x < y) and (x in set z))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 60:15\<close>
definition
	pre_implicitexplicit :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> bool"
where
	"pre_implicitexplicit x   y   z \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_implicitexplicit` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMSet' (inv_VDMNat) z))  \<and> 
		\<comment>\<open>User defined body of pre_implicitexplicit.\<close>
		((x < y) \<and> (x \<in> z))"


\<comment>\<open>VDM source: post_implicitexplicit: (nat * nat * set of (nat) * seq of (nat) +> bool)
	post_implicitexplicit(x, y, z, r) ==
(x > (len r))\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 61:12\<close>
definition
	post_implicitexplicit :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> VDMNat VDMSeq \<Rightarrow> bool"
where
	"post_implicitexplicit x   y   z   r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_implicitexplicit` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMSet' (inv_VDMNat) z)  \<and>  (inv_VDMSeq' (inv_VDMNat) r))  \<and> 
		\<comment>\<open>User defined body of post_implicitexplicit.\<close>
		(x > (len r))"

definition
	implicitexplicit :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> VDMNat VDMSeq"
where
	"implicitexplicit x   y   z \<equiv> 
	\<comment>\<open>User defined body of implicitexplicit.\<close>
	[x , y]"



end