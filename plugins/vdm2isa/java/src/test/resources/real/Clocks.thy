(* VDM to Isabelle Translation @2021-11-23T16:02:48.198638Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/real/Clocks.vdmsl' at line 1:8
files = [./src/test/resources/real/Clocks.vdmsl]
*)
theory Clocks
imports VDMToolkit
begin


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 37:5\<close>
record Time = 
	r\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMReal"
		i\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMNat"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 41:9\<close>
definition
	inv_Time :: "Time \<Rightarrow> \<bool>"
where
	"inv_Time t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_Time specification\<close>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e t))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e t)))
		))  \<and> 
		\<comment>\<open>User defined body of inv_Time\<close>
		((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (t)) \<ge> (0::VDMNat))"

		

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 44:21\<close>
definition
	ord_Time :: "Time\<Rightarrow> Time \<Rightarrow> \<bool>"
where
	"ord_Time a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_Time specification\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of ord_Time\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) < (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b))) \<or> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b))) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) < (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b)))))"

		

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 50:5\<close>
datatype Interval = calculated |  changing |  constantLF |  countdown |  fixed |  triggered |  tunable
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 50:5\<close>
definition
	inv_Interval :: "Interval \<Rightarrow> \<bool>"
where
	"inv_Interval dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_Interval specification\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 55:5\<close>
datatype ActionType = get |  getC |  set |  setC |  step
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 55:5\<close>
definition
	inv_ActionType :: "ActionType \<Rightarrow> \<bool>"
where
	"inv_ActionType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_ActionType specification\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 60:5\<close>
type_synonym Ref = "VDMNat"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 60:5\<close>
definition
	inv_Ref :: "Ref \<Rightarrow> \<bool>"
where
	"inv_Ref dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_Ref specification\<close>
		(((inv_VDMNat dummy0)))"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 65:5\<close>
type_synonym Name = "VDMChar VDMSeq1"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 65:5\<close>
definition
	inv_Name :: "Name \<Rightarrow> \<bool>"
where
	"inv_Name dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_Name specification\<close>
		(((inv_VDMSeq1' (inv_VDMChar) dummy0)))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 70:5\<close>
record FMURef = 
	name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Name"
		ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Ref"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 70:5\<close>
definition
	inv_FMURef :: "FMURef \<Rightarrow> \<bool>"
where
	"inv_FMURef dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_FMURef specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0))))
		))"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 74:5\<close>
datatype ValueTypesLF = UBool \<bool> |  UReal VDMReal
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 74:5\<close>
definition
	inv_ValueTypesLF :: "ValueTypesLF \<Rightarrow> \<bool>"
where
	"inv_ValueTypesLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_ValueTypesLF specification\<close>
		((((inv_bool dummy0))))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 81:5\<close>
record Value = 
	value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "ValueTypesLF"
		time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "Time"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 81:5\<close>
definition
	inv_Value :: "Value \<Rightarrow> \<bool>"
where
	"inv_Value dummy0 \<equiv> True" 
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 89:5\<close>
type_synonym Environment = "(Ref \<rightharpoonup> Value)"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 89:5\<close>
definition
	inv_Environment :: "Environment \<Rightarrow> \<bool>"
where
	"inv_Environment dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_Environment specification\<close>
		(((inv_Map (inv_Ref) inv_Value  dummy0)))"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 95:5\<close>
type_synonym Equation = "Environment \<Rightarrow> Environment"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 95:5\<close>
definition
	inv_Equation :: "Equation \<Rightarrow> \<bool>"
where
	"inv_Equation dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_Equation specification\<close>
		(((inv_Lambda (inv_Environment) (inv_Environment)dummy0)))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 97:5\<close>
datatype IOLF = inputLF |  outputLF
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 97:5\<close>
definition
	inv_IOLF :: "IOLF \<Rightarrow> \<bool>"
where
	"inv_IOLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_IOLF specification\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 98:5\<close>
datatype DCLF = continous |  discrete
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 98:5\<close>
definition
	inv_DCLF :: "DCLF \<Rightarrow> \<bool>"
where
	"inv_DCLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_DCLF specification\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 99:5\<close>
datatype ContractLF = delayed |  none |  reactive
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 99:5\<close>
definition
	inv_ContractLF :: "ContractLF \<Rightarrow> \<bool>"
where
	"inv_ContractLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_ContractLF specification\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 104:5\<close>
record Variable = 
	ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref"
		time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Time"
		causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "IOLF"
		type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "DCLF"
		clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref VDMSet"
		dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref VDMSet"
		contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "ContractLF"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 113:9\<close>
definition
	inv_Variable :: "Variable \<Rightarrow> \<bool>"
where
	"inv_Variable var \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_Variable specification\<close>
		(
		((((inv_VDMNat (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var)))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))))
		)) \<and>
		((((inv_True (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))))) \<and>
		((((inv_True (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and>
		((((inv_True (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var)))))
		))  \<and> 
		\<comment>\<open>User defined body of inv_Variable\<close>
		(((((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) = (outputLF)) \<longrightarrow> ((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) = (none))) \<and> ((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) = (inputLF))) \<longrightarrow> ((dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) = {}))"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 121:5\<close>
record Clock = 
	ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref"
		type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "IOLF"
		interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Interval"
		timeToTick\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Time"
		dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref VDMSet"
		equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref VDMSet"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 128:9\<close>
definition
	inv_Clock :: "Clock \<Rightarrow> \<bool>"
where
	"inv_Clock clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_Clock specification\<close>
		(
		((((inv_VDMNat (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock)))) \<and>
		((((inv_True (type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))))) \<and>
		((((inv_True (interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (timeToTick\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (timeToTick\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))))
		)) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock)))
		))  \<and> 
		\<comment>\<open>User defined body of inv_Clock\<close>
		((((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = (outputLF)) \<longrightarrow> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = (triggered))) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = (inputLF)) \<longrightarrow> ((dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = {})))"

		

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 132:5\<close>
datatype FMUModeLF = DONE |  EVENT |  INIT |  STEP
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 132:5\<close>
definition
	inv_FMUModeLF :: "FMUModeLF \<Rightarrow> \<bool>"
where
	"inv_FMUModeLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_FMUModeLF specification\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 140:5\<close>
record FMU = 
	name\<^sub>F\<^sub>M\<^sub>U :: "Name"
		clocks\<^sub>F\<^sub>M\<^sub>U :: "Clock VDMSet"
		inputs\<^sub>F\<^sub>M\<^sub>U :: "Variable VDMSet"
		outputs\<^sub>F\<^sub>M\<^sub>U :: "Variable VDMSet"
		mode\<^sub>F\<^sub>M\<^sub>U :: "FMUModeLF"
		time\<^sub>F\<^sub>M\<^sub>U :: "Time"
		maxStep\<^sub>F\<^sub>M\<^sub>U :: "VDMReal"
		env\<^sub>F\<^sub>M\<^sub>U :: "Environment"
		activeClocks\<^sub>F\<^sub>M\<^sub>U :: "Ref VDMSet"
		activeEquations\<^sub>F\<^sub>M\<^sub>U :: "Equation VDMSet"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 151:9\<close>
definition
	inv_FMU :: "FMU \<Rightarrow> \<bool>"
where
	"inv_FMU fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_FMU specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		))  \<and> 
		\<comment>\<open>User defined body of inv_FMU\<close>
		(
		let 
(vars::Variable VDMSet) = ((inputs\<^sub>F\<^sub>M\<^sub>U (fmu)) \<union> (outputs\<^sub>F\<^sub>M\<^sub>U (fmu)))
		in
			(if ((inv_VDMSet' inv_Variable  vars)) then
			(
		let 
(crefs::Ref VDMSet) = { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  };
		
(vrefs::Ref VDMSet) = { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) | v .  ((v \<in>vars))  };
		
(refs::Ref VDMSet) = (crefs \<union> vrefs)
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) crefs)) \<and> 
	((inv_VDMSet' ((inv_VDMNat)) vrefs)) \<and> 
	((inv_VDMSet' ((inv_VDMNat)) refs)) then
			(((maxStep\<^sub>F\<^sub>M\<^sub>U (fmu)) \<ge> (0.0)) \<and> (((vdm_card refs) = ((vdm_card (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))) + (vdm_card vars))) \<and> (((dom (env\<^sub>F\<^sub>M\<^sub>U (fmu))) \<subseteq> refs) \<and> (((activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu)) \<subseteq> crefs) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) \<noteq> (EVENT)) \<longrightarrow> ((activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu)) = {})) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) \<noteq> (EVENT)) \<longrightarrow> ((activeEquations\<^sub>F\<^sub>M\<^sub>U (fmu)) = {})) \<and> (\<forall> var \<in> vars  . ((clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) \<subseteq> crefs))))))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 180:5\<close>
record Action = 
	actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "ActionType"
		fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "FMU"
		port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "Ref"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 180:5\<close>
definition
	inv_Action :: "Action \<Rightarrow> \<bool>"
where
	"inv_Action dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_Action specification\<close>
		(
		(((((inv_True (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))))) \<and>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)))) )) \<and>
		(((inv_VDMNat (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))))
		))"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 194:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 197:9\<close>
definition
	pre_derefOutput :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_derefOutput fmu ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_derefOutput specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref)))  \<and> 
		\<comment>\<open>User defined body of pre_derefOutput\<close>
		(\<exists> c \<in> (outputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (c)) = ref))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 194:5\<close>
definition
	post_derefOutput :: "FMU\<Rightarrow> Ref\<Rightarrow> Variable \<Rightarrow> \<bool>"
where
	"post_derefOutput fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_derefOutput specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat ref))  \<and>   ((((inv_VDMNat (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e RESULT)))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e RESULT))))
		)) \<and>
		((((inv_True (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e RESULT))))) \<and>
		((((inv_True (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e RESULT))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e RESULT))) \<and>
		((((inv_True (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e RESULT))))) ))"

definition
	derefOutput :: "FMU\<Rightarrow> Ref \<Rightarrow> Variable"
where
	"derefOutput fmu ref \<equiv> 
	\<comment>\<open>User defined body of derefOutput\<close>
	(THE c. (((c \<in>(outputs\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (c)) = ref)))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 204:5\<close>
record Machine = 
	fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(Name \<rightharpoonup> FMU)"
		connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(FMURef \<rightharpoonup> FMURef)"
		clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(FMURef \<rightharpoonup> FMURef)"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 208:9\<close>
definition
	inv_Machine :: "Machine \<Rightarrow> \<bool>"
where
	"inv_Machine m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_Machine specification\<close>
		(
		(((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m)))
		))  \<and> 
		\<comment>\<open>User defined body of inv_Machine\<close>
		((\<forall> srcRef \<in> (dom (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (srcRef)) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) \<and> (
		let 
(srcFMU::FMU) = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (srcRef))));
		
(trgRef::FMURef) = (the((connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)) srcRef))
		in
			(if (inv_FMU srcFMU) \<and> 
	(inv_FMURef trgRef) then
			((\<exists> v \<in> (outputs\<^sub>F\<^sub>M\<^sub>U (srcFMU))  . ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (srcRef)) = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)))) \<and> (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (trgRef)) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) \<and> (
		let 
(trgFMU::FMU) = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (trgRef))))
		in
			(if (inv_FMU trgFMU) then
			((\<exists> v \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (trgFMU))  . ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (trgRef)) = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)))) \<and> (
		let 
(outputLF::Variable) = (derefOutput srcFMU  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (srcRef)));
		
(inputLF::Variable) = (derefInput trgFMU  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (trgRef)))
		in
			(if (inv_Variable outputLF) \<and> 
	(inv_Variable inputLF) then
			((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (outputLF)) = (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (inputLF)))
		 else
			undefined
		)
		))
		 else
			undefined
		)
		)))
		 else
			undefined
		)
		))) \<and> ((\<forall> fmuref \<in> (dom (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref)) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) \<and> (
		let 
(fmu::FMU) = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref))))
		in
			(if (inv_FMU fmu) then
			(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref)) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v))) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = (outputLF))))
		 else
			undefined
		)
		))) \<and> ((\<forall> fmuref \<in> (rng (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref)) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) \<and> (
		let 
(fmu::FMU) = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref))))
		in
			(if (inv_FMU fmu) then
			(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref)) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v))) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = (inputLF))))
		 else
			undefined
		)
		))) \<and> ((((dom (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m))) \<inter> (dom (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) = {}) \<and> (((rng (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m))) \<inter> (rng (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) = {})))))"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 247:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 247:5\<close>
definition
	pre_createFMURefs :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> \<bool>"
where
	"pre_createFMURefs fmu  clocks  res \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_createFMURefs specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  (inv_VDMSet' ((inv_VDMNat)) clocks)  \<and>  (inv_VDMSet' inv_FMURef  res))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 247:5\<close>
definition
	post_createFMURefs :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> FMURef VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> \<bool>"
where
	"post_createFMURefs fmu  clocks  res  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_createFMURefs specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_VDMSet' inv_FMURef  res)  \<and>  (inv_VDMSet' inv_FMURef  RESULT))"

definition
	createFMURefs :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> FMURef VDMSet"
where
	"createFMURefs fmu clocks res \<equiv> 
	\<comment>\<open>User defined body of createFMURefs\<close>
	(
		if ((clocks = {})) then
		(res)
		else
		((
		SOME (dummy0::FMURef VDMSet) .(dummy0 \<in> { (createFMURefs fmu  (clocks - {clock})  (res \<union> {\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>})) | clock .  ((clock \<in>clocks))  }))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 260:5\<close>
record Importer = 
	scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "Machine"
		schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "(FMURef \<rightharpoonup> VDMReal)"
		activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "FMURef VDMSet"
		readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "FMURef VDMSet"
		inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "FMURef VDMSet"
		fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "Name VDMSet"
		relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "FMURef VDMSet"
		relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "FMURef VDMSet"
		activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "FMURef VDMSet"
		calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "FMURef VDMSet"
		readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "FMURef VDMSet"
		time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "Time"
		endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "Time"
		stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "VDMReal"
		valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "(FMURef \<rightharpoonup> Value)"
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 276:9\<close>
definition
	inv_Importer :: "Importer \<Rightarrow> \<bool>"
where
	"inv_Importer imp \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_Importer specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)))
		))  \<and> 
		\<comment>\<open>User defined body of inv_Importer\<close>
		(
		let 
(fmus::(Name \<rightharpoonup> FMU)) = (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))))
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  fmus)) then
			(
		let 
(inputclocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu  { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = (inputLF)) }  {}) | fmu .  ((fmu \<in>(rng fmus)))  })
		in
			(if ((inv_VDMSet' inv_FMURef  inputclocks)) then
			(
		let 
(outputclocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu  { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = (outputLF)) }  {}) | fmu .  ((fmu \<in>(rng fmus)))  })
		in
			(if ((inv_VDMSet' inv_FMURef  outputclocks)) then
			(
		let 
(clocks::FMURef VDMSet) = (inputclocks \<union> outputclocks)
		in
			(if ((inv_VDMSet' inv_FMURef  clocks)) then
			((((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<union> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = clocks) \<and> ((((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}) \<and> ((((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}) \<and> (((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) = (\<Union> { (createFMURefs fmu  (activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu))  {}) | fmu .  ((fmu \<in>(rng fmus)))  })) \<and> (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<subseteq> (dom fmus)) \<and> (((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<subseteq> inputclocks) \<and> (((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<subseteq> outputclocks) \<and> ((((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}) \<and> (((dom (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = (\<Union> { (createFMURefs fmu  { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = (inputLF)) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) \<noteq> (triggered))) }  {}) | fmu .  ((fmu \<in>(rng fmus)))  })) \<and> (((endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<ge> (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) \<and> ((((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}) \<and> (((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}))))))))))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 301:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 301:5\<close>
definition
	pre_preSet :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_preSet fmu  inputLF \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_preSet specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat inputLF)))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 301:5\<close>
definition
	post_preSet :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_preSet fmu  inputLF  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_preSet specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat inputLF))  \<and>  (inv_bool RESULT))"

definition
	preSet :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"preSet fmu inputLF \<equiv> 
	\<comment>\<open>User defined body of preSet\<close>
	(\<exists> v \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = inputLF) \<and> (((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = (inputLF)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) \<noteq> (DONE)))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 310:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 310:5\<close>
definition
	pre_preGet :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_preGet fmu  ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_preGet specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref)))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 310:5\<close>
definition
	post_preGet :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_preGet fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_preGet specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat ref))  \<and>  (inv_bool RESULT))"

definition
	preGet :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"preGet fmu ref \<equiv> 
	\<comment>\<open>User defined body of preGet\<close>
	(
		let 
(outputLF::Variable) = (derefOutput fmu  ref)
		in
			(if (inv_Variable outputLF) then
			(\<exists> v \<in> (outputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = ref) \<and> (((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = (outputLF)) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) \<noteq> (DONE)) \<and> (feedthroughSatisfied fmu  outputLF)))))
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 318:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 318:5\<close>
definition
	pre_preStepT :: "FMU\<Rightarrow> VDMReal \<Rightarrow> \<bool>"
where
	"pre_preStepT fmu  stepSize \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_preStepT specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  (inv_VDMReal stepSize))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 318:5\<close>
definition
	post_preStepT :: "FMU\<Rightarrow> VDMReal\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_preStepT fmu  stepSize  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_preStepT specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  (inv_VDMReal stepSize)  \<and>  (inv_bool RESULT))"

definition
	preStepT :: "FMU\<Rightarrow> VDMReal \<Rightarrow> \<bool>"
where
	"preStepT fmu stepSize \<equiv> 
	\<comment>\<open>User defined body of preStepT\<close>
	(\<forall> i \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = (reactive)) \<longrightarrow> ((r\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e ((time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (((env\<^sub>F\<^sub>M\<^sub>U (fmu)) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i))))))) = ((r\<^sub>F\<^sub>M\<^sub>U ((time\<^sub>F\<^sub>M\<^sub>U (fmu)))) + stepSize))) \<and> ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = (delayed)) \<longrightarrow> ((time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (((env\<^sub>F\<^sub>M\<^sub>U (fmu)) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i))))) = (time\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> ((stepSize \<ge> (0.0)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (STEP))))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 325:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 325:5\<close>
definition
	pre_preStepE :: "FMU \<Rightarrow> \<bool>"
where
	"pre_preStepE fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_preStepE specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) ))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 325:5\<close>
definition
	post_preStepE :: "FMU\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_preStepE fmu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_preStepE specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  (inv_bool RESULT))"

definition
	preStepE :: "FMU \<Rightarrow> \<bool>"
where
	"preStepE fmu \<equiv> 
	\<comment>\<open>User defined body of preStepE\<close>
	((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (EVENT))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 329:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 329:5\<close>
definition
	pre_preSetC :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"pre_preSetC fmu  clock  val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_preSetC specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat clock))  \<and>  (inv_bool val))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 329:5\<close>
definition
	post_preSetC :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool>\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_preSetC fmu  clock  val  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_preSetC specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat clock))  \<and>  (inv_bool val)  \<and>  (inv_bool RESULT))"

definition
	preSetC :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"preSetC fmu clock val \<equiv> 
	\<comment>\<open>User defined body of preSetC\<close>
	(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = clock) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = (inputLF)) \<and> val)) \<longleftrightarrow> (\<not> (clock \<in> (activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu))))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 334:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 334:5\<close>
definition
	pre_preGetC :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_preGetC fmu  clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_preGetC specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat clock)))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 334:5\<close>
definition
	post_preGetC :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_preGetC fmu  clock  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_preGetC specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat clock))  \<and>  (inv_bool RESULT))"

definition
	preGetC :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"preGetC fmu clock \<equiv> 
	\<comment>\<open>User defined body of preGetC\<close>
	(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = clock) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = (outputLF)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (EVENT)))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 344:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 348:9\<close>
definition
	pre_set_m :: "FMU\<Rightarrow> Ref\<Rightarrow> Value \<Rightarrow> \<bool>"
where
	"pre_set_m fmu ref val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_set_m specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref))  \<and>   (((((inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val))))
		)) ))  \<and> 
		\<comment>\<open>User defined body of pre_set_m\<close>
		(preSet fmu  ref)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 344:5\<close>
definition
	post_set_m :: "FMU\<Rightarrow> Ref\<Rightarrow> Value\<Rightarrow> FMU \<Rightarrow> \<bool>"
where
	"post_set_m fmu  ref  val  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_set_m specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat ref))  \<and>  
		(((((inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val))))
		))
		)  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U RESULT)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U RESULT))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U RESULT))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U RESULT)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U RESULT))) ))"

definition
	set_m :: "FMU\<Rightarrow> Ref\<Rightarrow> Value \<Rightarrow> FMU"
where
	"set_m fmu ref val \<equiv> 
	\<comment>\<open>User defined body of set_m\<close>
	(fmu)\<lparr>env\<^sub>F\<^sub>M\<^sub>U := ((env\<^sub>F\<^sub>M\<^sub>U (fmu)) \<dagger> [ref\<mapsto>val])\<rparr>"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 350:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 354:9\<close>
definition
	pre_get_m :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_get_m fmu ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_get_m specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref)))  \<and> 
		\<comment>\<open>User defined body of pre_get_m\<close>
		(preGet fmu  ref)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 350:5\<close>
definition
	post_get_m :: "FMU\<Rightarrow> Ref\<Rightarrow> (FMU\<times> Value) \<Rightarrow> \<bool>"
where
	"post_get_m fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_get_m specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat ref))  \<and>  
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) )\<and>
		  (((((inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd RESULT)))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd RESULT))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd RESULT)))))
		)) )
		))"

definition
	get_m :: "FMU\<Rightarrow> Ref \<Rightarrow> (FMU\<times> Value)"
where
	"get_m fmu ref \<equiv> 
	\<comment>\<open>User defined body of get_m\<close>
	(fmu, ((env\<^sub>F\<^sub>M\<^sub>U (fmu)) ref))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 356:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 361:9\<close>
definition
	pre_set_cm :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"pre_set_cm fmu ref val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_set_cm specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref))  \<and>  (inv_bool val))  \<and> 
		\<comment>\<open>User defined body of pre_set_cm\<close>
		(preSetC fmu  ref  val)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 362:14\<close>
definition
	post_set_cm :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool>\<Rightarrow> FMU \<Rightarrow> \<bool>"
where
	"post_set_cm fmu ref val RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_set_cm specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref))  \<and>  (inv_bool val)  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U RESULT)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U RESULT))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U RESULT))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U RESULT)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U RESULT))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_set_cm\<close>
		(val \<longleftrightarrow> (ref \<in> (activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu))))"

definition
	set_cm :: "FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> FMU"
where
	"set_cm fmu ref val \<equiv> 
	\<comment>\<open>User defined body of set_cm\<close>
	(fmu)\<lparr>env\<^sub>F\<^sub>M\<^sub>U := ((env\<^sub>F\<^sub>M\<^sub>U (fmu)) \<dagger> [ref\<mapsto>\<lparr>value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = val, time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = (time\<^sub>F\<^sub>M\<^sub>U (fmu))\<rparr>]), activeClocks\<^sub>F\<^sub>M\<^sub>U := (
		if (val) then
		(((activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu)) \<union> {ref}))
		else
		(((activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu)) - {ref})))\<rparr>"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 364:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 367:9\<close>
definition
	pre_get_cm :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_get_cm fmu ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_get_cm specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref)))  \<and> 
		\<comment>\<open>User defined body of pre_get_cm\<close>
		(preGetC fmu  ref)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 364:5\<close>
definition
	post_get_cm :: "FMU\<Rightarrow> Ref\<Rightarrow> (FMU\<times> Value) \<Rightarrow> \<bool>"
where
	"post_get_cm fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_get_cm specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat ref))  \<and>  
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) )\<and>
		  (((((inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd RESULT)))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd RESULT))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd RESULT)))))
		)) )
		))"

definition
	get_cm :: "FMU\<Rightarrow> Ref \<Rightarrow> (FMU\<times> Value)"
where
	"get_cm fmu ref \<equiv> 
	\<comment>\<open>User defined body of get_cm\<close>
	(fmu, ((env\<^sub>F\<^sub>M\<^sub>U (fmu)) ref))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 369:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 373:9\<close>
definition
	pre_step_tm :: "FMU\<Rightarrow> VDMReal \<Rightarrow> \<bool>"
where
	"pre_step_tm fmu step \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_step_tm specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  (inv_VDMReal step))  \<and> 
		\<comment>\<open>User defined body of pre_step_tm\<close>
		(preStepT fmu  step)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 375:9\<close>
definition
	post_step_tm :: "FMU\<Rightarrow> VDMReal\<Rightarrow> (FMU\<times> VDMReal\<times> \<bool>) \<Rightarrow> \<bool>"
where
	"post_step_tm fmu step RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_step_tm specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  (inv_VDMReal step)  \<and>  
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) )\<and>
		 (inv_VDMReal (fst (snd RESULT)))\<and>
		 (inv_bool (snd (snd RESULT)))
		))  \<and> 
		\<comment>\<open>User defined body of post_step_tm\<close>
		(((fst (snd (RESULT))) \<le> step) \<and> ((fst (snd (RESULT))) \<le> (maxStep\<^sub>F\<^sub>M\<^sub>U (fmu))))"

definition
	step_tm :: "FMU\<Rightarrow> VDMReal \<Rightarrow> (FMU\<times> VDMReal\<times> \<bool>)"
where
	"step_tm fmu step \<equiv> 
	\<comment>\<open>User defined body of step_tm\<close>
	(
		if ((step \<ge> (maxStep\<^sub>F\<^sub>M\<^sub>U (fmu)))) then
		((fmu, (maxStep\<^sub>F\<^sub>M\<^sub>U (fmu)), (True::\<bool>)))
		else
		((fmu, step, (False::\<bool>))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 377:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 380:9\<close>
definition
	pre_step_e :: "FMU \<Rightarrow> \<bool>"
where
	"pre_step_e fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_step_e specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) ))  \<and> 
		\<comment>\<open>User defined body of pre_step_e\<close>
		(preStepE fmu)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 382:9\<close>
definition
	post_step_e :: "FMU\<Rightarrow> (FMU\<times> \<bool>) \<Rightarrow> \<bool>"
where
	"post_step_e fmu RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_step_e specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst RESULT))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst RESULT)))) )\<and>
		 (inv_bool (snd RESULT))
		))  \<and> 
		\<comment>\<open>User defined body of post_step_e\<close>
		(((mode\<^sub>F\<^sub>M\<^sub>U ((fst (RESULT)))) = (EVENT)) \<and> (((i\<^sub>F\<^sub>M\<^sub>U ((time\<^sub>F\<^sub>M\<^sub>U ((fst (RESULT)))))) = ((i\<^sub>F\<^sub>M\<^sub>U ((time\<^sub>F\<^sub>M\<^sub>U (fmu)))) + (1::VDMNat1))) \<and> ((activeClocks\<^sub>F\<^sub>M\<^sub>U ((fst (RESULT)))) = {})))"

definition
	step_e :: "FMU \<Rightarrow> (FMU\<times> \<bool>)"
where
	"step_e fmu \<equiv> 
	\<comment>\<open>User defined body of step_e\<close>
	undefined"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 386:5\<close>
datatype RealNaNLF = NaN |  VDMReal
	

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 386:5\<close>
definition
	inv_RealNaNLF :: "RealNaNLF \<Rightarrow> \<bool>"
where
	"inv_RealNaNLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_RealNaNLF specification\<close>
		((((inv_True dummy0))))"
 

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 391:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 396:9\<close>
definition
	pre_next_tm :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_next_tm fmu ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_next_tm specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref)))  \<and> 
		\<comment>\<open>User defined body of pre_next_tm\<close>
		(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = ref) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) \<in> {(tunable), (changing), (countdown)})))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 391:5\<close>
definition
	post_next_tm :: "FMU\<Rightarrow> Ref\<Rightarrow> RealNaNLF \<Rightarrow> \<bool>"
where
	"post_next_tm fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_next_tm specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat ref))  \<and>  (((inv_True RESULT))))"

definition
	next_tm :: "FMU\<Rightarrow> Ref \<Rightarrow> RealNaNLF"
where
	"next_tm fmu ref \<equiv> 
	\<comment>\<open>User defined body of next_tm\<close>
	(NaN)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 402:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 414:9\<close>
definition
	pre_updateDiscreteState :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> \<bool>"
where
	"pre_updateDiscreteState I fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_updateDiscreteState specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_updateDiscreteState\<close>
		((\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((name\<^sub>F\<^sub>M\<^sub>U (m')) \<in> fmus) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (EVENT)))) \<and> ((vdm_card { (time\<^sub>F\<^sub>M\<^sub>U (m')) | m' .  ((m' \<in>(rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))))  \<and> ((name\<^sub>F\<^sub>M\<^sub>U (m')) \<in> fmus) }) = (1::VDMNat1)))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 416:9\<close>
definition
	post_updateDiscreteState :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_updateDiscreteState I fmus RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_updateDiscreteState specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_updateDiscreteState\<close>
		((\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((name\<^sub>F\<^sub>M\<^sub>U (m')) \<in> fmus) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (EVENT)))) \<and> ((vdm_card { (time\<^sub>F\<^sub>M\<^sub>U (m')) | m' .  ((m' \<in>(rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))))  \<and> ((name\<^sub>F\<^sub>M\<^sub>U (m')) \<in> fmus) }) = (1::VDMNat1)))"

definition
	updateDiscreteState :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"updateDiscreteState I fmus \<equiv> 
	\<comment>\<open>User defined body of updateDiscreteState\<close>
	(
		let 
(M::Machine) = (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))
		in
			(if (inv_Machine M) then
			(
		let 
(res::(Name \<rightharpoonup> (FMU\<times> \<bool>))) = 
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) 
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U )))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U ))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U ))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U ))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U ))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U )))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U ))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U ))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U )))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U ))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U ))) )\<and>
		 (inv_bool )
		) res)) then
			(
		let 
(fmuMap::(Name \<rightharpoonup> FMU)) = ;
		
(eventFMUs::Name VDMSet) = { fmu .   ((fmu \<in>(dom res)))  \<and> ((snd ((the(res fmu)))) = (True::\<bool>)) }
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  fmuMap)) \<and> 
	((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) eventFMUs)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := fmuMap\<rparr>, fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := eventFMUs\<rparr>
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 420:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 423:9\<close>
definition
	pre_derefClock :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_derefClock fmu ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_derefClock specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref)))  \<and> 
		\<comment>\<open>User defined body of pre_derefClock\<close>
		(\<exists> c \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) = ref))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 420:5\<close>
definition
	post_derefClock :: "FMU\<Rightarrow> Ref\<Rightarrow> Clock \<Rightarrow> \<bool>"
where
	"post_derefClock fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_derefClock specification\<close>
		(
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat ref))  \<and>  
		((((inv_VDMNat (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k RESULT)))) \<and>
		((((inv_True (type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k RESULT))))) \<and>
		((((inv_True (interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k RESULT))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (timeToTick\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (timeToTick\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k RESULT))))
		)) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k RESULT)))
		))"

definition
	derefClock :: "FMU\<Rightarrow> Ref \<Rightarrow> Clock"
where
	"derefClock fmu ref \<equiv> 
	\<comment>\<open>User defined body of derefClock\<close>
	(THE c. (((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> ((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) = ref)))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 428:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 431:9\<close>
definition
	pre_derefInput :: "FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_derefInput fmu ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_derefInput specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat ref)))  \<and> 
		\<comment>\<open>User defined body of pre_derefInput\<close>
		(\<exists> c \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (c)) = ref))"

definition
	derefInput :: "FMU\<Rightarrow> Ref \<Rightarrow> Variable"
where
	"derefInput fmuref \<equiv> 
	\<comment>\<open>User defined body of derefInput\<close>
	(THE c. (((c \<in>(inputs\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (c)) = ref)))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 436:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 439:9\<close>
definition
	pre_enterEventMode :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> \<bool>"
where
	"pre_enterEventMode I fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_enterEventMode specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_enterEventMode\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((i\<^sub>F\<^sub>M\<^sub>U ((time\<^sub>F\<^sub>M\<^sub>U (m')))) = (0::VDMNat)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (STEP))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 440:10\<close>
definition
	post_enterEventMode :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_enterEventMode I fmus RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_enterEventMode specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_enterEventMode\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((i\<^sub>F\<^sub>M\<^sub>U ((time\<^sub>F\<^sub>M\<^sub>U (m')))) = (0::VDMNat)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (STEP))))"

definition
	enterEventMode :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"enterEventMode I fmus \<equiv> 
	\<comment>\<open>User defined body of enterEventMode\<close>
	(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := \<rparr>\<rparr>"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 445:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 448:9\<close>
definition
	pre_enterStepMode :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> \<bool>"
where
	"pre_enterStepMode I fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_enterStepMode specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_enterStepMode\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((i\<^sub>F\<^sub>M\<^sub>U ((time\<^sub>F\<^sub>M\<^sub>U (m')))) = (0::VDMNat)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) \<in> {(INIT), (EVENT)})))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 450:10\<close>
definition
	post_enterStepMode :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_enterStepMode I fmus RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_enterStepMode specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_enterStepMode\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((i\<^sub>F\<^sub>M\<^sub>U ((time\<^sub>F\<^sub>M\<^sub>U (m')))) = (0::VDMNat)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (STEP))))"

definition
	enterStepMode :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"enterStepMode I fmus \<equiv> 
	\<comment>\<open>User defined body of enterStepMode\<close>
	(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := \<rparr>\<rparr>"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 454:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 454:5\<close>
definition
	pre_variablesSynchronized :: "Machine \<Rightarrow> \<bool>"
where
	"pre_variablesSynchronized M \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_variablesSynchronized specification\<close>
		( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) ))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 454:5\<close>
definition
	post_variablesSynchronized :: "Machine\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"post_variablesSynchronized M  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_variablesSynchronized specification\<close>
		(
		(((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M)))
		)  \<and>  (inv_bool RESULT))"

definition
	variablesSynchronized :: "Machine \<Rightarrow> \<bool>"
where
	"variablesSynchronized M \<equiv> 
	\<comment>\<open>User defined body of variablesSynchronized\<close>
	(\<forall> srcPort \<in> (dom (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))  . (
		let 
(trgPort::FMURef) = (the((connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) srcPort))
		in
			(if (inv_FMURef trgPort) then
			(((env\<^sub>F\<^sub>M\<^sub>U ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (srcPort)))))) (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (srcPort))) = ((env\<^sub>F\<^sub>M\<^sub>U ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (trgPort)))))) (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (trgPort))))
		 else
			undefined
		)
		))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 464:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 471:16\<close>
definition
	pre_activateClocks :: "Importer\<Rightarrow> FMURef VDMSet \<Rightarrow> \<bool>"
where
	"pre_activateClocks I clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_activateClocks specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' inv_FMURef  clocks))  \<and> 
		\<comment>\<open>User defined body of pre_activateClocks\<close>
		(clocks \<subseteq> ((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<inter> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 464:5\<close>
definition
	post_activateClocks :: "Importer\<Rightarrow> FMURef VDMSet\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_activateClocks I  clocks  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_activateClocks specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  (inv_VDMSet' inv_FMURef  clocks)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))"

definition
	activateClocks :: "Importer\<Rightarrow> FMURef VDMSet \<Rightarrow> Importer"
where
	"activateClocks I clocks \<equiv> 
	\<comment>\<open>User defined body of activateClocks\<close>
	(
		if ((clocks = {})) then
		(I)
		else
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (
		let 
(I1::Importer) = (setClock I  (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock))  (True::\<bool>))
		in
			(if (inv_Importer I1) then
			(activateClocks I1  (clocks - {clock}))
		 else
			undefined
		)
		) | clock .  ((clock \<in>clocks))  }))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 478:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 490:9\<close>
definition
	pre_updateEnvironmentClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"pre_updateEnvironmentClock I fmu clock val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_updateEnvironmentClock specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat clock))  \<and>  (inv_bool val))  \<and> 
		\<comment>\<open>User defined body of pre_updateEnvironmentClock\<close>
		(
		let 
(fmuRef::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef fmuRef) then
			((fmuRef \<in> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<or> (fmuRef \<in> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))
		 else
			undefined
		)
		)"

definition
	updateEnvironmentClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> Importer"
where
	"updateEnvironmentClock Ifmuclockval \<equiv> 
	\<comment>\<open>User defined body of updateEnvironmentClock\<close>
	(
		let 
(fmuref::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>;
		
(activatedVariables::FMURef VDMSet) = (createFMURefs fmu  (\<Union> { (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (clock = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c))) })  {})
		in
			(if (inv_FMURef fmuref) \<and> 
	((inv_VDMSet' inv_FMURef  activatedVariables)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmu))\<mapsto>fmu])\<rparr>, activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> {fmuref}))
		else
		(((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - {fmuref}))), readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - {fmuref}))
		else
		((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))), inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - {fmuref}))
		else
		(((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> {fmuref}))), activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> activatedVariables))
		else
		(((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - activatedVariables))), readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - activatedVariables))
		else
		((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))\<rparr>
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 496:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 509:9\<close>
definition
	pre_queryClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"pre_queryClock I fmu clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_queryClock specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat clock)))  \<and> 
		\<comment>\<open>User defined body of pre_queryClock\<close>
		((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> \<in> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (clock \<in> { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) = (inputLF)) }))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 496:5\<close>
definition
	post_queryClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_queryClock I  fmu  clock  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_queryClock specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu)))
		)  \<and>  ((inv_VDMNat clock))  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))"

definition
	queryClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> Importer"
where
	"queryClock I fmu clock \<equiv> 
	\<comment>\<open>User defined body of queryClock\<close>
	(
		let 
((fmuUpdated  val)::(FMU\<times> Value)) = (get_cm fmu  clock);
		
(fmuref::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val)))))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val))))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val))))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val))))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val))))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val)))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val))))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val))))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val)))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val))))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  val))))) )\<and>
		  (((((inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd (fmuUpdated  val))))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd (fmuUpdated  val)))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd (fmuUpdated  val))))))
		)) )
		)) \<and> 
	(inv_FMURef fmuref) then
			(
		let 
(connectedClock::FMURef) = (the((clockConnections\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) fmuref))
		in
			(if (inv_FMURef connectedClock) then
			(
		let 
(I1::Importer) = (I)\<lparr>valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<dagger> [connectedClock\<mapsto>val]), relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - {fmuref}), relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> {connectedClock})\<rparr>
		in
			(if (inv_Importer I1) then
			(updateEnvironmentClock I1  fmuUpdated  clock  (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (val)))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 515:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 527:17\<close>
definition
	pre_setClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
	"pre_setClock I fmu clock val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_setClock specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  ((inv_VDMNat clock))  \<and>  (inv_bool val))  \<and> 
		\<comment>\<open>User defined body of pre_setClock\<close>
		(((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> \<in> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> val) \<longleftrightarrow> (\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> \<in> ((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<inter> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))"

definition
	setClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> \<bool> \<Rightarrow> Importer"
where
	"setClock Ifmuclockval \<equiv> 
	\<comment>\<open>User defined body of setClock\<close>
	(
		let 
(fmuUpdated::FMU) = (set_cm fmu  clock  val);
		
(fmuref::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMU fmuUpdated) \<and> 
	(inv_FMURef fmuref) then
			(
		let 
(feedthroughClocks::FMURef VDMSet) = { \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c))\<rparr> | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (clock \<in> (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c))) }
		in
			(if ((inv_VDMSet' inv_FMURef  feedthroughClocks)) then
			(
		let 
(I1::Importer) = (I)\<lparr>valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ({fmuref} -\<triangleleft> (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))), relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - {fmuref}), relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> feedthroughClocks)\<rparr>
		in
			(if (inv_Importer I1) then
			(updateEnvironmentClock I1  fmuUpdated  clock  val)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 531:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 539:14\<close>
definition
	pre_setPort :: "Importer\<Rightarrow> FMURef \<Rightarrow> \<bool>"
where
	"pre_setPort I port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_setPort specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)))) ))  \<and> 
		\<comment>\<open>User defined body of pre_setPort\<close>
		(port \<in> (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 531:5\<close>
definition
	post_setPort :: "Importer\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_setPort I  port  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_setPort specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))))
		)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))"

definition
	setPort :: "Importer\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"setPort I port \<equiv> 
	\<comment>\<open>User defined body of setPort\<close>
	(
		let 
(valueLF::Value) = (the((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) port))
		in
			(if (inv_Value valueLF) then
			(
		let 
(fmu::FMU) = (set_m (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port))  valueLF)
		in
			(if (inv_FMU fmu) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmu))\<mapsto>fmu])\<rparr>, valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ({port} -\<triangleleft> (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<rparr>
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 543:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 551:38\<close>
definition
	pre_getPort :: "Importer\<Rightarrow> FMURef \<Rightarrow> \<bool>"
where
	"pre_getPort I port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_getPort specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)))) ))  \<and> 
		\<comment>\<open>User defined body of pre_getPort\<close>
		((the((connections\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) port)) \<notin> (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 543:5\<close>
definition
	post_getPort :: "Importer\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_getPort I  port  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_getPort specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))))
		)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))"

definition
	getPort :: "Importer\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"getPort I port \<equiv> 
	\<comment>\<open>User defined body of getPort\<close>
	(
		let 
((fmu  val)::(FMU\<times> Value)) = (get_m (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port)));
		
(connectedInput::FMURef) = (the((connections\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) port))
		in
			(if (
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val)))))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val))))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val))))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val))))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val))))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val)))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val))))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val))))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val)))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val))))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst (fmu  val))))) )\<and>
		  (((((inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd (fmu  val))))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd (fmu  val)))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd (fmu  val))))))
		)) )
		)) \<and> 
	(inv_FMURef connectedInput) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmu))\<mapsto>fmu])\<rparr>, valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<dagger> [connectedInput\<mapsto>val])\<rparr>
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 554:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 566:18\<close>
definition
	pre_updateEnvironmentEquation :: "Importer\<Rightarrow> FMU\<Rightarrow> FMURef \<Rightarrow> \<bool>"
where
	"pre_updateEnvironmentEquation I fmu equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_updateEnvironmentEquation specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) ))  \<and> 
		\<comment>\<open>User defined body of pre_updateEnvironmentEquation\<close>
		(equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 567:19\<close>
definition
	post_updateEnvironmentEquation :: "Importer\<Rightarrow> FMU\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_updateEnvironmentEquation I fmu equation RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_updateEnvironmentEquation specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) )  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_updateEnvironmentEquation\<close>
		(equation \<in> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT)))"

definition
	updateEnvironmentEquation :: "Importer\<Rightarrow> FMU\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"updateEnvironmentEquation I fmu equation \<equiv> 
	\<comment>\<open>User defined body of updateEnvironmentEquation\<close>
	(
		let 
(triggeredClocks::Clock VDMSet) = { clock .   ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation)) \<in> (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock))) }
		in
			(if ((inv_VDMSet' inv_Clock  triggeredClocks)) then
			(
		let 
(triggeredInputs::FMURef VDMSet) = { \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (inputClock))\<rparr> | inputClock .  ((inputClock \<in>triggeredClocks))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (inputClock)) \<noteq> (inputLF)) };
		
(triggeredOutputs::FMURef VDMSet) = { \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (outputClock))\<rparr> | outputClock .  ((outputClock \<in>triggeredClocks))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (outputClock)) \<noteq> (outputLF)) }
		in
			(if ((inv_VDMSet' inv_FMURef  triggeredInputs)) \<and> 
	((inv_VDMSet' inv_FMURef  triggeredOutputs)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmu))\<mapsto>fmu])\<rparr>, calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> {equation}), relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> triggeredInputs), relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> triggeredOutputs)\<rparr>
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 573:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 578:9\<close>
definition
	pre_calculateInput :: "Importer\<Rightarrow> FMURef \<Rightarrow> \<bool>"
where
	"pre_calculateInput I equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_calculateInput specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) ))  \<and> 
		\<comment>\<open>User defined body of pre_calculateInput\<close>
		(
		let 
(fmu::FMU) = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))))
		in
			(if (inv_FMU fmu) then
			((equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> ((equation \<in> (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (EVENT)) \<and> (\<exists> v \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = (discrete)))))))
		 else
			undefined
		)
		)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 573:5\<close>
definition
	post_calculateInput :: "Importer\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_calculateInput I  equation  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_calculateInput specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))"

definition
	calculateInput :: "Importer\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"calculateInput I equation \<equiv> 
	\<comment>\<open>User defined body of calculateInput\<close>
	(
		let 
(I1::Importer) = (setPort I  equation)
		in
			(if (inv_Importer I1) then
			(updateEnvironmentEquation I1  (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))))  equation)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 588:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 593:9\<close>
definition
	pre_calculateOutput :: "Importer\<Rightarrow> FMURef \<Rightarrow> \<bool>"
where
	"pre_calculateOutput I equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_calculateOutput specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) ))  \<and> 
		\<comment>\<open>User defined body of pre_calculateOutput\<close>
		(
		let 
(fmu::FMU) = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))))
		in
			(if (inv_FMU fmu) then
			((equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (EVENT)) \<and> (\<exists> v \<in> (outputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = (discrete))))))
		 else
			undefined
		)
		)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 588:5\<close>
definition
	post_calculateOutput :: "Importer\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_calculateOutput I  equation  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_calculateOutput specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  
		((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)))) \<and>
		(((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))"

definition
	calculateOutput :: "Importer\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"calculateOutput I equation \<equiv> 
	\<comment>\<open>User defined body of calculateOutput\<close>
	(
		let 
(I1::Importer) = (getPort I  equation)
		in
			(if (inv_Importer I1) then
			(updateEnvironmentEquation I1  (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))))  equation)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 602:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 602:5\<close>
definition
	pre_runAlgorithm :: "Importer\<Rightarrow> Action VDMSet \<Rightarrow> \<bool>"
where
	"pre_runAlgorithm I  algorithm \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_runAlgorithm specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' inv_Action  algorithm))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 602:5\<close>
definition
	post_runAlgorithm :: "Importer\<Rightarrow> Action VDMSet\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_runAlgorithm I  algorithm  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_runAlgorithm specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  (inv_VDMSet' inv_Action  algorithm)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))"

definition
	runAlgorithm :: "Importer\<Rightarrow> Action VDMSet \<Rightarrow> Importer"
where
	"runAlgorithm I algorithm \<equiv> 
	\<comment>\<open>User defined body of runAlgorithm\<close>
	(
		if ((algorithm = {})) then
		(I)
		else
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (runAlgorithm (runAction I  action)  (algorithm - {action})) | action .  ((action \<in>{ a .   ((a \<in>algorithm))  \<and> (activatedAction I  a) }))  }))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 615:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 622:9\<close>
definition
	pre_initializeData :: "Importer \<Rightarrow> \<bool>"
where
	"pre_initializeData I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_initializeData specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) ))  \<and> 
		\<comment>\<open>User defined body of pre_initializeData\<close>
		(\<forall> fmu \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (INIT)))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 623:10\<close>
definition
	post_initializeData :: "Importer\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_initializeData I RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_initializeData specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_initializeData\<close>
		(variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT)))"

definition
	initializeData :: "Importer \<Rightarrow> Importer"
where
	"initializeData I \<equiv> 
	\<comment>\<open>User defined body of initializeData\<close>
	(
		let 
(connections::(FMURef \<rightharpoonup> FMURef)) = (connections\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))
		in
			(if ((inv_Map inv_FMURef  inv_FMURef  connections)) then
			(
		let 
(outputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (get), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))\<rparr> | outputLF .  ((outputLF \<in>(dom connections)))  };
		
(inputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (set), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))\<rparr> | inputLF .  ((inputLF \<in>(rng connections)))  }
		in
			(if ((inv_VDMSet' inv_Action  outputs)) \<and> 
	((inv_VDMSet' inv_Action  inputs)) then
			(runAlgorithm I  (outputs \<union> inputs))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 630:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 642:9\<close>
definition
	pre_cosimStep :: "Importer \<Rightarrow> \<bool>"
where
	"pre_cosimStep I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_cosimStep specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) ))  \<and> 
		\<comment>\<open>User defined body of pre_cosimStep\<close>
		(
		let 
(scenario::Machine) = (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))
		in
			(if (inv_Machine scenario) then
			((\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario)))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (STEP))) \<and> ((variablesSynchronized scenario) \<and> (fmusSynchronized scenario)))
		 else
			undefined
		)
		)"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 645:9\<close>
definition
	post_cosimStep :: "Importer\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_cosimStep I RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_cosimStep specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_cosimStep\<close>
		(
		let 
(scenario::Machine) = (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))
		in
			(if (inv_Machine scenario) then
			((\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario)))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (STEP))) \<and> ((variablesSynchronized scenario) \<and> (fmusSynchronized scenario)))
		 else
			undefined
		)
		)"

definition
	cosimStep :: "Importer \<Rightarrow> Importer"
where
	"cosimStep I \<equiv> 
	\<comment>\<open>User defined body of cosimStep\<close>
	(
		let 
(connections::(FMURef \<rightharpoonup> FMURef)) = (connections\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))
		in
			(if ((inv_Map inv_FMURef  inv_FMURef  connections)) then
			(
		let 
(fmus::FMU VDMSet) = (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))
		in
			(if ((inv_VDMSet' inv_FMU  fmus)) then
			(
		let 
(outputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (get), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))\<rparr> | outputLF .  ((outputLF \<in>(dom connections)))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e ((derefOutput (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))))) = (continous)) };
		
(inputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (set), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))\<rparr> | inputLF .  ((inputLF \<in>(rng connections)))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e ((derefInput (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))))) = (continous)) };
		
(steps::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (step), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = fmu, port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (1::VDMNat1)\<rparr> | fmu .  ((fmu \<in>fmus))  }
		in
			(if ((inv_VDMSet' inv_Action  outputs)) \<and> 
	((inv_VDMSet' inv_Action  inputs)) \<and> 
	((inv_VDMSet' inv_Action  steps)) then
			(
		let 
(actions::Action VDMSet) = ((outputs \<union> inputs) \<union> steps)
		in
			(if ((inv_VDMSet' inv_Action  actions)) then
			(runAlgorithm I  actions)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 651:5\<close>
definition
	runAction :: "Importer\<Rightarrow> Action \<Rightarrow> Importer"
where
	"runAction IA \<equiv> 
	\<comment>\<open>User defined body of runAction\<close>
	(\<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. optional, union, etc.) for `Action` VDM type.\<close>)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 673:5\<close>
definition
	stepFMU :: "Importer\<Rightarrow> FMU \<Rightarrow> Importer"
where
	"stepFMU Ifmu \<equiv> 
	\<comment>\<open>User defined body of stepFMU\<close>
	(
		let 
((fmuUpdated  step  event)::(FMU\<times> VDMReal\<times> \<bool>)) = (step_tm fmu  (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))
		in
			(if (
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event)))))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event))))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event))))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event))))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event))))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event)))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event))))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event))))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event)))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event))))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst (fmuUpdated  step  event))))) )\<and>
		 (inv_VDMReal (fst (snd (fmuUpdated  step  event))))\<and>
		 (inv_bool (snd (snd (fmuUpdated  step  event))))
		)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmuUpdated))\<mapsto>fmuUpdated])\<rparr>, fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (event) then
		(((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> {(name\<^sub>F\<^sub>M\<^sub>U (fmu))}))
		else
		((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))), stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := step\<rparr>
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 686:5\<close>
definition
	activatedAction :: "Importer\<Rightarrow> Action \<Rightarrow> \<bool>"
where
	"activatedAction IA \<equiv> 
	\<comment>\<open>User defined body of activatedAction\<close>
	(\<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. optional, union, etc.) for `Action` VDM type.\<close>)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 700:5\<close>
definition
	preSetI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"preSetI Ifmuport \<equiv> 
	\<comment>\<open>User defined body of preSetI\<close>
	(
		let 
(inputLF::Variable) = (derefInput fmu  port)
		in
			(if (inv_Variable inputLF) then
			((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (EVENT)) \<longleftrightarrow> ((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = port\<rparr> \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (inputLF)) = (discrete)))) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (STEP)) \<longleftrightarrow> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (inputLF)) = (continous))) \<and> (preSet fmu  port)))
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 708:5\<close>
definition
	preGetI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"preGetI Ifmuport \<equiv> 
	\<comment>\<open>User defined body of preGetI\<close>
	(
		let 
(outputLF::Variable) = (derefOutput fmu  port)
		in
			(if (inv_Variable outputLF) then
			((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (EVENT)) \<longleftrightarrow> ((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = port\<rparr> \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (outputLF)) = (discrete)))) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (STEP)) \<longleftrightarrow> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (outputLF)) = (continous))) \<and> (preGet fmu  port)))
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 716:5\<close>
definition
	preStepI :: "Importer\<Rightarrow> FMU \<Rightarrow> \<bool>"
where
	"preStepI Ifmu \<equiv> 
	\<comment>\<open>User defined body of preStepI\<close>
	(preStepT fmu  (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 720:5\<close>
definition
	preGetCI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"preGetCI Ifmuclock \<equiv> 
	\<comment>\<open>User defined body of preGetCI\<close>
	(
		let 
(outputLF::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef outputLF) then
			((outputLF \<in> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (preGetC fmu  clock))
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 727:5\<close>
definition
	preSetCI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> \<bool>"
where
	"preSetCI Ifmuclock \<equiv> 
	\<comment>\<open>User defined body of preSetCI\<close>
	(
		let 
(inputLF::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef inputLF) then
			(
		let 
(val::Value) = (the((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) inputLF))
		in
			(if (inv_Value val) then
			((preSetC fmu  clock  (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (val))) \<and> (inputLF \<in> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 741:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 747:9\<close>
definition
	pre_feedthroughSatisfied :: "FMU\<Rightarrow> Variable \<Rightarrow> \<bool>"
where
	"pre_feedthroughSatisfied fmu outputLF \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_feedthroughSatisfied specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>   ((((inv_VDMNat (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputLF)))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputLF)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputLF))))
		)) \<and>
		((((inv_True (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputLF))))) \<and>
		((((inv_True (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputLF))))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputLF))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputLF))) \<and>
		((((inv_True (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputLF))))) ))  \<and> 
		\<comment>\<open>User defined body of pre_feedthroughSatisfied\<close>
		(\<forall> i \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = (inputLF)))"

definition
	feedthroughSatisfied :: "FMU\<Rightarrow> Variable \<Rightarrow> \<bool>"
where
	"feedthroughSatisfied fmuoutputLF \<equiv> 
	\<comment>\<open>User defined body of feedthroughSatisfied\<close>
	(\<forall> i \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) \<in> (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (outputLF))) \<and> ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = (reactive)) \<longrightarrow> ((time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (((env\<^sub>F\<^sub>M\<^sub>U (fmu)) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i))))) \<ge> (time\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> (((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = (delayed)) \<longrightarrow> ((time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (((env\<^sub>F\<^sub>M\<^sub>U (fmu)) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i))))) = (time\<^sub>F\<^sub>M\<^sub>U (fmu)))))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 753:1\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 753:1\<close>
definition
	pre_updateSchedule :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Interval VDMSet \<Rightarrow> \<bool>"
where
	"pre_updateSchedule I  fmus  intervalSet \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_updateSchedule specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus)  \<and>  (inv_VDMSet' (calculated \<and>  (inv_True) \<and>  (inv_True) \<and>  (inv_True) \<and>  (inv_True) \<and>  (inv_True) \<and>  (inv_True)) intervalSet))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 753:1\<close>
definition
	post_updateSchedule :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Interval VDMSet\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_updateSchedule I  fmus  intervalSet  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_updateSchedule specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  (inv_VDMSet' (inv_Name) fmus)  \<and>  (inv_VDMSet' (inv_Interval) intervalSet)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))"

definition
	updateSchedule :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Interval VDMSet \<Rightarrow> Importer"
where
	"updateSchedule I fmus intervalSet \<equiv> 
	\<comment>\<open>User defined body of updateSchedule\<close>
	(
		if ((fmus = {})) then
		(I)
		else
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (
		let 
(fmu::FMU) = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name))
		in
			(if (inv_FMU fmu) then
			(
		let 
(relevantClocks::Ref VDMSet) = { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) \<in> intervalSet) }
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) relevantClocks)) then
			(
		let 
(scheduleEntries::(FMURef \<rightharpoonup> VDMReal)) = (calculateSchedule fmu  relevantClocks  [])
		in
			(if ((inv_Map inv_FMURef  (inv_VDMReal) scheduleEntries)) then
			(
		let 
(I1::Importer) = (I)\<lparr>schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<dagger> scheduleEntries)\<rparr>
		in
			(if (inv_Importer I1) then
			(updateSchedule I1  (fmus - {name})  intervalSet)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		) | name .  ((name \<in>fmus))  }))))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 769:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 773:9\<close>
definition
	pre_createSchedule :: "Importer \<Rightarrow> \<bool>"
where
	"pre_createSchedule I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_createSchedule specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) ))  \<and> 
		\<comment>\<open>User defined body of pre_createSchedule\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (INIT)) \<and> ((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 777:9\<close>
definition
	post_createSchedule :: "Importer\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_createSchedule I RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_createSchedule specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_createSchedule\<close>
		(
		let 
(timeBasedClocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu  { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = (inputLF)) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) \<noteq> (triggered))) }  {}) | fmu .  ((fmu \<in>(rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))))  })
		in
			(if ((inv_VDMSet' inv_FMURef  timeBasedClocks)) then
			(((dom (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))) = timeBasedClocks) \<and> ((\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (INIT))) \<and> ((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))))
		 else
			undefined
		)
		)"

definition
	createSchedule :: "Importer \<Rightarrow> Importer"
where
	"createSchedule I \<equiv> 
	\<comment>\<open>User defined body of createSchedule\<close>
	(
		let 
(fmus::Name VDMSet) = (dom (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus)) then
			(updateSchedule I  fmus  {(constantLF), (fixed), (calculated), (tunable), (changing), (countdown)})
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 788:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 803:9\<close>
definition
	pre_initialization :: "Importer \<Rightarrow> \<bool>"
where
	"pre_initialization I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_initialization specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) ))  \<and> 
		\<comment>\<open>User defined body of pre_initialization\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (INIT)) \<and> (fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 805:10\<close>
definition
	post_initialization :: "Importer\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_initialization I RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_initialization specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_initialization\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (STEP)) \<and> ((variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))) \<and> (fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))))))"

definition
	initialization :: "Importer \<Rightarrow> Importer"
where
	"initialization I \<equiv> 
	\<comment>\<open>User defined body of initialization\<close>
	(
		let 
(I1::Importer) = (initializeData I)
		in
			(if (inv_Importer I1) then
			(
		let 
(I2::Importer) = (createSchedule I1)
		in
			(if (inv_Importer I2) then
			(enterStepMode I2  (dom (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I2))))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 812:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 812:5\<close>
definition
	pre_tickingClocks :: "Importer \<Rightarrow> \<bool>"
where
	"pre_tickingClocks I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_tickingClocks specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) ))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 812:5\<close>
definition
	post_tickingClocks :: "Importer\<Rightarrow> (Importer\<times> FMURef VDMSet) \<Rightarrow> \<bool>"
where
	"post_tickingClocks I  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_tickingClocks specification\<close>
		(
		(( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		)  \<and>  
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT))))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT))))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT))))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst RESULT)))) )\<and>
		 (inv_VDMSet' inv_FMURef  (snd RESULT))
		))"

definition
	tickingClocks :: "Importer \<Rightarrow> (Importer\<times> FMURef VDMSet)"
where
	"tickingClocks I \<equiv> 
	\<comment>\<open>User defined body of tickingClocks\<close>
	(
		let 
(clocks::FMURef VDMSet) = (dom ((schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<triangleright> {(r\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))}))
		in
			(if ((inv_VDMSet' inv_FMURef  clocks)) then
			(
		let 
(I1::Importer) = (I)\<lparr>relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := clocks\<rparr>
		in
			(if (inv_Importer I1) then
			(I1, clocks)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 825:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 825:5\<close>
definition
	pre_stepnegotiation :: "Importer \<Rightarrow> \<bool>"
where
	"pre_stepnegotiation M \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_stepnegotiation specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) ))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 829:9\<close>
definition
	post_stepnegotiation :: "Importer\<Rightarrow> VDMReal \<Rightarrow> \<bool>"
where
	"post_stepnegotiation M RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_stepnegotiation specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r M))) )  \<and>  (inv_VDMReal RESULT))  \<and> 
		\<comment>\<open>User defined body of post_stepnegotiation\<close>
		((RESULT \<ge> (0::VDMNat)) \<and> (\<forall> fmu \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (M)))))  . ((maxStep\<^sub>F\<^sub>M\<^sub>U (fmu)) \<ge> RESULT)))"

definition
	stepnegotiation :: "Importer \<Rightarrow> VDMReal"
where
	"stepnegotiation M \<equiv> 
	\<comment>\<open>User defined body of stepnegotiation\<close>
	undefined"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 834:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 858:9\<close>
definition
	pre_cosimulationStep :: "Importer \<Rightarrow> \<bool>"
where
	"pre_cosimulationStep I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_cosimulationStep specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) ))  \<and> 
		\<comment>\<open>User defined body of pre_cosimulationStep\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (STEP)) \<and> ((variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 861:10\<close>
definition
	post_cosimulationStep :: "Importer\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_cosimulationStep I RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_cosimulationStep specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_cosimulationStep\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = (STEP)) \<and> ((variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))) \<and> (fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))))))"

definition
	cosimulationStep :: "Importer \<Rightarrow> Importer"
where
	"cosimulationStep I \<equiv> 
	\<comment>\<open>User defined body of cosimulationStep\<close>
	(
		let 
((I1  clocksToTick)::(Importer\<times> FMURef VDMSet)) = (tickingClocks I)
		in
			(if (
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick)))))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick)))))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick)))))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick)))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick)))))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst (I1  clocksToTick))))) )\<and>
		 (inv_VDMSet' inv_FMURef  (snd (I1  clocksToTick)))
		)) then
			(
		let 
(eventDetected::\<bool>) = ((clocksToTick \<noteq> {}) \<or> ((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I1)) \<noteq> {}))
		in
			(if ((inv_bool eventDetected)) then
			(
		let 
(I2::Importer) = (
		if (eventDetected) then
		((clockedSimulationAlgorithm I1  clocksToTick))
		else
		(I))
		in
			(if (inv_Importer I2) then
			(
		let 
(I3::Importer) = (I)\<lparr>stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (stepnegotiation I2)\<rparr>
		in
			(if (inv_Importer I3) then
			(
		let 
(I4::Importer) = (cosimStep I3)
		in
			(if (inv_Importer I4) then
			(
		if (((endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I4)) \<ge> (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I4)))) then
		((cosimulationStep I4))
		else
		(I4))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 866:5\<close>
definition
	fmusSynchronized :: "Machine \<Rightarrow> \<bool>"
where
	"fmusSynchronized M \<equiv> 
	\<comment>\<open>User defined body of fmusSynchronized\<close>
	((vdm_card { (time\<^sub>F\<^sub>M\<^sub>U (fmu)) | fmu .  ((fmu \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))))  }) = (1::VDMNat1))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 875:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 884:48\<close>
definition
	pre_calculateRelevantFMUs :: "Machine\<Rightarrow> Name VDMSet\<Rightarrow> Name VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> \<bool>"
where
	"pre_calculateRelevantFMUs M relevantFMUs notRelevantFMUs clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_calculateRelevantFMUs specification\<close>
		( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) relevantFMUs)  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) notRelevantFMUs)  \<and>  (inv_VDMSet' inv_FMURef  clocks))  \<and> 
		\<comment>\<open>User defined body of pre_calculateRelevantFMUs\<close>
		((relevantFMUs \<inter> notRelevantFMUs) = {})"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 886:13\<close>
definition
	post_calculateRelevantFMUs :: "Machine\<Rightarrow> Name VDMSet\<Rightarrow> Name VDMSet\<Rightarrow> FMURef VDMSet\<Rightarrow> Name VDMSet \<Rightarrow> \<bool>"
where
	"post_calculateRelevantFMUs M relevantFMUs notRelevantFMUs clocks RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_calculateRelevantFMUs specification\<close>
		( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) relevantFMUs)  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) notRelevantFMUs)  \<and>  (inv_VDMSet' inv_FMURef  clocks)  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) RESULT))  \<and> 
		\<comment>\<open>User defined body of post_calculateRelevantFMUs\<close>
		(({ (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock)) | clock .  ((clock \<in>clocks))  } \<subseteq> RESULT) \<and> (RESULT \<subseteq> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))))"

definition
	calculateRelevantFMUs :: "Machine\<Rightarrow> Name VDMSet\<Rightarrow> Name VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> Name VDMSet"
where
	"calculateRelevantFMUs MrelevantFMUsnotRelevantFMUsclocks \<equiv> 
	\<comment>\<open>User defined body of calculateRelevantFMUs\<close>
	(
		let 
(addedFMUs::Name VDMSet) = ({ (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock)) | clock .  ((clock \<in>clocks))  } \<union> { (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f ((the((clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) con)))) | con .  ((con \<in>(dom (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))))  \<and> (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (con)) \<in> relevantFMUs) \<and> ((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f ((the((clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) con)))) \<in> notRelevantFMUs)) })
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) addedFMUs)) then
			(
		if ((addedFMUs = {})) then
		(relevantFMUs)
		else
		((calculateRelevantFMUs M  (relevantFMUs \<union> addedFMUs)  (notRelevantFMUs - addedFMUs)  clocks)))
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 895:1\<close>
definition
	solveSystemOfEquations :: "Importer \<Rightarrow> Importer"
where
	"solveSystemOfEquations I \<equiv> 
	\<comment>\<open>User defined body of solveSystemOfEquations\<close>
	(
		if ((((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) = {})) then
		(I)
		else
		((
		let 
(clockActions::Action VDMSet) = ({ \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (setC), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock))\<rparr> | clock .  ((clock \<in>(relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))  } \<union> { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (getC), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock))\<rparr> | clock .  ((clock \<in>(relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))  })
		in
			(if ((inv_VDMSet' inv_Action  clockActions)) then
			(
		if (((clockActions \<noteq> {}) \<and> ({ a .   ((a \<in>clockActions))  \<and> (activatedAction I  a) } \<noteq> {}))) then
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (solveSystemOfEquations (runAction I  clockAction)) | clockAction .  ((clockAction \<in>{ a .   ((a \<in>clockActions))  \<and> (activatedAction I  a) }))  })))
		else
		((
		let 
(portActions::Action VDMSet) = ({ \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (set), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))\<rparr> | inputLF .  ((inputLF \<in>((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  } \<union> { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (get), fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))\<rparr> | outputLF .  ((outputLF \<in>((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  })
		in
			(if ((inv_VDMSet' inv_Action  portActions)) then
			(
		SOME (dummy0::Importer) .(dummy0 \<in> { (solveSystemOfEquations (runAction I  portAction)) | portAction .  ((portAction \<in>{ a .   ((a \<in>portActions))  \<and> (activatedAction I  a) }))  }))
		 else
			undefined
		)
		)))
		 else
			undefined
		)
		)))"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 913:1\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 938:9\<close>
definition
	pre_eventIteration :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> \<bool>"
where
	"pre_eventIteration I relevantFMUs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_eventIteration specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) relevantFMUs))  \<and> 
		\<comment>\<open>User defined body of pre_eventIteration\<close>
		((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (\<forall> fmu \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (EVENT))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 939:10\<close>
definition
	post_eventIteration :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_eventIteration I relevantFMUs RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_eventIteration specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) relevantFMUs)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_eventIteration\<close>
		(\<forall> fmu \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (EVENT)) \<and> (((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) = {})))"

definition
	eventIteration :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"eventIteration IrelevantFMUs \<equiv> 
	\<comment>\<open>User defined body of eventIteration\<close>
	(
		let 
(I1::Importer) = (solveSystemOfEquations I)
		in
			(if (inv_Importer I1) then
			(
		let 
(I2::Importer) = (updateDiscreteState I1  relevantFMUs)
		in
			(if (inv_Importer I2) then
			(updateSchedule I2  relevantFMUs  {(tunable), (changing), (countdown)})
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 948:5\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 978:9\<close>
definition
	pre_clockedSimulationAlgorithm :: "Importer\<Rightarrow> FMURef VDMSet \<Rightarrow> \<bool>"
where
	"pre_clockedSimulationAlgorithm I clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_clockedSimulationAlgorithm specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' inv_FMURef  clocks))  \<and> 
		\<comment>\<open>User defined body of pre_clockedSimulationAlgorithm\<close>
		((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (\<forall> fmu \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (STEP)) \<and> (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<noteq> {}) \<or> (clocks \<noteq> {})))))"


\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 981:9\<close>
definition
	post_clockedSimulationAlgorithm :: "Importer\<Rightarrow> FMURef VDMSet\<Rightarrow> Importer \<Rightarrow> \<bool>"
where
	"post_clockedSimulationAlgorithm I clocks RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_clockedSimulationAlgorithm specification\<close>
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) )  \<and>  (inv_VDMSet' inv_FMURef  clocks)  \<and>   (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) )) \<and>
		((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		)) \<and>
		((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and>
		((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) ))  \<and> 
		\<comment>\<open>User defined body of post_clockedSimulationAlgorithm\<close>
		((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (\<forall> fmu \<in> (rng (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = (STEP))))"

definition
	clockedSimulationAlgorithm :: "Importer\<Rightarrow> FMURef VDMSet \<Rightarrow> Importer"
where
	"clockedSimulationAlgorithm Iclocks \<equiv> 
	\<comment>\<open>User defined body of clockedSimulationAlgorithm\<close>
	(
		let 
(relevantFMUs::Name VDMSet) = (calculateRelevantFMUs (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))  (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))  ((dom (fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))) - (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))  clocks)
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) relevantFMUs)) then
			(
		let 
(I1::Importer) = (enterEventMode I  relevantFMUs)
		in
			(if (inv_Importer I1) then
			(
		let 
(I2::Importer) = (activateClocks I1  clocks)
		in
			(if (inv_Importer I2) then
			(
		let 
(I3::Importer) = (eventIteration I2  relevantFMUs)
		in
			(if (inv_Importer I3) then
			(
		if (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I3)) \<noteq> {})) then
		((enterStepMode I3  relevantFMUs))
		else
		((clockedSimulationAlgorithm I  clocks)))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 985:1\<close>

\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 1004:1\<close>
definition
	pre_calculateSchedule :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> (FMURef \<rightharpoonup> VDMReal) \<Rightarrow> \<bool>"
where
	"pre_calculateSchedule fmu clocks schedule \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_calculateSchedule specification\<close>
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and>
		(
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))))
		)) \<and>
		((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		(((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and>
		((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and>
		((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) )  \<and>  (inv_VDMSet' ((inv_VDMNat)) clocks)  \<and>  (inv_Map inv_FMURef  (inv_VDMReal) schedule))  \<and> 
		\<comment>\<open>User defined body of pre_calculateSchedule\<close>
		(
		let 
(cref::Ref VDMSet) = { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) = (inputLF)) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) \<noteq> (triggered))) }
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) cref)) then
			(clocks \<subseteq> cref)
		 else
			undefined
		)
		)"

definition
	calculateSchedule :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> (FMURef \<rightharpoonup> VDMReal) \<Rightarrow> (FMURef \<rightharpoonup> VDMReal)"
where
	"calculateSchedule fmuclocksschedule \<equiv> 
	\<comment>\<open>User defined body of calculateSchedule\<close>
	(
		if ((clocks = {})) then
		(schedule)
		else
		((
		SOME (dummy0::(FMURef \<rightharpoonup> VDMReal)) .(dummy0 \<in> { (
		let 
(fmuRef::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef fmuRef) then
			(
		let 
(n::RealNaNLF) = (next_tm fmu  clock);
		
(S1::(FMURef \<rightharpoonup> VDMReal)) = (schedule \<dagger> (
		if (not yet) then
		([fmuRef\<mapsto>(next_tm fmu  clock)])
		else
		([])))
		in
			(if ((NaN \<and>  (inv_VDMReal))n) \<and> 
	((inv_Map inv_FMURef  (inv_VDMReal) S1)) then
			(calculateSchedule fmu  (clocks - {clock})  S1)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		) | clock .  ((clock \<in>clocks))  }))))"

end