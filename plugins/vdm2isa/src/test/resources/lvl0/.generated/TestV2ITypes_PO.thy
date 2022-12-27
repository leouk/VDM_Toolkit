(* VDM to Isabelle Translation @2022-12-27T13:26:50.910Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypes_PO
   in 'TestV2ITypes' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypes.vdmsl) at line 15:22
   files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypes.vdmsl]
*)
theory TestV2ITypes_PO
imports VDMToolkit "TestV2ITypes" 
begin


\<comment>\<open>VDM source: TBasic2 = ?\<close>
\<comment>\<open>in 'TestV2ITypes' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypes.vdmsl) at line 15:22\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_1_TBasic2_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_1_TBasic2_TOTAL  \<equiv> (\<forall> (t :: VDMNat1)  . ((((inv_VDMNat1 t))) \<longrightarrow> isTest ((inv_TBasic2 t)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TBasic2 = ?\<close>
\<comment>\<open>in 'TestV2ITypes' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypes.vdmsl) at line 14:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_2_TBasic2_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_2_TBasic2_INV_SATISFIABILITY  \<equiv> (\<exists> (t :: VDMNat1)  . ((((inv_VDMNat1 t))) \<longrightarrow> (t > (10::VDMNat1))))\<close>

	

\<comment>\<open>VDM source: TBasic2 = ?\<close>
\<comment>\<open>in 'TestV2ITypes' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypes.vdmsl) at line 16:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_3_TBasic2_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_3_TBasic2_TOTAL  \<equiv> (\<forall> (t1 :: VDMNat1)   (t2 :: VDMNat1)  . ((((inv_VDMNat1 t1)))  \<and>  (((inv_VDMNat1 t2))) \<longrightarrow> isTest ((eq_TBasic2 t1  t2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TBasic2 = ?\<close>
\<comment>\<open>in 'TestV2ITypes' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypes.vdmsl) at line 16:9\<close>


definition
	PO_4_TBasic2_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_4_TBasic2_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TBasic2)  . ((((inv_TBasic2 x))) \<longrightarrow> (eq_TBasic2 x  x))) \<and> ((\<forall> (x :: TBasic2)  (y :: TBasic2)  . ((((inv_TBasic2 x))) \<and>  (((inv_TBasic2 y))) \<longrightarrow> ((eq_TBasic2 x  y) \<longrightarrow> (eq_TBasic2 y  x)))) \<and> (\<forall> (x :: TBasic2)  (y :: TBasic2)  (z :: TBasic2)  . ((((inv_TBasic2 x))) \<and>  (((inv_TBasic2 y))) \<and>  (((inv_TBasic2 z))) \<longrightarrow> (((eq_TBasic2 x  y) \<and> (eq_TBasic2 y  z)) \<longrightarrow> (eq_TBasic2 x  z))))))\<close>

	

\<comment>\<open>VDM source: TBasic2 = ?\<close>
\<comment>\<open>in 'TestV2ITypes' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypes.vdmsl) at line 17:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_5_TBasic2_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_5_TBasic2_TOTAL  \<equiv> (\<forall> (t1 :: VDMNat1)   (t2 :: VDMNat1)  . ((((inv_VDMNat1 t1)))  \<and>  (((inv_VDMNat1 t2))) \<longrightarrow> isTest ((ord_TBasic2 t1  t2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TBasic2 = ?\<close>
\<comment>\<open>in 'TestV2ITypes' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypes.vdmsl) at line 17:9\<close>


definition
	PO_6_TBasic2_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_6_TBasic2_STRICT_ORDER  \<equiv> ((\<forall> (x :: TBasic2)  . ((((inv_TBasic2 x))) \<longrightarrow> (\<not> (ord_TBasic2 x  x)))) \<and> (\<forall> (x :: TBasic2)  (y :: TBasic2)  (z :: TBasic2)  . ((((inv_TBasic2 x))) \<and>  (((inv_TBasic2 y))) \<and>  (((inv_TBasic2 z))) \<longrightarrow> (((ord_TBasic2 x  y) \<and> (ord_TBasic2 y  z)) \<longrightarrow> (ord_TBasic2 x  z)))))\<close>

	
 

end 