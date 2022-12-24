(* VDM to Isabelle Translation @2022-12-24T08:20:03.166Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesOrdering_PO
   in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 8:18
   files = [./lvl0/TestV2ITypesOrdering.vdmsl]
*)
theory TestV2ITypesOrdering_PO
imports VDMToolkit "TestV2ITypesOrdering" 
begin


\<comment>\<open>VDM source: TOrder1 = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 8:18\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_01_TOrder1_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_01_TOrder1_TOTAL  \<equiv> (\<forall> (oI :: VDMNat1)  . ((((inv_VDMNat1 oI))) \<longrightarrow> isTest ((inv_TOrder1 oI)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TOrder1 = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 7:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_02_TOrder1_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_02_TOrder1_INV_SATISFIABILITY  \<equiv> (\<exists> (oI :: VDMNat1)  . ((((inv_VDMNat1 oI))) \<longrightarrow> (oI > (1::VDMNat1))))\<close>

	

\<comment>\<open>VDM source: TOrder1 = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 9:8\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_03_TOrder1_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_03_TOrder1_TOTAL  \<equiv> (\<forall> (o1 :: VDMNat1)   (o2 :: VDMNat1)  . ((((inv_VDMNat1 o1)))  \<and>  (((inv_VDMNat1 o2))) \<longrightarrow> isTest ((eq_TOrder1 o1  o2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TOrder1 = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 9:8\<close>


definition
	PO_04_TOrder1_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_04_TOrder1_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TOrder1)  . ((((inv_TOrder1 x))) \<longrightarrow> (eq_TOrder1 x  x))) \<and> ((\<forall> (x :: TOrder1)  (y :: TOrder1)  . ((((inv_TOrder1 x))) \<and>  (((inv_TOrder1 y))) \<longrightarrow> ((eq_TOrder1 x  y) \<longrightarrow> (eq_TOrder1 y  x)))) \<and> (\<forall> (x :: TOrder1)  (y :: TOrder1)  (z :: TOrder1)  . ((((inv_TOrder1 x))) \<and>  (((inv_TOrder1 y))) \<and>  (((inv_TOrder1 z))) \<longrightarrow> (((eq_TOrder1 x  y) \<and> (eq_TOrder1 y  z)) \<longrightarrow> (eq_TOrder1 x  z))))))\<close>

	

\<comment>\<open>VDM source: TOrder1 = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 10:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_05_TOrder1_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_05_TOrder1_TOTAL  \<equiv> (\<forall> (o1 :: VDMNat1)   (o2 :: VDMNat1)  . ((((inv_VDMNat1 o1)))  \<and>  (((inv_VDMNat1 o2))) \<longrightarrow> isTest ((ord_TOrder1 o1  o2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TOrder1 = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 10:9\<close>


definition
	PO_06_TOrder1_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_06_TOrder1_STRICT_ORDER  \<equiv> ((\<forall> (x :: TOrder1)  . ((((inv_TOrder1 x))) \<longrightarrow> (\<not> (ord_TOrder1 x  x)))) \<and> (\<forall> (x :: TOrder1)  (y :: TOrder1)  (z :: TOrder1)  . ((((inv_TOrder1 x))) \<and>  (((inv_TOrder1 y))) \<and>  (((inv_TOrder1 z))) \<longrightarrow> (((ord_TOrder1 x  y) \<and> (ord_TOrder1 y  z)) \<longrightarrow> (ord_TOrder1 x  z)))))\<close>

	

\<comment>\<open>VDM source: TRenamed = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 14:16\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_07_TRenamed_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_07_TRenamed_TOTAL  \<equiv> (\<forall> (r :: TOrder1)  . ((((inv_TOrder1 r))) \<longrightarrow> isTest ((inv_TRenamed r)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRenamed = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 13:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_08_TRenamed_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_08_TRenamed_INV_SATISFIABILITY  \<equiv> (\<exists> (r :: TOrder1)  . ((((inv_TOrder1 r))) \<longrightarrow> \<comment>\<open>Transform a VDM `>` expression into a reversed `ord_TOrder1` call\<close>
	(ord_TOrder1 (10::VDMNat1)  r)))\<close>

	

\<comment>\<open>VDM source: TRenamedOrdered = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 17:8\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_09_TRenamedOrdered_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_09_TRenamedOrdered_TOTAL  \<equiv> (\<forall> (o1 :: TOrder1)   (o2 :: TOrder1)  . ((((inv_TOrder1 o1)))  \<and>  (((inv_TOrder1 o2))) \<longrightarrow> isTest ((eq_TRenamedOrdered o1  o2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRenamedOrdered = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 17:8\<close>


definition
	PO_10_TRenamedOrdered_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_10_TRenamedOrdered_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TRenamedOrdered)  . ((((inv_TRenamedOrdered x))) \<longrightarrow> (eq_TRenamedOrdered x  x))) \<and> ((\<forall> (x :: TRenamedOrdered)  (y :: TRenamedOrdered)  . ((((inv_TRenamedOrdered x))) \<and>  (((inv_TRenamedOrdered y))) \<longrightarrow> ((eq_TRenamedOrdered x  y) \<longrightarrow> (eq_TRenamedOrdered y  x)))) \<and> (\<forall> (x :: TRenamedOrdered)  (y :: TRenamedOrdered)  (z :: TRenamedOrdered)  . ((((inv_TRenamedOrdered x))) \<and>  (((inv_TRenamedOrdered y))) \<and>  (((inv_TRenamedOrdered z))) \<longrightarrow> (((eq_TRenamedOrdered x  y) \<and> (eq_TRenamedOrdered y  z)) \<longrightarrow> (eq_TRenamedOrdered x  z))))))\<close>

	

\<comment>\<open>VDM source: TRenamedOrdered = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 18:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_11_TRenamedOrdered_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_11_TRenamedOrdered_TOTAL  \<equiv> (\<forall> (o1 :: TOrder1)   (o2 :: TOrder1)  . ((((inv_TOrder1 o1)))  \<and>  (((inv_TOrder1 o2))) \<longrightarrow> isTest ((ord_TRenamedOrdered o1  o2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRenamedOrdered = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 18:9\<close>


definition
	PO_12_TRenamedOrdered_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_12_TRenamedOrdered_STRICT_ORDER  \<equiv> ((\<forall> (x :: TRenamedOrdered)  . ((((inv_TRenamedOrdered x))) \<longrightarrow> (\<not> (ord_TRenamedOrdered x  x)))) \<and> (\<forall> (x :: TRenamedOrdered)  (y :: TRenamedOrdered)  (z :: TRenamedOrdered)  . ((((inv_TRenamedOrdered x))) \<and>  (((inv_TRenamedOrdered y))) \<and>  (((inv_TRenamedOrdered z))) \<longrightarrow> (((ord_TRenamedOrdered x  y) \<and> (ord_TRenamedOrdered y  z)) \<longrightarrow> (ord_TRenamedOrdered x  z)))))\<close>

	

\<comment>\<open>VDM source: TRenamedPOrdered = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 22:8\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_13_TRenamedPOrdered_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_13_TRenamedPOrdered_TOTAL  \<equiv> (\<forall> (o1 :: TOrder1)   (o2 :: TOrder1)  . ((((inv_TOrder1 o1)))  \<and>  (((inv_TOrder1 o2))) \<longrightarrow> isTest ((eq_TRenamedPOrdered o1  o2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRenamedPOrdered = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 22:8\<close>


definition
	PO_14_TRenamedPOrdered_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_14_TRenamedPOrdered_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TRenamedPOrdered)  . ((((inv_TRenamedPOrdered x))) \<longrightarrow> (eq_TRenamedPOrdered x  x))) \<and> ((\<forall> (x :: TRenamedPOrdered)  (y :: TRenamedPOrdered)  . ((((inv_TRenamedPOrdered x))) \<and>  (((inv_TRenamedPOrdered y))) \<longrightarrow> ((eq_TRenamedPOrdered x  y) \<longrightarrow> (eq_TRenamedPOrdered y  x)))) \<and> (\<forall> (x :: TRenamedPOrdered)  (y :: TRenamedPOrdered)  (z :: TRenamedPOrdered)  . ((((inv_TRenamedPOrdered x))) \<and>  (((inv_TRenamedPOrdered y))) \<and>  (((inv_TRenamedPOrdered z))) \<longrightarrow> (((eq_TRenamedPOrdered x  y) \<and> (eq_TRenamedPOrdered y  z)) \<longrightarrow> (eq_TRenamedPOrdered x  z))))))\<close>

	

\<comment>\<open>VDM source: TRenamedPOrdered = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 23:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_15_TRenamedPOrdered_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_15_TRenamedPOrdered_TOTAL  \<equiv> (\<forall> (o1 :: TOrder1)   (o2 :: TOrder1)  . ((((inv_TOrder1 o1)))  \<and>  (((inv_TOrder1 o2))) \<longrightarrow> isTest ((ord_TRenamedPOrdered o1  o2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TRenamedPOrdered = ?\<close>
\<comment>\<open>in 'TestV2ITypesOrdering' (./lvl0/TestV2ITypesOrdering.vdmsl) at line 23:9\<close>


definition
	PO_16_TRenamedPOrdered_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_16_TRenamedPOrdered_STRICT_ORDER  \<equiv> ((\<forall> (x :: TRenamedPOrdered)  . ((((inv_TRenamedPOrdered x))) \<longrightarrow> (\<not> (ord_TRenamedPOrdered x  x)))) \<and> (\<forall> (x :: TRenamedPOrdered)  (y :: TRenamedPOrdered)  (z :: TRenamedPOrdered)  . ((((inv_TRenamedPOrdered x))) \<and>  (((inv_TRenamedPOrdered y))) \<and>  (((inv_TRenamedPOrdered z))) \<longrightarrow> (((ord_TRenamedPOrdered x  y) \<and> (ord_TRenamedPOrdered y  z)) \<longrightarrow> (ord_TRenamedPOrdered x  z)))))\<close>

	
 

end 