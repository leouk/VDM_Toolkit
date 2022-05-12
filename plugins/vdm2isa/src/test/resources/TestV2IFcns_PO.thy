(* VDM to Isabelle Translation @2022-05-06T12:42:52.475Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 24:5
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns_PO
imports TestV2IFcns
begin


\<comment>\<open>VDM source: g = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 24:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO1_g_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO1_g_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat1)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_g x  y) \<longrightarrow> (post_g x  y  (x + y)))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 32:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO2_h_SUB_TYPE :: "\<bool>"
where
	"PO2_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x > (0::VDMNat))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 30:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO3_h_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO3_h_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (post_h x  (g x  x)))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 33:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO4_h_SUB_TYPE :: "\<bool>"
where
	"PO4_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_g x  x) \<longrightarrow> (
		let 
(RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(x > (0::VDMNat))
		 else
			undefined
		)
		))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 33:23\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO5_h_SUB_TYPE :: "\<bool>"
where
	"PO5_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_g x  x) \<longrightarrow> (
		let 
(RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(RESULT > (0::VDMNat))
		 else
			undefined
		)
		))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 31:13\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO6_h_FUNC_APPLY :: "\<bool>"
where
	"PO6_h_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_g x  x) \<longrightarrow> (pre_g x  x))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 31:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO7_h_SUB_TYPE :: "\<bool>"
where
	"PO7_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_g x  x) \<longrightarrow> (x > (0::VDMNat)))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 36:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO8_h'_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO8_h'_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (post_h' x  (g x  x)))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 37:14\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO9_h'_FUNC_APPLY :: "\<bool>"
where
	"PO9_h'_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (pre_g x  x))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 37:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO10_h'_SUB_TYPE :: "\<bool>"
where
	"PO10_h'_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat)))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 42:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO11_h''_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO11_h''_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (post_h'' x  (g x  x)))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 45:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO12_h''_SUB_TYPE :: "\<bool>"
where
	"PO12_h''_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (
		let 
(RESULT::VDMNat) = (g x  x)
		in
			
			(if ((inv_VDMNat RESULT)) then
			(RESULT > (0::VDMNat))
		 else
			undefined
		)
		))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 43:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO13_h''_FUNC_APPLY :: "\<bool>"
where
	"PO13_h''_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (pre_g x  x))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 43:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO14_h''_SUB_TYPE :: "\<bool>"
where
	"PO14_h''_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat)))))"

	\<comment>\<open>Inferred proof strategy for lemma:
\<close>\<comment>\<open>try
	
	
	oops
	\<close>
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>


locale TestV2IFcns_POG = 
	assumes
			 TestV2IFcns_PO1: PO10_h'_SUB_TYPE
	 and TestV2IFcns_PO2: PO11_h''_FUNC_POST_CONDITION
	 and TestV2IFcns_PO3: PO12_h''_SUB_TYPE
	 and TestV2IFcns_PO4: PO13_h''_FUNC_APPLY
	 and TestV2IFcns_PO5: PO14_h''_SUB_TYPE
	 and TestV2IFcns_PO6: PO1_g_FUNC_POST_CONDITION
	 and TestV2IFcns_PO7: PO2_h_SUB_TYPE
	 and TestV2IFcns_PO8: PO3_h_FUNC_POST_CONDITION
	 and TestV2IFcns_PO9: PO4_h_SUB_TYPE
	 and TestV2IFcns_PO10: PO5_h_SUB_TYPE
	 and TestV2IFcns_PO11: PO6_h_FUNC_APPLY
	 and TestV2IFcns_PO12: PO7_h_SUB_TYPE
	 and TestV2IFcns_PO13: PO8_h'_FUNC_POST_CONDITION
	 and TestV2IFcns_PO14: PO9_h'_FUNC_APPLY
begin
	\<comment>\<open>User defined lemmas for TestV2IFcns POs\<close>
end


lemma TestV2IFcns_POG_l1[simp]: \<open>PO10_h'_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l2[simp]: \<open>PO11_h''_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l3[simp]: \<open>PO12_h''_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l4[simp]: \<open>PO13_h''_FUNC_APPLY\<close> 
	 sorry

lemma TestV2IFcns_POG_l5[simp]: \<open>PO14_h''_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l6[simp]: \<open>PO1_g_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l7[simp]: \<open>PO2_h_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l8[simp]: \<open>PO3_h_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l9[simp]: \<open>PO4_h_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l10[simp]: \<open>PO5_h_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l11[simp]: \<open>PO6_h_FUNC_APPLY\<close> 
	 sorry

lemma TestV2IFcns_POG_l12[simp]: \<open>PO7_h_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l13[simp]: \<open>PO8_h'_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l14[simp]: \<open>PO9_h'_FUNC_APPLY\<close> 
	 sorry

interpretation TestV2IFcns_POG 
	 	apply unfold_locales
	by simp_all
end