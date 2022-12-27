(* VDM to Isabelle Translation @2022-12-27T12:31:49.545Z  
   Copyright 2019-22, Leo Freitas, leo.freitas@newcastle.ac.uk

   VDM translation of module TestV2IExprs_PO
   in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 18:25
   files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl]
*)
theory TestV2IExprs_PO
imports VDMToolkit "TestV2IExprs" 
begin


\<comment>\<open>VDM source: t11 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 18:25\<close>


definition
	PO_01_t11_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_01_t11_SUB_TYPE  \<equiv> (({(1::VDMNat1)..(5::VDMNat1)} \<noteq> {}) \<and> isTest ({(1::VDMNat1)..(5::VDMNat1)}) (inv_VDMSet1' (inv_VDMNat1)))\<close>

	

\<comment>\<open>VDM source: t14 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 21:29\<close>


definition
	PO_02_t14_MAP_SEQ_OF_COMPATIBLE :: \<open>\<bool>\<close>
where
	\<open>PO_02_t14_MAP_SEQ_OF_COMPATIBLE  \<equiv> (\<forall> m1 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)] , [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> m2 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)] , [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> (((the(m1 d3))) = ((the(m2 d4)))))))))\<close>

	

\<comment>\<open>VDM source: v9 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 33:17\<close>


definition
	PO_03_v9_NON_EMPTY_SET :: \<open>\<bool>\<close>
where
	\<open>PO_03_v9_NON_EMPTY_SET  \<equiv> (t12 \<noteq> {})\<close>

	

\<comment>\<open>VDM source: v19 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 43:16\<close>


definition
	PO_04_v19_MAP_SET_OF_COMPATIBLE :: \<open>\<bool>\<close>
where
	\<open>PO_04_v19_MAP_SET_OF_COMPATIBLE  \<equiv> (\<forall> m1 \<in> {t14 , t15}  . (\<forall> m2 \<in> {t14 , t15}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> (((the(m1 d3))) = ((the(m2 d4)))))))))\<close>

	

\<comment>\<open>VDM source: v22 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 46:10\<close>


definition
	PO_05_v22_INVARIANT :: \<open>\<bool>\<close>
where
	\<open>PO_05_v22_INVARIANT  \<equiv> isTest (t14) (inv_VDMInmap (inv_VDMNat1) (inv_VDMNat1))\<close>

	

\<comment>\<open>VDM source: v44 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 66:10\<close>


definition
	PO_06_v44_MAP_COMPATIBLE :: \<open>\<bool>\<close>
where
	\<open>PO_06_v44_MAP_COMPATIBLE  \<equiv> (\<forall> ldom1 \<in> (dom t14)  . (\<forall> rdom2 \<in> (dom t15)  . ((ldom1 = rdom2) \<longrightarrow> (((the(t14 ldom1))) = ((the(t15 rdom2)))))))\<close>

	

\<comment>\<open>VDM source: v45 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 67:14\<close>


definition
	PO_07_v45_MAP_COMPOSE :: \<open>\<bool>\<close>
where
	\<open>PO_07_v45_MAP_COMPOSE  \<equiv> ((rng t15) \<subseteq> (dom t14))\<close>

	

\<comment>\<open>VDM source: v61 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 83:10\<close>


definition
	PO_08_v61_MAP_SEQ_OF_COMPATIBLE :: \<open>\<bool>\<close>
where
	\<open>PO_08_v61_MAP_SEQ_OF_COMPATIBLE  \<equiv> (\<forall> m1 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)] , [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> m2 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)] , [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> (((the(m1 d3))) = ((the(m2 d4)))))))))\<close>

	

\<comment>\<open>VDM source: v722 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 94:39\<close>


definition
	PO_09_v722_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_09_v722_SUB_TYPE  \<equiv> (
		let (r::VDMReal) = (4.0)
		in
			
			(if ((inv_VDMReal r)) then
			isTest (r) (inv_VDMNat1)
		 else
			undefined
		)
		)\<close>

	

\<comment>\<open>VDM source: v723 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 95:20\<close>


definition
	PO_10_v723_SUB_TYPE :: \<open>\<bool>\<close>
where
	\<open>PO_10_v723_SUB_TYPE  \<equiv> isTest (((6::VDMNat1) / (2::VDMNat1))) (inv_VDMNat1)\<close>

	

\<comment>\<open>VDM source: v73 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 96:11\<close>


definition
	PO_11_v73_UNIQUE_EXISTENCE :: \<open>\<bool>\<close>
where
	\<open>PO_11_v73_UNIQUE_EXISTENCE  \<equiv> (\<exists>! var \<in> t9  . (var < (2::VDMNat1)))\<close>

	

\<comment>\<open>VDM source: v80 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/target/test-classes/lvl0/TestV2IExprs.vdmsl) at line 103:15\<close>


definition
	PO_12_v80_LET_BE_EXISTS :: \<open>\<bool>\<close>
where
	\<open>PO_12_v80_LET_BE_EXISTS  \<equiv> (\<exists> x \<in> t9  . (\<exists> y \<in> t9  . ((x > (2::VDMNat1)) \<and> (y < x))))\<close>

	
 

end 