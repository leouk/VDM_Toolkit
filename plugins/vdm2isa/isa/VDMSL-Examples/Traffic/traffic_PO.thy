(* VDM to Isabelle Translation @2022-02-27T11:35:55.631536Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 14:7
files = [./src/test/resources/Examples/Traffic/traffic.vdmsl]
*)
theory traffic_PO
imports traffic
begin


\<comment>\<open>VDM source: Time = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 14:7\<close>
theorem Time_TOTAL_PO1:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (t :: VDMReal)  . ((((inv_VDMReal t))) \<longrightarrow> isTest ((inv_Time t)) (inv_bool))))"
	by simp
	
	
	
	
\<comment>\<open>VDM source: Time = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 13:3\<close>
theorem Time_INV_SATISFIABILITY_PO2:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (t :: VDMReal)  . ((((inv_VDMReal t))) \<longrightarrow> (t \<ge> (0::VDMNat)))))"
	by force
	
	
	
	
\<comment>\<open>VDM source: Conflict = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 20:7\<close>
theorem Conflict_TOTAL_PO3:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (dummy0 :: Conflict)  . (((inv_Conflict dummy0)) \<longrightarrow> (let path1 = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0); path2 = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0) in isTest ((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = path1, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = path2\<rparr>)) (inv_bool)))))"
	
	by simp
	
	
	
	
\<comment>\<open>VDM source: Conflict = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 18:3\<close>
theorem Conflict_INV_SATISFIABILITY_PO4:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (dummy0 :: Conflict)  . (((inv_Conflict dummy0)) \<longrightarrow> (let path1 = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0); path2 = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0) in (path1 \<noteq> path2)))))"
	
	by (metis (full_types) Conflict.select_convs(1) Conflict.select_convs(2) VDMToken.simps(1) list.simps(3))
	
	
	
	
\<comment>\<open>VDM source: Kernel = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 29:7\<close>
theorem Kernel_TOTAL_PO5:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (dummy0 :: Kernel)  . (((inv_Kernel dummy0)) \<longrightarrow> (let ls = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); cs = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in isTest ((inv_Kernel \<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = ls, conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = cs\<rparr>)) (inv_bool)))))"
	
	by fastforce
	
	
	
	
\<comment>\<open>VDM source: Kernel = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 31:15\<close>
theorem Kernel_SUB_TYPE_PO6:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (dummy0 :: Kernel)  . (((inv_Kernel dummy0)) \<longrightarrow> (let ls = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); cs = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in (\<forall> c \<in> cs  . (inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c), path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)\<rparr>))))))"
	
	by (meson inv_Kernel_def inv_SetElems_def inv_VDMSet'_def)
	
	
	
	
\<comment>\<open>VDM source: Kernel = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 34:16\<close>
theorem Kernel_MAP_APPLY_PO7:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (dummy0 :: Kernel)  . (((inv_Kernel dummy0)) \<longrightarrow> (let ls = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); cs = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in (\<forall> c \<in> cs  . ((\<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c), path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)\<rparr> \<in> cs) \<longrightarrow> (((path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)) \<longrightarrow> (((path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)) \<longrightarrow> ((path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls))))))))))"
	
	by fastforce
	
	
	
	
\<comment>\<open>VDM source: Kernel = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 34:39\<close>
theorem Kernel_MAP_APPLY_PO8:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (dummy0 :: Kernel)  . (((inv_Kernel dummy0)) \<longrightarrow> (let ls = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); cs = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in (\<forall> c \<in> cs  . ((\<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c), path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)\<rparr> \<in> cs) \<longrightarrow> (((path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)) \<longrightarrow> (((path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)) \<longrightarrow> ((\<not> (((the(ls (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)))) = Light.U_Red )) \<longrightarrow> ((path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)))))))))))"
	
	by simp
	
	
	
	
\<comment>\<open>VDM source: Kernel = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 27:3\<close>
theorem Kernel_INV_SATISFIABILITY_PO9:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (dummy0 :: Kernel)  . (((inv_Kernel dummy0)) \<longrightarrow> (let ls = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); cs = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in (\<forall> c \<in> cs  . ((\<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c), path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)\<rparr> \<in> cs) \<and> (((path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)) \<and> (((path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c) \<in> (dom ls)) \<and> ((((the(ls (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)))) = Light.U_Red ) \<or> (((the(ls (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t c)))) = Light.U_Red ))))))))))"
	
	by (metis Kernel.select_convs(2) empty_iff)
	
	
	
	
\<comment>\<open>VDM source: LIGHTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 62:12\<close>
theorem LIGHTS_MAP_SEQ_OF_COMPATIBLE_PO10:
	"((\<forall> m1 \<in> {[P1\<mapsto>Light.U_Red ] , [P2\<mapsto>Light.U_Red ] , [P3\<mapsto>Light.U_Green ] , [P4\<mapsto>Light.U_Green ]}  . (\<forall> m2 \<in> {[P1\<mapsto>Light.U_Red ] , [P2\<mapsto>Light.U_Red ] , [P3\<mapsto>Light.U_Green ] , [P4\<mapsto>Light.U_Green ]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((m1 d3) = (m2 d4))))))))"
	
	by (simp add: insertE l_map_dom_ran option.discI singleton_iff)
	
	
	
	
\<comment>\<open>VDM source: CONFLICTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 68:16\<close>
theorem CONFLICTS_SUB_TYPE_PO11:
	"((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P1, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P3\<rparr>))"
	unfolding inv_Conflict_defs by simp
	
	
	
	
\<comment>\<open>VDM source: CONFLICTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 69:16\<close>
theorem CONFLICTS_SUB_TYPE_PO12:
	"((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P1, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P4\<rparr>))"
	unfolding inv_Conflict_defs by simp
	
	
	
\<comment>\<open>VDM source: CONFLICTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 70:16\<close>
theorem CONFLICTS_SUB_TYPE_PO13:
	"((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P2, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P3\<rparr>))"
	unfolding inv_Conflict_defs by simp
	
	
	
\<comment>\<open>VDM source: CONFLICTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 71:16\<close>
theorem CONFLICTS_SUB_TYPE_PO14:
	"((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P2, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P4\<rparr>))"
	unfolding inv_Conflict_defs by simp
	
	
	
	
\<comment>\<open>VDM source: CONFLICTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 72:16\<close>
theorem CONFLICTS_SUB_TYPE_PO15:
	"((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P3, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P1\<rparr>))"
	unfolding inv_Conflict_defs by simp
	
	
	
	
\<comment>\<open>VDM source: CONFLICTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 73:16\<close>
theorem CONFLICTS_SUB_TYPE_PO16:
	"((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P4, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P1\<rparr>))"
	unfolding inv_Conflict_defs by simp
	
	
	
	
\<comment>\<open>VDM source: CONFLICTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 74:16\<close>
theorem CONFLICTS_SUB_TYPE_PO17:
	"((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P3, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P2\<rparr>))"
	unfolding inv_Conflict_defs by simp
	
	
	
	
\<comment>\<open>VDM source: CONFLICTS = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 75:16\<close>
theorem CONFLICTS_SUB_TYPE_PO18:
	"((inv_Conflict \<lparr>path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P4, path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t = P2\<rparr>))"
	unfolding inv_Conflict_defs by simp
	
	
	
	
\<comment>\<open>VDM source: KERNEL = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 78:12\<close>
theorem KERNEL_SUB_TYPE_PO19:
	"((inv_Kernel \<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = LIGHTS, conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = CONFLICTS\<rparr>))"
	unfolding inv_Kernel_defs by simp
	
	
	
	
\<comment>\<open>VDM source: ToGreen = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 91:7\<close>
theorem ToGreen_MAP_APPLY_PO20:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (p :: Path)   (dummy0 :: Kernel)  . ((((inv_Path p)))  \<and>  ((inv_Kernel dummy0)) \<longrightarrow> (let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in ((p \<in> (dom lights)) \<longrightarrow> (p \<in> (dom lights)))))))"
	
	by presburger
	
	
	
	
\<comment>\<open>VDM source: ToGreen = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 93:25\<close>
theorem ToGreen_MAP_APPLY_PO21:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (p :: Path)   (dummy0 :: Kernel)  . ((((inv_Path p)))  \<and>  ((inv_Kernel dummy0)) \<longrightarrow> (let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in ((p \<in> (dom lights)) \<longrightarrow> ((((the(lights p))) = Light.U_Red ) \<longrightarrow> (\<forall> dummy0 \<in> conflicts  . (let p1 = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0); p2 = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0) in ((p = p1) \<longrightarrow> (p2 \<in> (dom lights)))))))))))"
	
	by (meson inv_Kernel_def)
	
	
	
	
\<comment>\<open>VDM source: ToGreen = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 89:5\<close>
theorem ToGreen_SUB_TYPE_PO22:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (p :: Path)   (dummy0 :: Kernel)  . ((((inv_Path p)))  \<and>  ((inv_Kernel dummy0)) \<longrightarrow> (let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in (((p \<in> (dom lights)) \<and> ((((the(lights p))) = Light.U_Red ) \<and> (\<forall> dummy0 \<in> conflicts  . (let p1 = (path1\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0); p2 = (path2\<^sub>C\<^sub>o\<^sub>n\<^sub>f\<^sub>l\<^sub>i\<^sub>c\<^sub>t dummy0) in ((p = p1) \<longrightarrow> (((the(lights p2))) = Light.U_Red )))))) \<longrightarrow> (inv_Kernel \<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = (ChgLight lights   p   Light.U_Green ), conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = conflicts\<rparr>))))))"
	apply (safe, simp add: Let_def, safe)
  unfolding inv_Kernel_defs Let_def apply (simp, safe)
  \<comment> \<open>@LF cases below were sledgehammered\<close>
  apply (simp add: ChgLight_def dagger_finite)
  apply (smt (z3) ChgLight_def antirestr_then_dagger domIff dom_fun_upd l_dagger_apply option.simps(3))
  apply (simp add: ChgLight_def dagger_finite finite_ran)
    apply (simp add: ChgLight_def domD l_dagger_apply)
  apply (simp add: ChgLight_def domD l_dagger_apply)
  by (metis ChgLight_def Conflict.select_convs(1) Conflict.select_convs(2) dom_empty emptyE l_dagger_apply l_inmapupd_dom_iff)
	
\<comment>\<open>VDM source: ToRed = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 100:31\<close>
theorem ToRed_MAP_APPLY_PO23:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (p :: Path)   (dummy0 :: Kernel)  . ((((inv_Path p)))  \<and>  ((inv_Kernel dummy0)) \<longrightarrow> (let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in ((p \<in> (dom lights)) \<longrightarrow> (p \<in> (dom lights)))))))"
	
	by presburger
	
	
	
	
\<comment>\<open>VDM source: ToRed = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 99:5\<close>
theorem ToRed_SUB_TYPE_PO24:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (p :: Path)   (dummy0 :: Kernel)  . ((((inv_Path p)))  \<and>  ((inv_Kernel dummy0)) \<longrightarrow> (let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in (((p \<in> (dom lights)) \<and> (((the(lights p))) = Light.U_Amber )) \<longrightarrow> (inv_Kernel \<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = (ChgLight lights   p   Light.U_Red ), conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = conflicts\<rparr>))))))"
	apply (safe, simp add: Let_def, safe)
  unfolding inv_Kernel_defs Let_def apply (simp, safe)
  \<comment> \<open>@LF cases below were sledgehammered\<close>
  apply (simp add: ChgLight_def dagger_finite)
  apply (smt (z3) ChgLight_def antirestr_then_dagger domIff dom_fun_upd l_dagger_apply option.simps(3))
  apply (simp add: ChgLight_def dagger_finite finite_ran)
    apply (simp add: ChgLight_def domD l_dagger_apply)
   apply (simp add: ChgLight_def domD l_dagger_apply)
  by (metis ChgLight_def Light.distinct(3) dom_eq_singleton_conv option.sel singleton_iff the_dagger_dom_left)
	
	
\<comment>\<open>VDM source: ToAmber = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 107:31\<close>
theorem ToAmber_MAP_APPLY_PO25:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (p :: Path)   (dummy0 :: Kernel)  . ((((inv_Path p)))  \<and>  ((inv_Kernel dummy0)) \<longrightarrow> (let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in ((p \<in> (dom lights)) \<longrightarrow> (p \<in> (dom lights)))))))"
	
	by force
	
	
	
	
\<comment>\<open>VDM source: ToAmber = ?\<close>
\<comment>\<open>in 'traffic' (./src/test/resources/Examples/Traffic/traffic.vdmsl) at line 106:5\<close>
theorem ToAmber_SUB_TYPE_PO26:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (p :: Path)   (dummy0 :: Kernel)  . ((((inv_Path p)))  \<and>  ((inv_Kernel dummy0)) \<longrightarrow> (let lights = (lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0); conflicts = (conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l dummy0) in (((p \<in> (dom lights)) \<and> (((the(lights p))) = Light.U_Green )) \<longrightarrow> (inv_Kernel \<lparr>lights\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = (ChgLight lights   p   Light.U_Amber ), conflicts\<^sub>K\<^sub>e\<^sub>r\<^sub>n\<^sub>e\<^sub>l = conflicts\<rparr>))))))"
	apply (safe, simp add: Let_def, safe)
  unfolding inv_Kernel_defs Let_def apply (simp, safe)
  \<comment> \<open>@LF cases below were sledgehammered\<close>
  apply (simp add: ChgLight_def dagger_finite)
  apply (smt (z3) ChgLight_def antirestr_then_dagger domIff dom_fun_upd l_dagger_apply option.simps(3))
  apply (simp add: ChgLight_def dagger_finite finite_ran)
    apply (simp add: ChgLight_def domD l_dagger_apply)
  apply (simp add: ChgLight_def domD l_dagger_apply)
  by (smt (z3) ChgLight_def Light.distinct(5) l_inmapupd_dom_iff l_map_non_empty_has_elem_conv option.sel the_dagger_dom_left)
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>

\<comment> \<open>@LF 14 sledgehammered ; 9 simplified expansion; 3 proved by combination of specialised simplification and sledgehammer (1 for 3)\<close>

end