(* VDM to Isabelle Translation @2022-12-22T13:09:37.706Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2IDeclBeforeUse_PO
   in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 6:19
   files = [./lvl0/TestV2IDeclBeforeUse.vdmsl]
*)
theory TestV2IDeclBeforeUse_PO
imports VDMToolkit "TestV2IDeclBeforeUse" 
begin


\<comment>\<open>VDM source: head = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 6:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_28_head_NON_EMPTY_SEQ :: \<open>\<bool>\<close>
where
	\<open>PO_28_head_NON_EMPTY_SEQ  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> ((pre_head s) \<longrightarrow> (s \<noteq> []))))\<close>

	
(*
	\<comment>\<open>VDM proof obligation `PO_29_sum_elems_measure_sum_elems_TOTAL` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: sum_elems; measure_sum_elems = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 14:13\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_29_sum_elems_measure_sum_elems_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_29_sum_elems_measure_sum_elems_TOTAL  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> isTest ((measure_sum_elems s)) (inv_VDMNat)))\<close>

	
	*)

\<comment>\<open>VDM source: sum_elems = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 13:43\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_30_sum_elems_FUNC_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_30_sum_elems_FUNC_APPLY  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> ((\<not> (s = [])) \<longrightarrow> (pre_head s))))\<close>

	
(*
	\<comment>\<open>VDM proof obligation `PO_31_sum_elems_RECURSIVE` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: sum_elems = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 12:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_31_sum_elems_RECURSIVE :: \<open>\<bool>\<close>
where
	\<open>PO_31_sum_elems_RECURSIVE  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> ((\<not> (s = [])) \<longrightarrow> ((measure_sum_elems s) > (measure_sum_elems (tail s))))))\<close>

	
	*)

\<comment>\<open>VDM source: sum_elems = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 13:68\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_32_sum_elems_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_32_sum_elems_SUB_TYPE  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> ((\<not> (s = [])) \<longrightarrow> isTest (s) (inv_VDMSeq1' (inv_VDMNat)))))\<close>

	

\<comment>\<open>VDM source: S = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 27:21\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_33_S_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_33_S_TOTAL  \<equiv> (\<forall> (s :: T)  . ((((inv_T s))) \<longrightarrow> isTest ((inv_S s)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: S = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 24:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_34_S_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_34_S_INV_SATISFIABILITY  \<equiv> (\<exists> (s :: T)  . ((((inv_T s))) \<longrightarrow> ((len (tail s)) > (0::VDMNat))))\<close>

	

\<comment>\<open>VDM source: R = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 33:22\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_35_R_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_35_R_TOTAL  \<equiv> (\<forall> (r :: S)  . ((((inv_S r))) \<longrightarrow> isTest ((inv_R r)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: R = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 33:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_36_R_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_36_R_SUB_TYPE  \<equiv> (\<forall> (r :: S)  . ((((inv_S r))) \<longrightarrow> isTest (r) (inv_VDMSeq' (inv_VDMNat))))\<close>

	

\<comment>\<open>VDM source: R = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 30:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_37_R_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_37_R_INV_SATISFIABILITY  \<equiv> (\<exists> (r :: S)  . ((((inv_S r))) \<longrightarrow> ((sum_elems r) < (5::VDMNat1))))\<close>

	

\<comment>\<open>VDM source: Rec = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 41:37\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_38_Rec_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_38_Rec_TOTAL  \<equiv> (\<forall> (dummy0 :: Rec)  . (((inv_Rec dummy0)) \<longrightarrow> (\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let s = (s\<^sub>R\<^sub>e\<^sub>c dummy0); t = (t\<^sub>R\<^sub>e\<^sub>c dummy0); r = (r\<^sub>R\<^sub>e\<^sub>c dummy0) in isTest ((inv_Rec \<lparr>s\<^sub>R\<^sub>e\<^sub>c = s, t\<^sub>R\<^sub>e\<^sub>c = t, r\<^sub>R\<^sub>e\<^sub>c = r\<rparr>)) (inv_bool))))\<close>

	

\<comment>\<open>VDM source: Rec = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 41:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_39_Rec_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_39_Rec_SUB_TYPE  \<equiv> (\<forall> (dummy0 :: Rec)  . (((inv_Rec dummy0)) \<longrightarrow> (\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let s = (s\<^sub>R\<^sub>e\<^sub>c dummy0); t = (t\<^sub>R\<^sub>e\<^sub>c dummy0); r = (r\<^sub>R\<^sub>e\<^sub>c dummy0) in isTest (s) (inv_VDMSeq' (inv_VDMNat)))))\<close>

	

\<comment>\<open>VDM source: Rec = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 36:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_40_Rec_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_40_Rec_INV_SATISFIABILITY  \<equiv> (\<exists> (dummy0 :: Rec)  . (((inv_Rec dummy0)) \<longrightarrow> (\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let s = (s\<^sub>R\<^sub>e\<^sub>c dummy0); t = (t\<^sub>R\<^sub>e\<^sub>c dummy0); r = (r\<^sub>R\<^sub>e\<^sub>c dummy0) in (((sum_elems s) > (sum_elems t)) \<and> ((len r) > (1::VDMNat1))))))\<close>

	

\<comment>\<open>VDM source: Map = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 44:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_41_Map_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_41_Map_TOTAL  \<equiv> (\<forall> (m :: (S \<rightharpoonup> Rec))  . ((((inv_VDMMap inv_S inv_Rec  m))) \<longrightarrow> isTest ((inv_Map m)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: Map = ?\<close>
\<comment>\<open>in 'TestV2IDeclBeforeUse' (./lvl0/TestV2IDeclBeforeUse.vdmsl) at line 43:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_42_Map_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_42_Map_INV_SATISFIABILITY  \<equiv> (\<exists> (m :: (S \<rightharpoonup> Rec))  . ((((inv_VDMMap inv_S inv_Rec  m))) \<longrightarrow> ((dom m) = {})))\<close>

	
 

end 