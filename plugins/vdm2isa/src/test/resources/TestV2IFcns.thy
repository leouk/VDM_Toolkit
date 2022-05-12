(* VDM to Isabelle Translation @2022-05-06T12:42:51.791Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: g: (nat * nat1 -> nat1)
	g(x, y) ==
(x + y)
	pre (x > 10)
	post (x < RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 24:5\<close>

\<comment>\<open>VDM source: pre_g: (nat * nat1 +> bool)
	pre_g(x, y) ==
(x > 10)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 26:11\<close>
definition
	pre_g :: "VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_g x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))  \<and> 
		\<comment>\<open>User defined body of pre_g.\<close>
		(x > (10::VDMNat1))"


\<comment>\<open>VDM source: post_g: (nat * nat1 * nat1 +> bool)
	post_g(x, y, RESULT) ==
(x < RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 27:12\<close>
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
	pre pre_g(x, x)
	post post_g(x, x, RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 30:5\<close>

\<comment>\<open>VDM source: pre_h: (nat +> bool)
	pre_h(x) ==
pre_g(x, x)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 32:9\<close>
definition
	pre_h :: "VDMNat \<Rightarrow> bool"
where
	"pre_h x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_h` specification.\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h.\<close>
		(pre_g x  x)"


\<comment>\<open>VDM source: post_h: (nat * nat +> bool)
	post_h(x, RESULT) ==
post_g(x, x, RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 33:10\<close>
definition
	post_h :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_h x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_h` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h.\<close>
		(post_g x  x  RESULT)"

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
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 36:5\<close>

\<comment>\<open>VDM source: pre_h': (nat +> bool)
	pre_h'(x) ==
(x < 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 38:11\<close>
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
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 39:12\<close>
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
	post pre_g(x, RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 42:5\<close>

\<comment>\<open>VDM source: pre_h'': (nat +> bool)
	pre_h''(x) ==
(x < 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 44:11\<close>
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
pre_g(x, RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 45:10\<close>
definition
	post_h'' :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_h'' x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_h''` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h''.\<close>
		(pre_g x  RESULT)"

definition
	h'' :: "VDMNat \<Rightarrow> VDMNat"
where
	"h'' x \<equiv> 
	\<comment>\<open>User defined body of h''.\<close>
	(g x  x)"



end