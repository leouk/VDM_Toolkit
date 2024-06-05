(* VDM to Isabelle Translation @2022-03-02T08:26:14.538Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in '/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl' at line 1:8
files = [/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl]
*)
theory CM
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: MissileType = (<MissileA> | <MissileB> | <MissileC> | <None>)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 8:3\<close>
datatype MissileType = U_MissileA  | 
		 U_MissileB  | 
		 U_MissileC  | 
		 U_None 
	

\<comment>\<open>VDM source: inv_MissileType: (MissileType +> bool)
	inv_MissileType(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 8:3\<close>
definition
	inv_MissileType :: "MissileType \<Rightarrow> bool"
where
	"inv_MissileType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_MissileType` specification.\<close>
		((((inv_True dummy0))))"
 
lemmas inv_MissileType_defs = inv_MissileType_def inv_True_def 


	
	
\<comment>\<open>VDM source: Angle = nat
	inv num == (num <= 360)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 10:3\<close>
type_synonym Angle = "VDMNat"
	

\<comment>\<open>VDM source: inv_Angle: (nat +> bool)
	inv_Angle(num) ==
(num <= 360)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 11:7\<close>
definition
	inv_Angle :: "Angle \<Rightarrow> bool"
where
	"inv_Angle num \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Angle` specification.\<close>
		(((inv_VDMNat num)))  \<and> 
		\<comment>\<open>User defined body of inv_Angle.\<close>
		(num \<le> (360::VDMNat1))"
 
lemmas inv_Angle_defs = inv_Angle_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: MissileInput = (MissileType * Angle)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 13:3\<close>
type_synonym MissileInput = "(MissileType \<times> Angle)"
	

\<comment>\<open>VDM source: inv_MissileInput: (MissileInput +> bool)
	inv_MissileInput(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 13:3\<close>
definition
	inv_MissileInput :: "MissileInput \<Rightarrow> bool"
where
	"inv_MissileInput dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_MissileInput` specification.\<close>
		((
		((inv_MissileType (fst dummy0))\<and>
		 (inv_Angle (snd dummy0))
		)))"

		 
lemmas inv_MissileInput_defs = inv_Angle_def inv_MissileInput_def inv_MissileType_def inv_True_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: MissileInputs = seq of (MissileInput)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 15:3\<close>
type_synonym MissileInputs = "MissileInput VDMSeq"
	

\<comment>\<open>VDM source: inv_MissileInputs: (MissileInputs +> bool)
	inv_MissileInputs(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 15:3\<close>
definition
	inv_MissileInputs :: "MissileInputs \<Rightarrow> bool"
where
	"inv_MissileInputs dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_MissileInputs` specification.\<close>
		(((inv_VDMSeq' (
		(\<lambda> (dummy1of2, dummy2of2) . (inv_MissileType dummy1of2)\<and>
		 (inv_Angle dummy2of2)
		)) dummy0)))"
 
lemmas inv_MissileInputs_defs = inv_Angle_def inv_MissileInput_def inv_MissileInputs_def inv_MissileType_def inv_True_def inv_VDMNat_def inv_VDMSeq'_def inv_VDMSeq'_defs 


	
	
\<comment>\<open>VDM source: MagId = token\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 17:3\<close>
type_synonym MagId = "VDMChar VDMSeq VDMToken"
	

\<comment>\<open>VDM source: inv_MagId: (MagId +> bool)
	inv_MagId(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 17:3\<close>
definition
	inv_MagId :: "MagId \<Rightarrow> bool"
where
	"inv_MagId dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_MagId` specification.\<close>
		(((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar)) dummy0)))"
 
lemmas inv_MagId_defs = inv_MagId_def inv_VDMChar_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: AbsTime = nat\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 19:3\<close>
type_synonym AbsTime = "VDMNat"
	

\<comment>\<open>VDM source: inv_AbsTime: (AbsTime +> bool)
	inv_AbsTime(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 19:3\<close>
definition
	inv_AbsTime :: "AbsTime \<Rightarrow> bool"
where
	"inv_AbsTime dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_AbsTime` specification.\<close>
		(((inv_VDMNat dummy0)))"
 
lemmas inv_AbsTime_defs = inv_AbsTime_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: FlareType = (<DoNothingA> | <DoNothingB> | <DoNothingC> | <FlareOneA> | <FlareOneB> | <FlareOneC> | <FlareTwoA> | <FlareTwoB> | <FlareTwoC>)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 21:3\<close>
datatype FlareType = U_DoNothingA  | 
		 U_DoNothingB  | 
		 U_DoNothingC  | 
		 U_FlareOneA  | 
		 U_FlareOneB  | 
		 U_FlareOneC  | 
		 U_FlareTwoA  | 
		 U_FlareTwoB  | 
		 U_FlareTwoC 
	

\<comment>\<open>VDM source: inv_FlareType: (FlareType +> bool)
	inv_FlareType(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 21:3\<close>
definition
	inv_FlareType :: "FlareType \<Rightarrow> bool"
where
	"inv_FlareType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FlareType` specification.\<close>
		((((inv_True dummy0))))"
 
lemmas inv_FlareType_defs = inv_FlareType_def inv_True_def 


	
	
\<comment>\<open>VDM source: OutputStep = (FlareType * AbsTime)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 25:3\<close>
type_synonym OutputStep = "(FlareType \<times> AbsTime)"
	

\<comment>\<open>VDM source: inv_OutputStep: (OutputStep +> bool)
	inv_OutputStep(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 25:3\<close>
definition
	inv_OutputStep :: "OutputStep \<Rightarrow> bool"
where
	"inv_OutputStep dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_OutputStep` specification.\<close>
		((
		((inv_FlareType (fst dummy0))\<and>
		 (inv_AbsTime (snd dummy0))
		)))"

		 
lemmas inv_OutputStep_defs = inv_AbsTime_def inv_FlareType_def inv_OutputStep_def inv_True_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: OutputStepRecord = compose OutputStepRecord of x:FlareType, y:AbsTime end\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 31:3\<close>
record OutputStepRecord = 
	x\<^sub>O\<^sub>u\<^sub>t\<^sub>p\<^sub>u\<^sub>t\<^sub>S\<^sub>t\<^sub>e\<^sub>p\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d :: "FlareType"
		 
		 y\<^sub>O\<^sub>u\<^sub>t\<^sub>p\<^sub>u\<^sub>t\<^sub>S\<^sub>t\<^sub>e\<^sub>p\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d :: "AbsTime"
	

\<comment>\<open>VDM source: inv_OutputStepRecord: (OutputStepRecord +> bool)
	inv_OutputStepRecord(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 31:3\<close>
definition
	inv_OutputStepRecord :: "OutputStepRecord \<Rightarrow> bool"
where
	"inv_OutputStepRecord dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_OutputStepRecord` specification.\<close>
		( (((inv_FlareType (x\<^sub>O\<^sub>u\<^sub>t\<^sub>p\<^sub>u\<^sub>t\<^sub>S\<^sub>t\<^sub>e\<^sub>p\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d dummy0))) \<and> 
		 ((inv_AbsTime (y\<^sub>O\<^sub>u\<^sub>t\<^sub>p\<^sub>u\<^sub>t\<^sub>S\<^sub>t\<^sub>e\<^sub>p\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d dummy0))) ))"

		
lemmas inv_OutputStepRecord_defs = inv_AbsTime_def inv_FlareType_def inv_OutputStepRecord_def inv_True_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: Output = map (MagId) to (seq of (OutputStep))\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 35:3\<close>
type_synonym Output = "(MagId \<rightharpoonup> OutputStep VDMSeq)"
	

\<comment>\<open>VDM source: inv_Output: (Output +> bool)
	inv_Output(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 35:3\<close>
definition
	inv_Output :: "Output \<Rightarrow> bool"
where
	"inv_Output dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Output` specification.\<close>
		(((inv_Map ((inv_VDMToken' (inv_VDMSeq' (inv_VDMChar)))) (inv_VDMSeq' (
		(\<lambda> (dummy1of2, dummy2of2) . (inv_FlareType dummy1of2)\<and>
		 (inv_AbsTime dummy2of2)
		))) dummy0)))"
 
lemmas inv_Output_defs = inv_AbsTime_def inv_FlareType_def inv_MagId_def inv_Map_defs inv_Output_def inv_OutputStep_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq'_def inv_VDMSeq'_defs inv_VDMToken'_def 


	
	
\<comment>\<open>VDM source: Response = (FlareType * nat)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 37:3\<close>
type_synonym Response = "(FlareType \<times> VDMNat)"
	

\<comment>\<open>VDM source: inv_Response: (Response +> bool)
	inv_Response(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 37:3\<close>
definition
	inv_Response :: "Response \<Rightarrow> bool"
where
	"inv_Response dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Response` specification.\<close>
		((
		((inv_FlareType (fst dummy0))\<and>
		 (inv_VDMNat (snd dummy0))
		)))"

		 
lemmas inv_Response_defs = inv_FlareType_def inv_Response_def inv_True_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: Delay = nat\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 39:3\<close>
type_synonym Delay = "VDMNat"
	

\<comment>\<open>VDM source: inv_Delay: (Delay +> bool)
	inv_Delay(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 39:3\<close>
definition
	inv_Delay :: "Delay \<Rightarrow> bool"
where
	"inv_Delay dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Delay` specification.\<close>
		(((inv_VDMNat dummy0)))"
 
lemmas inv_Delay_defs = inv_Delay_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: Plan = seq of ((FlareType * Delay))\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 41:3\<close>
type_synonym Plan = "(FlareType \<times> Delay) VDMSeq"
	

\<comment>\<open>VDM source: inv_Plan: (Plan +> bool)
	inv_Plan(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 41:3\<close>
definition
	inv_Plan :: "Plan \<Rightarrow> bool"
where
	"inv_Plan dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Plan` specification.\<close>
		(((inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (inv_FlareType dummy1of2)\<and>
		 (inv_Delay dummy2of2)
		) dummy0)))"
 
lemmas inv_Plan_defs = inv_Delay_def inv_FlareType_def inv_Plan_def inv_True_def inv_VDMNat_def inv_VDMSeq'_def inv_VDMSeq'_defs 


	
	
\<comment>\<open>VDM source: FlareProd = (FlareType * Delay)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 47:3\<close>
type_synonym FlareProd = "(FlareType \<times> Delay)"
	

\<comment>\<open>VDM source: inv_FlareProd: (FlareProd +> bool)
	inv_FlareProd(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 47:3\<close>
definition
	inv_FlareProd :: "FlareProd \<Rightarrow> bool"
where
	"inv_FlareProd dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FlareProd` specification.\<close>
		((
		((inv_FlareType (fst dummy0))\<and>
		 (inv_Delay (snd dummy0))
		)))"

		 
lemmas inv_FlareProd_defs = inv_Delay_def inv_FlareProd_def inv_FlareType_def inv_True_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: Plan2 = seq of (FlareProd)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 48:3\<close>
type_synonym Plan2 = "FlareProd VDMSeq"
	

\<comment>\<open>VDM source: inv_Plan2: (Plan2 +> bool)
	inv_Plan2(dummy0) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 48:3\<close>
definition
	inv_Plan2 :: "Plan2 \<Rightarrow> bool"
where
	"inv_Plan2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Plan2` specification.\<close>
		(((inv_VDMSeq' (
		(\<lambda> (dummy1of2, dummy2of2) . (inv_FlareType dummy1of2)\<and>
		 (inv_Delay dummy2of2)
		)) dummy0)))"

		 
lemmas inv_Plan2_defs = inv_Delay_def inv_FlareProd_def inv_FlareType_def inv_Plan2_def inv_True_def inv_VDMNat_def inv_VDMSeq'_def inv_VDMSeq'_defs 


	
	
\<comment>\<open>VDM source: plan1:Plan = [mk_(<FlareOneA>, 900), mk_(<FlareTwoA>, 500), mk_(<DoNothingA>, 100), mk_(<FlareOneA>, 500)]\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 52:3\<close>
abbreviation
	plan1 :: "Plan"
where
	"plan1 \<equiv> [(FlareType.U_FlareOneA  , (900::VDMNat1)) , (FlareType.U_FlareTwoA  , (500::VDMNat1)) , (FlareType.U_DoNothingA  , (100::VDMNat1)) , (FlareType.U_FlareOneA  , (500::VDMNat1))]"

	definition
	inv_plan1 :: "\<bool>"
where
	"inv_plan1  \<equiv> inv_Plan plan1"

	
	
	
\<comment>\<open>VDM source: plan2:Plan2 = [mk_(<FlareOneA>, 900), mk_(<FlareTwoA>, 500), mk_(<DoNothingA>, 100), mk_(<FlareOneA>, 500)]\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 55:3\<close>
abbreviation
	plan2 :: "Plan2"
where
	"plan2 \<equiv> [(FlareType.U_FlareOneA  , (900::VDMNat1)) , (FlareType.U_FlareTwoA  , (500::VDMNat1)) , (FlareType.U_DoNothingA  , (100::VDMNat1)) , (FlareType.U_FlareOneA  , (500::VDMNat1))]"

	definition
	inv_plan2 :: "\<bool>"
where
	"inv_plan2  \<equiv> inv_Plan2 plan2"

	
	
	
\<comment>\<open>VDM source: responseDB:map (MissileType) to (Plan) = {<MissileA> |-> [mk_(<FlareOneA>, 900), mk_(<FlareTwoA>, 500), mk_(<DoNothingA>, 100), mk_(<FlareOneA>, 500)], <MissileB> |-> [mk_(<FlareTwoB>, 500), mk_(<FlareTwoB>, 700)], <MissileC> |-> [mk_(<FlareOneC>, 400), mk_(<DoNothingC>, 100), mk_(<FlareTwoC>, 400), mk_(<FlareOneC>, 500)]}\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 58:3\<close>
abbreviation
	responseDB :: "(MissileType \<rightharpoonup> Plan)"
where
	"responseDB \<equiv> [MissileType.U_MissileA \<mapsto>[(FlareType.U_FlareOneA  , (900::VDMNat1)) , (FlareType.U_FlareTwoA  , (500::VDMNat1)) , (FlareType.U_DoNothingA  , (100::VDMNat1)) , (FlareType.U_FlareOneA  , (500::VDMNat1))],MissileType.U_MissileB \<mapsto>[(FlareType.U_FlareTwoB  , (500::VDMNat1)) , (FlareType.U_FlareTwoB  , (700::VDMNat1))],MissileType.U_MissileC \<mapsto>[(FlareType.U_FlareOneC  , (400::VDMNat1)) , (FlareType.U_DoNothingC  , (100::VDMNat1)) , (FlareType.U_FlareTwoC  , (400::VDMNat1)) , (FlareType.U_FlareOneC  , (500::VDMNat1))]]"

	definition
	inv_responseDB :: "\<bool>"
where
	"inv_responseDB  \<equiv> (inv_Map inv_MissileType inv_Plan responseDB)"

	
	
	
\<comment>\<open>VDM source: responseDB2:map (MissileType) to (Plan2) = responseDB\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 69:3\<close>
abbreviation
	responseDB2 :: "(MissileType \<rightharpoonup> Plan2)"
where
	"responseDB2 \<equiv> responseDB"

	definition
	inv_responseDB2 :: "\<bool>"
where
	"inv_responseDB2  \<equiv> (inv_Map inv_MissileType inv_Plan2 responseDB2)"

	
	
	
\<comment>\<open>VDM source: missilePriority:map (MissileType) to (nat) = {<MissileA> |-> 1, <MissileB> |-> 2, <MissileC> |-> 3, <None> |-> 0}\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 71:3\<close>
abbreviation
	missilePriority :: "(MissileType \<rightharpoonup> VDMNat)"
where
	"missilePriority \<equiv> [MissileType.U_MissileA \<mapsto>(1::VDMNat1),MissileType.U_MissileB \<mapsto>(2::VDMNat1),MissileType.U_MissileC \<mapsto>(3::VDMNat1),MissileType.U_None \<mapsto>(0::VDMNat)]"

	definition
	inv_missilePriority :: "\<bool>"
where
	"inv_missilePriority  \<equiv> (inv_Map inv_MissileType (inv_VDMNat) missilePriority)"

	
	
	
\<comment>\<open>VDM source: stepLength:nat = 100\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 77:3\<close>
abbreviation
	stepLength :: "VDMNat"
where
	"stepLength \<equiv> (100::VDMNat1)"

	definition
	inv_stepLength :: "\<bool>"
where
	"inv_stepLength  \<equiv> (inv_VDMNat stepLength)"

	
	
	
\<comment>\<open>VDM source: testval1:MissileInputs = [mk_(<MissileA>, 88), mk_(<MissileB>, 70), mk_(<MissileA>, 222), mk_(<MissileC>, 44)]\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 79:3\<close>
abbreviation
	testval1 :: "MissileInputs"
where
	"testval1 \<equiv> [(MissileType.U_MissileA  , (88::VDMNat1)) , (MissileType.U_MissileB  , (70::VDMNat1)) , (MissileType.U_MissileA  , (222::VDMNat1)) , (MissileType.U_MissileC  , (44::VDMNat1))]"

	definition
	inv_testval1 :: "\<bool>"
where
	"inv_testval1  \<equiv> inv_MissileInputs testval1"

	
	
	
\<comment>\<open>VDM source: testval2:MissileInputs = [mk_(<MissileC>, 188), mk_(<MissileB>, 70), mk_(<MissileA>, 2), mk_(<MissileC>, 44)]\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 84:3\<close>
abbreviation
	testval2 :: "MissileInputs"
where
	"testval2 \<equiv> [(MissileType.U_MissileC  , (188::VDMNat1)) , (MissileType.U_MissileB  , (70::VDMNat1)) , (MissileType.U_MissileA  , (2::VDMNat1)) , (MissileType.U_MissileC  , (44::VDMNat1))]"

	definition
	inv_testval2 :: "\<bool>"
where
	"inv_testval2  \<equiv> inv_MissileInputs testval2"

	
	
	
\<comment>\<open>VDM source: testval3:MissileInputs = [mk_(<MissileA>, 288), mk_(<MissileB>, 170), mk_(<MissileA>, 222), mk_(<MissileC>, 44)]\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 89:3\<close>
abbreviation
	testval3 :: "MissileInputs"
where
	"testval3 \<equiv> [(MissileType.U_MissileA  , (288::VDMNat1)) , (MissileType.U_MissileB  , (170::VDMNat1)) , (MissileType.U_MissileA  , (222::VDMNat1)) , (MissileType.U_MissileC  , (44::VDMNat1))]"

	definition
	inv_testval3 :: "\<bool>"
where
	"inv_testval3  \<equiv> inv_MissileInputs testval3"

	
	
	
\<comment>\<open>VDM source: Angle2MagId: (Angle -> MagId)
	Angle2MagId(angle) ==
(if (angle < 90)
then mk_token("Magazine 1")
elseif (angle < 180)
then mk_token("Magazine 2")
elseif (angle < 270)
then mk_token("Magazine 3")
else mk_token("Magazine 4"))\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 96:1\<close>

\<comment>\<open>VDM source: pre_Angle2MagId: (Angle +> bool)
	pre_Angle2MagId(angle) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 96:1\<close>
definition
	pre_Angle2MagId :: "Angle \<Rightarrow> bool"
where
	"pre_Angle2MagId angle \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_Angle2MagId` specification.\<close>
		((inv_Angle angle))"


\<comment>\<open>VDM source: post_Angle2MagId: (Angle * MagId +> bool)
	post_Angle2MagId(angle, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 96:1\<close>
definition
	post_Angle2MagId :: "Angle \<Rightarrow> MagId \<Rightarrow> bool"
where
	"post_Angle2MagId angle   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_Angle2MagId` specification.\<close>
		((inv_Angle angle)  \<and>  (inv_MagId RESULT))"

definition
	Angle2MagId :: "Angle \<Rightarrow> MagId"
where
	"Angle2MagId angle \<equiv> 
	\<comment>\<open>User defined body of Angle2MagId.\<close>
	(
		if ((angle < (90::VDMNat1))) then
		((Token (''Magazine 1'')))
		else if ((angle < (180::VDMNat1))) then
		((Token (''Magazine 2'')))
		
		
		else if ((angle < (270::VDMNat1))) then
		((Token (''Magazine 3'')))
		else
		((Token (''Magazine 4''))))"

	
	
\<comment>\<open>VDM source: LeavePrefixUnchangedRecord: (seq of (OutputStepRecord) * nat -> seq of (OutputStepRecord))
	LeavePrefixUnchangedRecord(output_l, curTime) ==
[oid | oid in seq output_l & let mk_OutputStepRecord(-, t):OutputStepRecord = oid in (t <= curTime)]\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 106:1\<close>

\<comment>\<open>VDM source: pre_LeavePrefixUnchangedRecord: (seq of (OutputStepRecord) * nat +> bool)
	pre_LeavePrefixUnchangedRecord(output_l, curTime) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 106:1\<close>
definition
	pre_LeavePrefixUnchangedRecord :: "OutputStepRecord VDMSeq \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_LeavePrefixUnchangedRecord output_l   curTime \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_LeavePrefixUnchangedRecord` specification.\<close>
		((inv_VDMSeq' inv_OutputStepRecord  output_l)  \<and>  (inv_VDMNat curTime))"


\<comment>\<open>VDM source: post_LeavePrefixUnchangedRecord: (seq of (OutputStepRecord) * nat * seq of (OutputStepRecord) +> bool)
	post_LeavePrefixUnchangedRecord(output_l, curTime, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 106:1\<close>
definition
	post_LeavePrefixUnchangedRecord :: "OutputStepRecord VDMSeq \<Rightarrow> VDMNat \<Rightarrow> OutputStepRecord VDMSeq \<Rightarrow> bool"
where
	"post_LeavePrefixUnchangedRecord output_l   curTime   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_LeavePrefixUnchangedRecord` specification.\<close>
		((inv_VDMSeq' inv_OutputStepRecord  output_l)  \<and>  (inv_VDMNat curTime)  \<and>  (inv_VDMSeq' inv_OutputStepRecord  RESULT))"

definition
	LeavePrefixUnchangedRecord :: "OutputStepRecord VDMSeq \<Rightarrow> VDMNat \<Rightarrow> OutputStepRecord VDMSeq"
where
	"LeavePrefixUnchangedRecord output_l   curTime \<equiv> 
	\<comment>\<open>User defined body of LeavePrefixUnchangedRecord.\<close>
	[ oid . oid \<leftarrow> output_l , ((oid \<in>(elems output_l))) , (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::OutputStepRecord) = oid
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let dummy0_ignore = (x\<^sub>O\<^sub>u\<^sub>t\<^sub>p\<^sub>u\<^sub>t\<^sub>S\<^sub>t\<^sub>e\<^sub>p\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d dummy0); t = (y\<^sub>O\<^sub>u\<^sub>t\<^sub>p\<^sub>u\<^sub>t\<^sub>S\<^sub>t\<^sub>e\<^sub>p\<^sub>R\<^sub>e\<^sub>c\<^sub>o\<^sub>r\<^sub>d dummy0) in 
			(if (inv_OutputStepRecord  dummy0) then
			(t \<le> curTime)
		 else
			undefined
		)
		) ]"

	
	
\<comment>\<open>VDM source: LeavePrefixUnchanged: (seq of (OutputStep) * nat -> seq of (OutputStep))
	LeavePrefixUnchanged(output_l, curTime) ==
[oid | oid in seq output_l & let mk_(-, t):OutputStep = oid in (t <= curTime)]\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 112:1\<close>

\<comment>\<open>VDM source: pre_LeavePrefixUnchanged: (seq of (OutputStep) * nat +> bool)
	pre_LeavePrefixUnchanged(output_l, curTime) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 112:1\<close>
definition
	pre_LeavePrefixUnchanged :: "OutputStep VDMSeq \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_LeavePrefixUnchanged output_l   curTime \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_LeavePrefixUnchanged` specification.\<close>
		((inv_VDMSeq' inv_OutputStep output_l)  \<and>  (inv_VDMNat curTime))"


\<comment>\<open>VDM source: post_LeavePrefixUnchanged: (seq of (OutputStep) * nat * seq of (OutputStep) +> bool)
	post_LeavePrefixUnchanged(output_l, curTime, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 112:1\<close>
definition
	post_LeavePrefixUnchanged :: "OutputStep VDMSeq \<Rightarrow> VDMNat \<Rightarrow> OutputStep VDMSeq \<Rightarrow> bool"
where
	"post_LeavePrefixUnchanged output_l   curTime   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_LeavePrefixUnchanged` specification.\<close>
		((inv_VDMSeq' inv_OutputStep output_l)  \<and>  (inv_VDMNat curTime)  \<and>  (inv_VDMSeq' inv_OutputStep RESULT))"

definition
	LeavePrefixUnchanged :: "OutputStep VDMSeq \<Rightarrow> VDMNat \<Rightarrow> OutputStep VDMSeq"
where
	"LeavePrefixUnchanged output_l   curTime \<equiv> 
	\<comment>\<open>User defined body of LeavePrefixUnchanged.\<close>
	[ oid . oid \<leftarrow> output_l , ((oid \<in>(elems output_l))) , (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::OutputStep) = oid
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let dummy0_ignore = (fst dummy0); t = (snd dummy0) in 
			(if (inv_OutputStep dummy0) then
			(t \<le> curTime)
		 else
			undefined
		)
		) ]"

	
	
\<comment>\<open>VDM source: RelativeToAbsoluteTimes: (seq of (Response) -> seq of ((FlareType * nat)))
	RelativeToAbsoluteTimes(ts) ==
(if (ts = [])
then []
else let mk_(f, t):Response = (hd ts), ns:seq of ((FlareType * nat)) = RelativeToAbsoluteTimes((tl ts)) in ([mk_(f, t)] ^ [let mk_(nf, nt):(FlareType * nat) = n in mk_(nf, (nt + t)) | n in seq ns]))
	measure (len ts)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 118:1\<close>

\<comment>\<open>VDM source: pre_RelativeToAbsoluteTimes: (seq of (Response) +> bool)
	pre_RelativeToAbsoluteTimes(ts) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 118:1\<close>
definition
	pre_RelativeToAbsoluteTimes :: "Response VDMSeq \<Rightarrow> bool"
where
	"pre_RelativeToAbsoluteTimes ts \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_RelativeToAbsoluteTimes` specification.\<close>
		((inv_VDMSeq' inv_Response ts))"


\<comment>\<open>VDM source: post_RelativeToAbsoluteTimes: (seq of (Response) * seq of ((FlareType * nat)) +> bool)
	post_RelativeToAbsoluteTimes(ts, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 118:1\<close>
definition
	post_RelativeToAbsoluteTimes :: "Response VDMSeq \<Rightarrow> (FlareType \<times> VDMNat) VDMSeq \<Rightarrow> bool"
where
	"post_RelativeToAbsoluteTimes ts   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_RelativeToAbsoluteTimes` specification.\<close>
		((inv_VDMSeq' inv_Response ts)  \<and>  (inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (inv_FlareType dummy1of2)\<and>
		 (inv_VDMNat dummy2of2)
		) RESULT))"

fun
	RelativeToAbsoluteTimes :: "Response VDMSeq \<Rightarrow> (FlareType \<times> VDMNat) VDMSeq"
where
	"RelativeToAbsoluteTimes ts = 
	\<comment>\<open>User defined body of RelativeToAbsoluteTimes.\<close>
	(
		if ((ts = [])) then
		([])
		else
		((
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::Response) = (hd ts)
		;
		
(ns::(FlareType \<times> VDMNat) VDMSeq) = (RelativeToAbsoluteTimes (tl ts))
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let f = (fst dummy0); t = (snd dummy0) in 
		
			(if (inv_Response dummy0)
	 \<and> 
	((inv_VDMSeq' 
		(\<lambda> (dummy1of2, dummy2of2) . (((inv_True dummy1of2)))\<and>
		 (inv_VDMNat dummy2of2)
		) ns)) then
			([(f , t)] @ [ (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::(FlareType \<times> VDMNat)) = n
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let nf = (fst dummy0); nt = (snd dummy0) in 
			(if (
		((((inv_True (fst dummy0))))\<and>
		 (inv_VDMNat (snd dummy0))
		)) then
			(nf , (nt + t))
		 else
			undefined
		)
		) . n \<leftarrow> ns , ((n \<in>(elems ns))) ])
		 else
			undefined
		)
		)))"

	
	
\<comment>\<open>VDM source: OutputAtTimeZero: (seq of (Response) -> seq of (OutputStep))
	OutputAtTimeZero(response) ==
let absTimes:seq of ((FlareType * nat)) = RelativeToAbsoluteTimes(response) in let mk_(firstFlare, -):(FlareType * nat) = (hd absTimes) in ([mk_(firstFlare, 0)] ^ [let mk_(-, t):(FlareType * nat) = absTimes((i - 1)), mk_(f, -):(FlareType * nat) = absTimes(i) in mk_(f, t) | i in set {2, ... ,(len absTimes)}])\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 134:1\<close>

\<comment>\<open>VDM source: pre_OutputAtTimeZero: (seq of (Response) +> bool)
	pre_OutputAtTimeZero(response) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 134:1\<close>
definition
	pre_OutputAtTimeZero :: "Response VDMSeq \<Rightarrow> bool"
where
	"pre_OutputAtTimeZero response \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_OutputAtTimeZero` specification.\<close>
		((inv_VDMSeq' inv_Response response))"


\<comment>\<open>VDM source: post_OutputAtTimeZero: (seq of (Response) * seq of (OutputStep) +> bool)
	post_OutputAtTimeZero(response, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 134:1\<close>
definition
	post_OutputAtTimeZero :: "Response VDMSeq \<Rightarrow> OutputStep VDMSeq \<Rightarrow> bool"
where
	"post_OutputAtTimeZero response   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_OutputAtTimeZero` specification.\<close>
		((inv_VDMSeq' inv_Response response)  \<and>  (inv_VDMSeq' inv_OutputStep RESULT))"

definition
	OutputAtTimeZero :: "Response VDMSeq \<Rightarrow> OutputStep VDMSeq"
where
	"OutputAtTimeZero response \<equiv> 
	\<comment>\<open>User defined body of OutputAtTimeZero.\<close>
	(
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
			([(firstFlare , (0::VDMNat))] @ [ (
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::(FlareType \<times> VDMNat)) = (absTimes$(i - (1::VDMNat1)))
		;
		
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::(FlareType \<times> VDMNat)) = (absTimes$i)
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let dummy0_ignore = (fst dummy0); t = (snd dummy0) in 
		\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let f = (fst dummy0); dummy0_ignore = (snd dummy0) in 
			(if (
		((((inv_True (fst dummy0))))\<and>
		 (inv_VDMNat (snd dummy0))
		))
	 \<and> 
	(
		((((inv_True (fst dummy0))))\<and>
		 (inv_VDMNat (snd dummy0))
		)) then
			(f , t)
		 else
			undefined
		)
		) . i \<leftarrow> sorted_list_of_set ({(2::VDMNat1)..(len absTimes)}) , ((i \<in>{(2::VDMNat1)..(len absTimes)})) ])
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: OutputAtTimeZero': (seq of (Response) -> seq of (OutputStep))
	OutputAtTimeZero'(response) ==
let absTimes:seq of ((FlareType * nat)) = RelativeToAbsoluteTimes(response) in let mk_(firstFlare, -):(FlareType * nat) = (hd absTimes) in ([mk_(firstFlare, 0)] ^ [mk_((absTimes(i).#1), (absTimes((i - 1)).#2)) | i in set {2, ... ,(len absTimes)}])\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 147:1\<close>

\<comment>\<open>VDM source: pre_OutputAtTimeZero': (seq of (Response) +> bool)
	pre_OutputAtTimeZero'(response) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 147:1\<close>
definition
	pre_OutputAtTimeZero' :: "Response VDMSeq \<Rightarrow> bool"
where
	"pre_OutputAtTimeZero' response \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_OutputAtTimeZero'` specification.\<close>
		((inv_VDMSeq' inv_Response response))"


\<comment>\<open>VDM source: post_OutputAtTimeZero': (seq of (Response) * seq of (OutputStep) +> bool)
	post_OutputAtTimeZero'(response, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 147:1\<close>
definition
	post_OutputAtTimeZero' :: "Response VDMSeq \<Rightarrow> OutputStep VDMSeq \<Rightarrow> bool"
where
	"post_OutputAtTimeZero' response   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_OutputAtTimeZero'` specification.\<close>
		((inv_VDMSeq' inv_Response response)  \<and>  (inv_VDMSeq' inv_OutputStep RESULT))"

definition
	OutputAtTimeZero' :: "Response VDMSeq \<Rightarrow> OutputStep VDMSeq"
where
	"OutputAtTimeZero' response \<equiv> 
	\<comment>\<open>User defined body of OutputAtTimeZero'.\<close>
	(
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
			([(firstFlare , (0::VDMNat))] @ [ ((fst ((absTimes$i))) , (snd ((absTimes$(i - (1::VDMNat1)))))) . i \<leftarrow> sorted_list_of_set ({(2::VDMNat1)..(len absTimes)}) , ((i \<in>{(2::VDMNat1)..(len absTimes)})) ])
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: MakeOutputFromPlan: (nat * seq of (Response) -> seq of (OutputStep))
	MakeOutputFromPlan(curTime, response) ==
let outputLF:seq of (OutputStep) = OutputAtTimeZero(response) in [let mk_(flare, t):OutputStep = oid in mk_(flare, (t + curTime)) | oid in seq outputLF]\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 154:1\<close>

\<comment>\<open>VDM source: pre_MakeOutputFromPlan: (nat * seq of (Response) +> bool)
	pre_MakeOutputFromPlan(curTime, response) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 154:1\<close>
definition
	pre_MakeOutputFromPlan :: "VDMNat \<Rightarrow> Response VDMSeq \<Rightarrow> bool"
where
	"pre_MakeOutputFromPlan curTime   response \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_MakeOutputFromPlan` specification.\<close>
		((inv_VDMNat curTime)  \<and>  (inv_VDMSeq' inv_Response response))"


\<comment>\<open>VDM source: post_MakeOutputFromPlan: (nat * seq of (Response) * seq of (OutputStep) +> bool)
	post_MakeOutputFromPlan(curTime, response, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 154:1\<close>
definition
	post_MakeOutputFromPlan :: "VDMNat \<Rightarrow> Response VDMSeq \<Rightarrow> OutputStep VDMSeq \<Rightarrow> bool"
where
	"post_MakeOutputFromPlan curTime   response   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_MakeOutputFromPlan` specification.\<close>
		((inv_VDMNat curTime)  \<and>  (inv_VDMSeq' inv_Response response)  \<and>  (inv_VDMSeq' inv_OutputStep RESULT))"

definition
	MakeOutputFromPlan :: "VDMNat \<Rightarrow> Response VDMSeq \<Rightarrow> OutputStep VDMSeq"
where
	"MakeOutputFromPlan curTime   response \<equiv> 
	\<comment>\<open>User defined body of MakeOutputFromPlan.\<close>
	(
		let 
(outputLF::OutputStep VDMSeq) = (OutputAtTimeZero response)
		in
			
			(if ((inv_VDMSeq' inv_OutputStep outputLF)) then
			[
		(
		let 
	\<comment>\<open>Implicit pattern context projection for `let-bind definition`\<close>
	
(dummy0::OutputStep) = oid
		in
			\<comment>\<open>Implicit pattern context projection for `pattern list`\<close>
	 let flare = (fst dummy0); t = (snd dummy0) in 
			(if (inv_OutputStep dummy0) then
			(flare , (t + curTime))
		 else
			undefined
		)
		)
		.
		oid \<leftarrow> outputLF
		,
		((oid \<in>(elems outputLF)))
		]
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: InterruptPlan: (nat * Output * Plan * MagId -> Output)
	InterruptPlan(curTime, expOutput, plan, magid) ==
({magid |-> ((if (magid in set (dom expOutput))
then LeavePrefixUnchanged(expOutput(magid), curTime)
else []) ^ MakeOutputFromPlan(curTime, plan))} munion ({magid} <-: expOutput))\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 163:1\<close>

\<comment>\<open>VDM source: pre_InterruptPlan: (nat * Output * Plan * MagId +> bool)
	pre_InterruptPlan(curTime, expOutput, plan, magid) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 163:1\<close>
definition
	pre_InterruptPlan :: "VDMNat \<Rightarrow> Output \<Rightarrow> Plan \<Rightarrow> MagId \<Rightarrow> bool"
where
	"pre_InterruptPlan curTime   expOutput   plan   magid \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_InterruptPlan` specification.\<close>
		((inv_VDMNat curTime)  \<and>  (inv_Output expOutput)  \<and>  (inv_Plan plan)  \<and>  (inv_MagId magid))"


\<comment>\<open>VDM source: post_InterruptPlan: (nat * Output * Plan * MagId * Output +> bool)
	post_InterruptPlan(curTime, expOutput, plan, magid, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 163:1\<close>
definition
	post_InterruptPlan :: "VDMNat \<Rightarrow> Output \<Rightarrow> Plan \<Rightarrow> MagId \<Rightarrow> Output \<Rightarrow> bool"
where
	"post_InterruptPlan curTime   expOutput   plan   magid   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_InterruptPlan` specification.\<close>
		((inv_VDMNat curTime)  \<and>  (inv_Output expOutput)  \<and>  (inv_Plan plan)  \<and>  (inv_MagId magid)  \<and>  (inv_Output RESULT))"

definition
	InterruptPlan :: "VDMNat \<Rightarrow> Output \<Rightarrow> Plan \<Rightarrow> MagId \<Rightarrow> Output"
where
	"InterruptPlan curTime   expOutput   plan   magid \<equiv> 
	\<comment>\<open>User defined body of InterruptPlan.\<close>
	([magid\<mapsto>((
		if ((magid \<in> (dom expOutput))) then
		((LeavePrefixUnchanged ((the(expOutput magid)))  curTime))
		else
		([])) @ (MakeOutputFromPlan curTime  plan))] \<union>m ({magid} -\<triangleleft> expOutput))"

	
	
\<comment>\<open>VDM source: CM: (MissileInputs * Output * map (MagId) to ([MissileType]) * nat -> Output)
	CM(missileInputs, outputSoFar, lastMissile, curTime) ==
(if (missileInputs = [])
then outputSoFar
else let mk_(curMis, angle):MissileInput = (hd missileInputs) in let magid:MagId = Angle2MagId(angle) in (if ((magid not in set (dom lastMissile)) or ((magid in set (dom lastMissile)) and (missilePriority(curMis) > missilePriority(lastMissile(magid)))))
then let newOutput:Output = InterruptPlan(curTime, outputSoFar, responseDB(curMis), magid), magidMaplet:map (MagId) to ([MissileType]) = {magid |-> curMis} in CM((tl missileInputs), newOutput, (lastMissile ++ magidMaplet), (curTime + stepLength))
else CM((tl missileInputs), outputSoFar, lastMissile, (curTime + stepLength))))
	measure (len missileInputs)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 173:1\<close>

\<comment>\<open>VDM source: pre_CM: (MissileInputs * Output * map (MagId) to ([MissileType]) * nat +> bool)
	pre_CM(missileInputs, outputSoFar, lastMissile, curTime) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 173:1\<close>
definition
	pre_CM :: "MissileInputs \<Rightarrow> Output \<Rightarrow> (MagId \<rightharpoonup> MissileType option) \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"pre_CM missileInputs   outputSoFar   lastMissile   curTime \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_CM` specification.\<close>
		((inv_MissileInputs missileInputs)  \<and>  (inv_Output outputSoFar)  \<and>  (inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)  \<and>  (inv_VDMNat curTime))"


\<comment>\<open>VDM source: post_CM: (MissileInputs * Output * map (MagId) to ([MissileType]) * nat * Output +> bool)
	post_CM(missileInputs, outputSoFar, lastMissile, curTime, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 173:1\<close>
definition
	post_CM :: "MissileInputs \<Rightarrow> Output \<Rightarrow> (MagId \<rightharpoonup> MissileType option) \<Rightarrow> VDMNat \<Rightarrow> Output \<Rightarrow> bool"
where
	"post_CM missileInputs   outputSoFar   lastMissile   curTime   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_CM` specification.\<close>
		((inv_MissileInputs missileInputs)  \<and>  (inv_Output outputSoFar)  \<and>  (inv_Map inv_MagId (inv_Option inv_MissileType) lastMissile)  \<and>  (inv_VDMNat curTime)  \<and>  (inv_Output RESULT))"

fun
	CM :: "MissileInputs \<Rightarrow> Output \<Rightarrow> (MagId \<rightharpoonup> MissileType option) \<Rightarrow> VDMNat \<Rightarrow> Output"
where
	"CM missileInputs   outputSoFar   lastMissile   curTime = 
	\<comment>\<open>User defined body of CM.\<close>
	(
		if ((missileInputs = [])) then
		(outputSoFar)
		else
		((
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
			(
		if (((magid \<notin> (dom lastMissile)) \<or> ((magid \<in> (dom lastMissile)) \<and> (((the(missilePriority curMis))) > ((the(missilePriority ((the((the(lastMissile magid)))))))))))) then
		((
		let 
(newOutput::Output) = (InterruptPlan curTime  outputSoFar  ((the(responseDB curMis)))  magid)
		;
		
(magidMaplet::(MagId \<rightharpoonup> MissileType option)) = [magid\<mapsto> Some curMis]
		in
			
			(if (inv_Output newOutput)
	 \<and> 
	((inv_Map inv_MagId (inv_Option inv_MissileType) magidMaplet)) then
			(CM (tl missileInputs)  newOutput  (lastMissile \<dagger> magidMaplet)  (curTime + stepLength))
		 else
			undefined
		)
		))
		else
		((CM (tl missileInputs)  outputSoFar  lastMissile  (curTime + stepLength))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))"

	
	
\<comment>\<open>VDM source: CounterMeasures: (MissileInputs -> Output)
	CounterMeasures(missileInputs) ==
CM(missileInputs, {|->}, {|->}, 0)\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 201:1\<close>

\<comment>\<open>VDM source: pre_CounterMeasures: (MissileInputs +> bool)
	pre_CounterMeasures(missileInputs) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 201:1\<close>
definition
	pre_CounterMeasures :: "MissileInputs \<Rightarrow> bool"
where
	"pre_CounterMeasures missileInputs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_CounterMeasures` specification.\<close>
		((inv_MissileInputs missileInputs))"


\<comment>\<open>VDM source: post_CounterMeasures: (MissileInputs * Output +> bool)
	post_CounterMeasures(missileInputs, RESULT) ==
null\<close>
\<comment>\<open>in 'CM' (/Users/nljsf/Local/reps/git/VDM_Toolkit/plugins/vdm2isa/java/src/test/resources/Examples/CMSL/CM.vdmsl) at line 201:1\<close>
definition
	post_CounterMeasures :: "MissileInputs \<Rightarrow> Output \<Rightarrow> bool"
where
	"post_CounterMeasures missileInputs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_CounterMeasures` specification.\<close>
		((inv_MissileInputs missileInputs)  \<and>  (inv_Output RESULT))"

definition
	CounterMeasures :: "MissileInputs \<Rightarrow> Output"
where
	"CounterMeasures missileInputs \<equiv> 
	\<comment>\<open>User defined body of CounterMeasures.\<close>
	(CM missileInputs  Map.empty  Map.empty  (0::VDMNat))"

end