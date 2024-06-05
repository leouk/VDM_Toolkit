(* VDM to Isabelle Translation @2022-02-27T12:37:28.416425Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/Examples/Alarm/alarm.vdmsl' at line 1:8
files = [./src/test/resources/Examples/Alarm/alarm.vdmsl]
*)
theory alarm
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Period = token\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 25:3\<close>
type_synonym Period = "VDMChar VDMSeq VDMToken"
	

\<comment>\<open>VDM source: inv_Period: (Period +> bool)
	inv_Period(dummy0) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 25:3\<close>
definition
	inv_Period :: "Period \<Rightarrow> bool"
where
	"inv_Period dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Period` specification.\<close>
		(((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar)) dummy0)))"
 
lemmas inv_Period_defs = inv_Period_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: ExpertId = token\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 27:3\<close>
type_synonym ExpertId = "VDMChar VDMSeq VDMToken"
	

\<comment>\<open>VDM source: inv_ExpertId: (ExpertId +> bool)
	inv_ExpertId(dummy0) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 27:3\<close>
definition
	inv_ExpertId :: "ExpertId \<Rightarrow> bool"
where
	"inv_ExpertId dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ExpertId` specification.\<close>
		(((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar)) dummy0)))"

		 
lemmas inv_ExpertId_defs = inv_ExpertId_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: Qualification = (<Bio> | <Chem> | <Elec> | <Mech>)\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 29:3\<close>
datatype Qualification = U_Bio  | 
		 U_Chem  | 
		 U_Elec  | 
		 U_Mech 
	

\<comment>\<open>VDM source: inv_Qualification: (Qualification +> bool)
	inv_Qualification(dummy0) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 29:3\<close>
definition
	inv_Qualification :: "Qualification \<Rightarrow> bool"
where
	"inv_Qualification dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Qualification` specification.\<close>
		((((inv_True dummy0))))"
 
lemmas inv_Qualification_defs = inv_Qualification_def inv_True_def 


	
	
\<comment>\<open>VDM source: Expert = compose Expert of expertid:ExpertId, quali:set of (Qualification) end
	inv ex == ((ex.quali) <> {})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 31:3\<close>
record Expert = 
	expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t :: "ExpertId"
		 
		 quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t :: "Qualification VDMSet"
	

\<comment>\<open>VDM source: inv_Expert: (Expert +> bool)
	inv_Expert(ex) ==
((ex.quali) <> {})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 33:7\<close>
definition
	inv_Expert :: "Expert \<Rightarrow> bool"
where
	"inv_Expert ex \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Expert` specification.\<close>
		( (((inv_ExpertId (expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t ex))) \<and> 
		 ((inv_VDMSet' (inv_Qualification) (quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t ex))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Expert.\<close>
		((quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t ex) \<noteq> {})"
 
lemmas inv_Expert_defs = inv_Expert_def inv_ExpertId_def inv_Qualification_def inv_True_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: Schedule = map (Period) to (set of (Expert))
	inv sch == (forall exs in set (rng sch) & ((exs <> {}) and (forall ex1, ex2 in set exs & ((ex1 <> ex2) => ((ex1.expertid) <> (ex2.expertid))))))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 35:3\<close>
type_synonym Schedule = "(Period \<rightharpoonup> Expert VDMSet)"
	

\<comment>\<open>VDM source: inv_Schedule: (map (Period) to (set of (Expert)) +> bool)
	inv_Schedule(sch) ==
(forall exs in set (rng sch) & ((exs <> {}) and (forall ex1, ex2 in set exs & ((ex1 <> ex2) => ((ex1.expertid) <> (ex2.expertid))))))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 36:7\<close>
definition
	inv_Schedule :: "Schedule \<Rightarrow> bool"
where
	"inv_Schedule sch \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Schedule` specification.\<close>
		(((inv_Map (inv_Period) (inv_VDMSet' inv_Expert ) sch)))  \<and> 
		\<comment>\<open>User defined body of inv_Schedule.\<close>
		(\<forall> exs \<in> (rng sch)  . ((exs \<noteq> {}) \<and> (\<forall> ex1 \<in> exs  . (\<forall> ex2 \<in> exs  . ((ex1 \<noteq> ex2) \<longrightarrow> ((expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t ex1) \<noteq> (expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t ex2)))))))"

		 
lemmas inv_Schedule_defs = inv_Expert_def inv_ExpertId_def inv_Map_defs inv_Period_def inv_Qualification_def inv_Schedule_def inv_True_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: Alarm = compose Alarm of alarmtext:seq of (char), quali:Qualification end\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 42:3\<close>
record Alarm = 
	alarmtext\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m :: "VDMChar VDMSeq"
		 
		 quali\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m :: "Qualification"
	

\<comment>\<open>VDM source: inv_Alarm: (Alarm +> bool)
	inv_Alarm(dummy0) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 42:3\<close>
definition
	inv_Alarm :: "Alarm \<Rightarrow> bool"
where
	"inv_Alarm dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Alarm` specification.\<close>
		( (((inv_VDMSeq' (inv_VDMChar) (alarmtext\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m dummy0))) \<and> 
		 ((inv_Qualification (quali\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m dummy0))) ))"
 
lemmas inv_Alarm_defs = inv_Alarm_def inv_Qualification_def inv_True_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs 


	
	
\<comment>\<open>VDM source: QualificationOK: (set of (Expert) * Qualification -> bool)
	QualificationOK(exs, reqquali) ==
(exists [ex in set exs] & (reqquali in set (ex.quali)))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 46:3\<close>

\<comment>\<open>VDM source: pre_QualificationOK: (set of (Expert) * Qualification +> bool)
	pre_QualificationOK(exs, reqquali) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 46:3\<close>
definition
	pre_QualificationOK :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> bool"
where
	"pre_QualificationOK exs   reqquali \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_QualificationOK` specification.\<close>
		((inv_VDMSet' inv_Expert  exs)  \<and>  (inv_Qualification reqquali))"


\<comment>\<open>VDM source: post_QualificationOK: (set of (Expert) * Qualification * bool +> bool)
	post_QualificationOK(exs, reqquali, RESULT) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 46:3\<close>
definition
	post_QualificationOK :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_QualificationOK exs   reqquali   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_QualificationOK` specification.\<close>
		((inv_VDMSet' inv_Expert  exs)  \<and>  (inv_Qualification reqquali)  \<and>  (inv_bool RESULT))"

definition
	QualificationOK :: "Expert VDMSet \<Rightarrow> Qualification \<Rightarrow> bool"
where
	"QualificationOK exs   reqquali \<equiv> 
	\<comment>\<open>User defined body of QualificationOK.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(\<exists> ex \<in> exs  . (reqquali \<in> (quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t ex))))"

	
	
\<comment>\<open>VDM source: Plant = compose Plant of schedule:Schedule, alarms:set of (Alarm) end
	inv mk_Plant(schedule, alarms) == (forall a in set alarms & (forall peri in set (dom schedule) & QualificationOK(schedule(peri), (a.quali))))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 52:3\<close>
record Plant = 
	schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t :: "Schedule"
		 
		 alarms\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t :: "Alarm VDMSet"
	

\<comment>\<open>VDM source: inv_Plant: (Plant +> bool)
	inv_Plant(mk_Plant(schedule, alarms)) ==
(forall a in set alarms & (forall peri in set (dom schedule) & QualificationOK(schedule(peri), (a.quali))))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 54:7\<close>
definition
	inv_Plant :: "Plant \<Rightarrow> bool"
where
	"inv_Plant dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Plant` specification.\<close>
		( (((inv_Schedule (schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t dummy0))) \<and> 
		 ((inv_VDMSet' inv_Alarm  (alarms\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let schedule = (schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t dummy0); alarms = (alarms\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t dummy0) in 
		\<comment>\<open>User defined body of inv_Plant.\<close>
		(\<forall> a \<in> alarms  . (\<forall> peri \<in> (dom schedule)  . (QualificationOK ((the(schedule peri)))   (quali\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m a)))))"
 
lemmas inv_Plant_defs = inv_Alarm_def inv_Expert_def inv_ExpertId_def inv_Map_defs inv_Period_def inv_Plant_def inv_Qualification_def inv_Schedule_def inv_True_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: NumberOfExperts: (Period * Plant -> nat)
	NumberOfExperts(peri, plant) ==
(card (plant.schedule)(peri))
	pre (peri in set (dom (plant.schedule)))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 61:3\<close>

\<comment>\<open>VDM source: pre_NumberOfExperts: (Period * Plant +> bool)
	pre_NumberOfExperts(peri, plant) ==
(peri in set (dom (plant.schedule)))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 64:12\<close>
definition
	pre_NumberOfExperts :: "Period \<Rightarrow> Plant \<Rightarrow> bool"
where
	"pre_NumberOfExperts peri   plant \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_NumberOfExperts` specification.\<close>
		((inv_Period peri)  \<and>  inv_Plant plant)  \<and> 
		\<comment>\<open>User defined body of pre_NumberOfExperts.\<close>
		(peri \<in> (dom (schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t plant)))"


\<comment>\<open>VDM source: post_NumberOfExperts: (Period * Plant * nat +> bool)
	post_NumberOfExperts(peri, plant, RESULT) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 61:3\<close>
definition
	post_NumberOfExperts :: "Period \<Rightarrow> Plant \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_NumberOfExperts peri   plant   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_NumberOfExperts` specification.\<close>
		((inv_Period peri)  \<and>  inv_Plant plant  \<and>  (inv_VDMNat RESULT))"

definition
	NumberOfExperts :: "Period \<Rightarrow> Plant \<Rightarrow> VDMNat"
where
	"NumberOfExperts peri   plant \<equiv> 
	\<comment>\<open>User defined body of NumberOfExperts.\<close>
	(vdm_card ((the((schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t plant) peri))))"

	
	
\<comment>\<open>VDM source: ExpertIsOnDuty: (Expert * Plant -> set of (Period))
	ExpertIsOnDuty(ex, mk_Plant(sch, -)) ==
{peri | peri in set (dom sch) & (ex in set sch(peri))}\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 66:3\<close>

\<comment>\<open>VDM source: pre_ExpertIsOnDuty: (Expert * Plant +> bool)
	pre_ExpertIsOnDuty(ex, mk_Plant(sch, -)) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 66:3\<close>
definition
	pre_ExpertIsOnDuty :: "Expert \<Rightarrow> Plant \<Rightarrow> bool"
where
	"pre_ExpertIsOnDuty ex   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_ExpertIsOnDuty` specification.\<close>
		(inv_Expert ex  \<and>  inv_Plant dummy0)"


\<comment>\<open>VDM source: post_ExpertIsOnDuty: (Expert * Plant * set of (Period) +> bool)
	post_ExpertIsOnDuty(ex, mk_Plant(sch, -), RESULT) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 66:3\<close>
definition
	post_ExpertIsOnDuty :: "Expert \<Rightarrow> Plant \<Rightarrow> Period VDMSet \<Rightarrow> bool"
where
	"post_ExpertIsOnDuty ex   dummy0   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_ExpertIsOnDuty` specification.\<close>
		(inv_Expert ex  \<and>  inv_Plant dummy0  \<and>  (inv_VDMSet' (inv_Period) RESULT))"

definition
	ExpertIsOnDuty :: "Expert \<Rightarrow> Plant \<Rightarrow> Period VDMSet"
where
	"ExpertIsOnDuty ex   dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context conversion\<close>
	(let sch = (schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t dummy0); dummy0_ignore = (alarms\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t dummy0) in 
	\<comment>\<open>User defined body of ExpertIsOnDuty.\<close>
	{ peri .   ((peri \<in>(dom sch)))  \<and> (ex \<in> ((the(sch peri)))) })"

	
	
\<comment>\<open>VDM source: static private ExpertToPage((a:Alarm), (peri:Period), (plant:Plant))r:Expert
	pre ((peri in set (dom (plant.schedule))) and (a in set (plant.alarms)))
	post ((r in set (plant.schedule)(peri)) and ((a.quali) in set (r.quali)))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 70:3\<close>

\<comment>\<open>VDM source: pre_ExpertToPage: (Alarm * Period * Plant +> bool)
	pre_ExpertToPage(a, peri, plant) ==
((peri in set (dom (plant.schedule))) and (a in set (plant.alarms)))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 71:38\<close>
definition
	pre_ExpertToPage :: "Alarm \<Rightarrow> Period \<Rightarrow> Plant \<Rightarrow> bool"
where
	"pre_ExpertToPage a   peri   plant \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_ExpertToPage` specification.\<close>
		(inv_Alarm a  \<and>  (inv_Period peri)  \<and>  inv_Plant plant)  \<and> 
		\<comment>\<open>User defined body of pre_ExpertToPage.\<close>
		((peri \<in> (dom (schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t plant))) \<and> (a \<in> (alarms\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t plant)))"


\<comment>\<open>VDM source: post_ExpertToPage: (Alarm * Period * Plant * Expert +> bool)
	post_ExpertToPage(a, peri, plant, r) ==
((r in set (plant.schedule)(peri)) and ((a.quali) in set (r.quali)))\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 73:38\<close>
definition
	post_ExpertToPage :: "Alarm \<Rightarrow> Period \<Rightarrow> Plant \<Rightarrow> Expert \<Rightarrow> bool"
where
	"post_ExpertToPage a   peri   plant   r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_ExpertToPage` specification.\<close>
		(inv_Alarm a  \<and>  (inv_Period peri)  \<and>  inv_Plant plant  \<and>  inv_Expert r)  \<and> 
		\<comment>\<open>User defined body of post_ExpertToPage.\<close>
		((r \<in> ((the((schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t plant) peri)))) \<and> ((quali\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m a) \<in> (quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t r)))"


	
	
\<comment>\<open>VDM source: ChangeExpert: (Plant * Expert * Expert * Period -> Plant)
	ChangeExpert(mk_Plant(plan, alarms), v11, v22, peri) ==
mk_Plant((plan ++ {peri |-> ((plan(peri) \ {v11}) union {v22})}), alarms)\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 77:3\<close>

\<comment>\<open>VDM source: pre_ChangeExpert: (Plant * Expert * Expert * Period +> bool)
	pre_ChangeExpert(mk_Plant(plan, alarms), v11, v22, peri) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 77:3\<close>
definition
	pre_ChangeExpert :: "Plant \<Rightarrow> Expert \<Rightarrow> Expert \<Rightarrow> Period \<Rightarrow> bool"
where
	"pre_ChangeExpert dummy0   v11   v22   peri \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_ChangeExpert` specification.\<close>
		(inv_Plant dummy0  \<and>  inv_Expert v11  \<and>  inv_Expert v22  \<and>  (inv_Period peri))"


\<comment>\<open>VDM source: post_ChangeExpert: (Plant * Expert * Expert * Period * Plant +> bool)
	post_ChangeExpert(mk_Plant(plan, alarms), v11, v22, peri, RESULT) ==
null\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 77:3\<close>
definition
	post_ChangeExpert :: "Plant \<Rightarrow> Expert \<Rightarrow> Expert \<Rightarrow> Period \<Rightarrow> Plant \<Rightarrow> bool"
where
	"post_ChangeExpert dummy0   v11   v22   peri   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_ChangeExpert` specification.\<close>
		(inv_Plant dummy0  \<and>  inv_Expert v11  \<and>  inv_Expert v22  \<and>  (inv_Period peri)  \<and>  inv_Plant RESULT)"

definition
	ChangeExpert :: "Plant \<Rightarrow> Expert \<Rightarrow> Expert \<Rightarrow> Period \<Rightarrow> Plant"
where
	"ChangeExpert dummy0   v11   v22   peri \<equiv> 
	\<comment>\<open>Implicit pattern context conversion\<close>
	(let plan = (schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t dummy0); alarms = (alarms\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t dummy0) in 
	\<comment>\<open>User defined body of ChangeExpert.\<close>
	\<lparr>schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t = (plan \<dagger> [peri\<mapsto>((((the(plan peri))) - {v11}) \<union> {v22})]), alarms\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t = alarms\<rparr>)"

	
	
\<comment>\<open>VDM source: p1:Period = mk_token("Monday day")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 82:3\<close>
abbreviation
	p1 :: "Period"
where
	"p1 \<equiv> (Token (''Monday day''))"

	definition
	inv_p1 :: "\<bool>"
where
	"inv_p1  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))p1"

	
	
	
\<comment>\<open>VDM source: p2:Period = mk_token("Monday night")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 83:3\<close>
abbreviation
	p2 :: "Period"
where
	"p2 \<equiv> (Token (''Monday night''))"

	definition
	inv_p2 :: "\<bool>"
where
	"inv_p2  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))p2"

	
	
	
\<comment>\<open>VDM source: p3:Period = mk_token("Tuesday day")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 84:3\<close>
abbreviation
	p3 :: "Period"
where
	"p3 \<equiv> (Token (''Tuesday day''))"

	definition
	inv_p3 :: "\<bool>"
where
	"inv_p3  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))p3"

	
	
	
\<comment>\<open>VDM source: p4:Period = mk_token("Tuesday night")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 85:3\<close>
abbreviation
	p4 :: "Period"
where
	"p4 \<equiv> (Token (''Tuesday night''))"

	definition
	inv_p4 :: "\<bool>"
where
	"inv_p4  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))p4"

	
	
	
\<comment>\<open>VDM source: p5:Period = mk_token("Wednesday day")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 86:3\<close>
abbreviation
	p5 :: "Period"
where
	"p5 \<equiv> (Token (''Wednesday day''))"

	definition
	inv_p5 :: "\<bool>"
where
	"inv_p5  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))p5"

	
	
	
\<comment>\<open>VDM source: ps:set of (Period) = {p1, p2, p3, p4, p5}\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 87:3\<close>
abbreviation
	ps :: "Period VDMSet"
where
	"ps \<equiv> {p1 , p2 , p3 , p4 , p5}"

	definition
	inv_ps :: "\<bool>"
where
	"inv_ps  \<equiv> (inv_VDMSet' ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar)))) ps)"

	
	
	
\<comment>\<open>VDM source: eid1:ExpertId = mk_token("134")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 90:3\<close>
abbreviation
	eid1 :: "ExpertId"
where
	"eid1 \<equiv> (Token (''134''))"

	definition
	inv_eid1 :: "\<bool>"
where
	"inv_eid1  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))eid1"

	
	
	
\<comment>\<open>VDM source: eid2:ExpertId = mk_token("145")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 91:3\<close>
abbreviation
	eid2 :: "ExpertId"
where
	"eid2 \<equiv> (Token (''145''))"

	definition
	inv_eid2 :: "\<bool>"
where
	"inv_eid2  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))eid2"

	
	
	
\<comment>\<open>VDM source: eid3:ExpertId = mk_token("154")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 92:3\<close>
abbreviation
	eid3 :: "ExpertId"
where
	"eid3 \<equiv> (Token (''154''))"

	definition
	inv_eid3 :: "\<bool>"
where
	"inv_eid3  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))eid3"

	
	
	
\<comment>\<open>VDM source: eid4:ExpertId = mk_token("165")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 93:3\<close>
abbreviation
	eid4 :: "ExpertId"
where
	"eid4 \<equiv> (Token (''165''))"

	definition
	inv_eid4 :: "\<bool>"
where
	"inv_eid4  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))eid4"

	
	
	
\<comment>\<open>VDM source: eid5:ExpertId = mk_token("169")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 94:3\<close>
abbreviation
	eid5 :: "ExpertId"
where
	"eid5 \<equiv> (Token (''169''))"

	definition
	inv_eid5 :: "\<bool>"
where
	"inv_eid5  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))eid5"

	
	
	
\<comment>\<open>VDM source: eid6:ExpertId = mk_token("174")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 95:3\<close>
abbreviation
	eid6 :: "ExpertId"
where
	"eid6 \<equiv> (Token (''174''))"

	definition
	inv_eid6 :: "\<bool>"
where
	"inv_eid6  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))eid6"

	
	
	
\<comment>\<open>VDM source: eid7:ExpertId = mk_token("181")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 96:3\<close>
abbreviation
	eid7 :: "ExpertId"
where
	"eid7 \<equiv> (Token (''181''))"

	definition
	inv_eid7 :: "\<bool>"
where
	"inv_eid7  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))eid7"

	
	
	
\<comment>\<open>VDM source: eid8:ExpertId = mk_token("190")\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 97:3\<close>
abbreviation
	eid8 :: "ExpertId"
where
	"eid8 \<equiv> (Token (''190''))"

	definition
	inv_eid8 :: "\<bool>"
where
	"inv_eid8  \<equiv> ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar))))eid8"

	
	
	
\<comment>\<open>VDM source: e1:Expert = mk_Expert(eid1, {<Elec>})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 99:3\<close>
abbreviation
	e1 :: "Expert"
where
	"e1 \<equiv> \<lparr>expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = eid1, quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = {Qualification.U_Elec }\<rparr>"

	definition
	inv_e1 :: "\<bool>"
where
	"inv_e1  \<equiv> inv_Expert e1"

	
	
	
\<comment>\<open>VDM source: e2:Expert = mk_Expert(eid2, {<Mech>, <Chem>})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 100:3\<close>
abbreviation
	e2 :: "Expert"
where
	"e2 \<equiv> \<lparr>expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = eid2, quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = {Qualification.U_Mech  , Qualification.U_Chem }\<rparr>"

	definition
	inv_e2 :: "\<bool>"
where
	"inv_e2  \<equiv> inv_Expert e2"

	
	
	
\<comment>\<open>VDM source: e3:Expert = mk_Expert(eid3, {<Bio>, <Chem>, <Elec>})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 101:3\<close>
abbreviation
	e3 :: "Expert"
where
	"e3 \<equiv> \<lparr>expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = eid3, quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = {Qualification.U_Bio  , Qualification.U_Chem  , Qualification.U_Elec }\<rparr>"

	definition
	inv_e3 :: "\<bool>"
where
	"inv_e3  \<equiv> inv_Expert e3"

	
	
	
\<comment>\<open>VDM source: e4:Expert = mk_Expert(eid4, {<Bio>})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 102:3\<close>
abbreviation
	e4 :: "Expert"
where
	"e4 \<equiv> \<lparr>expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = eid4, quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = {Qualification.U_Bio }\<rparr>"

	definition
	inv_e4 :: "\<bool>"
where
	"inv_e4  \<equiv> inv_Expert e4"

	
	
	
\<comment>\<open>VDM source: e5:Expert = mk_Expert(eid5, {<Chem>, <Bio>})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 103:3\<close>
abbreviation
	e5 :: "Expert"
where
	"e5 \<equiv> \<lparr>expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = eid5, quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = {Qualification.U_Chem  , Qualification.U_Bio }\<rparr>"

	definition
	inv_e5 :: "\<bool>"
where
	"inv_e5  \<equiv> inv_Expert e5"

	
	
	
\<comment>\<open>VDM source: e6:Expert = mk_Expert(eid6, {<Elec>, <Chem>, <Bio>, <Mech>})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 104:3\<close>
abbreviation
	e6 :: "Expert"
where
	"e6 \<equiv> \<lparr>expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = eid6, quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = {Qualification.U_Elec  , Qualification.U_Chem  , Qualification.U_Bio  , Qualification.U_Mech }\<rparr>"

	definition
	inv_e6 :: "\<bool>"
where
	"inv_e6  \<equiv> inv_Expert e6"

	
	
	
\<comment>\<open>VDM source: e7:Expert = mk_Expert(eid7, {<Elec>, <Mech>})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 105:3\<close>
abbreviation
	e7 :: "Expert"
where
	"e7 \<equiv> \<lparr>expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = eid7, quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = {Qualification.U_Elec  , Qualification.U_Mech }\<rparr>"

	definition
	inv_e7 :: "\<bool>"
where
	"inv_e7  \<equiv> inv_Expert e7"

	
	
	
\<comment>\<open>VDM source: e8:Expert = mk_Expert(eid8, {<Mech>, <Bio>})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 106:3\<close>
abbreviation
	e8 :: "Expert"
where
	"e8 \<equiv> \<lparr>expertid\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = eid8, quali\<^sub>E\<^sub>x\<^sub>p\<^sub>e\<^sub>r\<^sub>t = {Qualification.U_Mech  , Qualification.U_Bio }\<rparr>"

	definition
	inv_e8 :: "\<bool>"
where
	"inv_e8  \<equiv> inv_Expert e8"

	
	
	
\<comment>\<open>VDM source: experts:set of (Expert) = {e1, e2, e3, e4, e5, e6, e7, e8}\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 107:3\<close>
abbreviation
	experts :: "Expert VDMSet"
where
	"experts \<equiv> {e1 , e2 , e3 , e4 , e5 , e6 , e7 , e8}"

	definition
	inv_experts :: "\<bool>"
where
	"inv_experts  \<equiv> (inv_VDMSet' inv_Expert  experts)"

	
	
	
\<comment>\<open>VDM source: s:map (Period) to (set of (Expert)) = {p1 |-> {e7, e5, e1}, p2 |-> {e6}, p3 |-> {e1, e3, e8}, p4 |-> {e6}}\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 109:3\<close>
abbreviation
	s :: "(Period \<rightharpoonup> Expert VDMSet)"
where
	"s \<equiv> [p1\<mapsto>{e7 , e5 , e1},p2\<mapsto>{e6},p3\<mapsto>{e1 , e3 , e8},p4\<mapsto>{e6}]"

	definition
	inv_s :: "\<bool>"
where
	"inv_s  \<equiv> (inv_Map ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar)))) (inv_VDMSet' inv_Expert ) s)"

	
	
	
\<comment>\<open>VDM source: a1:Alarm = mk_Alarm("Power supply missing", <Elec>)\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 115:3\<close>
abbreviation
	a1 :: "Alarm"
where
	"a1 \<equiv> \<lparr>alarmtext\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m = (''Power supply missing''), quali\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m = U_Elec \<rparr>"

	definition
	inv_a1 :: "\<bool>"
where
	"inv_a1  \<equiv> inv_Alarm a1"

	
	
	
\<comment>\<open>VDM source: a2:Alarm = mk_Alarm("Tank overflow", <Mech>)\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 116:3\<close>
abbreviation
	a2 :: "Alarm"
where
	"a2 \<equiv> \<lparr>alarmtext\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m = (''Tank overflow''), quali\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m = U_Mech \<rparr>"

	definition
	inv_a2 :: "\<bool>"
where
	"inv_a2  \<equiv> inv_Alarm a2"

	
	
	
\<comment>\<open>VDM source: a3:Alarm = mk_Alarm("CO2 detected", <Chem>)\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 117:3\<close>
abbreviation
	a3 :: "Alarm"
where
	"a3 \<equiv> \<lparr>alarmtext\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m = (''CO2 detected''), quali\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m = U_Chem \<rparr>"

	definition
	inv_a3 :: "\<bool>"
where
	"inv_a3  \<equiv> inv_Alarm a3"

	
	
	
\<comment>\<open>VDM source: a4:Alarm = mk_Alarm("Biological attack", <Bio>)\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 118:3\<close>
abbreviation
	a4 :: "Alarm"
where
	"a4 \<equiv> \<lparr>alarmtext\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m = (''Biological attack''), quali\<^sub>A\<^sub>l\<^sub>a\<^sub>r\<^sub>m = U_Bio \<rparr>"

	definition
	inv_a4 :: "\<bool>"
where
	"inv_a4  \<equiv> inv_Alarm a4"

	
	
	
\<comment>\<open>VDM source: ALARMS:set of (Alarm) = {a1, a2, a3, a4}\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 119:3\<close>
abbreviation
	ALARMS :: "Alarm VDMSet"
where
	"ALARMS \<equiv> {a1 , a2 , a3 , a4}"

	definition
	inv_ALARMS :: "\<bool>"
where
	"inv_ALARMS  \<equiv> (inv_VDMSet' inv_Alarm  ALARMS)"

	
	
	
\<comment>\<open>VDM source: plant1:Plant = mk_Plant(s, {a1, a2, a3})\<close>
\<comment>\<open>in 'alarm' (./src/test/resources/Examples/Alarm/alarm.vdmsl) at line 121:3\<close>
abbreviation
	plant1 :: "Plant"
where
	"plant1 \<equiv> \<lparr>schedule\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t = s, alarms\<^sub>P\<^sub>l\<^sub>a\<^sub>n\<^sub>t = {a1 , a2 , a3}\<rparr>"

	definition
	inv_plant1 :: "\<bool>"
where
	"inv_plant1  \<equiv> inv_Plant plant1"

	
end