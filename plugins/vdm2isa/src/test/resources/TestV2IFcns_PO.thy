(* VDM to Isabelle Translation @2022-05-26T11:45:34.996Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 12:5
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns_PO
imports TestV2IFcns
begin


\<comment>\<open>VDM source: constS = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 12:5\<close>


definition
	PO_01_constS_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO_01_constS_FUNC_POST_CONDITION  \<equiv> ((pre_constS ) \<longrightarrow> (post_constS (10::VDMNat1)))"

	
	
	
\<comment>\<open>VDM source: g = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 22:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_02_g_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO_02_g_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat1)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_g x  y) \<longrightarrow> (post_g x  y  (x + y)))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 30:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_03_h_SUB_TYPE :: "\<bool>"
where
	"PO_03_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x > (0::VDMNat))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 28:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_04_h_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO_04_h_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (post_h x  (g x  x)))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 31:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_05_h_SUB_TYPE :: "\<bool>"
where
	"PO_05_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (
		let 
(RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(x > (0::VDMNat))
		 else
			undefined
		)
		))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 31:23\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_06_h_SUB_TYPE :: "\<bool>"
where
	"PO_06_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (
		let 
(RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(RESULT > (0::VDMNat))
		 else
			undefined
		)
		))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 29:13\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_07_h_FUNC_APPLY :: "\<bool>"
where
	"PO_07_h_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (pre_g x  x))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 29:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_08_h_SUB_TYPE :: "\<bool>"
where
	"PO_08_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (x > (0::VDMNat)))))"

	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 34:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_09_h'_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO_09_h'_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (post_h' x  (g x  x)))))"

	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 35:14\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_10_h'_FUNC_APPLY :: "\<bool>"
where
	"PO_10_h'_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (pre_g x  x))))"

	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 35:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_11_h'_SUB_TYPE :: "\<bool>"
where
	"PO_11_h'_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (x > (0::VDMNat)))))"

	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 40:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_12_h''_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO_12_h''_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (post_h'' x  (g x  x)))))"

	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 43:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_13_h''_SUB_TYPE :: "\<bool>"
where
	"PO_13_h''_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (
		let 
(RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(RESULT > (0::VDMNat))
		 else
			undefined
		)
		))))"

	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 41:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_14_h''_FUNC_APPLY :: "\<bool>"
where
	"PO_14_h''_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (pre_g x  x))))"

	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 41:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_15_h''_SUB_TYPE :: "\<bool>"
where
	"PO_15_h''_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (x > (0::VDMNat)))))"

	
	
	
\<comment>\<open>VDM source: curriedS = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 50:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_16_curriedS_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO_16_curriedS_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y))) \<longrightarrow> (((pre_curriedS x) y) \<longrightarrow> ((post_curriedS x) y  (x + y)))))"

	
	
	
\<comment>\<open>VDM source: implicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 56:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_17_implicit_TOTAL :: "\<bool>"
where
	"PO_17_implicit_TOTAL  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> isTest ((pre_implicit x  y  z)) (inv_bool)))"

	
	
	
\<comment>\<open>VDM source: implicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 55:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_18_implicit_FUNC_SATISFIABILITY :: "\<bool>"
where
	"PO_18_implicit_FUNC_SATISFIABILITY  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> ((pre_implicit x  y  z) \<longrightarrow> (\<exists> (r :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) r))) \<longrightarrow> (post_implicit x  y  z  r))))))"

	
	
	
\<comment>\<open>VDM source: implicitexplicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 61:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_19_implicitexplicit_TOTAL :: "\<bool>"
where
	"PO_19_implicitexplicit_TOTAL  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> isTest ((pre_implicitexplicit x  y  z)) (inv_bool)))"

	
	
	
\<comment>\<open>VDM source: implicitexplicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/src/test/resources/TestV2IFcns.vdmsl) at line 59:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_20_implicitexplicit_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO_20_implicitexplicit_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> ((pre_implicitexplicit x  y  z) \<longrightarrow> (post_implicitexplicit x  y  z  [x , y]))))"

	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>


locale TestV2IFcns_POG = 
	assumes
			 TestV2IFcns_PO_01: PO_01_constS_FUNC_POST_CONDITION
	 and TestV2IFcns_PO_02: PO_02_g_FUNC_POST_CONDITION
	 and TestV2IFcns_PO_03: PO_03_h_SUB_TYPE
	 and TestV2IFcns_PO_04: PO_04_h_FUNC_POST_CONDITION
	 and TestV2IFcns_PO_05: PO_05_h_SUB_TYPE
	 and TestV2IFcns_PO_06: PO_06_h_SUB_TYPE
	 and TestV2IFcns_PO_07: PO_07_h_FUNC_APPLY
	 and TestV2IFcns_PO_08: PO_08_h_SUB_TYPE
	 and TestV2IFcns_PO_09: PO_09_h'_FUNC_POST_CONDITION
	 and TestV2IFcns_PO_10: PO_10_h'_FUNC_APPLY
	 and TestV2IFcns_PO_11: PO_11_h'_SUB_TYPE
	 and TestV2IFcns_PO_12: PO_12_h''_FUNC_POST_CONDITION
	 and TestV2IFcns_PO_13: PO_13_h''_SUB_TYPE
	 and TestV2IFcns_PO_14: PO_14_h''_FUNC_APPLY
	 and TestV2IFcns_PO_15: PO_15_h''_SUB_TYPE
	 and TestV2IFcns_PO_16: PO_16_curriedS_FUNC_POST_CONDITION
	 and TestV2IFcns_PO_17: PO_17_implicit_TOTAL
	 and TestV2IFcns_PO_18: PO_18_implicit_FUNC_SATISFIABILITY
	 and TestV2IFcns_PO_19: PO_19_implicitexplicit_TOTAL
	 and TestV2IFcns_PO_20: PO_20_implicitexplicit_FUNC_POST_CONDITION
begin
	\<comment>\<open>User defined lemmas for TestV2IFcns POs\<close>
end


lemma TestV2IFcns_POG_l1[simp]: \<open>PO_01_constS_FUNC_POST_CONDITION\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 by (simp add: PO_01_constS_FUNC_POST_CONDITION_def inv_VDMNat_def post_constS_def)	

lemma TestV2IFcns_POG_l2[simp]: \<open>PO_02_g_FUNC_POST_CONDITION\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 using PO_02_g_FUNC_POST_CONDITION_def inv_VDMNat1_def inv_VDMNat_def post_g_def by force
	

lemma TestV2IFcns_POG_l3[simp]: \<open>PO_03_h_SUB_TYPE\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l4[simp]: \<open>PO_04_h_FUNC_POST_CONDITION\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 by (smt (verit, ccfv_SIG) PO_02_g_FUNC_POST_CONDITION_def PO_04_h_FUNC_POST_CONDITION_def TestV2IFcns_POG_l2 g_def inv_VDMNat_def post_h_def pre_g_def pre_h_def)
		

lemma TestV2IFcns_POG_l5[simp]: \<open>PO_05_h_SUB_TYPE\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 by (simp add: PO_05_h_SUB_TYPE_def g_def inv_VDMNat_def pre_g_def pre_h_def)
	
lemma TestV2IFcns_POG_l6[simp]: \<open>PO_06_h_SUB_TYPE\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 using PO_05_h_SUB_TYPE_def PO_06_h_SUB_TYPE_def g_def by fastforce
	

lemma TestV2IFcns_POG_l7[simp]: \<open>PO_07_h_FUNC_APPLY\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 using PO_07_h_FUNC_APPLY_def pre_h_def by blast	

lemma TestV2IFcns_POG_l8[simp]: \<open>PO_08_h_SUB_TYPE\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 using PO_08_h_SUB_TYPE_def pre_g_def pre_h_def by force	

lemma TestV2IFcns_POG_l9[simp]: \<open>PO_09_h'_FUNC_POST_CONDITION\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l10[simp]: \<open>PO_10_h'_FUNC_APPLY\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l11[simp]: \<open>PO_11_h'_SUB_TYPE\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l12[simp]: \<open>PO_12_h''_FUNC_POST_CONDITION\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l13[simp]: \<open>PO_13_h''_SUB_TYPE\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l14[simp]: \<open>PO_14_h''_FUNC_APPLY\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l15[simp]: \<open>PO_15_h''_SUB_TYPE\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l16[simp]: \<open>PO_16_curriedS_FUNC_POST_CONDITION\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	nitpick
	
	
	oops
	

lemma TestV2IFcns_POG_l17[simp]: \<open>PO_17_implicit_TOTAL\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 by (simp add: PO_17_implicit_TOTAL_def)
	
named_theorems Fcns_defs and Fcns_PO_defs 

lemmas [Fcns_PO_defs] = PO_18_implicit_FUNC_SATISFIABILITY_def
lemmas [Fcns_defs] = post_implicit_def pre_implicit_def Fcns_PO_defs

lemma TestV2IFcns_POG_l18[simp]: \<open>PO_18_implicit_FUNC_SATISFIABILITY\<close> 
  apply (simp add: Fcns_PO_defs, safe?)+
  apply (simp add: Fcns_defs, safe?)+
  apply (simp add: VDM_seq_defs, safe?)+
  apply (simp add: VDM_set_defs, safe?)+
  apply (simp add: VDM_basic_defs, safe?)+
  apply (metis diff_ge_0_iff_ge inv_VDMNat_def inv_VDMSeq'_defs(2) l_inv_SeqElems_append not_one_le_zero)
  oops

lemma TestV2IFcns_POG_l18[simp]: \<open>PO_18_implicit_FUNC_SATISFIABILITY\<close> 
  apply (simp add: VDM_basic_defs VDM_set_defs VDM_seq_defs Fcns_defs, safe?)+
  by (metis diff_ge_0_iff_ge inv_VDMNat_def inv_VDMSeq'_defs(2) l_inv_SeqElems_append not_one_le_zero)

lemma TestV2IFcns_POG_l18[simp]: \<open>PO_18_implicit_FUNC_SATISFIABILITY\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close> 
	unfolding PO_18_implicit_FUNC_SATISFIABILITY_def
  apply (safe?, simp?)
  unfolding post_implicit_def pre_implicit_def
  apply (safe?, simp?)
  unfolding inv_VDMSeq'_def inv_SeqElems_def 
  apply (safe?, simp?)
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_SetElems_def
  apply (safe?, simp?)
  unfolding inv_VDMNat_def
  by (metis diff_ge_0_iff_ge inv_VDMSeq'_defs(2) l_inv_SeqElems_append not_one_le_zero)

lemma TestV2IFcns_POG_l19[simp]: \<open>PO_19_implicitexplicit_TOTAL\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	 by (simp add: PO_19_implicitexplicit_TOTAL_def)
	

lemma TestV2IFcns_POG_l20[simp]: \<open>PO_20_implicitexplicit_FUNC_POST_CONDITION\<close> 
	 \<comment>\<open>Inferred proof strategy for lemma:\<close>
	unfolding PO_20_implicitexplicit_FUNC_POST_CONDITION_def
  apply (safe?, simp?)
  unfolding post_implicitexplicit_def pre_implicitexplicit_def
  apply (safe?, simp?)
  unfolding inv_VDMSeq'_def inv_SeqElems_def 
  apply (safe?, simp?)
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_SetElems_def
  apply (safe?, simp?)
  unfolding inv_VDMNat_def
  oops
	

interpretation TestV2IFcns_POG 
	 	apply unfold_locales
	apply simp_all
  oops
end