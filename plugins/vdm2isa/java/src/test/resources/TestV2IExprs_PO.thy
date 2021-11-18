(* VDM to Isabelle Translation @2021-11-18T13:45:02.339946Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 18:25
files = [./src/test/resources/TestV2IExprs.vdmsl]
*)
theory TestV2IExprs_PO
imports TestV2IExprs
begin


\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 18:25\<close>
theorem t11_SUB_TYPE:
	"((({(1::VDMNat1)..(5::VDMNat1)} \<noteq> {}) \<and> not yet))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 21:29\<close>
theorem t14_MAP_SEQ_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> m2 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 33:17\<close>
theorem v9_NON_EMPTY_SET:
	"((t12 \<noteq> {}))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 43:16\<close>
theorem v19_MAP_SET_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {t14, t15}  . (\<forall> m2 \<in> {t14, t15}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 46:10\<close>
theorem v22_INVARIANT:
	"(not yet)"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 69:10\<close>
theorem v44_MAP_COMPATIBLE:
	"((\<forall> ldom1 \<in> (dom t14)  . (\<forall> rdom2 \<in> (dom t15)  . ((ldom1 = rdom2) \<longrightarrow> ((the(t14 ldom1)) = (the(t15 rdom2)))))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 70:14\<close>
theorem v45_MAP_COMPOSE:
	"(((rng t15) \<subseteq> (dom t14)))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 86:10\<close>
theorem v61_MAP_SEQ_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> m2 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 97:39\<close>
theorem v722_SUB_TYPE:
	"((
		let 
(r::VDMReal) = (4.0)
		in
			(if ((inv_VDMReal r)) then
			not yet
		 else
			undefined
		)
		))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 98:20\<close>
theorem v723_SUB_TYPE:
	"(not yet)"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 99:11\<close>
theorem v73_UNIQUE_EXISTENCE:
	"((\<exists>! var \<in> t9  . (var < (2::VDMNat1))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 117:37\<close>
theorem v93_SUB_TYPE:
	"(((\<not> (None = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)))) \<longrightarrow> (\<exists> (v :: VDMNat option)  . ((((inv_Option (inv_VDMNat) v))) \<longrightarrow> ((\<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v)) = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37))) \<longrightarrow> (
		let 
(v::VDMNat option) = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37))
		in
			(if ((inv_Option (inv_VDMNat) v)) then
			not yet
		 else
			undefined
		)
		))))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 117:39\<close>
theorem v93_SUB_TYPE:
	"(((\<not> (None = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)))) \<longrightarrow> (\<exists> (v :: VDMNat option)  . ((((inv_Option (inv_VDMNat) v))) \<longrightarrow> ((\<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v)) = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37))) \<longrightarrow> (
		let 
(v::VDMNat option) = \<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37))
		in
			(if ((inv_Option (inv_VDMNat) v)) then
			not yet
		 else
			undefined
		)
		))))))"
	
	oops
	
	
	
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 117:11\<close>
theorem v93_CASES_EXHAUSTIVE:
	"(((\<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)) = None) \<or> (\<exists> (v :: VDMNat option)  . ((((inv_Option (inv_VDMNat) v))) \<longrightarrow> (\<comment>\<open>Optional type variable `v37` might not need extra @{term the} operator!\<close>(the(v37)) = \<comment>\<open>Optional type variable `v` might not need extra @{term the} operator!\<close>(the(v)))))))"
	
	oops
	
	
end