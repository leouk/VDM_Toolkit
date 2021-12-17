(* VDM to Isabelle Translation @2021-12-17T14:09:24.808069Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/real/Clocks.vdmsl' at line 1:8
files = [./src/test/resources/real/Clocks.vdmsl]
*)
theory Clocks
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Time = compose Time of r:real, i:nat end
	inv t == ((t.r) >= 0)
	ord a < b == (((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 37:5\<close>
record Time = 
	r\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMReal"
		 i\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMNat"
	

\<comment>\<open>VDM source: inv_Time: (Time +> bool)
	inv_Time(t) ==
((t.r) >= 0)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 41:9\<close>
definition
	inv_Time :: "Time \<Rightarrow> bool"
where
	"inv_Time t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Time` specification.\<close>
		( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e t))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e t))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Time.\<close>
		((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (t)) \<ge> (0::VDMNat))"

		

\<comment>\<open>VDM source: ord_Time: (Time * Time +> bool)
	ord_Time(a, b) ==
(((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 43:9\<close>
definition
	ord_Time :: "Time\<Rightarrow> Time \<Rightarrow> bool"
where
	"ord_Time a  b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of ord_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) < (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b))) \<or> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b))) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (a)) < (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (b)))))"

		

	
\<comment>\<open>VDM source: Interval = (<calculated> | <changing> | <constantLF> | <countdown> | <fixed> | <triggered> | <tunable>)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 50:5\<close>
datatype Interval = U_calculated  | 
		 U_changing  | 
		 U_constantLF  | 
		 U_countdown  | 
		 U_fixed  | 
		 U_triggered  | 
		 U_tunable 
	

\<comment>\<open>VDM source: inv_Interval: (Interval +> bool)
	inv_Interval(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 50:5\<close>
definition
	inv_Interval :: "Interval \<Rightarrow> bool"
where
	"inv_Interval dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Interval` specification.\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>VDM source: ActionType = (<get> | <getC> | <set> | <setC> | <step>)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 55:5\<close>
datatype ActionType = U_get  | 
		 U_getC  | 
		 U_set  | 
		 U_setC  | 
		 U_step 
	

\<comment>\<open>VDM source: inv_ActionType: (ActionType +> bool)
	inv_ActionType(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 55:5\<close>
definition
	inv_ActionType :: "ActionType \<Rightarrow> bool"
where
	"inv_ActionType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ActionType` specification.\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>VDM source: Ref = nat\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 60:5\<close>
type_synonym Ref = "VDMNat"
	

\<comment>\<open>VDM source: inv_Ref: (Ref +> bool)
	inv_Ref(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 60:5\<close>
definition
	inv_Ref :: "Ref \<Rightarrow> bool"
where
	"inv_Ref dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Ref` specification.\<close>
		(((inv_VDMNat dummy0)))"
 

	
\<comment>\<open>VDM source: Name = seq1 of (char)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 65:5\<close>
type_synonym Name = "VDMChar VDMSeq1"
	

\<comment>\<open>VDM source: inv_Name: (Name +> bool)
	inv_Name(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 65:5\<close>
definition
	inv_Name :: "Name \<Rightarrow> bool"
where
	"inv_Name dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Name` specification.\<close>
		(((inv_VDMSeq1' (inv_VDMChar) dummy0)))"

		 

	
\<comment>\<open>VDM source: FMURef = compose FMURef of name:Name, ref:Ref end\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 70:5\<close>
record FMURef = 
	name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Name"
		 ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Ref"
	

\<comment>\<open>VDM source: inv_FMURef: (FMURef +> bool)
	inv_FMURef(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 70:5\<close>
definition
	inv_FMURef :: "FMURef \<Rightarrow> bool"
where
	"inv_FMURef dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMURef` specification.\<close>
		( (((inv_Name (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0))) \<and> 
		 ((inv_Ref (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0))) ))"

		 

	
\<comment>\<open>VDM source: ValueTypesLF = (bool | real)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 74:5\<close>
datatype ValueTypesLF = U_bool "bool" | 
		 U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_ValueTypesLF: (ValueTypesLF +> bool)
	inv_ValueTypesLF(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 74:5\<close>
definition
	inv_ValueTypesLF :: "ValueTypesLF \<Rightarrow> bool"
where
	"inv_ValueTypesLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ValueTypesLF` specification.\<close>
		(((case dummy0 of
		 ValueTypesLF.U_bool dummy0 \<Rightarrow> (inv_bool dummy0)
		  | ValueTypesLF.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>VDM source: Value = compose Value of value:ValueTypesLF, time:Time end\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 81:5\<close>
record Value = 
	value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "ValueTypesLF"
		 time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "Time"
	

\<comment>\<open>VDM source: inv_Value: (Value +> bool)
	inv_Value(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 81:5\<close>
definition
	inv_Value :: "Value \<Rightarrow> bool"
where
	"inv_Value dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Value` specification.\<close>
		( (((inv_ValueTypesLF (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0))) \<and> 
		 (inv_Time (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0)) ))"
 

	
\<comment>\<open>VDM source: Environment = map (Ref) to (Value)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 89:5\<close>
type_synonym Environment = "(Ref \<rightharpoonup> Value)"
	

\<comment>\<open>VDM source: inv_Environment: (Environment +> bool)
	inv_Environment(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 89:5\<close>
definition
	inv_Environment :: "Environment \<Rightarrow> bool"
where
	"inv_Environment dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Environment` specification.\<close>
		(((inv_Map (inv_Ref) inv_Value  dummy0)))"
 

	
\<comment>\<open>VDM source: Equation = (Environment -> Environment)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 95:5\<close>
type_synonym Equation = "Environment \<Rightarrow> Environment"
	

\<comment>\<open>VDM source: inv_Equation: (Equation +> bool)
	inv_Equation(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 95:5\<close>
definition
	inv_Equation :: "Equation \<Rightarrow> bool"
where
	"inv_Equation dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Equation` specification.\<close>
		(((inv_Lambda (inv_Environment) (inv_Environment)dummy0)))"

		 

	
\<comment>\<open>VDM source: IOLF = (<inputLF> | <outputLF>)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 97:5\<close>
datatype IOLF = U_inputLF  | 
		 U_outputLF 
	

\<comment>\<open>VDM source: inv_IOLF: (IOLF +> bool)
	inv_IOLF(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 97:5\<close>
definition
	inv_IOLF :: "IOLF \<Rightarrow> bool"
where
	"inv_IOLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_IOLF` specification.\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>VDM source: DCLF = (<continous> | <discrete>)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 98:5\<close>
datatype DCLF = U_continous  | 
		 U_discrete 
	

\<comment>\<open>VDM source: inv_DCLF: (DCLF +> bool)
	inv_DCLF(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 98:5\<close>
definition
	inv_DCLF :: "DCLF \<Rightarrow> bool"
where
	"inv_DCLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_DCLF` specification.\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>VDM source: ContractLF = (<delayed> | <none> | <reactive>)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 99:5\<close>
datatype ContractLF = U_delayed  | 
		 U_none  | 
		 U_reactive 
	

\<comment>\<open>VDM source: inv_ContractLF: (ContractLF +> bool)
	inv_ContractLF(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 99:5\<close>
definition
	inv_ContractLF :: "ContractLF \<Rightarrow> bool"
where
	"inv_ContractLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ContractLF` specification.\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>VDM source: Variable = compose Variable of ref:Ref, time:Time, causality:IOLF, type:DCLF, clocks:set of (Ref), dependsOn:set of (Ref), contract:ContractLF end
	inv var == (((((var.causality) = <outputLF>) => ((var.contract) = <none>)) and ((var.causality) = <inputLF>)) => ((var.dependsOn) = {}))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 104:5\<close>
record Variable = 
	ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref"
		 time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Time"
		 causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "IOLF"
		 type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "DCLF"
		 clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref VDMSet"
		 dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref VDMSet"
		 contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "ContractLF"
	

\<comment>\<open>VDM source: inv_Variable: (Variable +> bool)
	inv_Variable(var) ==
(((((var.causality) = <outputLF>) => ((var.contract) = <none>)) and ((var.causality) = <inputLF>)) => ((var.dependsOn) = {}))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 113:9\<close>
definition
	inv_Variable :: "Variable \<Rightarrow> bool"
where
	"inv_Variable var \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Variable` specification.\<close>
		( (((inv_Ref (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 (inv_Time (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var)) \<and> 
		 ((inv_IOLF (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_DCLF (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_ContractLF (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Variable.\<close>
		(((((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) = IOLF.U_outputLF ) \<longrightarrow> ((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) = ContractLF.U_none )) \<and> ((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) = IOLF.U_inputLF )) \<longrightarrow> ((dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) = {}))"
 

	
\<comment>\<open>VDM source: Clock = compose Clock of ref:Ref, type:IOLF, interval:Interval, timeToTick:Time, dependsOn:set of (Ref), equations:set of (Ref) end
	inv clock == ((((clock.type) = <outputLF>) => ((clock.interval) = <triggered>)) and (((clock.type) = <inputLF>) => ((clock.dependsOn) = {})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 121:5\<close>
record Clock = 
	ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref"
		 type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "IOLF"
		 interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Interval"
		 timeToTick\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Time"
		 dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref VDMSet"
		 equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref VDMSet"
	

\<comment>\<open>VDM source: inv_Clock: (Clock +> bool)
	inv_Clock(clock) ==
((((clock.type) = <outputLF>) => ((clock.interval) = <triggered>)) and (((clock.type) = <inputLF>) => ((clock.dependsOn) = {})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 128:9\<close>
definition
	inv_Clock :: "Clock \<Rightarrow> bool"
where
	"inv_Clock clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Clock` specification.\<close>
		( (((inv_Ref (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_IOLF (type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_Interval (interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 (inv_Time (timeToTick\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock)) \<and> 
		 ((inv_VDMSet' (inv_Ref) (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Clock.\<close>
		((((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = IOLF.U_outputLF ) \<longrightarrow> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = Interval.U_triggered )) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = IOLF.U_inputLF ) \<longrightarrow> ((dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = {})))"

		

	
\<comment>\<open>VDM source: FMUModeLF = (<DONE> | <EVENT> | <INIT> | <STEP>)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 132:5\<close>
datatype FMUModeLF = U_DONE  | 
		 U_EVENT  | 
		 U_INIT  | 
		 U_STEP 
	

\<comment>\<open>VDM source: inv_FMUModeLF: (FMUModeLF +> bool)
	inv_FMUModeLF(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 132:5\<close>
definition
	inv_FMUModeLF :: "FMUModeLF \<Rightarrow> bool"
where
	"inv_FMUModeLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMUModeLF` specification.\<close>
		((((inv_True dummy0))))"

		 

	
\<comment>\<open>VDM source: FMU = compose FMU of name:Name, clocks:set of (Clock), inputs:set of (Variable), outputs:set of (Variable), mode:FMUModeLF, time:Time, maxStep:real, env:Environment, activeClocks:set of (Ref), activeEquations:set of (Equation) end
	inv fmu == let vars:set of (Variable) = ((fmu.inputs) union (fmu.outputs)) in let crefs:set of (Ref) = {(c.ref) | c in set (fmu.clocks)}, vrefs:set of (Ref) = {(v.ref) | v in set vars}, refs:set of (Ref) = (crefs union vrefs) in (((fmu.maxStep) >= 0.0) and (((card refs) = ((card (fmu.clocks)) + (card vars))) and (((dom (fmu.env)) subset refs) and (((fmu.activeClocks) subset crefs) and ((((fmu.mode) <> <EVENT>) => ((fmu.activeClocks) = {})) and ((((fmu.mode) <> <EVENT>) => ((fmu.activeEquations) = {})) and (forall var in set vars & ((var.clocks) subset crefs))))))))\<close>
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
	

\<comment>\<open>VDM source: inv_FMU: (FMU +> bool)
	inv_FMU(fmu) ==
let vars:set of (Variable) = ((fmu.inputs) union (fmu.outputs)) in let crefs:set of (Ref) = {(c.ref) | c in set (fmu.clocks)}, vrefs:set of (Ref) = {(v.ref) | v in set vars}, refs:set of (Ref) = (crefs union vrefs) in (((fmu.maxStep) >= 0.0) and (((card refs) = ((card (fmu.clocks)) + (card vars))) and (((dom (fmu.env)) subset refs) and (((fmu.activeClocks) subset crefs) and ((((fmu.mode) <> <EVENT>) => ((fmu.activeClocks) = {})) and ((((fmu.mode) <> <EVENT>) => ((fmu.activeEquations) = {})) and (forall var in set vars & ((var.clocks) subset crefs))))))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 151:9\<close>
definition
	inv_FMU :: "FMU \<Rightarrow> bool"
where
	"inv_FMU fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_FMU` specification.\<close>
		( (((inv_Name (name\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_FMUModeLF (mode\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 (inv_Time (time\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' (inv_Equation) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) ))  \<and> 
		\<comment>\<open>User defined body of inv_FMU.\<close>
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
			(((maxStep\<^sub>F\<^sub>M\<^sub>U (fmu)) \<ge> (0.0)) \<and> (((vdm_card refs) = ((vdm_card (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))) + (vdm_card vars))) \<and> (((dom (env\<^sub>F\<^sub>M\<^sub>U (fmu))) \<subseteq> refs) \<and> (((activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu)) \<subseteq> crefs) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) \<noteq> FMUModeLF.U_EVENT ) \<longrightarrow> ((activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu)) = {})) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) \<noteq> FMUModeLF.U_EVENT ) \<longrightarrow> ((activeEquations\<^sub>F\<^sub>M\<^sub>U (fmu)) = {})) \<and> (\<forall> var \<in> vars  . ((clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (var)) \<subseteq> crefs))))))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"
 

	
\<comment>\<open>VDM source: Action = compose Action of actionType:ActionType, fmu:FMU, port:Ref end\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 180:5\<close>
record Action = 
	actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "ActionType"
		 fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "FMU"
		 port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "Ref"
	

\<comment>\<open>VDM source: inv_Action: (Action +> bool)
	inv_Action(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 180:5\<close>
definition
	inv_Action :: "Action \<Rightarrow> bool"
where
	"inv_Action dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Action` specification.\<close>
		( (((inv_ActionType (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))) \<and> 
		 (inv_FMU (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0)) \<and> 
		 ((inv_Ref (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))) ))"
 

	
\<comment>\<open>VDM source: derefInput: (FMU * Ref -> Variable)
	derefInput(fmu, ref) ==
(iota c in set (fmu.inputs) & ((c.ref) = ref))
	pre (exists [c in set (fmu.inputs)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 193:5\<close>

\<comment>\<open>VDM source: pre_derefInput: (FMU * Ref +> bool)
	pre_derefInput(fmu, ref) ==
(exists [c in set (fmu.inputs)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 196:9\<close>
definition
	pre_derefInput :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_derefInput fmu  ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_derefInput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_derefInput.\<close>
		(\<exists> c \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (c)) = ref))"


\<comment>\<open>VDM source: post_derefInput: (FMU * Ref * Variable +> bool)
	post_derefInput(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 193:5\<close>
definition
	post_derefInput :: "FMU\<Rightarrow> Ref\<Rightarrow> Variable \<Rightarrow> bool"
where
	"post_derefInput fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_derefInput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Variable RESULT)"

definition
	derefInput :: "FMU\<Rightarrow> Ref \<Rightarrow> Variable"
where
	"derefInput fmu  ref \<equiv> 
	\<comment>\<open>User defined body of derefInput.\<close>
	(THE c. (((c \<in>(inputs\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (c)) = ref)))"

	
\<comment>\<open>VDM source: derefOutput: (FMU * Ref -> Variable)
	derefOutput(fmu, ref) ==
(iota c in set (fmu.outputs) & ((c.ref) = ref))
	pre (exists [c in set (fmu.outputs)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 202:5\<close>

\<comment>\<open>VDM source: pre_derefOutput: (FMU * Ref +> bool)
	pre_derefOutput(fmu, ref) ==
(exists [c in set (fmu.outputs)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 205:9\<close>
definition
	pre_derefOutput :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_derefOutput fmu  ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_derefOutput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_derefOutput.\<close>
		(\<exists> c \<in> (outputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (c)) = ref))"


\<comment>\<open>VDM source: post_derefOutput: (FMU * Ref * Variable +> bool)
	post_derefOutput(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 202:5\<close>
definition
	post_derefOutput :: "FMU\<Rightarrow> Ref\<Rightarrow> Variable \<Rightarrow> bool"
where
	"post_derefOutput fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_derefOutput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Variable RESULT)"

definition
	derefOutput :: "FMU\<Rightarrow> Ref \<Rightarrow> Variable"
where
	"derefOutput fmu  ref \<equiv> 
	\<comment>\<open>User defined body of derefOutput.\<close>
	(THE c. (((c \<in>(outputs\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (c)) = ref)))"

	
\<comment>\<open>VDM source: Machine = compose Machine of fmus:map (Name) to (FMU), connections:map (FMURef) to (FMURef), clockConnections:map (FMURef) to (FMURef) end
	inv m == ((forall srcRef in set (dom (m.connections)) & (((srcRef.name) in set (dom (m.fmus))) and let srcFMU:FMU = (m.fmus)((srcRef.name)), trgRef:FMURef = (m.connections)(srcRef) in ((exists [v in set (srcFMU.outputs)] & ((srcRef.ref) = (v.ref))) and (((trgRef.name) in set (dom (m.fmus))) and let trgFMU:FMU = (m.fmus)((trgRef.name)) in ((exists [v in set (trgFMU.inputs)] & ((trgRef.ref) = (v.ref))) and let outputLF:Variable = derefOutput(srcFMU, (srcRef.ref)), inputLF:Variable = derefInput(trgFMU, (trgRef.ref)) in ((outputLF.type) = (inputLF.type))))))) and ((forall fmuref in set (dom (m.clockConnections)) & (((fmuref.name) in set (dom (m.fmus))) and let fmu:FMU = (m.fmus)((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and ((v.type) = <outputLF>))))) and ((forall fmuref in set (rng (m.clockConnections)) & (((fmuref.name) in set (dom (m.fmus))) and let fmu:FMU = (m.fmus)((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and ((v.type) = <inputLF>))))) and ((((dom (m.clockConnections)) inter (dom (m.connections))) = {}) and (((rng (m.clockConnections)) inter (rng (m.connections))) = {})))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 212:5\<close>
record Machine = 
	fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(Name \<rightharpoonup> FMU)"
		 connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(FMURef \<rightharpoonup> FMURef)"
		 clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(FMURef \<rightharpoonup> FMURef)"
	

\<comment>\<open>VDM source: inv_Machine: (Machine +> bool)
	inv_Machine(m) ==
((forall srcRef in set (dom (m.connections)) & (((srcRef.name) in set (dom (m.fmus))) and let srcFMU:FMU = (m.fmus)((srcRef.name)), trgRef:FMURef = (m.connections)(srcRef) in ((exists [v in set (srcFMU.outputs)] & ((srcRef.ref) = (v.ref))) and (((trgRef.name) in set (dom (m.fmus))) and let trgFMU:FMU = (m.fmus)((trgRef.name)) in ((exists [v in set (trgFMU.inputs)] & ((trgRef.ref) = (v.ref))) and let outputLF:Variable = derefOutput(srcFMU, (srcRef.ref)), inputLF:Variable = derefInput(trgFMU, (trgRef.ref)) in ((outputLF.type) = (inputLF.type))))))) and ((forall fmuref in set (dom (m.clockConnections)) & (((fmuref.name) in set (dom (m.fmus))) and let fmu:FMU = (m.fmus)((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and ((v.type) = <outputLF>))))) and ((forall fmuref in set (rng (m.clockConnections)) & (((fmuref.name) in set (dom (m.fmus))) and let fmu:FMU = (m.fmus)((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and ((v.type) = <inputLF>))))) and ((((dom (m.clockConnections)) inter (dom (m.connections))) = {}) and (((rng (m.clockConnections)) inter (rng (m.connections))) = {})))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 216:9\<close>
definition
	inv_Machine :: "Machine \<Rightarrow> bool"
where
	"inv_Machine m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Machine` specification.\<close>
		( (((inv_Map (inv_Name) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Machine.\<close>
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
			(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref)) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v))) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = IOLF.U_outputLF )))
		 else
			undefined
		)
		))) \<and> ((\<forall> fmuref \<in> (rng (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref)) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) \<and> (
		let 
(fmu::FMU) = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref))))
		in
			(if (inv_FMU fmu) then
			(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (fmuref)) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v))) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = IOLF.U_inputLF )))
		 else
			undefined
		)
		))) \<and> ((((dom (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m))) \<inter> (dom (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) = {}) \<and> (((rng (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m))) \<inter> (rng (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (m)))) = {})))))"
 

	
\<comment>\<open>VDM source: createFMURefs: (FMU * set of (Ref) * set of (FMURef) -> set of (FMURef))
	createFMURefs(fmu, clocks, res) ==
(if (clocks = {})
then res
else let clock in set clocks in createFMURefs(fmu, (clocks \ {clock}), (res union {mk_FMURef((fmu.name), clock)})))
	measure (card clocks)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 255:5\<close>

\<comment>\<open>VDM source: pre_createFMURefs: (FMU * set of (Ref) * set of (FMURef) +> bool)
	pre_createFMURefs(fmu, clocks, res) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 255:5\<close>
definition
	pre_createFMURefs :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"pre_createFMURefs fmu  clocks  res \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_createFMURefs` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_VDMSet' inv_FMURef  res))"


\<comment>\<open>VDM source: post_createFMURefs: (FMU * set of (Ref) * set of (FMURef) * set of (FMURef) +> bool)
	post_createFMURefs(fmu, clocks, res, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 255:5\<close>
definition
	post_createFMURefs :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> FMURef VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"post_createFMURefs fmu  clocks  res  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_createFMURefs` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_VDMSet' inv_FMURef  res)  \<and>  (inv_VDMSet' inv_FMURef  RESULT))"

definition
	createFMURefs :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> FMURef VDMSet"
where
	"createFMURefs fmu  clocks  res \<equiv> 
	\<comment>\<open>User defined body of createFMURefs.\<close>
	(
		if ((clocks = {})) then
		(res)
		else
		((
		SOME (dummy0::FMURef VDMSet) .(dummy0 \<in> { (createFMURefs fmu  (clocks - {clock})  (res \<union> {\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>})) | clock .  ((clock \<in>clocks))  }))))"

	
\<comment>\<open>VDM source: Importer = compose Importer of scenario:Machine, schedule:map (FMURef) to (real), activeClocks:set of (FMURef), readyClocks:set of (FMURef), inactiveClocks:set of (FMURef), fmusWithEvent:set of (Name), relevantOutputClocks:set of (FMURef), relevantInputClocks:set of (FMURef), activeEquations:set of (FMURef), calculatedEquations:set of (FMURef), readyEquations:set of (FMURef), time:Time, endtime:Time, stepSize:real, valueMap:map (FMURef) to (Value) end
	inv imp == let fmus:map (Name) to (FMU) = ((imp.scenario).fmus) in let inputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <inputLF>)}, {}) | fmu in set (rng fmus)}) in let outputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <outputLF>)}, {}) | fmu in set (rng fmus)}) in let clocks:set of (FMURef) = (inputclocks union outputclocks) in ((((imp.activeClocks) union (imp.inactiveClocks)) = clocks) and ((((imp.activeClocks) inter (imp.inactiveClocks)) = {}) and ((((imp.activeClocks) inter (imp.readyClocks)) = {}) and (((imp.activeClocks) = (dunion {createFMURefs(fmu, (fmu.activeClocks), {}) | fmu in set (rng fmus)})) and (((imp.fmusWithEvent) subset (dom fmus)) and (((imp.relevantInputClocks) subset inputclocks) and (((imp.relevantOutputClocks) subset outputclocks) and ((((imp.relevantInputClocks) inter (imp.relevantOutputClocks)) = {}) and (((dom (imp.schedule)) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & (((clock.type) = <inputLF>) and ((clock.interval) <> <triggered>))}, {}) | fmu in set (rng fmus)})) and (((imp.endtime) >= (imp.time)) and ((((imp.activeEquations) inter (imp.readyEquations)) = {}) and (((imp.readyEquations) inter (imp.calculatedEquations)) = {}))))))))))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 268:5\<close>
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

\<comment>\<open>VDM source: inv_Importer: (Importer +> bool)
	inv_Importer(imp) ==
let fmus:map (Name) to (FMU) = ((imp.scenario).fmus) in let inputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <inputLF>)}, {}) | fmu in set (rng fmus)}) in let outputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <outputLF>)}, {}) | fmu in set (rng fmus)}) in let clocks:set of (FMURef) = (inputclocks union outputclocks) in ((((imp.activeClocks) union (imp.inactiveClocks)) = clocks) and ((((imp.activeClocks) inter (imp.inactiveClocks)) = {}) and ((((imp.activeClocks) inter (imp.readyClocks)) = {}) and (((imp.activeClocks) = (dunion {createFMURefs(fmu, (fmu.activeClocks), {}) | fmu in set (rng fmus)})) and (((imp.fmusWithEvent) subset (dom fmus)) and (((imp.relevantInputClocks) subset inputclocks) and (((imp.relevantOutputClocks) subset outputclocks) and ((((imp.relevantInputClocks) inter (imp.relevantOutputClocks)) = {}) and (((dom (imp.schedule)) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & (((clock.type) = <inputLF>) and ((clock.interval) <> <triggered>))}, {}) | fmu in set (rng fmus)})) and (((imp.endtime) >= (imp.time)) and ((((imp.activeEquations) inter (imp.readyEquations)) = {}) and (((imp.readyEquations) inter (imp.calculatedEquations)) = {}))))))))))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 284:9\<close>
definition
	inv_Importer :: "Importer \<Rightarrow> bool"
where
	"inv_Importer imp \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Importer` specification.\<close>
		( ((inv_Machine (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) \<and> 
		 ((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' (inv_Name) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 (inv_Time (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) \<and> 
		 (inv_Time (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) \<and> 
		 ((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Importer.\<close>
		(
		let 
(fmus::(Name \<rightharpoonup> FMU)) = (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))))
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  fmus)) then
			(
		let 
(inputclocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu  { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = IOLF.U_inputLF ) }  {}) | fmu .  ((fmu \<in>(rng fmus)))  })
		in
			(if ((inv_VDMSet' inv_FMURef  inputclocks)) then
			(
		let 
(outputclocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu  { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = IOLF.U_outputLF ) }  {}) | fmu .  ((fmu \<in>(rng fmus)))  })
		in
			(if ((inv_VDMSet' inv_FMURef  outputclocks)) then
			(
		let 
(clocks::FMURef VDMSet) = (inputclocks \<union> outputclocks)
		in
			(if ((inv_VDMSet' inv_FMURef  clocks)) then
			((((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<union> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = clocks) \<and> ((((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}) \<and> ((((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}) \<and> (((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) = (\<Union> { (createFMURefs fmu  (activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu))  {}) | fmu .  ((fmu \<in>(rng fmus)))  })) \<and> (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<subseteq> (dom fmus)) \<and> (((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<subseteq> inputclocks) \<and> (((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<subseteq> outputclocks) \<and> ((((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}) \<and> (((dom (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = (\<Union> { (createFMURefs fmu  { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = IOLF.U_inputLF ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) \<noteq> Interval.U_triggered )) }  {}) | fmu .  ((fmu \<in>(rng fmus)))  })) \<and> ( ((((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}) \<and> (((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<inter> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) = {}))))))))))))
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
 (*((endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp)) \<ge> (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (imp))) \<and>*)

	
\<comment>\<open>VDM source: preSet: (FMU * Ref -> bool)
	preSet(fmu, inputLF) ==
(exists [v in set (fmu.inputs)] & (((v.ref) = inputLF) and (((v.causality) = <inputLF>) and ((fmu.mode) <> <DONE>))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 309:5\<close>

\<comment>\<open>VDM source: pre_preSet: (FMU * Ref +> bool)
	pre_preSet(fmu, inputLF) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 309:5\<close>
definition
	pre_preSet :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preSet fmu  inputLF \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref inputLF))"


\<comment>\<open>VDM source: post_preSet: (FMU * Ref * bool +> bool)
	post_preSet(fmu, inputLF, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 309:5\<close>
definition
	post_preSet :: "FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preSet fmu  inputLF  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preSet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref inputLF)  \<and>  (inv_bool RESULT))"

definition
	preSet :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"preSet fmu  inputLF \<equiv> 
	\<comment>\<open>User defined body of preSet.\<close>
	(\<exists> v \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = inputLF) \<and> (((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = IOLF.U_inputLF ) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) \<noteq> FMUModeLF.U_DONE ))))"

	
\<comment>\<open>VDM source: preGet: (FMU * Ref -> bool)
	preGet(fmu, ref) ==
let outputLF:Variable = derefOutput(fmu, ref) in (exists [v in set (fmu.outputs)] & (((v.ref) = ref) and (((v.causality) = <outputLF>) and (((fmu.mode) <> <DONE>) and feedthroughSatisfied(fmu, outputLF)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 318:5\<close>

\<comment>\<open>VDM source: pre_preGet: (FMU * Ref +> bool)
	pre_preGet(fmu, ref) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 318:5\<close>
definition
	pre_preGet :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGet fmu  ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))"


\<comment>\<open>VDM source: post_preGet: (FMU * Ref * bool +> bool)
	post_preGet(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 318:5\<close>
definition
	post_preGet :: "FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preGet fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preGet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  (inv_bool RESULT))"

definition
	preGet :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"preGet fmu  ref \<equiv> 
	\<comment>\<open>User defined body of preGet.\<close>
	(
		let 
(outputLF::Variable) = (derefOutput fmu  ref)
		in
			(if (inv_Variable outputLF) then
			(\<exists> v \<in> (outputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = ref) \<and> (((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = IOLF.U_outputLF ) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) \<noteq> FMUModeLF.U_DONE ) \<and> (feedthroughSatisfied fmu  outputLF)))))
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: preStepT: (FMU * real -> bool)
	preStepT(fmu, stepSize) ==
(forall i in set (fmu.inputs) & ((((i.contract) = <reactive>) => ((((fmu.env)((i.ref)).time).r) = (((fmu.time).r) + stepSize))) and ((((i.contract) = <delayed>) => (((fmu.env)((i.ref)).time) = (fmu.time))) and ((stepSize >= 0.0) and ((fmu.mode) = <STEP>)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 326:5\<close>

\<comment>\<open>VDM source: pre_preStepT: (FMU * real +> bool)
	pre_preStepT(fmu, stepSize) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 326:5\<close>
definition
	pre_preStepT :: "FMU\<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"pre_preStepT fmu  stepSize \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal stepSize))"


\<comment>\<open>VDM source: post_preStepT: (FMU * real * bool +> bool)
	post_preStepT(fmu, stepSize, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 326:5\<close>
definition
	post_preStepT :: "FMU\<Rightarrow> VDMReal\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preStepT fmu  stepSize  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal stepSize)  \<and>  (inv_bool RESULT))"

definition
	preStepT :: "FMU\<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"preStepT fmu  stepSize \<equiv> 
	\<comment>\<open>User defined body of preStepT.\<close>
	(\<forall> i \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = ContractLF.U_reactive ) \<longrightarrow> ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (((env\<^sub>F\<^sub>M\<^sub>U (fmu)) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i))))))) = ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>F\<^sub>M\<^sub>U (fmu)))) + stepSize))) \<and> ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = ContractLF.U_delayed ) \<longrightarrow> ((time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (((env\<^sub>F\<^sub>M\<^sub>U (fmu)) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i))))) = (time\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> ((stepSize \<ge> (0.0)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_STEP )))))"

	
\<comment>\<open>VDM source: preStepE: (FMU -> bool)
	preStepE(fmu) ==
((fmu.mode) = <EVENT>)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 333:5\<close>

\<comment>\<open>VDM source: pre_preStepE: (FMU +> bool)
	pre_preStepE(fmu) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 333:5\<close>
definition
	pre_preStepE :: "FMU \<Rightarrow> bool"
where
	"pre_preStepE fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preStepE` specification.\<close>
		(inv_FMU fmu)"


\<comment>\<open>VDM source: post_preStepE: (FMU * bool +> bool)
	post_preStepE(fmu, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 333:5\<close>
definition
	post_preStepE :: "FMU\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preStepE fmu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preStepE` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_bool RESULT))"

definition
	preStepE :: "FMU \<Rightarrow> bool"
where
	"preStepE fmu \<equiv> 
	\<comment>\<open>User defined body of preStepE.\<close>
	((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_EVENT )"

	
\<comment>\<open>VDM source: preSetC: (FMU * Ref * bool -> bool)
	preSetC(fmu, clock, val) ==
(exists [v in set (fmu.clocks)] & ((((v.ref) = clock) and (((v.type) = <inputLF>) and val)) <=> (not (clock in set (fmu.activeClocks)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 337:5\<close>

\<comment>\<open>VDM source: pre_preSetC: (FMU * Ref * bool +> bool)
	pre_preSetC(fmu, clock, val) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 337:5\<close>
definition
	pre_preSetC :: "FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_preSetC fmu  clock  val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val))"


\<comment>\<open>VDM source: post_preSetC: (FMU * Ref * bool * bool +> bool)
	post_preSetC(fmu, clock, val, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 337:5\<close>
definition
	post_preSetC :: "FMU\<Rightarrow> Ref\<Rightarrow> bool\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preSetC fmu  clock  val  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preSetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val)  \<and>  (inv_bool RESULT))"

definition
	preSetC :: "FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"preSetC fmu  clock  val \<equiv> 
	\<comment>\<open>User defined body of preSetC.\<close>
	(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = clock) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = IOLF.U_inputLF ) \<and> val)) \<longleftrightarrow> (\<not> (clock \<in> (activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu))))))"

	
\<comment>\<open>VDM source: preGetC: (FMU * Ref -> bool)
	preGetC(fmu, clock) ==
(exists [v in set (fmu.clocks)] & (((v.ref) = clock) and (((v.type) = <outputLF>) and ((fmu.mode) = <EVENT>))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 342:5\<close>

\<comment>\<open>VDM source: pre_preGetC: (FMU * Ref +> bool)
	pre_preGetC(fmu, clock) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 342:5\<close>
definition
	pre_preGetC :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGetC fmu  clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock))"


\<comment>\<open>VDM source: post_preGetC: (FMU * Ref * bool +> bool)
	post_preGetC(fmu, clock, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 342:5\<close>
definition
	post_preGetC :: "FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preGetC fmu  clock  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preGetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool RESULT))"

definition
	preGetC :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"preGetC fmu  clock \<equiv> 
	\<comment>\<open>User defined body of preGetC.\<close>
	(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = clock) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = IOLF.U_outputLF ) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_EVENT ))))"

	
\<comment>\<open>VDM source: set_m: (FMU * Ref * Value +> FMU)
	set_m(fmu, ref, val) ==
mu(fmu, env |-> ((fmu.env) ++ {ref |-> val}))
	pre preSet(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 352:5\<close>

\<comment>\<open>VDM source: pre_set_m: (FMU * Ref * Value +> bool)
	pre_set_m(fmu, ref, val) ==
preSet(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 356:9\<close>
definition
	pre_set_m :: "FMU\<Rightarrow> Ref\<Rightarrow> Value \<Rightarrow> bool"
where
	"pre_set_m fmu  ref  val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_set_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Value val)  \<and> 
		\<comment>\<open>User defined body of pre_set_m.\<close>
		(preSet fmu  ref)"


\<comment>\<open>VDM source: post_set_m: (FMU * Ref * Value * FMU +> bool)
	post_set_m(fmu, ref, val, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 352:5\<close>
definition
	post_set_m :: "FMU\<Rightarrow> Ref\<Rightarrow> Value\<Rightarrow> FMU \<Rightarrow> bool"
where
	"post_set_m fmu  ref  val  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_set_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Value val  \<and>  inv_FMU RESULT)"

definition
	set_m :: "FMU\<Rightarrow> Ref\<Rightarrow> Value \<Rightarrow> FMU"
where
	"set_m fmu  ref  val \<equiv> 
	\<comment>\<open>User defined body of set_m.\<close>
	(fmu)\<lparr>env\<^sub>F\<^sub>M\<^sub>U := ((env\<^sub>F\<^sub>M\<^sub>U (fmu)) \<dagger> [ref\<mapsto>val])\<rparr>"

	
\<comment>\<open>VDM source: get_m: (FMU * Ref +> (FMU * Value))
	get_m(fmu, ref) ==
mk_(fmu, (fmu.env)(ref))
	pre preGet(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 358:5\<close>

\<comment>\<open>VDM source: pre_get_m: (FMU * Ref +> bool)
	pre_get_m(fmu, ref) ==
preGet(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 362:9\<close>
definition
	pre_get_m :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_get_m fmu  ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_get_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_get_m.\<close>
		(preGet fmu  ref)"


\<comment>\<open>VDM source: post_get_m: (FMU * Ref * (FMU * Value) +> bool)
	post_get_m(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 358:5\<close>
definition
	post_get_m :: "FMU\<Rightarrow> Ref\<Rightarrow> (FMU\<times> Value) \<Rightarrow> bool"
where
	"post_get_m fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_get_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 inv_Value (snd RESULT)
		))"

definition
	get_m :: "FMU\<Rightarrow> Ref \<Rightarrow> (FMU\<times> Value)"
where
	"get_m fmu  ref \<equiv> 
	\<comment>\<open>User defined body of get_m.\<close>
	(fmu, ((env\<^sub>F\<^sub>M\<^sub>U (fmu)) ref))"

	
\<comment>\<open>VDM source: set_cm: (FMU * Ref * bool +> FMU)
	set_cm(fmu, ref, val) ==
mu(fmu, env |-> ((fmu.env) ++ {ref |-> mk_Value(val, (fmu.time))}), activeClocks |-> (if val
then ((fmu.activeClocks) union {ref})
else ((fmu.activeClocks) \ {ref})))
	pre preSetC(fmu, ref, val)
	post (val <=> (ref in set (fmu.activeClocks)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 364:5\<close>

\<comment>\<open>VDM source: pre_set_cm: (FMU * Ref * bool +> bool)
	pre_set_cm(fmu, ref, val) ==
preSetC(fmu, ref, val)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 369:9\<close>
definition
	pre_set_cm :: "FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_set_cm fmu  ref  val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_set_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  (inv_bool val))  \<and> 
		\<comment>\<open>User defined body of pre_set_cm.\<close>
		(preSetC fmu  ref  val)"


\<comment>\<open>VDM source: post_set_cm: (FMU * Ref * bool * FMU +> bool)
	post_set_cm(fmu, ref, val, RESULT) ==
(val <=> (ref in set (fmu.activeClocks)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 370:14\<close>
definition
	post_set_cm :: "FMU\<Rightarrow> Ref\<Rightarrow> bool\<Rightarrow> FMU \<Rightarrow> bool"
where
	"post_set_cm fmu  ref  val  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_set_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  (inv_bool val)  \<and>  inv_FMU RESULT)  \<and> 
		\<comment>\<open>User defined body of post_set_cm.\<close>
		(val \<longleftrightarrow> (ref \<in> (activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu))))"

definition
	set_cm :: "FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> FMU"
where
	"set_cm fmu  ref  val \<equiv> 
	\<comment>\<open>User defined body of set_cm.\<close>
	(fmu)\<lparr>env\<^sub>F\<^sub>M\<^sub>U := ((env\<^sub>F\<^sub>M\<^sub>U (fmu)) \<dagger> [ref\<mapsto>\<lparr>value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = val, time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = (time\<^sub>F\<^sub>M\<^sub>U (fmu))\<rparr>]), activeClocks\<^sub>F\<^sub>M\<^sub>U := (
		if (val) then
		(((activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu)) \<union> {ref}))
		else
		(((activeClocks\<^sub>F\<^sub>M\<^sub>U (fmu)) - {ref})))\<rparr>"

	
\<comment>\<open>VDM source: get_cm: (FMU * Ref +> (FMU * Value))
	get_cm(fmu, ref) ==
mk_(fmu, (fmu.env)(ref))
	pre preGetC(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 372:5\<close>

\<comment>\<open>VDM source: pre_get_cm: (FMU * Ref +> bool)
	pre_get_cm(fmu, ref) ==
preGetC(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 375:9\<close>
definition
	pre_get_cm :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_get_cm fmu  ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_get_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_get_cm.\<close>
		(preGetC fmu  ref)"


\<comment>\<open>VDM source: post_get_cm: (FMU * Ref * (FMU * Value) +> bool)
	post_get_cm(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 372:5\<close>
definition
	post_get_cm :: "FMU\<Rightarrow> Ref\<Rightarrow> (FMU\<times> Value) \<Rightarrow> bool"
where
	"post_get_cm fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_get_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 inv_Value (snd RESULT)
		))"

definition
	get_cm :: "FMU\<Rightarrow> Ref \<Rightarrow> (FMU\<times> Value)"
where
	"get_cm fmu  ref \<equiv> 
	\<comment>\<open>User defined body of get_cm.\<close>
	(fmu, ((env\<^sub>F\<^sub>M\<^sub>U (fmu)) ref))"

	
\<comment>\<open>VDM source: step_tm: (FMU * real +> (FMU * real * bool))
	step_tm(fmu, step) ==
(if (step >= (fmu.maxStep))
then mk_(fmu, (fmu.maxStep), true)
else mk_(fmu, step, false))
	pre preStepT(fmu, step)
	post (((RESULT.#2) <= step) and ((RESULT.#2) <= (fmu.maxStep)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 377:5\<close>

\<comment>\<open>VDM source: pre_step_tm: (FMU * real +> bool)
	pre_step_tm(fmu, step) ==
preStepT(fmu, step)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 381:9\<close>
definition
	pre_step_tm :: "FMU\<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"pre_step_tm fmu  step \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_step_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal step))  \<and> 
		\<comment>\<open>User defined body of pre_step_tm.\<close>
		(preStepT fmu  step)"


\<comment>\<open>VDM source: post_step_tm: (FMU * real * (FMU * real * bool) +> bool)
	post_step_tm(fmu, step, RESULT) ==
(((RESULT.#2) <= step) and ((RESULT.#2) <= (fmu.maxStep)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 383:9\<close>
definition
	post_step_tm :: "FMU\<Rightarrow> VDMReal\<Rightarrow> (FMU\<times> VDMReal\<times> bool) \<Rightarrow> bool"
where
	"post_step_tm fmu  step  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_step_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal step)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 (inv_VDMReal (fst (snd RESULT)))\<and>
		 (inv_bool (snd (snd RESULT)))
		))  \<and> 
		\<comment>\<open>User defined body of post_step_tm.\<close>
		(((fst (snd (RESULT))) \<le> step) \<and> ((fst (snd (RESULT))) \<le> (maxStep\<^sub>F\<^sub>M\<^sub>U (fmu))))"

definition
	step_tm :: "FMU\<Rightarrow> VDMReal \<Rightarrow> (FMU\<times> VDMReal\<times> bool)"
where
	"step_tm fmu  step \<equiv> 
	\<comment>\<open>User defined body of step_tm.\<close>
	(
		if ((step \<ge> (maxStep\<^sub>F\<^sub>M\<^sub>U (fmu)))) then
		((fmu, (maxStep\<^sub>F\<^sub>M\<^sub>U (fmu)), (True::\<bool>)))
		else
		((fmu, step, (False::\<bool>))))"

	
\<comment>\<open>VDM source: step_e: (FMU +> (FMU * bool))
	step_e(fmu) ==
not yet specified
	pre preStepE(fmu)
	post ((((RESULT.#1).mode) = <EVENT>) and (((((RESULT.#1).time).i) = (((fmu.time).i) + 1)) and (((RESULT.#1).activeClocks) = {})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 385:5\<close>

\<comment>\<open>VDM source: pre_step_e: (FMU +> bool)
	pre_step_e(fmu) ==
preStepE(fmu)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 388:9\<close>
definition
	pre_step_e :: "FMU \<Rightarrow> bool"
where
	"pre_step_e fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_step_e` specification.\<close>
		(inv_FMU fmu)  \<and> 
		\<comment>\<open>User defined body of pre_step_e.\<close>
		(preStepE fmu)"


\<comment>\<open>VDM source: post_step_e: (FMU * (FMU * bool) +> bool)
	post_step_e(fmu, RESULT) ==
((((RESULT.#1).mode) = <EVENT>) and (((((RESULT.#1).time).i) = (((fmu.time).i) + 1)) and (((RESULT.#1).activeClocks) = {})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 390:9\<close>
definition
	post_step_e :: "FMU\<Rightarrow> (FMU\<times> bool) \<Rightarrow> bool"
where
	"post_step_e fmu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_step_e` specification.\<close>
		(inv_FMU fmu  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 (inv_bool (snd RESULT))
		))  \<and> 
		\<comment>\<open>User defined body of post_step_e.\<close>
		(((mode\<^sub>F\<^sub>M\<^sub>U ((fst (RESULT)))) = FMUModeLF.U_EVENT ) \<and> (((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>F\<^sub>M\<^sub>U ((fst (RESULT)))))) = ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>F\<^sub>M\<^sub>U (fmu)))) + (1::VDMNat1))) \<and> ((activeClocks\<^sub>F\<^sub>M\<^sub>U ((fst (RESULT)))) = {})))"

definition
	step_e :: "FMU \<Rightarrow> (FMU\<times> bool)"
where
	"step_e fmu \<equiv> 
	\<comment>\<open>User defined body of step_e.\<close>
	undefined"

	
\<comment>\<open>VDM source: RealNaNLF = (<NaN> | real)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 394:5\<close>
datatype RealNaNLF = U_NaN  | 
		 U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_RealNaNLF: (RealNaNLF +> bool)
	inv_RealNaNLF(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 394:5\<close>
definition
	inv_RealNaNLF :: "RealNaNLF \<Rightarrow> bool"
where
	"inv_RealNaNLF dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_RealNaNLF` specification.\<close>
		(((case dummy0 of
		 RealNaNLF.U_NaN  \<Rightarrow> (inv_True dummy0)
		  | RealNaNLF.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 

	
\<comment>\<open>VDM source: next_tm: (FMU * Ref +> RealNaNLF)
	next_tm(fmu, ref) ==
<NaN>
	pre (exists [v in set (fmu.clocks)] & (((v.ref) = ref) and ((v.interval) in set {<tunable>, <changing>, <countdown>})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 399:5\<close>

\<comment>\<open>VDM source: pre_next_tm: (FMU * Ref +> bool)
	pre_next_tm(fmu, ref) ==
(exists [v in set (fmu.clocks)] & (((v.ref) = ref) and ((v.interval) in set {<tunable>, <changing>, <countdown>})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 404:9\<close>
definition
	pre_next_tm :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_next_tm fmu  ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_next_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_next_tm.\<close>
		(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) = ref) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (v)) \<in> {Interval.U_tunable , Interval.U_changing , Interval.U_countdown })))"


\<comment>\<open>VDM source: post_next_tm: (FMU * Ref * RealNaNLF +> bool)
	post_next_tm(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 399:5\<close>
definition
	post_next_tm :: "FMU\<Rightarrow> Ref\<Rightarrow> RealNaNLF \<Rightarrow> bool"
where
	"post_next_tm fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_next_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  (inv_RealNaNLF RESULT))"

definition
	next_tm :: "FMU\<Rightarrow> Ref \<Rightarrow> RealNaNLF"
where
	"next_tm fmu  ref \<equiv> 
	\<comment>\<open>User defined body of next_tm.\<close>
	RealNaNLF.U_NaN "

	
\<comment>\<open>VDM source: updateDiscreteState: (Importer * set of (Name) -> Importer)
	updateDiscreteState(I, fmus) ==
let M:Machine = (I.scenario) in let res:map (Name) to ((FMU * bool)) = {fmu |-> step_e((M.fmus)(fmu)) | fmu in set (dom (M.fmus)) & (fmu in set fmus)} in let fmuMap:map (Name) to (FMU) = {fmu |-> (res(fmu).#1) | fmu in set (dom res)}, eventFMUs:set of (Name) = {fmu | fmu in set (dom res) & ((res(fmu).#2) = true)} in mu(I, scenario |-> mu((I.scenario), fmus |-> fmuMap), fmusWithEvent |-> eventFMUs)
	pre ((forall m' in set (rng ((I.scenario).fmus)) & (((m'.name) in set fmus) and ((m'.mode) = <EVENT>))) and ((card {(m'.time) | m' in set (rng ((I.scenario).fmus)) & ((m'.name) in set fmus)}) = 1))
	post ((forall m' in set (rng ((I.scenario).fmus)) & (((m'.name) in set fmus) and ((m'.mode) = <EVENT>))) and ((card {(m'.time) | m' in set (rng ((I.scenario).fmus)) & ((m'.name) in set fmus)}) = 1))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 410:5\<close>

\<comment>\<open>VDM source: pre_updateDiscreteState: (Importer * set of (Name) +> bool)
	pre_updateDiscreteState(I, fmus) ==
((forall m' in set (rng ((I.scenario).fmus)) & (((m'.name) in set fmus) and ((m'.mode) = <EVENT>))) and ((card {(m'.time) | m' in set (rng ((I.scenario).fmus)) & ((m'.name) in set fmus)}) = 1))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 422:9\<close>
definition
	pre_updateDiscreteState :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> bool"
where
	"pre_updateDiscreteState I  fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_updateDiscreteState` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_updateDiscreteState.\<close>
		((\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((name\<^sub>F\<^sub>M\<^sub>U (m')) \<in> fmus) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_EVENT ))) \<and> ((vdm_card { (time\<^sub>F\<^sub>M\<^sub>U (m')) | m' .  ((m' \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))))  \<and> ((name\<^sub>F\<^sub>M\<^sub>U (m')) \<in> fmus) }) = (1::VDMNat1)))"


\<comment>\<open>VDM source: post_updateDiscreteState: (Importer * set of (Name) * Importer +> bool)
	post_updateDiscreteState(I, fmus, RESULT) ==
((forall m' in set (rng ((I.scenario).fmus)) & (((m'.name) in set fmus) and ((m'.mode) = <EVENT>))) and ((card {(m'.time) | m' in set (rng ((I.scenario).fmus)) & ((m'.name) in set fmus)}) = 1))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 424:9\<close>
definition
	post_updateDiscreteState :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_updateDiscreteState I  fmus  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_updateDiscreteState` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) fmus)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_updateDiscreteState.\<close>
		((\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((name\<^sub>F\<^sub>M\<^sub>U (m')) \<in> fmus) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_EVENT ))) \<and> ((vdm_card { (time\<^sub>F\<^sub>M\<^sub>U (m')) | m' .  ((m' \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))))  \<and> ((name\<^sub>F\<^sub>M\<^sub>U (m')) \<in> fmus) }) = (1::VDMNat1)))"

definition
	updateDiscreteState :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"updateDiscreteState I  fmus \<equiv> 
	\<comment>\<open>User defined body of updateDiscreteState.\<close>
	(
		let 
(M::Machine) = (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))
		in
			(if (inv_Machine M) then
			(
		let 
(res::(Name \<rightharpoonup> (FMU\<times> bool))) = (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ fmu .   ((fmu \<in>(dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))))  \<and> (fmu \<in> fmus) } 
		{ (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu))) | (dummy0RANGE :: (FMU\<times> bool)) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  ((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		)))  \<and> (fmu \<in> fmus) } 
		((inv_VDMSeq1' (inv_VDMChar))) 
		
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
		) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)  (dummy0RANGE :: (FMU\<times> bool)) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<and>  ((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<and> 
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )\<and>
		 (inv_bool (snd (
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))
		) then
		(
		if ((\<exists> (dummy0RANGE :: (FMU\<times> bool))  . (((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)) fmu)))) \<and> (fmu \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: Name)  (dummy0RANGE :: (FMU\<times> bool)) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<and>  ((
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<and> (inv_bool (
		if ((\<exists> fmu \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))  . ((fmu \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))) \<and> (fmu \<in> fmus)))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> fmu \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))  . ((fmu \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))) \<and> (fmu \<in> fmus)))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))
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
(fmuMap::(Name \<rightharpoonup> FMU)) = (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ fmu .   ((fmu \<in>(dom res)))  } 
		{(fst ((the(res fmu))))} 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)  (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and>  ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) ) then
		(
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((the(res fmu))))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(truecnst ));
		
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

	
\<comment>\<open>VDM source: derefClock: (FMU * Ref -> Clock)
	derefClock(fmu, ref) ==
(iota c in set (fmu.clocks) & ((c.ref) = ref))
	pre (exists [c in set (fmu.clocks)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 428:5\<close>

\<comment>\<open>VDM source: pre_derefClock: (FMU * Ref +> bool)
	pre_derefClock(fmu, ref) ==
(exists [c in set (fmu.clocks)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 431:9\<close>
definition
	pre_derefClock :: "FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_derefClock fmu  ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_derefClock` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_derefClock.\<close>
		(\<exists> c \<in> (clocks\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) = ref))"


\<comment>\<open>VDM source: post_derefClock: (FMU * Ref * Clock +> bool)
	post_derefClock(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 428:5\<close>
definition
	post_derefClock :: "FMU\<Rightarrow> Ref\<Rightarrow> Clock \<Rightarrow> bool"
where
	"post_derefClock fmu  ref  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_derefClock` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Clock RESULT)"

definition
	derefClock :: "FMU\<Rightarrow> Ref \<Rightarrow> Clock"
where
	"derefClock fmu  ref \<equiv> 
	\<comment>\<open>User defined body of derefClock.\<close>
	(THE c. (((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> ((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) = ref)))"

	
\<comment>\<open>VDM source: enterEventMode: (Importer * set of (Name) -> Importer)
	enterEventMode(I, fmus) ==
mu(I, scenario |-> mu((I.scenario), fmus |-> {name |-> mu(((I.scenario).fmus)(name), mode |-> <EVENT>) | name in set (dom ((I.scenario).fmus)) & (name in set fmus)}))
	pre (forall m' in set (rng ((I.scenario).fmus)) & ((((m'.time).i) = 0) and ((m'.mode) = <STEP>)))
	post (forall m' in set (rng ((I.scenario).fmus)) & ((((m'.time).i) = 0) and ((m'.mode) = <STEP>)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 436:5\<close>

\<comment>\<open>VDM source: pre_enterEventMode: (Importer * set of (Name) +> bool)
	pre_enterEventMode(I, fmus) ==
(forall m' in set (rng ((I.scenario).fmus)) & ((((m'.time).i) = 0) and ((m'.mode) = <STEP>)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 439:9\<close>
definition
	pre_enterEventMode :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> bool"
where
	"pre_enterEventMode I  fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_enterEventMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_enterEventMode.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>F\<^sub>M\<^sub>U (m')))) = (0::VDMNat)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_STEP )))"


\<comment>\<open>VDM source: post_enterEventMode: (Importer * set of (Name) * Importer +> bool)
	post_enterEventMode(I, fmus, RESULT) ==
(forall m' in set (rng ((I.scenario).fmus)) & ((((m'.time).i) = 0) and ((m'.mode) = <STEP>)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 440:10\<close>
definition
	post_enterEventMode :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_enterEventMode I  fmus  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_enterEventMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) fmus)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_enterEventMode.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>F\<^sub>M\<^sub>U (m')))) = (0::VDMNat)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_STEP )))"

definition
	enterEventMode :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"enterEventMode I  fmus \<equiv> 
	\<comment>\<open>User defined body of enterEventMode.\<close>
	(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ name .   ((name \<in>(dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))))  \<and> (name \<in> fmus) } 
		{ ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr> | (dummy0RANGE :: FMU) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) )))  \<and> (name \<in> fmus) } 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)  (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and>  ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) ) then
		(
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: Name)  (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and> (inv_bool (
		if ((\<exists> name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))) \<and> (name \<in> fmus)))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))) \<and> (name \<in> fmus)))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))\<rparr>\<rparr>"

	
\<comment>\<open>VDM source: enterStepMode: (Importer * set of (Name) -> Importer)
	enterStepMode(I, fmus) ==
mu(I, scenario |-> mu((I.scenario), fmus |-> {name |-> mu(((I.scenario).fmus)(name), mode |-> <EVENT>) | name in set (dom ((I.scenario).fmus)) & (name in set fmus)}))
	pre (forall m' in set (rng ((I.scenario).fmus)) & ((((m'.time).i) = 0) and ((m'.mode) in set {<INIT>, <EVENT>})))
	post (forall m' in set (rng ((I.scenario).fmus)) & ((((m'.time).i) = 0) and ((m'.mode) = <STEP>)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 445:5\<close>

\<comment>\<open>VDM source: pre_enterStepMode: (Importer * set of (Name) +> bool)
	pre_enterStepMode(I, fmus) ==
(forall m' in set (rng ((I.scenario).fmus)) & ((((m'.time).i) = 0) and ((m'.mode) in set {<INIT>, <EVENT>})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 448:9\<close>
definition
	pre_enterStepMode :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> bool"
where
	"pre_enterStepMode I  fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_enterStepMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_enterStepMode.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>F\<^sub>M\<^sub>U (m')))) = (0::VDMNat)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) \<in> {FMUModeLF.U_INIT , FMUModeLF.U_EVENT })))"


\<comment>\<open>VDM source: post_enterStepMode: (Importer * set of (Name) * Importer +> bool)
	post_enterStepMode(I, fmus, RESULT) ==
(forall m' in set (rng ((I.scenario).fmus)) & ((((m'.time).i) = 0) and ((m'.mode) = <STEP>)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 450:10\<close>
definition
	post_enterStepMode :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_enterStepMode I  fmus  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_enterStepMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) fmus)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_enterStepMode.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>F\<^sub>M\<^sub>U (m')))) = (0::VDMNat)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_STEP )))"

definition
	enterStepMode :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"enterStepMode I  fmus \<equiv> 
	\<comment>\<open>User defined body of enterStepMode.\<close>
	(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ name .   ((name \<in>(dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))))  \<and> (name \<in> fmus) } 
		{ ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr> | (dummy0RANGE :: FMU) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) )))  \<and> (name \<in> fmus) } 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)  (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and>  ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) ) then
		(
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = ((the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name)))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUModeLF.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))
	 else
		undefined
	)
	) 
		(
	\<lambda> (dummy0DOMAIN :: Name)  (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<and>  (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and> (inv_bool (
		if ((\<exists> name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))) \<and> (name \<in> fmus)))) then
		((True::\<bool>))
		else
		(undefined))) then
		(
		if ((\<exists> name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))) \<and> (name \<in> fmus)))) then
		((True::\<bool>))
		else
		(undefined))
	 else
		undefined
	)
	))\<rparr>\<rparr>"

	
\<comment>\<open>VDM source: variablesSynchronized: (Machine -> bool)
	variablesSynchronized(M) ==
(forall srcPort in set (dom (M.connections)) & let trgPort:FMURef = (M.connections)(srcPort) in (((M.fmus)((srcPort.name)).env)((srcPort.ref)) = ((M.fmus)((trgPort.name)).env)((trgPort.ref))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 454:5\<close>

\<comment>\<open>VDM source: pre_variablesSynchronized: (Machine +> bool)
	pre_variablesSynchronized(M) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 454:5\<close>
definition
	pre_variablesSynchronized :: "Machine \<Rightarrow> bool"
where
	"pre_variablesSynchronized M \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_variablesSynchronized` specification.\<close>
		(inv_Machine M)"


\<comment>\<open>VDM source: post_variablesSynchronized: (Machine * bool +> bool)
	post_variablesSynchronized(M, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 454:5\<close>
definition
	post_variablesSynchronized :: "Machine\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_variablesSynchronized M  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_variablesSynchronized` specification.\<close>
		(inv_Machine M  \<and>  (inv_bool RESULT))"

definition
	variablesSynchronized :: "Machine \<Rightarrow> bool"
where
	"variablesSynchronized M \<equiv> 
	\<comment>\<open>User defined body of variablesSynchronized.\<close>
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

	
\<comment>\<open>VDM source: activateClocks: (Importer * set of (FMURef) -> Importer)
	activateClocks(I, clocks) ==
(if (clocks = {})
then I
else let clock in set clocks in let I1:Importer = setClock(I, ((I.scenario).fmus)((clock.name)), (clock.ref), true) in activateClocks(I1, (clocks \ {clock})))
	pre (clocks subset ((I.readyClocks) inter (I.relevantInputClocks)))
	measure (card clocks)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 464:5\<close>

\<comment>\<open>VDM source: pre_activateClocks: (Importer * set of (FMURef) +> bool)
	pre_activateClocks(I, clocks) ==
(clocks subset ((I.readyClocks) inter (I.relevantInputClocks)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 471:16\<close>
definition
	pre_activateClocks :: "Importer\<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"pre_activateClocks I  clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_activateClocks` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_FMURef  clocks))  \<and> 
		\<comment>\<open>User defined body of pre_activateClocks.\<close>
		(clocks \<subseteq> ((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<inter> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))"


\<comment>\<open>VDM source: post_activateClocks: (Importer * set of (FMURef) * Importer +> bool)
	post_activateClocks(I, clocks, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 464:5\<close>
definition
	post_activateClocks :: "Importer\<Rightarrow> FMURef VDMSet\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_activateClocks I  clocks  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_activateClocks` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_FMURef  clocks)  \<and>  inv_Importer RESULT)"

definition
	activateClocks :: "Importer\<Rightarrow> FMURef VDMSet \<Rightarrow> Importer"
where
	"activateClocks I  clocks \<equiv> 
	\<comment>\<open>User defined body of activateClocks.\<close>
	(
		if ((clocks = {})) then
		(I)
		else
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (
		let 
(I1::Importer) = (setClock I  (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock))  (True::\<bool>))
		in
			(if (inv_Importer I1) then
			(activateClocks I1  (clocks - {clock}))
		 else
			undefined
		)
		) | clock .  ((clock \<in>clocks))  }))))"

	
\<comment>\<open>VDM source: updateEnvironmentClock: (Importer * FMU * Ref * bool -> Importer)
	updateEnvironmentClock(I, fmu, clock, val) ==
let fmuref:FMURef = mk_FMURef((fmu.name), clock), activatedVariables:set of (FMURef) = createFMURefs(fmu, (dunion {(c.equations) | c in set (fmu.clocks) & (clock = (c.ref))}), {}) in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmu.name) |-> fmu})), activeClocks |-> (if val
then ((I.activeClocks) union {fmuref})
else ((I.activeClocks) \ {fmuref})), readyClocks |-> (if val
then ((I.readyClocks) \ {fmuref})
else (I.readyClocks)), inactiveClocks |-> (if val
then ((I.inactiveClocks) \ {fmuref})
else ((I.inactiveClocks) union {fmuref})), activeEquations |-> (if val
then ((I.activeEquations) union activatedVariables)
else ((I.activeEquations) \ activatedVariables)), readyEquations |-> (if val
then ((I.readyEquations) \ activatedVariables)
else (I.readyEquations)))
	pre let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((fmuRef in set (I.relevantInputClocks)) or (fmuRef in set (I.relevantOutputClocks)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 478:5\<close>

\<comment>\<open>VDM source: pre_updateEnvironmentClock: (Importer * FMU * Ref * bool +> bool)
	pre_updateEnvironmentClock(I, fmu, clock, val) ==
let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((fmuRef in set (I.relevantInputClocks)) or (fmuRef in set (I.relevantOutputClocks)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 490:9\<close>
definition
	pre_updateEnvironmentClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_updateEnvironmentClock I  fmu  clock  val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_updateEnvironmentClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val))  \<and> 
		\<comment>\<open>User defined body of pre_updateEnvironmentClock.\<close>
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


\<comment>\<open>VDM source: post_updateEnvironmentClock: (Importer * FMU * Ref * bool * Importer +> bool)
	post_updateEnvironmentClock(I, fmu, clock, val, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 478:5\<close>
definition
	post_updateEnvironmentClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_updateEnvironmentClock I  fmu  clock  val  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_updateEnvironmentClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val)  \<and>  inv_Importer RESULT)"

definition
	updateEnvironmentClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> Importer"
where
	"updateEnvironmentClock I  fmu  clock  val \<equiv> 
	\<comment>\<open>User defined body of updateEnvironmentClock.\<close>
	(
		let 
(fmuref::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>;
		
(activatedVariables::FMURef VDMSet) = (createFMURefs fmu  (\<Union> { (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (clock = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c))) })  {})
		in
			(if (inv_FMURef fmuref) \<and> 
	((inv_VDMSet' inv_FMURef  activatedVariables)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmu))\<mapsto>fmu])\<rparr>, activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
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

	
\<comment>\<open>VDM source: queryClock: (Importer * FMU * Ref -> Importer)
	queryClock(I, fmu, clock) ==
let mk_(fmuUpdated, val):(FMU * Value) = get_cm(fmu, clock), fmuref:FMURef = mk_FMURef((fmu.name), clock) in let connectedClock:FMURef = ((I.scenario).clockConnections)(fmuref) in let I1:Importer = mu(I, valueMap |-> ((I.valueMap) ++ {connectedClock |-> val}), relevantOutputClocks |-> ((I.relevantOutputClocks) \ {fmuref}), relevantInputClocks |-> ((I.relevantInputClocks) union {connectedClock})) in updateEnvironmentClock(I1, fmuUpdated, clock, (val.value))
	pre ((mk_FMURef((fmu.name), clock) in set (I.relevantOutputClocks)) and (clock in set {(c.ref) | c in set (fmu.clocks) & ((c.type) = <inputLF>)}))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 496:5\<close>

\<comment>\<open>VDM source: pre_queryClock: (Importer * FMU * Ref +> bool)
	pre_queryClock(I, fmu, clock) ==
((mk_FMURef((fmu.name), clock) in set (I.relevantOutputClocks)) and (clock in set {(c.ref) | c in set (fmu.clocks) & ((c.type) = <inputLF>)}))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 509:9\<close>
definition
	pre_queryClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_queryClock I  fmu  clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_queryClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock))  \<and> 
		\<comment>\<open>User defined body of pre_queryClock.\<close>
		((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> \<in> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (clock \<in> { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) = IOLF.U_inputLF ) }))"


\<comment>\<open>VDM source: post_queryClock: (Importer * FMU * Ref * Importer +> bool)
	post_queryClock(I, fmu, clock, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 496:5\<close>
definition
	post_queryClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_queryClock I  fmu  clock  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_queryClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  inv_Importer RESULT)"

definition
	queryClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> Importer"
where
	"queryClock I  fmu  clock \<equiv> 
	\<comment>\<open>User defined body of queryClock.\<close>
	(
		let 
(val::Value) = (get_cm fmu  clock);
(fmuUpdated::FMU) = (get_cm fmu  clock);
		
(fmuref::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) )\<and>
		  ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) of
		 ValueTypesLF.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))
		  | ValueTypesLF.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))
		 ))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))))
		)) )
		)) \<and> 
	(inv_FMURef fmuref) then
			(
		let 
(connectedClock::FMURef) = (the((clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) fmuref))
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

	
\<comment>\<open>VDM source: setClock: (Importer * FMU * Ref * bool -> Importer)
	setClock(I, fmu, clock, val) ==
let fmuUpdated:FMU = set_cm(fmu, clock, val), fmuref:FMURef = mk_FMURef((fmu.name), clock) in let feedthroughClocks:set of (FMURef) = {mk_FMURef((fmu.name), (c.ref)) | c in set (fmu.clocks) & (clock in set (c.dependsOn))} in let I1:Importer = mu(I, valueMap |-> ({fmuref} <-: (I.valueMap)), relevantInputClocks |-> ((I.relevantInputClocks) \ {fmuref}), relevantOutputClocks |-> ((I.relevantOutputClocks) union feedthroughClocks)) in updateEnvironmentClock(I1, fmuUpdated, clock, val)
	pre (((mk_FMURef((fmu.name), clock) in set (I.relevantInputClocks)) and val) <=> (mk_FMURef((fmu.name), clock) in set ((I.inactiveClocks) inter (I.readyClocks))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 515:5\<close>

\<comment>\<open>VDM source: pre_setClock: (Importer * FMU * Ref * bool +> bool)
	pre_setClock(I, fmu, clock, val) ==
(((mk_FMURef((fmu.name), clock) in set (I.relevantInputClocks)) and val) <=> (mk_FMURef((fmu.name), clock) in set ((I.inactiveClocks) inter (I.readyClocks))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 527:17\<close>
definition
	pre_setClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_setClock I  fmu  clock  val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_setClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val))  \<and> 
		\<comment>\<open>User defined body of pre_setClock.\<close>
		(((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> \<in> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> val) \<longleftrightarrow> (\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> \<in> ((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<inter> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))"


\<comment>\<open>VDM source: post_setClock: (Importer * FMU * Ref * bool * Importer +> bool)
	post_setClock(I, fmu, clock, val, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 515:5\<close>
definition
	post_setClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_setClock I  fmu  clock  val  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_setClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val)  \<and>  inv_Importer RESULT)"

definition
	setClock :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> Importer"
where
	"setClock I  fmu  clock  val \<equiv> 
	\<comment>\<open>User defined body of setClock.\<close>
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

	
\<comment>\<open>VDM source: setPort: (Importer * FMURef -> Importer)
	setPort(I, port) ==
let valueLF:Value = (I.valueMap)(port) in let fmu:FMU = set_m(((I.scenario).fmus)((port.name)), (port.ref), valueLF) in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmu.name) |-> fmu})), valueMap |-> ({port} <-: (I.valueMap)))
	pre (port in set (dom (I.valueMap)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 531:5\<close>

\<comment>\<open>VDM source: pre_setPort: (Importer * FMURef +> bool)
	pre_setPort(I, port) ==
(port in set (dom (I.valueMap)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 539:14\<close>
definition
	pre_setPort :: "Importer\<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_setPort I  port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_setPort` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef port)  \<and> 
		\<comment>\<open>User defined body of pre_setPort.\<close>
		(port \<in> (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))"


\<comment>\<open>VDM source: post_setPort: (Importer * FMURef * Importer +> bool)
	post_setPort(I, port, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 531:5\<close>
definition
	post_setPort :: "Importer\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_setPort I  port  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_setPort` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef port  \<and>  inv_Importer RESULT)"

definition
	setPort :: "Importer\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"setPort I  port \<equiv> 
	\<comment>\<open>User defined body of setPort.\<close>
	(
		let 
(valueLF::Value) = (the((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) port))
		in
			(if (inv_Value valueLF) then
			(
		let 
(fmu::FMU) = (set_m (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port))  valueLF)
		in
			(if (inv_FMU fmu) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmu))\<mapsto>fmu])\<rparr>, valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ({port} -\<triangleleft> (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<rparr>
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: getPort: (Importer * FMURef -> Importer)
	getPort(I, port) ==
let mk_(fmu, val):(FMU * Value) = get_m(((I.scenario).fmus)((port.name)), (port.ref)), connectedInput:FMURef = ((I.scenario).connections)(port) in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmu.name) |-> fmu})), valueMap |-> ((I.valueMap) ++ {connectedInput |-> val}))
	pre (((I.scenario).connections)(port) not in set (dom (I.valueMap)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 543:5\<close>

\<comment>\<open>VDM source: pre_getPort: (Importer * FMURef +> bool)
	pre_getPort(I, port) ==
(((I.scenario).connections)(port) not in set (dom (I.valueMap)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 551:38\<close>
definition
	pre_getPort :: "Importer\<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_getPort I  port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_getPort` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef port)  \<and> 
		\<comment>\<open>User defined body of pre_getPort.\<close>
		((the((connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) port)) \<notin> (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))"


\<comment>\<open>VDM source: post_getPort: (Importer * FMURef * Importer +> bool)
	post_getPort(I, port, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 543:5\<close>
definition
	post_getPort :: "Importer\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_getPort I  port  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_getPort` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef port  \<and>  inv_Importer RESULT)"

definition
	getPort :: "Importer\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"getPort I  port \<equiv> 
	\<comment>\<open>User defined body of getPort.\<close>
	(
		let 
(val::Value) = (get_m (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port)));
(fmu::FMU) = (get_m (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (port)));
		
(connectedInput::FMURef) = (the((connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) port))
		in
			(if (
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) )\<and>
		  ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) of
		 ValueTypesLF.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))
		  | ValueTypesLF.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))
		 ))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))))
		)) )
		)) \<and> 
	(inv_FMURef connectedInput) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmu))\<mapsto>fmu])\<rparr>, valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<dagger> [connectedInput\<mapsto>val])\<rparr>
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: updateEnvironmentEquation: (Importer * FMU * FMURef -> Importer)
	updateEnvironmentEquation(I, fmu, equation) ==
let triggeredClocks:set of (Clock) = {clock | clock in set (fmu.clocks) & ((equation.ref) in set (clock.dependsOn))} in let triggeredInputs:set of (FMURef) = {mk_FMURef((equation.name), (inputClock.ref)) | inputClock in set triggeredClocks & ((inputClock.type) <> <inputLF>)}, triggeredOutputs:set of (FMURef) = {mk_FMURef((equation.name), (outputClock.ref)) | outputClock in set triggeredClocks & ((outputClock.type) <> <outputLF>)} in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmu.name) |-> fmu})), calculatedEquations |-> ((I.calculatedEquations) union {equation}), relevantInputClocks |-> ((I.relevantInputClocks) union triggeredInputs), relevantOutputClocks |-> ((I.relevantOutputClocks) union triggeredOutputs))
	pre (equation in set ((I.activeEquations) \ (I.calculatedEquations)))
	post (equation in set (RESULT.calculatedEquations))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 554:5\<close>

\<comment>\<open>VDM source: pre_updateEnvironmentEquation: (Importer * FMU * FMURef +> bool)
	pre_updateEnvironmentEquation(I, fmu, equation) ==
(equation in set ((I.activeEquations) \ (I.calculatedEquations)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 566:18\<close>
definition
	pre_updateEnvironmentEquation :: "Importer\<Rightarrow> FMU\<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_updateEnvironmentEquation I  fmu  equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_updateEnvironmentEquation` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  inv_FMURef equation)  \<and> 
		\<comment>\<open>User defined body of pre_updateEnvironmentEquation.\<close>
		(equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))"


\<comment>\<open>VDM source: post_updateEnvironmentEquation: (Importer * FMU * FMURef * Importer +> bool)
	post_updateEnvironmentEquation(I, fmu, equation, RESULT) ==
(equation in set (RESULT.calculatedEquations))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 567:19\<close>
definition
	post_updateEnvironmentEquation :: "Importer\<Rightarrow> FMU\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_updateEnvironmentEquation I  fmu  equation  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_updateEnvironmentEquation` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  inv_FMURef equation  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_updateEnvironmentEquation.\<close>
		(equation \<in> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT)))"

definition
	updateEnvironmentEquation :: "Importer\<Rightarrow> FMU\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"updateEnvironmentEquation I  fmu  equation \<equiv> 
	\<comment>\<open>User defined body of updateEnvironmentEquation.\<close>
	(
		let 
(triggeredClocks::Clock VDMSet) = { clock .   ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation)) \<in> (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock))) }
		in
			(if ((inv_VDMSet' inv_Clock  triggeredClocks)) then
			(
		let 
(triggeredInputs::FMURef VDMSet) = { \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (inputClock))\<rparr> | inputClock .  ((inputClock \<in>triggeredClocks))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (inputClock)) \<noteq> IOLF.U_inputLF ) };
		
(triggeredOutputs::FMURef VDMSet) = { \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (outputClock))\<rparr> | outputClock .  ((outputClock \<in>triggeredClocks))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (outputClock)) \<noteq> IOLF.U_outputLF ) }
		in
			(if ((inv_VDMSet' inv_FMURef  triggeredInputs)) \<and> 
	((inv_VDMSet' inv_FMURef  triggeredOutputs)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmu))\<mapsto>fmu])\<rparr>, calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> {equation}), relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> triggeredInputs), relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> triggeredOutputs)\<rparr>
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: calculateInput: (Importer * FMURef -> Importer)
	calculateInput(I, equation) ==
let I1:Importer = setPort(I, equation) in updateEnvironmentEquation(I1, ((I.scenario).fmus)((equation.name)), equation)
	pre let fmu:FMU = ((I.scenario).fmus)((equation.name)) in ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and ((equation in set (dom (I.valueMap))) and (((fmu.mode) = <EVENT>) and (exists [v in set (fmu.inputs)] & (((v.ref) = (equation.ref)) and ((v.type) = <discrete>))))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 573:5\<close>

\<comment>\<open>VDM source: pre_calculateInput: (Importer * FMURef +> bool)
	pre_calculateInput(I, equation) ==
let fmu:FMU = ((I.scenario).fmus)((equation.name)) in ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and ((equation in set (dom (I.valueMap))) and (((fmu.mode) = <EVENT>) and (exists [v in set (fmu.inputs)] & (((v.ref) = (equation.ref)) and ((v.type) = <discrete>))))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 578:9\<close>
definition
	pre_calculateInput :: "Importer\<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_calculateInput I  equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculateInput` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef equation)  \<and> 
		\<comment>\<open>User defined body of pre_calculateInput.\<close>
		(
		let 
(fmu::FMU) = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))))
		in
			(if (inv_FMU fmu) then
			((equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> ((equation \<in> (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_EVENT ) \<and> (\<exists> v \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = DCLF.U_discrete ))))))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_calculateInput: (Importer * FMURef * Importer +> bool)
	post_calculateInput(I, equation, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 573:5\<close>
definition
	post_calculateInput :: "Importer\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_calculateInput I  equation  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_calculateInput` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef equation  \<and>  inv_Importer RESULT)"

definition
	calculateInput :: "Importer\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"calculateInput I  equation \<equiv> 
	\<comment>\<open>User defined body of calculateInput.\<close>
	(
		let 
(I1::Importer) = (setPort I  equation)
		in
			(if (inv_Importer I1) then
			(updateEnvironmentEquation I1  (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))))  equation)
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: calculateOutput: (Importer * FMURef -> Importer)
	calculateOutput(I, equation) ==
let I1:Importer = getPort(I, equation) in updateEnvironmentEquation(I1, ((I.scenario).fmus)((equation.name)), equation)
	pre let fmu:FMU = ((I.scenario).fmus)((equation.name)) in ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and (((fmu.mode) = <EVENT>) and (exists [v in set (fmu.outputs)] & (((v.ref) = (equation.ref)) and ((v.type) = <discrete>)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 588:5\<close>

\<comment>\<open>VDM source: pre_calculateOutput: (Importer * FMURef +> bool)
	pre_calculateOutput(I, equation) ==
let fmu:FMU = ((I.scenario).fmus)((equation.name)) in ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and (((fmu.mode) = <EVENT>) and (exists [v in set (fmu.outputs)] & (((v.ref) = (equation.ref)) and ((v.type) = <discrete>)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 593:9\<close>
definition
	pre_calculateOutput :: "Importer\<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_calculateOutput I  equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculateOutput` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef equation)  \<and> 
		\<comment>\<open>User defined body of pre_calculateOutput.\<close>
		(
		let 
(fmu::FMU) = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))))
		in
			(if (inv_FMU fmu) then
			((equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_EVENT ) \<and> (\<exists> v \<in> (outputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (v)) = DCLF.U_discrete )))))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_calculateOutput: (Importer * FMURef * Importer +> bool)
	post_calculateOutput(I, equation, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 588:5\<close>
definition
	post_calculateOutput :: "Importer\<Rightarrow> FMURef\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_calculateOutput I  equation  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_calculateOutput` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef equation  \<and>  inv_Importer RESULT)"

definition
	calculateOutput :: "Importer\<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"calculateOutput I  equation \<equiv> 
	\<comment>\<open>User defined body of calculateOutput.\<close>
	(
		let 
(I1::Importer) = (getPort I  equation)
		in
			(if (inv_Importer I1) then
			(updateEnvironmentEquation I1  (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (equation))))  equation)
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: runAlgorithm: (Importer * set of (Action) -> Importer)
	runAlgorithm(I, algorithm) ==
(if (algorithm = {})
then I
else let action in set {a | a in set algorithm & activatedAction(I, a)} in runAlgorithm(runAction(I, action), (algorithm \ {action})))
	measure (card algorithm)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 602:5\<close>

\<comment>\<open>VDM source: pre_runAlgorithm: (Importer * set of (Action) +> bool)
	pre_runAlgorithm(I, algorithm) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 602:5\<close>
definition
	pre_runAlgorithm :: "Importer\<Rightarrow> Action VDMSet \<Rightarrow> bool"
where
	"pre_runAlgorithm I  algorithm \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_runAlgorithm` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_Action  algorithm))"


\<comment>\<open>VDM source: post_runAlgorithm: (Importer * set of (Action) * Importer +> bool)
	post_runAlgorithm(I, algorithm, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 602:5\<close>
definition
	post_runAlgorithm :: "Importer\<Rightarrow> Action VDMSet\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_runAlgorithm I  algorithm  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_runAlgorithm` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_Action  algorithm)  \<and>  inv_Importer RESULT)"

definition
	runAlgorithm :: "Importer\<Rightarrow> Action VDMSet \<Rightarrow> Importer"
where
	"runAlgorithm I  algorithm \<equiv> 
	\<comment>\<open>User defined body of runAlgorithm.\<close>
	(
		if ((algorithm = {})) then
		(I)
		else
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (runAlgorithm (runAction I  action)  (algorithm - {action})) | action .  ((action \<in>{ a .   ((a \<in>algorithm))  \<and> (activatedAction I  a) }))  }))))"

	
\<comment>\<open>VDM source: initializeData: (Importer -> Importer)
	initializeData(I) ==
let connections:map (FMURef) to (FMURef) = ((I.scenario).connections) in let outputs:set of (Action) = {mk_Action(<get>, ((I.scenario).fmus)((outputLF.name)), (outputLF.ref)) | outputLF in set (dom connections)}, inputs:set of (Action) = {mk_Action(<set>, ((I.scenario).fmus)((inputLF.name)), (inputLF.ref)) | inputLF in set (rng connections)} in runAlgorithm(I, (outputs union inputs))
	pre (forall fmu in set (rng ((I.scenario).fmus)) & ((fmu.mode) = <INIT>))
	post variablesSynchronized((RESULT.scenario))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 615:5\<close>

\<comment>\<open>VDM source: pre_initializeData: (Importer +> bool)
	pre_initializeData(I) ==
(forall fmu in set (rng ((I.scenario).fmus)) & ((fmu.mode) = <INIT>))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 622:9\<close>
definition
	pre_initializeData :: "Importer \<Rightarrow> bool"
where
	"pre_initializeData I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_initializeData` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_initializeData.\<close>
		(\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_INIT ))"


\<comment>\<open>VDM source: post_initializeData: (Importer * Importer +> bool)
	post_initializeData(I, RESULT) ==
variablesSynchronized((RESULT.scenario))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 623:10\<close>
definition
	post_initializeData :: "Importer\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_initializeData I  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_initializeData` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_initializeData.\<close>
		(variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT)))"

definition
	initializeData :: "Importer \<Rightarrow> Importer"
where
	"initializeData I \<equiv> 
	\<comment>\<open>User defined body of initializeData.\<close>
	(
		let 
(connections::(FMURef \<rightharpoonup> FMURef)) = (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))
		in
			(if ((inv_Map inv_FMURef  inv_FMURef  connections)) then
			(
		let 
(outputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_get , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))\<rparr> | outputLF .  ((outputLF \<in>(dom connections)))  };
		
(inputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_set , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))\<rparr> | inputLF .  ((inputLF \<in>(rng connections)))  }
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

	
\<comment>\<open>VDM source: cosimStep: (Importer -> Importer)
	cosimStep(I) ==
let connections:map (FMURef) to (FMURef) = ((I.scenario).connections) in let fmus:set of (FMU) = (rng ((I.scenario).fmus)) in let outputs:set of (Action) = {mk_Action(<get>, ((I.scenario).fmus)((outputLF.name)), (outputLF.ref)) | outputLF in set (dom connections) & ((derefOutput(((I.scenario).fmus)((outputLF.name)), (outputLF.ref)).type) = <continous>)}, inputs:set of (Action) = {mk_Action(<set>, ((I.scenario).fmus)((inputLF.name)), (inputLF.ref)) | inputLF in set (rng connections) & ((derefInput(((I.scenario).fmus)((inputLF.name)), (inputLF.ref)).type) = <continous>)}, steps:set of (Action) = {mk_Action(<step>, fmu, 1) | fmu in set fmus} in let actions:set of (Action) = ((outputs union inputs) union steps) in runAlgorithm(I, actions)
	pre let scenario:Machine = (I.scenario) in ((forall fmu in set (rng (scenario.fmus)) & ((fmu.mode) = <STEP>)) and (variablesSynchronized(scenario) and fmusSynchronized(scenario)))
	post let scenario:Machine = (RESULT.scenario) in ((forall fmu in set (rng (scenario.fmus)) & ((fmu.mode) = <STEP>)) and (variablesSynchronized(scenario) and fmusSynchronized(scenario)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 630:5\<close>

\<comment>\<open>VDM source: pre_cosimStep: (Importer +> bool)
	pre_cosimStep(I) ==
let scenario:Machine = (I.scenario) in ((forall fmu in set (rng (scenario.fmus)) & ((fmu.mode) = <STEP>)) and (variablesSynchronized(scenario) and fmusSynchronized(scenario)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 642:9\<close>
definition
	pre_cosimStep :: "Importer \<Rightarrow> bool"
where
	"pre_cosimStep I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_cosimStep` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_cosimStep.\<close>
		(
		let 
(scenario::Machine) = (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))
		in
			(if (inv_Machine scenario) then
			((\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario)))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_STEP )) \<and> ((variablesSynchronized scenario) \<and> (fmusSynchronized scenario)))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_cosimStep: (Importer * Importer +> bool)
	post_cosimStep(I, RESULT) ==
let scenario:Machine = (RESULT.scenario) in ((forall fmu in set (rng (scenario.fmus)) & ((fmu.mode) = <STEP>)) and (variablesSynchronized(scenario) and fmusSynchronized(scenario)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 645:9\<close>
definition
	post_cosimStep :: "Importer\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_cosimStep I  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_cosimStep` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_cosimStep.\<close>
		(
		let 
(scenario::Machine) = (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))
		in
			(if (inv_Machine scenario) then
			((\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario)))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_STEP )) \<and> ((variablesSynchronized scenario) \<and> (fmusSynchronized scenario)))
		 else
			undefined
		)
		)"

definition
	cosimStep :: "Importer \<Rightarrow> Importer"
where
	"cosimStep I \<equiv> 
	\<comment>\<open>User defined body of cosimStep.\<close>
	(
		let 
(connections::(FMURef \<rightharpoonup> FMURef)) = (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))
		in
			(if ((inv_Map inv_FMURef  inv_FMURef  connections)) then
			(
		let 
(fmus::FMU VDMSet) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))
		in
			(if ((inv_VDMSet' inv_FMU  fmus)) then
			(
		let 
(outputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_get , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))\<rparr> | outputLF .  ((outputLF \<in>(dom connections)))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e ((derefOutput (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))))) = DCLF.U_continous ) };
		
(inputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_set , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))\<rparr> | inputLF .  ((inputLF \<in>(rng connections)))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e ((derefInput (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))))  (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))))) = DCLF.U_continous ) };
		
(steps::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_step , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = fmu, port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (1::VDMNat1)\<rparr> | fmu .  ((fmu \<in>fmus))  }
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

	
\<comment>\<open>VDM source: runAction: (Importer * Action -> Importer)
	runAction(I, A) ==
(cases A :
mk_Action(<get>, fmu, port) -> getPort(I, mk_FMURef((fmu.name), port)),
mk_Action(<set>, fmu, port) -> setPort(I, mk_FMURef((fmu.name), port)),
mk_Action(<step>, fmu, -) -> stepFMU(I, fmu),
mk_Action(<setC>, fmu, clock) -> setClock(I, fmu, clock, true),
mk_Action(<getC>, fmu, clock) -> queryClock(I, fmu, clock)
end)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 651:5\<close>

\<comment>\<open>VDM source: pre_runAction: (Importer * Action +> bool)
	pre_runAction(I, A) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 651:5\<close>
definition
	pre_runAction :: "Importer\<Rightarrow> Action \<Rightarrow> bool"
where
	"pre_runAction I  A \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_runAction` specification.\<close>
		(inv_Importer I  \<and>  inv_Action A)"


\<comment>\<open>VDM source: post_runAction: (Importer * Action * Importer +> bool)
	post_runAction(I, A, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 651:5\<close>
definition
	post_runAction :: "Importer\<Rightarrow> Action\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_runAction I  A  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_runAction` specification.\<close>
		(inv_Importer I  \<and>  inv_Action A  \<and>  inv_Importer RESULT)"

definition
	runAction :: "Importer\<Rightarrow> Action \<Rightarrow> Importer"
where
	"runAction I  A \<equiv> 
	\<comment>\<open>User defined body of runAction.\<close>
	(
		 \<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. optional, union, etc.) for `Action` VDM type.\<close>)"

	
\<comment>\<open>VDM source: stepFMU: (Importer * FMU -> Importer)
	stepFMU(I, fmu) ==
let mk_(fmuUpdated, step, event):(FMU * real * bool) = step_tm(fmu, (I.stepSize)) in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmuUpdated.name) |-> fmuUpdated})), fmusWithEvent |-> (if event
then ((I.fmusWithEvent) union {(fmu.name)})
else (I.fmusWithEvent)), stepSize |-> step)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 673:5\<close>

\<comment>\<open>VDM source: pre_stepFMU: (Importer * FMU +> bool)
	pre_stepFMU(I, fmu) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 673:5\<close>
definition
	pre_stepFMU :: "Importer\<Rightarrow> FMU \<Rightarrow> bool"
where
	"pre_stepFMU I  fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_stepFMU` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu)"


\<comment>\<open>VDM source: post_stepFMU: (Importer * FMU * Importer +> bool)
	post_stepFMU(I, fmu, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 673:5\<close>
definition
	post_stepFMU :: "Importer\<Rightarrow> FMU\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_stepFMU I  fmu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_stepFMU` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  inv_Importer RESULT)"

definition
	stepFMU :: "Importer\<Rightarrow> FMU \<Rightarrow> Importer"
where
	"stepFMU I  fmu \<equiv> 
	\<comment>\<open>User defined body of stepFMU.\<close>
	(
		let 
(step::VDMReal) = (step_tm fmu  (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)));
(event::bool) = (step_tm fmu  (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)));
(fmuUpdated::FMU) = (step_tm fmu  (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))
		in
			(if (
		( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))
		)) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value  null)) ((inv_Map ((inv_VDMNat)) inv_Value  null)))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) )\<and>
		 (inv_VDMReal (fst (snd dummy0)))\<and>
		 (inv_bool (snd (snd dummy0)))
		)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U (fmuUpdated))\<mapsto>fmuUpdated])\<rparr>, fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (event) then
		(((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<union> {(name\<^sub>F\<^sub>M\<^sub>U (fmu))}))
		else
		((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))), stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := step\<rparr>
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: activatedAction: (Importer * Action -> bool)
	activatedAction(I, A) ==
(cases A :
mk_Action(<get>, fmu, port) -> preGetI(I, fmu, port),
mk_Action(<set>, fmu, port) -> preSetI(I, fmu, port),
mk_Action(<step>, fmu, -) -> preStepI(I, fmu),
mk_Action(<setC>, fmu, clock) -> preSetCI(I, fmu, clock),
mk_Action(<getC>, fmu, clock) -> preGetCI(I, fmu, clock)
end)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 686:5\<close>

\<comment>\<open>VDM source: pre_activatedAction: (Importer * Action +> bool)
	pre_activatedAction(I, A) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 686:5\<close>
definition
	pre_activatedAction :: "Importer\<Rightarrow> Action \<Rightarrow> bool"
where
	"pre_activatedAction I  A \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_activatedAction` specification.\<close>
		(inv_Importer I  \<and>  inv_Action A)"


\<comment>\<open>VDM source: post_activatedAction: (Importer * Action * bool +> bool)
	post_activatedAction(I, A, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 686:5\<close>
definition
	post_activatedAction :: "Importer\<Rightarrow> Action\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_activatedAction I  A  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_activatedAction` specification.\<close>
		(inv_Importer I  \<and>  inv_Action A  \<and>  (inv_bool RESULT))"

definition
	activatedAction :: "Importer\<Rightarrow> Action \<Rightarrow> bool"
where
	"activatedAction I  A \<equiv> 
	\<comment>\<open>User defined body of activatedAction.\<close>
	(
		 \<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. optional, union, etc.) for `Action` VDM type.\<close>)"

	
\<comment>\<open>VDM source: preSetI: (Importer * FMU * Ref -> bool)
	preSetI(I, fmu, port) ==
let inputLF:Variable = derefInput(fmu, port) in ((((fmu.mode) = <EVENT>) <=> ((mk_FMURef((fmu.name), port) in set ((I.activeEquations) \ (I.calculatedEquations))) and ((inputLF.type) = <discrete>))) and ((((fmu.mode) = <STEP>) <=> ((inputLF.type) = <continous>)) and preSet(fmu, port)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 700:5\<close>

\<comment>\<open>VDM source: pre_preSetI: (Importer * FMU * Ref +> bool)
	pre_preSetI(I, fmu, port) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 700:5\<close>
definition
	pre_preSetI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preSetI I  fmu  port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSetI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref port))"


\<comment>\<open>VDM source: post_preSetI: (Importer * FMU * Ref * bool +> bool)
	post_preSetI(I, fmu, port, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 700:5\<close>
definition
	post_preSetI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preSetI I  fmu  port  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preSetI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref port)  \<and>  (inv_bool RESULT))"

definition
	preSetI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"preSetI I  fmu  port \<equiv> 
	\<comment>\<open>User defined body of preSetI.\<close>
	(
		let 
(inputLF::Variable) = (derefInput fmu  port)
		in
			(if (inv_Variable inputLF) then
			((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_EVENT ) \<longleftrightarrow> ((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = port\<rparr> \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (inputLF)) = DCLF.U_discrete ))) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_STEP ) \<longleftrightarrow> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (inputLF)) = DCLF.U_continous )) \<and> (preSet fmu  port)))
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: preGetI: (Importer * FMU * Ref -> bool)
	preGetI(I, fmu, port) ==
let outputLF:Variable = derefOutput(fmu, port) in ((((fmu.mode) = <EVENT>) <=> ((mk_FMURef((fmu.name), port) in set ((I.activeEquations) \ (I.calculatedEquations))) and ((outputLF.type) = <discrete>))) and ((((fmu.mode) = <STEP>) <=> ((outputLF.type) = <continous>)) and preGet(fmu, port)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 708:5\<close>

\<comment>\<open>VDM source: pre_preGetI: (Importer * FMU * Ref +> bool)
	pre_preGetI(I, fmu, port) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 708:5\<close>
definition
	pre_preGetI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGetI I  fmu  port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGetI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref port))"


\<comment>\<open>VDM source: post_preGetI: (Importer * FMU * Ref * bool +> bool)
	post_preGetI(I, fmu, port, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 708:5\<close>
definition
	post_preGetI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preGetI I  fmu  port  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preGetI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref port)  \<and>  (inv_bool RESULT))"

definition
	preGetI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"preGetI I  fmu  port \<equiv> 
	\<comment>\<open>User defined body of preGetI.\<close>
	(
		let 
(outputLF::Variable) = (derefOutput fmu  port)
		in
			(if (inv_Variable outputLF) then
			((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_EVENT ) \<longleftrightarrow> ((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U (fmu)), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = port\<rparr> \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (outputLF)) = DCLF.U_discrete ))) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_STEP ) \<longleftrightarrow> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (outputLF)) = DCLF.U_continous )) \<and> (preGet fmu  port)))
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: preStepI: (Importer * FMU -> bool)
	preStepI(I, fmu) ==
preStepT(fmu, (I.stepSize))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 716:5\<close>

\<comment>\<open>VDM source: pre_preStepI: (Importer * FMU +> bool)
	pre_preStepI(I, fmu) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 716:5\<close>
definition
	pre_preStepI :: "Importer\<Rightarrow> FMU \<Rightarrow> bool"
where
	"pre_preStepI I  fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preStepI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu)"


\<comment>\<open>VDM source: post_preStepI: (Importer * FMU * bool +> bool)
	post_preStepI(I, fmu, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 716:5\<close>
definition
	post_preStepI :: "Importer\<Rightarrow> FMU\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preStepI I  fmu  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preStepI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_bool RESULT))"

definition
	preStepI :: "Importer\<Rightarrow> FMU \<Rightarrow> bool"
where
	"preStepI I  fmu \<equiv> 
	\<comment>\<open>User defined body of preStepI.\<close>
	(preStepT fmu  (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))"

	
\<comment>\<open>VDM source: preGetCI: (Importer * FMU * Ref -> bool)
	preGetCI(I, fmu, clock) ==
let outputLF:FMURef = mk_FMURef((fmu.name), clock) in ((outputLF in set (I.relevantOutputClocks)) and preGetC(fmu, clock))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 720:5\<close>

\<comment>\<open>VDM source: pre_preGetCI: (Importer * FMU * Ref +> bool)
	pre_preGetCI(I, fmu, clock) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 720:5\<close>
definition
	pre_preGetCI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGetCI I  fmu  clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGetCI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock))"


\<comment>\<open>VDM source: post_preGetCI: (Importer * FMU * Ref * bool +> bool)
	post_preGetCI(I, fmu, clock, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 720:5\<close>
definition
	post_preGetCI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preGetCI I  fmu  clock  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preGetCI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool RESULT))"

definition
	preGetCI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"preGetCI I  fmu  clock \<equiv> 
	\<comment>\<open>User defined body of preGetCI.\<close>
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

	
\<comment>\<open>VDM source: preSetCI: (Importer * FMU * Ref -> bool)
	preSetCI(I, fmu, clock) ==
let inputLF:FMURef = mk_FMURef((fmu.name), clock) in let val:Value = (I.valueMap)(inputLF) in (preSetC(fmu, clock, (val.value)) and (inputLF in set (I.relevantInputClocks)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 727:5\<close>

\<comment>\<open>VDM source: pre_preSetCI: (Importer * FMU * Ref +> bool)
	pre_preSetCI(I, fmu, clock) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 727:5\<close>
definition
	pre_preSetCI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preSetCI I  fmu  clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSetCI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock))"


\<comment>\<open>VDM source: post_preSetCI: (Importer * FMU * Ref * bool +> bool)
	post_preSetCI(I, fmu, clock, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 727:5\<close>
definition
	post_preSetCI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preSetCI I  fmu  clock  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preSetCI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool RESULT))"

definition
	preSetCI :: "Importer\<Rightarrow> FMU\<Rightarrow> Ref \<Rightarrow> bool"
where
	"preSetCI I  fmu  clock \<equiv> 
	\<comment>\<open>User defined body of preSetCI.\<close>
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

	
\<comment>\<open>VDM source: feedthroughSatisfied: (FMU * Variable -> bool)
	feedthroughSatisfied(fmu, outputLF) ==
(forall i in set (fmu.inputs) & (((i.ref) in set (outputLF.dependsOn)) and ((((i.contract) = <reactive>) => (((fmu.env)((i.ref)).time) >= (fmu.time))) and (((i.contract) = <delayed>) => (((fmu.env)((i.ref)).time) = (fmu.time))))))
	pre (forall i in set (fmu.inputs) & ((i.causality) = <inputLF>))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 741:5\<close>

\<comment>\<open>VDM source: pre_feedthroughSatisfied: (FMU * Variable +> bool)
	pre_feedthroughSatisfied(fmu, outputLF) ==
(forall i in set (fmu.inputs) & ((i.causality) = <inputLF>))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 747:9\<close>
definition
	pre_feedthroughSatisfied :: "FMU\<Rightarrow> Variable \<Rightarrow> bool"
where
	"pre_feedthroughSatisfied fmu  outputLF \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_feedthroughSatisfied` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Variable outputLF)  \<and> 
		\<comment>\<open>User defined body of pre_feedthroughSatisfied.\<close>
		(\<forall> i \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . ((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = IOLF.U_inputLF ))"


\<comment>\<open>VDM source: post_feedthroughSatisfied: (FMU * Variable * bool +> bool)
	post_feedthroughSatisfied(fmu, outputLF, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 741:5\<close>
definition
	post_feedthroughSatisfied :: "FMU\<Rightarrow> Variable\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_feedthroughSatisfied fmu  outputLF  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_feedthroughSatisfied` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Variable outputLF  \<and>  (inv_bool RESULT))"

definition
	feedthroughSatisfied :: "FMU\<Rightarrow> Variable \<Rightarrow> bool"
where
	"feedthroughSatisfied fmu  outputLF \<equiv> 
	\<comment>\<open>User defined body of feedthroughSatisfied.\<close>
	(\<forall> i \<in> (inputs\<^sub>F\<^sub>M\<^sub>U (fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) \<in> (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (outputLF))) \<and> ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = ContractLF.U_reactive ) \<longrightarrow> ((time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (((env\<^sub>F\<^sub>M\<^sub>U (fmu)) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i))))) \<ge> (time\<^sub>F\<^sub>M\<^sub>U (fmu)))) \<and> (((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i)) = ContractLF.U_delayed ) \<longrightarrow> ((time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (((env\<^sub>F\<^sub>M\<^sub>U (fmu)) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (i))))) = (time\<^sub>F\<^sub>M\<^sub>U (fmu)))))))"

	
\<comment>\<open>VDM source: updateSchedule: (Importer * set of (Name) * set of (Interval) -> Importer)
	updateSchedule(I, fmus, intervalSet) ==
(if (fmus = {})
then I
else let name in set fmus in let fmu:FMU = ((I.scenario).fmus)(name) in let relevantClocks:set of (Ref) = {(c.ref) | c in set (fmu.clocks) & ((c.interval) in set intervalSet)} in let scheduleEntries:map (FMURef) to (real) = calculateSchedule(fmu, relevantClocks, {|->}) in let I1:Importer = mu(I, schedule |-> ((I.schedule) ++ scheduleEntries)) in updateSchedule(I1, (fmus \ {name}), intervalSet))
	measure (card fmus)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 753:1\<close>

\<comment>\<open>VDM source: pre_updateSchedule: (Importer * set of (Name) * set of (Interval) +> bool)
	pre_updateSchedule(I, fmus, intervalSet) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 753:1\<close>
definition
	pre_updateSchedule :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Interval VDMSet \<Rightarrow> bool"
where
	"pre_updateSchedule I  fmus  intervalSet \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_updateSchedule` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) fmus)  \<and>  (inv_VDMSet' (inv_Interval) intervalSet))"


\<comment>\<open>VDM source: post_updateSchedule: (Importer * set of (Name) * set of (Interval) * Importer +> bool)
	post_updateSchedule(I, fmus, intervalSet, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 753:1\<close>
definition
	post_updateSchedule :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Interval VDMSet\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_updateSchedule I  fmus  intervalSet  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_updateSchedule` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) fmus)  \<and>  (inv_VDMSet' (inv_Interval) intervalSet)  \<and>  inv_Importer RESULT)"

definition
	updateSchedule :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Interval VDMSet \<Rightarrow> Importer"
where
	"updateSchedule I  fmus  intervalSet \<equiv> 
	\<comment>\<open>User defined body of updateSchedule.\<close>
	(
		if ((fmus = {})) then
		(I)
		else
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (
		let 
(fmu::FMU) = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) name))
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

	
\<comment>\<open>VDM source: createSchedule: (Importer -> Importer)
	createSchedule(I) ==
let fmus:set of (Name) = (dom ((I.scenario).fmus)) in updateSchedule(I, fmus, {<constantLF>, <fixed>, <calculated>, <tunable>, <changing>, <countdown>})
	pre (forall m' in set (rng ((I.scenario).fmus)) & (((m'.mode) = <INIT>) and (fmusSynchronized((I.scenario)) and variablesSynchronized((I.scenario)))))
	post let timeBasedClocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & (((clock.type) = <inputLF>) and ((clock.interval) <> <triggered>))}, {}) | fmu in set (rng ((I.scenario).fmus))}) in (((dom (RESULT.schedule)) = timeBasedClocks) and ((forall m' in set (rng ((I.scenario).fmus)) & ((m'.mode) = <INIT>)) and (fmusSynchronized((I.scenario)) and variablesSynchronized((I.scenario)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 769:5\<close>

\<comment>\<open>VDM source: pre_createSchedule: (Importer +> bool)
	pre_createSchedule(I) ==
(forall m' in set (rng ((I.scenario).fmus)) & (((m'.mode) = <INIT>) and (fmusSynchronized((I.scenario)) and variablesSynchronized((I.scenario)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 773:9\<close>
definition
	pre_createSchedule :: "Importer \<Rightarrow> bool"
where
	"pre_createSchedule I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_createSchedule` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_createSchedule.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_INIT ) \<and> ((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))))"


\<comment>\<open>VDM source: post_createSchedule: (Importer * Importer +> bool)
	post_createSchedule(I, RESULT) ==
let timeBasedClocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & (((clock.type) = <inputLF>) and ((clock.interval) <> <triggered>))}, {}) | fmu in set (rng ((I.scenario).fmus))}) in (((dom (RESULT.schedule)) = timeBasedClocks) and ((forall m' in set (rng ((I.scenario).fmus)) & ((m'.mode) = <INIT>)) and (fmusSynchronized((I.scenario)) and variablesSynchronized((I.scenario)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 777:9\<close>
definition
	post_createSchedule :: "Importer\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_createSchedule I  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_createSchedule` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_createSchedule.\<close>
		(
		let 
(timeBasedClocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu  { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) = IOLF.U_inputLF ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (clock)) \<noteq> Interval.U_triggered )) }  {}) | fmu .  ((fmu \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))))  })
		in
			(if ((inv_VDMSet' inv_FMURef  timeBasedClocks)) then
			(((dom (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))) = timeBasedClocks) \<and> ((\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_INIT )) \<and> ((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))))
		 else
			undefined
		)
		)"

definition
	createSchedule :: "Importer \<Rightarrow> Importer"
where
	"createSchedule I \<equiv> 
	\<comment>\<open>User defined body of createSchedule.\<close>
	(
		let 
(fmus::Name VDMSet) = (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) fmus)) then
			(updateSchedule I  fmus  {Interval.U_constantLF , Interval.U_fixed , Interval.U_calculated , Interval.U_tunable , Interval.U_changing , Interval.U_countdown })
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: initialization: (Importer -> Importer)
	initialization(I) ==
let I1:Importer = initializeData(I) in let I2:Importer = createSchedule(I1) in enterStepMode(I2, (dom ((I2.scenario).fmus)))
	pre (forall m' in set (rng ((I.scenario).fmus)) & (((m'.mode) = <INIT>) and fmusSynchronized((I.scenario))))
	post (forall m' in set (rng ((RESULT.scenario).fmus)) & (((m'.mode) = <STEP>) and (variablesSynchronized((RESULT.scenario)) and fmusSynchronized((RESULT.scenario)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 788:5\<close>

\<comment>\<open>VDM source: pre_initialization: (Importer +> bool)
	pre_initialization(I) ==
(forall m' in set (rng ((I.scenario).fmus)) & (((m'.mode) = <INIT>) and fmusSynchronized((I.scenario))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 803:9\<close>
definition
	pre_initialization :: "Importer \<Rightarrow> bool"
where
	"pre_initialization I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_initialization` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_initialization.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_INIT ) \<and> (fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))"


\<comment>\<open>VDM source: post_initialization: (Importer * Importer +> bool)
	post_initialization(I, RESULT) ==
(forall m' in set (rng ((RESULT.scenario).fmus)) & (((m'.mode) = <STEP>) and (variablesSynchronized((RESULT.scenario)) and fmusSynchronized((RESULT.scenario)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 805:10\<close>
definition
	post_initialization :: "Importer\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_initialization I  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_initialization` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_initialization.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_STEP ) \<and> ((variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))) \<and> (fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))))))"

definition
	initialization :: "Importer \<Rightarrow> Importer"
where
	"initialization I \<equiv> 
	\<comment>\<open>User defined body of initialization.\<close>
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
			(enterStepMode I2  (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I2))))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: tickingClocks: (Importer -> (Importer * set of (FMURef)))
	tickingClocks(I) ==
let clocks:set of (FMURef) = (dom ((I.schedule) :> {((I.time).r)})) in let I1:Importer = mu(I, relevantInputClocks |-> clocks) in mk_(I1, clocks)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 812:5\<close>

\<comment>\<open>VDM source: pre_tickingClocks: (Importer +> bool)
	pre_tickingClocks(I) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 812:5\<close>
definition
	pre_tickingClocks :: "Importer \<Rightarrow> bool"
where
	"pre_tickingClocks I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_tickingClocks` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_tickingClocks: (Importer * (Importer * set of (FMURef)) +> bool)
	post_tickingClocks(I, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 812:5\<close>
definition
	post_tickingClocks :: "Importer\<Rightarrow> (Importer\<times> FMURef VDMSet) \<Rightarrow> bool"
where
	"post_tickingClocks I  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_tickingClocks` specification.\<close>
		(inv_Importer I  \<and>  
		(inv_Importer (fst RESULT)\<and>
		 (inv_VDMSet' inv_FMURef  (snd RESULT))
		))"

definition
	tickingClocks :: "Importer \<Rightarrow> (Importer\<times> FMURef VDMSet)"
where
	"tickingClocks I \<equiv> 
	\<comment>\<open>User defined body of tickingClocks.\<close>
	(
		let 
(clocks::FMURef VDMSet) = (dom ((schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<triangleright> {(r\<^sub>T\<^sub>i\<^sub>m\<^sub>e ((time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))}))
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

	
\<comment>\<open>VDM source: stepnegotiation: (Importer -> real)
	stepnegotiation(M) ==
not yet specified
	post ((RESULT >= 0) and (forall fmu in set (rng ((M.scenario).fmus)) & ((fmu.maxStep) >= RESULT)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 825:5\<close>

\<comment>\<open>VDM source: pre_stepnegotiation: (Importer +> bool)
	pre_stepnegotiation(M) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 825:5\<close>
definition
	pre_stepnegotiation :: "Importer \<Rightarrow> bool"
where
	"pre_stepnegotiation M \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_stepnegotiation` specification.\<close>
		(inv_Importer M)"


\<comment>\<open>VDM source: post_stepnegotiation: (Importer * real +> bool)
	post_stepnegotiation(M, RESULT) ==
((RESULT >= 0) and (forall fmu in set (rng ((M.scenario).fmus)) & ((fmu.maxStep) >= RESULT)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 829:9\<close>
definition
	post_stepnegotiation :: "Importer\<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"post_stepnegotiation M  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_stepnegotiation` specification.\<close>
		(inv_Importer M  \<and>  (inv_VDMReal RESULT))  \<and> 
		\<comment>\<open>User defined body of post_stepnegotiation.\<close>
		((RESULT \<ge> (0::VDMNat)) \<and> (\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (M)))))  . ((maxStep\<^sub>F\<^sub>M\<^sub>U (fmu)) \<ge> RESULT)))"

definition
	stepnegotiation :: "Importer \<Rightarrow> VDMReal"
where
	"stepnegotiation M \<equiv> 
	\<comment>\<open>User defined body of stepnegotiation.\<close>
	undefined"

	
\<comment>\<open>VDM source: cosimulationStep: (Importer -> Importer)
	cosimulationStep(I) ==
let mk_(I1, clocksToTick):(Importer * set of (FMURef)) = tickingClocks(I) in let eventDetected:bool = ((clocksToTick <> {}) or ((I1.fmusWithEvent) <> {})) in let I2:Importer = (if eventDetected
then clockedSimulationAlgorithm(I1, clocksToTick)
else I) in let I3:Importer = mu(I, stepSize |-> stepnegotiation(I2)) in let I4:Importer = cosimStep(I3) in (if ((I4.endtime) >= (I4.time))
then cosimulationStep(I4)
else I4)
	pre (forall m' in set (rng ((I.scenario).fmus)) & (((m'.mode) = <STEP>) and (variablesSynchronized((I.scenario)) and fmusSynchronized((I.scenario)))))
	post (forall m' in set (rng ((RESULT.scenario).fmus)) & (((m'.mode) = <STEP>) and (variablesSynchronized((RESULT.scenario)) and fmusSynchronized((RESULT.scenario)))))
	measure (((I.endtime).r) - ((I.time).r))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 834:5\<close>

\<comment>\<open>VDM source: pre_cosimulationStep: (Importer +> bool)
	pre_cosimulationStep(I) ==
(forall m' in set (rng ((I.scenario).fmus)) & (((m'.mode) = <STEP>) and (variablesSynchronized((I.scenario)) and fmusSynchronized((I.scenario)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 858:9\<close>
definition
	pre_cosimulationStep :: "Importer \<Rightarrow> bool"
where
	"pre_cosimulationStep I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_cosimulationStep` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_cosimulationStep.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_STEP ) \<and> ((variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))))"


\<comment>\<open>VDM source: post_cosimulationStep: (Importer * Importer +> bool)
	post_cosimulationStep(I, RESULT) ==
(forall m' in set (rng ((RESULT.scenario).fmus)) & (((m'.mode) = <STEP>) and (variablesSynchronized((RESULT.scenario)) and fmusSynchronized((RESULT.scenario)))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 861:10\<close>
definition
	post_cosimulationStep :: "Importer\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_cosimulationStep I  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_cosimulationStep` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_cosimulationStep.\<close>
		(\<forall> m' \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (m')) = FMUModeLF.U_STEP ) \<and> ((variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))) \<and> (fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (RESULT))))))"

definition
	cosimulationStep :: "Importer \<Rightarrow> Importer"
where
	"cosimulationStep I \<equiv> 
	\<comment>\<open>User defined body of cosimulationStep.\<close>
	(
		let 
(I1::Importer) = (tickingClocks I);
(clocksToTick::FMURef VDMSet) = (tickingClocks I)
		in
			(if (
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) )) \<and> 
		 ((inv_Map inv_FMURef  (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))))
		)) \<and> 
		 (
		(((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))))
		)) \<and> 
		 ((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) )\<and>
		 (inv_VDMSet' inv_FMURef  (snd dummy0))
		)) then
			(
		let 
(eventDetected::bool) = ((clocksToTick \<noteq> {}) \<or> ((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I1)) \<noteq> {}))
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

	
\<comment>\<open>VDM source: fmusSynchronized: (Machine -> bool)
	fmusSynchronized(M) ==
((card {(fmu.time) | fmu in set (rng (M.fmus))}) = 1)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 866:5\<close>

\<comment>\<open>VDM source: pre_fmusSynchronized: (Machine +> bool)
	pre_fmusSynchronized(M) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 866:5\<close>
definition
	pre_fmusSynchronized :: "Machine \<Rightarrow> bool"
where
	"pre_fmusSynchronized M \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_fmusSynchronized` specification.\<close>
		(inv_Machine M)"


\<comment>\<open>VDM source: post_fmusSynchronized: (Machine * bool +> bool)
	post_fmusSynchronized(M, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 866:5\<close>
definition
	post_fmusSynchronized :: "Machine\<Rightarrow> bool \<Rightarrow> bool"
where
	"post_fmusSynchronized M  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_fmusSynchronized` specification.\<close>
		(inv_Machine M  \<and>  (inv_bool RESULT))"

definition
	fmusSynchronized :: "Machine \<Rightarrow> bool"
where
	"fmusSynchronized M \<equiv> 
	\<comment>\<open>User defined body of fmusSynchronized.\<close>
	((vdm_card { (time\<^sub>F\<^sub>M\<^sub>U (fmu)) | fmu .  ((fmu \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))))  }) = (1::VDMNat1))"

	
\<comment>\<open>VDM source: calculateRelevantFMUs: (Machine * set of (Name) * set of (Name) * set of (FMURef) -> set of (Name))
	calculateRelevantFMUs(M, relevantFMUs, notRelevantFMUs, clocks) ==
let addedFMUs:set of (Name) = ({(clock.name) | clock in set clocks} union {((M.clockConnections)(con).name) | con in set (dom (M.clockConnections)) & (((con.name) in set relevantFMUs) and (((M.clockConnections)(con).name) in set notRelevantFMUs))}) in (if (addedFMUs = {})
then relevantFMUs
else calculateRelevantFMUs(M, (relevantFMUs union addedFMUs), (notRelevantFMUs \ addedFMUs), clocks))
	pre ((relevantFMUs inter notRelevantFMUs) = {})
	post (({(clock.name) | clock in set clocks} subset RESULT) and (RESULT subset (dom (M.fmus))))
	measure (card notRelevantFMUs)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 875:5\<close>

\<comment>\<open>VDM source: pre_calculateRelevantFMUs: (Machine * set of (Name) * set of (Name) * set of (FMURef) +> bool)
	pre_calculateRelevantFMUs(M, relevantFMUs, notRelevantFMUs, clocks) ==
((relevantFMUs inter notRelevantFMUs) = {})\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 884:48\<close>
definition
	pre_calculateRelevantFMUs :: "Machine\<Rightarrow> Name VDMSet\<Rightarrow> Name VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"pre_calculateRelevantFMUs M  relevantFMUs  notRelevantFMUs  clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculateRelevantFMUs` specification.\<close>
		(inv_Machine M  \<and>  (inv_VDMSet' (inv_Name) relevantFMUs)  \<and>  (inv_VDMSet' (inv_Name) notRelevantFMUs)  \<and>  (inv_VDMSet' inv_FMURef  clocks))  \<and> 
		\<comment>\<open>User defined body of pre_calculateRelevantFMUs.\<close>
		((relevantFMUs \<inter> notRelevantFMUs) = {})"


\<comment>\<open>VDM source: post_calculateRelevantFMUs: (Machine * set of (Name) * set of (Name) * set of (FMURef) * set of (Name) +> bool)
	post_calculateRelevantFMUs(M, relevantFMUs, notRelevantFMUs, clocks, RESULT) ==
(({(clock.name) | clock in set clocks} subset RESULT) and (RESULT subset (dom (M.fmus))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 886:13\<close>
definition
	post_calculateRelevantFMUs :: "Machine\<Rightarrow> Name VDMSet\<Rightarrow> Name VDMSet\<Rightarrow> FMURef VDMSet\<Rightarrow> Name VDMSet \<Rightarrow> bool"
where
	"post_calculateRelevantFMUs M  relevantFMUs  notRelevantFMUs  clocks  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_calculateRelevantFMUs` specification.\<close>
		(inv_Machine M  \<and>  (inv_VDMSet' (inv_Name) relevantFMUs)  \<and>  (inv_VDMSet' (inv_Name) notRelevantFMUs)  \<and>  (inv_VDMSet' inv_FMURef  clocks)  \<and>  (inv_VDMSet' (inv_Name) RESULT))  \<and> 
		\<comment>\<open>User defined body of post_calculateRelevantFMUs.\<close>
		(({ (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock)) | clock .  ((clock \<in>clocks))  } \<subseteq> RESULT) \<and> (RESULT \<subseteq> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (M)))))"

definition
	calculateRelevantFMUs :: "Machine\<Rightarrow> Name VDMSet\<Rightarrow> Name VDMSet\<Rightarrow> FMURef VDMSet \<Rightarrow> Name VDMSet"
where
	"calculateRelevantFMUs M  relevantFMUs  notRelevantFMUs  clocks \<equiv> 
	\<comment>\<open>User defined body of calculateRelevantFMUs.\<close>
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

	
\<comment>\<open>VDM source: solveSystemOfEquations: (Importer -> Importer)
	solveSystemOfEquations(I) ==
(if (((I.activeEquations) \ (I.calculatedEquations)) = {})
then I
else let clockActions:set of (Action) = ({mk_Action(<setC>, ((I.scenario).fmus)((clock.name)), (clock.ref)) | clock in set (I.relevantInputClocks)} union {mk_Action(<getC>, ((I.scenario).fmus)((clock.name)), (clock.ref)) | clock in set (I.relevantOutputClocks)}) in (if ((clockActions <> {}) and ({a | a in set clockActions & activatedAction(I, a)} <> {}))
then let clockAction in set {a | a in set clockActions & activatedAction(I, a)} in solveSystemOfEquations(runAction(I, clockAction))
else let portActions:set of (Action) = ({mk_Action(<set>, ((I.scenario).fmus)((inputLF.name)), (inputLF.ref)) | inputLF in set ((I.activeEquations) \ (I.calculatedEquations))} union {mk_Action(<get>, ((I.scenario).fmus)((outputLF.name)), (outputLF.ref)) | outputLF in set ((I.activeEquations) \ (I.calculatedEquations))}) in let portAction in set {a | a in set portActions & activatedAction(I, a)} in solveSystemOfEquations(runAction(I, portAction))))
	measure ((card (I.readyEquations)) + (card ((I.activeEquations) \ (I.calculatedEquations))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 895:1\<close>

\<comment>\<open>VDM source: pre_solveSystemOfEquations: (Importer +> bool)
	pre_solveSystemOfEquations(I) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 895:1\<close>
definition
	pre_solveSystemOfEquations :: "Importer \<Rightarrow> bool"
where
	"pre_solveSystemOfEquations I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_solveSystemOfEquations` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_solveSystemOfEquations: (Importer * Importer +> bool)
	post_solveSystemOfEquations(I, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 895:1\<close>
definition
	post_solveSystemOfEquations :: "Importer\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_solveSystemOfEquations I  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_solveSystemOfEquations` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)"

definition
	solveSystemOfEquations :: "Importer \<Rightarrow> Importer"
where
	"solveSystemOfEquations I \<equiv> 
	\<comment>\<open>User defined body of solveSystemOfEquations.\<close>
	(
		if ((((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) = {})) then
		(I)
		else
		((
		let 
(clockActions::Action VDMSet) = ({ \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_setC , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock))\<rparr> | clock .  ((clock \<in>(relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))  } \<union> { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_getC , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (clock))\<rparr> | clock .  ((clock \<in>(relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))  })
		in
			(if ((inv_VDMSet' inv_Action  clockActions)) then
			(
		if (((clockActions \<noteq> {}) \<and> ({ a .   ((a \<in>clockActions))  \<and> (activatedAction I  a) } \<noteq> {}))) then
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (solveSystemOfEquations (runAction I  clockAction)) | clockAction .  ((clockAction \<in>{ a .   ((a \<in>clockActions))  \<and> (activatedAction I  a) }))  })))
		else
		((
		let 
(portActions::Action VDMSet) = ({ \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_set , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (inputLF))\<rparr> | inputLF .  ((inputLF \<in>((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  } \<union> { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_get , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF)))), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (outputLF))\<rparr> | outputLF .  ((outputLF \<in>((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  })
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

	
\<comment>\<open>VDM source: eventIteration: (Importer * set of (Name) -> Importer)
	eventIteration(I, relevantFMUs) ==
let I1:Importer = solveSystemOfEquations(I) in let I2:Importer = updateDiscreteState(I1, relevantFMUs) in updateSchedule(I2, relevantFMUs, {<tunable>, <changing>, <countdown>})
	pre (fmusSynchronized((I.scenario)) and (forall fmu in set (rng ((I.scenario).fmus)) & ((fmu.mode) = <EVENT>)))
	post (forall fmu in set (rng ((I.scenario).fmus)) & (((fmu.mode) = <EVENT>) and (((I.activeEquations) \ (I.calculatedEquations)) = {})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 913:1\<close>

\<comment>\<open>VDM source: pre_eventIteration: (Importer * set of (Name) +> bool)
	pre_eventIteration(I, relevantFMUs) ==
(fmusSynchronized((I.scenario)) and (forall fmu in set (rng ((I.scenario).fmus)) & ((fmu.mode) = <EVENT>)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 938:9\<close>
definition
	pre_eventIteration :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> bool"
where
	"pre_eventIteration I  relevantFMUs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_eventIteration` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) relevantFMUs))  \<and> 
		\<comment>\<open>User defined body of pre_eventIteration.\<close>
		((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_EVENT )))"


\<comment>\<open>VDM source: post_eventIteration: (Importer * set of (Name) * Importer +> bool)
	post_eventIteration(I, relevantFMUs, RESULT) ==
(forall fmu in set (rng ((I.scenario).fmus)) & (((fmu.mode) = <EVENT>) and (((I.activeEquations) \ (I.calculatedEquations)) = {})))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 939:10\<close>
definition
	post_eventIteration :: "Importer\<Rightarrow> Name VDMSet\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_eventIteration I  relevantFMUs  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_eventIteration` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) relevantFMUs)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_eventIteration.\<close>
		(\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_EVENT ) \<and> (((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) = {})))"

definition
	eventIteration :: "Importer\<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"eventIteration I  relevantFMUs \<equiv> 
	\<comment>\<open>User defined body of eventIteration.\<close>
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
			(updateSchedule I2  relevantFMUs  {Interval.U_tunable , Interval.U_changing , Interval.U_countdown })
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
\<comment>\<open>VDM source: clockedSimulationAlgorithm: (Importer * set of (FMURef) -> Importer)
	clockedSimulationAlgorithm(I, clocks) ==
let relevantFMUs:set of (Name) = calculateRelevantFMUs((I.scenario), (I.fmusWithEvent), ((dom ((I.scenario).fmus)) \ (I.fmusWithEvent)), clocks) in let I1:Importer = enterEventMode(I, relevantFMUs) in let I2:Importer = activateClocks(I1, clocks) in let I3:Importer = eventIteration(I2, relevantFMUs) in (if ((I3.fmusWithEvent) <> {})
then enterStepMode(I3, relevantFMUs)
else clockedSimulationAlgorithm(I, clocks))
	pre (fmusSynchronized((I.scenario)) and (forall fmu in set (rng ((I.scenario).fmus)) & (((fmu.mode) = <STEP>) and (((I.fmusWithEvent) <> {}) or (clocks <> {})))))
	post (fmusSynchronized((I.scenario)) and (forall fmu in set (rng ((I.scenario).fmus)) & ((fmu.mode) = <STEP>)))
	measure not yet specified\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 948:5\<close>

\<comment>\<open>VDM source: pre_clockedSimulationAlgorithm: (Importer * set of (FMURef) +> bool)
	pre_clockedSimulationAlgorithm(I, clocks) ==
(fmusSynchronized((I.scenario)) and (forall fmu in set (rng ((I.scenario).fmus)) & (((fmu.mode) = <STEP>) and (((I.fmusWithEvent) <> {}) or (clocks <> {})))))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 978:9\<close>
definition
	pre_clockedSimulationAlgorithm :: "Importer\<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"pre_clockedSimulationAlgorithm I  clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_clockedSimulationAlgorithm` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_FMURef  clocks))  \<and> 
		\<comment>\<open>User defined body of pre_clockedSimulationAlgorithm.\<close>
		((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . (((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_STEP ) \<and> (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)) \<noteq> {}) \<or> (clocks \<noteq> {})))))"


\<comment>\<open>VDM source: post_clockedSimulationAlgorithm: (Importer * set of (FMURef) * Importer +> bool)
	post_clockedSimulationAlgorithm(I, clocks, RESULT) ==
(fmusSynchronized((I.scenario)) and (forall fmu in set (rng ((I.scenario).fmus)) & ((fmu.mode) = <STEP>)))\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 981:9\<close>
definition
	post_clockedSimulationAlgorithm :: "Importer\<Rightarrow> FMURef VDMSet\<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_clockedSimulationAlgorithm I  clocks  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_clockedSimulationAlgorithm` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_FMURef  clocks)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_clockedSimulationAlgorithm.\<close>
		((fmusSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))) \<and> (\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))))  . ((mode\<^sub>F\<^sub>M\<^sub>U (fmu)) = FMUModeLF.U_STEP )))"

definition
	clockedSimulationAlgorithm :: "Importer\<Rightarrow> FMURef VDMSet \<Rightarrow> Importer"
where
	"clockedSimulationAlgorithm I  clocks \<equiv> 
	\<comment>\<open>User defined body of clockedSimulationAlgorithm.\<close>
	(
		let 
(relevantFMUs::Name VDMSet) = (calculateRelevantFMUs (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))  (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))  ((dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I))))) - (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (I)))  clocks)
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

	
\<comment>\<open>VDM source: calculateSchedule: (FMU * set of (Ref) * map (FMURef) to (real) -> map (FMURef) to (real))
	calculateSchedule(fmu, clocks, schedule) ==
(if (clocks = {})
then schedule
else let clock in set clocks in let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in let n:RealNaNLF = next_tm(fmu, clock), S1:map (FMURef) to (real) = (schedule ++ (if is_(n, real)
then {fmuRef |-> next_tm(fmu, clock)}
else {|->})) in calculateSchedule(fmu, (clocks \ {clock}), S1))
	pre let cref:set of (Ref) = {(c.ref) | c in set (fmu.clocks) & (((c.type) = <inputLF>) and ((c.interval) <> <triggered>))} in (clocks subset cref)
	measure (card clocks)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 985:1\<close>

\<comment>\<open>VDM source: pre_calculateSchedule: (FMU * set of (Ref) * map (FMURef) to (real) +> bool)
	pre_calculateSchedule(fmu, clocks, schedule) ==
let cref:set of (Ref) = {(c.ref) | c in set (fmu.clocks) & (((c.type) = <inputLF>) and ((c.interval) <> <triggered>))} in (clocks subset cref)\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 1004:1\<close>
definition
	pre_calculateSchedule :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> (FMURef \<rightharpoonup> VDMReal) \<Rightarrow> bool"
where
	"pre_calculateSchedule fmu  clocks  schedule \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculateSchedule` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_Map inv_FMURef  (inv_VDMReal) schedule))  \<and> 
		\<comment>\<open>User defined body of pre_calculateSchedule.\<close>
		(
		let 
(cref::Ref VDMSet) = { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U (fmu))))  \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) = IOLF.U_inputLF ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k (c)) \<noteq> Interval.U_triggered )) }
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) cref)) then
			(clocks \<subseteq> cref)
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_calculateSchedule: (FMU * set of (Ref) * map (FMURef) to (real) * map (FMURef) to (real) +> bool)
	post_calculateSchedule(fmu, clocks, schedule, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (./src/test/resources/real/Clocks.vdmsl) at line 985:1\<close>
definition
	post_calculateSchedule :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> (FMURef \<rightharpoonup> VDMReal)\<Rightarrow> (FMURef \<rightharpoonup> VDMReal) \<Rightarrow> bool"
where
	"post_calculateSchedule fmu  clocks  schedule  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_calculateSchedule` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_Map inv_FMURef  (inv_VDMReal) schedule)  \<and>  (inv_Map inv_FMURef  (inv_VDMReal) RESULT))"

definition
	calculateSchedule :: "FMU\<Rightarrow> Ref VDMSet\<Rightarrow> (FMURef \<rightharpoonup> VDMReal) \<Rightarrow> (FMURef \<rightharpoonup> VDMReal)"
where
	"calculateSchedule fmu  clocks  schedule \<equiv> 
	\<comment>\<open>User defined body of calculateSchedule.\<close>
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
		if (isTest (n) (inv_VDMReal)) then
		([fmuRef\<mapsto>(next_tm fmu  clock)])
		else
		([])))
		in
			(if (((inv_RealNaNLF ))n) \<and> 
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