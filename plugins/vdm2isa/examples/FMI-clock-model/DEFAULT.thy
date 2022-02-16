(* VDM to Isabelle Translation @2022-02-16T12:08:47.776542Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk


files = [Clocks.vdmsl, Importer.vdmsl, Validation.vdmsl, scenario.vdmsl]
*)
theory DEFAULT
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Time = compose Time of r:real, i:nat end
	inv t == ((t.r) >= 0)
	eq a = b == (((a.r) = (b.r)) and ((a.i) = (b.i)))
	ord a < b == (((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 34:5\<close>
record Time = 
	r\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMReal"
	i\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMNat"

term " r\<^sub>T\<^sub>i\<^sub>m\<^sub>e t"
\<comment>\<open>VDM source: inv_Time: (Time +> bool)
	inv_Time(t) ==
((t.r) >= 0)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 37:9\<close>
definition
	inv_Time :: "Time \<Rightarrow> bool"
where
	"inv_Time t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Time` specification.\<close>
		( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e t))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e t))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Time.\<close>
		((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e t) \<ge> (0::VDMNat))"
 

\<comment>\<open>VDM source: eq_Time: (Time * Time +> bool)
	eq_Time(a, b) ==
(((a.r) = (b.r)) and ((a.i) = (b.i)))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 39:8\<close>
definition
	eq_Time :: "Time \<Rightarrow> Time \<Rightarrow> bool"
where
	"eq_Time a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of eq_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)))"
 

\<comment>\<open>VDM source: ord_Time: (Time * Time +> bool)
	ord_Time(a, b) ==
(((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 40:9\<close>
definition
	ord_Time :: "Time \<Rightarrow> Time \<Rightarrow> bool"
where
	"ord_Time a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of ord_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) < (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<or> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) < (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e b))))"
 
lemmas inv_Time_defs = inv_Time_def inv_VDMNat_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: Interval = (<calculated> | <changing> | <constant> | <countdown> | <fixed> | <triggered> | <tunable>)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 46:5\<close>
datatype Interval = U_calculated  | 
		 U_changing  | 
		 U_constant  | 
		 U_countdown  | 
		 U_fixed  | 
		 U_triggered  | 
		 U_tunable 
	

\<comment>\<open>VDM source: inv_Interval: (Interval +> bool)
	inv_Interval(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 46:5\<close>
definition
	inv_Interval :: "Interval \<Rightarrow> bool"
where
	"inv_Interval dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Interval` specification.\<close>
		((((inv_True dummy0))))"
 
lemmas inv_Interval_defs = inv_Interval_def inv_True_def 


	
	
\<comment>\<open>VDM source: FMUMode = (<DONE> | <EVENT> | <INIT> | <STEP>)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 48:5\<close>
datatype FMUMode = U_DONE  | 
		 U_EVENT  | 
		 U_INIT  | 
		 U_STEP 
	

\<comment>\<open>VDM source: inv_FMUMode: (FMUMode +> bool)
	inv_FMUMode(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 48:5\<close>
definition
	inv_FMUMode :: "FMUMode \<Rightarrow> bool"
where
	"inv_FMUMode dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMUMode` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_FMUMode_defs = inv_FMUMode_def inv_True_def 


	
	
\<comment>\<open>VDM source: Contract = (<delayed> | <none> | <reactive>)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 50:5\<close>
datatype Contract = U_delayed  | 
		 U_none  | 
		 U_reactive 
	

\<comment>\<open>VDM source: inv_Contract: (Contract +> bool)
	inv_Contract(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 50:5\<close>
definition
	inv_Contract :: "Contract \<Rightarrow> bool"
where
	"inv_Contract dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Contract` specification.\<close>
		((((inv_True dummy0))))"
 
lemmas inv_Contract_defs = inv_Contract_def inv_True_def 


	
	
\<comment>\<open>VDM source: RealNaN = (<NaN> | real)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 52:5\<close>
datatype RealNaN = U_NaN  | 
		 U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_RealNaN: (RealNaN +> bool)
	inv_RealNaN(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 52:5\<close>
definition
	inv_RealNaN :: "RealNaN \<Rightarrow> bool"
where
	"inv_RealNaN dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_RealNaN` specification.\<close>
		(((case dummy0 of
		 RealNaN.U_NaN  \<Rightarrow> (inv_True dummy0)
		  | RealNaN.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 
lemmas inv_RealNaN_defs = inv_RealNaN_def inv_True_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: PortType = (<continous> | <discrete>)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 54:5\<close>
datatype PortType = U_continous  | 
		 U_discrete 
	

\<comment>\<open>VDM source: inv_PortType: (PortType +> bool)
	inv_PortType(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 54:5\<close>
definition
	inv_PortType :: "PortType \<Rightarrow> bool"
where
	"inv_PortType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_PortType` specification.\<close>
		((((inv_True dummy0))))"
 
lemmas inv_PortType_defs = inv_PortType_def inv_True_def 


	
	
\<comment>\<open>VDM source: Causality = (<input> | <output>)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 56:5\<close>
datatype Causality = U_input  | 
		 U_output 
	

\<comment>\<open>VDM source: inv_Causality: (Causality +> bool)
	inv_Causality(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 56:5\<close>
definition
	inv_Causality :: "Causality \<Rightarrow> bool"
where
	"inv_Causality dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Causality` specification.\<close>
		((((inv_True dummy0))))"
 
lemmas inv_Causality_defs = inv_Causality_def inv_True_def 


	
	
\<comment>\<open>VDM source: ActionType = (<get> | <getC> | <set> | <setC> | <step>)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 60:5\<close>
datatype ActionType = U_get  | 
		 U_getC  | 
		 U_set  | 
		 U_setC  | 
		 U_step 
	

\<comment>\<open>VDM source: inv_ActionType: (ActionType +> bool)
	inv_ActionType(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 60:5\<close>
definition
	inv_ActionType :: "ActionType \<Rightarrow> bool"
where
	"inv_ActionType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ActionType` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_ActionType_defs = inv_ActionType_def inv_True_def 


	
	
\<comment>\<open>VDM source: ValueType = (bool | real)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 62:5\<close>
datatype ValueType = U_bool "bool" | 
		 U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_ValueType: (ValueType +> bool)
	inv_ValueType(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 62:5\<close>
definition
	inv_ValueType :: "ValueType \<Rightarrow> bool"
where
	"inv_ValueType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ValueType` specification.\<close>
		(((case dummy0 of
		 ValueType.U_bool dummy0 \<Rightarrow> (inv_bool dummy0)
		  | ValueType.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"
 
lemmas inv_ValueType_defs = inv_VDMReal_def inv_ValueType_def inv_bool_def 


	
\<comment>\<open>VDM source: Name = seq1 of (char)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 82:5\<close>
type_synonym Name = "VDMChar VDMSeq1"

\<comment>\<open>VDM source: inv_Name: (Name +> bool)
	inv_Name(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 82:5\<close>
definition
	inv_Name :: "Name \<Rightarrow> bool"
where
	"inv_Name dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Name` specification.\<close>
		(((inv_VDMSeq1' (inv_VDMChar) dummy0)))"
 
lemmas inv_Name_defs = inv_Name_def inv_VDMChar_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


\<comment>\<open>VDM source: Ref = nat\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 77:5\<close>
type_synonym Ref = "VDMNat"
	
\<comment>\<open>VDM source: inv_Ref: (Ref +> bool)
	inv_Ref(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 77:5\<close>
definition
	inv_Ref :: "Ref \<Rightarrow> bool"
where
	"inv_Ref dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Ref` specification.\<close>
		(((inv_VDMNat dummy0)))"
 
lemmas inv_Ref_defs = inv_Ref_def inv_VDMNat_def 

\<comment>\<open>VDM source: Action = compose Action of actionType:ActionType, fmu:Name, port:Ref end
	ord a < b == ((a.port) < (b.port))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 67:5\<close>
record Action = 
	actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "ActionType"
		 
		 fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "Name"
		 
		 port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "Ref"
	

\<comment>\<open>VDM source: inv_Action: (Action +> bool)
	inv_Action(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 67:5\<close>
definition
	inv_Action :: "Action \<Rightarrow> bool"
where
	"inv_Action dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Action` specification.\<close>
		( (((inv_ActionType (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))) \<and> 
		 ((inv_Name (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))) \<and> 
		 ((inv_Ref (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))) ))"
 

\<comment>\<open>VDM source: ord_Action: (Action * Action +> bool)
	ord_Action(a, b) ==
((a.port) < (b.port))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 71:9\<close>
definition
	ord_Action :: "Action \<Rightarrow> Action \<Rightarrow> bool"
where
	"ord_Action a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Action` specification.\<close>
		(inv_Action a  \<and>  inv_Action b)  \<and> 
		\<comment>\<open>User defined body of ord_Action.\<close>
		((port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n a) < (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n b))"
 
lemmas inv_Action_defs = inv_Action_def inv_ActionType_def inv_Name_def inv_Ref_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


	
	



	
	
	


	
	
\<comment>\<open>VDM source: FMURef = compose FMURef of name:Name, ref:Ref end
	eq x = y == (((x.name) = (y.name)) and ((x.ref) = (y.ref)))
	ord a < b == ((a.ref) < (b.ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 87:5\<close>
record FMURef = 
	name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Name"
		 
		 ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Ref"
	

\<comment>\<open>VDM source: inv_FMURef: (FMURef +> bool)
	inv_FMURef(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 87:5\<close>
definition
	inv_FMURef :: "FMURef \<Rightarrow> bool"
where
	"inv_FMURef dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMURef` specification.\<close>
		( (((inv_Name (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0))) \<and> 
		 ((inv_Ref (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0))) ))"
 

\<comment>\<open>VDM source: eq_FMURef: (FMURef * FMURef +> bool)
	eq_FMURef(x, y) ==
(((x.name) = (y.name)) and ((x.ref) = (y.ref)))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 91:8\<close>
definition
	eq_FMURef :: "FMURef \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"eq_FMURef x   y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_FMURef` specification.\<close>
		(inv_FMURef x  \<and>  inv_FMURef y)  \<and> 
		\<comment>\<open>User defined body of eq_FMURef.\<close>
		(((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x) = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)) \<and> ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f x) = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f y)))"
 

\<comment>\<open>VDM source: ord_FMURef: (FMURef * FMURef +> bool)
	ord_FMURef(a, b) ==
((a.ref) < (b.ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 90:9\<close>
definition
	ord_FMURef :: "FMURef \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"ord_FMURef a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_FMURef` specification.\<close>
		(inv_FMURef a  \<and>  inv_FMURef b)  \<and> 
		\<comment>\<open>User defined body of ord_FMURef.\<close>
		((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f a) < (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f b))"
 
lemmas inv_FMURef_defs = inv_FMURef_def inv_Name_def inv_Ref_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


\<comment>\<open>VDM source: Value = compose Value of value:ValueType, time:Time end\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 105:5\<close>
record Value = 
	value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "ValueType"
		 
		 time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "Time"
	

\<comment>\<open>VDM source: inv_Value: (Value +> bool)
	inv_Value(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 105:5\<close>
definition
	inv_Value :: "Value \<Rightarrow> bool"
where
	"inv_Value dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Value` specification.\<close>
		( (((inv_ValueType (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0))) \<and> 
		 (inv_Time (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0)) ))"
 
lemmas inv_Value_defs = inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_Value_def inv_ValueType_def inv_bool_def 
	
	
\<comment>\<open>VDM source: Environment = map (Ref) to (Value)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 99:5\<close>
type_synonym Environment = "(Ref \<rightharpoonup> Value)"
	

\<comment>\<open>VDM source: inv_Environment: (Environment +> bool)
	inv_Environment(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 99:5\<close>
definition
	inv_Environment :: "Environment \<Rightarrow> bool"
where
	"inv_Environment dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Environment` specification.\<close>
		(((inv_Map (inv_Ref) inv_Value  dummy0)))"
 
lemmas inv_Environment_defs = inv_Environment_def inv_Map_defs inv_Ref_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_Value_def inv_ValueType_def inv_bool_def 


	
	


	
	
\<comment>\<open>VDM source: Equation = (Environment -> Environment)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 113:5\<close>
type_synonym Equation = "Environment \<Rightarrow> Environment"
	

\<comment>\<open>VDM source: inv_Equation: (Equation +> bool)
	inv_Equation(dummy0) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 113:5\<close>
definition
	inv_Equation :: "Equation \<Rightarrow> bool"
where
	"inv_Equation dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Equation` specification.\<close>
		(((inv_Lambda (inv_Environment) (inv_Environment)dummy0)))"

		 
lemmas inv_Equation_defs = inv_Environment_def inv_Equation_def inv_Lambda_def inv_Map_defs inv_Ref_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_Value_def inv_ValueType_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Variable = compose Variable of name:Name, ref:Ref, time:Time, causality:Causality, type:PortType, clocks:set of (Ref), dependsOn:set of (Ref), contract:Contract end
	inv var == ((((var.causality) = <output>) => ((var.contract) = <none>)) and ((((var.causality) = <input>) => ((var.dependsOn) = {})) and (((var.type) = <continous>) => ((var.clocks) = {}))))
	eq v1 = v2 == (((v1.name) = (v2.name)) and (((v1.ref) = (v2.ref)) and ((v1.causality) = (v2.causality))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 118:5\<close>
record Variable = 
	name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Name"
		 
		 ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref"
		 
		 time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Time"
		 
		 causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Causality"
		 
		 type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "PortType"
		 
		 clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref VDMSet"
		 
		 dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Ref VDMSet"
		 
		 contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e :: "Contract"
	

\<comment>\<open>VDM source: inv_Variable: (Variable +> bool)
	inv_Variable(var) ==
((((var.causality) = <output>) => ((var.contract) = <none>)) and ((((var.causality) = <input>) => ((var.dependsOn) = {})) and (((var.type) = <continous>) => ((var.clocks) = {}))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 127:9\<close>
definition
	inv_Variable :: "Variable \<Rightarrow> bool"
where
	"inv_Variable var \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Variable` specification.\<close>
		( (((inv_Name (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_Ref (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 (inv_Time (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var)) \<and> 
		 ((inv_Causality (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_PortType (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) \<and> 
		 ((inv_Contract (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Variable.\<close>
		((((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var) = Causality.U_output ) \<longrightarrow> ((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var) = Contract.U_none )) \<and> ((((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var) = Causality.U_input ) \<longrightarrow> ((dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var) = {})) \<and> (((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var) = PortType.U_continous ) \<longrightarrow> ((clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var) = {}))))"
 

\<comment>\<open>VDM source: eq_Variable: (Variable * Variable +> bool)
	eq_Variable(v1, v2) ==
(((v1.name) = (v2.name)) and (((v1.ref) = (v2.ref)) and ((v1.causality) = (v2.causality))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 131:8\<close>
definition
	eq_Variable :: "Variable \<Rightarrow> Variable \<Rightarrow> bool"
where
	"eq_Variable v1   v2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Variable` specification.\<close>
		(inv_Variable v1  \<and>  inv_Variable v2)  \<and> 
		\<comment>\<open>User defined body of eq_Variable.\<close>
		(((name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v1) = (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v2)) \<and> (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v1) = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v2)) \<and> ((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v1) = (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v2))))"
 
lemmas inv_Variable_defs = inv_Causality_def inv_Contract_def inv_Name_def inv_PortType_def inv_Ref_def inv_Time_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_Variable_def 


	
	
\<comment>\<open>VDM source: TimeBasedClock = compose TimeBasedClock of name:Name, shift:real, period:real, interval:Interval, master:FMURef end
	inv clock == (((clock.shift) >= 0.0) and (((clock.period) >= 0.0) and ((clock.interval) <> <triggered>)))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 135:5\<close>
record TimeBasedClock = 
	name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Name"
		 
		 shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "VDMReal"
		 
		 period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "VDMReal"
		 
		 interval\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Interval"
		 
		 master\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "FMURef"
	

\<comment>\<open>VDM source: inv_TimeBasedClock: (TimeBasedClock +> bool)
	inv_TimeBasedClock(clock) ==
(((clock.shift) >= 0.0) and (((clock.period) >= 0.0) and ((clock.interval) <> <triggered>)))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 141:9\<close>
definition
	inv_TimeBasedClock :: "TimeBasedClock \<Rightarrow> bool"
where
	"inv_TimeBasedClock clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TimeBasedClock` specification.\<close>
		( (((inv_Name (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_VDMReal (shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_VDMReal (period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_Interval (interval\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 (inv_FMURef (master\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock)) ))  \<and> 
		\<comment>\<open>User defined body of inv_TimeBasedClock.\<close>
		(((shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) \<ge> (0.0)) \<and> (((period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) \<ge> (0.0)) \<and> ((interval\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) \<noteq> Interval.U_triggered )))"

		
lemmas inv_TimeBasedClock_defs = inv_FMURef_def inv_Interval_def inv_Name_def inv_Ref_def inv_TimeBasedClock_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


	
	
\<comment>\<open>VDM source: Clock = compose Clock of name:Name, ref:Ref, type:Causality, interval:Interval, dependsOn:set of (Ref), equations:set of (Ref) end
	inv clock == ((((clock.type) = <output>) => ((clock.interval) = <triggered>)) and (((clock.type) = <input>) => ((clock.dependsOn) = {})))
	eq c1 = c2 == (((c1.name) = (c2.name)) and (((c1.ref) = (c2.ref)) and ((c1.type) = (c2.type))))
	ord c1 < c2 == ((c1.ref) < (c2.ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 149:5\<close>
record Clock = 
	name\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Name"
		 
		 ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref"
		 
		 type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Causality"
		 
		 interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Interval"
		 
		 dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref VDMSet"
		 
		 equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Ref VDMSet"
	

\<comment>\<open>VDM source: inv_Clock: (Clock +> bool)
	inv_Clock(clock) ==
((((clock.type) = <output>) => ((clock.interval) = <triggered>)) and (((clock.type) = <input>) => ((clock.dependsOn) = {})))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 156:9\<close>
definition
	inv_Clock :: "Clock \<Rightarrow> bool"
where
	"inv_Clock clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Clock` specification.\<close>
		( (((inv_Name (name\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_Ref (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_Causality (type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_Interval (interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) ))  \<and> 
		\<comment>\<open>User defined body of inv_Clock.\<close>
		((((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) = Causality.U_output ) \<longrightarrow> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) = Interval.U_triggered )) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) = Causality.U_input ) \<longrightarrow> ((dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) = {})))"

		

\<comment>\<open>VDM source: eq_Clock: (Clock * Clock +> bool)
	eq_Clock(c1, c2) ==
(((c1.name) = (c2.name)) and (((c1.ref) = (c2.ref)) and ((c1.type) = (c2.type))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 160:8\<close>
definition
	eq_Clock :: "Clock \<Rightarrow> Clock \<Rightarrow> bool"
where
	"eq_Clock c1   c2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Clock` specification.\<close>
		(inv_Clock c1  \<and>  inv_Clock c2)  \<and> 
		\<comment>\<open>User defined body of eq_Clock.\<close>
		(((name\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c1) = (name\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c2)) \<and> (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c1) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c2)) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c1) = (type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c2))))"

		

\<comment>\<open>VDM source: ord_Clock: (Clock * Clock +> bool)
	ord_Clock(c1, c2) ==
((c1.ref) < (c2.ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 159:9\<close>
definition
	ord_Clock :: "Clock \<Rightarrow> Clock \<Rightarrow> bool"
where
	"ord_Clock c1   c2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Clock` specification.\<close>
		(inv_Clock c1  \<and>  inv_Clock c2)  \<and> 
		\<comment>\<open>User defined body of ord_Clock.\<close>
		((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c1) < (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c2))"

		
lemmas inv_Clock_defs = inv_Causality_def inv_Clock_def inv_Interval_def inv_Name_def inv_Ref_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs 


	
	
\<comment>\<open>VDM source: FMU = compose FMU of id:nat, name:Name, clocks:set of (Clock), inputs:set of (Variable), outputs:set of (Variable), mode:FMUMode, time:Time, stepped:bool, maxStep:real, env:Environment, activeClocks:set of (Ref), activeEquations:set of (Equation) end
	inv fmu == let vars:set1 of (Variable) = ((fmu.inputs) union (fmu.outputs)) in let crefs:set of (Ref) = {(c.ref) | c in set (fmu.clocks)}, vrefs:set of (Ref) = {(v.ref) | v in set vars}, refs:set of (Ref) = (crefs union vrefs) in (((fmu.maxStep) >= 0.0) and (((card refs) = ((card (fmu.clocks)) + (card vars))) and (((dom (fmu.env)) subset refs) and (((fmu.activeClocks) subset crefs) and ((((fmu.mode) <> <EVENT>) => ((fmu.activeClocks) = {})) and ((((fmu.mode) <> <EVENT>) => ((fmu.activeEquations) = {})) and ((((fmu.mode) <> <EVENT>) => (((fmu.time).i) = 0)) and (forall var in set vars & ((var.clocks) subset crefs)))))))))
	ord fmu1 < fmu2 == ((fmu1.id) < (fmu2.id))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 168:5\<close>
record FMU = 
	id\<^sub>F\<^sub>M\<^sub>U :: "VDMNat"
		 
		 name\<^sub>F\<^sub>M\<^sub>U :: "Name"
		 
		 clocks\<^sub>F\<^sub>M\<^sub>U :: "Clock VDMSet"
		 
		 inputs\<^sub>F\<^sub>M\<^sub>U :: "Variable VDMSet"
		 
		 outputs\<^sub>F\<^sub>M\<^sub>U :: "Variable VDMSet"
		 
		 mode\<^sub>F\<^sub>M\<^sub>U :: "FMUMode"
		 
		 time\<^sub>F\<^sub>M\<^sub>U :: "Time"
		 
		 stepped\<^sub>F\<^sub>M\<^sub>U :: "bool"
		 
		 maxStep\<^sub>F\<^sub>M\<^sub>U :: "VDMReal"
		 
		 env\<^sub>F\<^sub>M\<^sub>U :: "Environment"
		 
		 activeClocks\<^sub>F\<^sub>M\<^sub>U :: "Ref VDMSet"
		 
		 activeEquations\<^sub>F\<^sub>M\<^sub>U :: "Equation VDMSet"
	

\<comment>\<open>VDM source: inv_FMU: (FMU +> bool)
	inv_FMU(fmu) ==
let vars:set1 of (Variable) = ((fmu.inputs) union (fmu.outputs)) in let crefs:set of (Ref) = {(c.ref) | c in set (fmu.clocks)}, vrefs:set of (Ref) = {(v.ref) | v in set vars}, refs:set of (Ref) = (crefs union vrefs) in (((fmu.maxStep) >= 0.0) and (((card refs) = ((card (fmu.clocks)) + (card vars))) and (((dom (fmu.env)) subset refs) and (((fmu.activeClocks) subset crefs) and ((((fmu.mode) <> <EVENT>) => ((fmu.activeClocks) = {})) and ((((fmu.mode) <> <EVENT>) => ((fmu.activeEquations) = {})) and ((((fmu.mode) <> <EVENT>) => (((fmu.time).i) = 0)) and (forall var in set vars & ((var.clocks) subset crefs)))))))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 181:9\<close>
definition
	inv_FMU :: "FMU \<Rightarrow> bool"
where
	"inv_FMU fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_FMU` specification.\<close>
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_Name (name\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_FMUMode (mode\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 (inv_Time (time\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> 
		 ((inv_VDMSet' (inv_Equation) (activeEquations\<^sub>F\<^sub>M\<^sub>U fmu))) ))  \<and> 
		\<comment>\<open>User defined body of inv_FMU.\<close>
		(
		let 
(vars::Variable VDMSet1) = ((inputs\<^sub>F\<^sub>M\<^sub>U fmu) \<union> (outputs\<^sub>F\<^sub>M\<^sub>U fmu))
		in
			(if ((inv_VDMSet1' inv_Variable  vars)) then
			(
		let 
(crefs::Ref VDMSet) = { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  }
		;
		
(vrefs::Ref VDMSet) = { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) | v .  ((v \<in>vars))  }
		;
		
(refs::Ref VDMSet) = (crefs \<union> vrefs)
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) crefs))
	 \<and> 
	((inv_VDMSet' ((inv_VDMNat)) vrefs))
	 \<and> 
	((inv_VDMSet' ((inv_VDMNat)) refs)) then
			(((maxStep\<^sub>F\<^sub>M\<^sub>U fmu) \<ge> (0.0)) \<and> (((vdm_card refs) = ((vdm_card (clocks\<^sub>F\<^sub>M\<^sub>U fmu)) + (vdm_card vars))) \<and> (((dom (env\<^sub>F\<^sub>M\<^sub>U fmu)) \<subseteq> refs) \<and> (((activeClocks\<^sub>F\<^sub>M\<^sub>U fmu) \<subseteq> crefs) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U fmu) \<noteq> FMUMode.U_EVENT ) \<longrightarrow> ((activeClocks\<^sub>F\<^sub>M\<^sub>U fmu) = {})) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U fmu) \<noteq> FMUMode.U_EVENT ) \<longrightarrow> ((activeEquations\<^sub>F\<^sub>M\<^sub>U fmu) = {})) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U fmu) \<noteq> FMUMode.U_EVENT ) \<longrightarrow> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) = (0::VDMNat))) \<and> (\<forall> var \<in> vars  . ((clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e var) \<subseteq> crefs)))))))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"
 

\<comment>\<open>VDM source: ord_FMU: (FMU * FMU +> bool)
	ord_FMU(fmu1, fmu2) ==
((fmu1.id) < (fmu2.id))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 207:13\<close>
definition
	ord_FMU :: "FMU \<Rightarrow> FMU \<Rightarrow> bool"
where
	"ord_FMU fmu1   fmu2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_FMU` specification.\<close>
		(inv_FMU fmu1  \<and>  inv_FMU fmu2)  \<and> 
		\<comment>\<open>User defined body of ord_FMU.\<close>
		((id\<^sub>F\<^sub>M\<^sub>U fmu1) < (id\<^sub>F\<^sub>M\<^sub>U fmu2))"
 
lemmas inv_FMU_defs = inv_Causality_def inv_Clock_def inv_Contract_def inv_Environment_def inv_Equation_def inv_FMU_def inv_FMUMode_def inv_Interval_def inv_Lambda_def inv_Map_defs inv_Name_def inv_PortType_def inv_Ref_def inv_Time_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_Value_def inv_ValueType_def inv_Variable_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Machine = compose Machine of fmus:map (Name) to (FMU), timeBasedClocks:set of (TimeBasedClock), connections:map (FMURef) to (FMURef), clockConnections:map (FMURef) to (FMURef), timedClockConnections:map (Name) to (set of (FMURef)) end
	inv m == ((forall srcRef in set (dom (m.connections)) & (((srcRef.name) in set (dom (m.fmus))) and let srcFMU:FMU = (m.fmus)((srcRef.name)), trgRef:FMURef = (m.connections)(srcRef) in ((exists [v in set (srcFMU.outputs)] & ((srcRef.ref) = (v.ref))) and (((trgRef.name) in set (dom (m.fmus))) and let trgFMU:FMU = (m.fmus)((trgRef.name)) in ((exists [v in set (trgFMU.inputs)] & ((trgRef.ref) = (v.ref))) and let output:Variable = derefOutput(srcFMU, (srcRef.ref)), input:Variable = derefInput(trgFMU, (trgRef.ref)) in ((output.type) = (input.type))))))) and ((forall fmuref in set (dom (m.clockConnections)) & (((fmuref.name) in set (dom (m.fmus))) and let fmu:FMU = (m.fmus)((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and (((v.type) = <output>) and ((v.interval) = <triggered>)))))) and ((forall fmuref in set (rng (m.clockConnections)) & (((fmuref.name) in set (dom (m.fmus))) and let fmu:FMU = (m.fmus)((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and (((v.type) = <input>) and ((v.interval) = <triggered>)))))) and ((((dom (m.clockConnections)) inter (dom (m.connections))) = {}) and ((((rng (m.clockConnections)) inter (rng (m.connections))) = {}) and (((dom (m.timedClockConnections)) = {(c.name) | c in set (m.timeBasedClocks)}) and (forall t in set (m.timeBasedClocks) & (((t.master) in set (m.timedClockConnections)((t.name))) and (forall c in set (dunion {c | c in set (rng (m.timedClockConnections))}) & let clock:Clock = derefClock((m.fmus)((c.name)), (c.ref)) in (((clock.interval) <> <triggered>) and ((clock.type) = <input>)))))))))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 213:5\<close>
record Machine = 
	fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(Name \<rightharpoonup> FMU)"
		 
		 timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "TimeBasedClock VDMSet"
		 
		 connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(FMURef \<rightharpoonup> FMURef)"
		 
		 clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(FMURef \<rightharpoonup> FMURef)"
		 
		 timedClockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(Name \<rightharpoonup> FMURef VDMSet)"
	

	
	
\<comment>\<open>VDM source: derefClock: (FMU * Ref -> Clock)
	derefClock(fmu, ref) ==
(iota c in set (fmu.clocks) & ((c.ref) = ref))
	pre (exists [c in set (fmu.clocks)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 347:5\<close>

\<comment>\<open>VDM source: pre_derefClock: (FMU * Ref +> bool)
	pre_derefClock(fmu, ref) ==
(exists [c in set (fmu.clocks)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 350:9\<close>
definition
	pre_derefClock :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_derefClock fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_derefClock` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_derefClock.\<close>
		(\<exists> c \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)  . ((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) = ref))"


\<comment>\<open>VDM source: post_derefClock: (FMU * Ref * Clock +> bool)
	post_derefClock(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 347:5\<close>
definition
	post_derefClock :: "FMU \<Rightarrow> Ref \<Rightarrow> Clock \<Rightarrow> bool"
where
	"post_derefClock fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_derefClock` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Clock RESULT)"

definition
	derefClock :: "FMU \<Rightarrow> Ref \<Rightarrow> Clock"
where
	"derefClock fmu   ref \<equiv> 
	\<comment>\<open>User defined body of derefClock.\<close>
	(THE c. (((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> ((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) = ref)))"

	
	
\<comment>\<open>VDM source: derefInput: (FMU * Ref -> Variable)
	derefInput(fmu, ref) ==
(iota c in set (fmu.inputs) & ((c.ref) = ref))
	pre (exists [c in set (fmu.inputs)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 355:5\<close>

\<comment>\<open>VDM source: pre_derefInput: (FMU * Ref +> bool)
	pre_derefInput(fmu, ref) ==
(exists [c in set (fmu.inputs)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 358:9\<close>
definition
	pre_derefInput :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_derefInput fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_derefInput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_derefInput.\<close>
		(\<exists> c \<in> (inputs\<^sub>F\<^sub>M\<^sub>U fmu)  . ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e c) = ref))"


\<comment>\<open>VDM source: post_derefInput: (FMU * Ref * Variable +> bool)
	post_derefInput(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 355:5\<close>
definition
	post_derefInput :: "FMU \<Rightarrow> Ref \<Rightarrow> Variable \<Rightarrow> bool"
where
	"post_derefInput fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_derefInput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Variable RESULT)"

definition
	derefInput :: "FMU \<Rightarrow> Ref \<Rightarrow> Variable"
where
	"derefInput fmu   ref \<equiv> 
	\<comment>\<open>User defined body of derefInput.\<close>
	(THE c. (((c \<in>(inputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e c) = ref)))"

	
	
\<comment>\<open>VDM source: derefOutput: (FMU * Ref -> Variable)
	derefOutput(fmu, ref) ==
(iota c in set (fmu.outputs) & ((c.ref) = ref))
	pre (exists [c in set (fmu.outputs)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 363:5\<close>

\<comment>\<open>VDM source: pre_derefOutput: (FMU * Ref +> bool)
	pre_derefOutput(fmu, ref) ==
(exists [c in set (fmu.outputs)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 366:9\<close>
definition
	pre_derefOutput :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_derefOutput fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_derefOutput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_derefOutput.\<close>
		(\<exists> c \<in> (outputs\<^sub>F\<^sub>M\<^sub>U fmu)  . ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e c) = ref))"


\<comment>\<open>VDM source: post_derefOutput: (FMU * Ref * Variable +> bool)
	post_derefOutput(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 363:5\<close>
definition
	post_derefOutput :: "FMU \<Rightarrow> Ref \<Rightarrow> Variable \<Rightarrow> bool"
where
	"post_derefOutput fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_derefOutput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Variable RESULT)"

definition
	derefOutput :: "FMU \<Rightarrow> Ref \<Rightarrow> Variable"
where
	"derefOutput fmu   ref \<equiv> 
	\<comment>\<open>User defined body of derefOutput.\<close>
	(THE c. (((c \<in>(outputs\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e c) = ref)))"

\<comment>\<open>VDM source: inv_Machine: (Machine +> bool)
	inv_Machine(m) ==
((forall srcRef in set (dom (m.connections)) & (((srcRef.name) in set (dom (m.fmus))) and let srcFMU:FMU = (m.fmus)((srcRef.name)), trgRef:FMURef = (m.connections)(srcRef) in ((exists [v in set (srcFMU.outputs)] & ((srcRef.ref) = (v.ref))) and (((trgRef.name) in set (dom (m.fmus))) and let trgFMU:FMU = (m.fmus)((trgRef.name)) in ((exists [v in set (trgFMU.inputs)] & ((trgRef.ref) = (v.ref))) and let output:Variable = derefOutput(srcFMU, (srcRef.ref)), input:Variable = derefInput(trgFMU, (trgRef.ref)) in ((output.type) = (input.type))))))) and ((forall fmuref in set (dom (m.clockConnections)) & (((fmuref.name) in set (dom (m.fmus))) and let fmu:FMU = (m.fmus)((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and (((v.type) = <output>) and ((v.interval) = <triggered>)))))) and ((forall fmuref in set (rng (m.clockConnections)) & (((fmuref.name) in set (dom (m.fmus))) and let fmu:FMU = (m.fmus)((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and (((v.type) = <input>) and ((v.interval) = <triggered>)))))) and ((((dom (m.clockConnections)) inter (dom (m.connections))) = {}) and ((((rng (m.clockConnections)) inter (rng (m.connections))) = {}) and (((dom (m.timedClockConnections)) = {(c.name) | c in set (m.timeBasedClocks)}) and (forall t in set (m.timeBasedClocks) & (((t.master) in set (m.timedClockConnections)((t.name))) and (forall c in set (dunion {c | c in set (rng (m.timedClockConnections))}) & let clock:Clock = derefClock((m.fmus)((c.name)), (c.ref)) in (((clock.interval) <> <triggered>) and ((clock.type) = <input>)))))))))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 219:9\<close>
definition
	inv_Machine :: "Machine \<Rightarrow> bool"
where
	"inv_Machine m \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Machine` specification.\<close>
		( (((inv_Map (inv_Name) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> 
		 ((inv_VDMSet' inv_TimeBasedClock  (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> 
		 ((inv_Map (inv_Name) (inv_VDMSet' inv_FMURef ) (timedClockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) )
      )  \<and> 
		\<comment>\<open>User defined body of inv_Machine.\<close>
		((\<forall> srcRef \<in> (dom (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> (
		let 
(srcFMU::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef))))
		;
		
(trgRef::FMURef) = (the(((connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m) srcRef)))
		in
			(if (inv_FMU srcFMU)
	 \<and> 
	(inv_FMURef trgRef) then
			((\<exists> v \<in> (outputs\<^sub>F\<^sub>M\<^sub>U srcFMU)  . ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef) = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v))) \<and> (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> (
		let 
(trgFMU::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef))))
		in
			(if (inv_FMU trgFMU) then
			((\<exists> v \<in> (inputs\<^sub>F\<^sub>M\<^sub>U trgFMU)  . ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef) = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v))) \<and> (
		let 
(output::Variable) = (derefOutput srcFMU   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef))
		;
		
(input::Variable) = (derefInput trgFMU   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef))
		in
			(if (inv_Variable output)
	 \<and> 
	(inv_Variable input) then
			((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e output) = (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e input))
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
		))) \<and> ((\<forall> fmuref \<in> (dom (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> (
		let 
(fmu::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref))))
		in
			(if (inv_FMU fmu) then
			(\<exists>
		v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)
		
		.
		(((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v)) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_output ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Interval.U_triggered ))))
		 else
			undefined
		)
		))) \<and> ((\<forall> fmuref \<in> (rng (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref) \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) \<and> (
		let 
(fmu::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref))))
		in
			(if (inv_FMU fmu) then
			(\<exists>
		v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)
		
		.
		(((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v)) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_input ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Interval.U_triggered ))))
		 else
			undefined
		)
		))) \<and> ((((dom (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m)) \<inter> (dom (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) = {}) \<and> ((((rng (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m)) \<inter> (rng (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))) = {}) \<and> (((dom (timedClockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m)) = { (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>(timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m)))  }) \<and> (\<forall> t \<in> (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m)  . (((master\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k t) \<in> the((timedClockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m) (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k t))) \<and> (\<forall> c \<in> (\<Union> { c .   ((c \<in>(rng (timedClockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m))))  })  . (
		let 
(clock::Clock) = (derefClock (the((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e m) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f c)))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f c))
		in
			(if (inv_Clock clock) then
			(((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) \<noteq> Interval.U_triggered ) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) = Causality.U_input ))
		 else
			undefined
		)
		))))))))))"
 
lemmas inv_Machine_defs = inv_Causality_def inv_Clock_def inv_Contract_def inv_Environment_def inv_Equation_def inv_FMU_def inv_FMUMode_def inv_FMURef_def inv_Interval_def inv_Lambda_def inv_Machine_def inv_Map_def inv_Map_defs inv_Name_def inv_PortType_def inv_Ref_def inv_Time_def inv_TimeBasedClock_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_Value_def inv_ValueType_def inv_Variable_def inv_bool_def 


	
	
\<comment>\<open>VDM source: set_m: (FMU * Ref * Value +> FMU)
	set_m(fmu, ref, val) ==
mu(fmu, env |-> ((fmu.env) ++ {ref |-> val}))
	pre preSet(fmu, ref)
	post (((RESULT.mode) = (fmu.mode)) and (((RESULT.time) = (fmu.time)) and ((RESULT.inputs) = (fmu.inputs))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 265:5\<close>

\<comment>\<open>VDM source: pre_set_m: (FMU * Ref * Value +> bool)
	pre_set_m(fmu, ref, val) ==
preSet(fmu, ref)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 269:9\<close>
definition
	pre_set_m :: "FMU \<Rightarrow> Ref \<Rightarrow> Value \<Rightarrow> bool"
where
	"pre_set_m fmu   ref   val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_set_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Value val)  \<and> 
		\<comment>\<open>User defined body of pre_set_m.\<close>
		(preSet fmu   ref)"


\<comment>\<open>VDM source: post_set_m: (FMU * Ref * Value * FMU +> bool)
	post_set_m(fmu, ref, val, RESULT) ==
(((RESULT.mode) = (fmu.mode)) and (((RESULT.time) = (fmu.time)) and ((RESULT.inputs) = (fmu.inputs))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 271:5\<close>
definition
	post_set_m :: "FMU \<Rightarrow> Ref \<Rightarrow> Value \<Rightarrow> FMU \<Rightarrow> bool"
where
	"post_set_m fmu   ref   val   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_set_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_Value val  \<and>  inv_FMU RESULT)  \<and> 
		\<comment>\<open>User defined body of post_set_m.\<close>
		(((mode\<^sub>F\<^sub>M\<^sub>U RESULT) = (mode\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>F\<^sub>M\<^sub>U RESULT)   (time\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> ((inputs\<^sub>F\<^sub>M\<^sub>U RESULT) = (inputs\<^sub>F\<^sub>M\<^sub>U fmu))))"

definition
	set_m :: "FMU \<Rightarrow> Ref \<Rightarrow> Value \<Rightarrow> FMU"
where
	"set_m fmu   ref   val \<equiv> 
	\<comment>\<open>User defined body of set_m.\<close>
	(fmu)\<lparr>env\<^sub>F\<^sub>M\<^sub>U := ((env\<^sub>F\<^sub>M\<^sub>U fmu) \<dagger> [ref\<mapsto>val])\<rparr>"

	
	
\<comment>\<open>VDM source: get_m: (FMU * Ref +> (FMU * Value))
	get_m(fmu, ref) ==
mk_(fmu, (fmu.env)(ref))
	pre preGet(fmu, ref)
	post (((fmu.mode) <> <EVENT>) => fmusNotAffected({(RESULT.#1)}, {fmu}))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 274:5\<close>

\<comment>\<open>VDM source: pre_get_m: (FMU * Ref +> bool)
	pre_get_m(fmu, ref) ==
preGet(fmu, ref)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 278:9\<close>
definition
	pre_get_m :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_get_m fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_get_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_get_m.\<close>
		(preGet fmu   ref)"


\<comment>\<open>VDM source: post_get_m: (FMU * Ref * (FMU * Value) +> bool)
	post_get_m(fmu, ref, RESULT) ==
(((fmu.mode) <> <EVENT>) => fmusNotAffected({(RESULT.#1)}, {fmu}))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 279:30\<close>
definition
	post_get_m :: "FMU \<Rightarrow> Ref \<Rightarrow> (FMU \<times> Value) \<Rightarrow> bool"
where
	"post_get_m fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_get_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 inv_Value (snd RESULT)
		))  \<and> 
		\<comment>\<open>User defined body of post_get_m.\<close>
		(((mode\<^sub>F\<^sub>M\<^sub>U fmu) \<noteq> FMUMode.U_EVENT ) \<longrightarrow> (fmusNotAffected {(fst (RESULT))}   {fmu}))"

definition
	get_m :: "FMU \<Rightarrow> Ref \<Rightarrow> (FMU \<times> Value)"
where
	"get_m fmu   ref \<equiv> 
	\<comment>\<open>User defined body of get_m.\<close>
	(fmu , ((env\<^sub>F\<^sub>M\<^sub>U fmu) ref))"

	
	
\<comment>\<open>VDM source: set_cm: (FMU * Ref * bool +> FMU)
	set_cm(fmu, ref, val) ==
mu(fmu, env |-> ((fmu.env) ++ {ref |-> mk_Value(val, (fmu.time))}), activeClocks |-> (if val
then ((fmu.activeClocks) union {ref})
else ((fmu.activeClocks) \ {ref})))
	pre preSetC(fmu, ref, val)
	post (val <=> (ref in set (RESULT.activeClocks)))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 281:5\<close>

\<comment>\<open>VDM source: pre_set_cm: (FMU * Ref * bool +> bool)
	pre_set_cm(fmu, ref, val) ==
preSetC(fmu, ref, val)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 286:9\<close>
definition
	pre_set_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_set_cm fmu   ref   val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_set_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  (inv_bool val))  \<and> 
		\<comment>\<open>User defined body of pre_set_cm.\<close>
		(preSetC fmu   ref   val)"


\<comment>\<open>VDM source: post_set_cm: (FMU * Ref * bool * FMU +> bool)
	post_set_cm(fmu, ref, val, RESULT) ==
(val <=> (ref in set (RESULT.activeClocks)))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 287:14\<close>
definition
	post_set_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> FMU \<Rightarrow> bool"
where
	"post_set_cm fmu   ref   val   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_set_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  (inv_bool val)  \<and>  inv_FMU RESULT)  \<and> 
		\<comment>\<open>User defined body of post_set_cm.\<close>
		(val \<longleftrightarrow> (ref \<in> (activeClocks\<^sub>F\<^sub>M\<^sub>U RESULT)))"

definition
	set_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> FMU"
where
	"set_cm fmu   ref   val \<equiv> 
	\<comment>\<open>User defined body of set_cm.\<close>
	(fmu)\<lparr>env\<^sub>F\<^sub>M\<^sub>U := ((env\<^sub>F\<^sub>M\<^sub>U fmu) \<dagger> [ref\<mapsto>\<lparr>value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = ValueType.U_bool val, time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = (time\<^sub>F\<^sub>M\<^sub>U fmu)\<rparr>]), activeClocks\<^sub>F\<^sub>M\<^sub>U := (
		if (val) then
		(((activeClocks\<^sub>F\<^sub>M\<^sub>U fmu) \<union> {ref}))
		else
		(((activeClocks\<^sub>F\<^sub>M\<^sub>U fmu) - {ref})))\<rparr>"

	
	
\<comment>\<open>VDM source: get_cm: (FMU * Ref +> (FMU * Value))
	get_cm(fmu, ref) ==
mk_(fmu, (fmu.env)(ref))
	pre preGetC(fmu, ref)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 289:5\<close>

\<comment>\<open>VDM source: pre_get_cm: (FMU * Ref +> bool)
	pre_get_cm(fmu, ref) ==
preGetC(fmu, ref)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 292:9\<close>
definition
	pre_get_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_get_cm fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_get_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_get_cm.\<close>
		(preGetC fmu   ref)"


\<comment>\<open>VDM source: post_get_cm: (FMU * Ref * (FMU * Value) +> bool)
	post_get_cm(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 289:5\<close>
definition
	post_get_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> (FMU \<times> Value) \<Rightarrow> bool"
where
	"post_get_cm fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_get_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 inv_Value (snd RESULT)
		))"

definition
	get_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> (FMU \<times> Value)"
where
	"get_cm fmu   ref \<equiv> 
	\<comment>\<open>User defined body of get_cm.\<close>
	(fmu , ((env\<^sub>F\<^sub>M\<^sub>U fmu) ref))"

	
	
\<comment>\<open>VDM source: step_tm: (FMU * real +> (FMU * real * bool))
	step_tm(fmu, step) ==
let mk_(stepTaken, eventTriggered):(real * bool) = (if (step >= (fmu.maxStep))
then mk_((fmu.maxStep), true)
else mk_(step, false)) in let newTime:Time = mk_Time((((fmu.time).r) + stepTaken), ((fmu.time).i)) in let updatedFMU:FMU = mu(fmu, time |-> newTime, env |-> updateOutputs(fmu, newTime), stepped |-> true) in mk_(updatedFMU, stepTaken, eventTriggered)
	pre preStepT(fmu, step)
	post postStepT((RESULT.#1), (RESULT.#2), (RESULT.#3), fmu, step)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 294:5\<close>

\<comment>\<open>VDM source: pre_step_tm: (FMU * real +> bool)
	pre_step_tm(fmu, step) ==
preStepT(fmu, step)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 307:9\<close>
definition
	pre_step_tm :: "FMU \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"pre_step_tm fmu   step \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_step_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal step))  \<and> 
		\<comment>\<open>User defined body of pre_step_tm.\<close>
		(preStepT fmu   step)"


\<comment>\<open>VDM source: post_step_tm: (FMU * real * (FMU * real * bool) +> bool)
	post_step_tm(fmu, step, RESULT) ==
postStepT((RESULT.#1), (RESULT.#2), (RESULT.#3), fmu, step)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 308:10\<close>
definition
	post_step_tm :: "FMU \<Rightarrow> VDMReal \<Rightarrow> (FMU \<times> VDMReal \<times> bool) \<Rightarrow> bool"
where
	"post_step_tm fmu   step   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_step_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal step)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 (inv_VDMReal (fst (snd RESULT)))\<and>
		 (inv_bool (snd (snd RESULT)))
		))  \<and> 
		\<comment>\<open>User defined body of post_step_tm.\<close>
		(postStepT (fst (RESULT))   (fst (snd (RESULT)))   (snd (snd (RESULT)))   fmu   step)"

definition
	step_tm :: "FMU \<Rightarrow> VDMReal \<Rightarrow> (FMU \<times> VDMReal \<times> bool)"
where
	"step_tm fmu   step \<equiv> 
	\<comment>\<open>User defined body of step_tm.\<close>
	(
		let 
(stepTaken::VDMReal) = (
		if ((step \<ge> (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) then
		(((maxStep\<^sub>F\<^sub>M\<^sub>U fmu) , (True::\<bool>)))
		else
		((step , (False::\<bool>))));
(eventTriggered::bool) = (
		if ((step \<ge> (maxStep\<^sub>F\<^sub>M\<^sub>U fmu))) then
		(((maxStep\<^sub>F\<^sub>M\<^sub>U fmu) , (True::\<bool>)))
		else
		((step , (False::\<bool>))))
		in
			(if (
		((inv_VDMReal (fst dummy0))\<and>
		 (inv_bool (snd dummy0))
		)) then
			(
		let 
(newTime::Time) = \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) + stepTaken), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu))\<rparr>
		in
			(if (inv_Time newTime) then
			(
		let 
(updatedFMU::FMU) = (fmu)\<lparr>time\<^sub>F\<^sub>M\<^sub>U := newTime, env\<^sub>F\<^sub>M\<^sub>U := (updateOutputs fmu   newTime), stepped\<^sub>F\<^sub>M\<^sub>U := (True::\<bool>)\<rparr>
		in
			(if (inv_FMU updatedFMU) then
			(updatedFMU , stepTaken , eventTriggered)
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

	
	
\<comment>\<open>VDM source: step_e: (FMU +> (FMU * bool))
	step_e(fmu) ==
let updatedFMU:FMU = mu(fmu, time |-> mk_Time(((fmu.time).r), (((fmu.time).i) + 1)), activeClocks |-> {}) in mk_(updatedFMU, false)
	pre preStepE(fmu)
	post postStepE((RESULT.#1), fmu, (RESULT.#2))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 311:5\<close>

\<comment>\<open>VDM source: pre_step_e: (FMU +> bool)
	pre_step_e(fmu) ==
preStepE(fmu)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 318:9\<close>
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
postStepE((RESULT.#1), fmu, (RESULT.#2))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 319:10\<close>
definition
	post_step_e :: "FMU \<Rightarrow> (FMU \<times> bool) \<Rightarrow> bool"
where
	"post_step_e fmu   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_step_e` specification.\<close>
		(inv_FMU fmu  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 (inv_bool (snd RESULT))
		))  \<and> 
		\<comment>\<open>User defined body of post_step_e.\<close>
		(postStepE (fst (RESULT))   fmu   (snd (RESULT)))"

definition
	step_e :: "FMU \<Rightarrow> (FMU \<times> bool)"
where
	"step_e fmu \<equiv> 
	\<comment>\<open>User defined body of step_e.\<close>
	(
		let 
(updatedFMU::FMU) = (fmu)\<lparr>time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) + (1::VDMNat1))\<rparr>, activeClocks\<^sub>F\<^sub>M\<^sub>U := {}\<rparr>
		in
			(if (inv_FMU updatedFMU) then
			(updatedFMU , (False::\<bool>))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: next_tm: (FMU * Ref +> RealNaN)
	next_tm(fmu, ref) ==
not yet specified
	pre (exists [v in set (fmu.clocks)] & (((v.ref) = ref) and (((v.type) = <input>) and ((v.interval) in set {<tunable>, <changing>, <countdown>}))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 325:5\<close>

\<comment>\<open>VDM source: pre_next_tm: (FMU * Ref +> bool)
	pre_next_tm(fmu, ref) ==
(exists [v in set (fmu.clocks)] & (((v.ref) = ref) and (((v.type) = <input>) and ((v.interval) in set {<tunable>, <changing>, <countdown>}))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 328:9\<close>
definition
	pre_next_tm :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_next_tm fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_next_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_next_tm.\<close>
		(\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = ref) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_input ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) \<in> {Interval.U_tunable  , Interval.U_changing  , Interval.U_countdown }))))"


\<comment>\<open>VDM source: post_next_tm: (FMU * Ref * RealNaN +> bool)
	post_next_tm(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 325:5\<close>
definition
	post_next_tm :: "FMU \<Rightarrow> Ref \<Rightarrow> RealNaN \<Rightarrow> bool"
where
	"post_next_tm fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_next_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  (inv_RealNaN RESULT))"

definition
	next_tm :: "FMU \<Rightarrow> Ref \<Rightarrow> RealNaN"
where
	"next_tm fmu   ref \<equiv> 
	\<comment>\<open>User defined body of next_tm.\<close>
	undefined"

	
	
\<comment>\<open>VDM source: updateOutputs: (FMU * Time -> Environment)
	updateOutputs(fmu, time) ==
let outputRef:set of (Ref) = {(o.ref) | o in set (fmu.outputs)} in {oValue |-> calculate(oValue, (fmu.env), time) | oValue in set (dom (fmu.env)) & (oValue in set outputRef)}\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 335:5\<close>

\<comment>\<open>VDM source: pre_updateOutputs: (FMU * Time +> bool)
	pre_updateOutputs(fmu, time) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 335:5\<close>
definition
	pre_updateOutputs :: "FMU \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_updateOutputs fmu   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_updateOutputs` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time)"


\<comment>\<open>VDM source: post_updateOutputs: (FMU * Time * Environment +> bool)
	post_updateOutputs(fmu, time, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 335:5\<close>
definition
	post_updateOutputs :: "FMU \<Rightarrow> Time \<Rightarrow> Environment \<Rightarrow> bool"
where
	"post_updateOutputs fmu   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_updateOutputs` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time  \<and>  (inv_Environment RESULT))"

definition
	updateOutputs :: "FMU \<Rightarrow> Time \<Rightarrow> Environment"
where
	"updateOutputs fmu   time \<equiv> 
	\<comment>\<open>User defined body of updateOutputs.\<close>
	(
		let 
(outputRef::Ref VDMSet) = { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e o) | o .  ((o \<in>(outputs\<^sub>F\<^sub>M\<^sub>U fmu)))  }
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) outputRef)) then
			(\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ oValue .   (oValue \<in>(dom (env\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> (oValue \<in> outputRef) } 
		{ (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time) | (dummy0RANGE :: Value) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) )))  \<and> (oValue \<in> outputRef) } 
		((inv_VDMNat)) 
		 ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e Value) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e Value) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e Value))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e Value) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e Value))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e Value)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e Value)))) )) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Ref)   (dummy0RANGE :: Value) .
		(if ((((inv_VDMNat dummy0DOMAIN))))  \<and>  (( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<and>  ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: Value)  . ((( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> ((dummy0RANGE = (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: Value)  . ((( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> ((dummy0RANGE = (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: Value)  . ((( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> ((dummy0RANGE = (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: Value)  . ((( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> ((dummy0RANGE = (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: Value)  . ((( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> ((dummy0RANGE = (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: Value)  . ((( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> ((dummy0RANGE = (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: Value)  . ((( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> ((dummy0RANGE = (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) ) then
			(
		if ((\<exists> (dummy0RANGE :: Value)  . ((( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> ((dummy0RANGE = (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: Ref)   (dummy0RANGE :: Value) .
		(if ((((inv_VDMNat dummy0DOMAIN))))  \<and>  (( ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<and> (inv_bool (
		if ((\<exists> oValue \<in> (dom (env\<^sub>F\<^sub>M\<^sub>U fmu))  . ((oValue \<in> (dom (env\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> (oValue \<in> outputRef)))) then
		((True::\<bool>))
		else
		(undefined))) then
			(
		if ((\<exists> oValue \<in> (dom (env\<^sub>F\<^sub>M\<^sub>U fmu))  . ((oValue \<in> (dom (env\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> (oValue \<in> outputRef)))) then
		((True::\<bool>))
		else
		(undefined))
		 else
			undefined
		)
		))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: calculate: (Ref * Environment * Time -> Value)
	calculate(ref, env, time) ==
mk_Value((env(ref).value), time)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 340:5\<close>

\<comment>\<open>VDM source: pre_calculate: (Ref * Environment * Time +> bool)
	pre_calculate(ref, env, time) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 340:5\<close>
definition
	pre_calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_calculate ref   env   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_calculate` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time)"


\<comment>\<open>VDM source: post_calculate: (Ref * Environment * Time * Value +> bool)
	post_calculate(ref, env, time, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 340:5\<close>
definition
	post_calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> Value \<Rightarrow> bool"
where
	"post_calculate ref   env   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_calculate` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time  \<and>  inv_Value RESULT)"

definition
	calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> Value"
where
	"calculate ref   env   time \<equiv> 
	\<comment>\<open>User defined body of calculate.\<close>
	\<lparr>value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the((env ref)))), time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = time\<rparr>"


	
	
\<comment>\<open>VDM source: updateEnvironmentClock: (Importer * FMU * Ref * bool -> Importer)
	updateEnvironmentClock(I, fmu, clock, val) ==
let fmuref:FMURef = mk_FMURef((fmu.name), clock), activatedVariables:set of (FMURef) = createFMURefs(fmu, (dunion {(c.equations) | c in set (fmu.clocks) & (clock = (c.ref))})) in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmu.name) |-> fmu})), activeClocks |-> (if val
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
	post let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((val => (((I.activeClocks) subset (RESULT.activeClocks)) and (((RESULT.readyClocks) psubset (I.readyClocks)) and (((RESULT.inactiveClocks) psubset (I.inactiveClocks)) and (fmuRef in set (RESULT.activeClocks)))))) and ((not val) => (fmuRef in set (RESULT.inactiveClocks))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 372:5\<close>

\<comment>\<open>VDM source: pre_updateEnvironmentClock: (Importer * FMU * Ref * bool +> bool)
	pre_updateEnvironmentClock(I, fmu, clock, val) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 372:5\<close>
definition
	pre_updateEnvironmentClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_updateEnvironmentClock I   fmu   clock   val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_updateEnvironmentClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val))"


\<comment>\<open>VDM source: post_updateEnvironmentClock: (Importer * FMU * Ref * bool * Importer +> bool)
	post_updateEnvironmentClock(I, fmu, clock, val, RESULT) ==
let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((val => (((I.activeClocks) subset (RESULT.activeClocks)) and (((RESULT.readyClocks) psubset (I.readyClocks)) and (((RESULT.inactiveClocks) psubset (I.inactiveClocks)) and (fmuRef in set (RESULT.activeClocks)))))) and ((not val) => (fmuRef in set (RESULT.inactiveClocks))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 384:10\<close>
definition
	post_updateEnvironmentClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_updateEnvironmentClock I   fmu   clock   val   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_updateEnvironmentClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_updateEnvironmentClock.\<close>
		(
		let 
(fmuRef::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef fmuRef) then
			((val \<longrightarrow> (((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<subseteq> (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT) \<subset> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> (((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT) \<subset> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> (fmuRef \<in> (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))))) \<and> ((\<not> val) \<longrightarrow> (fmuRef \<in> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		 else
			undefined
		)
		)"

definition
	updateEnvironmentClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> Importer"
where
	"updateEnvironmentClock I   fmu   clock   val \<equiv> 
	\<comment>\<open>User defined body of updateEnvironmentClock.\<close>
	(
		let 
(fmuref::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		;
		
(activatedVariables::FMURef VDMSet) = (createFMURefs fmu   (\<Union> { (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> (clock = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c)) }))
		in
			(if (inv_FMURef fmuref)
	 \<and> 
	((inv_VDMSet' inv_FMURef  activatedVariables)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U fmu)\<mapsto>fmu])\<rparr>, activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> {fmuref}))
		else
		(((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - {fmuref}))), readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - {fmuref}))
		else
		((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))), inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - {fmuref}))
		else
		(((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> {fmuref}))), activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> activatedVariables))
		else
		(((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - activatedVariables))), readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (val) then
		(((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - activatedVariables))
		else
		((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))\<rparr>
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: calculateInput: (Importer * FMURef -> Importer)
	calculateInput(I, equation) ==
let I1:Importer = setPort(I, equation) in updateEnvironmentEquation(I1, ((I.scenario).fmus)((equation.name)), equation)
	pre let fmu:FMU = ((I.scenario).fmus)((equation.name)) in ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and (((fmu.mode) = <EVENT>) and preSetI(I, fmu, (equation.ref))))
	post let newFMU:FMU = ((RESULT.scenario).fmus)((equation.name)), oldFMU:FMU = ((I.scenario).fmus)((equation.name)) in (((newFMU.mode) = (oldFMU.mode)) and (((newFMU.time) = (oldFMU.time)) and (((newFMU.outputs) = (oldFMU.outputs)) and (fmusNotAffected((rng ({(equation.name)} <-: ((I.scenario).fmus))), (rng ({(equation.name)} <-: ((RESULT.scenario).fmus)))) and (equation in set (RESULT.calculatedEquations))))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 396:5\<close>

\<comment>\<open>VDM source: pre_calculateInput: (Importer * FMURef +> bool)
	pre_calculateInput(I, equation) ==
let fmu:FMU = ((I.scenario).fmus)((equation.name)) in ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and (((fmu.mode) = <EVENT>) and preSetI(I, fmu, (equation.ref))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 402:9\<close>
definition
	pre_calculateInput :: "Importer \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_calculateInput I   equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculateInput` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef equation)  \<and> 
		\<comment>\<open>User defined body of pre_calculateInput.\<close>
		(
		let 
(fmu::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		in
			(if (inv_FMU fmu) then
			((equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ) \<and> (preSetI I   fmu   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_calculateInput: (Importer * FMURef * Importer +> bool)
	post_calculateInput(I, equation, RESULT) ==
let newFMU:FMU = ((RESULT.scenario).fmus)((equation.name)), oldFMU:FMU = ((I.scenario).fmus)((equation.name)) in (((newFMU.mode) = (oldFMU.mode)) and (((newFMU.time) = (oldFMU.time)) and (((newFMU.outputs) = (oldFMU.outputs)) and (fmusNotAffected((rng ({(equation.name)} <-: ((I.scenario).fmus))), (rng ({(equation.name)} <-: ((RESULT.scenario).fmus)))) and (equation in set (RESULT.calculatedEquations))))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 407:5\<close>
definition
	post_calculateInput :: "Importer \<Rightarrow> FMURef \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_calculateInput I   equation   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_calculateInput` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef equation  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_calculateInput.\<close>
		(
		let 
(newFMU::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		;
		
(oldFMU::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		in
			(if (inv_FMU newFMU)
	 \<and> 
	(inv_FMU oldFMU) then
			(((mode\<^sub>F\<^sub>M\<^sub>U newFMU) = (mode\<^sub>F\<^sub>M\<^sub>U oldFMU)) \<and> (\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>F\<^sub>M\<^sub>U newFMU)   (time\<^sub>F\<^sub>M\<^sub>U oldFMU)) \<and> (((outputs\<^sub>F\<^sub>M\<^sub>U newFMU) = (outputs\<^sub>F\<^sub>M\<^sub>U oldFMU)) \<and> ((fmusNotAffected (rng ({(name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))   (rng ({(name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))) \<and> (equation \<in> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))))
		 else
			undefined
		)
		)"

definition
	calculateInput :: "Importer \<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"calculateInput I   equation \<equiv> 
	\<comment>\<open>User defined body of calculateInput.\<close>
	(
		let 
(I1::Importer) = (setPort I   equation)
		in
			(if (inv_Importer I1) then
			(updateEnvironmentEquation I1   ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))   equation)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: calculateOutput: (Importer * FMURef -> Importer)
	calculateOutput(I, equation) ==
let I1:Importer = getPort(I, equation) in updateEnvironmentEquation(I1, ((I.scenario).fmus)((equation.name)), equation)
	pre let fmu:FMU = ((I.scenario).fmus)((equation.name)) in ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and (((fmu.mode) = <EVENT>) and preGetI(I, fmu, (equation.ref))))
	post postVaraibleCalculation(equation, I, RESULT)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 420:5\<close>

\<comment>\<open>VDM source: pre_calculateOutput: (Importer * FMURef +> bool)
	pre_calculateOutput(I, equation) ==
let fmu:FMU = ((I.scenario).fmus)((equation.name)) in ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and (((fmu.mode) = <EVENT>) and preGetI(I, fmu, (equation.ref))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 426:9\<close>
definition
	pre_calculateOutput :: "Importer \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_calculateOutput I   equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculateOutput` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef equation)  \<and> 
		\<comment>\<open>User defined body of pre_calculateOutput.\<close>
		(
		let 
(fmu::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		in
			(if (inv_FMU fmu) then
			((equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ) \<and> (preGetI I   fmu   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_calculateOutput: (Importer * FMURef * Importer +> bool)
	post_calculateOutput(I, equation, RESULT) ==
postVaraibleCalculation(equation, I, RESULT)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 430:10\<close>
definition
	post_calculateOutput :: "Importer \<Rightarrow> FMURef \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_calculateOutput I   equation   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_calculateOutput` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef equation  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_calculateOutput.\<close>
		(postVaraibleCalculation equation   I   RESULT)"

definition
	calculateOutput :: "Importer \<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"calculateOutput I   equation \<equiv> 
	\<comment>\<open>User defined body of calculateOutput.\<close>
	(
		let 
(I1::Importer) = (getPort I   equation)
		in
			(if (inv_Importer I1) then
			(updateEnvironmentEquation I1   ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))   equation)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: updateEnvironmentEquation: (Importer * FMU * FMURef -> Importer)
	updateEnvironmentEquation(I, fmu, equation) ==
let triggeredClocks:set of (Clock) = {clock | clock in set (fmu.clocks) & ((equation.ref) in set (clock.dependsOn))} in let triggeredInputs:set of (FMURef) = {mk_FMURef((equation.name), (inputClock.ref)) | inputClock in set triggeredClocks & ((inputClock.type) <> <input>)}, triggeredOutputs:set of (FMURef) = {mk_FMURef((equation.name), (outputClock.ref)) | outputClock in set triggeredClocks & ((outputClock.type) <> <output>)} in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmu.name) |-> fmu})), calculatedEquations |-> ((I.calculatedEquations) union {equation}), relevantInputClocks |-> ((I.relevantInputClocks) union triggeredInputs), relevantOutputClocks |-> ((I.relevantOutputClocks) union triggeredOutputs))
	pre ((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and ((fmu.mode) = <EVENT>))
	post ((equation in set (RESULT.calculatedEquations)) and (((I.relevantInputClocks) subset (RESULT.relevantInputClocks)) and (((I.relevantOutputClocks) subset (RESULT.relevantOutputClocks)) and fmusNotAffected((rng ({(fmu.name)} <-: ((I.scenario).fmus))), (rng ({(fmu.name)} <-: ((RESULT.scenario).fmus)))))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 432:5\<close>

\<comment>\<open>VDM source: pre_updateEnvironmentEquation: (Importer * FMU * FMURef +> bool)
	pre_updateEnvironmentEquation(I, fmu, equation) ==
((equation in set ((I.activeEquations) \ (I.calculatedEquations))) and ((fmu.mode) = <EVENT>))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 445:9\<close>
definition
	pre_updateEnvironmentEquation :: "Importer \<Rightarrow> FMU \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_updateEnvironmentEquation I   fmu   equation \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_updateEnvironmentEquation` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  inv_FMURef equation)  \<and> 
		\<comment>\<open>User defined body of pre_updateEnvironmentEquation.\<close>
		((equation \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ))"


\<comment>\<open>VDM source: post_updateEnvironmentEquation: (Importer * FMU * FMURef * Importer +> bool)
	post_updateEnvironmentEquation(I, fmu, equation, RESULT) ==
((equation in set (RESULT.calculatedEquations)) and (((I.relevantInputClocks) subset (RESULT.relevantInputClocks)) and (((I.relevantOutputClocks) subset (RESULT.relevantOutputClocks)) and fmusNotAffected((rng ({(fmu.name)} <-: ((I.scenario).fmus))), (rng ({(fmu.name)} <-: ((RESULT.scenario).fmus)))))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 447:9\<close>
definition
	post_updateEnvironmentEquation :: "Importer \<Rightarrow> FMU \<Rightarrow> FMURef \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_updateEnvironmentEquation I   fmu   equation   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_updateEnvironmentEquation` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  inv_FMURef equation  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_updateEnvironmentEquation.\<close>
		((equation \<in> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<subseteq> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<subseteq> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (fmusNotAffected (rng ({(name\<^sub>F\<^sub>M\<^sub>U fmu)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))   (rng ({(name\<^sub>F\<^sub>M\<^sub>U fmu)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))))))"

definition
	updateEnvironmentEquation :: "Importer \<Rightarrow> FMU \<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"updateEnvironmentEquation I   fmu   equation \<equiv> 
	\<comment>\<open>User defined body of updateEnvironmentEquation.\<close>
	(
		let 
(triggeredClocks::Clock VDMSet) = { clock .   ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation) \<in> (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock)) }
		in
			(if ((inv_VDMSet' inv_Clock  triggeredClocks)) then
			(
		let 
(triggeredInputs::FMURef VDMSet) = { \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k inputClock)\<rparr> | inputClock .  ((inputClock \<in>triggeredClocks))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k inputClock) \<noteq> Causality.U_input ) }
		;
		
(triggeredOutputs::FMURef VDMSet) = { \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k outputClock)\<rparr> | outputClock .  ((outputClock \<in>triggeredClocks))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k outputClock) \<noteq> Causality.U_output ) }
		in
			(if ((inv_VDMSet' inv_FMURef  triggeredInputs))
	 \<and> 
	((inv_VDMSet' inv_FMURef  triggeredOutputs)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U fmu)\<mapsto>fmu])\<rparr>, calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> {equation}), relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> triggeredInputs), relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> triggeredOutputs)\<rparr>
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: initializeData: (Importer -> Importer)
	initializeData(I) ==
let connections:map (FMURef) to (FMURef) = ((I.scenario).connections) in let outputs:set of (Action) = {mk_Action(<get>, (output.name), (output.ref)) | output in set (dom connections)}, inputs:set of (Action) = {mk_Action(<set>, (input.name), (input.ref)) | input in set (rng connections)} in runAlgorithm(I, [act | act in set (outputs union inputs)])
	pre preInitialization(I)
	post postInitialization(RESULT)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 456:5\<close>

\<comment>\<open>VDM source: pre_initializeData: (Importer +> bool)
	pre_initializeData(I) ==
preInitialization(I)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 462:9\<close>
definition
	pre_initializeData :: "Importer \<Rightarrow> bool"
where
	"pre_initializeData I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_initializeData` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_initializeData.\<close>
		(preInitialization I)"


\<comment>\<open>VDM source: post_initializeData: (Importer * Importer +> bool)
	post_initializeData(I, RESULT) ==
postInitialization(RESULT)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 463:10\<close>
definition
	post_initializeData :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_initializeData I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_initializeData` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_initializeData.\<close>
		(postInitialization RESULT)"

definition
	initializeData :: "Importer \<Rightarrow> Importer"
where
	"initializeData I \<equiv> 
	\<comment>\<open>User defined body of initializeData.\<close>
	(
		let 
(connections::(FMURef \<rightharpoonup> FMURef)) = (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))
		in
			(if ((inv_Map inv_FMURef  inv_FMURef  connections)) then
			(
		let 
(outputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_get ActionType.U_get , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output)\<rparr> | output .  ((output \<in>(dom connections)))  }
		;
		
(inputs::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_set ActionType.U_set , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input)\<rparr> | input .  ((input \<in>(rng connections)))  }
		in
			(if ((inv_VDMSet' inv_Action  outputs))
	 \<and> 
	((inv_VDMSet' inv_Action  inputs)) then
			(runAlgorithm I   [ act . act \<leftarrow> sorted_list_of_set ((outputs \<union> inputs)) , ((act \<in>(outputs \<union> inputs))) ]
	\<comment>\<open>`Set bind `(act \<in> (outputs \<union> inputs))` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>(outputs \<union> inputs)\<close>}   has a VDM ord_ predicate.\<close> )
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
let clocksToTick:set of (Name) = (dom ((I.schedule) :> {((I.time).r)})) in let affectededInputs:set of (FMURef) = (dunion (rng (clocksToTick <: ((I.scenario).timedClockConnections)))) in let updatedSchedule:map (Name) to (real) = {(c.name) |-> ((c.period) + ((I.time).r)) | c in set ((I.scenario).timeBasedClocks) & ((c.name) in set clocksToTick)} in let I1:Importer = mu(I, relevantInputClocks |-> affectededInputs, schedule |-> ((I.schedule) ++ updatedSchedule)) in mk_(I1, affectededInputs)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 468:5\<close>

\<comment>\<open>VDM source: pre_tickingClocks: (Importer +> bool)
	pre_tickingClocks(I) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 468:5\<close>
definition
	pre_tickingClocks :: "Importer \<Rightarrow> bool"
where
	"pre_tickingClocks I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_tickingClocks` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_tickingClocks: (Importer * (Importer * set of (FMURef)) +> bool)
	post_tickingClocks(I, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 468:5\<close>
definition
	post_tickingClocks :: "Importer \<Rightarrow> (Importer \<times> FMURef VDMSet) \<Rightarrow> bool"
where
	"post_tickingClocks I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_tickingClocks` specification.\<close>
		(inv_Importer I  \<and>  
		(inv_Importer (fst RESULT)\<and>
		 (inv_VDMSet' inv_FMURef  (snd RESULT))
		))"

definition
	tickingClocks :: "Importer \<Rightarrow> (Importer \<times> FMURef VDMSet)"
where
	"tickingClocks I \<equiv> 
	\<comment>\<open>User defined body of tickingClocks.\<close>
	(
		let 
(clocksToTick::Name VDMSet) = (dom ((schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<triangleright> {(r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))}))
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) clocksToTick)) then
			(
		let 
(affectededInputs::FMURef VDMSet) = (\<Union> (rng (clocksToTick \<triangleleft> (timedClockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))))
		in
			(if ((inv_VDMSet' inv_FMURef  affectededInputs)) then
			(
		let 
(updatedSchedule::(Name \<rightharpoonup> VDMReal)) = (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | (dummy0DOMAIN :: Name) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and> ((name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<in> clocksToTick) } 
		{ ((period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) + (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) | (dummy0RANGE :: VDMReal) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (((inv_VDMReal dummy0RANGE)))  \<and> ((name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<in> clocksToTick) } 
		((inv_VDMSeq1' (inv_VDMChar))) 
		(inv_VDMReal) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: VDMReal) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (((inv_VDMReal dummy0RANGE))) \<and> ((inv_VDMSeq1' (inv_VDMChar) (
		if ((\<exists> (dummy0DOMAIN :: Name)  . (((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<longrightarrow> ((dummy0DOMAIN = (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c)) \<and> ((name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<in> clocksToTick))))) then
		(dummy0DOMAIN)
		else
		(undefined)))) then
			(
		if ((\<exists> (dummy0DOMAIN :: Name)  . (((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<longrightarrow> ((dummy0DOMAIN = (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c)) \<and> ((name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<in> clocksToTick))))) then
		(dummy0DOMAIN)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: VDMReal) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (((inv_VDMReal dummy0RANGE))) \<and> (inv_VDMReal (
		if ((\<exists> (dummy0RANGE :: VDMReal)  . ((((inv_VDMReal dummy0RANGE))) \<longrightarrow> ((dummy0RANGE = ((period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) + (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and> ((name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<in> clocksToTick))))) then
		(dummy0RANGE)
		else
		(undefined))) then
			(
		if ((\<exists> (dummy0RANGE :: VDMReal)  . ((((inv_VDMReal dummy0RANGE))) \<longrightarrow> ((dummy0RANGE = ((period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) + (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and> ((name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<in> clocksToTick))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: VDMReal) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (((inv_VDMReal dummy0RANGE))) \<and> (inv_bool (
		if ((\<exists> c \<in> (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))  . ((c \<in> (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> ((name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<in> clocksToTick)))) then
		((True::\<bool>))
		else
		(undefined))) then
			(
		if ((\<exists> c \<in> (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))  . ((c \<in> (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> ((name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<in> clocksToTick)))) then
		((True::\<bool>))
		else
		(undefined))
		 else
			undefined
		)
		))
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) (inv_VDMReal) updatedSchedule)) then
			(
		let 
(I1::Importer) = (I)\<lparr>relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := affectededInputs, schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<dagger> updatedSchedule)\<rparr>
		in
			(if (inv_Importer I1) then
			(I1 , affectededInputs)
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

	
	
\<comment>\<open>VDM source: calculateRelevantFMUs: (Machine * set of (Name) * set of (Name) -> set of (Name))
	calculateRelevantFMUs(M, relevantFMUs, notRelevantFMUs) ==
let addedFMUs:set of (Name) = {((M.clockConnections)(con).name) | con in set (dom (M.clockConnections)) & (((con.name) in set relevantFMUs) and (((M.clockConnections)(con).name) in set notRelevantFMUs))} in (if (addedFMUs = {})
then relevantFMUs
else calculateRelevantFMUs(M, (relevantFMUs union addedFMUs), (notRelevantFMUs \ addedFMUs)))
	pre ((relevantFMUs inter notRelevantFMUs) = {})
	post ((RESULT subset (dom (M.fmus))) and let notAdded:set of (Name) = ((dom (M.fmus)) \ RESULT) in (not (exists [srcClock in set (dom (M.clockConnections))] & (((srcClock.name) in set RESULT) and (((M.clockConnections)(srcClock).name) in set notAdded)))))
	measure (card notRelevantFMUs)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 489:5\<close>

\<comment>\<open>VDM source: pre_calculateRelevantFMUs: (Machine * set of (Name) * set of (Name) +> bool)
	pre_calculateRelevantFMUs(M, relevantFMUs, notRelevantFMUs) ==
((relevantFMUs inter notRelevantFMUs) = {})\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 497:48\<close>
definition
	pre_calculateRelevantFMUs :: "Machine \<Rightarrow> Name VDMSet \<Rightarrow> Name VDMSet \<Rightarrow> bool"
where
	"pre_calculateRelevantFMUs M   relevantFMUs   notRelevantFMUs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculateRelevantFMUs` specification.\<close>
		(inv_Machine M  \<and>  (inv_VDMSet' (inv_Name) relevantFMUs)  \<and>  (inv_VDMSet' (inv_Name) notRelevantFMUs))  \<and> 
		\<comment>\<open>User defined body of pre_calculateRelevantFMUs.\<close>
		((relevantFMUs \<inter> notRelevantFMUs) = {})"


\<comment>\<open>VDM source: post_calculateRelevantFMUs: (Machine * set of (Name) * set of (Name) * set of (Name) +> bool)
	post_calculateRelevantFMUs(M, relevantFMUs, notRelevantFMUs, RESULT) ==
((RESULT subset (dom (M.fmus))) and let notAdded:set of (Name) = ((dom (M.fmus)) \ RESULT) in (not (exists [srcClock in set (dom (M.clockConnections))] & (((srcClock.name) in set RESULT) and (((M.clockConnections)(srcClock).name) in set notAdded)))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 499:13\<close>
definition
	post_calculateRelevantFMUs :: "Machine \<Rightarrow> Name VDMSet \<Rightarrow> Name VDMSet \<Rightarrow> Name VDMSet \<Rightarrow> bool"
where
	"post_calculateRelevantFMUs M   relevantFMUs   notRelevantFMUs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_calculateRelevantFMUs` specification.\<close>
		(inv_Machine M  \<and>  (inv_VDMSet' (inv_Name) relevantFMUs)  \<and>  (inv_VDMSet' (inv_Name) notRelevantFMUs)  \<and>  (inv_VDMSet' (inv_Name) RESULT))  \<and> 
		\<comment>\<open>User defined body of post_calculateRelevantFMUs.\<close>
		((RESULT \<subseteq> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))) \<and> (
		let 
(notAdded::Name VDMSet) = ((dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M)) - RESULT)
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) notAdded)) then
			(\<not> (\<exists> srcClock \<in> (dom (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcClock) \<in> RESULT) \<and> ((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (the(((clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) srcClock)))) \<in> notAdded))))
		 else
			undefined
		)
		))"

fun
	calculateRelevantFMUs :: "Machine \<Rightarrow> Name VDMSet \<Rightarrow> Name VDMSet \<Rightarrow> Name VDMSet"
where
	"calculateRelevantFMUs M   relevantFMUs   notRelevantFMUs = 
	\<comment>\<open>User defined body of calculateRelevantFMUs.\<close>
	(
		let 
(addedFMUs::Name VDMSet) = { (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (the(((clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) con)))) | con .  ((con \<in>(dom (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))))  \<and> (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f con) \<in> relevantFMUs) \<and> ((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (the(((clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) con)))) \<in> notRelevantFMUs)) }
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) addedFMUs)) then
			(
		if ((addedFMUs = {})) then
		(relevantFMUs)
		else
		((calculateRelevantFMUs M   (relevantFMUs \<union> addedFMUs)   (notRelevantFMUs - addedFMUs))))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: clockedSimulationAlgorithm: (Importer * set of (FMURef) -> Importer)
	clockedSimulationAlgorithm(I, clocks) ==
let eventFMUs:set of (Name) = ((I.fmusWithEvent) union {(clock.name) | clock in set clocks}) in let relevantFMUs:set of (Name) = calculateRelevantFMUs((I.scenario), eventFMUs, ((dom ((I.scenario).fmus)) \ eventFMUs)) in let I1:Importer = enterEventMode(I, relevantFMUs) in let I2:Importer = activateClocks(I1, [clock | clock in set clocks]) in let I3:Importer = eventIteration(I2, relevantFMUs) in (if ((I3.fmusWithEvent) = {})
then enterStepMode(I3, relevantFMUs)
else clockedSimulationAlgorithm(I, clocks))
	pre preEventMode(I, clocks)
	post postEventMode(RESULT)
	measure not yet specified\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 510:5\<close>

\<comment>\<open>VDM source: pre_clockedSimulationAlgorithm: (Importer * set of (FMURef) +> bool)
	pre_clockedSimulationAlgorithm(I, clocks) ==
preEventMode(I, clocks)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 545:9\<close>
definition
	pre_clockedSimulationAlgorithm :: "Importer \<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"pre_clockedSimulationAlgorithm I   clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_clockedSimulationAlgorithm` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_FMURef  clocks))  \<and> 
		\<comment>\<open>User defined body of pre_clockedSimulationAlgorithm.\<close>
		(preEventMode I   clocks)"


\<comment>\<open>VDM source: post_clockedSimulationAlgorithm: (Importer * set of (FMURef) * Importer +> bool)
	post_clockedSimulationAlgorithm(I, clocks, RESULT) ==
postEventMode(RESULT)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 546:10\<close>
definition
	post_clockedSimulationAlgorithm :: "Importer \<Rightarrow> FMURef VDMSet \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_clockedSimulationAlgorithm I   clocks   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_clockedSimulationAlgorithm` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_FMURef  clocks)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_clockedSimulationAlgorithm.\<close>
		(postEventMode RESULT)"

fun
	clockedSimulationAlgorithm :: "Importer \<Rightarrow> FMURef VDMSet \<Rightarrow> Importer"
where
	"clockedSimulationAlgorithm I   clocks = 
	\<comment>\<open>User defined body of clockedSimulationAlgorithm.\<close>
	(
		let 
(eventFMUs::Name VDMSet) = ((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> { (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock) | clock .  ((clock \<in>clocks))  })
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) eventFMUs)) then
			(
		let 
(relevantFMUs::Name VDMSet) = (calculateRelevantFMUs (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   eventFMUs   ((dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) - eventFMUs))
		in
			(if ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) relevantFMUs)) then
			(
		let 
(I1::Importer) = (enterEventMode I   relevantFMUs)
		in
			(if (inv_Importer I1) then
			(
		let 
(I2::Importer) = (activateClocks I1   [ clock . clock \<leftarrow> sorted_list_of_set (clocks) , ((clock \<in>clocks)) ]
	\<comment>\<open>`Set bind `(clock \<in> clocks)` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>clocks\<close>}   has a VDM ord_ predicate.\<close> )
		in
			(if (inv_Importer I2) then
			(
		let 
(I3::Importer) = (eventIteration I2   relevantFMUs)
		in
			(if (inv_Importer I3) then
			(
		if (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I3) = {})) then
		((enterStepMode I3   relevantFMUs))
		else
		((clockedSimulationAlgorithm I   clocks)))
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

	
	
\<comment>\<open>VDM source: eventIteration: (Importer * set of (Name) -> Importer)
	eventIteration(I, relevantFMUs) ==
let I1:Importer = solveSystemOfEquations(I) in let I2:Importer = updateDiscreteState(I1, relevantFMUs) in I2
	pre let fmus:set of (FMU) = (rng (relevantFMUs <: ((I.scenario).fmus))) in (fmusSynchronized(fmus) and assertFMUMode(fmus, {<EVENT>}))
	post let newfmus:set of (FMU) = (rng (relevantFMUs <: ((RESULT.scenario).fmus))), oldfmus:set of (FMU) = (rng (relevantFMUs <: ((I.scenario).fmus))) in eventSolved(RESULT, newfmus, oldfmus)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 551:1\<close>

\<comment>\<open>VDM source: pre_eventIteration: (Importer * set of (Name) +> bool)
	pre_eventIteration(I, relevantFMUs) ==
let fmus:set of (FMU) = (rng (relevantFMUs <: ((I.scenario).fmus))) in (fmusSynchronized(fmus) and assertFMUMode(fmus, {<EVENT>}))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 580:9\<close>
definition
	pre_eventIteration :: "Importer \<Rightarrow> Name VDMSet \<Rightarrow> bool"
where
	"pre_eventIteration I   relevantFMUs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_eventIteration` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) relevantFMUs))  \<and> 
		\<comment>\<open>User defined body of pre_eventIteration.\<close>
		(
		let 
(fmus::FMU VDMSet) = (rng (relevantFMUs \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		in
			(if ((inv_VDMSet' inv_FMU  fmus)) then
			((fmusSynchronized fmus) \<and> (assertFMUMode fmus   {FMUMode.U_EVENT }))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_eventIteration: (Importer * set of (Name) * Importer +> bool)
	post_eventIteration(I, relevantFMUs, RESULT) ==
let newfmus:set of (FMU) = (rng (relevantFMUs <: ((RESULT.scenario).fmus))), oldfmus:set of (FMU) = (rng (relevantFMUs <: ((I.scenario).fmus))) in eventSolved(RESULT, newfmus, oldfmus)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 584:9\<close>
definition
	post_eventIteration :: "Importer \<Rightarrow> Name VDMSet \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_eventIteration I   relevantFMUs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_eventIteration` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' (inv_Name) relevantFMUs)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_eventIteration.\<close>
		(
		let 
(newfmus::FMU VDMSet) = (rng (relevantFMUs \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		;
		
(oldfmus::FMU VDMSet) = (rng (relevantFMUs \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		in
			(if ((inv_VDMSet' inv_FMU  newfmus))
	 \<and> 
	((inv_VDMSet' inv_FMU  oldfmus)) then
			(eventSolved RESULT   newfmus   oldfmus)
		 else
			undefined
		)
		)"

definition
	eventIteration :: "Importer \<Rightarrow> Name VDMSet \<Rightarrow> Importer"
where
	"eventIteration I   relevantFMUs \<equiv> 
	\<comment>\<open>User defined body of eventIteration.\<close>
	(
		let 
(I1::Importer) = (solveSystemOfEquations I)
		in
			(if (inv_Importer I1) then
			(
		let 
(I2::Importer) = (updateDiscreteState I1   relevantFMUs)
		in
			(if (inv_Importer I2) then
			I2
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: solveSystemOfEquations: (Importer -> Importer)
	solveSystemOfEquations(I) ==
(if (((I.activeEquations) \ (I.calculatedEquations)) = {})
then I
else let action:Action = selectAction(I) in solveSystemOfEquations(runAction(I, action)))
	post (((RESULT.activeEquations) \ (RESULT.calculatedEquations)) = {})
	measure ((card (I.readyEquations)) + (card ((I.activeEquations) \ (I.calculatedEquations))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 594:1\<close>

\<comment>\<open>VDM source: pre_solveSystemOfEquations: (Importer +> bool)
	pre_solveSystemOfEquations(I) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 594:1\<close>
definition
	pre_solveSystemOfEquations :: "Importer \<Rightarrow> bool"
where
	"pre_solveSystemOfEquations I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_solveSystemOfEquations` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_solveSystemOfEquations: (Importer * Importer +> bool)
	post_solveSystemOfEquations(I, RESULT) ==
(((RESULT.activeEquations) \ (RESULT.calculatedEquations)) = {})\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 600:62\<close>
definition
	post_solveSystemOfEquations :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_solveSystemOfEquations I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_solveSystemOfEquations` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_solveSystemOfEquations.\<close>
		(((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) = {})"

fun
	solveSystemOfEquations :: "Importer \<Rightarrow> Importer"
where
	"solveSystemOfEquations I = 
	\<comment>\<open>User defined body of solveSystemOfEquations.\<close>
	(
		if ((((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) = {})) then
		(I)
		else
		((
		let 
(action::Action) = (selectAction I)
		in
			(if (inv_Action action) then
			(solveSystemOfEquations (runAction I   action))
		 else
			undefined
		)
		)))"

	
	
\<comment>\<open>VDM source: selectAction: (Importer -> Action)
	selectAction(I) ==
let fmus:map (Name) to (FMU) = ((I.scenario).fmus) in let queryClockActions:set of (Action) = {mk_Action(<getC>, (clock.name), (clock.ref)) | clock in set (I.relevantOutputClocks)}, setClockActions:set of (Action) = {mk_Action(<setC>, (clock.name), (clock.ref)) | clock in set (I.relevantInputClocks)} in let clockActions:set of (Action) = (queryClockActions union setClockActions) in (if ((clockActions <> {}) and ({action | action in set clockActions & isActionEnabled(I, action)} <> {}))
then let clockAction in set {action | action in set clockActions & isActionEnabled(I, action)} in clockAction
else let portActions:set of (Action) = ({mk_Action(<set>, (input.name), (input.ref)) | input in set ((I.activeEquations) \ (I.calculatedEquations)) & ((input.ref) in set {(i.ref) | i in set (fmus((input.name)).inputs)})} union {mk_Action(<get>, (output.name), (output.ref)) | output in set ((I.activeEquations) \ (I.calculatedEquations)) & ((output.ref) in set {(o.ref) | o in set (fmus((output.name)).outputs)})}) in let portAction in set {action | action in set portActions & isActionEnabled(I, action)} in portAction)
	pre (((I.activeEquations) \ (I.calculatedEquations)) <> {})
	post (((RESULT.actionType) <> <step>) and ((((RESULT.actionType) in set {<getC>, <setC>}) => (((I.relevantOutputClocks) union (I.relevantInputClocks)) <> {})) and (((RESULT.actionType) not in set {<getC>, <setC>}) => (((I.relevantOutputClocks) union (I.relevantInputClocks)) = {}))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 608:1\<close>

\<comment>\<open>VDM source: pre_selectAction: (Importer +> bool)
	pre_selectAction(I) ==
(((I.activeEquations) \ (I.calculatedEquations)) <> {})\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 625:51\<close>
definition
	pre_selectAction :: "Importer \<Rightarrow> bool"
where
	"pre_selectAction I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_selectAction` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_selectAction.\<close>
		(((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<noteq> {})"


\<comment>\<open>VDM source: post_selectAction: (Importer * Action +> bool)
	post_selectAction(I, RESULT) ==
(((RESULT.actionType) <> <step>) and ((((RESULT.actionType) in set {<getC>, <setC>}) => (((I.relevantOutputClocks) union (I.relevantInputClocks)) <> {})) and (((RESULT.actionType) not in set {<getC>, <setC>}) => (((I.relevantOutputClocks) union (I.relevantInputClocks)) = {}))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 628:9\<close>
definition
	post_selectAction :: "Importer \<Rightarrow> Action \<Rightarrow> bool"
where
	"post_selectAction I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_selectAction` specification.\<close>
		(inv_Importer I  \<and>  inv_Action RESULT)  \<and> 
		\<comment>\<open>User defined body of post_selectAction.\<close>
		(((actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n RESULT) \<noteq> ActionType.U_step ) \<and> ((((actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n RESULT) \<in> {ActionType.U_getC  , ActionType.U_setC }) \<longrightarrow> (((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<noteq> {})) \<and> (((actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n RESULT) \<notin> {ActionType.U_getC  , ActionType.U_setC }) \<longrightarrow> (((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) = {}))))"

definition
	selectAction :: "Importer \<Rightarrow> Action"
where
	"selectAction I \<equiv> 
	\<comment>\<open>User defined body of selectAction.\<close>
	(
		let 
(fmus::(Name \<rightharpoonup> FMU)) = (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  fmus)) then
			(
		let 
(queryClockActions::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_getC ActionType.U_getC , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock)\<rparr> | clock .  ((clock \<in>(relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))  }
		;
		
(setClockActions::Action VDMSet) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_setC ActionType.U_setC , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock)\<rparr> | clock .  ((clock \<in>(relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))  }
		in
			(if ((inv_VDMSet' inv_Action  queryClockActions))
	 \<and> 
	((inv_VDMSet' inv_Action  setClockActions)) then
			(
		let 
(clockActions::Action VDMSet) = (queryClockActions \<union> setClockActions)
		in
			(if ((inv_VDMSet' inv_Action  clockActions)) then
			(
		if (((clockActions \<noteq> {}) \<and> ({ action .   ((action \<in>clockActions))  \<and> (isActionEnabled I   action) } \<noteq> {}))) then
		((
		SOME (dummy0::Action) .(dummy0 \<in> { clockAction .   ((clockAction \<in>{ action .   ((action \<in>clockActions))  \<and> (isActionEnabled I   action) }))  })))
		else
		((
		let 
(portActions::Action VDMSet) = ({ \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_set ActionType.U_set , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input)\<rparr> | input .  ((input \<in>((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))  \<and> ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input) \<in> { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) | i .  ((i \<in>(inputs\<^sub>F\<^sub>M\<^sub>U (the((fmus (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input)))))))  }) } \<union> { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_get ActionType.U_get , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output)\<rparr> | output .  ((output \<in>((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))  \<and> ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output) \<in> { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e o) | o .  ((o \<in>(outputs\<^sub>F\<^sub>M\<^sub>U (the((fmus (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output)))))))  }) })
		in
			(if ((inv_VDMSet' inv_Action  portActions)) then
			(
		SOME (dummy0::Action) .(dummy0 \<in> { portAction .   ((portAction \<in>{ action .   ((action \<in>portActions))  \<and> (isActionEnabled I   action) }))  }))
		 else
			undefined
		)
		)))
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

	
	
\<comment>\<open>VDM source: createSchedule: (Importer -> Importer)
	createSchedule(I) ==
let timedBasedClocks:set of (TimeBasedClock) = ((I.scenario).timeBasedClocks) in mu(I, schedule |-> {(c.name) |-> ((c.period) + (c.shift)) | c in set timedBasedClocks})
	pre let fmus:set of (FMU) = (rng ((I.scenario).fmus)) in (assertFMUMode(fmus, {<INIT>}) and (fmusSynchronized(fmus) and variablesSynchronized((I.scenario), {<discrete>, <continous>})))
	post let fmus:set of (FMU) = (rng ((RESULT.scenario).fmus)) in (((dom (RESULT.schedule)) = {(c.name) | c in set ((RESULT.scenario).timeBasedClocks)}) and (assertFMUMode(fmus, {<INIT>}) and (fmusSynchronized(fmus) and (ImporterNotAffected(I, RESULT) and variablesSynchronized((RESULT.scenario), {<discrete>, <continous>})))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 652:1\<close>

\<comment>\<open>VDM source: pre_createSchedule: (Importer +> bool)
	pre_createSchedule(I) ==
let fmus:set of (FMU) = (rng ((I.scenario).fmus)) in (assertFMUMode(fmus, {<INIT>}) and (fmusSynchronized(fmus) and variablesSynchronized((I.scenario), {<discrete>, <continous>})))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 659:5\<close>
definition
	pre_createSchedule :: "Importer \<Rightarrow> bool"
where
	"pre_createSchedule I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_createSchedule` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_createSchedule.\<close>
		(
		let 
(fmus::FMU VDMSet) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		in
			(if ((inv_VDMSet' inv_FMU  fmus)) then
			((assertFMUMode fmus   {FMUMode.U_INIT }) \<and> ((fmusSynchronized fmus) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   {PortType.U_discrete  , PortType.U_continous })))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_createSchedule: (Importer * Importer +> bool)
	post_createSchedule(I, RESULT) ==
let fmus:set of (FMU) = (rng ((RESULT.scenario).fmus)) in (((dom (RESULT.schedule)) = {(c.name) | c in set ((RESULT.scenario).timeBasedClocks)}) and (assertFMUMode(fmus, {<INIT>}) and (fmusSynchronized(fmus) and (ImporterNotAffected(I, RESULT) and variablesSynchronized((RESULT.scenario), {<discrete>, <continous>})))))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 664:5\<close>
definition
	post_createSchedule :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_createSchedule I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_createSchedule` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_createSchedule.\<close>
		(
		let 
(fmus::FMU VDMSet) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))
		in
			(if ((inv_VDMSet' inv_FMU  fmus)) then
			(((dom (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) = { (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>(timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))  }) \<and> ((assertFMUMode fmus   {FMUMode.U_INIT }) \<and> ((fmusSynchronized fmus) \<and> ((ImporterNotAffected I   RESULT) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)   {PortType.U_discrete  , PortType.U_continous })))))
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
(timedBasedClocks::TimeBasedClock VDMSet) = (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))
		in
			(if ((inv_VDMSet' inv_TimeBasedClock  timedBasedClocks)) then
			(I)\<lparr>schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{(name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c)} 
		{((period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) + (shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c))} 
		((inv_VDMSeq1' (inv_VDMChar))) 
		(inv_VDMReal) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: VDMReal) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (((inv_VDMReal dummy0RANGE))) \<and> ((inv_VDMSeq1' (inv_VDMChar) (
		if ((\<exists> (dummy0DOMAIN :: Name)  . (((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<longrightarrow> ((dummy0DOMAIN = (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined)))) then
			(
		if ((\<exists> (dummy0DOMAIN :: Name)  . (((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<longrightarrow> ((dummy0DOMAIN = (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: VDMReal) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (((inv_VDMReal dummy0RANGE))) \<and> (inv_VDMReal (
		if ((\<exists> (dummy0RANGE :: VDMReal)  . ((((inv_VDMReal dummy0RANGE))) \<longrightarrow> ((dummy0RANGE = ((period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) + (shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))) then
			(
		if ((\<exists> (dummy0RANGE :: VDMReal)  . ((((inv_VDMReal dummy0RANGE))) \<longrightarrow> ((dummy0RANGE = ((period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) + (shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(truecnst ))\<rparr>
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: calculateSchedule: (FMU * set of (Ref) -> map (FMURef) to (real))
	calculateSchedule(fmu, clocks) ==
{mk_FMURef((fmu.name), clock) |-> next_tm(fmu, clock) | clock in set clocks}
	pre let cref:set of (Ref) = {(c.ref) | c in set (fmu.clocks) & (((c.type) = <input>) and ((c.interval) <> <triggered>))} in (clocks subset cref)
	post ((card (dom RESULT)) = (card clocks))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 671:1\<close>

\<comment>\<open>VDM source: pre_calculateSchedule: (FMU * set of (Ref) +> bool)
	pre_calculateSchedule(fmu, clocks) ==
let cref:set of (Ref) = {(c.ref) | c in set (fmu.clocks) & (((c.type) = <input>) and ((c.interval) <> <triggered>))} in (clocks subset cref)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 674:5\<close>
definition
	pre_calculateSchedule :: "FMU \<Rightarrow> Ref VDMSet \<Rightarrow> bool"
where
	"pre_calculateSchedule fmu   clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculateSchedule` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks))  \<and> 
		\<comment>\<open>User defined body of pre_calculateSchedule.\<close>
		(
		let 
(cref::Ref VDMSet) = { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) = Causality.U_input ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) \<noteq> Interval.U_triggered )) }
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) cref)) then
			(clocks \<subseteq> cref)
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_calculateSchedule: (FMU * set of (Ref) * map (FMURef) to (real) +> bool)
	post_calculateSchedule(fmu, clocks, RESULT) ==
((card (dom RESULT)) = (card clocks))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 676:22\<close>
definition
	post_calculateSchedule :: "FMU \<Rightarrow> Ref VDMSet \<Rightarrow> (FMURef \<rightharpoonup> VDMReal) \<Rightarrow> bool"
where
	"post_calculateSchedule fmu   clocks   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_calculateSchedule` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_Map inv_FMURef  (inv_VDMReal) RESULT))  \<and> 
		\<comment>\<open>User defined body of post_calculateSchedule.\<close>
		((vdm_card (dom RESULT)) = (vdm_card clocks))"

definition
	calculateSchedule :: "FMU \<Rightarrow> Ref VDMSet \<Rightarrow> (FMURef \<rightharpoonup> VDMReal)"
where
	"calculateSchedule fmu   clocks \<equiv> 
	\<comment>\<open>User defined body of calculateSchedule.\<close>
	(\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>} 
		{ (next_tm fmu   clock) | clock .  (clock \<in>clocks)  } 
		 ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f FMURef)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f FMURef)))) ) 
		((inv_RealNaN )) 
		(
	\<lambda> (dummy0DOMAIN :: FMURef)   (dummy0RANGE :: RealNaN) .
		(if (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) )))  \<and>  ((((case dummy0RANGE of
		 RealNaN.U_NaN  \<Rightarrow> (inv_True dummy0RANGE)
		  | RealNaN.U_VDMReal dummy0RANGE \<Rightarrow> (inv_VDMReal dummy0RANGE)
		 )))) \<and>  ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (
		if ((\<exists> (dummy0DOMAIN :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMURef` call\<close>
	(eq_FMURef dummy0DOMAIN   \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined)))))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (
		if ((\<exists> (dummy0DOMAIN :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMURef` call\<close>
	(eq_FMURef dummy0DOMAIN   \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined)))))) ) then
			(
		if ((\<exists> (dummy0DOMAIN :: FMURef)  . ((( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMURef` call\<close>
	(eq_FMURef dummy0DOMAIN   \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: FMURef)   (dummy0RANGE :: RealNaN) .
		(if (( ((((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) \<and> 
		 (((inv_VDMNat (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0DOMAIN)))) )))  \<and>  ((((case dummy0RANGE of
		 RealNaN.U_NaN  \<Rightarrow> (inv_True dummy0RANGE)
		  | RealNaN.U_VDMReal dummy0RANGE \<Rightarrow> (inv_VDMReal dummy0RANGE)
		 )))) \<and> ((case (
		if ((\<exists> clock \<in> clocks  . ((clock \<in> clocks) \<and> ((dummy0RANGE = (next_tm fmu   clock)) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)) of
		 RealNaN.U_NaN  \<Rightarrow> (inv_True (
		if ((\<exists> clock \<in> clocks  . ((clock \<in> clocks) \<and> ((dummy0RANGE = (next_tm fmu   clock)) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))
		  | RealNaN.U_VDMReal (
		if ((\<exists> clock \<in> clocks  . ((clock \<in> clocks) \<and> ((dummy0RANGE = (next_tm fmu   clock)) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)) \<Rightarrow> (inv_VDMReal (
		if ((\<exists> clock \<in> clocks  . ((clock \<in> clocks) \<and> ((dummy0RANGE = (next_tm fmu   clock)) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))
		 )) then
			(
		if ((\<exists> clock \<in> clocks  . ((clock \<in> clocks) \<and> ((dummy0RANGE = (next_tm fmu   clock)) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(truecnst ))"

	
	
\<comment>\<open>VDM source: createFMURefs: (FMU * set of (Ref) -> set of (FMURef))
	createFMURefs(fmu, clocks) ==
{mk_FMURef((fmu.name), clock) | clock in set clocks}
	post ((card RESULT) = (card clocks))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 678:1\<close>

\<comment>\<open>VDM source: pre_createFMURefs: (FMU * set of (Ref) +> bool)
	pre_createFMURefs(fmu, clocks) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 678:1\<close>
definition
	pre_createFMURefs :: "FMU \<Rightarrow> Ref VDMSet \<Rightarrow> bool"
where
	"pre_createFMURefs fmu   clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_createFMURefs` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks))"


\<comment>\<open>VDM source: post_createFMURefs: (FMU * set of (Ref) * set of (FMURef) +> bool)
	post_createFMURefs(fmu, clocks, RESULT) ==
((card RESULT) = (card clocks))\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 681:18\<close>
definition
	post_createFMURefs :: "FMU \<Rightarrow> Ref VDMSet \<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"post_createFMURefs fmu   clocks   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_createFMURefs` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_VDMSet' inv_FMURef  RESULT))  \<and> 
		\<comment>\<open>User defined body of post_createFMURefs.\<close>
		((vdm_card RESULT) = (vdm_card clocks))"

definition
	createFMURefs :: "FMU \<Rightarrow> Ref VDMSet \<Rightarrow> FMURef VDMSet"
where
	"createFMURefs fmu   clocks \<equiv> 
	\<comment>\<open>User defined body of createFMURefs.\<close>
	{ \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> | clock .  ((clock \<in>clocks))  }"

	
	
\<comment>\<open>VDM source: selectMinStep: (set of (real) -> real)
	selectMinStep(steps) ==
minset(steps, 10000)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 683:1\<close>

\<comment>\<open>VDM source: pre_selectMinStep: (set of (real) +> bool)
	pre_selectMinStep(steps) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 683:1\<close>
definition
	pre_selectMinStep :: "VDMReal VDMSet \<Rightarrow> bool"
where
	"pre_selectMinStep steps \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_selectMinStep` specification.\<close>
		((inv_VDMSet' (inv_VDMReal) steps))"


\<comment>\<open>VDM source: post_selectMinStep: (set of (real) * real +> bool)
	post_selectMinStep(steps, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 683:1\<close>
definition
	post_selectMinStep :: "VDMReal VDMSet \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"post_selectMinStep steps   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_selectMinStep` specification.\<close>
		((inv_VDMSet' (inv_VDMReal) steps)  \<and>  (inv_VDMReal RESULT))"

definition
	selectMinStep :: "VDMReal VDMSet \<Rightarrow> VDMReal"
where
	"selectMinStep steps \<equiv> 
	\<comment>\<open>User defined body of selectMinStep.\<close>
	(minset steps   (10000::VDMNat1))"

	
	
\<comment>\<open>VDM source: minset: (set of (real) * real -> real)
	minset(s, min) ==
(if (s = {})
then min
else let e in set s in (if (e < min)
then minset((s \ {e}), e)
else minset((s \ {e}), min)))
	measure (card s)\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 686:1\<close>

\<comment>\<open>VDM source: pre_minset: (set of (real) * real +> bool)
	pre_minset(s, min) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 686:1\<close>
definition
	pre_minset :: "VDMReal VDMSet \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"pre_minset s   min \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_minset` specification.\<close>
		((inv_VDMSet' (inv_VDMReal) s)  \<and>  (inv_VDMReal min))"


\<comment>\<open>VDM source: post_minset: (set of (real) * real * real +> bool)
	post_minset(s, min, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Clocks.vdmsl) at line 686:1\<close>
definition
	post_minset :: "VDMReal VDMSet \<Rightarrow> VDMReal \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"post_minset s   min   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_minset` specification.\<close>
		((inv_VDMSet' (inv_VDMReal) s)  \<and>  (inv_VDMReal min)  \<and>  (inv_VDMReal RESULT))"

fun
	minset :: "VDMReal VDMSet \<Rightarrow> VDMReal \<Rightarrow> VDMReal"
where
	"minset s   min = 
	\<comment>\<open>User defined body of minset.\<close>
	(
		if ((s = {})) then
		(min)
		else
		((
		SOME (dummy0::VDMReal) .(dummy0 \<in> { (
		if ((e < min)) then
		((minset (s - {e})   e))
		else
		((minset (s - {e})   min))) | e .  ((e \<in>s))  }))))"

	
	
\<comment>\<open>VDM source: Importer = compose Importer of scenario:Machine, schedule:map (Name) to (real), activeClocks:set of (FMURef), readyClocks:set of (FMURef), inactiveClocks:set of (FMURef), fmusWithEvent:set of (Name), relevantOutputClocks:set of (FMURef), relevantInputClocks:set of (FMURef), activeEquations:set of (FMURef), calculatedEquations:set of (FMURef), readyEquations:set of (FMURef), time:Time, endtime:Time, stepSize:real, valueMap:map (FMURef) to (Value) end
	inv imp == let fmus:map (Name) to (FMU) = ((imp.scenario).fmus) in let inputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <input>)}) | fmu in set (rng fmus)}) in let outputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <output>)}) | fmu in set (rng fmus)}) in let clocks:set of (FMURef) = (inputclocks union outputclocks) in (((card ((imp.activeClocks) union (imp.inactiveClocks))) = (card clocks)) and ((((imp.activeClocks) inter (imp.inactiveClocks)) = {}) and ((((imp.activeClocks) inter (imp.readyClocks)) = {}) and (((imp.activeClocks) = (dunion {createFMURefs(fmu, (fmu.activeClocks)) | fmu in set (rng fmus)})) and (((imp.fmusWithEvent) subset (dom fmus)) and (((imp.relevantInputClocks) subset inputclocks) and (((imp.relevantOutputClocks) subset outputclocks) and ((((imp.relevantInputClocks) inter (imp.relevantOutputClocks)) = {}) and (((imp.endtime) >= (imp.time)) and ((((imp.activeEquations) inter (imp.readyEquations)) = {}) and (((imp.readyEquations) inter (imp.calculatedEquations)) = {})))))))))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 35:5\<close>
record Importer = 
	scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "Machine"
		 
		 schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "(Name \<rightharpoonup> VDMReal)"
		 
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
let fmus:map (Name) to (FMU) = ((imp.scenario).fmus) in let inputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <input>)}) | fmu in set (rng fmus)}) in let outputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <output>)}) | fmu in set (rng fmus)}) in let clocks:set of (FMURef) = (inputclocks union outputclocks) in (((card ((imp.activeClocks) union (imp.inactiveClocks))) = (card clocks)) and ((((imp.activeClocks) inter (imp.inactiveClocks)) = {}) and ((((imp.activeClocks) inter (imp.readyClocks)) = {}) and (((imp.activeClocks) = (dunion {createFMURefs(fmu, (fmu.activeClocks)) | fmu in set (rng fmus)})) and (((imp.fmusWithEvent) subset (dom fmus)) and (((imp.relevantInputClocks) subset inputclocks) and (((imp.relevantOutputClocks) subset outputclocks) and ((((imp.relevantInputClocks) inter (imp.relevantOutputClocks)) = {}) and (((imp.endtime) >= (imp.time)) and ((((imp.activeEquations) inter (imp.readyEquations)) = {}) and (((imp.readyEquations) inter (imp.calculatedEquations)) = {})))))))))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 51:9\<close>
definition
	inv_Importer :: "Importer \<Rightarrow> bool"
where
	"inv_Importer imp \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Importer` specification.\<close>
		( ((inv_Machine (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) \<and> 
		 ((inv_Map (inv_Name) (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
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
(fmus::(Name \<rightharpoonup> FMU)) = (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  fmus)) then
			(
		let 
(inputclocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu   { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) = Causality.U_input ) }) | fmu .  ((fmu \<in>(rng fmus)))  })
		in
			(if ((inv_VDMSet' inv_FMURef  inputclocks)) then
			(
		let 
(outputclocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu   { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) | clock .  ((clock \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) = Causality.U_output ) }) | fmu .  ((fmu \<in>(rng fmus)))  })
		in
			(if ((inv_VDMSet' inv_FMURef  outputclocks)) then
			(
		let 
(clocks::FMURef VDMSet) = (inputclocks \<union> outputclocks)
		in
			(if ((inv_VDMSet' inv_FMURef  clocks)) then
			(((vdm_card ((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<union> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) = (vdm_card clocks)) \<and> ((((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<inter> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) = {}) \<and> ((((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<inter> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) = {}) \<and> (((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) = (\<Union> { (createFMURefs fmu   (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu)) | fmu .  ((fmu \<in>(rng fmus)))  })) \<and> (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<subseteq> (dom fmus)) \<and> (((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<subseteq> inputclocks) \<and> (((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<subseteq> outputclocks) \<and> ((((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<inter> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) = {}) \<and> (\<comment>\<open>Transform a VDM `>` expression into a reversed `ord_Time` call\<close>
	(ord_Time (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)   (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) \<or> 
	\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) \<and> ((((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<inter> (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) = {}) \<and> (((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp) \<inter> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) = {})))))))))))
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
 
lemmas inv_Importer_defs = inv_Causality_def inv_Clock_def inv_Contract_def inv_Environment_def inv_Equation_def inv_FMU_def inv_FMUMode_def inv_FMURef_def inv_Importer_def inv_Interval_def inv_Lambda_def inv_Machine_def inv_Map_def inv_Map_defs inv_Name_def inv_PortType_def inv_Ref_def inv_Time_def inv_TimeBasedClock_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_Value_def inv_ValueType_def inv_Variable_def inv_bool_def 


	
	
\<comment>\<open>VDM source: createImporter: (Machine * Time * real -> Importer)
	createImporter(M, endtime, stepSize) ==
let clocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(c.ref) | c in set (fmu.clocks)}) | fmu in set (rng (M.fmus))}), discreteVariables:set of (FMURef) = (dunion {createFMURefs(fmu, {(v.ref) | v in set ((fmu.inputs) union (fmu.outputs)) & ((v.type) = <discrete>)}) | fmu in set (rng (M.fmus))}) in mk_Importer(M, {|->}, {}, clocks, clocks, {}, {}, {}, {}, {}, discreteVariables, mk_Time(0, 0), endtime, stepSize, {|->})\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 75:5\<close>

\<comment>\<open>VDM source: pre_createImporter: (Machine * Time * real +> bool)
	pre_createImporter(M, endtime, stepSize) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 75:5\<close>
definition
	pre_createImporter :: "Machine \<Rightarrow> Time \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"pre_createImporter M   endtime   stepSize \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_createImporter` specification.\<close>
		(inv_Machine M  \<and>  inv_Time endtime  \<and>  (inv_VDMReal stepSize))"


\<comment>\<open>VDM source: post_createImporter: (Machine * Time * real * Importer +> bool)
	post_createImporter(M, endtime, stepSize, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 75:5\<close>
definition
	post_createImporter :: "Machine \<Rightarrow> Time \<Rightarrow> VDMReal \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_createImporter M   endtime   stepSize   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_createImporter` specification.\<close>
		(inv_Machine M  \<and>  inv_Time endtime  \<and>  (inv_VDMReal stepSize)  \<and>  inv_Importer RESULT)"

definition
	createImporter :: "Machine \<Rightarrow> Time \<Rightarrow> VDMReal \<Rightarrow> Importer"
where
	"createImporter M   endtime   stepSize \<equiv> 
	\<comment>\<open>User defined body of createImporter.\<close>
	(
		let 
(clocks::FMURef VDMSet) = (\<Union> { (createFMURefs fmu   { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  }) | fmu .  ((fmu \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))))  })
		;
		
(discreteVariables::FMURef VDMSet) = (\<Union> { (createFMURefs fmu   { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) | v .  ((v \<in>((inputs\<^sub>F\<^sub>M\<^sub>U fmu) \<union> (outputs\<^sub>F\<^sub>M\<^sub>U fmu))))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = PortType.U_discrete ) }) | fmu .  ((fmu \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M))))  })
		in
			(if ((inv_VDMSet' inv_FMURef  clocks))
	 \<and> 
	((inv_VDMSet' inv_FMURef  discreteVariables)) then
			\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = M, schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = [], activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = {}, readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = clocks, inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = clocks, fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = {}, relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = {}, relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = {}, activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = {}, calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = {}, readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = discreteVariables, time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>, endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = endtime, stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = stepSize, valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r = []\<rparr>
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: runScenario: (() -> Importer)
	runScenario() ==
let scenario:Machine = createScenario() in let I:Importer = createImporter(scenario, mk_Time(10, 0), 5) in let INITIALIZED:Importer = initialization(I) in let I2:Importer = cosimulationStep(INITIALIZED) in terminate(I2)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 98:5\<close>

\<comment>\<open>VDM source: pre_runScenario: (() +> bool)
	pre_runScenario() ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 98:5\<close>
definition
	pre_runScenario :: "bool"
where
	"pre_runScenario  \<equiv> True"


\<comment>\<open>VDM source: post_runScenario: (Importer +> bool)
	post_runScenario(RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 98:5\<close>
definition
	post_runScenario :: "Importer \<Rightarrow> bool"
where
	"post_runScenario RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_runScenario` specification.\<close>
		(inv_Importer RESULT)"

definition
	runScenario :: "Importer"
where
	"runScenario  \<equiv> 
	\<comment>\<open>User defined body of runScenario.\<close>
	(
		let 
(scenario::Machine) = (createScenario )
		in
			(if (inv_Machine scenario) then
			(
		let 
(I::Importer) = (createImporter scenario   \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (10::VDMNat1), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>   (5::VDMNat1))
		in
			(if (inv_Importer I) then
			(
		let 
(INITIALIZED::Importer) = (initialization I)
		in
			(if (inv_Importer INITIALIZED) then
			(
		let 
(I2::Importer) = (cosimulationStep INITIALIZED)
		in
			(if (inv_Importer I2) then
			(terminate I2)
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

	
	
\<comment>\<open>VDM source: runAlgorithm: (Importer * seq of (Action) -> Importer)
	runAlgorithm(I, algorithm) ==
(if (algorithm = [])
then I
else let action in set {action | action in seq algorithm & isActionEnabled(I, action)} in runAlgorithm(runAction(I, action), [act | act in seq algorithm & (act <> action)]))
	measure (len algorithm)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 112:5\<close>

\<comment>\<open>VDM source: pre_runAlgorithm: (Importer * seq of (Action) +> bool)
	pre_runAlgorithm(I, algorithm) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 112:5\<close>
definition
	pre_runAlgorithm :: "Importer \<Rightarrow> Action VDMSeq \<Rightarrow> bool"
where
	"pre_runAlgorithm I   algorithm \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_runAlgorithm` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSeq' inv_Action  algorithm))"


\<comment>\<open>VDM source: post_runAlgorithm: (Importer * seq of (Action) * Importer +> bool)
	post_runAlgorithm(I, algorithm, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 112:5\<close>
definition
	post_runAlgorithm :: "Importer \<Rightarrow> Action VDMSeq \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_runAlgorithm I   algorithm   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_runAlgorithm` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSeq' inv_Action  algorithm)  \<and>  inv_Importer RESULT)"

fun
	runAlgorithm :: "Importer \<Rightarrow> Action VDMSeq \<Rightarrow> Importer"
where
	"runAlgorithm I   algorithm = 
	\<comment>\<open>User defined body of runAlgorithm.\<close>
	(
		if ((algorithm = [])) then
		(I)
		else
		((
		SOME (dummy0::Importer) .(dummy0 \<in> { (runAlgorithm (runAction I   action)   [ act . act \<leftarrow> algorithm , ((act \<in>(elems algorithm))) , (act \<noteq> action) ]) | action .  ((action \<in>{ action .   ((action \<in>(elems algorithm)))  \<and> (isActionEnabled I   action) }))  }))))"

	
	
\<comment>\<open>VDM source: runAction: (Importer * Action -> Importer)
	runAction(I, action) ==
let fmus:map (Name) to (FMU) = ((I.scenario).fmus) in (cases action :
mk_Action(<get>, fmu, port) -> (if ((fmus(fmu).mode) = <EVENT>)
then calculateOutput(I, mk_FMURef(fmu, port))
else getPort(I, mk_FMURef(fmu, port))),
mk_Action(<set>, fmu, port) -> (if ((fmus(fmu).mode) = <EVENT>)
then calculateInput(I, mk_FMURef(fmu, port))
else setPort(I, mk_FMURef(fmu, port))),
mk_Action(<step>, fmu, -) -> stepFMU(I, ((I.scenario).fmus)(fmu)),
mk_Action(<setC>, fmu, clock) -> setClock(I, ((I.scenario).fmus)(fmu), clock, true),
mk_Action(<getC>, fmu, clock) -> queryClock(I, ((I.scenario).fmus)(fmu), clock)
others -> I
end)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 124:5\<close>

\<comment>\<open>VDM source: pre_runAction: (Importer * Action +> bool)
	pre_runAction(I, action) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 124:5\<close>
definition
	pre_runAction :: "Importer \<Rightarrow> Action \<Rightarrow> bool"
where
	"pre_runAction I   action \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_runAction` specification.\<close>
		(inv_Importer I  \<and>  inv_Action action)"


\<comment>\<open>VDM source: post_runAction: (Importer * Action * Importer +> bool)
	post_runAction(I, action, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 124:5\<close>
definition
	post_runAction :: "Importer \<Rightarrow> Action \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_runAction I   action   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_runAction` specification.\<close>
		(inv_Importer I  \<and>  inv_Action action  \<and>  inv_Importer RESULT)"

definition
	runAction :: "Importer \<Rightarrow> Action \<Rightarrow> Importer"
where
	"runAction I   action \<equiv> 
	\<comment>\<open>User defined body of runAction.\<close>
	(
		let 
(fmus::(Name \<rightharpoonup> FMU)) = (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  fmus)) then
			(
		\<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. optional, union, etc.) for `Action` VDM type.\<close>)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: updateDiscreteState: (Importer * set1 of (Name) -> Importer)
	updateDiscreteState(I, fmus) ==
let M:Machine = (I.scenario) in let res:map (Name) to ((FMU * bool)) = {fmu |-> step_e((M.fmus)(fmu)) | fmu in set fmus} in let fmuMap:map (Name) to (FMU) = (((I.scenario).fmus) ++ {fmu |-> (res(fmu).#1) | fmu in set (dom res)}), eventFMUs:set of (Name) = {fmu | fmu in set (dom res) & ((res(fmu).#2) = true)} in mu(I, scenario |-> mu((I.scenario), fmus |-> fmuMap), fmusWithEvent |-> eventFMUs, activeClocks |-> {}, inactiveClocks |-> ((I.inactiveClocks) union (I.activeClocks)), activeEquations |-> {}, readyClocks |-> ((I.inactiveClocks) union (I.activeClocks)), readyEquations |-> (((I.readyEquations) union (I.calculatedEquations)) union (I.activeEquations)), calculatedEquations |-> {}, activeEquations |-> {})
	pre let relevantFMUs:set1 of (FMU) = (rng (fmus <: ((I.scenario).fmus))) in (assertFMUMode(relevantFMUs, {<EVENT>}) and fmusSynchronized(relevantFMUs))
	post let newFmus:set1 of (FMU) = (rng (fmus <: ((RESULT.scenario).fmus))), oldFMUs:set1 of (FMU) = (rng (fmus <: ((I.scenario).fmus))) in (assertFMUMode(newFmus, {<EVENT>}) and (fmusSynchronized(newFmus) and timeAdvanced(newFmus, oldFMUs, true)))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 139:5\<close>

\<comment>\<open>VDM source: pre_updateDiscreteState: (Importer * set1 of (Name) +> bool)
	pre_updateDiscreteState(I, fmus) ==
let relevantFMUs:set1 of (FMU) = (rng (fmus <: ((I.scenario).fmus))) in (assertFMUMode(relevantFMUs, {<EVENT>}) and fmusSynchronized(relevantFMUs))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 158:5\<close>
definition
	pre_updateDiscreteState :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> bool"
where
	"pre_updateDiscreteState I   fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_updateDiscreteState` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet1' (inv_Name) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_updateDiscreteState.\<close>
		(
		let 
(relevantFMUs::FMU VDMSet1) = (rng (fmus \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		in
			(if ((inv_VDMSet1' inv_FMU  relevantFMUs)) then
			((assertFMUMode relevantFMUs   {FMUMode.U_EVENT }) \<and> (fmusSynchronized relevantFMUs))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_updateDiscreteState: (Importer * set1 of (Name) * Importer +> bool)
	post_updateDiscreteState(I, fmus, RESULT) ==
let newFmus:set1 of (FMU) = (rng (fmus <: ((RESULT.scenario).fmus))), oldFMUs:set1 of (FMU) = (rng (fmus <: ((I.scenario).fmus))) in (assertFMUMode(newFmus, {<EVENT>}) and (fmusSynchronized(newFmus) and timeAdvanced(newFmus, oldFMUs, true)))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 162:5\<close>
definition
	post_updateDiscreteState :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_updateDiscreteState I   fmus   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_updateDiscreteState` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet1' (inv_Name) fmus)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_updateDiscreteState.\<close>
		(
		let 
(newFmus::FMU VDMSet1) = (rng (fmus \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		;
		
(oldFMUs::FMU VDMSet1) = (rng (fmus \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		in
			(if ((inv_VDMSet1' inv_FMU  newFmus))
	 \<and> 
	((inv_VDMSet1' inv_FMU  oldFMUs)) then
			((assertFMUMode newFmus   {FMUMode.U_EVENT }) \<and> ((fmusSynchronized newFmus) \<and> (timeAdvanced newFmus   oldFMUs   (True::\<bool>))))
		 else
			undefined
		)
		)"

definition
	updateDiscreteState :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> Importer"
where
	"updateDiscreteState I   fmus \<equiv> 
	\<comment>\<open>User defined body of updateDiscreteState.\<close>
	(
		let 
(M::Machine) = (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)
		in
			(if (inv_Machine M) then
			(
		let 
(res::(Name \<rightharpoonup> (FMU \<times> bool))) = (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ fmu .   ((fmu \<in>fmus))  } 
		{(step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))} 
		((inv_VDMSeq1' (inv_VDMChar))) 
		
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U )))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U ))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U )))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U )))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U )))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U ))) )\<and>
		 (inv_bool )
		) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: (FMU \<times> bool)) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  ((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<and> 
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )\<and>
		 (inv_bool (snd (
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))
		) then
			(
		if ((\<exists> (dummy0RANGE :: (FMU \<times> bool))  . (((
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0RANGE)))) )\<and>
		 (inv_bool (snd dummy0RANGE))
		))) \<longrightarrow> ((dummy0RANGE = (step_e ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e M) fmu))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(truecnst ))
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) 
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U )))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U ))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U )))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U )))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U )))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U ))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U ))) )\<and>
		 (inv_bool )
		) res)) then
			(
		let 
(fmuMap::(Name \<rightharpoonup> FMU)) = ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<dagger> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ fmu .   ((fmu \<in>(dom res)))  } 
		{(fst ((res fmu)))} 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and>  (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) ) then
			(
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (fst ((res fmu)))) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(truecnst )))
		;
		
(eventFMUs::Name VDMSet) = { fmu .   ((fmu \<in>(dom res)))  \<and> ((snd ((res fmu))) = (True::\<bool>)) }
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  fmuMap))
	 \<and> 
	((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) eventFMUs)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := fmuMap\<rparr>, fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := eventFMUs, activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := {}, inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)), activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := {}, readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)), readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<union> (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)), calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := {}, activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := {}\<rparr>
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

	
	
\<comment>\<open>VDM source: enterEventMode: (Importer * set1 of (Name) -> Importer)
	enterEventMode(I, fmus) ==
mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {name |-> mu(((I.scenario).fmus)(name), mode |-> <EVENT>) | name in set (dom ((I.scenario).fmus)) & (name in set fmus)})))
	pre preCoSimulationStep((I.scenario), (I.time))
	post let fmusAffected:set of (FMU) = (rng (fmus <: ((RESULT.scenario).fmus))) in (ImporterNotAffected(I, RESULT) and (assertFMUMode(fmusAffected, {<EVENT>}) and (forall m' in set fmusAffected & ((((m'.time).i) = 0) and variablesSynchronized((RESULT.scenario), {<continous>})))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 172:5\<close>

\<comment>\<open>VDM source: pre_enterEventMode: (Importer * set1 of (Name) +> bool)
	pre_enterEventMode(I, fmus) ==
preCoSimulationStep((I.scenario), (I.time))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 177:9\<close>
definition
	pre_enterEventMode :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> bool"
where
	"pre_enterEventMode I   fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_enterEventMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet1' (inv_Name) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_enterEventMode.\<close>
		(preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))"


\<comment>\<open>VDM source: post_enterEventMode: (Importer * set1 of (Name) * Importer +> bool)
	post_enterEventMode(I, fmus, RESULT) ==
let fmusAffected:set of (FMU) = (rng (fmus <: ((RESULT.scenario).fmus))) in (ImporterNotAffected(I, RESULT) and (assertFMUMode(fmusAffected, {<EVENT>}) and (forall m' in set fmusAffected & ((((m'.time).i) = 0) and variablesSynchronized((RESULT.scenario), {<continous>})))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 179:9\<close>
definition
	post_enterEventMode :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_enterEventMode I   fmus   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_enterEventMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet1' (inv_Name) fmus)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_enterEventMode.\<close>
		(
		let 
(fmusAffected::FMU VDMSet) = (rng (fmus \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))
		in
			(if ((inv_VDMSet' inv_FMU  fmusAffected)) then
			((ImporterNotAffected I   RESULT) \<and> ((assertFMUMode fmusAffected   {FMUMode.U_EVENT }) \<and> (\<forall> m' \<in> fmusAffected  . (((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m')) = (0::VDMNat)) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)   {PortType.U_continous })))))
		 else
			undefined
		)
		)"

definition
	enterEventMode :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> Importer"
where
	"enterEventMode I   fmus \<equiv> 
	\<comment>\<open>User defined body of enterEventMode.\<close>
	(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<dagger> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ name .   (name \<in>(dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))  \<and> (name \<in> fmus) } 
		{ (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr> | (dummy0RANGE :: FMU) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) )))  \<and> (name \<in> fmus) } 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and>  (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))))) ) then
			(
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_EVENT \<rparr>) \<and> (name \<in> fmus))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and> (inv_bool (
		if ((\<exists> name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))  . ((name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and> (name \<in> fmus)))) then
		((True::\<bool>))
		else
		(undefined))) then
			(
		if ((\<exists> name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))  . ((name \<in> (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and> (name \<in> fmus)))) then
		((True::\<bool>))
		else
		(undefined))
		 else
			undefined
		)
		)))\<rparr>\<rparr>"

	
	
\<comment>\<open>VDM source: enterStepMode: (Importer * set1 of (Name) -> Importer)
	enterStepMode(I, fmus) ==
mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {name |-> mu(((I.scenario).fmus)(name), mode |-> <STEP>, time |-> mk_Time(((((I.scenario).fmus)(name).time).r), 0)) | name in set fmus})), time |-> mk_Time(((I.time).r), 0))
	pre let relevantFMUs:set1 of (FMU) = (rng (fmus <: ((I.scenario).fmus))) in (assertFMUMode(relevantFMUs, {<INIT>, <EVENT>}) and (fmusSynchronized(relevantFMUs) and variablesSynchronized((I.scenario), {<continous>})))
	post postStepMode(RESULT, I, fmus)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 188:5\<close>

\<comment>\<open>VDM source: pre_enterStepMode: (Importer * set1 of (Name) +> bool)
	pre_enterStepMode(I, fmus) ==
let relevantFMUs:set1 of (FMU) = (rng (fmus <: ((I.scenario).fmus))) in (assertFMUMode(relevantFMUs, {<INIT>, <EVENT>}) and (fmusSynchronized(relevantFMUs) and variablesSynchronized((I.scenario), {<continous>})))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 197:9\<close>
definition
	pre_enterStepMode :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> bool"
where
	"pre_enterStepMode I   fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_enterStepMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet1' (inv_Name) fmus))  \<and> 
		\<comment>\<open>User defined body of pre_enterStepMode.\<close>
		(
		let 
(relevantFMUs::FMU VDMSet1) = (rng (fmus \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		in
			(if ((inv_VDMSet1' inv_FMU  relevantFMUs)) then
			((assertFMUMode relevantFMUs   {FMUMode.U_INIT  , FMUMode.U_EVENT }) \<and> ((fmusSynchronized relevantFMUs) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   {PortType.U_continous })))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_enterStepMode: (Importer * set1 of (Name) * Importer +> bool)
	post_enterStepMode(I, fmus, RESULT) ==
postStepMode(RESULT, I, fmus)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 201:10\<close>
definition
	post_enterStepMode :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_enterStepMode I   fmus   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_enterStepMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet1' (inv_Name) fmus)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_enterStepMode.\<close>
		(postStepMode RESULT   I   fmus)"

definition
	enterStepMode :: "Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> Importer"
where
	"enterStepMode I   fmus \<equiv> 
	\<comment>\<open>User defined body of enterStepMode.\<close>
	(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<dagger> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ name .   ((name \<in>fmus))  } 
		{(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>} 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and>  (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) ) then
			(
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_STEP , time\<^sub>F\<^sub>M\<^sub>U := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))))), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(truecnst )))\<rparr>, time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>"

	
	
\<comment>\<open>VDM source: activateClocks: (Importer * seq of (FMURef) -> Importer)
	activateClocks(I, clocks) ==
(if (clocks = [])
then I
else let clock:FMURef = (hd clocks) in let I1:Importer = setClock(I, ((I.scenario).fmus)((clock.name)), (clock.ref), true) in activateClocks(I1, (tl clocks)))
	pre let clockSet:set of (FMURef) = {clock | clock in seq clocks} in ((clockSet subset ((I.readyClocks) inter (I.relevantInputClocks))) and let fmusOfClocks:set of (FMU) = {((I.scenario).fmus)((clock.name)) | clock in seq clocks} in assertFMUMode(fmusOfClocks, {<EVENT>}))
	post let clockSet:set of (FMURef) = {clock | clock in seq clocks} in ((clockSet subset (RESULT.activeClocks)) and (((clockSet <> {}) => (not (clockSet subset (RESULT.readyClocks)))) and (((clockSet <> {}) => (not (clockSet subset (RESULT.relevantInputClocks)))) and let fmusOfClocks:set of (FMU) = {((RESULT.scenario).fmus)((clock.name)) | clock in seq clocks} in assertFMUMode(fmusOfClocks, {<EVENT>}))))
	measure (len clocks)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 208:5\<close>

\<comment>\<open>VDM source: pre_activateClocks: (Importer * seq of (FMURef) +> bool)
	pre_activateClocks(I, clocks) ==
let clockSet:set of (FMURef) = {clock | clock in seq clocks} in ((clockSet subset ((I.readyClocks) inter (I.relevantInputClocks))) and let fmusOfClocks:set of (FMU) = {((I.scenario).fmus)((clock.name)) | clock in seq clocks} in assertFMUMode(fmusOfClocks, {<EVENT>}))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 216:9\<close>
definition
	pre_activateClocks :: "Importer \<Rightarrow> FMURef VDMSeq \<Rightarrow> bool"
where
	"pre_activateClocks I   clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_activateClocks` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSeq' inv_FMURef  clocks))  \<and> 
		\<comment>\<open>User defined body of pre_activateClocks.\<close>
		(
		let 
(clockSet::FMURef VDMSet) = { clock .   ((clock \<in>(elems clocks)))  }
		in
			(if ((inv_VDMSet' inv_FMURef  clockSet)) then
			((clockSet \<subseteq> ((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<inter> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> (
		let 
(fmusOfClocks::FMU VDMSet) = { ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock)) | clock .  ((clock \<in>(elems clocks)))  }
		in
			(if ((inv_VDMSet' inv_FMU  fmusOfClocks)) then
			(assertFMUMode fmusOfClocks   {FMUMode.U_EVENT })
		 else
			undefined
		)
		))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_activateClocks: (Importer * seq of (FMURef) * Importer +> bool)
	post_activateClocks(I, clocks, RESULT) ==
let clockSet:set of (FMURef) = {clock | clock in seq clocks} in ((clockSet subset (RESULT.activeClocks)) and (((clockSet <> {}) => (not (clockSet subset (RESULT.readyClocks)))) and (((clockSet <> {}) => (not (clockSet subset (RESULT.relevantInputClocks)))) and let fmusOfClocks:set of (FMU) = {((RESULT.scenario).fmus)((clock.name)) | clock in seq clocks} in assertFMUMode(fmusOfClocks, {<EVENT>}))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 221:9\<close>
definition
	post_activateClocks :: "Importer \<Rightarrow> FMURef VDMSeq \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_activateClocks I   clocks   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_activateClocks` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSeq' inv_FMURef  clocks)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_activateClocks.\<close>
		(
		let 
(clockSet::FMURef VDMSet) = { clock .   ((clock \<in>(elems clocks)))  }
		in
			(if ((inv_VDMSet' inv_FMURef  clockSet)) then
			((clockSet \<subseteq> (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (((clockSet \<noteq> {}) \<longrightarrow> (\<not> (clockSet \<subseteq> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and> (((clockSet \<noteq> {}) \<longrightarrow> (\<not> (clockSet \<subseteq> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))) \<and> (
		let 
(fmusOfClocks::FMU VDMSet) = { ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock)) | clock .  ((clock \<in>(elems clocks)))  }
		in
			(if ((inv_VDMSet' inv_FMU  fmusOfClocks)) then
			(assertFMUMode fmusOfClocks   {FMUMode.U_EVENT })
		 else
			undefined
		)
		))))
		 else
			undefined
		)
		)"

fun
	activateClocks :: "Importer \<Rightarrow> FMURef VDMSeq \<Rightarrow> Importer"
where
	"activateClocks I   clocks = 
	\<comment>\<open>User defined body of activateClocks.\<close>
	(
		if ((clocks = [])) then
		(I)
		else
		((
		let 
(clock::FMURef) = (hd clocks)
		in
			(if (inv_FMURef clock) then
			(
		let 
(I1::Importer) = (setClock I   ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f clock)   (True::\<bool>))
		in
			(if (inv_Importer I1) then
			(activateClocks I1   (tl clocks))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)))"

	
	
\<comment>\<open>VDM source: initialization: (Importer -> Importer)
	initialization(I) ==
let I1:Importer = initializeData(I) in let I2:Importer = createSchedule(I1) in enterStepMode(I2, (dom ((I2.scenario).fmus)))
	pre preInitialization(I)
	post (preCoSimulationStep((RESULT.scenario), (RESULT.time)) and (ImporterNotAffected(RESULT, I) and ((RESULT.time) = mk_Time(0, 0))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 232:5\<close>

\<comment>\<open>VDM source: pre_initialization: (Importer +> bool)
	pre_initialization(I) ==
preInitialization(I)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 248:9\<close>
definition
	pre_initialization :: "Importer \<Rightarrow> bool"
where
	"pre_initialization I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_initialization` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_initialization.\<close>
		(preInitialization I)"


\<comment>\<open>VDM source: post_initialization: (Importer * Importer +> bool)
	post_initialization(I, RESULT) ==
(preCoSimulationStep((RESULT.scenario), (RESULT.time)) and (ImporterNotAffected(RESULT, I) and ((RESULT.time) = mk_Time(0, 0))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 250:9\<close>
definition
	post_initialization :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_initialization I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_initialization` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_initialization.\<close>
		((preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> ((ImporterNotAffected RESULT   I) \<and> \<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)   \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>)))"

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
			(enterStepMode I2   (dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I2))))
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
let connections:map (FMURef) to (FMURef) = ((I.scenario).connections) in let outputs:set1 of (Action) = {mk_Action(<get>, (output.name), (output.ref)) | output in set (dom connections) & ((derefOutput(((I.scenario).fmus)((output.name)), (output.ref)).type) = <continous>)}, inputs:set1 of (Action) = {mk_Action(<set>, (input.name), (input.ref)) | input in set (rng connections) & ((derefInput(((I.scenario).fmus)((input.name)), (input.ref)).type) = <continous>)}, steps:set1 of (Action) = {mk_Action(<step>, (fmu.name), 1) | fmu in set (rng ((I.scenario).fmus))} in let actions:seq1 of (Action) = [act | act in set ((outputs union inputs) union steps)] in runAlgorithm(I, actions)
	pre preCoSimulationStep((I.scenario), (I.time))
	post postCosimulationStep((RESULT.scenario), (rng ((I.scenario).fmus)))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 258:5\<close>

\<comment>\<open>VDM source: pre_cosimStep: (Importer +> bool)
	pre_cosimStep(I) ==
preCoSimulationStep((I.scenario), (I.time))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 271:9\<close>
definition
	pre_cosimStep :: "Importer \<Rightarrow> bool"
where
	"pre_cosimStep I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_cosimStep` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_cosimStep.\<close>
		(preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))"


\<comment>\<open>VDM source: post_cosimStep: (Importer * Importer +> bool)
	post_cosimStep(I, RESULT) ==
postCosimulationStep((RESULT.scenario), (rng ((I.scenario).fmus)))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 272:10\<close>
definition
	post_cosimStep :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_cosimStep I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_cosimStep` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_cosimStep.\<close>
		(postCosimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)   (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))"

definition
	cosimStep :: "Importer \<Rightarrow> Importer"
where
	"cosimStep I \<equiv> 
	\<comment>\<open>User defined body of cosimStep.\<close>
	(
		let 
(connections::(FMURef \<rightharpoonup> FMURef)) = (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))
		in
			(if ((inv_Map inv_FMURef  inv_FMURef  connections)) then
			(
		let 
(outputs::Action VDMSet1) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_get ActionType.U_get , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output)\<rparr> | output .  ((output \<in>(dom connections)))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (derefOutput ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f output))) = PortType.U_continous ) }
		;
		
(inputs::Action VDMSet1) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_set ActionType.U_set , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input)\<rparr> | input .  ((input \<in>(rng connections)))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e (derefInput ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f input))) = PortType.U_continous ) }
		;
		
(steps::Action VDMSet1) = { \<lparr>actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = ActionType.U_step ActionType.U_step , fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (name\<^sub>F\<^sub>M\<^sub>U fmu), port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n = (1::VDMNat1)\<rparr> | fmu .  ((fmu \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))))  }
		in
			(if ((inv_VDMSet1' inv_Action  outputs))
	 \<and> 
	((inv_VDMSet1' inv_Action  inputs))
	 \<and> 
	((inv_VDMSet1' inv_Action  steps)) then
			(
		let 
(actions::Action VDMSeq1) = [ act . act \<leftarrow> sorted_list_of_set (((outputs \<union> inputs) \<union> steps)) , ((act \<in>((outputs \<union> inputs) \<union> steps))) ]
	\<comment>\<open>`Set bind `(act \<in> ((outputs \<union> inputs) \<union> steps))` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>((outputs \<union> inputs) \<union> steps)\<close>}   has a VDM ord_ predicate.\<close> 
		in
			(if ((inv_VDMSeq1' inv_Action  actions)) then
			(runAlgorithm I   actions)
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

	
	
\<comment>\<open>VDM source: terminate: (Importer -> Importer)
	terminate(I) ==
mu(I, scenario |-> mu((I.scenario), fmus |-> {name |-> mu(((I.scenario).fmus)(name), mode |-> <DONE>) | name in set (dom ((I.scenario).fmus))}))
	pre preTermination(I)
	post postTermination(RESULT, I)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 274:5\<close>

\<comment>\<open>VDM source: pre_terminate: (Importer +> bool)
	pre_terminate(I) ==
preTermination(I)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 277:9\<close>
definition
	pre_terminate :: "Importer \<Rightarrow> bool"
where
	"pre_terminate I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_terminate` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_terminate.\<close>
		(preTermination I)"


\<comment>\<open>VDM source: post_terminate: (Importer * Importer +> bool)
	post_terminate(I, RESULT) ==
postTermination(RESULT, I)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 278:10\<close>
definition
	post_terminate :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_terminate I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_terminate` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_terminate.\<close>
		(postTermination RESULT   I)"

definition
	terminate :: "Importer \<Rightarrow> Importer"
where
	"terminate I \<equiv> 
	\<comment>\<open>User defined body of terminate.\<close>
	(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ name .   ((name \<in>(dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))))  } 
		{(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>} 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and>  (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) ) then
			(
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) name))\<lparr>mode\<^sub>F\<^sub>M\<^sub>U := FMUMode.U_DONE \<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(truecnst ))\<rparr>\<rparr>"

	
	
\<comment>\<open>VDM source: cosimulationStep: (Importer -> Importer)
	cosimulationStep(I) ==
let mk_(I1, clocksToTick):(Importer * set of (FMURef)) = tickingClocks(I) in let eventDetected:bool = ((clocksToTick <> {}) or ((I1.fmusWithEvent) <> {})) in let I2:Importer = (if eventDetected
then clockedSimulationAlgorithm(I1, clocksToTick)
else I) in let I3:Importer = mu(I2, stepSize |-> stepnegotiation(I2)) in let I4:Importer = cosimStep(I3) in let I5:Importer = mu(I4, scenario |-> mu((I4.scenario), fmus |-> {name |-> mu(((I4.scenario).fmus)(name), stepped |-> false) | name in set (dom ((I4.scenario).fmus))}), time |-> mk_Time((((I4.time).r) + (I4.stepSize)), ((I4.time).i))) in (if ((I5.endtime) > (I5.time))
then cosimulationStep(I5)
else I5)
	pre preCoSimulationStep((I.scenario), (I.time))
	post (preCoSimulationStep((RESULT.scenario), (RESULT.time)) and ((((I.time).r) <= ((RESULT.time).r)) and (ImporterNotAffected(I, RESULT) and let M':set1 of (FMU) = (rng ((RESULT.scenario).fmus)), M:set1 of (FMU) = (rng ((I.scenario).fmus)) in timeAdvanced(M', M, false))))
	measure (((I.endtime).r) - ((I.time).r))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 284:5\<close>

\<comment>\<open>VDM source: pre_cosimulationStep: (Importer +> bool)
	pre_cosimulationStep(I) ==
preCoSimulationStep((I.scenario), (I.time))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 315:9\<close>
definition
	pre_cosimulationStep :: "Importer \<Rightarrow> bool"
where
	"pre_cosimulationStep I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_cosimulationStep` specification.\<close>
		(inv_Importer I)  \<and> 
		\<comment>\<open>User defined body of pre_cosimulationStep.\<close>
		(preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))"


\<comment>\<open>VDM source: post_cosimulationStep: (Importer * Importer +> bool)
	post_cosimulationStep(I, RESULT) ==
(preCoSimulationStep((RESULT.scenario), (RESULT.time)) and ((((I.time).r) <= ((RESULT.time).r)) and (ImporterNotAffected(I, RESULT) and let M':set1 of (FMU) = (rng ((RESULT.scenario).fmus)), M:set1 of (FMU) = (rng ((I.scenario).fmus)) in timeAdvanced(M', M, false))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 317:9\<close>
definition
	post_cosimulationStep :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_cosimulationStep I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_cosimulationStep` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_cosimulationStep.\<close>
		((preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<le> (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) \<and> ((ImporterNotAffected I   RESULT) \<and> (
		let 
(M'::FMU VDMSet1) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)))
		;
		
(M::FMU VDMSet1) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		in
			(if ((inv_VDMSet1' inv_FMU  M'))
	 \<and> 
	((inv_VDMSet1' inv_FMU  M)) then
			(timeAdvanced M'   M   (False::\<bool>))
		 else
			undefined
		)
		))))"

fun
	cosimulationStep :: "Importer \<Rightarrow> Importer"
where
	"cosimulationStep I = 
	\<comment>\<open>User defined body of cosimulationStep.\<close>
	(
		let 
(I1::Importer) = (tickingClocks I);
(clocksToTick::FMURef VDMSet) = (tickingClocks I)
		in
			(if (
		( (( (((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_VDMSet' inv_TimeBasedClock  (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) (inv_VDMSet' inv_FMURef ) (timedClockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) )) \<and> 
		 ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) (inv_VDMReal) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMSeq1' (inv_VDMChar))) (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_FMURef  (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) )) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0))))) )) \<and> 
		 ((inv_VDMReal (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) \<and> 
		 ((inv_Map inv_FMURef  inv_Value  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r (fst dummy0)))) )\<and>
		 (inv_VDMSet' inv_FMURef  (snd dummy0))
		)) then
			(
		let 
(eventDetected::bool) = ((clocksToTick \<noteq> {}) \<or> ((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I1) \<noteq> {}))
		in
			(if ((inv_bool eventDetected)) then
			(
		let 
(I2::Importer) = (
		if (eventDetected) then
		((clockedSimulationAlgorithm I1   clocksToTick))
		else
		(I))
		in
			(if (inv_Importer I2) then
			(
		let 
(I3::Importer) = (I2)\<lparr>stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (stepnegotiation I2)\<rparr>
		in
			(if (inv_Importer I3) then
			(
		let 
(I4::Importer) = (cosimStep I3)
		in
			(if (inv_Importer I4) then
			(
		let 
(I5::Importer) = (I4)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ name .   ((name \<in>(dom (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)))))  } 
		{(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>} 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and>  (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined)))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))))) ) then
			(
		if ((\<exists> (dummy0RANGE :: FMU)  . ((( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<longrightarrow> ((dummy0RANGE = (((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) name))\<lparr>stepped\<^sub>F\<^sub>M\<^sub>U := (False::\<bool>)\<rparr>) \<and> (True::\<bool>))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(truecnst ))\<rparr>, time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)) + (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4)), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I4))\<rparr>\<rparr>
		in
			(if (inv_Importer I5) then
			(
		if (\<comment>\<open>Transform a VDM `>` expression into a reversed `ord_Time` call\<close>
	(ord_Time (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I5)   (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I5))) then
		((cosimulationStep I5))
		else
		(I5))
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
		)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: stepnegotiation: (Importer -> real)
	stepnegotiation(I) ==
let maxSteps:set1 of (real) = {(fmu.maxStep) | fmu in set (rng ((I.scenario).fmus))}, scheduling:set of (real) = {(t - ((I.time).r)) | t in set (rng (I.schedule))}, timeLeft:real = (((I.endtime).r) - ((I.time).r)) in selectMinStep(((maxSteps union scheduling) union {timeLeft}))
	post ((RESULT >= 0) and ((forall fmu in set (rng ((I.scenario).fmus)) & ((fmu.maxStep) >= RESULT)) and ((forall clockTicks in set (rng (I.schedule)) & ((clockTicks - ((I.time).r)) >= RESULT)) and ((RESULT <= (I.stepSize)) and (RESULT <= (((I.endtime).r) - ((I.time).r)))))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 327:5\<close>

\<comment>\<open>VDM source: pre_stepnegotiation: (Importer +> bool)
	pre_stepnegotiation(I) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 327:5\<close>
definition
	pre_stepnegotiation :: "Importer \<Rightarrow> bool"
where
	"pre_stepnegotiation I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_stepnegotiation` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_stepnegotiation: (Importer * real +> bool)
	post_stepnegotiation(I, RESULT) ==
((RESULT >= 0) and ((forall fmu in set (rng ((I.scenario).fmus)) & ((fmu.maxStep) >= RESULT)) and ((forall clockTicks in set (rng (I.schedule)) & ((clockTicks - ((I.time).r)) >= RESULT)) and ((RESULT <= (I.stepSize)) and (RESULT <= (((I.endtime).r) - ((I.time).r)))))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 334:9\<close>
definition
	post_stepnegotiation :: "Importer \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"post_stepnegotiation I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_stepnegotiation` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMReal RESULT))  \<and> 
		\<comment>\<open>User defined body of post_stepnegotiation.\<close>
		((RESULT \<ge> (0::VDMNat)) \<and> ((\<forall> fmu \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))  . ((maxStep\<^sub>F\<^sub>M\<^sub>U fmu) \<ge> RESULT)) \<and> ((\<forall> clockTicks \<in> (rng (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))  . ((clockTicks - (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<ge> RESULT)) \<and> ((RESULT \<le> (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> (RESULT \<le> ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) - (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))))))"

definition
	stepnegotiation :: "Importer \<Rightarrow> VDMReal"
where
	"stepnegotiation I \<equiv> 
	\<comment>\<open>User defined body of stepnegotiation.\<close>
	(
		let 
(maxSteps::VDMReal VDMSet1) = { (maxStep\<^sub>F\<^sub>M\<^sub>U fmu) | fmu .  ((fmu \<in>(rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))))  }
		;
		
(scheduling::VDMReal VDMSet) = { (t - (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) | t .  ((t \<in>(rng (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))  }
		;
		
(timeLeft::VDMReal) = ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) - (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		in
			(if ((inv_VDMSet1' (inv_VDMReal) maxSteps))
	 \<and> 
	((inv_VDMSet' (inv_VDMReal) scheduling))
	 \<and> 
	((inv_VDMReal timeLeft)) then
			(selectMinStep ((maxSteps \<union> scheduling) \<union> {timeLeft}))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: queryClock: (Importer * FMU * Ref -> Importer)
	queryClock(I, fmu, clock) ==
let mk_(fmuUpdated, val):(FMU * Value) = get_cm(fmu, clock), fmuref:FMURef = mk_FMURef((fmu.name), clock) in let connectedClock:FMURef = ((I.scenario).clockConnections)(fmuref) in let I1:Importer = mu(I, valueMap |-> ((I.valueMap) ++ {connectedClock |-> val}), relevantOutputClocks |-> ((I.relevantOutputClocks) \ {fmuref}), relevantInputClocks |-> ((I.relevantInputClocks) union {connectedClock})) in updateEnvironmentClock(I1, fmuUpdated, clock, (val.value))
	pre ((mk_FMURef((fmu.name), clock) in set (I.relevantOutputClocks)) and ((clock in set {(c.ref) | c in set (fmu.clocks) & ((c.type) = <output>)}) and preGetCI(I, fmu, clock)))
	post (mk_FMURef((fmu.name), clock) not in set (RESULT.relevantOutputClocks))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 346:5\<close>

\<comment>\<open>VDM source: pre_queryClock: (Importer * FMU * Ref +> bool)
	pre_queryClock(I, fmu, clock) ==
((mk_FMURef((fmu.name), clock) in set (I.relevantOutputClocks)) and ((clock in set {(c.ref) | c in set (fmu.clocks) & ((c.type) = <output>)}) and preGetCI(I, fmu, clock)))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 359:9\<close>
definition
	pre_queryClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_queryClock I   fmu   clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_queryClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock))  \<and> 
		\<comment>\<open>User defined body of pre_queryClock.\<close>
		((\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> \<in> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> ((clock \<in> { (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) = Causality.U_output ) }) \<and> (preGetCI I   fmu   clock)))"


\<comment>\<open>VDM source: post_queryClock: (Importer * FMU * Ref * Importer +> bool)
	post_queryClock(I, fmu, clock, RESULT) ==
(mk_FMURef((fmu.name), clock) not in set (RESULT.relevantOutputClocks))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 361:36\<close>
definition
	post_queryClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_queryClock I   fmu   clock   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_queryClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_queryClock.\<close>
		(\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr> \<notin> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))"

definition
	queryClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> Importer"
where
	"queryClock I   fmu   clock \<equiv> 
	\<comment>\<open>User defined body of queryClock.\<close>
	(
		let 
(fmuUpdated::FMU) = (get_cm fmu   clock);
(val::Value) = (get_cm fmu   clock)
		;
		
(fmuref::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) )\<and>
		  ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0))))) )) )
		))
	 \<and> 
	(inv_FMURef fmuref) then
			(
		let 
(connectedClock::FMURef) = (the(((clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) fmuref)))
		in
			(if (inv_FMURef connectedClock) then
			(
		let 
(I1::Importer) = (I)\<lparr>valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<dagger> [connectedClock\<mapsto>val]), relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - {fmuref}), relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> {connectedClock})\<rparr>
		in
			(if (inv_Importer I1) then
			(updateEnvironmentClock I1   fmuUpdated   clock   (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val))
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
	pre let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((fmuRef in set (I.relevantInputClocks)) and ((val <=> (fmuRef in set ((I.inactiveClocks) inter (I.readyClocks)))) and ((fmu.mode) = <EVENT>)))
	post let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((fmuRef not in set (RESULT.relevantInputClocks)) and (((card (RESULT.relevantInputClocks)) < (card (I.relevantInputClocks))) and (((((RESULT.scenario).fmus)((fmu.name)).mode) = <EVENT>) and (val <=> ((fmuRef in set (RESULT.activeClocks)) and (fmuRef not in set ((RESULT.readyClocks) union (RESULT.inactiveClocks))))))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 366:5\<close>

\<comment>\<open>VDM source: pre_setClock: (Importer * FMU * Ref * bool +> bool)
	pre_setClock(I, fmu, clock, val) ==
let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((fmuRef in set (I.relevantInputClocks)) and ((val <=> (fmuRef in set ((I.inactiveClocks) inter (I.readyClocks)))) and ((fmu.mode) = <EVENT>)))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 378:5\<close>
definition
	pre_setClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_setClock I   fmu   clock   val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_setClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val))  \<and> 
		\<comment>\<open>User defined body of pre_setClock.\<close>
		(
		let 
(fmuRef::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef fmuRef) then
			((fmuRef \<in> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> ((val \<longleftrightarrow> (fmuRef \<in> ((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<inter> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT )))
		 else
			undefined
		)
		)"


\<comment>\<open>VDM source: post_setClock: (Importer * FMU * Ref * bool * Importer +> bool)
	post_setClock(I, fmu, clock, val, RESULT) ==
let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((fmuRef not in set (RESULT.relevantInputClocks)) and (((card (RESULT.relevantInputClocks)) < (card (I.relevantInputClocks))) and (((((RESULT.scenario).fmus)((fmu.name)).mode) = <EVENT>) and (val <=> ((fmuRef in set (RESULT.activeClocks)) and (fmuRef not in set ((RESULT.readyClocks) union (RESULT.inactiveClocks))))))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 383:5\<close>
definition
	post_setClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_setClock I   fmu   clock   val   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_setClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val)  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_setClock.\<close>
		(
		let 
(fmuRef::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef fmuRef) then
			((fmuRef \<notin> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (((vdm_card (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) < (vdm_card (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) (name\<^sub>F\<^sub>M\<^sub>U fmu))))) = FMUMode.U_EVENT ) \<and> (val \<longleftrightarrow> ((fmuRef \<in> (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (fmuRef \<notin> ((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT) \<union> (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))))))
		 else
			undefined
		)
		)"

definition
	setClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> Importer"
where
	"setClock I   fmu   clock   val \<equiv> 
	\<comment>\<open>User defined body of setClock.\<close>
	(
		let 
(fmuUpdated::FMU) = (set_cm fmu   clock   val)
		;
		
(fmuref::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMU fmuUpdated)
	 \<and> 
	(inv_FMURef fmuref) then
			(
		let 
(feedthroughClocks::FMURef VDMSet) = { \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c)\<rparr> | c .  ((c \<in>(clocks\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> (clock \<in> (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c)) }
		in
			(if ((inv_VDMSet' inv_FMURef  feedthroughClocks)) then
			(
		let 
(I1::Importer) = (I)\<lparr>valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ({fmuref} -\<triangleleft> (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)), relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - {fmuref}), relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> feedthroughClocks)\<rparr>
		in
			(if (inv_Importer I1) then
			(updateEnvironmentClock I1   fmuUpdated   clock   val)
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
let value:Value = (I.valueMap)(port) in let fmu:FMU = set_m(((I.scenario).fmus)((port.name)), (port.ref), value) in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmu.name) |-> fmu})), valueMap |-> ({port} <-: (I.valueMap)))
	pre preSetI(I, ((I.scenario).fmus)((port.name)), (port.ref))
	post (fmusNotAffected((rng ({(port.name)} <-: ((I.scenario).fmus))), (rng ({(port.name)} <-: ((RESULT.scenario).fmus)))) and (((card (dom (RESULT.valueMap))) + 1) = (card (dom (I.valueMap)))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 390:5\<close>

\<comment>\<open>VDM source: pre_setPort: (Importer * FMURef +> bool)
	pre_setPort(I, port) ==
preSetI(I, ((I.scenario).fmus)((port.name)), (port.ref))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 398:9\<close>
definition
	pre_setPort :: "Importer \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_setPort I   port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_setPort` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef port)  \<and> 
		\<comment>\<open>User defined body of pre_setPort.\<close>
		(preSetI I   ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))"


\<comment>\<open>VDM source: post_setPort: (Importer * FMURef * Importer +> bool)
	post_setPort(I, port, RESULT) ==
(fmusNotAffected((rng ({(port.name)} <-: ((I.scenario).fmus))), (rng ({(port.name)} <-: ((RESULT.scenario).fmus)))) and (((card (dom (RESULT.valueMap))) + 1) = (card (dom (I.valueMap)))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 400:5\<close>
definition
	post_setPort :: "Importer \<Rightarrow> FMURef \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_setPort I   port   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_setPort` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef port  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_setPort.\<close>
		((fmusNotAffected (rng ({(name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))   (rng ({(name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))) \<and> (((vdm_card (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) + (1::VDMNat1)) = (vdm_card (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))))"

definition
	setPort :: "Importer \<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"setPort I   port \<equiv> 
	\<comment>\<open>User defined body of setPort.\<close>
	(
		let 
(value::Value) = (the(((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) port)))
		in
			(if (inv_Value value) then
			(
		let 
(fmu::FMU) = (set_m ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)   value)
		in
			(if (inv_FMU fmu) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U fmu)\<mapsto>fmu])\<rparr>, valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ({port} -\<triangleleft> (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<rparr>
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
	pre preGetI(I, ((I.scenario).fmus)((port.name)), (port.ref))
	post (fmusNotAffected((rng ({(port.name)} <-: ((I.scenario).fmus))), (rng ({(port.name)} <-: ((RESULT.scenario).fmus)))) and ((card (dom (RESULT.valueMap))) = ((card (dom (I.valueMap))) + 1)))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 404:5\<close>

\<comment>\<open>VDM source: pre_getPort: (Importer * FMURef +> bool)
	pre_getPort(I, port) ==
preGetI(I, ((I.scenario).fmus)((port.name)), (port.ref))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 412:9\<close>
definition
	pre_getPort :: "Importer \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_getPort I   port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_getPort` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef port)  \<and> 
		\<comment>\<open>User defined body of pre_getPort.\<close>
		(preGetI I   ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))"


\<comment>\<open>VDM source: post_getPort: (Importer * FMURef * Importer +> bool)
	post_getPort(I, port, RESULT) ==
(fmusNotAffected((rng ({(port.name)} <-: ((I.scenario).fmus))), (rng ({(port.name)} <-: ((RESULT.scenario).fmus)))) and ((card (dom (RESULT.valueMap))) = ((card (dom (I.valueMap))) + 1)))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 414:5\<close>
definition
	post_getPort :: "Importer \<Rightarrow> FMURef \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_getPort I   port   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_getPort` specification.\<close>
		(inv_Importer I  \<and>  inv_FMURef port  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_getPort.\<close>
		((fmusNotAffected (rng ({(name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))   (rng ({(name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))) \<and> ((vdm_card (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))) = ((vdm_card (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) + (1::VDMNat1))))"

definition
	getPort :: "Importer \<Rightarrow> FMURef \<Rightarrow> Importer"
where
	"getPort I   port \<equiv> 
	\<comment>\<open>User defined body of getPort.\<close>
	(
		let 
(fmu::FMU) = (get_m ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port));
(val::Value) = (get_m ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f port))
		;
		
(connectedInput::FMURef) = (the(((connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) port)))
		in
			(if (
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) )\<and>
		  ((((case (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) of
		 ValueType.U_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) \<Rightarrow> (inv_bool (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))
		  | ValueType.U_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)) \<Rightarrow> (inv_VDMReal (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0)))
		 ))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (snd dummy0))))) )) )
		))
	 \<and> 
	(inv_FMURef connectedInput) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U fmu)\<mapsto>fmu])\<rparr>, valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<dagger> [connectedInput\<mapsto>val])\<rparr>
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: stepFMU: (Importer * FMU -> Importer)
	stepFMU(I, fmu) ==
let mk_(fmuUpdated, step, event):(FMU * real * bool) = step_tm(fmu, (I.stepSize)) in mu(I, scenario |-> mu((I.scenario), fmus |-> (((I.scenario).fmus) ++ {(fmuUpdated.name) |-> fmuUpdated})), fmusWithEvent |-> (if event
then ((I.fmusWithEvent) union {(fmu.name)})
else (I.fmusWithEvent)), stepSize |-> step)
	pre preStepI(I, fmu)
	post (fmusNotAffected((rng ({(fmu.name)} <-: ((I.scenario).fmus))), (rng ({(fmu.name)} <-: ((RESULT.scenario).fmus)))) and (((I.fmusWithEvent) subset (RESULT.fmusWithEvent)) and (((I.stepSize) >= (RESULT.stepSize)) and ImporterNotAffected(I, RESULT))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 420:5\<close>

\<comment>\<open>VDM source: pre_stepFMU: (Importer * FMU +> bool)
	pre_stepFMU(I, fmu) ==
preStepI(I, fmu)\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 428:9\<close>
definition
	pre_stepFMU :: "Importer \<Rightarrow> FMU \<Rightarrow> bool"
where
	"pre_stepFMU I   fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_stepFMU` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu)  \<and> 
		\<comment>\<open>User defined body of pre_stepFMU.\<close>
		(preStepI I   fmu)"


\<comment>\<open>VDM source: post_stepFMU: (Importer * FMU * Importer +> bool)
	post_stepFMU(I, fmu, RESULT) ==
(fmusNotAffected((rng ({(fmu.name)} <-: ((I.scenario).fmus))), (rng ({(fmu.name)} <-: ((RESULT.scenario).fmus)))) and (((I.fmusWithEvent) subset (RESULT.fmusWithEvent)) and (((I.stepSize) >= (RESULT.stepSize)) and ImporterNotAffected(I, RESULT))))\<close>
\<comment>\<open>in 'DEFAULT' (Importer.vdmsl) at line 430:5\<close>
definition
	post_stepFMU :: "Importer \<Rightarrow> FMU \<Rightarrow> Importer \<Rightarrow> bool"
where
	"post_stepFMU I   fmu   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_stepFMU` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  inv_Importer RESULT)  \<and> 
		\<comment>\<open>User defined body of post_stepFMU.\<close>
		((fmusNotAffected (rng ({(name\<^sub>F\<^sub>M\<^sub>U fmu)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))   (rng ({(name\<^sub>F\<^sub>M\<^sub>U fmu)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT))))) \<and> (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<subseteq> (fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (((stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<ge> (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r RESULT)) \<and> (ImporterNotAffected I   RESULT))))"

definition
	stepFMU :: "Importer \<Rightarrow> FMU \<Rightarrow> Importer"
where
	"stepFMU I   fmu \<equiv> 
	\<comment>\<open>User defined body of stepFMU.\<close>
	(
		let 
(step::VDMReal) = (step_tm fmu   (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I));
(event::bool) = (step_tm fmu   (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I));
(fmuUpdated::FMU) = (step_tm fmu   (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))
		in
			(if (
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U (fst dummy0))))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U (fst dummy0)))) )\<and>
		 (inv_VDMReal (fst (snd dummy0)))\<and>
		 (inv_bool (snd (snd dummy0)))
		)) then
			(I)\<lparr>scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))\<lparr>fmus\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<dagger> [(name\<^sub>F\<^sub>M\<^sub>U fmuUpdated)\<mapsto>fmuUpdated])\<rparr>, fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := (
		if (event) then
		(((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> {(name\<^sub>F\<^sub>M\<^sub>U fmu)}))
		else
		((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))), stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r := step\<rparr>
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: variablesSynchronized: (Machine * set of (PortType) -> bool)
	variablesSynchronized(M, variableTypes) ==
let outputs:set of (FMURef) = filterOutputs([fmu | fmu in set (rng (M.fmus))], variableTypes) in (forall srcPort in set outputs & let trgPort:FMURef = (M.connections)(srcPort) in (((M.fmus)((srcPort.name)).env)((srcPort.ref)) = ((M.fmus)((trgPort.name)).env)((trgPort.ref))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 31:5\<close>

\<comment>\<open>VDM source: pre_variablesSynchronized: (Machine * set of (PortType) +> bool)
	pre_variablesSynchronized(M, variableTypes) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 31:5\<close>
definition
	pre_variablesSynchronized :: "Machine \<Rightarrow> PortType VDMSet \<Rightarrow> bool"
where
	"pre_variablesSynchronized M   variableTypes \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_variablesSynchronized` specification.\<close>
		(inv_Machine M  \<and>  (inv_VDMSet' (inv_PortType) variableTypes))"


\<comment>\<open>VDM source: post_variablesSynchronized: (Machine * set of (PortType) * bool +> bool)
	post_variablesSynchronized(M, variableTypes, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 31:5\<close>
definition
	post_variablesSynchronized :: "Machine \<Rightarrow> PortType VDMSet \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_variablesSynchronized M   variableTypes   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_variablesSynchronized` specification.\<close>
		(inv_Machine M  \<and>  (inv_VDMSet' (inv_PortType) variableTypes)  \<and>  (inv_bool RESULT))"

definition
	variablesSynchronized :: "Machine \<Rightarrow> PortType VDMSet \<Rightarrow> bool"
where
	"variablesSynchronized M   variableTypes \<equiv> 
	\<comment>\<open>User defined body of variablesSynchronized.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	())"

	
	
\<comment>\<open>VDM source: filterOutputs: (seq of (FMU) * set of (PortType) -> set of (FMURef))
	filterOutputs(fmus, variableTypes) ==
(if (fmus = [])
then {}
else let fmu:FMU = (hd fmus) in ({mk_FMURef((fmu.name), (output.ref)) | output in set (fmu.outputs) & ((output.type) in set variableTypes)} union filterOutputs((tl fmus), variableTypes)))
	measure (len fmus)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 40:5\<close>

\<comment>\<open>VDM source: pre_filterOutputs: (seq of (FMU) * set of (PortType) +> bool)
	pre_filterOutputs(fmus, variableTypes) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 40:5\<close>
definition
	pre_filterOutputs :: "FMU VDMSeq \<Rightarrow> PortType VDMSet \<Rightarrow> bool"
where
	"pre_filterOutputs fmus   variableTypes \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_filterOutputs` specification.\<close>
		((inv_VDMSeq' inv_FMU  fmus)  \<and>  (inv_VDMSet' (inv_PortType) variableTypes))"


\<comment>\<open>VDM source: post_filterOutputs: (seq of (FMU) * set of (PortType) * set of (FMURef) +> bool)
	post_filterOutputs(fmus, variableTypes, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 40:5\<close>
definition
	post_filterOutputs :: "FMU VDMSeq \<Rightarrow> PortType VDMSet \<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"post_filterOutputs fmus   variableTypes   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_filterOutputs` specification.\<close>
		((inv_VDMSeq' inv_FMU  fmus)  \<and>  (inv_VDMSet' (inv_PortType) variableTypes)  \<and>  (inv_VDMSet' inv_FMURef  RESULT))"

fun
	filterOutputs :: "FMU VDMSeq \<Rightarrow> PortType VDMSet \<Rightarrow> FMURef VDMSet"
where
	"filterOutputs fmus   variableTypes = 
	\<comment>\<open>User defined body of filterOutputs.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	())"

	
	
\<comment>\<open>VDM source: isActionEnabled: (Importer * Action -> bool)
	isActionEnabled(I, action) ==
(cases action :
mk_Action(<get>, fmu, port) -> preGetI(I, ((I.scenario).fmus)(fmu), port),
mk_Action(<set>, fmu, port) -> preSetI(I, ((I.scenario).fmus)(fmu), port),
mk_Action(<step>, fmu, -) -> preStepI(I, ((I.scenario).fmus)(fmu)),
mk_Action(<setC>, fmu, clock) -> preSetCI(I, ((I.scenario).fmus)(fmu), clock),
mk_Action(<getC>, fmu, clock) -> preGetCI(I, ((I.scenario).fmus)(fmu), clock)
others -> false
end)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 52:5\<close>

\<comment>\<open>VDM source: pre_isActionEnabled: (Importer * Action +> bool)
	pre_isActionEnabled(I, action) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 52:5\<close>
definition
	pre_isActionEnabled :: "Importer \<Rightarrow> Action \<Rightarrow> bool"
where
	"pre_isActionEnabled I   action \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_isActionEnabled` specification.\<close>
		(inv_Importer I  \<and>  inv_Action action)"


\<comment>\<open>VDM source: post_isActionEnabled: (Importer * Action * bool +> bool)
	post_isActionEnabled(I, action, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 52:5\<close>
definition
	post_isActionEnabled :: "Importer \<Rightarrow> Action \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_isActionEnabled I   action   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_isActionEnabled` specification.\<close>
		(inv_Importer I  \<and>  inv_Action action  \<and>  (inv_bool RESULT))"

definition
	isActionEnabled :: "Importer \<Rightarrow> Action \<Rightarrow> bool"
where
	"isActionEnabled I   action \<equiv> 
	\<comment>\<open>User defined body of isActionEnabled.\<close>
	(
		 \<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. optional, union, etc.) for `Action` VDM type.\<close>)"

	
	
\<comment>\<open>VDM source: preSetI: (Importer * FMU * Ref -> bool)
	preSetI(I, fmu, port) ==
let input:Variable = derefInput(fmu, port), fmuRef:FMURef = mk_FMURef((fmu.name), port) in ((((fmu.mode) = <EVENT>) <=> ((fmuRef in set ((I.activeEquations) \ (I.calculatedEquations))) and ((input.type) = <discrete>))) and ((fmuRef in set (dom (I.valueMap))) and let val:Value = (I.valueMap)(fmuRef) in ((((fmu.mode) = <STEP>) => (((input.type) = <continous>) and ((((input.contract) = <reactive>) => ((val.time) > (fmu.time))) and (((input.contract) = <delayed>) => ((val.time) = (fmu.time)))))) and preSet(fmu, port))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 68:5\<close>

\<comment>\<open>VDM source: pre_preSetI: (Importer * FMU * Ref +> bool)
	pre_preSetI(I, fmu, port) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 68:5\<close>
definition
	pre_preSetI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preSetI I   fmu   port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSetI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref port))"


\<comment>\<open>VDM source: post_preSetI: (Importer * FMU * Ref * bool +> bool)
	post_preSetI(I, fmu, port, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 68:5\<close>
definition
	post_preSetI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preSetI I   fmu   port   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preSetI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref port)  \<and>  (inv_bool RESULT))"

definition
	preSetI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"preSetI I   fmu   port \<equiv> 
	\<comment>\<open>User defined body of preSetI.\<close>
	(
		let 
(input::Variable) = (derefInput fmu   port)
		;
		
(fmuRef::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = port\<rparr>
		in
			(if (inv_Variable input)
	 \<and> 
	(inv_FMURef fmuRef) then
			((((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ) \<longleftrightarrow> ((fmuRef \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e input) = PortType.U_discrete ))) \<and> ((fmuRef \<in> (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> (
		let 
(val::Value) = (the(((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) fmuRef)))
		in
			(if (inv_Value val) then
			((((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_STEP ) \<longrightarrow> (((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e input) = PortType.U_continous ) \<and> ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e input) = Contract.U_reactive ) \<longrightarrow> \<comment>\<open>Transform a VDM `>` expression into a reversed `ord_Time` call\<close>
	(ord_Time (time\<^sub>F\<^sub>M\<^sub>U fmu)   (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val))) \<and> (((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e input) = Contract.U_delayed ) \<longrightarrow> \<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val)   (time\<^sub>F\<^sub>M\<^sub>U fmu)))))) \<and> (preSet fmu   port))
		 else
			undefined
		)
		)))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: preGetI: (Importer * FMU * Ref -> bool)
	preGetI(I, fmu, port) ==
let output:Variable = derefOutput(fmu, port), fmuRef:FMURef = mk_FMURef((fmu.name), port), connectedInput:FMURef = ((I.scenario).connections)(fmuRef) in let input:Variable = derefInput(((I.scenario).fmus)((connectedInput.name)), (connectedInput.ref)) in ((((fmu.mode) = <EVENT>) <=> ((fmuRef in set ((I.activeEquations) \ (I.calculatedEquations))) and ((output.type) = <discrete>))) and ((((fmu.mode) = <STEP>) => (((output.type) = <continous>) and (((input.contract) = <delayed>) => (fmu.stepped)))) and (preGet(fmu, port) and (connectedInput not in set (dom (I.valueMap))))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 80:5\<close>

\<comment>\<open>VDM source: pre_preGetI: (Importer * FMU * Ref +> bool)
	pre_preGetI(I, fmu, port) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 80:5\<close>
definition
	pre_preGetI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGetI I   fmu   port \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGetI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref port))"


\<comment>\<open>VDM source: post_preGetI: (Importer * FMU * Ref * bool +> bool)
	post_preGetI(I, fmu, port, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 80:5\<close>
definition
	post_preGetI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preGetI I   fmu   port   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preGetI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref port)  \<and>  (inv_bool RESULT))"

definition
	preGetI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"preGetI I   fmu   port \<equiv> 
	\<comment>\<open>User defined body of preGetI.\<close>
	(
		let 
(output::Variable) = (derefOutput fmu   port)
		;
		
(fmuRef::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = port\<rparr>
		;
		
(connectedInput::FMURef) = (the(((connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) fmuRef)))
		in
			(if (inv_Variable output)
	 \<and> 
	(inv_FMURef fmuRef)
	 \<and> 
	(inv_FMURef connectedInput) then
			(
		let 
(input::Variable) = (derefInput ((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f connectedInput))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f connectedInput))
		in
			(if (inv_Variable input) then
			((((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ) \<longleftrightarrow> ((fmuRef \<in> ((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e output) = PortType.U_discrete ))) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_STEP ) \<longrightarrow> (((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e output) = PortType.U_continous ) \<and> (((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e input) = Contract.U_delayed ) \<longrightarrow> (stepped\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and> ((preGet fmu   port) \<and> (connectedInput \<notin> (dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))))
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: preStepI: (Importer * FMU -> bool)
	preStepI(I, fmu) ==
(not (exists [m in set (rng ((I.scenario).fmus))] & (((m.name) <> (fmu.name)) and (((m.time) < (fmu.time)) and preStepT(fmu, (I.stepSize))))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 91:5\<close>

\<comment>\<open>VDM source: pre_preStepI: (Importer * FMU +> bool)
	pre_preStepI(I, fmu) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 91:5\<close>
definition
	pre_preStepI :: "Importer \<Rightarrow> FMU \<Rightarrow> bool"
where
	"pre_preStepI I   fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preStepI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu)"


\<comment>\<open>VDM source: post_preStepI: (Importer * FMU * bool +> bool)
	post_preStepI(I, fmu, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 91:5\<close>
definition
	post_preStepI :: "Importer \<Rightarrow> FMU \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preStepI I   fmu   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preStepI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_bool RESULT))"

definition
	preStepI :: "Importer \<Rightarrow> FMU \<Rightarrow> bool"
where
	"preStepI I   fmu \<equiv> 
	\<comment>\<open>User defined body of preStepI.\<close>
	(\<not> (\<exists> m \<in> (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))  . (((name\<^sub>F\<^sub>M\<^sub>U m) \<noteq> (name\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (\<comment>\<open>Transform a VDM `<` expression into an `ord_Time` call\<close>
	(ord_Time (time\<^sub>F\<^sub>M\<^sub>U m)   (time\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (preStepT fmu   (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))))"

	
	
\<comment>\<open>VDM source: preGetCI: (Importer * FMU * Ref -> bool)
	preGetCI(I, fmu, clock) ==
let output:FMURef = mk_FMURef((fmu.name), clock) in ((output in set (I.relevantOutputClocks)) and preGetC(fmu, clock))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 98:5\<close>

\<comment>\<open>VDM source: pre_preGetCI: (Importer * FMU * Ref +> bool)
	pre_preGetCI(I, fmu, clock) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 98:5\<close>
definition
	pre_preGetCI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGetCI I   fmu   clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGetCI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock))"


\<comment>\<open>VDM source: post_preGetCI: (Importer * FMU * Ref * bool +> bool)
	post_preGetCI(I, fmu, clock, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 98:5\<close>
definition
	post_preGetCI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preGetCI I   fmu   clock   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preGetCI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool RESULT))"

definition
	preGetCI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"preGetCI I   fmu   clock \<equiv> 
	\<comment>\<open>User defined body of preGetCI.\<close>
	(
		let 
(output::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef output) then
			((output \<in> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> (preGetC fmu   clock))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: preSetCI: (Importer * FMU * Ref -> bool)
	preSetCI(I, fmu, clock) ==
let input:FMURef = mk_FMURef((fmu.name), clock) in ((input in set ((dom (I.valueMap)) inter (I.relevantInputClocks))) and let val:Value = (I.valueMap)(input) in (preSetC(fmu, clock, (val.value)) and ((val.value) <=> (input in set ((I.inactiveClocks) inter (I.readyClocks))))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 104:5\<close>

\<comment>\<open>VDM source: pre_preSetCI: (Importer * FMU * Ref +> bool)
	pre_preSetCI(I, fmu, clock) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 104:5\<close>
definition
	pre_preSetCI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preSetCI I   fmu   clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSetCI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock))"


\<comment>\<open>VDM source: post_preSetCI: (Importer * FMU * Ref * bool +> bool)
	post_preSetCI(I, fmu, clock, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 104:5\<close>
definition
	post_preSetCI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preSetCI I   fmu   clock   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preSetCI` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool RESULT))"

definition
	preSetCI :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"preSetCI I   fmu   clock \<equiv> 
	\<comment>\<open>User defined body of preSetCI.\<close>
	(
		let 
(input::FMURef) = \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U fmu), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = clock\<rparr>
		in
			(if (inv_FMURef input) then
			((input \<in> ((dom (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<inter> (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> (
		let 
(val::Value) = (the(((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) input)))
		in
			(if (inv_Value val) then
			((preSetC fmu   clock   (value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val)) \<and> ((value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e val) \<longleftrightarrow> (input \<in> ((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<inter> (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))))
		 else
			undefined
		)
		))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: preSet: (FMU * Ref -> bool)
	preSet(fmu, input) ==
(exists [v in set (fmu.inputs)] & (((v.ref) = input) and (((v.causality) = <input>) and (((fmu.mode) <> <DONE>) and ((((fmu.mode) = <STEP>) => ((v.type) = <continous>)) and (((fmu.mode) = <EVENT>) => ((v.type) = <discrete>)))))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 117:5\<close>

\<comment>\<open>VDM source: pre_preSet: (FMU * Ref +> bool)
	pre_preSet(fmu, input) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 117:5\<close>
definition
	pre_preSet :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preSet fmu   input \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref input))"


\<comment>\<open>VDM source: post_preSet: (FMU * Ref * bool +> bool)
	post_preSet(fmu, input, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 117:5\<close>
definition
	post_preSet :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preSet fmu   input   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preSet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref input)  \<and>  (inv_bool RESULT))"

definition
	preSet :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"preSet fmu   input \<equiv> 
	\<comment>\<open>User defined body of preSet.\<close>
	(\<exists> v \<in> (inputs\<^sub>F\<^sub>M\<^sub>U fmu)  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = input) \<and> (((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = Causality.U_input ) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U fmu) \<noteq> FMUMode.U_DONE ) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_STEP ) \<longrightarrow> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = PortType.U_continous )) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ) \<longrightarrow> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = PortType.U_discrete )))))))"

	
	
\<comment>\<open>VDM source: preGet: (FMU * Ref -> bool)
	preGet(fmu, ref) ==
let output:Variable = derefOutput(fmu, ref) in ((exists1 v in set (fmu.outputs) & (((v.ref) = ref) and ((v.causality) = <output>))) and (((fmu.mode) <> <DONE>) and feedthroughSatisfied(fmu, output)))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 127:5\<close>

\<comment>\<open>VDM source: pre_preGet: (FMU * Ref +> bool)
	pre_preGet(fmu, ref) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 127:5\<close>
definition
	pre_preGet :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGet fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))"


\<comment>\<open>VDM source: post_preGet: (FMU * Ref * bool +> bool)
	post_preGet(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 127:5\<close>
definition
	post_preGet :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preGet fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preGet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  (inv_bool RESULT))"

definition
	preGet :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"preGet fmu   ref \<equiv> 
	\<comment>\<open>User defined body of preGet.\<close>
	(
		let 
(output::Variable) = (derefOutput fmu   ref)
		in
			(if (inv_Variable output) then
			((\<exists>! v \<in> (outputs\<^sub>F\<^sub>M\<^sub>U fmu)  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = ref) \<and> ((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = Causality.U_output ))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U fmu) \<noteq> FMUMode.U_DONE ) \<and> (feedthroughSatisfied fmu   output)))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: preStepT: (FMU * real -> bool)
	preStepT(fmu, stepSize) ==
let continousInputs:set of (Variable) = {i | i in set (fmu.inputs) & ((i.type) = <continous>)} in ((forall i in set continousInputs & ((((i.contract) = <reactive>) => ((((fmu.env)((i.ref)).time).r) = (((fmu.time).r) + stepSize))) and (((i.contract) = <delayed>) => (((fmu.env)((i.ref)).time) = (fmu.time))))) and ((stepSize >= 0.0) and ((fmu.mode) = <STEP>)))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 134:5\<close>

\<comment>\<open>VDM source: pre_preStepT: (FMU * real +> bool)
	pre_preStepT(fmu, stepSize) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 134:5\<close>
definition
	pre_preStepT :: "FMU \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"pre_preStepT fmu   stepSize \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal stepSize))"


\<comment>\<open>VDM source: post_preStepT: (FMU * real * bool +> bool)
	post_preStepT(fmu, stepSize, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 134:5\<close>
definition
	post_preStepT :: "FMU \<Rightarrow> VDMReal \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preStepT fmu   stepSize   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal stepSize)  \<and>  (inv_bool RESULT))"

definition
	preStepT :: "FMU \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"preStepT fmu   stepSize \<equiv> 
	\<comment>\<open>User defined body of preStepT.\<close>
	(
		let 
(continousInputs::Variable VDMSet) = { i .   ((i \<in>(inputs\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = PortType.U_continous ) }
		in
			(if ((inv_VDMSet' inv_Variable  continousInputs)) then
			((\<forall> i \<in> continousInputs  . ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = Contract.U_reactive ) \<longrightarrow> ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))) = ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) + stepSize))) \<and> (((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = Contract.U_delayed ) \<longrightarrow> \<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))   (time\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and> ((stepSize \<ge> (0.0)) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_STEP )))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: postStepT: (FMU * real * bool * FMU * real -> bool)
	postStepT(fmu, stepTaken, eventTriggered, oldFMU, stepAsked) ==
(((stepTaken <= stepAsked) and ((stepTaken <= (oldFMU.maxStep)) and eventTriggered)) <=> (((oldFMU.maxStep) <= stepTaken) and ((((fmu.time).r) = (((oldFMU.time).r) + stepTaken)) and (((fmu.time).i) = ((oldFMU.time).i)))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 143:5\<close>

\<comment>\<open>VDM source: pre_postStepT: (FMU * real * bool * FMU * real +> bool)
	pre_postStepT(fmu, stepTaken, eventTriggered, oldFMU, stepAsked) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 143:5\<close>
definition
	pre_postStepT :: "FMU \<Rightarrow> VDMReal \<Rightarrow> bool \<Rightarrow> FMU \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"pre_postStepT fmu   stepTaken   eventTriggered   oldFMU   stepAsked \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal stepTaken)  \<and>  (inv_bool eventTriggered)  \<and>  inv_FMU oldFMU  \<and>  (inv_VDMReal stepAsked))"


\<comment>\<open>VDM source: post_postStepT: (FMU * real * bool * FMU * real * bool +> bool)
	post_postStepT(fmu, stepTaken, eventTriggered, oldFMU, stepAsked, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 143:5\<close>
definition
	post_postStepT :: "FMU \<Rightarrow> VDMReal \<Rightarrow> bool \<Rightarrow> FMU \<Rightarrow> VDMReal \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postStepT fmu   stepTaken   eventTriggered   oldFMU   stepAsked   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMReal stepTaken)  \<and>  (inv_bool eventTriggered)  \<and>  inv_FMU oldFMU  \<and>  (inv_VDMReal stepAsked)  \<and>  (inv_bool RESULT))"

definition
	postStepT :: "FMU \<Rightarrow> VDMReal \<Rightarrow> bool \<Rightarrow> FMU \<Rightarrow> VDMReal \<Rightarrow> bool"
where
	"postStepT fmu   stepTaken   eventTriggered   oldFMU   stepAsked \<equiv> 
	\<comment>\<open>User defined body of postStepT.\<close>
	(((stepTaken \<le> stepAsked) \<and> ((stepTaken \<le> (maxStep\<^sub>F\<^sub>M\<^sub>U oldFMU)) \<and> eventTriggered)) \<longleftrightarrow> (((maxStep\<^sub>F\<^sub>M\<^sub>U oldFMU) \<le> stepTaken) \<and> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) = ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U oldFMU)) + stepTaken)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U oldFMU))))))"

	
	
\<comment>\<open>VDM source: preStepE: (FMU -> bool)
	preStepE(fmu) ==
((fmu.mode) = <EVENT>)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 151:5\<close>

\<comment>\<open>VDM source: pre_preStepE: (FMU +> bool)
	pre_preStepE(fmu) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 151:5\<close>
definition
	pre_preStepE :: "FMU \<Rightarrow> bool"
where
	"pre_preStepE fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preStepE` specification.\<close>
		(inv_FMU fmu)"


\<comment>\<open>VDM source: post_preStepE: (FMU * bool +> bool)
	post_preStepE(fmu, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 151:5\<close>
definition
	post_preStepE :: "FMU \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preStepE fmu   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preStepE` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_bool RESULT))"

definition
	preStepE :: "FMU \<Rightarrow> bool"
where
	"preStepE fmu \<equiv> 
	\<comment>\<open>User defined body of preStepE.\<close>
	((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT )"

	
	
\<comment>\<open>VDM source: postStepE: (FMU * FMU * bool -> bool)
	postStepE(fmu, oldFMU, -) ==
(((fmu.mode) = <EVENT>) and ((((fmu.time).i) = (((oldFMU.time).i) + 1)) and ((((fmu.time).r) = ((oldFMU.time).r)) and ((fmu.activeClocks) = {}))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 155:5\<close>

\<comment>\<open>VDM source: pre_postStepE: (FMU * FMU * bool +> bool)
	pre_postStepE(fmu, oldFMU, -) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 155:5\<close>
definition
	pre_postStepE :: "FMU \<Rightarrow> FMU \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_postStepE fmu   oldFMU   dummy0_ignore \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postStepE` specification.\<close>
		(inv_FMU fmu  \<and>  inv_FMU oldFMU  \<and>  (inv_bool dummy0_ignore))"


\<comment>\<open>VDM source: post_postStepE: (FMU * FMU * bool * bool +> bool)
	post_postStepE(fmu, oldFMU, -, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 155:5\<close>
definition
	post_postStepE :: "FMU \<Rightarrow> FMU \<Rightarrow> bool \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postStepE fmu   oldFMU   dummy0_ignore   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postStepE` specification.\<close>
		(inv_FMU fmu  \<and>  inv_FMU oldFMU  \<and>  (inv_bool dummy0_ignore)  \<and>  (inv_bool RESULT))"

definition
	postStepE :: "FMU \<Rightarrow> FMU \<Rightarrow> bool \<Rightarrow> bool"
where
	"postStepE fmu   oldFMU   dummy0_ignore \<equiv> 
	\<comment>\<open>User defined body of postStepE.\<close>
	(((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ) \<and> (((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) = ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U oldFMU)) + (1::VDMNat1))) \<and> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U oldFMU))) \<and> ((activeClocks\<^sub>F\<^sub>M\<^sub>U fmu) = {}))))"

	
	
\<comment>\<open>VDM source: preSetC: (FMU * Ref * bool -> bool)
	preSetC(fmu, clock, val) ==
(((exists [v in set (fmu.clocks)] & (((v.ref) = clock) and ((v.type) = <input>))) and val) <=> ((not (clock in set (fmu.activeClocks))) and ((fmu.mode) = <EVENT>)))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 162:5\<close>

\<comment>\<open>VDM source: pre_preSetC: (FMU * Ref * bool +> bool)
	pre_preSetC(fmu, clock, val) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 162:5\<close>
definition
	pre_preSetC :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_preSetC fmu   clock   val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val))"


\<comment>\<open>VDM source: post_preSetC: (FMU * Ref * bool * bool +> bool)
	post_preSetC(fmu, clock, val, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 162:5\<close>
definition
	post_preSetC :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preSetC fmu   clock   val   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preSetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val)  \<and>  (inv_bool RESULT))"

definition
	preSetC :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"preSetC fmu   clock   val \<equiv> 
	\<comment>\<open>User defined body of preSetC.\<close>
	(((\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = clock) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_input ))) \<and> val) \<longleftrightarrow> ((\<not> (clock \<in> (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT )))"

	
	
\<comment>\<open>VDM source: preGetC: (FMU * Ref -> bool)
	preGetC(fmu, clock) ==
((exists [v in set (fmu.clocks)] & (((v.ref) = clock) and ((v.type) = <output>))) and ((fmu.mode) = <EVENT>))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 168:5\<close>

\<comment>\<open>VDM source: pre_preGetC: (FMU * Ref +> bool)
	pre_preGetC(fmu, clock) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 168:5\<close>
definition
	pre_preGetC :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGetC fmu   clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock))"


\<comment>\<open>VDM source: post_preGetC: (FMU * Ref * bool +> bool)
	post_preGetC(fmu, clock, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 168:5\<close>
definition
	post_preGetC :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preGetC fmu   clock   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preGetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool RESULT))"

definition
	preGetC :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"preGetC fmu   clock \<equiv> 
	\<comment>\<open>User defined body of preGetC.\<close>
	((\<exists> v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = clock) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_output ))) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ))"

	
	
\<comment>\<open>VDM source: preEventMode: (Importer * set of (FMURef) -> bool)
	preEventMode(I, clocks) ==
(preCoSimulationStep((I.scenario), (I.time)) and (((I.fmusWithEvent) <> {}) or (clocks <> {})))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 174:5\<close>

\<comment>\<open>VDM source: pre_preEventMode: (Importer * set of (FMURef) +> bool)
	pre_preEventMode(I, clocks) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 174:5\<close>
definition
	pre_preEventMode :: "Importer \<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"pre_preEventMode I   clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preEventMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_FMURef  clocks))"


\<comment>\<open>VDM source: post_preEventMode: (Importer * set of (FMURef) * bool +> bool)
	post_preEventMode(I, clocks, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 174:5\<close>
definition
	post_preEventMode :: "Importer \<Rightarrow> FMURef VDMSet \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preEventMode I   clocks   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preEventMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet' inv_FMURef  clocks)  \<and>  (inv_bool RESULT))"

definition
	preEventMode :: "Importer \<Rightarrow> FMURef VDMSet \<Rightarrow> bool"
where
	"preEventMode I   clocks \<equiv> 
	\<comment>\<open>User defined body of preEventMode.\<close>
	((preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> (((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<noteq> {}) \<or> (clocks \<noteq> {})))"

	
	
\<comment>\<open>VDM source: postEventMode: (Importer -> bool)
	postEventMode(I) ==
(preCoSimulationStep((I.scenario), (I.time)) and ((I.fmusWithEvent) = {}))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 179:5\<close>

\<comment>\<open>VDM source: pre_postEventMode: (Importer +> bool)
	pre_postEventMode(I) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 179:5\<close>
definition
	pre_postEventMode :: "Importer \<Rightarrow> bool"
where
	"pre_postEventMode I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postEventMode` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_postEventMode: (Importer * bool +> bool)
	post_postEventMode(I, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 179:5\<close>
definition
	post_postEventMode :: "Importer \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postEventMode I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postEventMode` specification.\<close>
		(inv_Importer I  \<and>  (inv_bool RESULT))"

definition
	postEventMode :: "Importer \<Rightarrow> bool"
where
	"postEventMode I \<equiv> 
	\<comment>\<open>User defined body of postEventMode.\<close>
	((preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> ((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) = {}))"

	
	
\<comment>\<open>VDM source: feedthroughSatisfied: (FMU * Variable -> bool)
	feedthroughSatisfied(fmu, output) ==
let inputs:set of (Variable) = {input | input in set (fmu.inputs) & ((input.ref) in set (output.dependsOn))} in (forall i in set inputs & (((i.ref) in set (dom (fmu.env))) and ((((i.contract) = <reactive>) => (((fmu.env)((i.ref)).time) >= (fmu.time))) and (((i.contract) = <delayed>) => (((fmu.env)((i.ref)).time) = (fmu.time))))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 184:5\<close>

\<comment>\<open>VDM source: pre_feedthroughSatisfied: (FMU * Variable +> bool)
	pre_feedthroughSatisfied(fmu, output) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 184:5\<close>
definition
	pre_feedthroughSatisfied :: "FMU \<Rightarrow> Variable \<Rightarrow> bool"
where
	"pre_feedthroughSatisfied fmu   output \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_feedthroughSatisfied` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Variable output)"


\<comment>\<open>VDM source: post_feedthroughSatisfied: (FMU * Variable * bool +> bool)
	post_feedthroughSatisfied(fmu, output, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 184:5\<close>
definition
	post_feedthroughSatisfied :: "FMU \<Rightarrow> Variable \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_feedthroughSatisfied fmu   output   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_feedthroughSatisfied` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Variable output  \<and>  (inv_bool RESULT))"

definition
	feedthroughSatisfied :: "FMU \<Rightarrow> Variable \<Rightarrow> bool"
where
	"feedthroughSatisfied fmu   output \<equiv> 
	\<comment>\<open>User defined body of feedthroughSatisfied.\<close>
	(
		let 
(inputs::Variable VDMSet) = { input .   ((input \<in>(inputs\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e input) \<in> (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e output)) }
		in
			(if ((inv_VDMSet' inv_Variable  inputs)) then
			(\<forall>
		i \<in> inputs
		
		.
		(((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) \<in> (dom (env\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = Contract.U_reactive ) \<longrightarrow> \<comment>\<open>Transform a VDM `>` expression into a reversed `ord_Time` call\<close>
	(ord_Time (time\<^sub>F\<^sub>M\<^sub>U fmu)   (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))) \<or> 
	\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))   (time\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> (((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = Contract.U_delayed ) \<longrightarrow> \<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))   (time\<^sub>F\<^sub>M\<^sub>U fmu))))))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: fmusSynchronized: (set1 of (FMU) -> bool)
	fmusSynchronized(fmus) ==
((card {(fmu.time) | fmu in set fmus}) = 1)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 192:5\<close>

\<comment>\<open>VDM source: pre_fmusSynchronized: (set1 of (FMU) +> bool)
	pre_fmusSynchronized(fmus) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 192:5\<close>
definition
	pre_fmusSynchronized :: "FMU VDMSet1 \<Rightarrow> bool"
where
	"pre_fmusSynchronized fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_fmusSynchronized` specification.\<close>
		((inv_VDMSet1' inv_FMU  fmus))"


\<comment>\<open>VDM source: post_fmusSynchronized: (set1 of (FMU) * bool +> bool)
	post_fmusSynchronized(fmus, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 192:5\<close>
definition
	post_fmusSynchronized :: "FMU VDMSet1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_fmusSynchronized fmus   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_fmusSynchronized` specification.\<close>
		((inv_VDMSet1' inv_FMU  fmus)  \<and>  (inv_bool RESULT))"

definition
	fmusSynchronized :: "FMU VDMSet1 \<Rightarrow> bool"
where
	"fmusSynchronized fmus \<equiv> 
	\<comment>\<open>User defined body of fmusSynchronized.\<close>
	((vdm_card { (time\<^sub>F\<^sub>M\<^sub>U fmu) | fmu .  ((fmu \<in>fmus))  }) = (1::VDMNat1))"

	
	
\<comment>\<open>VDM source: fmusSynchronizedAtTime: (set1 of (FMU) * Time -> bool)
	fmusSynchronizedAtTime(fmus, t) ==
(fmusSynchronized(fmus) and (forall fmu in set fmus & ((fmu.time) = t)))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 196:5\<close>

\<comment>\<open>VDM source: pre_fmusSynchronizedAtTime: (set1 of (FMU) * Time +> bool)
	pre_fmusSynchronizedAtTime(fmus, t) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 196:5\<close>
definition
	pre_fmusSynchronizedAtTime :: "FMU VDMSet1 \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_fmusSynchronizedAtTime fmus   t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_fmusSynchronizedAtTime` specification.\<close>
		((inv_VDMSet1' inv_FMU  fmus)  \<and>  inv_Time t)"


\<comment>\<open>VDM source: post_fmusSynchronizedAtTime: (set1 of (FMU) * Time * bool +> bool)
	post_fmusSynchronizedAtTime(fmus, t, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 196:5\<close>
definition
	post_fmusSynchronizedAtTime :: "FMU VDMSet1 \<Rightarrow> Time \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_fmusSynchronizedAtTime fmus   t   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_fmusSynchronizedAtTime` specification.\<close>
		((inv_VDMSet1' inv_FMU  fmus)  \<and>  inv_Time t  \<and>  (inv_bool RESULT))"

definition
	fmusSynchronizedAtTime :: "FMU VDMSet1 \<Rightarrow> Time \<Rightarrow> bool"
where
	"fmusSynchronizedAtTime fmus   t \<equiv> 
	\<comment>\<open>User defined body of fmusSynchronizedAtTime.\<close>
	((fmusSynchronized fmus) \<and> (\<forall> fmu \<in> fmus  . \<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>F\<^sub>M\<^sub>U fmu)   t)))"

	
	
\<comment>\<open>VDM source: eventSolved: (Importer * set1 of (FMU) * set1 of (FMU) -> bool)
	eventSolved(I, newFmus, oldFmus) ==
(assertFMUMode(newFmus, {<EVENT>}) and (timeAdvanced(newFmus, oldFmus, true) and ((((I.activeEquations) \ (I.calculatedEquations)) = {}) and (((I.relevantInputClocks) union (I.relevantOutputClocks)) = {}))))
	pre sameSetOfFMUs(newFmus, oldFmus)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 201:5\<close>

\<comment>\<open>VDM source: pre_eventSolved: (Importer * set1 of (FMU) * set1 of (FMU) +> bool)
	pre_eventSolved(I, newFmus, oldFmus) ==
sameSetOfFMUs(newFmus, oldFmus)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 207:13\<close>
definition
	pre_eventSolved :: "Importer \<Rightarrow> FMU VDMSet1 \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool"
where
	"pre_eventSolved I   newFmus   oldFmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_eventSolved` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet1' inv_FMU  newFmus)  \<and>  (inv_VDMSet1' inv_FMU  oldFmus))  \<and> 
		\<comment>\<open>User defined body of pre_eventSolved.\<close>
		(sameSetOfFMUs newFmus   oldFmus)"


\<comment>\<open>VDM source: post_eventSolved: (Importer * set1 of (FMU) * set1 of (FMU) * bool +> bool)
	post_eventSolved(I, newFmus, oldFmus, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 201:5\<close>
definition
	post_eventSolved :: "Importer \<Rightarrow> FMU VDMSet1 \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_eventSolved I   newFmus   oldFmus   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_eventSolved` specification.\<close>
		(inv_Importer I  \<and>  (inv_VDMSet1' inv_FMU  newFmus)  \<and>  (inv_VDMSet1' inv_FMU  oldFmus)  \<and>  (inv_bool RESULT))"

definition
	eventSolved :: "Importer \<Rightarrow> FMU VDMSet1 \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool"
where
	"eventSolved I   newFmus   oldFmus \<equiv> 
	\<comment>\<open>User defined body of eventSolved.\<close>
	((assertFMUMode newFmus   {FMUMode.U_EVENT }) \<and> ((timeAdvanced newFmus   oldFmus   (True::\<bool>)) \<and> ((((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) - (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) = {}) \<and> (((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<union> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) = {}))))"

	
	
\<comment>\<open>VDM source: assertFMUMode: (set of (FMU) * set of (FMUMode) -> bool)
	assertFMUMode(fmus, modes) ==
(exists1 mode in set modes & (forall fmu in set fmus & ((fmu.mode) = mode)))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 212:5\<close>

\<comment>\<open>VDM source: pre_assertFMUMode: (set of (FMU) * set of (FMUMode) +> bool)
	pre_assertFMUMode(fmus, modes) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 212:5\<close>
definition
	pre_assertFMUMode :: "FMU VDMSet \<Rightarrow> FMUMode VDMSet \<Rightarrow> bool"
where
	"pre_assertFMUMode fmus   modes \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_assertFMUMode` specification.\<close>
		((inv_VDMSet' inv_FMU  fmus)  \<and>  (inv_VDMSet' (inv_FMUMode) modes))"


\<comment>\<open>VDM source: post_assertFMUMode: (set of (FMU) * set of (FMUMode) * bool +> bool)
	post_assertFMUMode(fmus, modes, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 212:5\<close>
definition
	post_assertFMUMode :: "FMU VDMSet \<Rightarrow> FMUMode VDMSet \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_assertFMUMode fmus   modes   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_assertFMUMode` specification.\<close>
		((inv_VDMSet' inv_FMU  fmus)  \<and>  (inv_VDMSet' (inv_FMUMode) modes)  \<and>  (inv_bool RESULT))"

definition
	assertFMUMode :: "FMU VDMSet \<Rightarrow> FMUMode VDMSet \<Rightarrow> bool"
where
	"assertFMUMode fmus   modes \<equiv> 
	\<comment>\<open>User defined body of assertFMUMode.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	())"

	
	
\<comment>\<open>VDM source: timeAdvanced: (set1 of (FMU) * set1 of (FMU) * bool -> bool)
	timeAdvanced(newFMUs, oldFMUs, discreteTime) ==
(forall m' in set newFMUs & (exists1 m in set oldFMUs & (((m.name) = (m'.name)) and (((m.time) <= (m'.time)) and ((discreteTime => (((((m.time).i) + 1) = ((m'.time).i)) and (((m.time).r) = ((m'.time).r)))) and ((not discreteTime) => ((((m.time).i) = ((m'.time).i)) and (((m.time).r) <= ((m'.time).r)))))))))
	pre sameSetOfFMUs(newFMUs, oldFMUs)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 218:5\<close>

\<comment>\<open>VDM source: pre_timeAdvanced: (set1 of (FMU) * set1 of (FMU) * bool +> bool)
	pre_timeAdvanced(newFMUs, oldFMUs, discreteTime) ==
sameSetOfFMUs(newFMUs, oldFMUs)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 225:13\<close>
definition
	pre_timeAdvanced :: "FMU VDMSet1 \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_timeAdvanced newFMUs   oldFMUs   discreteTime \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_timeAdvanced` specification.\<close>
		((inv_VDMSet1' inv_FMU  newFMUs)  \<and>  (inv_VDMSet1' inv_FMU  oldFMUs)  \<and>  (inv_bool discreteTime))  \<and> 
		\<comment>\<open>User defined body of pre_timeAdvanced.\<close>
		(sameSetOfFMUs newFMUs   oldFMUs)"


\<comment>\<open>VDM source: post_timeAdvanced: (set1 of (FMU) * set1 of (FMU) * bool * bool +> bool)
	post_timeAdvanced(newFMUs, oldFMUs, discreteTime, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 218:5\<close>
definition
	post_timeAdvanced :: "FMU VDMSet1 \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_timeAdvanced newFMUs   oldFMUs   discreteTime   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_timeAdvanced` specification.\<close>
		((inv_VDMSet1' inv_FMU  newFMUs)  \<and>  (inv_VDMSet1' inv_FMU  oldFMUs)  \<and>  (inv_bool discreteTime)  \<and>  (inv_bool RESULT))"

definition
	timeAdvanced :: "FMU VDMSet1 \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"timeAdvanced newFMUs   oldFMUs   discreteTime \<equiv> 
	\<comment>\<open>User defined body of timeAdvanced.\<close>
	(\<forall> m' \<in> newFMUs  . (\<exists>! m \<in> oldFMUs  . (((name\<^sub>F\<^sub>M\<^sub>U m) = (name\<^sub>F\<^sub>M\<^sub>U m')) \<and> (\<comment>\<open>Transform a VDM `<` expression into an `ord_Time` call\<close>
	(ord_Time (time\<^sub>F\<^sub>M\<^sub>U m)   (time\<^sub>F\<^sub>M\<^sub>U m')) \<or> 
	\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>F\<^sub>M\<^sub>U m)   (time\<^sub>F\<^sub>M\<^sub>U m')) \<and> ((discreteTime \<longrightarrow> ((((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m)) + (1::VDMNat1)) = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m'))) \<and> ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m)) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m'))))) \<and> ((\<not> discreteTime) \<longrightarrow> (((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m)) = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m'))) \<and> ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m)) \<le> (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U m'))))))))))"

	
	
\<comment>\<open>VDM source: preCoSimulationStep: (Machine * Time -> bool)
	preCoSimulationStep(scenario, time) ==
let fmus:set1 of (FMU) = (rng (scenario.fmus)) in (assertFMUMode(fmus, {<STEP>}) and (variablesSynchronized(scenario, {<continous>}) and fmusSynchronizedAtTime(fmus, time)))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 230:5\<close>

\<comment>\<open>VDM source: pre_preCoSimulationStep: (Machine * Time +> bool)
	pre_preCoSimulationStep(scenario, time) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 230:5\<close>
definition
	pre_preCoSimulationStep :: "Machine \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_preCoSimulationStep scenario   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preCoSimulationStep` specification.\<close>
		(inv_Machine scenario  \<and>  inv_Time time)"


\<comment>\<open>VDM source: post_preCoSimulationStep: (Machine * Time * bool +> bool)
	post_preCoSimulationStep(scenario, time, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 230:5\<close>
definition
	post_preCoSimulationStep :: "Machine \<Rightarrow> Time \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preCoSimulationStep scenario   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preCoSimulationStep` specification.\<close>
		(inv_Machine scenario  \<and>  inv_Time time  \<and>  (inv_bool RESULT))"

definition
	preCoSimulationStep :: "Machine \<Rightarrow> Time \<Rightarrow> bool"
where
	"preCoSimulationStep scenario   time \<equiv> 
	\<comment>\<open>User defined body of preCoSimulationStep.\<close>
	(
		let 
(fmus::FMU VDMSet1) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e scenario))
		in
			(if ((inv_VDMSet1' inv_FMU  fmus)) then
			((assertFMUMode fmus   {FMUMode.U_STEP }) \<and> ((variablesSynchronized scenario   {PortType.U_continous }) \<and> (fmusSynchronizedAtTime fmus   time)))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: postCosimulationStep: (Machine * set1 of (FMU) -> bool)
	postCosimulationStep(scenario, oldFMUs) ==
let fmus:set1 of (FMU) = (rng (scenario.fmus)) in (assertFMUMode(fmus, {<STEP>}) and (variablesSynchronized(scenario, {<continous>}) and (fmusSynchronized(fmus) and timeAdvanced(fmus, oldFMUs, false))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 238:5\<close>

\<comment>\<open>VDM source: pre_postCosimulationStep: (Machine * set1 of (FMU) +> bool)
	pre_postCosimulationStep(scenario, oldFMUs) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 238:5\<close>
definition
	pre_postCosimulationStep :: "Machine \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool"
where
	"pre_postCosimulationStep scenario   oldFMUs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postCosimulationStep` specification.\<close>
		(inv_Machine scenario  \<and>  (inv_VDMSet1' inv_FMU  oldFMUs))"


\<comment>\<open>VDM source: post_postCosimulationStep: (Machine * set1 of (FMU) * bool +> bool)
	post_postCosimulationStep(scenario, oldFMUs, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 238:5\<close>
definition
	post_postCosimulationStep :: "Machine \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postCosimulationStep scenario   oldFMUs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postCosimulationStep` specification.\<close>
		(inv_Machine scenario  \<and>  (inv_VDMSet1' inv_FMU  oldFMUs)  \<and>  (inv_bool RESULT))"

definition
	postCosimulationStep :: "Machine \<Rightarrow> FMU VDMSet1 \<Rightarrow> bool"
where
	"postCosimulationStep scenario   oldFMUs \<equiv> 
	\<comment>\<open>User defined body of postCosimulationStep.\<close>
	(
		let 
(fmus::FMU VDMSet1) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e scenario))
		in
			(if ((inv_VDMSet1' inv_FMU  fmus)) then
			((assertFMUMode fmus   {FMUMode.U_STEP }) \<and> ((variablesSynchronized scenario   {PortType.U_continous }) \<and> ((fmusSynchronized fmus) \<and> (timeAdvanced fmus   oldFMUs   (False::\<bool>)))))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: postStepMode: (Importer * Importer * set1 of (Name) -> bool)
	postStepMode(I, oldImporter, fmus) ==
(ImporterNotAffected(oldImporter, I) and let relevantFMUs:set of (FMU) = (rng (fmus <: ((I.scenario).fmus))) in (fmusNotAffected((rng (fmus <-: ((I.scenario).fmus))), (rng (fmus <-: ((oldImporter.scenario).fmus)))) and (assertFMUMode(relevantFMUs, {<STEP>}) and preCoSimulationStep((I.scenario), (I.time)))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 247:5\<close>

\<comment>\<open>VDM source: pre_postStepMode: (Importer * Importer * set1 of (Name) +> bool)
	pre_postStepMode(I, oldImporter, fmus) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 247:5\<close>
definition
	pre_postStepMode :: "Importer \<Rightarrow> Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> bool"
where
	"pre_postStepMode I   oldImporter   fmus \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postStepMode` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer oldImporter  \<and>  (inv_VDMSet1' (inv_Name) fmus))"


\<comment>\<open>VDM source: post_postStepMode: (Importer * Importer * set1 of (Name) * bool +> bool)
	post_postStepMode(I, oldImporter, fmus, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 247:5\<close>
definition
	post_postStepMode :: "Importer \<Rightarrow> Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postStepMode I   oldImporter   fmus   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postStepMode` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer oldImporter  \<and>  (inv_VDMSet1' (inv_Name) fmus)  \<and>  (inv_bool RESULT))"

definition
	postStepMode :: "Importer \<Rightarrow> Importer \<Rightarrow> Name VDMSet1 \<Rightarrow> bool"
where
	"postStepMode I   oldImporter   fmus \<equiv> 
	\<comment>\<open>User defined body of postStepMode.\<close>
	((ImporterNotAffected oldImporter   I) \<and> (
		let 
(relevantFMUs::FMU VDMSet) = (rng (fmus \<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		in
			(if ((inv_VDMSet' inv_FMU  relevantFMUs)) then
			((fmusNotAffected (rng (fmus -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))   (rng (fmus -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter))))) \<and> ((assertFMUMode relevantFMUs   {FMUMode.U_STEP }) \<and> (preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		 else
			undefined
		)
		))"

	
	
\<comment>\<open>VDM source: fmusNotAffected: (set of (FMU) * set of (FMU) -> bool)
	fmusNotAffected(oldFMUs, newFMUs) ==
(oldFMUs = newFMUs)
	pre sameSetOfFMUs(oldFMUs, newFMUs)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 256:5\<close>

\<comment>\<open>VDM source: pre_fmusNotAffected: (set of (FMU) * set of (FMU) +> bool)
	pre_fmusNotAffected(oldFMUs, newFMUs) ==
sameSetOfFMUs(oldFMUs, newFMUs)\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 258:9\<close>
definition
	pre_fmusNotAffected :: "FMU VDMSet \<Rightarrow> FMU VDMSet \<Rightarrow> bool"
where
	"pre_fmusNotAffected oldFMUs   newFMUs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_fmusNotAffected` specification.\<close>
		((inv_VDMSet' inv_FMU  oldFMUs)  \<and>  (inv_VDMSet' inv_FMU  newFMUs))  \<and> 
		\<comment>\<open>User defined body of pre_fmusNotAffected.\<close>
		(sameSetOfFMUs oldFMUs   newFMUs)"


\<comment>\<open>VDM source: post_fmusNotAffected: (set of (FMU) * set of (FMU) * bool +> bool)
	post_fmusNotAffected(oldFMUs, newFMUs, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 256:5\<close>
definition
	post_fmusNotAffected :: "FMU VDMSet \<Rightarrow> FMU VDMSet \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_fmusNotAffected oldFMUs   newFMUs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_fmusNotAffected` specification.\<close>
		((inv_VDMSet' inv_FMU  oldFMUs)  \<and>  (inv_VDMSet' inv_FMU  newFMUs)  \<and>  (inv_bool RESULT))"

definition
	fmusNotAffected :: "FMU VDMSet \<Rightarrow> FMU VDMSet \<Rightarrow> bool"
where
	"fmusNotAffected oldFMUs   newFMUs \<equiv> 
	\<comment>\<open>User defined body of fmusNotAffected.\<close>
	(oldFMUs = newFMUs)"

	
	
\<comment>\<open>VDM source: preInitialization: (Importer -> bool)
	preInitialization(I) ==
let fmus:set1 of (FMU) = (rng ((I.scenario).fmus)) in (assertFMUMode(fmus, {<INIT>}) and (((I.time) = mk_Time(0, 0)) and fmusSynchronizedAtTime(fmus, (I.time))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 260:5\<close>

\<comment>\<open>VDM source: pre_preInitialization: (Importer +> bool)
	pre_preInitialization(I) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 260:5\<close>
definition
	pre_preInitialization :: "Importer \<Rightarrow> bool"
where
	"pre_preInitialization I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preInitialization` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_preInitialization: (Importer * bool +> bool)
	post_preInitialization(I, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 260:5\<close>
definition
	post_preInitialization :: "Importer \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preInitialization I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preInitialization` specification.\<close>
		(inv_Importer I  \<and>  (inv_bool RESULT))"

definition
	preInitialization :: "Importer \<Rightarrow> bool"
where
	"preInitialization I \<equiv> 
	\<comment>\<open>User defined body of preInitialization.\<close>
	(
		let 
(fmus::FMU VDMSet1) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		in
			(if ((inv_VDMSet1' inv_FMU  fmus)) then
			((assertFMUMode fmus   {FMUMode.U_INIT }) \<and> (\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>) \<and> (fmusSynchronizedAtTime fmus   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: postInitialization: (Importer -> bool)
	postInitialization(I) ==
let fmus:set1 of (FMU) = (rng ((I.scenario).fmus)) in (assertFMUMode(fmus, {<INIT>}) and (fmusSynchronizedAtTime(fmus, (I.time)) and (((I.time) = mk_Time(0, 0)) and variablesSynchronized((I.scenario), {<continous>, <discrete>}))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 268:5\<close>

\<comment>\<open>VDM source: pre_postInitialization: (Importer +> bool)
	pre_postInitialization(I) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 268:5\<close>
definition
	pre_postInitialization :: "Importer \<Rightarrow> bool"
where
	"pre_postInitialization I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postInitialization` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_postInitialization: (Importer * bool +> bool)
	post_postInitialization(I, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 268:5\<close>
definition
	post_postInitialization :: "Importer \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postInitialization I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postInitialization` specification.\<close>
		(inv_Importer I  \<and>  (inv_bool RESULT))"

definition
	postInitialization :: "Importer \<Rightarrow> bool"
where
	"postInitialization I \<equiv> 
	\<comment>\<open>User defined body of postInitialization.\<close>
	(
		let 
(fmus::FMU VDMSet1) = (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))
		in
			(if ((inv_VDMSet1' inv_FMU  fmus)) then
			((assertFMUMode fmus   {FMUMode.U_INIT }) \<and> ((fmusSynchronizedAtTime fmus   (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> (\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>) \<and> (variablesSynchronized (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   {PortType.U_continous  , PortType.U_discrete }))))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: preTermination: (Importer -> bool)
	preTermination(I) ==
(preCoSimulationStep((I.scenario), (I.endtime)) and ((((I.time).r) = ((I.endtime).r)) and ((I.fmusWithEvent) = {})))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 276:5\<close>

\<comment>\<open>VDM source: pre_preTermination: (Importer +> bool)
	pre_preTermination(I) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 276:5\<close>
definition
	pre_preTermination :: "Importer \<Rightarrow> bool"
where
	"pre_preTermination I \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preTermination` specification.\<close>
		(inv_Importer I)"


\<comment>\<open>VDM source: post_preTermination: (Importer * bool +> bool)
	post_preTermination(I, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 276:5\<close>
definition
	post_preTermination :: "Importer \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preTermination I   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preTermination` specification.\<close>
		(inv_Importer I  \<and>  (inv_bool RESULT))"

definition
	preTermination :: "Importer \<Rightarrow> bool"
where
	"preTermination I \<equiv> 
	\<comment>\<open>User defined body of preTermination.\<close>
	((preCoSimulationStep (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)   (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) \<and> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))) \<and> ((fmusWithEvent\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) = {})))"

	
	
\<comment>\<open>VDM source: postTermination: (Importer * Importer -> bool)
	postTermination(I, oldI) ==
(assertFMUMode((rng ((I.scenario).fmus)), {<DONE>}) and (fmusSynchronized((rng ((I.scenario).fmus))) and ImporterNotAffected(oldI, I)))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 283:5\<close>

\<comment>\<open>VDM source: pre_postTermination: (Importer * Importer +> bool)
	pre_postTermination(I, oldI) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 283:5\<close>
definition
	pre_postTermination :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"pre_postTermination I   oldI \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postTermination` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer oldI)"


\<comment>\<open>VDM source: post_postTermination: (Importer * Importer * bool +> bool)
	post_postTermination(I, oldI, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 283:5\<close>
definition
	post_postTermination :: "Importer \<Rightarrow> Importer \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postTermination I   oldI   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postTermination` specification.\<close>
		(inv_Importer I  \<and>  inv_Importer oldI  \<and>  (inv_bool RESULT))"

definition
	postTermination :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"postTermination I   oldI \<equiv> 
	\<comment>\<open>User defined body of postTermination.\<close>
	((assertFMUMode (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))   {FMUMode.U_DONE }) \<and> ((fmusSynchronized (rng (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I)))) \<and> (ImporterNotAffected oldI   I)))"

	
	
\<comment>\<open>VDM source: postVaraibleCalculation: (FMURef * Importer * Importer -> bool)
	postVaraibleCalculation(equation, I, NewI) ==
((equation in set (NewI.calculatedEquations)) and (((I.relevantInputClocks) = (NewI.relevantInputClocks)) and (((I.relevantOutputClocks) subset (NewI.relevantOutputClocks)) and (((I.calculatedEquations) subset (NewI.calculatedEquations)) and let fmu:FMU = ((NewI.scenario).fmus)((equation.name)) in (fmusNotAffected((rng ({(fmu.name)} <-: ((I.scenario).fmus))), (rng ({(fmu.name)} <-: ((NewI.scenario).fmus)))) and ((fmu.mode) = <EVENT>))))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 290:5\<close>

\<comment>\<open>VDM source: pre_postVaraibleCalculation: (FMURef * Importer * Importer +> bool)
	pre_postVaraibleCalculation(equation, I, NewI) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 290:5\<close>
definition
	pre_postVaraibleCalculation :: "FMURef \<Rightarrow> Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"pre_postVaraibleCalculation equation   I   NewI \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postVaraibleCalculation` specification.\<close>
		(inv_FMURef equation  \<and>  inv_Importer I  \<and>  inv_Importer NewI)"


\<comment>\<open>VDM source: post_postVaraibleCalculation: (FMURef * Importer * Importer * bool +> bool)
	post_postVaraibleCalculation(equation, I, NewI, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 290:5\<close>
definition
	post_postVaraibleCalculation :: "FMURef \<Rightarrow> Importer \<Rightarrow> Importer \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postVaraibleCalculation equation   I   NewI   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postVaraibleCalculation` specification.\<close>
		(inv_FMURef equation  \<and>  inv_Importer I  \<and>  inv_Importer NewI  \<and>  (inv_bool RESULT))"

definition
	postVaraibleCalculation :: "FMURef \<Rightarrow> Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"postVaraibleCalculation equation   I   NewI \<equiv> 
	\<comment>\<open>User defined body of postVaraibleCalculation.\<close>
	((equation \<in> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r NewI)) \<and> (((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) = (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r NewI)) \<and> (((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<subseteq> (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r NewI)) \<and> (((calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I) \<subseteq> (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r NewI)) \<and> (
		let 
(fmu::FMU) = (the(((fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r NewI)) (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f equation))))
		in
			(if (inv_FMU fmu) then
			((fmusNotAffected (rng ({(name\<^sub>F\<^sub>M\<^sub>U fmu)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r I))))   (rng ({(name\<^sub>F\<^sub>M\<^sub>U fmu)} -\<triangleleft> (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r NewI))))) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ))
		 else
			undefined
		)
		)))))"

	
	
\<comment>\<open>VDM source: ImporterNotAffected: (Importer * Importer -> bool)
	ImporterNotAffected(oldImporter, newImporter) ==
(((oldImporter.activeClocks) = (newImporter.activeClocks)) and (((oldImporter.readyClocks) = (newImporter.readyClocks)) and (((oldImporter.inactiveClocks) = (newImporter.inactiveClocks)) and (((oldImporter.relevantOutputClocks) = (newImporter.relevantOutputClocks)) and (((oldImporter.relevantInputClocks) = (newImporter.relevantInputClocks)) and (((oldImporter.activeEquations) = (newImporter.activeEquations)) and (((oldImporter.calculatedEquations) = (newImporter.calculatedEquations)) and (((oldImporter.readyEquations) = (newImporter.readyEquations)) and (((oldImporter.endtime) = (newImporter.endtime)) and ((oldImporter.valueMap) = (newImporter.valueMap)))))))))))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 300:5\<close>

\<comment>\<open>VDM source: pre_ImporterNotAffected: (Importer * Importer +> bool)
	pre_ImporterNotAffected(oldImporter, newImporter) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 300:5\<close>
definition
	pre_ImporterNotAffected :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"pre_ImporterNotAffected oldImporter   newImporter \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_ImporterNotAffected` specification.\<close>
		(inv_Importer oldImporter  \<and>  inv_Importer newImporter)"


\<comment>\<open>VDM source: post_ImporterNotAffected: (Importer * Importer * bool +> bool)
	post_ImporterNotAffected(oldImporter, newImporter, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 300:5\<close>
definition
	post_ImporterNotAffected :: "Importer \<Rightarrow> Importer \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_ImporterNotAffected oldImporter   newImporter   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_ImporterNotAffected` specification.\<close>
		(inv_Importer oldImporter  \<and>  inv_Importer newImporter  \<and>  (inv_bool RESULT))"

definition
	ImporterNotAffected :: "Importer \<Rightarrow> Importer \<Rightarrow> bool"
where
	"ImporterNotAffected oldImporter   newImporter \<equiv> 
	\<comment>\<open>User defined body of ImporterNotAffected.\<close>
	(((activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (activeClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> (((readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (readyClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> (((inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (inactiveClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> (((relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (relevantOutputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> (((relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (relevantInputClocks\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> (((activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (activeEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> (((calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (calculatedEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> (((readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (readyEquations\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> (\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter)   (endtime\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)) \<and> ((valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r oldImporter) = (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r newImporter)))))))))))"

	
	
\<comment>\<open>VDM source: sameSetOfFMUs: (set of (FMU) * set of (FMU) -> bool)
	sameSetOfFMUs(fmus1, fmus2) ==
(((card fmus1) = (card fmus2)) and ({(m.name) | m in set fmus1} = {(m.name) | m in set fmus2}))\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 320:5\<close>

\<comment>\<open>VDM source: pre_sameSetOfFMUs: (set of (FMU) * set of (FMU) +> bool)
	pre_sameSetOfFMUs(fmus1, fmus2) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 320:5\<close>
definition
	pre_sameSetOfFMUs :: "FMU VDMSet \<Rightarrow> FMU VDMSet \<Rightarrow> bool"
where
	"pre_sameSetOfFMUs fmus1   fmus2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_sameSetOfFMUs` specification.\<close>
		((inv_VDMSet' inv_FMU  fmus1)  \<and>  (inv_VDMSet' inv_FMU  fmus2))"


\<comment>\<open>VDM source: post_sameSetOfFMUs: (set of (FMU) * set of (FMU) * bool +> bool)
	post_sameSetOfFMUs(fmus1, fmus2, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (Validation.vdmsl) at line 320:5\<close>
definition
	post_sameSetOfFMUs :: "FMU VDMSet \<Rightarrow> FMU VDMSet \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_sameSetOfFMUs fmus1   fmus2   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_sameSetOfFMUs` specification.\<close>
		((inv_VDMSet' inv_FMU  fmus1)  \<and>  (inv_VDMSet' inv_FMU  fmus2)  \<and>  (inv_bool RESULT))"

definition
	sameSetOfFMUs :: "FMU VDMSet \<Rightarrow> FMU VDMSet \<Rightarrow> bool"
where
	"sameSetOfFMUs fmus1   fmus2 \<equiv> 
	\<comment>\<open>User defined body of sameSetOfFMUs.\<close>
	(((vdm_card fmus1) = (vdm_card fmus2)) \<and> ({ (name\<^sub>F\<^sub>M\<^sub>U m) | m .  ((m \<in>fmus1))  } = { (name\<^sub>F\<^sub>M\<^sub>U m) | m .  ((m \<in>fmus2))  }))"

	
	
\<comment>\<open>VDM source: createFMU: (nat * Name * set of (Clock) * set of (Variable) * set of (Variable) -> FMU)
	createFMU(id, name, clocks, inputs, outputs) ==
mk_FMU(id, name, clocks, inputs, outputs, <INIT>, mk_Time(0, 0), false, 5.0, {10 |-> mk_Value(1, mk_Time(0, 0))}, {}, {})\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 30:5\<close>

\<comment>\<open>VDM source: pre_createFMU: (nat * Name * set of (Clock) * set of (Variable) * set of (Variable) +> bool)
	pre_createFMU(id, name, clocks, inputs, outputs) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 30:5\<close>
definition
	pre_createFMU :: "VDMNat \<Rightarrow> Name \<Rightarrow> Clock VDMSet \<Rightarrow> Variable VDMSet \<Rightarrow> Variable VDMSet \<Rightarrow> bool"
where
	"pre_createFMU id   name   clocks   inputs   outputs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_createFMU` specification.\<close>
		((inv_VDMNat id)  \<and>  (inv_Name name)  \<and>  (inv_VDMSet' inv_Clock  clocks)  \<and>  (inv_VDMSet' inv_Variable  inputs)  \<and>  (inv_VDMSet' inv_Variable  outputs))"


\<comment>\<open>VDM source: post_createFMU: (nat * Name * set of (Clock) * set of (Variable) * set of (Variable) * FMU +> bool)
	post_createFMU(id, name, clocks, inputs, outputs, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 30:5\<close>
definition
	post_createFMU :: "VDMNat \<Rightarrow> Name \<Rightarrow> Clock VDMSet \<Rightarrow> Variable VDMSet \<Rightarrow> Variable VDMSet \<Rightarrow> FMU \<Rightarrow> bool"
where
	"post_createFMU id   name   clocks   inputs   outputs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_createFMU` specification.\<close>
		((inv_VDMNat id)  \<and>  (inv_Name name)  \<and>  (inv_VDMSet' inv_Clock  clocks)  \<and>  (inv_VDMSet' inv_Variable  inputs)  \<and>  (inv_VDMSet' inv_Variable  outputs)  \<and>  inv_FMU RESULT)"

definition
	createFMU :: "VDMNat \<Rightarrow> Name \<Rightarrow> Clock VDMSet \<Rightarrow> Variable VDMSet \<Rightarrow> Variable VDMSet \<Rightarrow> FMU"
where
	"createFMU id   name   clocks   inputs   outputs \<equiv> 
	\<comment>\<open>User defined body of createFMU.\<close>
	\<lparr>id\<^sub>F\<^sub>M\<^sub>U = id, name\<^sub>F\<^sub>M\<^sub>U = name, clocks\<^sub>F\<^sub>M\<^sub>U = clocks, inputs\<^sub>F\<^sub>M\<^sub>U = inputs, outputs\<^sub>F\<^sub>M\<^sub>U = outputs, mode\<^sub>F\<^sub>M\<^sub>U = FMUMode.U_INIT FMUMode.U_INIT , time\<^sub>F\<^sub>M\<^sub>U = \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>, stepped\<^sub>F\<^sub>M\<^sub>U = (False::\<bool>), maxStep\<^sub>F\<^sub>M\<^sub>U = (5.0), env\<^sub>F\<^sub>M\<^sub>U = [(10::VDMNat1)\<mapsto>\<lparr>value\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = ValueType.U_VDMReal (1::VDMNat1), time\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>\<rparr>], activeClocks\<^sub>F\<^sub>M\<^sub>U = {}, activeEquations\<^sub>F\<^sub>M\<^sub>U = {}\<rparr>"

	
	
\<comment>\<open>VDM source: createVariable: (Name * Ref * Causality * PortType * set of (Ref) * set of (Ref) * Contract -> Variable)
	createVariable(name, ref, causality, type, clocks, dependsOn, contract) ==
mk_Variable(name, ref, mk_Time(0, 0), causality, type, clocks, dependsOn, contract)\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 48:5\<close>

\<comment>\<open>VDM source: pre_createVariable: (Name * Ref * Causality * PortType * set of (Ref) * set of (Ref) * Contract +> bool)
	pre_createVariable(name, ref, causality, type, clocks, dependsOn, contract) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 48:5\<close>
definition
	pre_createVariable :: "Name \<Rightarrow> Ref \<Rightarrow> Causality \<Rightarrow> PortType \<Rightarrow> Ref VDMSet \<Rightarrow> Ref VDMSet \<Rightarrow> Contract \<Rightarrow> bool"
where
	"pre_createVariable name   ref   causality   type   clocks   dependsOn   contract \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_createVariable` specification.\<close>
		((inv_Name name)  \<and>  (inv_Ref ref)  \<and>  (inv_Causality causality)  \<and>  (inv_PortType type)  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_VDMSet' (inv_Ref) dependsOn)  \<and>  (inv_Contract contract))"


\<comment>\<open>VDM source: post_createVariable: (Name * Ref * Causality * PortType * set of (Ref) * set of (Ref) * Contract * Variable +> bool)
	post_createVariable(name, ref, causality, type, clocks, dependsOn, contract, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 48:5\<close>
definition
	post_createVariable :: "Name \<Rightarrow> Ref \<Rightarrow> Causality \<Rightarrow> PortType \<Rightarrow> Ref VDMSet \<Rightarrow> Ref VDMSet \<Rightarrow> Contract \<Rightarrow> Variable \<Rightarrow> bool"
where
	"post_createVariable name   ref   causality   type   clocks   dependsOn   contract   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_createVariable` specification.\<close>
		((inv_Name name)  \<and>  (inv_Ref ref)  \<and>  (inv_Causality causality)  \<and>  (inv_PortType type)  \<and>  (inv_VDMSet' (inv_Ref) clocks)  \<and>  (inv_VDMSet' (inv_Ref) dependsOn)  \<and>  (inv_Contract contract)  \<and>  inv_Variable RESULT)"

definition
	createVariable :: "Name \<Rightarrow> Ref \<Rightarrow> Causality \<Rightarrow> PortType \<Rightarrow> Ref VDMSet \<Rightarrow> Ref VDMSet \<Rightarrow> Contract \<Rightarrow> Variable"
where
	"createVariable name   ref   causality   type   clocks   dependsOn   contract \<equiv> 
	\<comment>\<open>User defined body of createVariable.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(\<lparr>name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e = name, ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e = ref, time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e = \<lparr>r\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat), i\<^sub>T\<^sub>i\<^sub>m\<^sub>e = (0::VDMNat)\<rparr>, causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e = causality, type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e = type, clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e = clocks, dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e = dependsOn, contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e = contract\<rparr>))"

	
	
\<comment>\<open>VDM source: createClock: (Name * Ref * Causality * Interval * set of (Ref) * set of (Ref) -> Clock)
	createClock(name, ref, causality, interval, dependsOn, equations) ==
mk_Clock(name, ref, causality, interval, dependsOn, equations)\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 53:5\<close>

\<comment>\<open>VDM source: pre_createClock: (Name * Ref * Causality * Interval * set of (Ref) * set of (Ref) +> bool)
	pre_createClock(name, ref, causality, interval, dependsOn, equations) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 53:5\<close>
definition
	pre_createClock :: "Name \<Rightarrow> Ref \<Rightarrow> Causality \<Rightarrow> Interval \<Rightarrow> Ref VDMSet \<Rightarrow> Ref VDMSet \<Rightarrow> bool"
where
	"pre_createClock name   ref   causality   interval   dependsOn   equations \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_createClock` specification.\<close>
		((inv_Name name)  \<and>  (inv_Ref ref)  \<and>  (inv_Causality causality)  \<and>  (inv_Interval interval)  \<and>  (inv_VDMSet' (inv_Ref) dependsOn)  \<and>  (inv_VDMSet' (inv_Ref) equations))"


\<comment>\<open>VDM source: post_createClock: (Name * Ref * Causality * Interval * set of (Ref) * set of (Ref) * Clock +> bool)
	post_createClock(name, ref, causality, interval, dependsOn, equations, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 53:5\<close>
definition
	post_createClock :: "Name \<Rightarrow> Ref \<Rightarrow> Causality \<Rightarrow> Interval \<Rightarrow> Ref VDMSet \<Rightarrow> Ref VDMSet \<Rightarrow> Clock \<Rightarrow> bool"
where
	"post_createClock name   ref   causality   interval   dependsOn   equations   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_createClock` specification.\<close>
		((inv_Name name)  \<and>  (inv_Ref ref)  \<and>  (inv_Causality causality)  \<and>  (inv_Interval interval)  \<and>  (inv_VDMSet' (inv_Ref) dependsOn)  \<and>  (inv_VDMSet' (inv_Ref) equations)  \<and>  inv_Clock RESULT)"

definition
	createClock :: "Name \<Rightarrow> Ref \<Rightarrow> Causality \<Rightarrow> Interval \<Rightarrow> Ref VDMSet \<Rightarrow> Ref VDMSet \<Rightarrow> Clock"
where
	"createClock name   ref   causality   interval   dependsOn   equations \<equiv> 
	\<comment>\<open>User defined body of createClock.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(\<lparr>name\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = name, ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = ref, type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = causality, interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = interval, dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = dependsOn, equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = equations\<rparr>))"

	
	
\<comment>\<open>VDM source: createTimeBased: (Name * real * real * Interval * FMURef -> TimeBasedClock)
	createTimeBased(name, shift, period, interval, master) ==
mk_TimeBasedClock(name, shift, period, interval, master)\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 57:5\<close>

\<comment>\<open>VDM source: pre_createTimeBased: (Name * real * real * Interval * FMURef +> bool)
	pre_createTimeBased(name, shift, period, interval, master) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 57:5\<close>
definition
	pre_createTimeBased :: "Name \<Rightarrow> VDMReal \<Rightarrow> VDMReal \<Rightarrow> Interval \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"pre_createTimeBased name   shift   period   interval   master \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_createTimeBased` specification.\<close>
		((inv_Name name)  \<and>  (inv_VDMReal shift)  \<and>  (inv_VDMReal period)  \<and>  (inv_Interval interval)  \<and>  inv_FMURef master)"


\<comment>\<open>VDM source: post_createTimeBased: (Name * real * real * Interval * FMURef * TimeBasedClock +> bool)
	post_createTimeBased(name, shift, period, interval, master, RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 57:5\<close>
definition
	post_createTimeBased :: "Name \<Rightarrow> VDMReal \<Rightarrow> VDMReal \<Rightarrow> Interval \<Rightarrow> FMURef \<Rightarrow> TimeBasedClock \<Rightarrow> bool"
where
	"post_createTimeBased name   shift   period   interval   master   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_createTimeBased` specification.\<close>
		((inv_Name name)  \<and>  (inv_VDMReal shift)  \<and>  (inv_VDMReal period)  \<and>  (inv_Interval interval)  \<and>  inv_FMURef master  \<and>  inv_TimeBasedClock RESULT)"

definition
	createTimeBased :: "Name \<Rightarrow> VDMReal \<Rightarrow> VDMReal \<Rightarrow> Interval \<Rightarrow> FMURef \<Rightarrow> TimeBasedClock"
where
	"createTimeBased name   shift   period   interval   master \<equiv> 
	\<comment>\<open>User defined body of createTimeBased.\<close>
	(
	\<comment>\<open>Implicit union type parameters projection\<close>
	(\<lparr>name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = name, shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = shift, period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = period, interval\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = interval, master\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k = master\<rparr>))"

	
	
\<comment>\<open>VDM source: createScenario: (() -> Machine)
	createScenario() ==
let ctrlInputs:set1 of (Variable) = {createVariable("a_s", 0, <input>, <discrete>, {}, {}, <delayed>), createVariable("x_r", 1, <input>, <discrete>, {}, {}, <delayed>)}, ctrlOutputs:set1 of (Variable) = {createVariable("u_r", 10, <output>, <discrete>, {}, {}, <none>)}, ctrlClocks:set1 of (Clock) = {createClock("s", 20, <input>, <triggered>, {}, {0}), createClock("r", 21, <input>, <fixed>, {}, {1, 10})} in let ctrlFMU:FMU = createFMU(1, "ctrl", ctrlClocks, ctrlInputs, ctrlOutputs) in let actuationInputs:set1 of (Variable) = {createVariable("u_r", 0, <input>, <discrete>, {}, {}, <delayed>)}, actuationOutputs:set1 of (Variable) = {createVariable("u", 10, <output>, <continous>, {}, {}, <none>)}, actuationClocks:set1 of (Clock) = {createClock("r", 20, <input>, <fixed>, {}, {0})} in let actuationFMU:FMU = createFMU(2, "actuation", actuationClocks, actuationInputs, actuationOutputs) in let plantInputs:set1 of (Variable) = {createVariable("u", 0, <input>, <continous>, {}, {}, <delayed>)}, plantOutputs:set1 of (Variable) = {createVariable("x", 10, <output>, <continous>, {}, {}, <none>)}, plantClocks:{} = {} in let plantFMU:FMU = createFMU(3, "plant", plantClocks, plantInputs, plantOutputs) in let sensorInputs:set1 of (Variable) = {createVariable("x", 0, <input>, <continous>, {}, {}, <delayed>)}, sensorOutputs:set1 of (Variable) = {createVariable("x_r", 10, <output>, <discrete>, {}, {}, <none>)}, sensorClocks:set1 of (Clock) = {createClock("r", 20, <input>, <fixed>, {}, {10})} in let sensorFMU:FMU = createFMU(4, "sensor", sensorClocks, sensorInputs, sensorOutputs) in let supervisorInputs:{} = {}, supervisorOutputs:set1 of (Variable) = {createVariable("a_s", 10, <output>, <discrete>, {}, {}, <none>)}, supervisorClocks:set1 of (Clock) = {createClock("s", 20, <output>, <triggered>, {}, {10})} in let supervisorFMU:FMU = createFMU(5, "supervisor", supervisorClocks, supervisorInputs, supervisorOutputs) in let fmus:map (Name) to (FMU) = {(fmu.name) |-> fmu | fmu in set {sensorFMU, ctrlFMU, supervisorFMU, plantFMU, actuationFMU}} in let timeBasedClock_R:TimeBasedClock = createTimeBased("r", 2, 2, <fixed>, mk_FMURef((ctrlFMU.name), 21)) in let timeBasedClocks:set1 of (TimeBasedClock) = {timeBasedClock_R} in let connections:map (FMURef) to (FMURef) = {mk_FMURef((supervisorFMU.name), 10) |-> mk_FMURef((ctrlFMU.name), 0), mk_FMURef((ctrlFMU.name), 10) |-> mk_FMURef((actuationFMU.name), 0), mk_FMURef((actuationFMU.name), 10) |-> mk_FMURef((plantFMU.name), 0), mk_FMURef((plantFMU.name), 10) |-> mk_FMURef((sensorFMU.name), 0), mk_FMURef((sensorFMU.name), 10) |-> mk_FMURef((ctrlFMU.name), 1)}, clockConnections:map (FMURef) to (FMURef) = {mk_FMURef((supervisorFMU.name), 20) |-> mk_FMURef((ctrlFMU.name), 20)} in let timeBasedClockConnections:map (Name) to (set1 of (FMURef)) = {(timeBasedClock_R.name) |-> {mk_FMURef((sensorFMU.name), 20), mk_FMURef((actuationFMU.name), 20), mk_FMURef((ctrlFMU.name), 21)}} in mk_Machine(fmus, timeBasedClocks, connections, clockConnections, timeBasedClockConnections)\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 62:5\<close>

\<comment>\<open>VDM source: pre_createScenario: (() +> bool)
	pre_createScenario() ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 62:5\<close>
definition
	pre_createScenario :: "bool"
where
	"pre_createScenario  \<equiv> True"


\<comment>\<open>VDM source: post_createScenario: (Machine +> bool)
	post_createScenario(RESULT) ==
null\<close>
\<comment>\<open>in 'DEFAULT' (scenario.vdmsl) at line 62:5\<close>
definition
	post_createScenario :: "Machine \<Rightarrow> bool"
where
	"post_createScenario RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_createScenario` specification.\<close>
		(inv_Machine RESULT)"

definition
	createScenario :: "Machine"
where
	"createScenario  \<equiv> 
	\<comment>\<open>User defined body of createScenario.\<close>
	(
		let 
(ctrlInputs::Variable VDMSet1) = {(createVariable (''a_s'')   (0::VDMNat)   Causality.U_input    PortType.U_discrete    {}   {}   Contract.U_delayed ) , (createVariable (''x_r'')   (1::VDMNat1)   Causality.U_input    PortType.U_discrete    {}   {}   Contract.U_delayed )}
		;
		
(ctrlOutputs::Variable VDMSet1) = {(createVariable (''u_r'')   (10::VDMNat1)   Causality.U_output    PortType.U_discrete    {}   {}   Contract.U_none )}
		;
		
(ctrlClocks::Clock VDMSet1) = {(createClock (''s'')   (20::VDMNat1)   Causality.U_input    Interval.U_triggered    {}   {(0::VDMNat)}) , (createClock (''r'')   (21::VDMNat1)   Causality.U_input    Interval.U_fixed    {}   {(1::VDMNat1) , (10::VDMNat1)})}
		in
			(if ((inv_VDMSet1' inv_Variable  ctrlInputs))
	 \<and> 
	((inv_VDMSet1' inv_Variable  ctrlOutputs))
	 \<and> 
	((inv_VDMSet1' inv_Clock  ctrlClocks)) then
			(
		let 
(ctrlFMU::FMU) = (createFMU (1::VDMNat1)   (''ctrl'')   ctrlClocks   ctrlInputs   ctrlOutputs)
		in
			(if (inv_FMU ctrlFMU) then
			(
		let 
(actuationInputs::Variable VDMSet1) = {(createVariable (''u_r'')   (0::VDMNat)   Causality.U_input    PortType.U_discrete    {}   {}   Contract.U_delayed )}
		;
		
(actuationOutputs::Variable VDMSet1) = {(createVariable (''u'')   (10::VDMNat1)   Causality.U_output    PortType.U_continous    {}   {}   Contract.U_none )}
		;
		
(actuationClocks::Clock VDMSet1) = {(createClock (''r'')   (20::VDMNat1)   Causality.U_input    Interval.U_fixed    {}   {(0::VDMNat)})}
		in
			(if ((inv_VDMSet1' inv_Variable  actuationInputs))
	 \<and> 
	((inv_VDMSet1' inv_Variable  actuationOutputs))
	 \<and> 
	((inv_VDMSet1' inv_Clock  actuationClocks)) then
			(
		let 
(actuationFMU::FMU) = (createFMU (2::VDMNat1)   (''actuation'')   actuationClocks   actuationInputs   actuationOutputs)
		in
			(if (inv_FMU actuationFMU) then
			(
		let 
(plantInputs::Variable VDMSet1) = {(createVariable (''u'')   (0::VDMNat)   Causality.U_input    PortType.U_continous    {}   {}   Contract.U_delayed )}
		;
		
(plantOutputs::Variable VDMSet1) = {(createVariable (''x'')   (10::VDMNat1)   Causality.U_output    PortType.U_continous    {}   {}   Contract.U_none )}
		;
		
(plantClocks::'UNKNOWN VDMSet) = {}
		in
			(if ((inv_VDMSet1' inv_Variable  plantInputs))
	 \<and> 
	((inv_VDMSet1' inv_Variable  plantOutputs))
	 \<and> 
	((inv_VDMSet' inv_True
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close> plantClocks)) then
			(
		let 
(plantFMU::FMU) = (createFMU (3::VDMNat1)   (''plant'')   plantClocks   plantInputs   plantOutputs)
		in
			(if (inv_FMU plantFMU) then
			(
		let 
(sensorInputs::Variable VDMSet1) = {(createVariable (''x'')   (0::VDMNat)   Causality.U_input    PortType.U_continous    {}   {}   Contract.U_delayed )}
		;
		
(sensorOutputs::Variable VDMSet1) = {(createVariable (''x_r'')   (10::VDMNat1)   Causality.U_output    PortType.U_discrete    {}   {}   Contract.U_none )}
		;
		
(sensorClocks::Clock VDMSet1) = {(createClock (''r'')   (20::VDMNat1)   Causality.U_input    Interval.U_fixed    {}   {(10::VDMNat1)})}
		in
			(if ((inv_VDMSet1' inv_Variable  sensorInputs))
	 \<and> 
	((inv_VDMSet1' inv_Variable  sensorOutputs))
	 \<and> 
	((inv_VDMSet1' inv_Clock  sensorClocks)) then
			(
		let 
(sensorFMU::FMU) = (createFMU (4::VDMNat1)   (''sensor'')   sensorClocks   sensorInputs   sensorOutputs)
		in
			(if (inv_FMU sensorFMU) then
			(
		let 
(supervisorInputs::'UNKNOWN VDMSet) = {}
		;
		
(supervisorOutputs::Variable VDMSet1) = {(createVariable (''a_s'')   (10::VDMNat1)   Causality.U_output    PortType.U_discrete    {}   {}   Contract.U_none )}
		;
		
(supervisorClocks::Clock VDMSet1) = {(createClock (''s'')   (20::VDMNat1)   Causality.U_output    Interval.U_triggered    {}   {(10::VDMNat1)})}
		in
			(if ((inv_VDMSet' inv_True
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close> supervisorInputs))
	 \<and> 
	((inv_VDMSet1' inv_Variable  supervisorOutputs))
	 \<and> 
	((inv_VDMSet1' inv_Clock  supervisorClocks)) then
			(
		let 
(supervisorFMU::FMU) = (createFMU (5::VDMNat1)   (''supervisor'')   supervisorClocks   supervisorInputs   supervisorOutputs)
		in
			(if (inv_FMU supervisorFMU) then
			(
		let 
(fmus::(Name \<rightharpoonup> FMU)) = (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{(name\<^sub>F\<^sub>M\<^sub>U fmu)} 
		{ fmu .   ((fmu \<in>{sensorFMU , ctrlFMU , supervisorFMU , plantFMU , actuationFMU}))  } 
		((inv_VDMSeq1' (inv_VDMChar))) 
		 (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U FMU))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U FMU)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U FMU)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U FMU))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U FMU))) ) 
		(
	\<lambda> (dummy0DOMAIN :: Name)   (dummy0RANGE :: FMU) .
		(if ((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN))))  \<and>  (( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_VDMSeq1' (inv_VDMChar) (name\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (inputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' inv_Variable  (outputs\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((((inv_True (mode\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))))) \<and> 
		 ( (((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) )) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMReal (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 (((inv_Map ((inv_VDMNat)) inv_Value  (env\<^sub>F\<^sub>M\<^sub>U dummy0RANGE)))) \<and> 
		 ((inv_VDMSet' ((inv_VDMNat)) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) \<and> 
		 ((inv_VDMSet' ((inv_Lambda ((inv_Map ((inv_VDMNat)) inv_Value )) ((inv_Map ((inv_VDMNat)) inv_Value )))) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0RANGE))) ))) \<and> ((inv_VDMSeq1' (inv_VDMChar) (
		if ((\<exists> (dummy0DOMAIN :: Name)  . (((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<longrightarrow> ((dummy0DOMAIN = (name\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined)))) then
			(
		if ((\<exists> (dummy0DOMAIN :: Name)  . (((((inv_VDMSeq1' (inv_VDMChar) dummy0DOMAIN)))) \<longrightarrow> ((dummy0DOMAIN = (name\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(rngid ) 
		(truecnst ))
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) inv_FMU  fmus)) then
			(
		let 
(timeBasedClock_R::TimeBasedClock) = (createTimeBased (''r'')   (2::VDMNat1)   (2::VDMNat1)   Interval.U_fixed    \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U ctrlFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (21::VDMNat1)\<rparr>)
		in
			(if (inv_TimeBasedClock timeBasedClock_R) then
			(
		let 
(timeBasedClocks::TimeBasedClock VDMSet1) = {timeBasedClock_R}
		in
			(if ((inv_VDMSet1' inv_TimeBasedClock  timeBasedClocks)) then
			(
		let 
(connections::(FMURef \<rightharpoonup> FMURef)) = [\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U supervisorFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (10::VDMNat1)\<rparr>\<mapsto>\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U ctrlFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (0::VDMNat)\<rparr>,\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U ctrlFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (10::VDMNat1)\<rparr>\<mapsto>\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U actuationFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (0::VDMNat)\<rparr>,\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U actuationFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (10::VDMNat1)\<rparr>\<mapsto>\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U plantFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (0::VDMNat)\<rparr>,\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U plantFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (10::VDMNat1)\<rparr>\<mapsto>\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U sensorFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (0::VDMNat)\<rparr>,\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U sensorFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (10::VDMNat1)\<rparr>\<mapsto>\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U ctrlFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (1::VDMNat1)\<rparr>]
		;
		
(clockConnections::(FMURef \<rightharpoonup> FMURef)) = [\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U supervisorFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (20::VDMNat1)\<rparr>\<mapsto>\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U ctrlFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (20::VDMNat1)\<rparr>]
		in
			(if ((inv_Map inv_FMURef  inv_FMURef  connections))
	 \<and> 
	((inv_Map inv_FMURef  inv_FMURef  clockConnections)) then
			(
		let 
(timeBasedClockConnections::(Name \<rightharpoonup> FMURef VDMSet1)) = [(name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k timeBasedClock_R)\<mapsto>{\<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U sensorFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (20::VDMNat1)\<rparr> , \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U actuationFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (20::VDMNat1)\<rparr> , \<lparr>name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (name\<^sub>F\<^sub>M\<^sub>U ctrlFMU), ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f = (21::VDMNat1)\<rparr>}]
		in
			(if ((inv_Map ((inv_VDMSeq1' (inv_VDMChar))) (inv_VDMSet1' inv_FMURef ) timeBasedClockConnections)) then
			\<lparr>fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e = fmus, timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e = timeBasedClocks, connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e = connections, clockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e = clockConnections, timedClockConnections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e = timeBasedClockConnections\<rparr>
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
		)
		 else
			undefined
		)
		)
		 else
			undefined
		)
		)"

\<comment>\<open>Processing VDM exports as Isabelle hidden declarations\<close>
hide_const "runAction"
hide_const "max_FMU"
hide_const "calculateRelevantFMUs"
hide_type "Time"
hide_const "inv_TimeBasedClock"
hide_const "measure_solveSystemOfEquations"
hide_const "post_enterEventMode"
hide_const "postInitialization"
hide_const "calculateSchedule"
hide_const "runScenario"
hide_const "postTermination"
hide_const "max_Action"
hide_const "pre_enterStepMode"
hide_const "measure_calculateRelevantFMUs"
hide_const "pre_calculateSchedule"
hide_const "pre_updateEnvironmentEquation"
hide_const "max_Time"
hide_const "minset"
hide_const "measure_filterOutputs"
hide_const "pre_clockedSimulationAlgorithm"
hide_const "sameSetOfFMUs"
hide_const "updateEnvironmentClock"
hide_const "post_stepnegotiation"
hide_const "post_activateClocks"
hide_const "post_initialization"
hide_const "measure_cosimulationStep"
hide_const "stepFMU"
hide_const "timeAdvanced"
hide_const "pre_createSchedule"
hide_const "pre_activateClocks"
hide_const "max_FMURef"
hide_const "pre_fmusNotAffected"
hide_const "post_calculateSchedule"
hide_const "preSetI"
hide_const "post_set_m"
hide_const "calculateOutput"
hide_const "filterOutputs"
hide_const "preSetC"
hide_const "post_initializeData"
hide_const "post_terminate"
hide_const "pre_set_cm"
hide_const "preCoSimulationStep"
hide_const "measure_activateClocks"
hide_const "pre_calculateRelevantFMUs"
hide_type "FMU"
hide_const "feedthroughSatisfied"
hide_const "get_cm"
hide_type "Ref"
hide_const "calculateInput"
hide_const "fmusSynchronized"
hide_const "pre_enterEventMode"
hide_const "step_e"
hide_const "post_eventIteration"
hide_const "initializeData"
hide_const "preSetCI"
hide_type "Variable"
hide_const "pre_next_tm"
hide_const "derefOutput"
hide_const "pre_derefOutput"
hide_const "set_m"
hide_const "preSet"
hide_const "pre_setClock"
hide_const "post_get_m"
hide_const "createFMU"
hide_const "post_updateDiscreteState"
hide_const "updateEnvironmentEquation"
hide_const "measure_minset"
hide_const "pre_get_m"
hide_const "pre_calculateOutput"
hide_const "selectMinStep"
hide_const "preEventMode"
hide_const "selectAction"
hide_const "measure_runAlgorithm"
hide_type "Causality"
hide_const "preInitialization"
hide_const "runAlgorithm"
hide_const "terminate"
hide_const "eq_Variable"
hide_type "Value"
hide_const "ord_Action"
hide_const "cosimStep"
hide_type "ActionType"
hide_const "preGetC"
hide_const "preGetI"
hide_type "Clock"
hide_const "inv_Variable"
hide_const "post_stepFMU"
hide_const "createVariable"
hide_const "ord_FMU"
hide_type "Importer"
hide_const "createImporter"
hide_type "ValueType"
hide_const "tickingClocks"
hide_const "fmusSynchronizedAtTime"
hide_const "preTermination"
hide_type "Equation"
hide_const "eq_Clock"
hide_const "ord_FMURef"
hide_const "inv_FMU"
hide_const "step_tm"
hide_const "pre_derefInput"
hide_const "pre_stepFMU"
hide_const "post_set_cm"
hide_const "pre_initializeData"
hide_type "RealNaN"
hide_type "Machine"
hide_const "pre_step_tm"
hide_const "pre_updateDiscreteState"
hide_type "Action"
hide_const "fmusNotAffected"
hide_const "post_cosimulationStep"
hide_const "pre_derefClock"
hide_const "pre_setPort"
hide_const "setPort"
hide_const "pre_selectAction"
hide_const "inv_Importer"
hide_const "queryClock"
hide_const "post_updateEnvironmentEquation"
hide_const "activateClocks"
hide_const "initialization"
hide_const "post_setPort"
hide_const "preGetCI"
hide_const "pre_cosimulationStep"
hide_const "postCosimulationStep"
hide_const "eq_Time"
hide_const "preStepI"
hide_const "postEventMode"
hide_const "post_updateEnvironmentClock"
hide_const "post_step_tm"
hide_const "preStepE"
hide_type "Environment"
hide_const "inv_Machine"
hide_const "derefClock"
hide_const "max_Clock"
hide_const "preStepT"
hide_const "pre_timeAdvanced"
hide_const "post_calculateInput"
hide_type "FMUMode"
hide_const "post_calculateOutput"
hide_const "eventIteration"
hide_const "setClock"
hide_const "enterStepMode"
hide_const "get_m"
hide_const "post_clockedSimulationAlgorithm"
hide_const "updateDiscreteState"
hide_const "post_createFMURefs"
hide_const "derefInput"
hide_const "set_cm"
hide_const "updateOutputs"
hide_const "min_FMU"
hide_const "createScenario"
hide_const "createTimeBased"
hide_const "createClock"
hide_const "pre_get_cm"
hide_const "post_calculateRelevantFMUs"
hide_const "stepnegotiation"
hide_const "inv_Time"
hide_const "getPort"
hide_const "pre_step_e"
hide_const "pre_cosimStep"
hide_const "pre_calculateInput"
hide_const "post_solveSystemOfEquations"
hide_const "ord_Clock"
hide_const "solveSystemOfEquations"
hide_const "inv_Clock"
hide_const "next_tm"
hide_const "pre_initialization"
hide_const "createSchedule"
hide_const "ImporterNotAffected"
hide_const "post_step_e"
hide_const "eventSolved"
hide_const "pre_eventSolved"
hide_const "min_Time"
hide_const "ord_Time"
hide_const "variablesSynchronized"
hide_const "preGet"
hide_const "min_Clock"
hide_type "TimeBasedClock"
hide_const "post_selectAction"
hide_const "post_getPort"
hide_const "isActionEnabled"
hide_const "post_createSchedule"
hide_type "PortType"
hide_type "Contract"
hide_type "Interval"
hide_const "clockedSimulationAlgorithm"
hide_const "pre_terminate"
hide_const "pre_queryClock"
hide_const "postStepE"
hide_type "Name"
hide_const "createFMURefs"
hide_const "pre_getPort"
hide_const "min_FMURef"
hide_const "postStepMode"
hide_type "FMURef"
hide_const "eq_FMURef"
hide_const "post_cosimStep"
hide_const "calculate"
hide_const "pre_set_m"
hide_const "post_setClock"
hide_const "postVaraibleCalculation"
hide_const "post_queryClock"
hide_const "enterEventMode"
hide_const "pre_eventIteration"
hide_const "postStepT"
hide_const "cosimulationStep"
hide_const "post_enterStepMode"
hide_const "assertFMUMode"
hide_const "min_Action"

end