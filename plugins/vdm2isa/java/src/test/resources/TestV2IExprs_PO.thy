(* VDM to Isabelle Translation @2021-12-17T14:01:51.177494Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 18:25
files = [./src/test/resources/TestV2IExprs.vdmsl]
*)
theory TestV2IExprs_PO
imports TestV2IExprs
begin


\<comment>\<open>VDM source: t11 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 18:25\<close>
theorem t11_SUB_TYPE:
	"((({(1::VDMNat1)..(5::VDMNat1)} \<noteq> {}) \<and> isTest ({(1::VDMNat1)..(5::VDMNat1)}) (inv_VDMSet1' (inv_VDMNat1))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: t14 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 21:29\<close>
theorem t14_MAP_SEQ_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> m2 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v9 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 33:17\<close>
theorem v9_NON_EMPTY_SET:
	"((t12 \<noteq> {}))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v19 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 43:16\<close>
theorem v19_MAP_SET_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {t14, t15}  . (\<forall> m2 \<in> {t14, t15}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v22 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 46:10\<close>
theorem v22_INVARIANT:
	"(isTest (t14) (inv_Inmap (inv_VDMNat1) (inv_VDMNat1) null))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v44 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 66:10\<close>
theorem v44_MAP_COMPATIBLE:
	"((\<forall> ldom1 \<in> (dom t14)  . (\<forall> rdom2 \<in> (dom t15)  . ((ldom1 = rdom2) \<longrightarrow> ((the(t14 ldom1)) = (the(t15 rdom2)))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v45 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 67:14\<close>
theorem v45_MAP_COMPOSE:
	"(((rng t15) \<subseteq> (dom t14)))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v61 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 83:10\<close>
theorem v61_MAP_SEQ_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> m2 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v722 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 94:39\<close>
theorem v722_SUB_TYPE:
	"((
		let 
(r::VDMReal) = (4.0)
		in
			(if ((inv_VDMReal r)) then
			isTest (r) (inv_VDMNat1)
		 else
			undefined
		)
		))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v723 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 95:20\<close>
theorem v723_SUB_TYPE:
	"(isTest (((6::VDMNat1) / (2::VDMNat1))) (inv_VDMNat1))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v73 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 96:11\<close>
theorem v73_UNIQUE_EXISTENCE:
	"((\<exists>! var \<in> t9  . (var < (2::VDMNat1))))"
	
	oops
	
	
	
\<comment>\<open>VDM source: v80 = ?\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 103:15\<close>
theorem v80_LET_BE_EXISTS:
	"((\<exists> x \<in> t9  . (\<exists> y \<in> t9  . ((x > (2::VDMNat1)) \<and> (y < x)))))"
	
	oops
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "v22"
hide_const "v44"
hide_const "v9"
hide_const "t14"
hide_const "v45"
hide_const "v19"
hide_const "v80"
hide_const "v722"
hide_const "v723"
hide_const "v73"
hide_const "v61"
hide_const "t11"

end