(* VDM to Isabelle Translation @2022-03-01T13:27:00.763152Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 11:7
files = [./src/test/resources/Examples/CMSL/CM.vdmsl]
*)
theory CM_POPS1
imports CM
begin


\<comment>\<open>VDM source: Angle = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 11:7\<close>
theorem Angle_TOTAL_PO1:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (num :: VDMNat)  . ((((inv_VDMNat num))) \<longrightarrow> isTest ((inv_Angle num)) (inv_bool))))"
	by simp
	
	
	
	
\<comment>\<open>VDM source: Angle = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 10:3\<close>
theorem Angle_INV_SATISFIABILITY_PO2:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<exists> (num :: VDMNat)  . ((((inv_VDMNat num))) \<longrightarrow> (num \<le> (360::VDMNat1)))))"
	by blast
	
	
	
	
\<comment>\<open>VDM source: responseDB = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 59:5\<close>
theorem responseDB_MAP_SEQ_OF_COMPATIBLE_PO3:
	"((\<forall> m1 \<in> {[MissileType.U_MissileA \<mapsto>[(FlareType.U_FlareOneA  , (900::VDMNat1)) , (FlareType.U_FlareTwoA  , (500::VDMNat1)) , (FlareType.U_DoNothingA  , (100::VDMNat1)) , (FlareType.U_FlareOneA  , (500::VDMNat1))]] , [MissileType.U_MissileB \<mapsto>[(FlareType.U_FlareTwoB  , (500::VDMNat1)) , (FlareType.U_FlareTwoB  , (700::VDMNat1))]] , [MissileType.U_MissileC \<mapsto>[(FlareType.U_FlareOneC  , (400::VDMNat1)) , (FlareType.U_DoNothingC  , (100::VDMNat1)) , (FlareType.U_FlareTwoC  , (400::VDMNat1)) , (FlareType.U_FlareOneC  , (500::VDMNat1))]]}  . (\<forall> m2 \<in> {[MissileType.U_MissileA \<mapsto>[(FlareType.U_FlareOneA  , (900::VDMNat1)) , (FlareType.U_FlareTwoA  , (500::VDMNat1)) , (FlareType.U_DoNothingA  , (100::VDMNat1)) , (FlareType.U_FlareOneA  , (500::VDMNat1))]] , [MissileType.U_MissileB \<mapsto>[(FlareType.U_FlareTwoB  , (500::VDMNat1)) , (FlareType.U_FlareTwoB  , (700::VDMNat1))]] , [MissileType.U_MissileC \<mapsto>[(FlareType.U_FlareOneC  , (400::VDMNat1)) , (FlareType.U_DoNothingC  , (100::VDMNat1)) , (FlareType.U_FlareTwoC  , (400::VDMNat1)) , (FlareType.U_FlareOneC  , (500::VDMNat1))]]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((m1 d3) = (m2 d4))))))))"
	by auto
	
	
	
	
\<comment>\<open>VDM source: missilePriority = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 72:25\<close>
theorem missilePriority_MAP_SEQ_OF_COMPATIBLE_PO4:
	"((\<forall> m1 \<in> {[MissileType.U_MissileA \<mapsto>(1::VDMNat1)] , [MissileType.U_MissileB \<mapsto>(2::VDMNat1)] , [MissileType.U_MissileC \<mapsto>(3::VDMNat1)] , [MissileType.U_None \<mapsto>(0::VDMNat)]}  . (\<forall> m2 \<in> {[MissileType.U_MissileA \<mapsto>(1::VDMNat1)] , [MissileType.U_MissileB \<mapsto>(2::VDMNat1)] , [MissileType.U_MissileC \<mapsto>(3::VDMNat1)] , [MissileType.U_None \<mapsto>(0::VDMNat)]}  . (\<forall> d3 \<in> (dom m1)  . (\<forall> d4 \<in> (dom m2)  . ((d3 = d4) \<longrightarrow> ((m1 d3) = (m2 d4))))))))"
	by auto
	
	
	
	
\<comment>\<open>VDM source: testval1 = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 79:30\<close>
theorem testval1_SUB_TYPE_PO5:
	"((((inv_Angle (88::VDMNat1)) \<and> isTest ((88::VDMNat1)) (inv_VDMNat)) \<and> (((inv_Angle (70::VDMNat1)) \<and> isTest ((70::VDMNat1)) (inv_VDMNat)) \<and> (((inv_Angle (222::VDMNat1)) \<and> isTest ((222::VDMNat1)) (inv_VDMNat)) \<and> ((inv_Angle (44::VDMNat1)) \<and> isTest ((44::VDMNat1)) (inv_VDMNat))))))"
	unfolding inv_Angle_defs by simp
	
	
	
	
\<comment>\<open>VDM source: testval2 = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 84:30\<close>
theorem testval2_SUB_TYPE_PO6:
	"((((inv_Angle (188::VDMNat1)) \<and> isTest ((188::VDMNat1)) (inv_VDMNat)) \<and> (((inv_Angle (70::VDMNat1)) \<and> isTest ((70::VDMNat1)) (inv_VDMNat)) \<and> (((inv_Angle (2::VDMNat1)) \<and> isTest ((2::VDMNat1)) (inv_VDMNat)) \<and> ((inv_Angle (44::VDMNat1)) \<and> isTest ((44::VDMNat1)) (inv_VDMNat))))))"
	
	unfolding inv_Angle_defs by simp
	
	
	
	
\<comment>\<open>VDM source: testval3 = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 89:30\<close>
theorem testval3_SUB_TYPE_PO7:
	"((((inv_Angle (288::VDMNat1)) \<and> isTest ((288::VDMNat1)) (inv_VDMNat)) \<and> (((inv_Angle (170::VDMNat1)) \<and> isTest ((170::VDMNat1)) (inv_VDMNat)) \<and> (((inv_Angle (222::VDMNat1)) \<and> isTest ((222::VDMNat1)) (inv_VDMNat)) \<and> ((inv_Angle (44::VDMNat1)) \<and> isTest ((44::VDMNat1)) (inv_VDMNat))))))"
	
	unfolding inv_Angle_defs by simp
	
	
	
	(*
	\<comment>\<open>VDM proof obligation `RelativeToAbsoluteTimes_measure_RelativeToAbsoluteTimes` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: RelativeToAbsoluteTimes; measure_RelativeToAbsoluteTimes = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 130:9\<close>
theorem RelativeToAbsoluteTimes_measure_RelativeToAbsoluteTimes_TOTAL_PO8:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ts :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response ts))) \<longrightarrow> isTest ((measure_RelativeToAbsoluteTimes ts)) (inv_VDMNat))))"
	
	oops
	
	
	*)
	
	
\<comment>\<open>VDM source: RelativeToAbsoluteTimes; f, t = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 123:26\<close>
theorem RelativeToAbsoluteTimes_f_t_NON_EMPTY_SEQ_PO9:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ts :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response ts))) \<longrightarrow> ((\<not> (ts = [])) \<longrightarrow> (ts \<noteq> [])))))"
	by meson
	
	
	
	(*
	\<comment>\<open>VDM proof obligation `RelativeToAbsoluteTimes_ns` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: RelativeToAbsoluteTimes; ns = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 118:1\<close>
theorem RelativeToAbsoluteTimes_ns_RECURSIVE_PO10:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ts :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response ts))) \<longrightarrow> ((\<not> (ts = [])) \<longrightarrow> ((measure_RelativeToAbsoluteTimes ts) > (measure_RelativeToAbsoluteTimes (tl ts)))))))"
	
	oops
	
	
	*)
	
	
\<comment>\<open>VDM source: RelativeToAbsoluteTimes; ns = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 125:44\<close>
theorem RelativeToAbsoluteTimes_ns_NON_EMPTY_SEQ_PO11:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (ts :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response ts))) \<longrightarrow> ((\<not> (ts = [])) \<longrightarrow> (ts \<noteq> [])))))"
	by blast
	
	
	
	
\<comment>\<open>VDM source: OutputAtTimeZero; firstFlare = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 136:32\<close>
theorem OutputAtTimeZero_firstFlare_NON_EMPTY_SEQ_PO12:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (response :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response response))) \<longrightarrow> (
		let 
(absTimes::(FlareType \<times> VDMNat) VDMSeq) = (RelativeToAbsoluteTimes response)
		in
			
			(if ((inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (((inv_True dummy1of2)))\<and>
		 (inv_VDMNat dummy2of2)
		) absTimes)) then
			(absTimes \<noteq> [])
		 else
			undefined
		)
		))))"
	nitpick
	oops
	
	
lemma l_CM_AbsTimes_inds: "i \<in> {2..len s} \<Longrightarrow> i - 1 \<in> inds s"	
  by (simp add: l_inds_upto)

lemma l_CM_AbsTimes_post: "inv_VDMSeq' inv_Response response \<Longrightarrow> inv_VDMSeq' (\<lambda>(dummy1of2, y). inv_VDMNat y) (RelativeToAbsoluteTimes response)"   
  apply (induct response)
   apply (simp add: inv_VDMSeq'_defs)
  thm RelativeToAbsoluteTimes.simps
  oops

lemma l_CM_AbsTimes_post_l0: "inv_VDMSeq' inv_Response response \<Longrightarrow> response \<noteq> [] \<Longrightarrow> 
  RelativeToAbsoluteTimes response = [hd response] @ [ (fst n, snd n + snd (hd response)) . n \<leftarrow> tl response ]" 
\<comment> \<open>@LF hard lemma about the inner property of \<^term>\<open>RelativeToAbsoluteTimes\<close>\<close>
  sorry

lemma l_CM_AbsTimes_post_l1: "inv_VDMSeq' inv_Response response \<Longrightarrow> response \<noteq> [] \<Longrightarrow> inv_VDMSeq' (\<lambda>(dummy1of2, y). inv_VDMNat y) (RelativeToAbsoluteTimes response)"
  apply (simp add: l_CM_AbsTimes_post_l0[of response] del: RelativeToAbsoluteTimes.simps)
  apply (simp add: inv_VDMSeq'_defs list_all_def inv_Response_defs)
  apply safe
   apply (metis hd_in_set snd_conv)
  by (meson add_increasing list.set_sel(1) list.set_sel(2))

lemma l_CM_AbsTimes_post: "inv_VDMSeq' inv_Response response \<Longrightarrow> inv_VDMSeq' (\<lambda>(dummy1of2, y). inv_VDMNat y) (RelativeToAbsoluteTimes response)"   
  apply (induct response)
   apply (simp add: inv_VDMSeq'_defs)
  apply (rule l_CM_AbsTimes_post_l1)
  by simp_all

lemma l_CM_AbsTimes_post': "inv_VDMSeq' inv_Response response \<Longrightarrow>
       inv_VDMNat (snd (hd (RelativeToAbsoluteTimes response)))"
  nitpick
  oops

\<comment>\<open>VDM source: OutputAtTimeZero; t = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 138:24\<close>
theorem OutputAtTimeZero_t_SEQ_APPLY_PO13:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (response :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response response))) \<longrightarrow> (
		let 
(absTimes::(FlareType \<times> VDMNat) VDMSeq) = (RelativeToAbsoluteTimes response)
		in
			
			(if ((inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (((inv_True dummy1of2)))\<and>
		 (inv_VDMNat dummy2of2)
		) absTimes)) then
			(
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::(FlareType \<times> VDMNat)) = (hd absTimes)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let firstFlare = (fst dummy0); dummy0_ignore = (snd dummy0) in 
			(if (
		((((inv_True (fst dummy0))))\<and>
		 (inv_VDMNat (snd dummy0))
		)) then
			(\<forall>
		i \<in> {(2::VDMNat1)..(len absTimes)}
		
		.
		((i - (1::VDMNat1)) \<in> (inds absTimes)))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		))))"
	apply (safe, simp del: RelativeToAbsoluteTimes.simps add: Let_def, safe)
	  apply (meson l_CM_AbsTimes_inds)
  using l_CM_AbsTimes_post apply blast
  nitpick
	oops
  
	
	
	
\<comment>\<open>VDM source: OutputAtTimeZero; f = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 139:24\<close>
theorem OutputAtTimeZero_f_SEQ_APPLY_PO14:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (response :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response response))) \<longrightarrow> (
		let 
(absTimes::(FlareType \<times> VDMNat) VDMSeq) = (RelativeToAbsoluteTimes response)
		in
			
			(if ((inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (((inv_True dummy1of2)))\<and>
		 (inv_VDMNat dummy2of2)
		) absTimes)) then
			(
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::(FlareType \<times> VDMNat)) = (hd absTimes)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let firstFlare = (fst dummy0); dummy0_ignore = (snd dummy0) in 
			(if (
		((((inv_True (fst dummy0))))\<and>
		 (inv_VDMNat (snd dummy0))
		)) then
			(\<forall>
		i \<in> {(2::VDMNat1)..(len absTimes)}
		
		.
		(i \<in> (inds absTimes)))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		))))"
	nitpick
	oops
	
	
	
	
\<comment>\<open>VDM source: OutputAtTimeZero'; firstFlare = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 149:32\<close>
theorem OutputAtTimeZero'_firstFlare_NON_EMPTY_SEQ_PO15:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (response :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response response))) \<longrightarrow> (
		let 
(absTimes::(FlareType \<times> VDMNat) VDMSeq) = (RelativeToAbsoluteTimes response)
		in
			
			(if ((inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (((inv_True dummy1of2)))\<and>
		 (inv_VDMNat dummy2of2)
		) absTimes)) then
			(absTimes \<noteq> [])
		 else
			undefined
		)
		))))"
	nitpick
	oops
	
	
	
	
\<comment>\<open>VDM source: OutputAtTimeZero' = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 151:13\<close>
theorem OutputAtTimeZero'_SEQ_APPLY_PO16:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (response :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response response))) \<longrightarrow> (
		let 
(absTimes::(FlareType \<times> VDMNat) VDMSeq) = (RelativeToAbsoluteTimes response)
		in
			
			(if ((inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (((inv_True dummy1of2)))\<and>
		 (inv_VDMNat dummy2of2)
		) absTimes)) then
			(
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::(FlareType \<times> VDMNat)) = (hd absTimes)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let firstFlare = (fst dummy0); dummy0_ignore = (snd dummy0) in 
			(if (
		((((inv_True (fst dummy0))))\<and>
		 (inv_VDMNat (snd dummy0))
		)) then
			(\<forall>
		i \<in> {(2::VDMNat1)..(len absTimes)}
		
		.
		(i \<in> (inds absTimes)))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		))))"
	nitpick
	oops
	
	
	
	
\<comment>\<open>VDM source: OutputAtTimeZero' = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 151:29\<close>
theorem OutputAtTimeZero'_SEQ_APPLY_PO17:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (response :: Response VDMSeq)  . ((((inv_VDMSeq' inv_Response response))) \<longrightarrow> (
		let 
(absTimes::(FlareType \<times> VDMNat) VDMSeq) = (RelativeToAbsoluteTimes response)
		in
			
			(if ((inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (((inv_True dummy1of2)))\<and>
		 (inv_VDMNat dummy2of2)
		) absTimes)) then
			(
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::(FlareType \<times> VDMNat)) = (hd absTimes)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let firstFlare = (fst dummy0); dummy0_ignore = (snd dummy0) in 
			(if (
		((((inv_True (fst dummy0))))\<and>
		 (inv_VDMNat (snd dummy0))
		)) then
			(\<forall>
		i \<in> {(2::VDMNat1)..(len absTimes)}
		
		.
		((i - (1::VDMNat1)) \<in> (inds absTimes)))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		))))"
	nitpick
	oops
	
	
	
	
\<comment>\<open>VDM source: InterruptPlan = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 165:41\<close>
theorem InterruptPlan_MAP_APPLY_PO18:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (curTime :: VDMNat)   (expOutput :: Output)   (plan :: Plan)   (magid :: MagId)  . ((((inv_VDMNat curTime)))  \<and>  (((inv_Output expOutput)))  \<and>  (((inv_Plan plan)))  \<and>  (((inv_MagId magid))) \<longrightarrow> ((magid \<in> (dom expOutput)) \<longrightarrow> (magid \<in> (dom expOutput))))))"
	
	by blast
	
	
	
	
\<comment>\<open>VDM source: InterruptPlan = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 164:3\<close>
theorem InterruptPlan_MAP_COMPATIBLE_PO19:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (curTime :: VDMNat)   (expOutput :: Output)   (plan :: Plan)   (magid :: MagId)  . ((((inv_VDMNat curTime)))  \<and>  (((inv_Output expOutput)))  \<and>  (((inv_Plan plan)))  \<and>  (((inv_MagId magid))) \<longrightarrow> (\<forall> ldom1 \<in> (dom [magid\<mapsto>((
		if ((magid \<in> (dom expOutput))) then
		((LeavePrefixUnchanged ((the(expOutput magid)))  curTime))
		else
		([])) @ (MakeOutputFromPlan curTime  plan))])  . (\<forall> rdom2 \<in> (dom ({magid} -\<triangleleft> expOutput))  . ((ldom1 = rdom2) \<longrightarrow> (((the([magid\<mapsto>((
		if ((magid \<in> (dom expOutput))) then
		((LeavePrefixUnchanged ((the(expOutput magid)))  curTime))
		else
		([])) @ (MakeOutputFromPlan curTime  plan))] ldom1))) = ((the(({magid} -\<triangleleft> expOutput) rdom2))))))))))"
	by (simp add: l_dom_dom_ar)
	
	
	
	(*
	\<comment>\<open>VDM proof obligation `CM_measure_CM` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: CM; measure_CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 197:9\<close>
theorem CM_measure_CM_TOTAL_PO20:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> isTest ((measure_CM missileInputs  outputSoFar  lastMissile  curTime)) (inv_VDMNat))))"
	
	oops
	
	
	*)
	
	
\<comment>\<open>VDM source: CM; curMis, angle = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 177:35\<close>
theorem CM_curMis_angle_NON_EMPTY_SEQ_PO21:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (missileInputs \<noteq> [])))))"
	by meson
	
	
lemma l_CM_MAP_APPLY_l1: "list_all inv_True a"
  using inv_SeqElems_def l_invSeqElems_inv_True_True by blast

lemma l_CM_MAP_APPLY_l2: "inv_VDMToken' (inv_VDMSeq' inv_VDMChar) t"
  unfolding inv_VDMToken'_def inv_VDMSeq'_defs inv_VDMChar_def 
  by (metis VDMToken.case VDMToken.exhaust l_CM_MAP_APPLY_l1)

\<comment>\<open>VDM source: CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 185:14\<close>
theorem CM_MAP_APPLY_PO22:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			((\<not> (magid \<notin> (dom lastMissile))) \<longrightarrow> ((magid \<in> (dom lastMissile)) \<longrightarrow> (curMis \<in> (dom missilePriority))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
	apply (simp add: Let_def, safe)
	  apply (meson MissileType.exhaust)
	unfolding inv_MissileInputs_defs inv_VDMSeq'_def list_all_def apply simp
  apply (erule_tac x="(hd missileInputs)" in ballE)
   apply safe 
  apply force+
  using inv_MagId_defs Angle2MagId_def l_CM_MAP_APPLY_l2 by simp
  
	
\<comment>\<open>VDM source: CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 186:14\<close>
theorem CM_MAP_APPLY_PO23:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			((\<not> (magid \<notin> (dom lastMissile))) \<longrightarrow> ((magid \<in> (dom lastMissile)) \<longrightarrow> (((the((the(lastMissile magid))))) \<in> (dom missilePriority))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
	by (smt (z3) CM_MAP_APPLY_PO22 MissileType.exhaust domIff fun_upd_same l_inmapupd_dom option.distinct(1))
	
	
	
	
\<comment>\<open>VDM source: CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 186:30\<close>
theorem CM_SUB_TYPE_PO24:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			((\<not> (magid \<notin> (dom lastMissile))) \<longrightarrow> ((magid \<in> (dom lastMissile)) \<longrightarrow> (isTest (((the((the(lastMissile magid)))))) (inv_True) \<or> (isTest (((the((the(lastMissile magid)))))) (inv_True) \<or> (isTest (((the((the(lastMissile magid)))))) (inv_True) \<or> isTest (((the((the(lastMissile magid)))))) (inv_True))))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
	by (metis CM_MAP_APPLY_PO22 inv_True_def isTest_def)
	
	
	
	
\<comment>\<open>VDM source: CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 186:30\<close>
theorem CM_MAP_APPLY_PO25:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			((\<not> (magid \<notin> (dom lastMissile))) \<longrightarrow> ((magid \<in> (dom lastMissile)) \<longrightarrow> (magid \<in> (dom lastMissile))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
	by (meson CM_MAP_APPLY_PO22)
	
	
	
	
\<comment>\<open>VDM source: CM; newOutput = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 189:36\<close>
theorem CM_newOutput_MAP_APPLY_PO26:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			(((magid \<notin> (dom lastMissile)) \<or> ((magid \<in> (dom lastMissile)) \<and> (((the(missilePriority curMis))) > ((the(missilePriority ((the((the(lastMissile magid))))))))))) \<longrightarrow> (curMis \<in> (dom responseDB)))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
  
	apply (simp add: Let_def, safe)
  \<comment> \<open>@LF clear consequence of multiple let-defs! Safe = 41 goals\<close>
                      apply (meson CM_MAP_APPLY_PO22)
  using inv_MagId_def l_CM_MAP_APPLY_l2 apply blast
                      apply (meson CM_MAP_APPLY_PO25)
  using inv_MagId_def l_CM_MAP_APPLY_l2 apply blast
                      apply (meson CM_MAP_APPLY_PO25)
  using inv_MagId_def l_CM_MAP_APPLY_l2 apply blast 
  apply (rule_tac x="(Some U_MissileA)" in exI)  
  defer
                      apply (meson CM_MAP_APPLY_PO25)
  using inv_MagId_def l_CM_MAP_APPLY_l2 apply blast
                      defer
                      apply (meson CM_MAP_APPLY_PO25)
  using inv_MagId_def l_CM_MAP_APPLY_l2 apply blast
  apply (rule_tac x="(Some U_MissileC)" in exI)  
  defer  
                      apply (meson CM_MAP_APPLY_PO25)
  using inv_MagId_def l_CM_MAP_APPLY_l2 apply blast
  apply (rule_tac x="(Some U_None)" in exI)  
                      defer
                      apply (meson CM_MAP_APPLY_PO25)
  using inv_MagId_def l_CM_MAP_APPLY_l2 apply blast
                      apply (meson MissileType.exhaust)+
  defer
     apply (rule_tac x="(Some U_MissileB)" in exI)  
  \<comment> \<open>@LF mostly repeated proof. quite annoying "the" etc.\<close>
	oops
	
	
	
	(*
	\<comment>\<open>VDM proof obligation `CM` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 172:1\<close>
theorem CM_RECURSIVE_PO27:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			(((magid \<notin> (dom lastMissile)) \<or> ((magid \<in> (dom lastMissile)) \<and> (((the(missilePriority curMis))) > ((the(missilePriority ((the((the(lastMissile magid))))))))))) \<longrightarrow> (
		let 
(newOutput::Output) = (InterruptPlan curTime  outputSoFar  ((the(responseDB curMis)))  magid)
		;
		
(magidMaplet::(MagId \<rightharpoonup> MissileType option)) = [magid\<mapsto>curMis]
		in
			
			(if (inv_Output newOutput)
	 \<and> 
	((inv_Map inv_MagId (inv_Option inv_MissileType) magidMaplet)) then
			((measure_CM missileInputs  outputSoFar  lastMissile  curTime) > (measure_CM (tl missileInputs)  newOutput  (lastMissile \<dagger> magidMaplet)  (curTime + stepLength)))
		 else
			undefined
		)
		))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
	
	oops
	
	
	*)
	
	
\<comment>\<open>VDM source: CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 192:24\<close>
theorem CM_NON_EMPTY_SEQ_PO28:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			(((magid \<notin> (dom lastMissile)) \<or> ((magid \<in> (dom lastMissile)) \<and> (((the(missilePriority curMis))) > ((the(missilePriority ((the((the(lastMissile magid))))))))))) \<longrightarrow> (
		let 
(newOutput::Output) = (InterruptPlan curTime  outputSoFar  ((the(responseDB curMis)))  magid)
		;
		
\<comment> \<open>@LF missing Some context :-(\<close>
(magidMaplet::(MagId \<rightharpoonup> MissileType option)) = [magid\<mapsto> Some curMis]
		in
			
			(if (inv_Output newOutput)
	 \<and> 
	((inv_Map inv_MagId (inv_Option inv_MissileType) magidMaplet)) then
			(missileInputs \<noteq> [])
		 else
			undefined
		)
		))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
	apply (simp add: Let_def, safe)
  \<comment> \<open>@LF even worse: 392 goals! \<close>
	oops
	
	
	
	(*
	\<comment>\<open>VDM proof obligation `CM` is spurious given Isabelle's encoding of `measures`.\<close>
	
\<comment>\<open>VDM source: CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 172:1\<close>
theorem CM_RECURSIVE_PO29:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			((\<not> ((magid \<notin> (dom lastMissile)) \<or> ((magid \<in> (dom lastMissile)) \<and> (((the(missilePriority curMis))) > ((the(missilePriority ((the((the(lastMissile magid)))))))))))) \<longrightarrow> ((measure_CM missileInputs  outputSoFar  lastMissile  curTime) > (measure_CM (tl missileInputs)  outputSoFar  lastMissile  (curTime + stepLength))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
	
	oops
	
	
	*)
	
	
\<comment>\<open>VDM source: CM = ?\<close>
\<comment>\<open>in 'CM' (./src/test/resources/Examples/CMSL/CM.vdmsl) at line 195:21\<close>
theorem CM_NON_EMPTY_SEQ_PO30:
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	"((\<forall> (missileInputs :: MissileInputs)   (outputSoFar :: Output)   (lastMissile :: (MagId \<rightharpoonup> MissileType option))   (curTime :: VDMNat)  . ((((inv_MissileInputs missileInputs)))  \<and>  (((inv_Output outputSoFar)))  \<and>  (((inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)))  \<and>  (((inv_VDMNat curTime))) \<longrightarrow> ((\<not> (missileInputs = [])) \<longrightarrow> (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::MissileInput) = (hd missileInputs)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let curMis = (fst dummy0); angle = (snd dummy0) in 
			(if (inv_MissileInput dummy0) then
			(
		let 
(magid::MagId) = (Angle2MagId angle)
		in
			
			(if (inv_MagId magid) then
			((\<not> ((magid \<notin> (dom lastMissile)) \<or> ((magid \<in> (dom lastMissile)) \<and> (((the(missilePriority curMis))) > ((the(missilePriority ((the((the(lastMissile magid)))))))))))) \<longrightarrow> (missileInputs \<noteq> []))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))))"
	using CM_MAP_APPLY_PO25 by presburger
	
	
\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>

\<comment> \<open>@LF 13 sledgehammered, 3 simplified expansion, 4 oopsed (recursive), 6 nitpicked, 4 manual needing 6 extra lemmas\<close>
end