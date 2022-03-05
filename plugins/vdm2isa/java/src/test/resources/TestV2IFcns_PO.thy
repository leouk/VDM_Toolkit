(* VDM to Isabelle Translation @2022-03-05T08:34:12.222Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 11:5
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns_PO
imports TestV2IFcns
begin


\<comment>\<open>VDM source: constS = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 11:5\<close>


definition
	PO1_constS_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO1_constS_FUNC_POST_CONDITION  \<equiv> ((pre_constS ) \<longrightarrow> (post_constS (10::VDMNat1)))"

	
	
	
\<comment>\<open>VDM source: g = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 21:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO2_g_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO2_g_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat1)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_g x  y) \<longrightarrow> (post_g x  y  (x + y)))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 29:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO3_h_SUB_TYPE :: "\<bool>"
where
	"PO3_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (x > (0::VDMNat))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 27:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO4_h_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO4_h_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h x) \<longrightarrow> (post_h x  (g x  x)))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 30:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO5_h_SUB_TYPE :: "\<bool>"
where
	"PO5_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (
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
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 30:23\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO6_h_SUB_TYPE :: "\<bool>"
where
	"PO6_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (
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
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 28:13\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO7_h_FUNC_APPLY :: "\<bool>"
where
	"PO7_h_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (pre_g x  x))))"

	
	
	
\<comment>\<open>VDM source: h = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 28:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO8_h_SUB_TYPE :: "\<bool>"
where
	"PO8_h_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> (((pre_g x  x) \<and> (x < (20::VDMNat1))) \<longrightarrow> (x > (0::VDMNat)))))"

	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 33:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO9_h'_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO9_h'_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h' x) \<longrightarrow> (post_h' x  (g x  x)))))"

	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 34:14\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO10_h'_FUNC_APPLY :: "\<bool>"
where
	"PO10_h'_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (pre_g x  x))))"

	
	
	
\<comment>\<open>VDM source: h' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 34:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO11_h'_SUB_TYPE :: "\<bool>"
where
	"PO11_h'_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat)))))"

	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 39:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO12_h''_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO12_h''_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((pre_h'' x) \<longrightarrow> (post_h'' x  (g x  x)))))"

	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 42:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO13_h''_SUB_TYPE :: "\<bool>"
where
	"PO13_h''_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (
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
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 40:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO14_h''_FUNC_APPLY :: "\<bool>"
where
	"PO14_h''_FUNC_APPLY  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (pre_g x  x))))"

	
	
	
\<comment>\<open>VDM source: h'' = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 40:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO15_h''_SUB_TYPE :: "\<bool>"
where
	"PO15_h''_SUB_TYPE  \<equiv> (\<forall> (x :: VDMNat)  . ((((inv_VDMNat x))) \<longrightarrow> ((x < (20::VDMNat1)) \<longrightarrow> (x > (0::VDMNat)))))"

	
	
	
\<comment>\<open>VDM source: curriedS = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 49:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO16_curriedS_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO16_curriedS_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y))) \<longrightarrow> (((pre_curriedS x) y) \<longrightarrow> ((post_curriedS x) y  (x + y)))))"

	
	
	
\<comment>\<open>VDM source: implicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 55:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO17_implicit_TOTAL :: "\<bool>"
where
	"PO17_implicit_TOTAL  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> isTest ((pre_implicit x  y  z)) (inv_bool)))"

	
	
	
\<comment>\<open>VDM source: implicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 54:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO18_implicit_FUNC_SATISFIABILITY :: "\<bool>"
where
	"PO18_implicit_FUNC_SATISFIABILITY  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> ((pre_implicit x  y  z) \<longrightarrow> (\<exists> (r :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) r))) \<longrightarrow> (post_implicit x  y  z  r))))))"

	
	
	
\<comment>\<open>VDM source: implicitexplicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 60:15\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO19_implicitexplicit_TOTAL :: "\<bool>"
where
	"PO19_implicitexplicit_TOTAL  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> isTest ((pre_implicitexplicit x  y  z)) (inv_bool)))"

	
	
	
\<comment>\<open>VDM source: implicitexplicit = ?\<close>
\<comment>\<open>in 'TestV2IFcns' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/TestV2IFcns.vdmsl) at line 58:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO20_implicitexplicit_FUNC_POST_CONDITION :: "\<bool>"
where
	"PO20_implicitexplicit_FUNC_POST_CONDITION  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat)   (z :: VDMNat VDMSet)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat y)))  \<and>  (((inv_VDMSet' (inv_VDMNat) z))) \<longrightarrow> ((pre_implicitexplicit x  y  z) \<longrightarrow> (post_implicitexplicit x  y  z  [x , y]))))"

	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>


locale TestV2IFcns_POG = 
	assumes
			 TestV2IFcns_PO1: PO10_h'_FUNC_APPLY
	 and TestV2IFcns_PO2: PO11_h'_SUB_TYPE
	 and TestV2IFcns_PO3: PO12_h''_FUNC_POST_CONDITION
	 and TestV2IFcns_PO4: PO13_h''_SUB_TYPE
	 and TestV2IFcns_PO5: PO14_h''_FUNC_APPLY
	 and TestV2IFcns_PO6: PO15_h''_SUB_TYPE
	 and TestV2IFcns_PO7: PO16_curriedS_FUNC_POST_CONDITION
	 and TestV2IFcns_PO8: PO17_implicit_TOTAL
	 and TestV2IFcns_PO9: PO18_implicit_FUNC_SATISFIABILITY
	 and TestV2IFcns_PO10: PO19_implicitexplicit_TOTAL
	 and TestV2IFcns_PO11: PO1_constS_FUNC_POST_CONDITION
	 and TestV2IFcns_PO12: PO20_implicitexplicit_FUNC_POST_CONDITION
	 and TestV2IFcns_PO13: PO2_g_FUNC_POST_CONDITION
	 and TestV2IFcns_PO14: PO3_h_SUB_TYPE
	 and TestV2IFcns_PO15: PO4_h_FUNC_POST_CONDITION
	 and TestV2IFcns_PO16: PO5_h_SUB_TYPE
	 and TestV2IFcns_PO17: PO6_h_SUB_TYPE
	 and TestV2IFcns_PO18: PO7_h_FUNC_APPLY
	 and TestV2IFcns_PO19: PO8_h_SUB_TYPE
	 and TestV2IFcns_PO20: PO9_h'_FUNC_POST_CONDITION
begin
	\<comment>\<open>User defined lemmas for TestV2IFcns POs\<close>
end


lemma TestV2IFcns_POG_l1: \<open>PO10_h'_FUNC_APPLY\<close> 
  sorry

lemma TestV2IFcns_POG_l2: \<open>PO11_h'_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l3: \<open>PO12_h''_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l4: \<open>PO13_h''_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l5: \<open>PO14_h''_FUNC_APPLY\<close> 
	 sorry

lemma TestV2IFcns_POG_l6: \<open>PO15_h''_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l7: \<open>PO16_curriedS_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l8: \<open>PO17_implicit_TOTAL\<close> 
	 sorry

lemma TestV2IFcns_POG_l9: \<open>PO18_implicit_FUNC_SATISFIABILITY\<close> 
	 sorry

lemma TestV2IFcns_POG_l10: \<open>PO19_implicitexplicit_TOTAL\<close> 
	 sorry

lemma TestV2IFcns_POG_l11: \<open>PO1_constS_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l12: \<open>PO20_implicitexplicit_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l13: \<open>PO2_g_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l14: \<open>PO3_h_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l15: \<open>PO4_h_FUNC_POST_CONDITION\<close> 
	 sorry

lemma TestV2IFcns_POG_l16: \<open>PO5_h_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l17: \<open>PO6_h_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l18: \<open>PO7_h_FUNC_APPLY\<close> 
	 sorry

lemma TestV2IFcns_POG_l19: \<open>PO8_h_SUB_TYPE\<close> 
	 sorry

lemma TestV2IFcns_POG_l20: \<open>PO9_h'_FUNC_POST_CONDITION\<close> 
	 sorry
interpretation TestV2IFcns_POG 
  apply unfold_locales
  apply (simp add: TestV2IFcns_POG_l1)
  apply (simp add: TestV2IFcns_POG_l2)
  apply (simp add: TestV2IFcns_POG_l3)
  apply (simp add: TestV2IFcns_POG_l4)
  apply (simp add: TestV2IFcns_POG_l5)
  apply (simp add: TestV2IFcns_POG_l6)
  apply (simp add: TestV2IFcns_POG_l7)
  apply (simp add: TestV2IFcns_POG_l8)
  apply (simp add: TestV2IFcns_POG_l9)
  apply (simp add: TestV2IFcns_POG_l10)
  apply (simp add: TestV2IFcns_POG_l11)
  apply (simp add: TestV2IFcns_POG_l12)
  apply (simp add: TestV2IFcns_POG_l13)
  apply (simp add: TestV2IFcns_POG_l14)
  apply (simp add: TestV2IFcns_POG_l15)
  apply (simp add: TestV2IFcns_POG_l16)
  apply (simp add: TestV2IFcns_POG_l17)
  apply (simp add: TestV2IFcns_POG_l18)
  apply (simp add: TestV2IFcns_POG_l19)
  apply (simp add: TestV2IFcns_POG_l20)
	done
end