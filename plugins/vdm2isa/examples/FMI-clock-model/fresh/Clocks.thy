(* VDM to Isabelle Translation @2022-02-17T14:07:16.225393Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in 'Clocks.vdmsl' at line 1:8
files = [Clocks.vdmsl]
*)
theory Clocks
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: Real1 = real
	inv r == (r >= 0)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 35:5\<close>
type_synonym Real1 = "VDMReal"
	

\<comment>\<open>VDM source: inv_Real1: (real +> bool)
	inv_Real1(r) ==
(r >= 0)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 36:9\<close>
definition
	inv_Real1 :: "Real1 \<Rightarrow> bool"
where
	"inv_Real1 r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Real1` specification.\<close>
		(((inv_VDMReal r)))  \<and> 
		\<comment>\<open>User defined body of inv_Real1.\<close>
		(r \<ge> (0::VDMNat))"

		 
lemmas inv_Real1_defs = inv_Real1_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: Time = compose Time of r:Real1, i:nat end
	eq a = b == (((a.r) = (b.r)) and ((a.i) = (b.i)))
	ord a < b == (((a.r) < (b.r)) or (((a.r) = (b.r)) and ((a.i) < (b.i))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 42:5\<close>
record Time = 
	r\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "Real1"
		 
		 i\<^sub>T\<^sub>i\<^sub>m\<^sub>e :: "VDMNat"
	

\<comment>\<open>VDM source: inv_Time: (Time +> bool)
	inv_Time(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 42:5\<close>
definition
	inv_Time :: "Time \<Rightarrow> bool"
where
	"inv_Time dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Time` specification.\<close>
		( (((inv_Real1 (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e dummy0))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e dummy0))) ))"

		

\<comment>\<open>VDM source: eq_Time: (Time * Time +> bool)
	eq_Time(a, b) ==
(((a.r) = (b.r)) and ((a.i) = (b.i)))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 45:8\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 46:9\<close>
definition
	ord_Time :: "Time \<Rightarrow> Time \<Rightarrow> bool"
where
	"ord_Time a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Time` specification.\<close>
		(inv_Time a  \<and>  inv_Time b)  \<and> 
		\<comment>\<open>User defined body of ord_Time.\<close>
		(((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) < (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<or> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) = (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e b)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e a) < (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e b))))"

		
lemmas inv_Time_defs = inv_Real1_def inv_Time_def inv_VDMNat_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: Interval = (<calculated> | <changing> | <constant> | <countdown> | <fixed> | <triggered> | <tunable>)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 54:5\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 54:5\<close>
definition
	inv_Interval :: "Interval \<Rightarrow> bool"
where
	"inv_Interval dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Interval` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_Interval_defs = inv_Interval_def inv_True_def 


	
	
\<comment>\<open>VDM source: FMUMode = (<DONE> | <EVENT> | <INIT> | <STEP>)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 56:5\<close>
datatype FMUMode = U_DONE  | 
		 U_EVENT  | 
		 U_INIT  | 
		 U_STEP 
	

\<comment>\<open>VDM source: inv_FMUMode: (FMUMode +> bool)
	inv_FMUMode(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 56:5\<close>
definition
	inv_FMUMode :: "FMUMode \<Rightarrow> bool"
where
	"inv_FMUMode dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMUMode` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_FMUMode_defs = inv_FMUMode_def inv_True_def 


	
	
\<comment>\<open>VDM source: Contract = (<delayed> | <none> | <reactive>)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 58:5\<close>
datatype Contract = U_delayed  | 
		 U_none  | 
		 U_reactive 
	

\<comment>\<open>VDM source: inv_Contract: (Contract +> bool)
	inv_Contract(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 58:5\<close>
definition
	inv_Contract :: "Contract \<Rightarrow> bool"
where
	"inv_Contract dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Contract` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_Contract_defs = inv_Contract_def inv_True_def 


	
	
\<comment>\<open>VDM source: RealNaN = (<NaN> | real)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 60:5\<close>
datatype RealNaN = U_NaN  | 
		 U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_RealNaN: (RealNaN +> bool)
	inv_RealNaN(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 60:5\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 62:5\<close>
datatype PortType = U_continous  | 
		 U_discrete 
	

\<comment>\<open>VDM source: inv_PortType: (PortType +> bool)
	inv_PortType(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 62:5\<close>
definition
	inv_PortType :: "PortType \<Rightarrow> bool"
where
	"inv_PortType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_PortType` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_PortType_defs = inv_PortType_def inv_True_def 


	
	
\<comment>\<open>VDM source: Causality = (<input> | <output>)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 64:5\<close>
datatype Causality = U_input  | 
		 U_output 
	

\<comment>\<open>VDM source: inv_Causality: (Causality +> bool)
	inv_Causality(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 64:5\<close>
definition
	inv_Causality :: "Causality \<Rightarrow> bool"
where
	"inv_Causality dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Causality` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_Causality_defs = inv_Causality_def inv_True_def 


	
	
\<comment>\<open>VDM source: ActionType = (<get> | <getC> | <set> | <setC> | <step>)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 68:5\<close>
datatype ActionType = U_get  | 
		 U_getC  | 
		 U_set  | 
		 U_setC  | 
		 U_step 
	

\<comment>\<open>VDM source: inv_ActionType: (ActionType +> bool)
	inv_ActionType(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 68:5\<close>
definition
	inv_ActionType :: "ActionType \<Rightarrow> bool"
where
	"inv_ActionType dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_ActionType` specification.\<close>
		((((inv_True dummy0))))"

		 
lemmas inv_ActionType_defs = inv_ActionType_def inv_True_def 


	
	
\<comment>\<open>VDM source: ValueType = (bool | real)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 70:5\<close>
datatype ValueType = U_bool "bool" | 
		 U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_ValueType: (ValueType +> bool)
	inv_ValueType(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 70:5\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 76:5\<close>
type_synonym Name = "VDMChar VDMSeq1"
	

\<comment>\<open>VDM source: inv_Name: (Name +> bool)
	inv_Name(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 76:5\<close>
definition
	inv_Name :: "Name \<Rightarrow> bool"
where
	"inv_Name dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Name` specification.\<close>
		(((inv_VDMSeq1' (inv_VDMChar) dummy0)))"

		 
lemmas inv_Name_defs = inv_Name_def inv_VDMChar_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


	
	
\<comment>\<open>VDM source: Ref = nat\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 81:5\<close>
type_synonym Ref = "VDMNat"
	

\<comment>\<open>VDM source: inv_Ref: (Ref +> bool)
	inv_Ref(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 81:5\<close>
definition
	inv_Ref :: "Ref \<Rightarrow> bool"
where
	"inv_Ref dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Ref` specification.\<close>
		(((inv_VDMNat dummy0)))"

		 
lemmas inv_Ref_defs = inv_Ref_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: Action = compose Action of actionType:ActionType, fmu:Name, port:Ref end
	eq mk_Action(act1, fmu1, port1) = mk_Action(act2, fmu2, port2) == ((act1 = act2) and ((fmu1 = fmu2) and (port1 = port2)))
	ord a < b == ((a.port) < (b.port))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 86:5\<close>
record Action = 
	actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "ActionType"
		 
		 fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "Name"
		 
		 port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n :: "Ref"
	

\<comment>\<open>VDM source: inv_Action: (Action +> bool)
	inv_Action(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 86:5\<close>
definition
	inv_Action :: "Action \<Rightarrow> bool"
where
	"inv_Action dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Action` specification.\<close>
		( (((inv_ActionType (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))) \<and> 
		 ((inv_Name (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))) \<and> 
		 ((inv_Ref (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0))) ))"

		

\<comment>\<open>VDM source: eq_Action: (Action * Action +> bool)
	eq_Action(mk_Action(act1, fmu1, port1), mk_Action(act2, fmu2, port2)) ==
((act1 = act2) and ((fmu1 = fmu2) and (port1 = port2)))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 90:8\<close>
definition
	eq_Action :: "Action \<Rightarrow> Action \<Rightarrow> bool"
where
	"eq_Action dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Action` specification.\<close>
		(inv_Action dummy0  \<and>  inv_Action dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let act1 = (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0); fmu1 = (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0); port1 = (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0); 
			act1 = (actionType\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0); fmu1 = (fmu\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0); port1 = (port\<^sub>A\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n dummy0) in 
		\<comment>\<open>User defined body of eq_Action.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		(((act1 = act2) \<and> ((fmu1 = fmu2) \<and> (port1 = port2))))))"

		

\<comment>\<open>VDM source: ord_Action: (Action * Action +> bool)
	ord_Action(a, b) ==
((a.port) < (b.port))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 94:9\<close>
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
	eq mk_FMURef(name1, ref1) = mk_FMURef(name2, ref2) == ((name1 = name2) and (ref1 = ref2))
	ord a < b == ((a.ref) < (b.ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 101:5\<close>
record FMURef = 
	name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Name"
		 
		 ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Ref"
	

\<comment>\<open>VDM source: inv_FMURef: (FMURef +> bool)
	inv_FMURef(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 101:5\<close>
definition
	inv_FMURef :: "FMURef \<Rightarrow> bool"
where
	"inv_FMURef dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMURef` specification.\<close>
		( (((inv_Name (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0))) \<and> 
		 ((inv_Ref (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0))) ))"

		

\<comment>\<open>VDM source: eq_FMURef: (FMURef * FMURef +> bool)
	eq_FMURef(mk_FMURef(name1, ref1), mk_FMURef(name2, ref2)) ==
((name1 = name2) and (ref1 = ref2))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 105:8\<close>
definition
	eq_FMURef :: "FMURef \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"eq_FMURef dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_FMURef` specification.\<close>
		(inv_FMURef dummy0  \<and>  inv_FMURef dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let name1 = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0); ref1 = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0); 
			name1 = (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0); ref1 = (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f dummy0) in 
		\<comment>\<open>User defined body of eq_FMURef.\<close>
		((name1 = name2) \<and> (ref1 = ref2)))"

		

\<comment>\<open>VDM source: ord_FMURef: (FMURef * FMURef +> bool)
	ord_FMURef(a, b) ==
((a.ref) < (b.ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 104:9\<close>
definition
	ord_FMURef :: "FMURef \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"ord_FMURef a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_FMURef` specification.\<close>
		(inv_FMURef a  \<and>  inv_FMURef b)  \<and> 
		\<comment>\<open>User defined body of ord_FMURef.\<close>
		((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f a) < (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f b))"

		
lemmas inv_FMURef_defs = inv_FMURef_def inv_Name_def inv_Ref_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


	
	
\<comment>\<open>VDM source: FMIValue = compose FMIValue of fmiValue:ValueType, time:Time end
	eq mk_FMIValue(val1, t1) = mk_FMIValue(val2, t2) == ((val1 = val2) and (t1 = t2))
	ord mk_FMIValue(-, t1) < mk_FMIValue(-, t2) == (t1 < t2)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 113:5\<close>
record FMIValue = 
	fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "ValueType"
		 
		 time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e :: "Time"
	

\<comment>\<open>VDM source: inv_FMIValue: (FMIValue +> bool)
	inv_FMIValue(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 113:5\<close>
definition
	inv_FMIValue :: "FMIValue \<Rightarrow> bool"
where
	"inv_FMIValue dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_FMIValue` specification.\<close>
		( (((inv_ValueType (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0))) \<and> 
		 (inv_Time (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0)) ))"

		

\<comment>\<open>VDM source: eq_FMIValue: (FMIValue * FMIValue +> bool)
	eq_FMIValue(mk_FMIValue(val1, t1), mk_FMIValue(val2, t2)) ==
((val1 = val2) and (t1 = t2))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 117:8\<close>
definition
	eq_FMIValue :: "FMIValue \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"eq_FMIValue dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_FMIValue` specification.\<close>
		(inv_FMIValue dummy0  \<and>  inv_FMIValue dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let val1 = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); 
			val1 = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of eq_FMIValue.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		()))"

		

\<comment>\<open>VDM source: ord_FMIValue: (FMIValue * FMIValue +> bool)
	ord_FMIValue(mk_FMIValue(-, t1), mk_FMIValue(-, t2)) ==
(t1 < t2)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 116:9\<close>
definition
	ord_FMIValue :: "FMIValue \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"ord_FMIValue dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_FMIValue` specification.\<close>
		(inv_FMIValue dummy0  \<and>  inv_FMIValue dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let dummy0_ignore = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); 
			dummy0_ignore = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of ord_FMIValue.\<close>
		\<comment>\<open>Transform a VDM `<` expression into an `ord_Time` call\<close>
	(ord_Time t1   t2))"

		
lemmas inv_FMIValue_defs = inv_FMIValue_def inv_Real1_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Environment = map (Ref) to (FMIValue)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 125:5\<close>
type_synonym Environment = "(Ref \<rightharpoonup> FMIValue)"
	

\<comment>\<open>VDM source: inv_Environment: (Environment +> bool)
	inv_Environment(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 125:5\<close>
definition
	inv_Environment :: "Environment \<Rightarrow> bool"
where
	"inv_Environment dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Environment` specification.\<close>
		(((inv_Map (inv_Ref) inv_FMIValue  dummy0)))"
 
lemmas inv_Environment_defs = inv_Environment_def inv_FMIValue_def inv_Map_defs inv_Real1_def inv_Ref_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Equation = (Environment -> Environment)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 131:5\<close>
type_synonym Equation = "Environment \<Rightarrow> Environment"
	

\<comment>\<open>VDM source: inv_Equation: (Equation +> bool)
	inv_Equation(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 131:5\<close>
definition
	inv_Equation :: "Equation \<Rightarrow> bool"
where
	"inv_Equation dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_Equation` specification.\<close>
		(((inv_Lambda (inv_Environment) (inv_Environment)dummy0)))"

		 
lemmas inv_Equation_defs = inv_Environment_def inv_Equation_def inv_FMIValue_def inv_Lambda_def inv_Map_defs inv_Real1_def inv_Ref_def inv_Time_def inv_VDMNat_def inv_VDMReal_def inv_ValueType_def inv_bool_def 


	
	
\<comment>\<open>VDM source: Variable = compose Variable of name:Name, ref:Ref, time:Time, causality:Causality, type:PortType, clocks:set of (Ref), dependsOn:set of (Ref), contract:Contract end
	inv mk_Variable(-, -, -, causality, type, clocks, dependsOn, contract) == (((causality = <output>) => (contract = <none>)) and (((causality = <input>) => (contract <> <none>)) and (((causality = <input>) => (dependsOn = {})) and (((type = <continous>) => (clocks = {})) and (((type = <discrete>) and (causality = <input>)) => (clocks = {}))))))
	eq mk_Variable(name1, ref1, -, causality1, -, -, -, -) = mk_Variable(name2, ref2, -, causality2, -, -, -, -) == ((name1 = name2) and ((ref1 = ref2) and (causality1 = causality2)))
	ord mk_Variable(-, ref1, -, -, -, -, -, -) < mk_Variable(-, ref2, -, -, -, -, -, -) == (ref1 < ref2)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 137:5\<close>
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
	inv_Variable(mk_Variable(-, -, -, causality, type, clocks, dependsOn, contract)) ==
(((causality = <output>) => (contract = <none>)) and (((causality = <input>) => (contract <> <none>)) and (((causality = <input>) => (dependsOn = {})) and (((type = <continous>) => (clocks = {})) and (((type = <discrete>) and (causality = <input>)) => (clocks = {}))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 146:9\<close>
definition
	inv_Variable :: "Variable \<Rightarrow> bool"
where
	"inv_Variable dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Variable` specification.\<close>
		( (((inv_Name (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) \<and> 
		 ((inv_Ref (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) \<and> 
		 (inv_Time (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0)) \<and> 
		 ((inv_Causality (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) \<and> 
		 ((inv_PortType (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) \<and> 
		 ((inv_Contract (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let dummy0_ignore = (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); causality = (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); type = (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); clocks = (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dependsOn = (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); contract = (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of inv_Variable.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		((((causality = Causality.U_output ) \<longrightarrow> (contract = Contract.U_none )) \<and> (((causality = Causality.U_input ) \<longrightarrow> (contract \<noteq> Contract.U_none )) \<and> (((causality = Causality.U_input ) \<longrightarrow> (dependsOn = {})) \<and> (((type = PortType.U_continous ) \<longrightarrow> (clocks = {})) \<and> (((type = PortType.U_discrete ) \<and> (causality = Causality.U_input )) \<longrightarrow> (clocks = {})))))))))"

		

\<comment>\<open>VDM source: eq_Variable: (Variable * Variable +> bool)
	eq_Variable(mk_Variable(name1, ref1, -, causality1, -, -, -, -), mk_Variable(name2, ref2, -, causality2, -, -, -, -)) ==
((name1 = name2) and ((ref1 = ref2) and (causality1 = causality2)))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 155:9\<close>
definition
	eq_Variable :: "Variable \<Rightarrow> Variable \<Rightarrow> bool"
where
	"eq_Variable dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Variable` specification.\<close>
		(inv_Variable dummy0  \<and>  inv_Variable dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let name1 = (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); ref1 = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); causality1 = (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); 
			name1 = (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); ref1 = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); causality1 = (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of eq_Variable.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		(((name1 = name2) \<and> ((ref1 = ref2) \<and> (causality1 = causality2))))))"

		

\<comment>\<open>VDM source: ord_Variable: (Variable * Variable +> bool)
	ord_Variable(mk_Variable(-, ref1, -, -, -, -, -, -), mk_Variable(-, ref2, -, -, -, -, -, -)) ==
(ref1 < ref2)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 152:9\<close>
definition
	ord_Variable :: "Variable \<Rightarrow> Variable \<Rightarrow> bool"
where
	"ord_Variable dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Variable` specification.\<close>
		(inv_Variable dummy0  \<and>  inv_Variable dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let dummy0_ignore = (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); ref1 = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); 
			dummy0_ignore = (name\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); ref1 = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (time\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (clocks\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0); dummy0_ignore = (contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of ord_Variable.\<close>
		(ref1 < ref2))"

		
lemmas inv_Variable_defs = inv_Causality_def inv_Contract_def inv_Name_def inv_PortType_def inv_Real1_def inv_Ref_def inv_Time_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_Variable_def 


	
	
\<comment>\<open>VDM source: TimeBasedClock = compose TimeBasedClock of name:Name, shift:Real1, period:Real1, interval:Interval, master:FMURef end
	inv clock == ((clock.interval) <> <triggered>)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 160:5\<close>
record TimeBasedClock = 
	name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Name"
		 
		 shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Real1"
		 
		 period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Real1"
		 
		 interval\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "Interval"
		 
		 master\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k :: "FMURef"
	

\<comment>\<open>VDM source: inv_TimeBasedClock: (TimeBasedClock +> bool)
	inv_TimeBasedClock(clock) ==
((clock.interval) <> <triggered>)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 166:9\<close>
definition
	inv_TimeBasedClock :: "TimeBasedClock \<Rightarrow> bool"
where
	"inv_TimeBasedClock clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_TimeBasedClock` specification.\<close>
		( (((inv_Name (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_Real1 (shift\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_Real1 (period\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 ((inv_Interval (interval\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock))) \<and> 
		 (inv_FMURef (master\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock)) ))  \<and> 
		\<comment>\<open>User defined body of inv_TimeBasedClock.\<close>
		((interval\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) \<noteq> Interval.U_triggered )"

		
lemmas inv_TimeBasedClock_defs = inv_FMURef_def inv_Interval_def inv_Name_def inv_Real1_def inv_Ref_def inv_TimeBasedClock_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


	
	
\<comment>\<open>VDM source: Clock = compose Clock of name:Name, ref:Ref, type:Causality, interval:Interval, dependsOn:set of (Ref), equations:set of (Ref) end
	inv clock == ((((clock.type) = <output>) => ((clock.interval) = <triggered>)) and (((clock.type) = <input>) => ((clock.dependsOn) = {})))
	eq mk_Clock(name1, ref1, type1, interval1, -, -) = mk_Clock(name2, ref2, type2, interval2, -, -) == ((name1 = name2) and ((ref1 = ref2) and ((type1 = type2) and (interval1 = interval2))))
	ord c1 < c2 == ((c1.ref) < (c2.ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 172:5\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 179:9\<close>
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
	eq_Clock(mk_Clock(name1, ref1, type1, interval1, -, -), mk_Clock(name2, ref2, type2, interval2, -, -)) ==
((name1 = name2) and ((ref1 = ref2) and ((type1 = type2) and (interval1 = interval2))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 183:8\<close>
definition
	eq_Clock :: "Clock \<Rightarrow> Clock \<Rightarrow> bool"
where
	"eq_Clock dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_Clock` specification.\<close>
		(inv_Clock dummy0  \<and>  inv_Clock dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let name1 = (name\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); ref1 = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); type1 = (type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); interval1 = (interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); dummy0_ignore = (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); dummy0_ignore = (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); 
			name1 = (name\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); ref1 = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); type1 = (type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); interval1 = (interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); dummy0_ignore = (dependsOn\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0); dummy0_ignore = (equations\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k dummy0) in 
		\<comment>\<open>User defined body of eq_Clock.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		(((name1 = name2) \<and> ((ref1 = ref2) \<and> ((type1 = type2) \<and> (interval1 = interval2)))))))"

		

\<comment>\<open>VDM source: ord_Clock: (Clock * Clock +> bool)
	ord_Clock(c1, c2) ==
((c1.ref) < (c2.ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 182:9\<close>
definition
	ord_Clock :: "Clock \<Rightarrow> Clock \<Rightarrow> bool"
where
	"ord_Clock c1   c2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_Clock` specification.\<close>
		(inv_Clock c1  \<and>  inv_Clock c2)  \<and> 
		\<comment>\<open>User defined body of ord_Clock.\<close>
		((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c1) < (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c2))"

		
lemmas inv_Clock_defs = inv_Causality_def inv_Clock_def inv_Interval_def inv_Name_def inv_Ref_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs 


	
	
\<comment>\<open>VDM source: clock_refs: (set of (Clock) -> set of (Ref))
	clock_refs(cs) ==
{(c.ref) | c in set cs}
	pre true
	post ((card cs) = (card RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 234:5\<close>

\<comment>\<open>VDM source: pre_clock_refs: (set of (Clock) +> bool)
	pre_clock_refs(cs) ==
true\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 236:9\<close>
definition
	pre_clock_refs :: "Clock VDMSet \<Rightarrow> bool"
where
	"pre_clock_refs cs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_clock_refs` specification.\<close>
		((inv_VDMSet' inv_Clock  cs))  \<and> 
		\<comment>\<open>User defined body of pre_clock_refs.\<close>
		(True::\<bool>)"


\<comment>\<open>VDM source: post_clock_refs: (set of (Clock) * set of (Ref) +> bool)
	post_clock_refs(cs, RESULT) ==
((card cs) = (card RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 238:17\<close>
definition
	post_clock_refs :: "Clock VDMSet \<Rightarrow> Ref VDMSet \<Rightarrow> bool"
where
	"post_clock_refs cs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_clock_refs` specification.\<close>
		((inv_VDMSet' inv_Clock  cs)  \<and>  (inv_VDMSet' (inv_Ref) RESULT))  \<and> 
		\<comment>\<open>User defined body of post_clock_refs.\<close>
		((vdm_card cs) = (vdm_card RESULT))"

definition
	clock_refs :: "Clock VDMSet \<Rightarrow> Ref VDMSet"
where
	"clock_refs cs \<equiv> 
	\<comment>\<open>User defined body of clock_refs.\<close>
	{ (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>cs))  }"

	
	
\<comment>\<open>VDM source: var_refs: (set1 of (Variable) -> set1 of (Ref))
	var_refs(vs) ==
{(v.ref) | v in set vs}
	pre true
	post ((card vs) = (card RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 241:5\<close>

\<comment>\<open>VDM source: pre_var_refs: (set1 of (Variable) +> bool)
	pre_var_refs(vs) ==
true\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 243:9\<close>
definition
	pre_var_refs :: "Variable VDMSet1 \<Rightarrow> bool"
where
	"pre_var_refs vs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_var_refs` specification.\<close>
		((inv_VDMSet1' inv_Variable  vs))  \<and> 
		\<comment>\<open>User defined body of pre_var_refs.\<close>
		(True::\<bool>)"


\<comment>\<open>VDM source: post_var_refs: (set1 of (Variable) * set1 of (Ref) +> bool)
	post_var_refs(vs, RESULT) ==
((card vs) = (card RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 245:17\<close>
definition
	post_var_refs :: "Variable VDMSet1 \<Rightarrow> Ref VDMSet1 \<Rightarrow> bool"
where
	"post_var_refs vs   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_var_refs` specification.\<close>
		((inv_VDMSet1' inv_Variable  vs)  \<and>  (inv_VDMSet1' (inv_Ref) RESULT))  \<and> 
		\<comment>\<open>User defined body of post_var_refs.\<close>
		((vdm_card vs) = (vdm_card RESULT))"

definition
	var_refs :: "Variable VDMSet1 \<Rightarrow> Ref VDMSet1"
where
	"var_refs vs \<equiv> 
	\<comment>\<open>User defined body of var_refs.\<close>
	{ (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) | v .  ((v \<in>vs))  }"

	
	
\<comment>\<open>VDM source: IOLeo = compose IOLeo of LFinput:set of (Variable), LFoutput:set of (Variable) end
	inv mk_IOLeo(LFinput, LFoutput) == ((LFinput union LFoutput) <> {})\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 249:5\<close>
record IOLeo = 
	LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o :: "Variable VDMSet"
		 
		 LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o :: "Variable VDMSet"
	

\<comment>\<open>VDM source: inv_IOLeo: (IOLeo +> bool)
	inv_IOLeo(mk_IOLeo(LFinput, LFoutput)) ==
((LFinput union LFoutput) <> {})\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 253:9\<close>
definition
	inv_IOLeo :: "IOLeo \<Rightarrow> bool"
where
	"inv_IOLeo dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_IOLeo` specification.\<close>
		( (((inv_VDMSet' inv_Variable  (LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o dummy0))) \<and> 
		 ((inv_VDMSet' inv_Variable  (LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let LFinput = (LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o dummy0); LFoutput = (LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o dummy0) in 
		\<comment>\<open>User defined body of inv_IOLeo.\<close>
		((LFinput \<union> LFoutput) \<noteq> {}))"

		
lemmas inv_IOLeo_defs = inv_Causality_def inv_Contract_def inv_IOLeo_def inv_Name_def inv_PortType_def inv_Real1_def inv_Ref_def inv_Time_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_Variable_def 


	
	
\<comment>\<open>VDM source: FMU = compose FMU of id:nat, name:Name, clocks:set of (Clock), io:IOLeo, mode:FMUMode, time:Time, stepped:bool, maxStep:Real1, env:Environment, activeClocks:set of (Ref), activeEquations:set of (Equation) end
	inv mk_FMU(-, -, clocks, io, mode, time, -, -, env, activeClocks, activeEquations) == (pre_clock_refs(clocks) and (pre_var_refs(((io.LFinput) union (io.LFoutput))) and let vars:set1 of (Variable) = ((io.LFinput) union (io.LFoutput)), crefs:set of (Ref) = clock_refs(clocks), vrefs:set1 of (Ref) = var_refs(vars), refs:set1 of (Ref) = (crefs union vrefs) in (post_clock_refs(clocks, crefs) and (post_var_refs(vars, vrefs) and (((crefs inter vrefs) = {}) and (((card refs) = ((card clocks) + (card vars))) and (((dom env) subset refs) and ((activeClocks subset crefs) and (((mode <> <EVENT>) => ((activeClocks = {}) and ((activeEquations = {}) and ((time.i) = 0)))) and (((mode <> <EVENT>) => (activeEquations = {})) and (((mode <> <EVENT>) => ((time.i) = 0)) and (forall var in set vars & ((var.clocks) subset crefs)))))))))))))
	eq fmu1 = fmu2 == ((fmu1.id) = (fmu2.id))
	ord fmu1 < fmu2 == ((fmu1.id) < (fmu2.id))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 256:5\<close>
record FMU = 
	id\<^sub>F\<^sub>M\<^sub>U :: "VDMNat"
		 
		 name\<^sub>F\<^sub>M\<^sub>U :: "Name"
		 
		 clocks\<^sub>F\<^sub>M\<^sub>U :: "Clock VDMSet"
		 
		 io\<^sub>F\<^sub>M\<^sub>U :: "IOLeo"
		 
		 mode\<^sub>F\<^sub>M\<^sub>U :: "FMUMode"
		 
		 time\<^sub>F\<^sub>M\<^sub>U :: "Time"
		 
		 stepped\<^sub>F\<^sub>M\<^sub>U :: "bool"
		 
		 maxStep\<^sub>F\<^sub>M\<^sub>U :: "Real1"
		 
		 env\<^sub>F\<^sub>M\<^sub>U :: "Environment"
		 
		 activeClocks\<^sub>F\<^sub>M\<^sub>U :: "Ref VDMSet"
		 
		 activeEquations\<^sub>F\<^sub>M\<^sub>U :: "Equation VDMSet"
	

\<comment>\<open>VDM source: inv_FMU: (FMU +> bool)
	inv_FMU(mk_FMU(-, -, clocks, io, mode, time, -, -, env, activeClocks, activeEquations)) ==
(pre_clock_refs(clocks) and (pre_var_refs(((io.LFinput) union (io.LFoutput))) and let vars:set1 of (Variable) = ((io.LFinput) union (io.LFoutput)), crefs:set of (Ref) = clock_refs(clocks), vrefs:set1 of (Ref) = var_refs(vars), refs:set1 of (Ref) = (crefs union vrefs) in (post_clock_refs(clocks, crefs) and (post_var_refs(vars, vrefs) and (((crefs inter vrefs) = {}) and (((card refs) = ((card clocks) + (card vars))) and (((dom env) subset refs) and ((activeClocks subset crefs) and (((mode <> <EVENT>) => ((activeClocks = {}) and ((activeEquations = {}) and ((time.i) = 0)))) and (((mode <> <EVENT>) => (activeEquations = {})) and (((mode <> <EVENT>) => ((time.i) = 0)) and (forall var in set vars & ((var.clocks) subset crefs)))))))))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 269:9\<close>
definition
	inv_FMU :: "FMU \<Rightarrow> bool"
where
	"inv_FMU dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_FMU` specification.\<close>
		( (((inv_VDMNat (id\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 ((inv_Name (name\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 ((inv_VDMSet' inv_Clock  (clocks\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 (inv_IOLeo (io\<^sub>F\<^sub>M\<^sub>U dummy0)) \<and> 
		 ((inv_FMUMode (mode\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 (inv_Time (time\<^sub>F\<^sub>M\<^sub>U dummy0)) \<and> 
		 ((inv_bool (stepped\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 ((inv_Real1 (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 ((inv_Environment (env\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 ((inv_VDMSet' (inv_Ref) (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0))) \<and> 
		 ((inv_VDMSet' (inv_Equation) (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let dummy0_ignore = (id\<^sub>F\<^sub>M\<^sub>U dummy0); dummy0_ignore = (name\<^sub>F\<^sub>M\<^sub>U dummy0); clocks = (clocks\<^sub>F\<^sub>M\<^sub>U dummy0); io = (io\<^sub>F\<^sub>M\<^sub>U dummy0); mode = (mode\<^sub>F\<^sub>M\<^sub>U dummy0); time = (time\<^sub>F\<^sub>M\<^sub>U dummy0); dummy0_ignore = (stepped\<^sub>F\<^sub>M\<^sub>U dummy0); dummy0_ignore = (maxStep\<^sub>F\<^sub>M\<^sub>U dummy0); env = (env\<^sub>F\<^sub>M\<^sub>U dummy0); activeClocks = (activeClocks\<^sub>F\<^sub>M\<^sub>U dummy0); activeEquations = (activeEquations\<^sub>F\<^sub>M\<^sub>U dummy0) in 
		\<comment>\<open>User defined body of inv_FMU.\<close>
		(
		\<comment>\<open>Implicit union type parameters projection\<close>
		()))"

		

\<comment>\<open>VDM source: eq_FMU: (FMU * FMU +> bool)
	eq_FMU(fmu1, fmu2) ==
((fmu1.id) = (fmu2.id))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 306:12\<close>
definition
	eq_FMU :: "FMU \<Rightarrow> FMU \<Rightarrow> bool"
where
	"eq_FMU fmu1   fmu2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_FMU` specification.\<close>
		(inv_FMU fmu1  \<and>  inv_FMU fmu2)  \<and> 
		\<comment>\<open>User defined body of eq_FMU.\<close>
		((id\<^sub>F\<^sub>M\<^sub>U fmu1) = (id\<^sub>F\<^sub>M\<^sub>U fmu2))"

		

\<comment>\<open>VDM source: ord_FMU: (FMU * FMU +> bool)
	ord_FMU(fmu1, fmu2) ==
((fmu1.id) < (fmu2.id))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 308:13\<close>
definition
	ord_FMU :: "FMU \<Rightarrow> FMU \<Rightarrow> bool"
where
	"ord_FMU fmu1   fmu2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_FMU` specification.\<close>
		(inv_FMU fmu1  \<and>  inv_FMU fmu2)  \<and> 
		\<comment>\<open>User defined body of ord_FMU.\<close>
		((id\<^sub>F\<^sub>M\<^sub>U fmu1) < (id\<^sub>F\<^sub>M\<^sub>U fmu2))"

		
lemmas inv_FMU_defs = inv_Causality_def inv_Clock_def inv_Contract_def inv_Environment_def inv_Equation_def inv_FMIValue_def inv_FMU_def inv_FMUMode_def inv_IOLeo_def inv_Interval_def inv_Lambda_def inv_Map_defs inv_Name_def inv_PortType_def inv_Real1_def inv_Ref_def inv_Time_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_ValueType_def inv_Variable_def inv_bool_def 


end