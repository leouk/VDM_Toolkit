(* VDM to Isabelle Translation @2022-12-27T12:31:49.995Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesOrdering
   in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl' at line 1:8
   files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl]
*)
theory TestV2ITypesOrdering
imports VDMToolkit 
begin

\<comment>\<open>VDM source: TOrder1 = nat1
	inv oI == (oI > 1)
	eq o1 = o2 == (o1 = o2)
	ord o1 < o2 == (o1 > o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 7:5\<close>
type_synonym TOrder1 = \<open>VDMNat1\<close>
	
\<comment>\<open>VDM source: inv_TOrder1: (nat1 +> bool)
	inv_TOrder1(oI) ==
(oI > 1)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 8:18\<close>
definition
	inv_TOrder1 :: \<open>TOrder1 \<Rightarrow> bool\<close>
where
	\<open>inv_TOrder1 oI \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TOrder1` specification.\<close>
		(((inv_VDMNat1 oI)))  \<and> 
		\<comment>\<open>User defined body of inv_TOrder1.\<close>
		(oI > (1::VDMNat1))\<close>
 
\<comment>\<open>VDM source: eq_TOrder1: (nat1 * nat1 +> bool)
	eq_TOrder1(o1, o2) ==
(o1 = o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 9:8\<close>
definition
	eq_TOrder1 :: \<open>TOrder1 \<Rightarrow> TOrder1 \<Rightarrow> bool\<close>
where
	\<open>eq_TOrder1 o1   o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TOrder1` specification.\<close>
		((inv_TOrder1 o1)  \<and>  (inv_TOrder1 o2))  \<and> 
		\<comment>\<open>User defined body of eq_TOrder1.\<close>
		(o1 = o2)\<close>
 
\<comment>\<open>VDM source: ord_TOrder1: (nat1 * nat1 +> bool)
	ord_TOrder1(o1, o2) ==
(o1 > o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 10:9\<close>
definition
	ord_TOrder1 :: \<open>TOrder1 \<Rightarrow> TOrder1 \<Rightarrow> bool\<close>
where
	\<open>ord_TOrder1 o1   o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TOrder1` specification.\<close>
		((inv_TOrder1 o1)  \<and>  (inv_TOrder1 o2))  \<and> 
		\<comment>\<open>User defined body of ord_TOrder1.\<close>
		(o1 > o2)\<close>
 
\<comment>\<open>VDM source: min_TOrder1: (TOrder1 * TOrder1 +> TOrder1)
	min_TOrder1(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 10:9\<close>
definition
	min_TOrder1 :: \<open>TOrder1 \<Rightarrow> TOrder1 \<Rightarrow> TOrder1\<close>
where
	\<open>min_TOrder1 a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TOrder1` specification.\<close>
		(if ((inv_TOrder1 a)  \<and>  (inv_TOrder1 b)) then
			
		\<comment>\<open>User defined body of min_TOrder1.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TOrder1` call\<close>
	(ord_TOrder1 a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TOrder1` call\<close>
	(eq_TOrder1 a  b))) then
		(a)
		else
		(b))
			else
			undefined)\<close>

	
\<comment>\<open>VDM source: max_TOrder1: (TOrder1 * TOrder1 +> TOrder1)
	max_TOrder1(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 10:9\<close>
definition
	max_TOrder1 :: \<open>TOrder1 \<Rightarrow> TOrder1 \<Rightarrow> TOrder1\<close>
where
	\<open>max_TOrder1 a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TOrder1` specification.\<close>
		(if ((inv_TOrder1 a)  \<and>  (inv_TOrder1 b)) then
			
		\<comment>\<open>User defined body of max_TOrder1.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TOrder1` call\<close>
	(ord_TOrder1 a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TOrder1` call\<close>
	(eq_TOrder1 a  b))) then
		(b)
		else
		(a))
			else
			undefined)\<close>

	
lemmas inv_TOrder1_defs = inv_TOrder1_def inv_VDMNat1_def 


\<comment>\<open>VDM source: TRenamed = TOrder1
	inv r == (r > 10)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 13:5\<close>
type_synonym TRenamed = \<open>TOrder1\<close>
	
\<comment>\<open>VDM source: inv_TRenamed: (TOrder1 +> bool)
	inv_TRenamed(r) ==
(r > 10)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 14:16\<close>
definition
	inv_TRenamed :: \<open>TRenamed \<Rightarrow> bool\<close>
where
	\<open>inv_TRenamed r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TRenamed` specification.\<close>
		((inv_TOrder1 r))  \<and> 
		\<comment>\<open>User defined body of inv_TRenamed.\<close>
		\<comment>\<open>Transform a VDM `>` expression into a reversed `ord_TOrder1` call\<close>
	(ord_TOrder1 (10::VDMNat1)  r)\<close>

		 
lemmas inv_TRenamed_defs = inv_TOrder1_def inv_TRenamed_def inv_VDMNat1_def 


\<comment>\<open>VDM source: TRenamedOrdered = TOrder1
	eq o1 = o2 == (o1 = o2)
	ord o1 < o2 == (o1 < o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 16:5\<close>
type_synonym TRenamedOrdered = \<open>TOrder1\<close>
	
\<comment>\<open>VDM source: inv_TRenamedOrdered: (TRenamedOrdered +> bool)
	inv_TRenamedOrdered(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 16:5\<close>
definition
	inv_TRenamedOrdered :: \<open>TRenamedOrdered \<Rightarrow> bool\<close>
where
	\<open>inv_TRenamedOrdered dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TRenamedOrdered` specification.\<close>
		((inv_TOrder1 dummy0))\<close>

		 
\<comment>\<open>VDM source: eq_TRenamedOrdered: (TOrder1 * TOrder1 +> bool)
	eq_TRenamedOrdered(o1, o2) ==
(o1 = o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 17:8\<close>
definition
	eq_TRenamedOrdered :: \<open>TRenamedOrdered \<Rightarrow> TRenamedOrdered \<Rightarrow> bool\<close>
where
	\<open>eq_TRenamedOrdered o1   o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TRenamedOrdered` specification.\<close>
		((inv_TRenamedOrdered o1)  \<and>  (inv_TRenamedOrdered o2))  \<and> 
		\<comment>\<open>User defined body of eq_TRenamedOrdered.\<close>
		\<comment>\<open>Transform a VDM `=` expression into an `eq_TOrder1` call\<close>
	(eq_TOrder1 o1  o2)\<close>

		 
\<comment>\<open>VDM source: ord_TRenamedOrdered: (TOrder1 * TOrder1 +> bool)
	ord_TRenamedOrdered(o1, o2) ==
(o1 < o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 18:9\<close>
definition
	ord_TRenamedOrdered :: \<open>TRenamedOrdered \<Rightarrow> TRenamedOrdered \<Rightarrow> bool\<close>
where
	\<open>ord_TRenamedOrdered o1   o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TRenamedOrdered` specification.\<close>
		((inv_TRenamedOrdered o1)  \<and>  (inv_TRenamedOrdered o2))  \<and> 
		\<comment>\<open>User defined body of ord_TRenamedOrdered.\<close>
		\<comment>\<open>Transform a VDM `<` expression into an `ord_TOrder1` call\<close>
	(ord_TOrder1 o1  o2)\<close>

		 
\<comment>\<open>VDM source: min_TRenamedOrdered: (TRenamedOrdered * TRenamedOrdered +> TRenamedOrdered)
	min_TRenamedOrdered(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 18:9\<close>
definition
	min_TRenamedOrdered :: \<open>TRenamedOrdered \<Rightarrow> TRenamedOrdered \<Rightarrow> TRenamedOrdered\<close>
where
	\<open>min_TRenamedOrdered a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TRenamedOrdered` specification.\<close>
		(if ((inv_TRenamedOrdered a)  \<and>  (inv_TRenamedOrdered b)) then
			
		\<comment>\<open>User defined body of min_TRenamedOrdered.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TRenamedOrdered` call\<close>
	(ord_TRenamedOrdered a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TRenamedOrdered` call\<close>
	(eq_TRenamedOrdered a  b))) then
		(a)
		else
		(b))
			else
			undefined)\<close>

	
\<comment>\<open>VDM source: max_TRenamedOrdered: (TRenamedOrdered * TRenamedOrdered +> TRenamedOrdered)
	max_TRenamedOrdered(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 18:9\<close>
definition
	max_TRenamedOrdered :: \<open>TRenamedOrdered \<Rightarrow> TRenamedOrdered \<Rightarrow> TRenamedOrdered\<close>
where
	\<open>max_TRenamedOrdered a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TRenamedOrdered` specification.\<close>
		(if ((inv_TRenamedOrdered a)  \<and>  (inv_TRenamedOrdered b)) then
			
		\<comment>\<open>User defined body of max_TRenamedOrdered.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TRenamedOrdered` call\<close>
	(ord_TRenamedOrdered a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TRenamedOrdered` call\<close>
	(eq_TRenamedOrdered a  b))) then
		(b)
		else
		(a))
			else
			undefined)\<close>

	
lemmas inv_TRenamedOrdered_defs = inv_TOrder1_def inv_TRenamedOrdered_def inv_VDMNat1_def 


\<comment>\<open>VDM source: TRenamedPOrdered = TOrder1
	eq o1 = o2 == (o1 = o2)
	ord o1 < o2 == (o1 > o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 21:5\<close>
type_synonym TRenamedPOrdered = \<open>TOrder1\<close>
	
\<comment>\<open>VDM source: inv_TRenamedPOrdered: (TRenamedPOrdered +> bool)
	inv_TRenamedPOrdered(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 21:5\<close>
definition
	inv_TRenamedPOrdered :: \<open>TRenamedPOrdered \<Rightarrow> bool\<close>
where
	\<open>inv_TRenamedPOrdered dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TRenamedPOrdered` specification.\<close>
		((inv_TOrder1 dummy0))\<close>

		 
\<comment>\<open>VDM source: eq_TRenamedPOrdered: (TOrder1 * TOrder1 +> bool)
	eq_TRenamedPOrdered(o1, o2) ==
(o1 = o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 22:8\<close>
definition
	eq_TRenamedPOrdered :: \<open>TRenamedPOrdered \<Rightarrow> TRenamedPOrdered \<Rightarrow> bool\<close>
where
	\<open>eq_TRenamedPOrdered o1   o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_TRenamedPOrdered` specification.\<close>
		((inv_TRenamedPOrdered o1)  \<and>  (inv_TRenamedPOrdered o2))  \<and> 
		\<comment>\<open>User defined body of eq_TRenamedPOrdered.\<close>
		\<comment>\<open>Transform a VDM `=` expression into an `eq_TOrder1` call\<close>
	(eq_TOrder1 o1  o2)\<close>

		 
\<comment>\<open>VDM source: ord_TRenamedPOrdered: (TOrder1 * TOrder1 +> bool)
	ord_TRenamedPOrdered(o1, o2) ==
(o1 > o2)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 23:9\<close>
definition
	ord_TRenamedPOrdered :: \<open>TRenamedPOrdered \<Rightarrow> TRenamedPOrdered \<Rightarrow> bool\<close>
where
	\<open>ord_TRenamedPOrdered o1   o2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_TRenamedPOrdered` specification.\<close>
		((inv_TRenamedPOrdered o1)  \<and>  (inv_TRenamedPOrdered o2))  \<and> 
		\<comment>\<open>User defined body of ord_TRenamedPOrdered.\<close>
		\<comment>\<open>Transform a VDM `>` expression into a reversed `ord_TOrder1` call\<close>
	(ord_TOrder1 o2  o1)\<close>

		 
\<comment>\<open>VDM source: min_TRenamedPOrdered: (TRenamedPOrdered * TRenamedPOrdered +> TRenamedPOrdered)
	min_TRenamedPOrdered(a, b) ==
(if ((a < b) or (a = b))
then a
else b)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 23:9\<close>
definition
	min_TRenamedPOrdered :: \<open>TRenamedPOrdered \<Rightarrow> TRenamedPOrdered \<Rightarrow> TRenamedPOrdered\<close>
where
	\<open>min_TRenamedPOrdered a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `min_TRenamedPOrdered` specification.\<close>
		(if ((inv_TRenamedPOrdered a)  \<and>  (inv_TRenamedPOrdered b)) then
			
		\<comment>\<open>User defined body of min_TRenamedPOrdered.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TRenamedPOrdered` call\<close>
	(ord_TRenamedPOrdered a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TRenamedPOrdered` call\<close>
	(eq_TRenamedPOrdered a  b))) then
		(a)
		else
		(b))
			else
			undefined)\<close>

	
\<comment>\<open>VDM source: max_TRenamedPOrdered: (TRenamedPOrdered * TRenamedPOrdered +> TRenamedPOrdered)
	max_TRenamedPOrdered(a, b) ==
(if ((a < b) or (a = b))
then b
else a)\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesOrdering.vdmsl) at line 23:9\<close>
definition
	max_TRenamedPOrdered :: \<open>TRenamedPOrdered \<Rightarrow> TRenamedPOrdered \<Rightarrow> TRenamedPOrdered\<close>
where
	\<open>max_TRenamedPOrdered a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `max_TRenamedPOrdered` specification.\<close>
		(if ((inv_TRenamedPOrdered a)  \<and>  (inv_TRenamedPOrdered b)) then
			
		\<comment>\<open>User defined body of max_TRenamedPOrdered.\<close>
		(
		if ((\<comment>\<open>Transform a VDM `<` expression into an `ord_TRenamedPOrdered` call\<close>
	(ord_TRenamedPOrdered a  b) \<or> \<comment>\<open>Transform a VDM `=` expression into an `eq_TRenamedPOrdered` call\<close>
	(eq_TRenamedPOrdered a  b))) then
		(b)
		else
		(a))
			else
			undefined)\<close>

	
lemmas inv_TRenamedPOrdered_defs = inv_TOrder1_def inv_TRenamedPOrdered_def inv_VDMNat1_def 


 

end 