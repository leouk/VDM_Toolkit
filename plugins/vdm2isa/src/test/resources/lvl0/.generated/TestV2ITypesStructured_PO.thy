(* VDM to Isabelle Translation @2022-12-24T08:20:03.179Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2ITypesStructured_PO
   in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 11:23
   files = [./lvl0/TestV2ITypesStructured.vdmsl]
*)
theory TestV2ITypesStructured_PO
imports VDMToolkit "TestV2ITypesStructured" 
begin


\<comment>\<open>VDM source: G2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 11:23\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_17_G2_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_17_G2_TOTAL  \<equiv> (\<forall> (dummy0 :: (VDMInt \<times> VDMInt))  . (((
		((inv_VDMInt (fst dummy0))\<and>
		 (inv_VDMInt (snd dummy0))
		))) \<longrightarrow> (\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let l = (fst dummy0); r = (snd dummy0) in isTest ((inv_G2 (l , r))) (inv_bool))))\<close>

	

\<comment>\<open>VDM source: G2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 10:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_18_G2_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_18_G2_INV_SATISFIABILITY  \<equiv> (\<exists> (dummy0 :: (VDMInt \<times> VDMInt))  . (((
		((inv_VDMInt (fst dummy0))\<and>
		 (inv_VDMInt (snd dummy0))
		))) \<longrightarrow> (\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let l = (fst dummy0); r = (snd dummy0) in (l < r))))\<close>

	

\<comment>\<open>VDM source: G2' = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 15:19\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_19_G2'_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_19_G2'_TOTAL  \<equiv> (\<forall> (g :: (VDMInt \<times> VDMInt))  . (((
		((inv_VDMInt (fst g))\<and>
		 (inv_VDMInt (snd g))
		))) \<longrightarrow> isTest ((inv_G2' g)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: G2' = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 14:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_20_G2'_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_20_G2'_INV_SATISFIABILITY  \<equiv> (\<exists> (g :: (VDMInt \<times> VDMInt))  . (((
		((inv_VDMInt (fst g))\<and>
		 (inv_VDMInt (snd g))
		))) \<longrightarrow> ((fst (g)) < (snd (g)))))\<close>

	

\<comment>\<open>VDM source: TSet = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 18:22\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_21_TSet_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_21_TSet_TOTAL  \<equiv> (\<forall> (s :: VDMNat1 VDMSet)  . ((((inv_VDMSet' (inv_VDMNat1) s))) \<longrightarrow> isTest ((inv_TSet s)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSet = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 17:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_22_TSet_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_22_TSet_INV_SATISFIABILITY  \<equiv> (\<exists> (s :: VDMNat1 VDMSet)  . ((((inv_VDMSet' (inv_VDMNat1) s))) \<longrightarrow> (s \<noteq> {})))\<close>

	

\<comment>\<open>VDM source: TSet = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 19:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_23_TSet_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_23_TSet_TOTAL  \<equiv> (\<forall> (s1 :: VDMNat1 VDMSet)   (s2 :: VDMNat1 VDMSet)  . ((((inv_VDMSet' (inv_VDMNat1) s1)))  \<and>  (((inv_VDMSet' (inv_VDMNat1) s2))) \<longrightarrow> isTest ((eq_TSet s1  s2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSet = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 19:9\<close>


definition
	PO_24_TSet_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_24_TSet_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TSet)  . ((((inv_TSet x))) \<longrightarrow> (eq_TSet x  x))) \<and> ((\<forall> (x :: TSet)  (y :: TSet)  . ((((inv_TSet x))) \<and>  (((inv_TSet y))) \<longrightarrow> ((eq_TSet x  y) \<longrightarrow> (eq_TSet y  x)))) \<and> (\<forall> (x :: TSet)  (y :: TSet)  (z :: TSet)  . ((((inv_TSet x))) \<and>  (((inv_TSet y))) \<and>  (((inv_TSet z))) \<longrightarrow> (((eq_TSet x  y) \<and> (eq_TSet y  z)) \<longrightarrow> (eq_TSet x  z))))))\<close>

	

\<comment>\<open>VDM source: TSet = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 20:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_25_TSet_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_25_TSet_TOTAL  \<equiv> (\<forall> (s1 :: VDMNat1 VDMSet)   (s2 :: VDMNat1 VDMSet)  . ((((inv_VDMSet' (inv_VDMNat1) s1)))  \<and>  (((inv_VDMSet' (inv_VDMNat1) s2))) \<longrightarrow> isTest ((ord_TSet s1  s2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSet = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 20:9\<close>


definition
	PO_26_TSet_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_26_TSet_STRICT_ORDER  \<equiv> ((\<forall> (x :: TSet)  . ((((inv_TSet x))) \<longrightarrow> (\<not> (ord_TSet x  x)))) \<and> (\<forall> (x :: TSet)  (y :: TSet)  (z :: TSet)  . ((((inv_TSet x))) \<and>  (((inv_TSet y))) \<and>  (((inv_TSet z))) \<longrightarrow> (((ord_TSet x  y) \<and> (ord_TSet y  z)) \<longrightarrow> (ord_TSet x  z)))))\<close>

	

\<comment>\<open>VDM source: TSet2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 24:21\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_27_TSet2_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_27_TSet2_TOTAL  \<equiv> (\<forall> (s :: TSet)  . ((((inv_TSet s))) \<longrightarrow> isTest ((inv_TSet2 s)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSet2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 23:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_28_TSet2_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_28_TSet2_INV_SATISFIABILITY  \<equiv> (\<exists> (s :: TSet)  . ((((inv_TSet s))) \<longrightarrow> ((vdm_card s) > (10::VDMNat1))))\<close>

	

\<comment>\<open>VDM source: TSet4 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 29:21\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_29_TSet4_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_29_TSet4_TOTAL  \<equiv> (\<forall> (s :: TSet3 VDMSet)  . ((((inv_VDMSet' inv_TSet3 s))) \<longrightarrow> isTest ((inv_TSet4 s)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSet4 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 28:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_30_TSet4_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_30_TSet4_INV_SATISFIABILITY  \<equiv> (\<exists> (s :: TSet3 VDMSet)  . ((((inv_VDMSet' inv_TSet3 s))) \<longrightarrow> ((vdm_card s) > (20::VDMNat1))))\<close>

	

\<comment>\<open>VDM source: TSeq = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 32:33\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_31_TSeq_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_31_TSeq_TOTAL  \<equiv> (\<forall> (s :: VDMNat1 VDMSeq1)  . ((((inv_VDMSeq1' (inv_VDMNat1) s))) \<longrightarrow> isTest ((inv_TSeq s)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSeq = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 31:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_32_TSeq_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_32_TSeq_INV_SATISFIABILITY  \<equiv> (\<exists> (s :: VDMNat1 VDMSeq1)  . ((((inv_VDMSeq1' (inv_VDMNat1) s))) \<longrightarrow> ((vdm_card (elems s)) = (len s))))\<close>

	

\<comment>\<open>VDM source: TSeq = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 33:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_33_TSeq_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_33_TSeq_TOTAL  \<equiv> (\<forall> (s1 :: VDMNat1 VDMSeq1)   (s2 :: VDMNat1 VDMSeq1)  . ((((inv_VDMSeq1' (inv_VDMNat1) s1)))  \<and>  (((inv_VDMSeq1' (inv_VDMNat1) s2))) \<longrightarrow> isTest ((eq_TSeq s1  s2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSeq = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 33:9\<close>


definition
	PO_34_TSeq_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_34_TSeq_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TSeq)  . ((((inv_TSeq x))) \<longrightarrow> (eq_TSeq x  x))) \<and> ((\<forall> (x :: TSeq)  (y :: TSeq)  . ((((inv_TSeq x))) \<and>  (((inv_TSeq y))) \<longrightarrow> ((eq_TSeq x  y) \<longrightarrow> (eq_TSeq y  x)))) \<and> (\<forall> (x :: TSeq)  (y :: TSeq)  (z :: TSeq)  . ((((inv_TSeq x))) \<and>  (((inv_TSeq y))) \<and>  (((inv_TSeq z))) \<longrightarrow> (((eq_TSeq x  y) \<and> (eq_TSeq y  z)) \<longrightarrow> (eq_TSeq x  z))))))\<close>

	

\<comment>\<open>VDM source: TSeq = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 34:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_35_TSeq_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_35_TSeq_TOTAL  \<equiv> (\<forall> (s1 :: VDMNat1 VDMSeq1)   (s2 :: VDMNat1 VDMSeq1)  . ((((inv_VDMSeq1' (inv_VDMNat1) s1)))  \<and>  (((inv_VDMSeq1' (inv_VDMNat1) s2))) \<longrightarrow> isTest ((ord_TSeq s1  s2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSeq = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 34:9\<close>


definition
	PO_36_TSeq_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_36_TSeq_STRICT_ORDER  \<equiv> ((\<forall> (x :: TSeq)  . ((((inv_TSeq x))) \<longrightarrow> (\<not> (ord_TSeq x  x)))) \<and> (\<forall> (x :: TSeq)  (y :: TSeq)  (z :: TSeq)  . ((((inv_TSeq x))) \<and>  (((inv_TSeq y))) \<and>  (((inv_TSeq z))) \<longrightarrow> (((ord_TSeq x  y) \<and> (ord_TSeq y  z)) \<longrightarrow> (ord_TSeq x  z)))))\<close>

	

\<comment>\<open>VDM source: TSeq2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 38:33\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_37_TSeq2_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_37_TSeq2_TOTAL  \<equiv> (\<forall> (s :: TSet VDMSeq1)  . ((((inv_VDMSeq1' inv_TSet s))) \<longrightarrow> isTest ((inv_TSeq2 s)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSeq2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 37:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_38_TSeq2_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_38_TSeq2_INV_SATISFIABILITY  \<equiv> (\<exists> (s :: TSet VDMSeq1)  . ((((inv_VDMSeq1' inv_TSet s))) \<longrightarrow> ((vdm_card (elems s)) = (len s))))\<close>

	

\<comment>\<open>VDM source: TSeq2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 39:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_39_TSeq2_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_39_TSeq2_TOTAL  \<equiv> (\<forall> (s1 :: TSet VDMSeq1)   (s2 :: TSet VDMSeq1)  . ((((inv_VDMSeq1' inv_TSet s1)))  \<and>  (((inv_VDMSeq1' inv_TSet s2))) \<longrightarrow> isTest ((eq_TSeq2 s1  s2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSeq2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 39:9\<close>


definition
	PO_40_TSeq2_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_40_TSeq2_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TSeq2)  . ((((inv_TSeq2 x))) \<longrightarrow> (eq_TSeq2 x  x))) \<and> ((\<forall> (x :: TSeq2)  (y :: TSeq2)  . ((((inv_TSeq2 x))) \<and>  (((inv_TSeq2 y))) \<longrightarrow> ((eq_TSeq2 x  y) \<longrightarrow> (eq_TSeq2 y  x)))) \<and> (\<forall> (x :: TSeq2)  (y :: TSeq2)  (z :: TSeq2)  . ((((inv_TSeq2 x))) \<and>  (((inv_TSeq2 y))) \<and>  (((inv_TSeq2 z))) \<longrightarrow> (((eq_TSeq2 x  y) \<and> (eq_TSeq2 y  z)) \<longrightarrow> (eq_TSeq2 x  z))))))\<close>

	

\<comment>\<open>VDM source: TSeq2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 40:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_41_TSeq2_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_41_TSeq2_TOTAL  \<equiv> (\<forall> (s1 :: TSet VDMSeq1)   (s2 :: TSet VDMSeq1)  . ((((inv_VDMSeq1' inv_TSet s1)))  \<and>  (((inv_VDMSeq1' inv_TSet s2))) \<longrightarrow> isTest ((ord_TSeq2 s1  s2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TSeq2 = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 40:9\<close>


definition
	PO_42_TSeq2_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_42_TSeq2_STRICT_ORDER  \<equiv> ((\<forall> (x :: TSeq2)  . ((((inv_TSeq2 x))) \<longrightarrow> (\<not> (ord_TSeq2 x  x)))) \<and> (\<forall> (x :: TSeq2)  (y :: TSeq2)  (z :: TSeq2)  . ((((inv_TSeq2 x))) \<and>  (((inv_TSeq2 y))) \<and>  (((inv_TSeq2 z))) \<longrightarrow> (((ord_TSeq2 x  y) \<and> (ord_TSeq2 y  z)) \<longrightarrow> (ord_TSeq2 x  z)))))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 44:20\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_43_TMap_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_43_TMap_TOTAL  \<equiv> (\<forall> (m :: (VDMNat1 \<rightharpoonup> VDMNat1))  . ((((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m))) \<longrightarrow> isTest ((inv_TMap m)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 43:5\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_44_TMap_INV_SATISFIABILITY :: \<open>\<bool>\<close>
where
	\<open>PO_44_TMap_INV_SATISFIABILITY  \<equiv> (\<exists> (m :: (VDMNat1 \<rightharpoonup> VDMNat1))  . ((((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m))) \<longrightarrow> ((dom m) \<noteq> {})))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 45:8\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_45_TMap_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_45_TMap_TOTAL  \<equiv> (\<forall> (m1 :: (VDMNat1 \<rightharpoonup> VDMNat1))   (m2 :: (VDMNat1 \<rightharpoonup> VDMNat1))  . ((((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m1)))  \<and>  (((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m2))) \<longrightarrow> isTest ((eq_TMap m1  m2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 45:65\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_46_TMap_MAP_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_46_TMap_MAP_APPLY  \<equiv> (\<forall> (m1 :: (VDMNat1 \<rightharpoonup> VDMNat1))   (m2 :: (VDMNat1 \<rightharpoonup> VDMNat1))  . ((((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m1)))  \<and>  (((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m2))) \<longrightarrow> (((dom m1) = (dom m2)) \<longrightarrow> (\<forall> x \<in> (dom m1)  . (x \<in> (dom m1))))))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 45:73\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_47_TMap_MAP_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_47_TMap_MAP_APPLY  \<equiv> (\<forall> (m1 :: (VDMNat1 \<rightharpoonup> VDMNat1))   (m2 :: (VDMNat1 \<rightharpoonup> VDMNat1))  . ((((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m1)))  \<and>  (((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m2))) \<longrightarrow> (((dom m1) = (dom m2)) \<longrightarrow> (\<forall> x \<in> (dom m1)  . (x \<in> (dom m2))))))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 45:8\<close>


definition
	PO_48_TMap_EQUIV_RELATION :: \<open>\<bool>\<close>
where
	\<open>PO_48_TMap_EQUIV_RELATION  \<equiv> ((\<forall> (x :: TMap)  . ((((inv_TMap x))) \<longrightarrow> (eq_TMap x  x))) \<and> ((\<forall> (x :: TMap)  (y :: TMap)  . ((((inv_TMap x))) \<and>  (((inv_TMap y))) \<longrightarrow> ((eq_TMap x  y) \<longrightarrow> (eq_TMap y  x)))) \<and> (\<forall> (x :: TMap)  (y :: TMap)  (z :: TMap)  . ((((inv_TMap x))) \<and>  (((inv_TMap y))) \<and>  (((inv_TMap z))) \<longrightarrow> (((eq_TMap x  y) \<and> (eq_TMap y  z)) \<longrightarrow> (eq_TMap x  z))))))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 46:9\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_49_TMap_TOTAL :: \<open>\<bool>\<close>
where
	\<open>PO_49_TMap_TOTAL  \<equiv> (\<forall> (m1 :: (VDMNat1 \<rightharpoonup> VDMNat1))   (m2 :: (VDMNat1 \<rightharpoonup> VDMNat1))  . ((((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m1)))  \<and>  (((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m2))) \<longrightarrow> isTest ((ord_TMap m1  m2)) (inv_bool)))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 49:56\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_50_TMap_MAP_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_50_TMap_MAP_APPLY  \<equiv> (\<forall> (m1 :: (VDMNat1 \<rightharpoonup> VDMNat1))   (m2 :: (VDMNat1 \<rightharpoonup> VDMNat1))  . ((((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m1)))  \<and>  (((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m2))) \<longrightarrow> ((\<not> ((dom m1) \<subseteq> (dom m2))) \<longrightarrow> (((dom m1) = (dom m2)) \<longrightarrow> (\<forall> x \<in> (dom m1)  . (x \<in> (dom m1)))))))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 49:64\<close>

\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	
definition
	PO_51_TMap_MAP_APPLY :: \<open>\<bool>\<close>
where
	\<open>PO_51_TMap_MAP_APPLY  \<equiv> (\<forall> (m1 :: (VDMNat1 \<rightharpoonup> VDMNat1))   (m2 :: (VDMNat1 \<rightharpoonup> VDMNat1))  . ((((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m1)))  \<and>  (((inv_VDMMap (inv_VDMNat1) (inv_VDMNat1) m2))) \<longrightarrow> ((\<not> ((dom m1) \<subseteq> (dom m2))) \<longrightarrow> (((dom m1) = (dom m2)) \<longrightarrow> (\<forall> x \<in> (dom m1)  . (x \<in> (dom m2)))))))\<close>

	

\<comment>\<open>VDM source: TMap = ?\<close>
\<comment>\<open>in 'TestV2ITypesStructured' (./lvl0/TestV2ITypesStructured.vdmsl) at line 46:9\<close>


definition
	PO_52_TMap_STRICT_ORDER :: \<open>\<bool>\<close>
where
	\<open>PO_52_TMap_STRICT_ORDER  \<equiv> ((\<forall> (x :: TMap)  . ((((inv_TMap x))) \<longrightarrow> (\<not> (ord_TMap x  x)))) \<and> (\<forall> (x :: TMap)  (y :: TMap)  (z :: TMap)  . ((((inv_TMap x))) \<and>  (((inv_TMap y))) \<and>  (((inv_TMap z))) \<longrightarrow> (((ord_TMap x  y) \<and> (ord_TMap y  z)) \<longrightarrow> (ord_TMap x  z)))))\<close>

	
 

end 