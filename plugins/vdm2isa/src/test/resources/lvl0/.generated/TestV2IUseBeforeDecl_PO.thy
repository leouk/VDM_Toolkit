(* VDM to Isabelle Translation @2022-12-24T08:20:03.188Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2IUseBeforeDecl_PO
   in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 43:19
   files = [./lvl0/TestV2IUseBeforeDecl.vdmsl]
*)
theory TestV2IUseBeforeDecl_PO
imports VDMToolkit "TestV2IUseBeforeDecl" 
begin


\<comment>\<open>VDM source: head = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 43:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_74_head_NON_EMPTY_SEQ :: \<open>\<bool>\<close>
where
	\<open>PO_74_head_NON_EMPTY_SEQ  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> ((pre_head s) \<longrightarrow> (s \<noteq> []))))\<close>

	
(*
	\<comment>\<open>VDM proof obligation `PO_75_sum_elems_measure_sum_elems_TOTAL` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: sum_elems; measure_sum_elems = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 40:13\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_75_sum_elems_measure_sum_elems_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_75_sum_elems_measure_sum_elems_TOTAL  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> isTest ((measure_sum_elems s)) (inv_VDMNat)))\<close>

	
	*)

\<comment>\<open>VDM source: sum_elems = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 39:43\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_76_sum_elems_FUNC_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_76_sum_elems_FUNC_APPLY  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> ((\<not> (s = [])) \<longrightarrow> (pre_head s))))\<close>

	
(*
	\<comment>\<open>VDM proof obligation `PO_77_sum_elems_RECURSIVE` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: sum_elems = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 38:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_77_sum_elems_RECURSIVE :: \<open>\<bool>\<close>
where
	\<open>PO_77_sum_elems_RECURSIVE  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> ((\<not> (s = [])) \<longrightarrow> ((measure_sum_elems s) > (measure_sum_elems (tail s))))))\<close>

	
	*)

\<comment>\<open>VDM source: sum_elems = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 39:68\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_78_sum_elems_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_78_sum_elems_SUB_TYPE  \<equiv> (\<forall> (s :: VDMNat VDMSeq)  . ((((inv_VDMSeq' (inv_VDMNat) s))) \<longrightarrow> ((\<not> (s = [])) \<longrightarrow> isTest (s) (inv_VDMSeq1' (inv_VDMNat)))))\<close>

	

\<comment>\<open>VDM source: S = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 27:21\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_79_S_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_79_S_TOTAL  \<equiv> (\<forall> (s :: T)  . ((((inv_T s))) \<longrightarrow> isTest ((inv_S s)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: S = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 24:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_80_S_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_80_S_INV_SATISFIABILITY  \<equiv> (\<exists> (s :: T)  . ((((inv_T s))) \<longrightarrow> ((len (tail s)) > (0::VDMNat))))\<close>

	

\<comment>\<open>VDM source: R = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 21:22\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_81_R_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_81_R_TOTAL  \<equiv> (\<forall> (r :: S)  . ((((inv_S r))) \<longrightarrow> isTest ((inv_R r)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: R = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 21:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_82_R_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_82_R_SUB_TYPE  \<equiv> (\<forall> (r :: S)  . ((((inv_S r))) \<longrightarrow> isTest (r) (inv_VDMSeq' (inv_VDMNat))))\<close>

	

\<comment>\<open>VDM source: R = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 18:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_83_R_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_83_R_INV_SATISFIABILITY  \<equiv> (\<exists> (r :: S)  . ((((inv_S r))) \<longrightarrow> ((sum_elems r) < (5::VDMNat1))))\<close>

	

\<comment>\<open>VDM source: Rec = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 15:37\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_84_Rec_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_84_Rec_TOTAL  \<equiv> (\<forall> (dummy0 :: Rec)  . (((inv_Rec dummy0)) \<longrightarrow> (\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let s = (s\<^sub>R\<^sub>e\<^sub>c dummy0); t = (t\<^sub>R\<^sub>e\<^sub>c dummy0); r = (r\<^sub>R\<^sub>e\<^sub>c dummy0) in isTest ((inv_Rec \<lparr>s\<^sub>R\<^sub>e\<^sub>c = s, t\<^sub>R\<^sub>e\<^sub>c = t, r\<^sub>R\<^sub>e\<^sub>c = r\<rparr>)) (inv_bool))))\<close>

	

\<comment>\<open>VDM source: Rec = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 15:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_85_Rec_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_85_Rec_SUB_TYPE  \<equiv> (\<forall> (dummy0 :: Rec)  . (((inv_Rec dummy0)) \<longrightarrow> (\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let s = (s\<^sub>R\<^sub>e\<^sub>c dummy0); t = (t\<^sub>R\<^sub>e\<^sub>c dummy0); r = (r\<^sub>R\<^sub>e\<^sub>c dummy0) in isTest (s) (inv_VDMSeq' (inv_VDMNat)))))\<close>

	

\<comment>\<open>VDM source: Rec = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 10:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_86_Rec_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_86_Rec_INV_SATISFIABILITY  \<equiv> (\<exists> (dummy0 :: Rec)  . (((inv_Rec dummy0)) \<longrightarrow> (\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let s = (s\<^sub>R\<^sub>e\<^sub>c dummy0); t = (t\<^sub>R\<^sub>e\<^sub>c dummy0); r = (r\<^sub>R\<^sub>e\<^sub>c dummy0) in (((sum_elems s) > (sum_elems t)) \<and> ((len r) > (1::VDMNat1))))))\<close>

	

\<comment>\<open>VDM source: Map = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 7:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_87_Map_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_87_Map_TOTAL  \<equiv> (\<forall> (m :: (S \<rightharpoonup> Rec))  . ((((inv_VDMMap inv_S inv_Rec  m))) \<longrightarrow> isTest ((inv_Map m)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: Map = ?\<close>
\<comment>\<open>in 'TestV2IUseBeforeDecl' (./lvl0/TestV2IUseBeforeDecl.vdmsl) at line 6:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_88_Map_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_88_Map_INV_SATISFIABILITY  \<equiv> (\<exists> (m :: (S \<rightharpoonup> Rec))  . ((((inv_VDMMap inv_S inv_Rec  m))) \<longrightarrow> ((dom m) = {})))\<close>

	
 

end 