(* VDM to Isabelle Translation @2022-03-11T09:31:29.983Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 14:9
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl]
*)
theory MinimalTheorem_PO
imports MinimalTheorem
begin


\<comment>\<open>VDM source: T = ?\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 14:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO1_T_TOTAL :: "\<bool>"
where
	"PO1_T_TOTAL  \<equiv> (\<forall> (t :: VDMNat)  . ((((inv_VDMNat t))) \<longrightarrow> isTest ((inv_T t)) (inv_bool)))"

	
	
	
\<comment>\<open>VDM source: T = ?\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 13:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO2_T_INV_SATISFIABILITY :: "\<bool>"
where
	"PO2_T_INV_SATISFIABILITY  \<equiv> (\<exists> (t :: VDMNat)  . ((((inv_VDMNat t))) \<longrightarrow> (t > (10::VDMNat1))))"

	
	
	
\<comment>\<open>VDM source: T; T = ?\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 13:5\<close>


definition
	PO3_T_T_THEOREM :: "\<bool>"
where
	"PO3_T_T_THEOREM  \<equiv> ((20::VDMNat1) > (10::VDMNat1))"

	
	
	
\<comment>\<open>VDM source: T; T; T_Test = ?\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 13:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO4_T_T_T_Test_THEOREM :: "\<bool>"
where
	"PO4_T_T_T_Test_THEOREM  \<equiv> (\<forall> (x :: T)  . ((((inv_T x))) \<longrightarrow> (x > (0::VDMNat))))"

	
	
	
\<comment>\<open>VDM source: T; T; T_Test; T_Test2 = ?\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 13:5\<close>


definition
	PO5_T_T_T_Test_T_Test2_THEOREM :: "\<bool>"
where
	"PO5_T_T_T_Test_T_Test2_THEOREM  \<equiv> (\<forall> x \<in> {(1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1)}  . (x > (0::VDMNat)))"

	
	
	
\<comment>\<open>VDM source: T; T; T_Test; T_Test2; T_Lemma = ?\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 13:5\<close>


definition
	PO6_T_T_T_Test_T_Test2_T_Lemma_THEOREM :: "\<bool>"
where
	"PO6_T_T_T_Test_T_Test2_T_Lemma_THEOREM  \<equiv> ((20::VDMNat1) < (10::VDMNat1))"

	
	
	
\<comment>\<open>VDM source: T; T; T_Test; T_Test2; f; fProperty1 = ?\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 20:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO7_T_T_T_Test_T_Test2_f_fProperty1_THEOREM :: "\<bool>"
where
	"PO7_T_T_T_Test_T_Test2_f_fProperty1_THEOREM  \<equiv> (\<forall> (x :: VDMNat)   (y :: VDMNat1)  . ((((inv_VDMNat x)))  \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((x < (f x  y)) \<and> (y < (f x  y)))))"

	
	
	
\<comment>\<open>VDM source: T; T; T_Test; T_Test2; f; fProperty1; fLemma1 = ?\<close>
\<comment>\<open>in 'MinimalTheorem' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/annotations/src/test/resources/MinimalTheorem.vdmsl) at line 20:5\<close>


definition
	PO8_T_T_T_Test_T_Test2_f_fProperty1_fLemma1_THEOREM :: "\<bool>"
where
	"PO8_T_T_T_Test_T_Test2_f_fProperty1_fLemma1_THEOREM  \<equiv> ((f (10::VDMNat1)  (20::VDMNat1)) \<le> (f (20::VDMNat1)  (10::VDMNat1)))"

	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>


locale MinimalTheorem_POG = 
	assumes
			 MinimalTheorem_PO1: PO1_T_TOTAL
	 and MinimalTheorem_PO2: PO2_T_INV_SATISFIABILITY
	 and MinimalTheorem_PO3: PO3_T_T_THEOREM
	 and MinimalTheorem_PO4: PO4_T_T_T_Test_THEOREM
	 and MinimalTheorem_PO5: PO5_T_T_T_Test_T_Test2_THEOREM
	 and MinimalTheorem_PO6: PO6_T_T_T_Test_T_Test2_T_Lemma_THEOREM
	 and MinimalTheorem_PO7: PO7_T_T_T_Test_T_Test2_f_fProperty1_THEOREM
	 and MinimalTheorem_PO8: PO8_T_T_T_Test_T_Test2_f_fProperty1_fLemma1_THEOREM
begin
	\<comment>\<open>User defined lemmas for MinimalTheorem POs\<close>
end


lemma MinimalTheorem_POG_l1[simp]: \<open>PO1_T_TOTAL\<close> 
	 sorry

lemma MinimalTheorem_POG_l2[simp]: \<open>PO2_T_INV_SATISFIABILITY\<close> 
	 sorry

lemma MinimalTheorem_POG_l3[simp]: \<open>PO3_T_T_THEOREM\<close> 
	 sorry

lemma MinimalTheorem_POG_l4[simp]: \<open>PO4_T_T_T_Test_THEOREM\<close> 
	 sorry

lemma MinimalTheorem_POG_l5[simp]: \<open>PO5_T_T_T_Test_T_Test2_THEOREM\<close> 
	 sorry

lemma MinimalTheorem_POG_l6[simp]: \<open>PO6_T_T_T_Test_T_Test2_T_Lemma_THEOREM\<close> 
	 sorry

lemma MinimalTheorem_POG_l7[simp]: \<open>PO7_T_T_T_Test_T_Test2_f_fProperty1_THEOREM\<close> 
	 sorry

lemma MinimalTheorem_POG_l8[simp]: \<open>PO8_T_T_T_Test_T_Test2_f_fProperty1_fLemma1_THEOREM\<close> 
	 sorry

interpretation MinimalTheorem_POG 
	 	apply unfold_locales
	by simp_all
end