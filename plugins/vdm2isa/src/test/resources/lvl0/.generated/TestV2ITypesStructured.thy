(* VDM to Isabelle Translation @2022-12-22T16:13:15.652Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesStructured
   in './lvl0/TestV2ITypesStructured.vdmsl' at line 1:8
   files = [./lvl0/TestV2ITypesStructured.vdmsl]
*)
theory TestV2ITypesStructured
imports VDMToolkit 
begin


\<comment>\<open>VDM source: G2 = (int * int)
	inv mk_(l, r) == (l < r)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 10:5\<close>
type_synonym G2 = \<open>(VDMInt \<times> VDMInt)\<close>
	
\<comment>\<open>VDM source: inv_G2: ((int * int) +> bool)
	inv_G2(mk_(l, r)) ==
(l < r)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 11:23\<close>
definition
	inv_G2 :: \<open>G2 \<Rightarrow> bool\<close>
where
	\<open>inv_G2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_G2` specification.\<close>
		((
		((inv_VDMInt (fst dummy0))\<and>
		 (inv_VDMInt (snd dummy0))
		)))  \<and> 
		\<comment>\<open>Implicit pattern context projection for `function parameters`\<close>
		(\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	
			let l = (fst dummy0); r = (snd dummy0) in 
		\<comment>\<open>User defined body of inv_G2.\<close>
		(l < r))\<close>

		 
lemmas inv_G2_defs = inv_G2_def inv_VDMInt_def 



\<comment>\<open>VDM source: G2' = (int * int)
	inv g == ((g.#1) < (g.#2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 14:5\<close>
type_synonym G2' = \<open>(VDMInt \<times> VDMInt)\<close>
	
\<comment>\<open>VDM source: inv_G2': ((int * int) +> bool)
	inv_G2'(g) ==
((g.#1) < (g.#2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 15:19\<close>
definition
	inv_G2' :: \<open>G2' \<Rightarrow> bool\<close>
where
	\<open>inv_G2' g \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_G2'` specification.\<close>
		((
		((inv_VDMInt (fst g))\<and>
		 (inv_VDMInt (snd g))
		)))  \<and> 
		\<comment>\<open>User defined body of inv_G2'.\<close>
		((fst (g)) < (snd (g)))\<close>

		 
lemmas inv_G2'_defs = inv_G2'_def inv_VDMInt_def 


\<comment>\<open>VDM source: TSet = set of (nat1)
	inv s == (s <> {})
	eq s1 = s2 == (s1 subset s2)
	ord s1 < s2 == ((card s1) < (card s2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 17:5\<close>
type_synonym TSet = \<open>VDMNat1 VDMSet\<close>
	
\<comment>\<open>VDM source: inv_TSet: (set of (nat1) +> bool)
	inv_TSet(s) ==
(s <> {})\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 18:22\<close>
definition
	inv_TSet :: \<open>TSet \<Rightarrow> bool\<close>
where
	\<open>inv_TSet s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TSet` specification.\<close>
		(((inv_VDMSet' (inv_VDMNat1) s)))  \<and> 
		\<comment>\<open>User defined body of inv_TSet.\<close>
		(s \<noteq> {})\<close>
 
\<comment>\<open>VDM source: eq_TSet: (set of (nat1) * set of (nat1) +> bool)
	eq_TSet(s1, s2) ==
(s1 subset s2)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 19:9\<close>
definition
	eq_TSet :: \<open>TSet \<Rightarrow> TSet \<Rightarrow> bool\<close>
where
	\<open>eq_TSet s1   s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TSet` specification.\<close>
		((inv_TSet s1)  \<and>  (inv_TSet s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSet.\<close>
		(s1 \<subseteq> s2)\<close>
 
\<comment>\<open>VDM source: ord_TSet: (set of (nat1) * set of (nat1) +> bool)
	ord_TSet(s1, s2) ==
((card s1) < (card s2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 20:9\<close>
definition
	ord_TSet :: \<open>TSet \<Rightarrow> TSet \<Rightarrow> bool\<close>
where
	\<open>ord_TSet s1   s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TSet` specification.\<close>
		((inv_TSet s1)  \<and>  (inv_TSet s2))  \<and> 
		\<comment>\<open>User defined body of ord_TSet.\<close>
		((vdm_card s1) < (vdm_card s2))\<close>
 
\<comment>\<open>VDM source: min_TSet: (TSet * TSet +> TSet)
	min_TSet(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 20:9\<close>
definition
	min_TSet :: \<open>TSet \<Rightarrow> TSet \<Rightarrow> TSet\<close>
where
	\<open>min_TSet a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TSet` specification.\<close>
		(if ((inv_TSet a)  \<and>  (inv_TSet b)) then
			
		\<comment>\<open>User defined body of min_TSet.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TSet` call\<close>
	(ord_TSet a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TSet` call\<close>
	(eq_TSet a  b))) then
		(a)
		else
		(b))
			else
			undefined)\<close>

	
\<comment>\<open>VDM source: max_TSet: (TSet * TSet +> TSet)
	max_TSet(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 20:9\<close>
definition
	max_TSet :: \<open>TSet \<Rightarrow> TSet \<Rightarrow> TSet\<close>
where
	\<open>max_TSet a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TSet` specification.\<close>
		(if ((inv_TSet a)  \<and>  (inv_TSet b)) then
			
		\<comment>\<open>User defined body of max_TSet.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TSet` call\<close>
	(ord_TSet a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TSet` call\<close>
	(eq_TSet a  b))) then
		(b)
		else
		(a))
			else
			undefined)\<close>

	
lemmas inv_TSet_defs = inv_TSet_def inv_VDMNat1_def inv_VDMSet'_def inv_VDMSet'_defs 


\<comment>\<open>VDM source: TSet2 = TSet
	inv s == ((card s) > 10)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 23:5\<close>
type_synonym TSet2 = \<open>TSet\<close>
	
\<comment>\<open>VDM source: inv_TSet2: (TSet +> bool)
	inv_TSet2(s) ==
((card s) > 10)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 24:21\<close>
definition
	inv_TSet2 :: \<open>TSet2 \<Rightarrow> bool\<close>
where
	\<open>inv_TSet2 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TSet2` specification.\<close>
		((inv_TSet s))  \<and> 
		\<comment>\<open>User defined body of inv_TSet2.\<close>
		((vdm_card s) > (10::VDMNat1))\<close>

		 
lemmas inv_TSet2_defs = inv_TSet_def inv_TSet2_def inv_VDMNat1_def inv_VDMSet'_def inv_VDMSet'_defs 


\<comment>\<open>VDM source: TSet3 = set of (TSet)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 26:5\<close>
type_synonym TSet3 = \<open>TSet VDMSet\<close>
	
\<comment>\<open>VDM source: inv_TSet3: (TSet3 +> bool)
	inv_TSet3(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 26:5\<close>
definition
	inv_TSet3 :: \<open>TSet3 \<Rightarrow> bool\<close>
where
	\<open>inv_TSet3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TSet3` specification.\<close>
		(((inv_VDMSet' inv_TSet dummy0)))\<close>

		 
lemmas inv_TSet3_defs = inv_TSet_def inv_TSet3_def inv_VDMNat1_def inv_VDMSet'_def inv_VDMSet'_defs 


\<comment>\<open>VDM source: TSet4 = set of (TSet3)
	inv s == ((card s) > 20)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 28:5\<close>
type_synonym TSet4 = \<open>TSet3 VDMSet\<close>
	
\<comment>\<open>VDM source: inv_TSet4: (set of (TSet3) +> bool)
	inv_TSet4(s) ==
((card s) > 20)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 29:21\<close>
definition
	inv_TSet4 :: \<open>TSet4 \<Rightarrow> bool\<close>
where
	\<open>inv_TSet4 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TSet4` specification.\<close>
		(((inv_VDMSet' inv_TSet3 s)))  \<and> 
		\<comment>\<open>User defined body of inv_TSet4.\<close>
		((vdm_card s) > (20::VDMNat1))\<close>

		 
lemmas inv_TSet4_defs = inv_TSet_def inv_TSet3_def inv_TSet4_def inv_VDMNat1_def inv_VDMSet'_def inv_VDMSet'_defs 


\<comment>\<open>VDM source: TSeq = seq1 of (nat1)
	inv s == ((card (elems s)) = (len s))
	eq s1 = s2 == ((elems s1) = (elems s2))
	ord s1 < s2 == ((len s1) < (len s2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 31:5\<close>
type_synonym TSeq = \<open>VDMNat1 VDMSeq1\<close>
	
\<comment>\<open>VDM source: inv_TSeq: (seq1 of (nat1) +> bool)
	inv_TSeq(s) ==
((card (elems s)) = (len s))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 32:33\<close>
definition
	inv_TSeq :: \<open>TSeq \<Rightarrow> bool\<close>
where
	\<open>inv_TSeq s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TSeq` specification.\<close>
		(((inv_VDMSeq1' (inv_VDMNat1) s)))  \<and> 
		\<comment>\<open>User defined body of inv_TSeq.\<close>
		((vdm_card (elems s)) = (len s))\<close>

		 
\<comment>\<open>VDM source: eq_TSeq: (seq1 of (nat1) * seq1 of (nat1) +> bool)
	eq_TSeq(s1, s2) ==
((elems s1) = (elems s2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 33:9\<close>
definition
	eq_TSeq :: \<open>TSeq \<Rightarrow> TSeq \<Rightarrow> bool\<close>
where
	\<open>eq_TSeq s1   s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TSeq` specification.\<close>
		((inv_TSeq s1)  \<and>  (inv_TSeq s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSeq.\<close>
		((elems s1) = (elems s2))\<close>

		 
\<comment>\<open>VDM source: ord_TSeq: (seq1 of (nat1) * seq1 of (nat1) +> bool)
	ord_TSeq(s1, s2) ==
((len s1) < (len s2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 34:9\<close>
definition
	ord_TSeq :: \<open>TSeq \<Rightarrow> TSeq \<Rightarrow> bool\<close>
where
	\<open>ord_TSeq s1   s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TSeq` specification.\<close>
		((inv_TSeq s1)  \<and>  (inv_TSeq s2))  \<and> 
		\<comment>\<open>User defined body of ord_TSeq.\<close>
		((len s1) < (len s2))\<close>

		 
\<comment>\<open>VDM source: min_TSeq: (TSeq * TSeq +> TSeq)
	min_TSeq(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 34:9\<close>
definition
	min_TSeq :: \<open>TSeq \<Rightarrow> TSeq \<Rightarrow> TSeq\<close>
where
	\<open>min_TSeq a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TSeq` specification.\<close>
		(if ((inv_TSeq a)  \<and>  (inv_TSeq b)) then
			
		\<comment>\<open>User defined body of min_TSeq.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TSeq` call\<close>
	(ord_TSeq a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TSeq` call\<close>
	(eq_TSeq a  b))) then
		(a)
		else
		(b))
			else
			undefined)\<close>

	
\<comment>\<open>VDM source: max_TSeq: (TSeq * TSeq +> TSeq)
	max_TSeq(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 34:9\<close>
definition
	max_TSeq :: \<open>TSeq \<Rightarrow> TSeq \<Rightarrow> TSeq\<close>
where
	\<open>max_TSeq a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TSeq` specification.\<close>
		(if ((inv_TSeq a)  \<and>  (inv_TSeq b)) then
			
		\<comment>\<open>User defined body of max_TSeq.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TSeq` call\<close>
	(ord_TSeq a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TSeq` call\<close>
	(eq_TSeq a  b))) then
		(b)
		else
		(a))
			else
			undefined)\<close>

	
lemmas inv_TSeq_defs = inv_TSeq_def inv_VDMNat1_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 



\<comment>\<open>VDM source: TSeq2 = seq1 of (TSet)
	inv s == ((card (elems s)) = (len s))
	eq s1 = s2 == ((elems s1) = (elems s2))
	ord s1 < s2 == ((len s1) < (len s2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 37:5\<close>
type_synonym TSeq2 = \<open>TSet VDMSeq1\<close>
	
\<comment>\<open>VDM source: inv_TSeq2: (seq1 of (TSet) +> bool)
	inv_TSeq2(s) ==
((card (elems s)) = (len s))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 38:33\<close>
definition
	inv_TSeq2 :: \<open>TSeq2 \<Rightarrow> bool\<close>
where
	\<open>inv_TSeq2 s \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TSeq2` specification.\<close>
		(((inv_VDMSeq1' inv_TSet s)))  \<and> 
		\<comment>\<open>User defined body of inv_TSeq2.\<close>
		((vdm_card (elems s)) = (len s))\<close>

		 
\<comment>\<open>VDM source: eq_TSeq2: (seq1 of (TSet) * seq1 of (TSet) +> bool)
	eq_TSeq2(s1, s2) ==
((elems s1) = (elems s2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 39:9\<close>
definition
	eq_TSeq2 :: \<open>TSeq2 \<Rightarrow> TSeq2 \<Rightarrow> bool\<close>
where
	\<open>eq_TSeq2 s1   s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TSeq2` specification.\<close>
		((inv_TSeq2 s1)  \<and>  (inv_TSeq2 s2))  \<and> 
		\<comment>\<open>User defined body of eq_TSeq2.\<close>
		((elems s1) = (elems s2))\<close>

		 
\<comment>\<open>VDM source: ord_TSeq2: (seq1 of (TSet) * seq1 of (TSet) +> bool)
	ord_TSeq2(s1, s2) ==
((len s1) < (len s2))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 40:9\<close>
definition
	ord_TSeq2 :: \<open>TSeq2 \<Rightarrow> TSeq2 \<Rightarrow> bool\<close>
where
	\<open>ord_TSeq2 s1   s2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TSeq2` specification.\<close>
		((inv_TSeq2 s1)  \<and>  (inv_TSeq2 s2))  \<and> 
		\<comment>\<open>User defined body of ord_TSeq2.\<close>
		((len s1) < (len s2))\<close>

		 
\<comment>\<open>VDM source: min_TSeq2: (TSeq2 * TSeq2 +> TSeq2)
	min_TSeq2(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 40:9\<close>
definition
	min_TSeq2 :: \<open>TSeq2 \<Rightarrow> TSeq2 \<Rightarrow> TSeq2\<close>
where
	\<open>min_TSeq2 a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TSeq2` specification.\<close>
		(if ((inv_TSeq2 a)  \<and>  (inv_TSeq2 b)) then
			
		\<comment>\<open>User defined body of min_TSeq2.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TSeq2` call\<close>
	(ord_TSeq2 a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TSeq2` call\<close>
	(eq_TSeq2 a  b))) then
		(a)
		else
		(b))
			else
			undefined)\<close>

	
\<comment>\<open>VDM source: max_TSeq2: (TSeq2 * TSeq2 +> TSeq2)
	max_TSeq2(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 40:9\<close>
definition
	max_TSeq2 :: \<open>TSeq2 \<Rightarrow> TSeq2 \<Rightarrow> TSeq2\<close>
where
	\<open>max_TSeq2 a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TSeq2` specification.\<close>
		(if ((inv_TSeq2 a)  \<and>  (inv_TSeq2 b)) then
			
		\<comment>\<open>User defined body of max_TSeq2.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TSeq2` call\<close>
	(ord_TSeq2 a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TSeq2` call\<close>
	(eq_TSeq2 a  b))) then
		(b)
		else
		(a))
			else
			undefined)\<close>

	
lemmas inv_TSeq2_defs = inv_TSeq2_def inv_TSet_def inv_VDMNat1_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs 



\<comment>\<open>VDM source: TMap = map (nat1) to (nat1)
	inv m == ((dom m) <> {})
	eq m1 = m2 == (((dom m1) = (dom m2)) and (forall x in set (dom m1) & (m1(x) = m2(x))))
	ord m1 < m2 == (((dom m1) subset (dom m2)) or (((dom m1) = (dom m2)) and (forall x in set (dom m1) & (m1(x) < m2(x)))))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 43:5\<close>
type_synonym TMap = \<open>(VDMNat1 \<rightharpoonup> VDMNat1)\<close>
	
\<comment>\<open>VDM source: inv_TMap: (map (nat1) to (nat1) +> bool)
	inv_TMap(m) ==
((dom m) <> {})\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 44:20\<close>
definition
	inv_TMap :: \<open>TMap \<Rightarrow> bool\<close>
where
	\<open>inv_TMap m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TMap` specification.\<close>
		(((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m)))  \<and> 
		\<comment>\<open>User defined body of inv_TMap.\<close>
		((dom m) \<noteq> {})\<close>

		 
\<comment>\<open>VDM source: eq_TMap: (map (nat1) to (nat1) * map (nat1) to (nat1) +> bool)
	eq_TMap(m1, m2) ==
(((dom m1) = (dom m2)) and (forall x in set (dom m1) & (m1(x) = m2(x))))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 45:8\<close>
definition
	eq_TMap :: \<open>TMap \<Rightarrow> TMap \<Rightarrow> bool\<close>
where
	\<open>eq_TMap m1   m2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TMap` specification.\<close>
		((inv_TMap m1)  \<and>  (inv_TMap m2))  \<and> 
		\<comment>\<open>User defined body of eq_TMap.\<close>
		(((dom m1) = (dom m2)) \<and> (\<forall> x \<in> (dom m1)  . (((the(m1 x))) = ((the(m2 x))))))\<close>

		 
\<comment>\<open>VDM source: ord_TMap: (map (nat1) to (nat1) * map (nat1) to (nat1) +> bool)
	ord_TMap(m1, m2) ==
(((dom m1) subset (dom m2)) or (((dom m1) = (dom m2)) and (forall x in set (dom m1) & (m1(x) < m2(x)))))\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 46:9\<close>
definition
	ord_TMap :: \<open>TMap \<Rightarrow> TMap \<Rightarrow> bool\<close>
where
	\<open>ord_TMap m1   m2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TMap` specification.\<close>
		((inv_TMap m1)  \<and>  (inv_TMap m2))  \<and> 
		\<comment>\<open>User defined body of ord_TMap.\<close>
		(((dom m1) \<subseteq> (dom m2)) \<or> (((dom m1) = (dom m2)) \<and> (\<forall> x \<in> (dom m1)  . (((the(m1 x))) < ((the(m2 x)))))))\<close>

		 
\<comment>\<open>VDM source: min_TMap: (TMap * TMap +> TMap)
	min_TMap(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 46:9\<close>
definition
	min_TMap :: \<open>TMap \<Rightarrow> TMap \<Rightarrow> TMap\<close>
where
	\<open>min_TMap a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TMap` specification.\<close>
		(if ((inv_TMap a)  \<and>  (inv_TMap b)) then
			
		\<comment>\<open>User defined body of min_TMap.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TMap` call\<close>
	(ord_TMap a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TMap` call\<close>
	(eq_TMap a  b))) then
		(a)
		else
		(b))
			else
			undefined)\<close>

	
\<comment>\<open>VDM source: max_TMap: (TMap * TMap +> TMap)
	max_TMap(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 46:9\<close>
definition
	max_TMap :: \<open>TMap \<Rightarrow> TMap \<Rightarrow> TMap\<close>
where
	\<open>max_TMap a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TMap` specification.\<close>
		(if ((inv_TMap a)  \<and>  (inv_TMap b)) then
			
		\<comment>\<open>User defined body of max_TMap.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TMap` call\<close>
	(ord_TMap a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TMap` call\<close>
	(eq_TMap a  b))) then
		(b)
		else
		(a))
			else
			undefined)\<close>

	
lemmas inv_TMap_defs = inv_TMap_def inv_VDMMap_defs inv_VDMNat1_def 


\<comment>\<open>VDM source: TMap2 = map (TSet4) to (TSeq2)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 52:5\<close>
type_synonym TMap2 = \<open>(TSet4 \<rightharpoonup> TSeq2)\<close>
	
\<comment>\<open>VDM source: inv_TMap2: (TMap2 +> bool)
	inv_TMap2(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 52:5\<close>
definition
	inv_TMap2 :: \<open>TMap2 \<Rightarrow> bool\<close>
where
	\<open>inv_TMap2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TMap2` specification.\<close>
		(((inv_VDMMap inv_TSet4 inv_TSeq2 dummy0)))\<close>

		 
lemmas inv_TMap2_defs = inv_TMap2_def inv_TSeq2_def inv_TSet_def inv_TSet3_def inv_TSet4_def inv_VDMMap_defs inv_VDMNat1_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs 


\<comment>\<open>VDM source: TMap3 = map (TMap2) to (TMap)\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 54:5\<close>
type_synonym TMap3 = \<open>(TMap2 \<rightharpoonup> TMap)\<close>
	
\<comment>\<open>VDM source: inv_TMap3: (TMap3 +> bool)
	inv_TMap3(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 54:5\<close>
definition
	inv_TMap3 :: \<open>TMap3 \<Rightarrow> bool\<close>
where
	\<open>inv_TMap3 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TMap3` specification.\<close>
		(((inv_VDMMap inv_TMap2 inv_TMap dummy0)))\<close>

		 
lemmas inv_TMap3_defs = inv_TMap_def inv_TMap2_def inv_TMap3_def inv_TSeq2_def inv_TSet_def inv_TSet3_def inv_TSet4_def inv_VDMMap_defs inv_VDMNat1_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs 


 

end 