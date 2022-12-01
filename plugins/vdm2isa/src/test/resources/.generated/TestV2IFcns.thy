(* VDM to Isabelle Translation @2022-11-27T14:59:13.982Z
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns.vdmsl' at line 1:8
files = [TestV2IFcns.vdmsl]
*)
theory TestV2IFcns
imports VDMToolkit
begin


\<comment>\<open>VDM source: const: (() -> nat)
	const() ==
10\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 8:5\<close>

\<comment>\<open>VDM source: pre_const: (() +> bool)
	pre_const() ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 8:5\<close>
definition
	pre_const :: \<open>bool\<close>
where
	\<open>pre_const  \<equiv> True\<close>


\<comment>\<open>VDM source: post_const: (nat +> bool)
	post_const(RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 8:5\<close>
definition
	post_const :: \<open>VDMNat \<Rightarrow> \<bool>\<close>
where
	\<open>post_const RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_const` specification.\<close>
		((inv_VDMNat RESULT))\<close>

definition
	const :: \<open>VDMNat\<close>
where
	\<open>const  \<equiv> (if (pre_const ) then
		 
	\<comment>\<open>User defined body of const.\<close>
	(10::VDMNat1) 
	else undefined)\<close>

	
	
\<comment>\<open>VDM source: constS: (() -> nat)
	constS() ==
10
	pre (10 > 5)
	post (RESULT > 0)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 12:5\<close>

\<comment>\<open>VDM source: pre_constS: (() +> bool)
	pre_constS() ==
(10 > 5)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 14:12\<close>
definition
	pre_constS :: \<open>bool\<close>
where
	\<open>pre_constS  \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_constS` specification.\<close>
		
		\<comment>\<open>User defined body of pre_constS.\<close>
		((10::VDMNat1) > (5::VDMNat1))\<close>


\<comment>\<open>VDM source: post_constS: (nat +> bool)
	post_constS(RESULT) ==
(RESULT > 0)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 15:17\<close>
definition
	post_constS :: \<open>VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_constS RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_constS` specification.\<close>
		((inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_constS.\<close>
		(RESULT > (0::VDMNat))\<close>

definition
	constS :: \<open>VDMNat\<close>
where
	\<open>constS  \<equiv> (if (pre_constS ) then
		 
	\<comment>\<open>User defined body of constS.\<close>
	(10::VDMNat1) 
	else undefined)\<close>

	
	
\<comment>\<open>VDM source: f: (nat * nat1 -> nat1)
	f(x, y) ==
(x + y)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 18:5\<close>

\<comment>\<open>VDM source: pre_f: (nat * nat1 +> bool)
	pre_f(x, y) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 18:5\<close>
definition
	pre_f :: \<open>VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool\<close>
where
	\<open>pre_f x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))\<close>


\<comment>\<open>VDM source: post_f: (nat * nat1 * nat1 +> bool)
	post_f(x, y, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 18:5\<close>
definition
	post_f :: \<open>VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> bool\<close>
where
	\<open>post_f x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat1 RESULT))\<close>

definition
	f :: \<open>VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1\<close>
where
	\<open>f x   y \<equiv> (if (pre_f x   y) then
		 
	\<comment>\<open>User defined body of f.\<close>
	(x + y) 
	else undefined)\<close>

	
	
\<comment>\<open>VDM source: g: (nat * nat1 -> nat1)
	g(x, y) ==
(x + y)
	pre (x > 10)
	post (x < RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 22:5\<close>

\<comment>\<open>VDM source: pre_g: (nat * nat1 +> bool)
	pre_g(x, y) ==
(x > 10)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 24:11\<close>
definition
	pre_g :: \<open>VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> bool\<close>
where
	\<open>pre_g x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))  \<and> 
		\<comment>\<open>User defined body of pre_g.\<close>
		(x > (10::VDMNat1))\<close>


\<comment>\<open>VDM source: post_g: (nat * nat1 * nat1 +> bool)
	post_g(x, y, RESULT) ==
(x < RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 25:12\<close>
definition
	post_g :: \<open>VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> bool\<close>
where
	\<open>post_g x   y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_g` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat1 RESULT))  \<and> 
		\<comment>\<open>User defined body of post_g.\<close>
		(x < RESULT)\<close>

definition
	g :: \<open>VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1\<close>
where
	\<open>g x   y \<equiv> (if (pre_g x   y) then
		 
	\<comment>\<open>User defined body of g.\<close>
	(x + y) 
	else undefined)\<close>

abbreviation 
    test :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where
     \<open>test x \<equiv>  True\<close>
definition
    test2 :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where
      [simp, intro!] :  \<open>test2 x \<equiv>  True\<close>
type_synonym 'a test2  =  \<open>'a set\<close>
lemmas test  =  f_def, g_def
lemma test  [simp, intro!] :
    \<open>True\<close>  
theorem test  [simp, intro!] :
    \<open>True\<close>  	
	
\<comment>\<open>VDM source: h: (nat -> nat)
	h(x) ==
g(x, x)
	pre pre_g(x, x)
	post post_g(x, x, RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 28:5\<close>

\<comment>\<open>VDM source: pre_h: (nat +> bool)
	pre_h(x) ==
pre_g(x, x)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 30:9\<close>
definition
	pre_h :: \<open>VDMNat \<Rightarrow> bool\<close>
where
	\<open>pre_h x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_h` specification.\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h.\<close>
		(pre_g x  x)\<close>


\<comment>\<open>VDM source: post_h: (nat * nat +> bool)
	post_h(x, RESULT) ==
post_g(x, x, RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 31:10\<close>
definition
	post_h :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_h x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_h` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h.\<close>
		(post_g x  x  RESULT)\<close>

definition
	h :: \<open>VDMNat \<Rightarrow> VDMNat\<close>
where
	\<open>h x \<equiv> (if (pre_h x) then
		 
	\<comment>\<open>User defined body of h.\<close>
	(g x  x) 
	else undefined)\<close>

	
	
\<comment>\<open>VDM source: h': (nat -> nat)
	h'(x) ==
g(x, x)
	pre (x < 20)
	post (x > 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 34:5\<close>

\<comment>\<open>VDM source: pre_h': (nat +> bool)
	pre_h'(x) ==
(x < 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 36:11\<close>
definition
	pre_h' :: \<open>VDMNat \<Rightarrow> bool\<close>
where
	\<open>pre_h' x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_h'` specification.\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h'.\<close>
		(x < (20::VDMNat1))\<close>


\<comment>\<open>VDM source: post_h': (nat * nat +> bool)
	post_h'(x, RESULT) ==
(x > 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 37:12\<close>
definition
	post_h' :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_h' x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_h'` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h'.\<close>
		(x > (20::VDMNat1))\<close>

definition
	h' :: \<open>VDMNat \<Rightarrow> VDMNat\<close>
where
	\<open>h' x \<equiv> (if (pre_h' x) then
		 
	\<comment>\<open>User defined body of h'.\<close>
	(g x  x) 
	else undefined)\<close>

	
	
\<comment>\<open>VDM source: h'': (nat -> nat)
	h''(x) ==
g(x, x)
	pre (x < 20)
	post pre_g(x, RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 40:5\<close>

\<comment>\<open>VDM source: pre_h'': (nat +> bool)
	pre_h''(x) ==
(x < 20)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 42:11\<close>
definition
	pre_h'' :: \<open>VDMNat \<Rightarrow> bool\<close>
where
	\<open>pre_h'' x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_h''` specification.\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h''.\<close>
		(x < (20::VDMNat1))\<close>


\<comment>\<open>VDM source: post_h'': (nat * nat +> bool)
	post_h''(x, RESULT) ==
pre_g(x, RESULT)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 43:10\<close>
definition
	post_h'' :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_h'' x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_h''` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h''.\<close>
		(pre_g x  RESULT)\<close>

definition
	h'' :: \<open>VDMNat \<Rightarrow> VDMNat\<close>
where
	\<open>h'' x \<equiv> (if (pre_h'' x) then
		 
	\<comment>\<open>User defined body of h''.\<close>
	(g x  x) 
	else undefined)\<close>

	
	
\<comment>\<open>VDM source: curried: (nat -> (nat -> nat))
	curried(x)(y) ==
(x + y)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 46:5\<close>

\<comment>\<open>VDM source: pre_curried: (nat +> (nat +> bool))
	pre_curried(x)(y) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 46:5\<close>
definition
	pre_curried :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>pre_curried x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_curried` specification.\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))\<close>


\<comment>\<open>VDM source: post_curried: (nat +> (nat * nat +> bool))
	post_curried(x)(y, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 46:5\<close>
definition
	post_curried :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_curried x y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_curried` specification.\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))\<close>

definition
	curried :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat\<close>
where
	\<open>curried x y \<equiv> (if (pre_curried x y) then
		 
	\<comment>\<open>User defined body of curried.\<close>
	(x + y) 
	else undefined)\<close>

	
	
\<comment>\<open>VDM source: curriedS: (nat -> (nat -> nat))
	curriedS(x)(y) ==
(x + y)
	pre (x > y)
	post ((x < RESULT) and (y < RESULT))\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 50:5\<close>

\<comment>\<open>VDM source: pre_curriedS: (nat +> (nat +> bool))
	pre_curriedS(x)(y) ==
(x > y)\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 52:11\<close>
definition
	pre_curriedS :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>pre_curriedS x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_curriedS` specification.\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))  \<and> 
		\<comment>\<open>User defined body of pre_curriedS.\<close>
		(x > y)\<close>


\<comment>\<open>VDM source: post_curriedS: (nat +> (nat * nat +> bool))
	post_curriedS(x)(y, RESULT) ==
((x < RESULT) and (y < RESULT))\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 53:21\<close>
definition
	post_curriedS :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat \<Rightarrow> bool\<close>
where
	\<open>post_curriedS x y   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_curriedS` specification.\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))  \<and> 
		\<comment>\<open>User defined body of post_curriedS.\<close>
		((x < RESULT) \<and> (y < RESULT))\<close>

definition
	curriedS :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat\<close>
where
	\<open>curriedS x y \<equiv> (if (pre_curriedS x y) then
		 
	\<comment>\<open>User defined body of curriedS.\<close>
	(x + y) 
	else undefined)\<close>

	
	
\<comment>\<open>VDM source: static private implicit((x, y:nat), (z:set of (nat)))r:seq of (nat)
	pre ((x < y) and (x in set z))
	post (x > (len r))\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 55:5\<close>

\<comment>\<open>VDM source: pre_implicit: (nat * nat * set of (nat) +> bool)
	pre_implicit(x, y, z) ==
((x < y) and (x in set z))\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 56:15\<close>
definition
	pre_implicit :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> bool\<close>
where
	\<open>pre_implicit x   y   z \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_implicit` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMSet' (inv_VDMNat) z))  \<and> 
		\<comment>\<open>User defined body of pre_implicit.\<close>
		((x < y) \<and> (x \<in> z))\<close>


\<comment>\<open>VDM source: post_implicit: (nat * nat * set of (nat) * seq of (nat) +> bool)
	post_implicit(x, y, z, r) ==
(x > (len r))\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 57:12\<close>
definition
	post_implicit :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> VDMNat VDMSeq \<Rightarrow> bool\<close>
where
	\<open>post_implicit x   y   z   r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_implicit` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMSet' (inv_VDMNat) z)  \<and>  (inv_VDMSeq' (inv_VDMNat) r))  \<and> 
		\<comment>\<open>User defined body of post_implicit.\<close>
		(x > (len r))\<close>


	
	
\<comment>\<open>VDM source: static private implicitexplicit((x, y:nat), (z:set of (nat)))r:seq of (nat) ==
	[x, y]
	pre ((x < y) and (x in set z))
	post (x > (len r))\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 59:5\<close>

\<comment>\<open>VDM source: pre_implicitexplicit: (nat * nat * set of (nat) +> bool)
	pre_implicitexplicit(x, y, z) ==
((x < y) and (x in set z))\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 61:15\<close>
definition
	pre_implicitexplicit :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> bool\<close>
where
	\<open>pre_implicitexplicit x   y   z \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_implicitexplicit` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMSet' (inv_VDMNat) z))  \<and> 
		\<comment>\<open>User defined body of pre_implicitexplicit.\<close>
		((x < y) \<and> (x \<in> z))\<close>


\<comment>\<open>VDM source: post_implicitexplicit: (nat * nat * set of (nat) * seq of (nat) +> bool)
	post_implicitexplicit(x, y, z, r) ==
(x > (len r))\<close>
\<comment>\<open>in 'TestV2IFcns' (TestV2IFcns.vdmsl) at line 62:12\<close>
definition
	post_implicitexplicit :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> VDMNat VDMSeq \<Rightarrow> bool\<close>
where
	\<open>post_implicitexplicit x   y   z   r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_implicitexplicit` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat y)  \<and>  (inv_VDMSet' (inv_VDMNat) z)  \<and>  (inv_VDMSeq' (inv_VDMNat) r))  \<and> 
		\<comment>\<open>User defined body of post_implicitexplicit.\<close>
		(x > (len r))\<close>

definition
	implicitexplicit :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat VDMSet \<Rightarrow> VDMNat VDMSeq\<close>
where
	\<open>implicitexplicit x   y   z \<equiv> (if (pre_implicitexplicit x   y   z) then
		 
	\<comment>\<open>User defined body of implicitexplicit.\<close>
	[x , y] 
	else undefined)\<close>



end