(* VDM to Isabelle Translation @2022-12-26T10:40:28.985Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesRecords_PO
   in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 10:18
   files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl]
*)
theory TestV2ITypesRecords_PO
imports VDMToolkit "TestV2ITypesRecords" 
begin


\<comment>\<open>VDM source: TRecord = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 10:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_01_TRecord_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_01_TRecord_TOTAL  \<equiv> (\<forall> (r :: TRecord)  . (((inv_TRecord r)) \<longrightarrow> isTest ((inv_TRecord r)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRecord = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 7:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_02_TRecord_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_02_TRecord_INV_SATISFIABILITY  \<equiv> (\<exists> (r :: TRecord)  . (((inv_TRecord r)) \<longrightarrow> ((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r) < (y\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r))))\<close>

	

\<comment>\<open>VDM source: TRecord = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 11:8\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_03_TRecord_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_03_TRecord_TOTAL  \<equiv> (\<forall> (r1 :: TRecord)   (r2 :: TRecord)  . (((inv_TRecord r1))  \<and>  ((inv_TRecord r2)) \<longrightarrow> isTest ((eq_TRecord r1  r2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRecord = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 11:8\<close>


definition
	PO_04_TRecord_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_04_TRecord_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TRecord)  . (((inv_TRecord x)) \<longrightarrow> (eq_TRecord x  x))) \<and> ((\<forall> (x :: TRecord)  (y :: TRecord)  . (((inv_TRecord x)) \<and>  ((inv_TRecord y)) \<longrightarrow> ((eq_TRecord x  y) \<longrightarrow> (eq_TRecord y  x)))) \<and> (\<forall> (x :: TRecord)  (y :: TRecord)  (z :: TRecord)  . (((inv_TRecord x)) \<and>  ((inv_TRecord y)) \<and>  ((inv_TRecord z)) \<longrightarrow> (((eq_TRecord x  y) \<and> (eq_TRecord y  z)) \<longrightarrow> (eq_TRecord x  z))))))\<close>

	

\<comment>\<open>VDM source: TRecord = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 12:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_05_TRecord_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_05_TRecord_TOTAL  \<equiv> (\<forall> (r1 :: TRecord)   (r2 :: TRecord)  . (((inv_TRecord r1))  \<and>  ((inv_TRecord r2)) \<longrightarrow> isTest ((ord_TRecord r1  r2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRecord = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 12:9\<close>


definition
	PO_06_TRecord_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_06_TRecord_STRICT_ORDER  \<equiv> ((\<forall> (x :: TRecord)  . (((inv_TRecord x)) \<longrightarrow> (\<not> (ord_TRecord x  x)))) \<and> (\<forall> (x :: TRecord)  (y :: TRecord)  (z :: TRecord)  . (((inv_TRecord x)) \<and>  ((inv_TRecord y)) \<and>  ((inv_TRecord z)) \<longrightarrow> (((ord_TRecord x  y) \<and> (ord_TRecord y  z)) \<longrightarrow> (ord_TRecord x  z)))))\<close>

	

\<comment>\<open>VDM source: TRecord3 = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 20:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_07_TRecord3_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_07_TRecord3_TOTAL  \<equiv> (\<forall> (r :: TRecord)  . (((inv_TRecord r)) \<longrightarrow> isTest ((inv_TRecord3 r)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRecord3 = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 19:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_08_TRecord3_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_08_TRecord3_INV_SATISFIABILITY  \<equiv> (\<exists> (r :: TRecord)  . (((inv_TRecord r)) \<longrightarrow> ((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r) > (10::VDMNat1))))\<close>

	

\<comment>\<open>VDM source: TRecord5 = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 29:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_09_TRecord5_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_09_TRecord5_TOTAL  \<equiv> (\<forall> (r :: TRecord2)  . ((((inv_TRecord2 r))) \<longrightarrow> isTest ((inv_TRecord5 r)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRecord5 = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 28:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_10_TRecord5_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_10_TRecord5_INV_SATISFIABILITY  \<equiv> (\<exists> (r :: TRecord2)  . ((((inv_TRecord2 r))) \<longrightarrow> ((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r) > (20::VDMNat1))))\<close>

	

\<comment>\<open>VDM source: TRecord7 = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 38:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_11_TRecord7_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_11_TRecord7_TOTAL  \<equiv> (\<forall> (r :: TRecord5)  . ((((inv_TRecord5 r))) \<longrightarrow> isTest ((inv_TRecord7 r)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRecord7 = ?\<close>
\<comment>\<open>in 'TestV2ITypesRecords' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2ITypesRecords.vdmsl) at line 37:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_12_TRecord7_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_12_TRecord7_INV_SATISFIABILITY  \<equiv> (\<exists> (r :: TRecord5)  . ((((inv_TRecord5 r))) \<longrightarrow> ((x\<^sub>T\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d r) > (30::VDMNat1))))\<close>

	
 

end 