(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 7:5files = [./src/test/resources/TestV2I.vdmsl]
*)
theory TestV2I_PO
imports TestV2I
begin


theorem R_INV_SATISFIABILITY:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (r :: R)  . (((
		(((inv_VDMNat (x\<^sub>R r))) \<and>
	 ((inv_VDMNat (y\<^sub>R r)))
		))) \<longrightarrow> ((x\<^sub>R (r)) < (y\<^sub>R (r))))))"
	
	oops
	
	
theorem mkr_SUB_TYPE:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (n :: VDMNat)  . ((((inv_VDMNat n))) \<longrightarrow> (inv_R \<lparr>x\<^sub>R = n, y\<^sub>R = (n + (1::VDMNat1))\<rparr>))))"
	
	oops
	
	
theorem t11_SUB_TYPE:
	"((({(1::VDMNat1)..(5::VDMNat1)} \<noteq> {}) \<and> not yet))"
	
	oops
	
	
theorem t14_MAP_SEQ_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> m2 \<in> {[(1::VDMNat1)\<mapsto>(1::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
theorem v9_NON_EMPTY_SET:
	"((t12 \<noteq> {}))"
	
	oops
	
	
theorem v19_MAP_SET_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {t14, t15}  . (\<forall> m2 \<in> {t14, t15}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
theorem v22_INVARIANT:
	"(not yet)"
	
	oops
	
	
theorem v44_MAP_COMPATIBLE:
	"((\<forall> ldom1 \<in> (dom t14)  . (\<forall> rdom2 \<in> (dom t15)  . ((ldom1 = rdom2) \<longrightarrow> ((the(t14 ldom1)) = (the(t15 rdom2)))))))"
	
	oops
	
	
theorem v45_MAP_COMPOSE:
	"(((rng t15) \<subseteq> (dom t14)))"
	
	oops
	
	
theorem v61_MAP_SEQ_OF_COMPATIBLE:
	"((\<forall> m1 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> m2 \<in> {[(1::VDMNat1)\<mapsto>(2::VDMNat1)], [(2::VDMNat1)\<mapsto>(3::VDMNat1)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((the(m1 d3)) = (the(m2 d4)))))))))"
	
	oops
	
	
theorem v65_SUB_TYPE:
	"((inv_R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"
	
	oops
	
	
theorem v651_SUB_TYPE:
	"((inv_R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"
	
	oops
	
	
theorem v722_SUB_TYPE:
	"((
		let (r::VDMReal) = (4.0)
		in
			(if ((inv_VDMReal r)) then
			not yet
		 else
			undefined
		)
		))"
	
	oops
	
	
theorem v723_SUB_TYPE:
	"(not yet)"
	
	oops
	
	
theorem v73_UNIQUE_EXISTENCE:
	"((\<exists>! var \<in> t9  . (var < (2::VDMNat1))))"
	
	oops
	
end