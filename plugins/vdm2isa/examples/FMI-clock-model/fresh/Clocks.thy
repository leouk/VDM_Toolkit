(* VDM to Isabelle Translation @2022-02-17T09:57:08.129070Z
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
		(		(let val1 = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); 
			val1 = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0); t1 = (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of eq_FMIValue.\<close>
		(True

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
	post ((card cs) = (card RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 234:5\<close>

\<comment>\<open>VDM source: pre_clock_refs: (set of (Clock) +> bool)
	pre_clock_refs(cs) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 234:5\<close>
definition
	pre_clock_refs :: "Clock VDMSet \<Rightarrow> bool"
where
	"pre_clock_refs cs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_clock_refs` specification.\<close>
		((inv_VDMSet' inv_Clock  cs))"


\<comment>\<open>VDM source: post_clock_refs: (set of (Clock) * set of (Ref) +> bool)
	post_clock_refs(cs, RESULT) ==
((card cs) = (card RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 237:17\<close>
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
	post ((card vs) = (card RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 240:5\<close>

\<comment>\<open>VDM source: pre_var_refs: (set1 of (Variable) +> bool)
	pre_var_refs(vs) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 240:5\<close>
definition
	pre_var_refs :: "Variable VDMSet1 \<Rightarrow> bool"
where
	"pre_var_refs vs \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_var_refs` specification.\<close>
		((inv_VDMSet1' inv_Variable  vs))"


\<comment>\<open>VDM source: post_var_refs: (set1 of (Variable) * set1 of (Ref) +> bool)
	post_var_refs(vs, RESULT) ==
((card vs) = (card RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 243:17\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 247:5\<close>
record IOLeo = 
	LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o :: "Variable VDMSet"
		 
		 LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o :: "Variable VDMSet"
	

\<comment>\<open>VDM source: inv_IOLeo: (IOLeo +> bool)
	inv_IOLeo(mk_IOLeo(LFinput, LFoutput)) ==
((LFinput union LFoutput) <> {})\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 251:9\<close>
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
	inv mk_FMU(-, -, clocks, io, mode, time, -, -, env, activeClocks, activeEquations) == let vars:set1 of (Variable) = ((io.LFinput) union (io.LFoutput)), crefs:set of (Ref) = clock_refs(clocks), vrefs:set1 of (Ref) = var_refs(vars), refs:set1 of (Ref) = (crefs union vrefs) in (post_clock_refs(clocks, crefs) and (post_var_refs(vars, vrefs) and (((crefs inter vrefs) = {}) and (((card refs) = ((card clocks) + (card vars))) and (((dom env) subset refs) and ((activeClocks subset crefs) and (((mode <> <EVENT>) => ((activeClocks = {}) and ((activeEquations = {}) and ((time.i) = 0)))) and (((mode <> <EVENT>) => (activeEquations = {})) and (((mode <> <EVENT>) => ((time.i) = 0)) and (forall var in set vars & ((var.clocks) subset crefs)))))))))))
	eq fmu1 = fmu2 == ((fmu1.id) = (fmu2.id))
	ord fmu1 < fmu2 == ((fmu1.id) < (fmu2.id))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 254:5\<close>
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
let vars:set1 of (Variable) = ((io.LFinput) union (io.LFoutput)), crefs:set of (Ref) = clock_refs(clocks), vrefs:set1 of (Ref) = var_refs(vars), refs:set1 of (Ref) = (crefs union vrefs) in (post_clock_refs(clocks, crefs) and (post_var_refs(vars, vrefs) and (((crefs inter vrefs) = {}) and (((card refs) = ((card clocks) + (card vars))) and (((dom env) subset refs) and ((activeClocks subset crefs) and (((mode <> <EVENT>) => ((activeClocks = {}) and ((activeEquations = {}) and ((time.i) = 0)))) and (((mode <> <EVENT>) => (activeEquations = {})) and (((mode <> <EVENT>) => ((time.i) = 0)) and (forall var in set vars & ((var.clocks) subset crefs)))))))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 267:9\<close>
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
		(True
		\<comment>\<open>Implicit union type parameters projection\<close>
		))"
 

\<comment>\<open>VDM source: eq_FMU: (FMU * FMU +> bool)
	eq_FMU(fmu1, fmu2) ==
((fmu1.id) = (fmu2.id))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 299:12\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 301:13\<close>
definition
	ord_FMU :: "FMU \<Rightarrow> FMU \<Rightarrow> bool"
where
	"ord_FMU fmu1   fmu2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_FMU` specification.\<close>
		(inv_FMU fmu1  \<and>  inv_FMU fmu2)  \<and> 
		\<comment>\<open>User defined body of ord_FMU.\<close>
		((id\<^sub>F\<^sub>M\<^sub>U fmu1) < (id\<^sub>F\<^sub>M\<^sub>U fmu2))"
 
lemmas inv_FMU_defs = inv_Causality_def inv_Clock_def inv_Contract_def inv_Environment_def inv_Equation_def inv_FMIValue_def inv_FMU_def inv_FMUMode_def inv_IOLeo_def inv_Interval_def inv_Lambda_def inv_Map_defs inv_Name_def inv_PortType_def inv_Real1_def inv_Ref_def inv_Time_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_ValueType_def inv_Variable_def inv_bool_def 


	
	
\<comment>\<open>VDM source: derefClock: (FMU * Ref -> Clock)
	derefClock(fmu, ref) ==
(iota c in set (fmu.clocks) & ((c.ref) = ref))
	pre (exists [c in set (fmu.clocks)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 308:5\<close>

\<comment>\<open>VDM source: pre_derefClock: (FMU * Ref +> bool)
	pre_derefClock(fmu, ref) ==
(exists [c in set (fmu.clocks)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 311:9\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 308:5\<close>
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
(iota c in set ((fmu.io).LFinput) & ((c.ref) = ref))
	pre (exists [c in set ((fmu.io).LFinput)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 316:5\<close>

\<comment>\<open>VDM source: pre_derefInput: (FMU * Ref +> bool)
	pre_derefInput(fmu, ref) ==
(exists [c in set ((fmu.io).LFinput)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 319:9\<close>
definition
	pre_derefInput :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_derefInput fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_derefInput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_derefInput.\<close>
		(\<exists> c \<in> (LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))  . ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e c) = ref))"


\<comment>\<open>VDM source: post_derefInput: (FMU * Ref * Variable +> bool)
	post_derefInput(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 316:5\<close>
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
	(THE c. (((c \<in>(LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e c) = ref)))"

	
	
\<comment>\<open>VDM source: derefOutput: (FMU * Ref -> Variable)
	derefOutput(fmu, ref) ==
(iota c in set ((fmu.io).LFoutput) & ((c.ref) = ref))
	pre (exists [c in set ((fmu.io).LFoutput)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 324:5\<close>

\<comment>\<open>VDM source: pre_derefOutput: (FMU * Ref +> bool)
	pre_derefOutput(fmu, ref) ==
(exists [c in set ((fmu.io).LFoutput)] & ((c.ref) = ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 327:9\<close>
definition
	pre_derefOutput :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_derefOutput fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_derefOutput` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_derefOutput.\<close>
		(\<exists> c \<in> (LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))  . ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e c) = ref))"


\<comment>\<open>VDM source: post_derefOutput: (FMU * Ref * Variable +> bool)
	post_derefOutput(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 324:5\<close>
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
	(THE c. (((c \<in>(LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu)))) \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e c) = ref)))"

	
	
\<comment>\<open>VDM source: Connections = compose Connections of dataConnections:map (FMURef) to (FMURef), clockConnections:map (FMURef) to (FMURef), timedClockConnections:map (Name) to (set1 of (FMURef)) end
	inv mk_Connections(connections, clockConnections, timedClockConnections) == ((((dom clockConnections) inter (dom connections)) = {}) and ((((rng clockConnections) inter (rng connections)) = {}) and ((forall connection in set (dom connections) & ((connection.name) <> (connections(connection).name))) and (forall connection in set (dom clockConnections) & ((connection.name) <> (clockConnections(connection).name))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 330:1\<close>
record Connections = 
	dataConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s :: "(FMURef \<rightharpoonup> FMURef)"
		 
		 clockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s :: "(FMURef \<rightharpoonup> FMURef)"
		 
		 timedClockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s :: "(Name \<rightharpoonup> FMURef VDMSet1)"
	

\<comment>\<open>VDM source: inv_Connections: (Connections +> bool)
	inv_Connections(mk_Connections(connections, clockConnections, timedClockConnections)) ==
((((dom clockConnections) inter (dom connections)) = {}) and ((((rng clockConnections) inter (rng connections)) = {}) and ((forall connection in set (dom connections) & ((connection.name) <> (connections(connection).name))) and (forall connection in set (dom clockConnections) & ((connection.name) <> (clockConnections(connection).name))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 334:9\<close>
definition
	inv_Connections :: "Connections \<Rightarrow> bool"
where
	"inv_Connections dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Connections` specification.\<close>
		( (((inv_Map inv_FMURef  inv_FMURef  (dataConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s dummy0))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMURef  (clockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s dummy0))) \<and> 
		 ((inv_Map (inv_Name) (inv_VDMSet1' inv_FMURef ) (timedClockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let connections = (dataConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s dummy0); clockConnections = (clockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s dummy0); timedClockConnections = (timedClockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s dummy0) in 
		\<comment>\<open>User defined body of inv_Connections.\<close>
		((((dom clockConnections) \<inter> (dom connections)) = {}) \<and> ((((rng clockConnections) \<inter> (rng connections)) = {}) \<and> ((\<forall> connection \<in> (dom connections)  . ((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f connection) \<noteq> (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (the((connections connection)))))) \<and> (\<forall> connection \<in> (dom clockConnections)  . ((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f connection) \<noteq> (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f (the((clockConnections connection))))))))))"

		
lemmas inv_Connections_defs = inv_Connections_def inv_FMURef_def inv_Map_def inv_Map_defs inv_Name_def inv_Ref_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet1'_def inv_VDMSet1'_defs 


	
	
\<comment>\<open>VDM source: Machine = compose Machine of fmus:map (Name) to (FMU), timeBasedClocks:set of (TimeBasedClock), connections:Connections end
	inv mk_Machine(fmus, timeBasedClocks, connections) == ((forall srcRef in set (dom (connections.dataConnections)) & (((srcRef.name) in set (dom fmus)) and let srcFMU:FMU = fmus((srcRef.name)), trgRef:FMURef = (connections.dataConnections)(srcRef) in ((exists [v in set ((srcFMU.io).LFoutput)] & ((srcRef.ref) = (v.ref))) and (((trgRef.name) in set (dom fmus)) and let trgFMU:FMU = fmus((trgRef.name)) in ((exists [v in set ((trgFMU.io).LFinput)] & ((trgRef.ref) = (v.ref))) and (pre_derefOutput(srcFMU, (srcRef.ref)) and (pre_derefInput(trgFMU, (trgRef.ref)) and let outputVar:Variable = derefOutput(srcFMU, (srcRef.ref)), inputVar:Variable = derefInput(trgFMU, (trgRef.ref)) in ((outputVar.type) = (inputVar.type))))))))) and ((forall fmuref in set (dom (connections.clockConnections)) & (((fmuref.name) in set (dom fmus)) and let fmu:FMU = fmus((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and (((v.type) = <output>) and ((v.interval) = <triggered>)))))) and ((forall fmuref in set (rng (connections.clockConnections)) & (((fmuref.name) in set (dom fmus)) and let fmu:FMU = fmus((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and (((v.type) = <input>) and ((v.interval) = <triggered>)))))) and (((dom (connections.timedClockConnections)) = {(c.name) | c in set timeBasedClocks}) and (forall t in set timeBasedClocks & (((t.master) in set (connections.timedClockConnections)((t.name))) and (forall c in set (dunion {c | c in set (rng (connections.timedClockConnections))}) & (pre_derefClock(fmus((c.name)), (c.ref)) and let clock:Clock = derefClock(fmus((c.name)), (c.ref)) in (((clock.interval) <> <triggered>) and ((clock.type) = <input>))))))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 346:5\<close>
record Machine = 
	fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "(Name \<rightharpoonup> FMU)"
		 
		 timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "TimeBasedClock VDMSet"
		 
		 connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e :: "Connections"
	

\<comment>\<open>VDM source: inv_Machine: (Machine +> bool)
	inv_Machine(mk_Machine(fmus, timeBasedClocks, connections)) ==
((forall srcRef in set (dom (connections.dataConnections)) & (((srcRef.name) in set (dom fmus)) and let srcFMU:FMU = fmus((srcRef.name)), trgRef:FMURef = (connections.dataConnections)(srcRef) in ((exists [v in set ((srcFMU.io).LFoutput)] & ((srcRef.ref) = (v.ref))) and (((trgRef.name) in set (dom fmus)) and let trgFMU:FMU = fmus((trgRef.name)) in ((exists [v in set ((trgFMU.io).LFinput)] & ((trgRef.ref) = (v.ref))) and (pre_derefOutput(srcFMU, (srcRef.ref)) and (pre_derefInput(trgFMU, (trgRef.ref)) and let outputVar:Variable = derefOutput(srcFMU, (srcRef.ref)), inputVar:Variable = derefInput(trgFMU, (trgRef.ref)) in ((outputVar.type) = (inputVar.type))))))))) and ((forall fmuref in set (dom (connections.clockConnections)) & (((fmuref.name) in set (dom fmus)) and let fmu:FMU = fmus((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and (((v.type) = <output>) and ((v.interval) = <triggered>)))))) and ((forall fmuref in set (rng (connections.clockConnections)) & (((fmuref.name) in set (dom fmus)) and let fmu:FMU = fmus((fmuref.name)) in (exists [v in set (fmu.clocks)] & (((fmuref.ref) = (v.ref)) and (((v.type) = <input>) and ((v.interval) = <triggered>)))))) and (((dom (connections.timedClockConnections)) = {(c.name) | c in set timeBasedClocks}) and (forall t in set timeBasedClocks & (((t.master) in set (connections.timedClockConnections)((t.name))) and (forall c in set (dunion {c | c in set (rng (connections.timedClockConnections))}) & (pre_derefClock(fmus((c.name)), (c.ref)) and let clock:Clock = derefClock(fmus((c.name)), (c.ref)) in (((clock.interval) <> <triggered>) and ((clock.type) = <input>))))))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 350:9\<close>
definition
	inv_Machine :: "Machine \<Rightarrow> bool"
where
	"inv_Machine dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Machine` specification.\<close>
		( (((inv_Map (inv_Name) inv_FMU  (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e dummy0))) \<and> 
		 ((inv_VDMSet' inv_TimeBasedClock  (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e dummy0))) \<and> 
		 (inv_Connections (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e dummy0)) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let fmus = (fmus\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e dummy0); timeBasedClocks = (timeBasedClocks\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e dummy0); connections = (connections\<^sub>M\<^sub>a\<^sub>c\<^sub>h\<^sub>i\<^sub>n\<^sub>e dummy0) in 
		\<comment>\<open>User defined body of inv_Machine.\<close>
		((\<forall> srcRef \<in> (dom (dataConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s connections))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef) \<in> (dom fmus)) \<and> (
		let 
(srcFMU::FMU) = (the((fmus (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef))))
		;
		
(trgRef::FMURef) = (the(((dataConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s connections) srcRef)))
		in
			(if (inv_FMU srcFMU)
	 \<and> 
	(inv_FMURef trgRef) then
			((\<exists> v \<in> (LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U srcFMU))  . ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef) = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v))) \<and> (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef) \<in> (dom fmus)) \<and> (
		let 
(trgFMU::FMU) = (the((fmus (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef))))
		in
			(if (inv_FMU trgFMU) then
			((\<exists> v \<in> (LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U trgFMU))  . ((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef) = (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v))) \<and> ((pre_derefOutput srcFMU   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef)) \<and> ((pre_derefInput trgFMU   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef)) \<and> (
		let 
(outputVar::Variable) = (derefOutput srcFMU   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f srcRef))
		;
		
(inputVar::Variable) = (derefInput trgFMU   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f trgRef))
		in
			(if (inv_Variable outputVar)
	 \<and> 
	(inv_Variable inputVar) then
			((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputVar) = (type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e inputVar))
		 else
			undefined
		)
		))))
		 else
			undefined
		)
		)))
		 else
			undefined
		)
		))) \<and> ((\<forall> fmuref \<in> (dom (clockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s connections))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref) \<in> (dom fmus)) \<and> (
		let 
(fmu::FMU) = (the((fmus (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref))))
		in
			(if (inv_FMU fmu) then
			(\<exists>
		v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)
		
		.
		(((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v)) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_output ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Interval.U_triggered ))))
		 else
			undefined
		)
		))) \<and> ((\<forall> fmuref \<in> (rng (clockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s connections))  . (((name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref) \<in> (dom fmus)) \<and> (
		let 
(fmu::FMU) = (the((fmus (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref))))
		in
			(if (inv_FMU fmu) then
			(\<exists>
		v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)
		
		.
		(((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f fmuref) = (ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v)) \<and> (((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_input ) \<and> ((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Interval.U_triggered ))))
		 else
			undefined
		)
		))) \<and> (((dom (timedClockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s connections)) = { (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k c) | c .  ((c \<in>timeBasedClocks))  }) \<and> (\<forall> t \<in> timeBasedClocks  . (((master\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k t) \<in> the((timedClockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s connections) (name\<^sub>T\<^sub>i\<^sub>m\<^sub>e\<^sub>B\<^sub>a\<^sub>s\<^sub>e\<^sub>d\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k t))) \<and> (\<forall> c \<in> (\<Union> { c .   ((c \<in>(rng (timedClockConnections\<^sub>C\<^sub>o\<^sub>n\<^sub>n\<^sub>e\<^sub>c\<^sub>t\<^sub>i\<^sub>o\<^sub>n\<^sub>s connections))))  })  . ((pre_derefClock (the(fmus (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f c)))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f c)) \<and> (
		let 
(clock::Clock) = (derefClock (fmus (name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f c))   (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f c))
		in
			(if (inv_Clock clock) then
			(((interval\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) \<noteq> Interval.U_triggered ) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k clock) = Causality.U_input ))
		 else
			undefined
		)
		))))))))))"

		
lemmas inv_Machine_defs = inv_Causality_def inv_Clock_def inv_Connections_def inv_Contract_def inv_Environment_def inv_Equation_def inv_FMIValue_def inv_FMU_def inv_FMUMode_def inv_FMURef_def inv_IOLeo_def inv_Interval_def inv_Lambda_def inv_Machine_def inv_Map_def inv_Map_defs inv_Name_def inv_PortType_def inv_Real1_def inv_Ref_def inv_Time_def inv_TimeBasedClock_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_VDMSet1'_def inv_VDMSet1'_defs inv_ValueType_def inv_Variable_def inv_bool_def 


	
	
\<comment>\<open>VDM source: preSet: (FMU * Ref -> bool)
	preSet(fmu, input) ==
(exists1 v in set ((fmu.io).LFinput) & (((v.ref) = input) and (((v.causality) = <input>) and (((fmu.mode) <> <DONE>) and ((((fmu.mode) = <STEP>) => ((v.type) = <continous>)) and (((fmu.mode) = <EVENT>) => ((v.type) = <discrete>)))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 404:5\<close>

\<comment>\<open>VDM source: pre_preSet: (FMU * Ref +> bool)
	pre_preSet(fmu, input) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 404:5\<close>
definition
	pre_preSet :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preSet fmu   input \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref input))"


\<comment>\<open>VDM source: post_preSet: (FMU * Ref * bool +> bool)
	post_preSet(fmu, input, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 404:5\<close>
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
	(\<exists>! v \<in> (LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = input) \<and> (((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = Causality.U_input ) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U fmu) \<noteq> FMUMode.U_DONE ) \<and> ((((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_STEP ) \<longrightarrow> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = PortType.U_continous )) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ) \<longrightarrow> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = PortType.U_discrete )))))))"

	
	
\<comment>\<open>VDM source: set_m: (FMU * Ref * FMIValue +> FMU)
	set_m(fmu, ref, val) ==
mu(fmu, env |-> ((fmu.env) ++ {ref |-> val}))
	pre preSet(fmu, ref)
	post (((RESULT.mode) = (fmu.mode)) and (((RESULT.time) = (fmu.time)) and (((RESULT.io).LFinput) = ((fmu.io).LFinput))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 412:5\<close>

\<comment>\<open>VDM source: pre_set_m: (FMU * Ref * FMIValue +> bool)
	pre_set_m(fmu, ref, val) ==
preSet(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 416:9\<close>
definition
	pre_set_m :: "FMU \<Rightarrow> Ref \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"pre_set_m fmu   ref   val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_set_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_FMIValue val)  \<and> 
		\<comment>\<open>User defined body of pre_set_m.\<close>
		(preSet fmu   ref)"


\<comment>\<open>VDM source: post_set_m: (FMU * Ref * FMIValue * FMU +> bool)
	post_set_m(fmu, ref, val, RESULT) ==
(((RESULT.mode) = (fmu.mode)) and (((RESULT.time) = (fmu.time)) and (((RESULT.io).LFinput) = ((fmu.io).LFinput))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 418:5\<close>
definition
	post_set_m :: "FMU \<Rightarrow> Ref \<Rightarrow> FMIValue \<Rightarrow> FMU \<Rightarrow> bool"
where
	"post_set_m fmu   ref   val   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_set_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  inv_FMIValue val  \<and>  inv_FMU RESULT)  \<and> 
		\<comment>\<open>User defined body of post_set_m.\<close>
		(((mode\<^sub>F\<^sub>M\<^sub>U RESULT) = (mode\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> (\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>F\<^sub>M\<^sub>U RESULT)   (time\<^sub>F\<^sub>M\<^sub>U fmu)) \<and> ((LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U RESULT)) = (LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu)))))"

definition
	set_m :: "FMU \<Rightarrow> Ref \<Rightarrow> FMIValue \<Rightarrow> FMU"
where
	"set_m fmu   ref   val \<equiv> 
	\<comment>\<open>User defined body of set_m.\<close>
	(fmu)\<lparr>env\<^sub>F\<^sub>M\<^sub>U := ((env\<^sub>F\<^sub>M\<^sub>U fmu) \<dagger> [ref\<mapsto>val])\<rparr>"

	
	
\<comment>\<open>VDM source: feedthroughSatisfied: (FMU * Variable -> bool)
	feedthroughSatisfied(fmu, outputVariable) ==
let inputs:set of (Variable) = {input | input in set ((fmu.io).LFinput) & ((input.ref) in set (outputVariable.dependsOn))} in (forall i in set inputs & (((i.ref) in set (dom (fmu.env))) and ((((i.contract) = <reactive>) => (((fmu.env)((i.ref)).time) >= (fmu.time))) and (((i.contract) = <delayed>) => (((fmu.env)((i.ref)).time) = (fmu.time))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 421:5\<close>

\<comment>\<open>VDM source: pre_feedthroughSatisfied: (FMU * Variable +> bool)
	pre_feedthroughSatisfied(fmu, outputVariable) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 421:5\<close>
definition
	pre_feedthroughSatisfied :: "FMU \<Rightarrow> Variable \<Rightarrow> bool"
where
	"pre_feedthroughSatisfied fmu   outputVariable \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_feedthroughSatisfied` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Variable outputVariable)"


\<comment>\<open>VDM source: post_feedthroughSatisfied: (FMU * Variable * bool +> bool)
	post_feedthroughSatisfied(fmu, outputVariable, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 421:5\<close>
definition
	post_feedthroughSatisfied :: "FMU \<Rightarrow> Variable \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_feedthroughSatisfied fmu   outputVariable   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_feedthroughSatisfied` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Variable outputVariable  \<and>  (inv_bool RESULT))"

definition
	feedthroughSatisfied :: "FMU \<Rightarrow> Variable \<Rightarrow> bool"
where
	"feedthroughSatisfied fmu   outputVariable \<equiv> 
	\<comment>\<open>User defined body of feedthroughSatisfied.\<close>
	(
		let 
(inputs::Variable VDMSet) = { input .   ((input \<in>(LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))))  \<and> ((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e input) \<in> (dependsOn\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputVariable)) }
		in
			(if ((inv_VDMSet' inv_Variable  inputs)) then
			(\<forall>
		i \<in> inputs
		
		.
		(((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) \<in> (dom (env\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = Contract.U_reactive ) \<longrightarrow> \<comment>\<open>Transform a VDM `>` expression into a reversed `ord_Time` call\<close>
	(ord_Time (time\<^sub>F\<^sub>M\<^sub>U fmu)   (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))) \<or> 
	\<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))   (time\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> (((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = Contract.U_delayed ) \<longrightarrow> \<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))   (time\<^sub>F\<^sub>M\<^sub>U fmu))))))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: preGet: (FMU * Ref -> bool)
	preGet(fmu, ref) ==
let outputVariable:Variable = derefOutput(fmu, ref) in ((exists1 v in set ((fmu.io).LFoutput) & (((v.ref) = ref) and ((v.causality) = <output>))) and (((fmu.mode) <> <DONE>) and feedthroughSatisfied(fmu, outputVariable)))
	pre pre_derefOutput(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 429:5\<close>

\<comment>\<open>VDM source: pre_preGet: (FMU * Ref +> bool)
	pre_preGet(fmu, ref) ==
pre_derefOutput(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 435:9\<close>
definition
	pre_preGet :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGet fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_preGet` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_preGet.\<close>
		(pre_derefOutput fmu   ref)"


\<comment>\<open>VDM source: post_preGet: (FMU * Ref * bool +> bool)
	post_preGet(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 429:5\<close>
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
(outputVariable::Variable) = (derefOutput fmu   ref)
		in
			(if (inv_Variable outputVariable) then
			((\<exists>! v \<in> (LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))  . (((ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = ref) \<and> ((causality\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e v) = Causality.U_output ))) \<and> (((mode\<^sub>F\<^sub>M\<^sub>U fmu) \<noteq> FMUMode.U_DONE ) \<and> (feedthroughSatisfied fmu   outputVariable)))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: get_m: (FMU * Ref +> (FMU * FMIValue))
	get_m(fmu, ref) ==
mk_(fmu, (fmu.env)(ref))
	pre (preGet(fmu, ref) and pre_preGet(fmu, ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 438:5\<close>

\<comment>\<open>VDM source: pre_get_m: (FMU * Ref +> bool)
	pre_get_m(fmu, ref) ==
(preGet(fmu, ref) and pre_preGet(fmu, ref))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 442:26\<close>
definition
	pre_get_m :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_get_m fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_get_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_get_m.\<close>
		((preGet fmu   ref) \<and> (pre_preGet fmu   ref))"


\<comment>\<open>VDM source: post_get_m: (FMU * Ref * (FMU * FMIValue) +> bool)
	post_get_m(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 438:5\<close>
definition
	post_get_m :: "FMU \<Rightarrow> Ref \<Rightarrow> (FMU \<times> FMIValue) \<Rightarrow> bool"
where
	"post_get_m fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_get_m` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 inv_FMIValue (snd RESULT)
		))"

definition
	get_m :: "FMU \<Rightarrow> Ref \<Rightarrow> (FMU \<times> FMIValue)"
where
	"get_m fmu   ref \<equiv> 
	\<comment>\<open>User defined body of get_m.\<close>
	(fmu , ((env\<^sub>F\<^sub>M\<^sub>U fmu) ref))"

	
	
\<comment>\<open>VDM source: preSetC: (FMU * Ref * bool -> bool)
	preSetC(fmu, clock, val) ==
(((exists1 v in set (fmu.clocks) & (((v.ref) = clock) and ((v.type) = <input>))) and val) <=> ((not (clock in set (fmu.activeClocks))) and ((fmu.mode) = <EVENT>)))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 445:5\<close>

\<comment>\<open>VDM source: pre_preSetC: (FMU * Ref * bool +> bool)
	pre_preSetC(fmu, clock, val) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 445:5\<close>
definition
	pre_preSetC :: "FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_preSetC fmu   clock   val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preSetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val))"


\<comment>\<open>VDM source: post_preSetC: (FMU * Ref * bool * bool +> bool)
	post_preSetC(fmu, clock, val, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 445:5\<close>
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
	(((\<exists>! v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = clock) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_input ))) \<and> val) \<longleftrightarrow> ((\<not> (clock \<in> (activeClocks\<^sub>F\<^sub>M\<^sub>U fmu))) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT )))"

	
	
\<comment>\<open>VDM source: set_cm: (FMU * Ref * bool +> FMU)
	set_cm(fmu, ref, val) ==
mu(fmu, env |-> ((fmu.env) ++ {ref |-> mk_FMIValue(val, (fmu.time))}), activeClocks |-> (if val
then ((fmu.activeClocks) union {ref})
else ((fmu.activeClocks) \ {ref})))
	pre preSetC(fmu, ref, val)
	post (val <=> (ref in set (RESULT.activeClocks)))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 451:5\<close>

\<comment>\<open>VDM source: pre_set_cm: (FMU * Ref * bool +> bool)
	pre_set_cm(fmu, ref, val) ==
preSetC(fmu, ref, val)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 456:9\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 457:14\<close>
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
	(fmu)\<lparr>env\<^sub>F\<^sub>M\<^sub>U := ((env\<^sub>F\<^sub>M\<^sub>U fmu) \<dagger> [ref\<mapsto>\<lparr>fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = ValueType.U_bool val, time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = (time\<^sub>F\<^sub>M\<^sub>U fmu)\<rparr>]), activeClocks\<^sub>F\<^sub>M\<^sub>U := (
		if (val) then
		(((activeClocks\<^sub>F\<^sub>M\<^sub>U fmu) \<union> {ref}))
		else
		(((activeClocks\<^sub>F\<^sub>M\<^sub>U fmu) - {ref})))\<rparr>"

	
	
\<comment>\<open>VDM source: preGetC: (FMU * Ref -> bool)
	preGetC(fmu, clock) ==
((exists1 v in set (fmu.clocks) & (((v.ref) = clock) and ((v.type) = <output>))) and ((fmu.mode) = <EVENT>))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 459:5\<close>

\<comment>\<open>VDM source: pre_preGetC: (FMU * Ref +> bool)
	pre_preGetC(fmu, clock) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 459:5\<close>
definition
	pre_preGetC :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_preGetC fmu   clock \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preGetC` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref clock))"


\<comment>\<open>VDM source: post_preGetC: (FMU * Ref * bool +> bool)
	post_preGetC(fmu, clock, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 459:5\<close>
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
	((\<exists>! v \<in> (clocks\<^sub>F\<^sub>M\<^sub>U fmu)  . (((ref\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = clock) \<and> ((type\<^sub>C\<^sub>l\<^sub>o\<^sub>c\<^sub>k v) = Causality.U_output ))) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_EVENT ))"

	
	
\<comment>\<open>VDM source: get_cm: (FMU * Ref +> (FMU * FMIValue))
	get_cm(fmu, ref) ==
mk_(fmu, (fmu.env)(ref))
	pre preGetC(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 464:5\<close>

\<comment>\<open>VDM source: pre_get_cm: (FMU * Ref +> bool)
	pre_get_cm(fmu, ref) ==
preGetC(fmu, ref)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 467:9\<close>
definition
	pre_get_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> bool"
where
	"pre_get_cm fmu   ref \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_get_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref))  \<and> 
		\<comment>\<open>User defined body of pre_get_cm.\<close>
		(preGetC fmu   ref)"


\<comment>\<open>VDM source: post_get_cm: (FMU * Ref * (FMU * FMIValue) +> bool)
	post_get_cm(fmu, ref, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 464:5\<close>
definition
	post_get_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> (FMU \<times> FMIValue) \<Rightarrow> bool"
where
	"post_get_cm fmu   ref   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_get_cm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Ref ref)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 inv_FMIValue (snd RESULT)
		))"

definition
	get_cm :: "FMU \<Rightarrow> Ref \<Rightarrow> (FMU \<times> FMIValue)"
where
	"get_cm fmu   ref \<equiv> 
	\<comment>\<open>User defined body of get_cm.\<close>
	(fmu , ((env\<^sub>F\<^sub>M\<^sub>U fmu) ref))"

	
	
\<comment>\<open>VDM source: preStepT: (FMU * Real1 -> bool)
	preStepT(fmu, stepSize) ==
let continousInputs:set of (Variable) = {i | i in set ((fmu.io).LFinput) & ((i.type) = <continous>)} in ((forall i in set continousInputs & ((((i.contract) = <reactive>) => ((((fmu.env)((i.ref)).time).r) = (((fmu.time).r) + stepSize))) and (((i.contract) = <delayed>) => (((fmu.env)((i.ref)).time) = (fmu.time))))) and ((fmu.mode) = <STEP>))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 470:5\<close>

\<comment>\<open>VDM source: pre_preStepT: (FMU * Real1 +> bool)
	pre_preStepT(fmu, stepSize) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 470:5\<close>
definition
	pre_preStepT :: "FMU \<Rightarrow> Real1 \<Rightarrow> bool"
where
	"pre_preStepT fmu   stepSize \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Real1 stepSize))"


\<comment>\<open>VDM source: post_preStepT: (FMU * Real1 * bool +> bool)
	post_preStepT(fmu, stepSize, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 470:5\<close>
definition
	post_preStepT :: "FMU \<Rightarrow> Real1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_preStepT fmu   stepSize   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_preStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Real1 stepSize)  \<and>  (inv_bool RESULT))"

definition
	preStepT :: "FMU \<Rightarrow> Real1 \<Rightarrow> bool"
where
	"preStepT fmu   stepSize \<equiv> 
	\<comment>\<open>User defined body of preStepT.\<close>
	(
		let 
(continousInputs::Variable VDMSet) = { i .   ((i \<in>(LFinput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))))  \<and> ((type\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = PortType.U_continous ) }
		in
			(if ((inv_VDMSet' inv_Variable  continousInputs)) then
			((\<forall> i \<in> continousInputs  . ((((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = Contract.U_reactive ) \<longrightarrow> ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))) = ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) + stepSize))) \<and> (((contract\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i) = Contract.U_delayed ) \<longrightarrow> \<comment>\<open>Transform a VDM `=` expression into an `eq_Time` call\<close>
	(eq_Time (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the(((env\<^sub>F\<^sub>M\<^sub>U fmu) (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e i)))))   (time\<^sub>F\<^sub>M\<^sub>U fmu))))) \<and> ((mode\<^sub>F\<^sub>M\<^sub>U fmu) = FMUMode.U_STEP ))
		 else
			undefined
		)
		)"

	
	
\<comment>\<open>VDM source: postStepT: (FMU * Real1 * bool * FMU * Real1 -> bool)
	postStepT(fmu, stepTaken, eventTriggered, oldFMU, stepAsked) ==
(((stepTaken <= stepAsked) and ((stepTaken <= (oldFMU.maxStep)) and eventTriggered)) <=> (((oldFMU.maxStep) <= stepTaken) and ((((fmu.time).r) = (((oldFMU.time).r) + stepTaken)) and (((fmu.time).i) = ((oldFMU.time).i)))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 479:5\<close>

\<comment>\<open>VDM source: pre_postStepT: (FMU * Real1 * bool * FMU * Real1 +> bool)
	pre_postStepT(fmu, stepTaken, eventTriggered, oldFMU, stepAsked) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 479:5\<close>
definition
	pre_postStepT :: "FMU \<Rightarrow> Real1 \<Rightarrow> bool \<Rightarrow> FMU \<Rightarrow> Real1 \<Rightarrow> bool"
where
	"pre_postStepT fmu   stepTaken   eventTriggered   oldFMU   stepAsked \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Real1 stepTaken)  \<and>  (inv_bool eventTriggered)  \<and>  inv_FMU oldFMU  \<and>  (inv_Real1 stepAsked))"


\<comment>\<open>VDM source: post_postStepT: (FMU * Real1 * bool * FMU * Real1 * bool +> bool)
	post_postStepT(fmu, stepTaken, eventTriggered, oldFMU, stepAsked, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 479:5\<close>
definition
	post_postStepT :: "FMU \<Rightarrow> Real1 \<Rightarrow> bool \<Rightarrow> FMU \<Rightarrow> Real1 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_postStepT fmu   stepTaken   eventTriggered   oldFMU   stepAsked   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_postStepT` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Real1 stepTaken)  \<and>  (inv_bool eventTriggered)  \<and>  inv_FMU oldFMU  \<and>  (inv_Real1 stepAsked)  \<and>  (inv_bool RESULT))"

definition
	postStepT :: "FMU \<Rightarrow> Real1 \<Rightarrow> bool \<Rightarrow> FMU \<Rightarrow> Real1 \<Rightarrow> bool"
where
	"postStepT fmu   stepTaken   eventTriggered   oldFMU   stepAsked \<equiv> 
	\<comment>\<open>User defined body of postStepT.\<close>
	(((stepTaken \<le> stepAsked) \<and> ((stepTaken \<le> (maxStep\<^sub>F\<^sub>M\<^sub>U oldFMU)) \<and> eventTriggered)) \<longleftrightarrow> (((maxStep\<^sub>F\<^sub>M\<^sub>U oldFMU) \<le> stepTaken) \<and> (((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) = ((r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U oldFMU)) + stepTaken)) \<and> ((i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U fmu)) = (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>U oldFMU))))))"

	
	
\<comment>\<open>VDM source: updateOutputs: (FMU * Time -> Environment)
	updateOutputs(fmu, time) ==
let outputRef:set of (Ref) = {(outputVar.ref) | outputVar in set ((fmu.io).LFoutput)} in {oValue |-> calculate(oValue, (fmu.env), time) | oValue in set (dom (fmu.env)) & (oValue in set outputRef)}\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 490:5\<close>

\<comment>\<open>VDM source: pre_updateOutputs: (FMU * Time +> bool)
	pre_updateOutputs(fmu, time) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 490:5\<close>
definition
	pre_updateOutputs :: "FMU \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_updateOutputs fmu   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_updateOutputs` specification.\<close>
		(inv_FMU fmu  \<and>  inv_Time time)"


\<comment>\<open>VDM source: post_updateOutputs: (FMU * Time * Environment +> bool)
	post_updateOutputs(fmu, time, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 490:5\<close>
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
(outputRef::Ref VDMSet) = { (ref\<^sub>V\<^sub>a\<^sub>r\<^sub>i\<^sub>a\<^sub>b\<^sub>l\<^sub>e outputVar) | outputVar .  ((outputVar \<in>(LFoutput\<^sub>I\<^sub>O\<^sub>L\<^sub>e\<^sub>o (io\<^sub>F\<^sub>M\<^sub>U fmu))))  }
		in
			(if ((inv_VDMSet' ((inv_VDMNat)) outputRef)) then
			(\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{ oValue .   (oValue \<in>(dom (env\<^sub>F\<^sub>M\<^sub>U fmu)))  \<and> (oValue \<in> outputRef) } 
		{ (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time) | (dummy0RANGE :: FMIValue) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) )))  \<and> (oValue \<in> outputRef) } 
		((inv_VDMNat)) 
		 ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e FMIValue)))) )) ) 
		(domid ) 
		(
	\<lambda> (dummy0DOMAIN :: Ref)   (dummy0RANGE :: FMIValue) .
		(if ((((inv_VDMNat dummy0DOMAIN))))  \<and>  (( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<and>  ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined)))))) )) ) then
			(
		if ((\<exists> (dummy0RANGE :: FMIValue)  . ((( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<longrightarrow> (\<comment>\<open>Transform a VDM `=` expression into an `eq_FMIValue` call\<close>
	(eq_FMIValue dummy0RANGE   (calculate oValue   (env\<^sub>F\<^sub>M\<^sub>U fmu)   time)) \<and> (oValue \<in> outputRef))))) then
		(dummy0RANGE)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(
	\<lambda> (dummy0DOMAIN :: Ref)   (dummy0RANGE :: FMIValue) .
		(if ((((inv_VDMNat dummy0DOMAIN))))  \<and>  (( ((((case (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) of
		 ValueType.U_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_bool (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		  | ValueType.U_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE) \<Rightarrow> (inv_VDMReal (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))
		 ))) \<and> 
		 ( ((((inv_VDMReal (r\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE))))) \<and> 
		 ((inv_VDMNat (i\<^sub>T\<^sub>i\<^sub>m\<^sub>e (time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e dummy0RANGE)))) )) ))) \<and> (inv_bool (
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

	
	
\<comment>\<open>VDM source: calculate: (Ref * Environment * Time -> FMIValue)
	calculate(ref, env, time) ==
mk_FMIValue((env(ref).fmiValue), time)
	pre (ref in set (dom env))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 495:5\<close>

\<comment>\<open>VDM source: pre_calculate: (Ref * Environment * Time +> bool)
	pre_calculate(ref, env, time) ==
(ref in set (dom env))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 501:13\<close>
definition
	pre_calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> bool"
where
	"pre_calculate ref   env   time \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_calculate` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time)  \<and> 
		\<comment>\<open>User defined body of pre_calculate.\<close>
		(ref \<in> (dom env))"


\<comment>\<open>VDM source: post_calculate: (Ref * Environment * Time * FMIValue +> bool)
	post_calculate(ref, env, time, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 495:5\<close>
definition
	post_calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> FMIValue \<Rightarrow> bool"
where
	"post_calculate ref   env   time   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_calculate` specification.\<close>
		((inv_Ref ref)  \<and>  (inv_Environment env)  \<and>  inv_Time time  \<and>  inv_FMIValue RESULT)"

definition
	calculate :: "Ref \<Rightarrow> Environment \<Rightarrow> Time \<Rightarrow> FMIValue"
where
	"calculate ref   env   time \<equiv> 
	\<comment>\<open>User defined body of calculate.\<close>
	\<lparr>fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = (fmiValue\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e (the((env ref)))), time\<^sub>F\<^sub>M\<^sub>I\<^sub>V\<^sub>a\<^sub>l\<^sub>u\<^sub>e = time\<rparr>"

	
	
\<comment>\<open>VDM source: step_tm: (FMU * Real1 +> (FMU * Real1 * bool))
	step_tm(fmu, step) ==
let mk_(stepTaken, eventTriggered):(Real1 * bool) = (if (step >= (fmu.maxStep))
then mk_((fmu.maxStep), true)
else mk_(step, false)) in let newTime:Time = mk_Time((((fmu.time).r) + stepTaken), ((fmu.time).i)) in let updatedFMU:FMU = mu(fmu, time |-> newTime, env |-> updateOutputs(fmu, newTime), stepped |-> true) in mk_(updatedFMU, stepTaken, eventTriggered)
	pre preStepT(fmu, step)
	post postStepT((RESULT.#1), (RESULT.#2), (RESULT.#3), fmu, step)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 503:5\<close>

\<comment>\<open>VDM source: pre_step_tm: (FMU * Real1 +> bool)
	pre_step_tm(fmu, step) ==
preStepT(fmu, step)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 516:9\<close>
definition
	pre_step_tm :: "FMU \<Rightarrow> Real1 \<Rightarrow> bool"
where
	"pre_step_tm fmu   step \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_step_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Real1 step))  \<and> 
		\<comment>\<open>User defined body of pre_step_tm.\<close>
		(preStepT fmu   step)"


\<comment>\<open>VDM source: post_step_tm: (FMU * Real1 * (FMU * Real1 * bool) +> bool)
	post_step_tm(fmu, step, RESULT) ==
postStepT((RESULT.#1), (RESULT.#2), (RESULT.#3), fmu, step)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 517:10\<close>
definition
	post_step_tm :: "FMU \<Rightarrow> Real1 \<Rightarrow> (FMU \<times> Real1 \<times> bool) \<Rightarrow> bool"
where
	"post_step_tm fmu   step   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_step_tm` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_Real1 step)  \<and>  
		(inv_FMU (fst RESULT)\<and>
		 (inv_Real1 (fst (snd RESULT)))\<and>
		 (inv_bool (snd (snd RESULT)))
		))  \<and> 
		\<comment>\<open>User defined body of post_step_tm.\<close>
		(postStepT (fst (RESULT))   (fst (snd (RESULT)))   (snd (snd (RESULT)))   fmu   step)"

definition
	step_tm :: "FMU \<Rightarrow> Real1 \<Rightarrow> (FMU \<times> Real1 \<times> bool)"
where
	"step_tm fmu   step \<equiv> 
	\<comment>\<open>User defined body of step_tm.\<close>
	(
		let 
(stepTaken::Real1) = (
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
		(((inv_VDMReal (fst dummy0)))\<and>
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

	
	
\<comment>\<open>VDM source: preStepE: (FMU -> bool)
	preStepE(fmu) ==
((fmu.mode) = <EVENT>)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 520:5\<close>

\<comment>\<open>VDM source: pre_preStepE: (FMU +> bool)
	pre_preStepE(fmu) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 520:5\<close>
definition
	pre_preStepE :: "FMU \<Rightarrow> bool"
where
	"pre_preStepE fmu \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_preStepE` specification.\<close>
		(inv_FMU fmu)"


\<comment>\<open>VDM source: post_preStepE: (FMU * bool +> bool)
	post_preStepE(fmu, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 520:5\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 524:5\<close>

\<comment>\<open>VDM source: pre_postStepE: (FMU * FMU * bool +> bool)
	pre_postStepE(fmu, oldFMU, -) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 524:5\<close>
definition
	pre_postStepE :: "FMU \<Rightarrow> FMU \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_postStepE fmu   oldFMU   dummy0_ignore \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_postStepE` specification.\<close>
		(inv_FMU fmu  \<and>  inv_FMU oldFMU  \<and>  (inv_bool dummy0_ignore))"


\<comment>\<open>VDM source: post_postStepE: (FMU * FMU * bool * bool +> bool)
	post_postStepE(fmu, oldFMU, -, RESULT) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 524:5\<close>
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

	
	
\<comment>\<open>VDM source: step_e: (FMU +> (FMU * bool))
	step_e(fmu) ==
let updatedFMU:FMU = mu(fmu, time |-> mk_Time(((fmu.time).r), (((fmu.time).i) + 1)), activeClocks |-> {}) in mk_(updatedFMU, false)
	pre preStepE(fmu)
	post postStepE((RESULT.#1), fmu, (RESULT.#2))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 531:5\<close>

\<comment>\<open>VDM source: pre_step_e: (FMU +> bool)
	pre_step_e(fmu) ==
preStepE(fmu)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 538:9\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 539:10\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 545:5\<close>

\<comment>\<open>VDM source: pre_next_tm: (FMU * Ref +> bool)
	pre_next_tm(fmu, ref) ==
(exists [v in set (fmu.clocks)] & (((v.ref) = ref) and (((v.type) = <input>) and ((v.interval) in set {<tunable>, <changing>, <countdown>}))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 548:9\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 545:5\<close>
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

	
	
\<comment>\<open>VDM source: Importer = compose Importer of scenario:Machine, schedule:map (Name) to (Real1), activeClocks:set of (FMURef), readyClocks:set of (FMURef), inactiveClocks:set of (FMURef), fmusWithEvent:set of (Name), relevantOutputClocks:set of (FMURef), relevantInputClocks:set of (FMURef), activeEquations:set of (FMURef), calculatedEquations:set of (FMURef), readyEquations:set of (FMURef), time:Time, endtime:Time, stepSize:Real1, valueMap:map (FMURef) to (FMIValue) end
	inv imp == let fmus:map (Name) to (FMU) = ((imp.scenario).fmus) in let inputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <input>)}) | fmu in set (rng fmus)}) in let outputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <output>)}) | fmu in set (rng fmus)}) in let clocks:set of (FMURef) = (inputclocks union outputclocks) in (((card ((imp.activeClocks) union (imp.inactiveClocks))) = (card clocks)) and ((((imp.activeClocks) inter (imp.inactiveClocks)) = {}) and ((((imp.activeClocks) inter (imp.readyClocks)) = {}) and (((imp.activeClocks) = (dunion {createFMURefs(fmu, (fmu.activeClocks)) | fmu in set (rng fmus)})) and (((imp.fmusWithEvent) subset (dom fmus)) and (((imp.relevantInputClocks) subset inputclocks) and (((imp.relevantOutputClocks) subset outputclocks) and ((((imp.relevantInputClocks) inter (imp.relevantOutputClocks)) = {}) and (((imp.endtime) >= (imp.time)) and ((((imp.activeEquations) inter (imp.readyEquations)) = {}) and (((imp.readyEquations) inter (imp.calculatedEquations)) = {})))))))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 563:5\<close>
record Importer = 
	scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "Machine"
		 
		 schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "(Name \<rightharpoonup> Real1)"
		 
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
		 
		 stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "Real1"
		 
		 valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r :: "(FMURef \<rightharpoonup> FMIValue)"
	

\<comment>\<open>VDM source: inv_Importer: (Importer +> bool)
	inv_Importer(imp) ==
let fmus:map (Name) to (FMU) = ((imp.scenario).fmus) in let inputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <input>)}) | fmu in set (rng fmus)}) in let outputclocks:set of (FMURef) = (dunion {createFMURefs(fmu, {(clock.ref) | clock in set (fmu.clocks) & ((clock.type) = <output>)}) | fmu in set (rng fmus)}) in let clocks:set of (FMURef) = (inputclocks union outputclocks) in (((card ((imp.activeClocks) union (imp.inactiveClocks))) = (card clocks)) and ((((imp.activeClocks) inter (imp.inactiveClocks)) = {}) and ((((imp.activeClocks) inter (imp.readyClocks)) = {}) and (((imp.activeClocks) = (dunion {createFMURefs(fmu, (fmu.activeClocks)) | fmu in set (rng fmus)})) and (((imp.fmusWithEvent) subset (dom fmus)) and (((imp.relevantInputClocks) subset inputclocks) and (((imp.relevantOutputClocks) subset outputclocks) and ((((imp.relevantInputClocks) inter (imp.relevantOutputClocks)) = {}) and (((imp.endtime) >= (imp.time)) and ((((imp.activeEquations) inter (imp.readyEquations)) = {}) and (((imp.readyEquations) inter (imp.calculatedEquations)) = {})))))))))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 579:9\<close>
definition
	inv_Importer :: "Importer \<Rightarrow> bool"
where
	"inv_Importer imp \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_Importer` specification.\<close>
		( ((inv_Machine (scenario\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp)) \<and> 
		 ((inv_Map (inv_Name) (inv_Real1) (schedule\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
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
		 ((inv_Real1 (stepSize\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) \<and> 
		 ((inv_Map inv_FMURef  inv_FMIValue  (valueMap\<^sub>I\<^sub>m\<^sub>p\<^sub>o\<^sub>r\<^sub>t\<^sub>e\<^sub>r imp))) ))  \<and> 
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
 
lemmas inv_Importer_defs = inv_Causality_def inv_Clock_def inv_Connections_def inv_Contract_def inv_Environment_def inv_Equation_def inv_FMIValue_def inv_FMU_def inv_FMUMode_def inv_FMURef_def inv_IOLeo_def inv_Importer_def inv_Interval_def inv_Lambda_def inv_Machine_def inv_Map_def inv_Map_defs inv_Name_def inv_PortType_def inv_Real1_def inv_Ref_def inv_Time_def inv_TimeBasedClock_def inv_True_def inv_VDMChar_def inv_VDMNat_def inv_VDMReal_def inv_VDMSeq1'_def inv_VDMSeq1'_defs inv_VDMSet'_def inv_VDMSet'_defs inv_VDMSet1'_def inv_VDMSet1'_defs inv_ValueType_def inv_Variable_def inv_bool_def 


	
	
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 608:5\<close>

\<comment>\<open>VDM source: pre_updateEnvironmentClock: (Importer * FMU * Ref * bool +> bool)
	pre_updateEnvironmentClock(I, fmu, clock, val) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 608:5\<close>
definition
	pre_updateEnvironmentClock :: "Importer \<Rightarrow> FMU \<Rightarrow> Ref \<Rightarrow> bool \<Rightarrow> bool"
where
	"pre_updateEnvironmentClock I   fmu   clock   val \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_updateEnvironmentClock` specification.\<close>
		(inv_Importer I  \<and>  inv_FMU fmu  \<and>  (inv_Ref clock)  \<and>  (inv_bool val))"


\<comment>\<open>VDM source: post_updateEnvironmentClock: (Importer * FMU * Ref * bool * Importer +> bool)
	post_updateEnvironmentClock(I, fmu, clock, val, RESULT) ==
let fmuRef:FMURef = mk_FMURef((fmu.name), clock) in ((val => (((I.activeClocks) subset (RESULT.activeClocks)) and (((RESULT.readyClocks) psubset (I.readyClocks)) and (((RESULT.inactiveClocks) psubset (I.inactiveClocks)) and (fmuRef in set (RESULT.activeClocks)))))) and ((not val) => (fmuRef in set (RESULT.inactiveClocks))))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 620:10\<close>
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

	
	
\<comment>\<open>VDM source: createFMURefs: (FMU * set of (Ref) -> set of (FMURef))
	createFMURefs(fmu, clocks) ==
{mk_FMURef((fmu.name), clock) | clock in set clocks}
	post ((card RESULT) = (card clocks))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 914:5\<close>

\<comment>\<open>VDM source: pre_createFMURefs: (FMU * set of (Ref) +> bool)
	pre_createFMURefs(fmu, clocks) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 914:5\<close>
definition
	pre_createFMURefs :: "FMU \<Rightarrow> Ref VDMSet \<Rightarrow> bool"
where
	"pre_createFMURefs fmu   clocks \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_createFMURefs` specification.\<close>
		(inv_FMU fmu  \<and>  (inv_VDMSet' (inv_Ref) clocks))"


\<comment>\<open>VDM source: post_createFMURefs: (FMU * set of (Ref) * set of (FMURef) +> bool)
	post_createFMURefs(fmu, clocks, RESULT) ==
((card RESULT) = (card clocks))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 917:22\<close>
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

	
	
\<comment>\<open>VDM source: minset: (set of (Real1) * Real1 -> Real1)
	minset(s, leomin) ==
(if (s = {})
then leomin
else let e in set s in let new_set:set of (Real1) = (s \ {e}) in (if (e < leomin)
then minset(new_set, e)
else minset(new_set, leomin)))
	pre true
	post (forall elem in set s & (elem >= RESULT))
	measure (card s)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 919:5\<close>

\<comment>\<open>VDM source: pre_minset: (set of (Real1) * Real1 +> bool)
	pre_minset(s, leomin) ==
true\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 928:9\<close>
definition
	pre_minset :: "Real1 VDMSet \<Rightarrow> Real1 \<Rightarrow> bool"
where
	"pre_minset s   leomin \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_minset` specification.\<close>
		((inv_VDMSet' (inv_Real1) s)  \<and>  (inv_Real1 leomin))  \<and> 
		\<comment>\<open>User defined body of pre_minset.\<close>
		(True::\<bool>)"


\<comment>\<open>VDM source: post_minset: (set of (Real1) * Real1 * Real1 +> bool)
	post_minset(s, leomin, RESULT) ==
(forall elem in set s & (elem >= RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 929:10\<close>
definition
	post_minset :: "Real1 VDMSet \<Rightarrow> Real1 \<Rightarrow> Real1 \<Rightarrow> bool"
where
	"post_minset s   leomin   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_minset` specification.\<close>
		((inv_VDMSet' (inv_Real1) s)  \<and>  (inv_Real1 leomin)  \<and>  (inv_Real1 RESULT))  \<and> 
		\<comment>\<open>User defined body of post_minset.\<close>
		(\<forall> elem \<in> s  . (elem \<ge> RESULT))"

fun
	minset :: "Real1 VDMSet \<Rightarrow> Real1 \<Rightarrow> Real1"
where
	"minset s   leomin = 
	\<comment>\<open>User defined body of minset.\<close>
	(
		if ((s = {})) then
		(leomin)
		else
		((
		SOME (dummy0::Real1) .(dummy0 \<in> { (
		let 
(new_set::Real1 VDMSet) = (s - {e})
		in
			(if ((inv_VDMSet' ((inv_VDMReal)) new_set)) then
			(
		if ((e < leomin)) then
		((minset new_set   e))
		else
		((minset new_set   leomin)))
		 else
			undefined
		)
		) | e .  ((e \<in>s))  }))))"

	
	
\<comment>\<open>VDM source: selectMinStep: (set1 of (Real1) -> Real1)
	selectMinStep(steps) ==
minset(steps, 10000)
	pre pre_minset(steps, 10000)
	post (forall elem in set steps & (elem >= RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 932:5\<close>

\<comment>\<open>VDM source: pre_selectMinStep: (set1 of (Real1) +> bool)
	pre_selectMinStep(steps) ==
pre_minset(steps, 10000)\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 934:9\<close>
definition
	pre_selectMinStep :: "Real1 VDMSet1 \<Rightarrow> bool"
where
	"pre_selectMinStep steps \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_selectMinStep` specification.\<close>
		((inv_VDMSet1' (inv_Real1) steps))  \<and> 
		\<comment>\<open>User defined body of pre_selectMinStep.\<close>
		(pre_minset steps   (10000::VDMNat1))"


\<comment>\<open>VDM source: post_selectMinStep: (set1 of (Real1) * Real1 +> bool)
	post_selectMinStep(steps, RESULT) ==
(forall elem in set steps & (elem >= RESULT))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 935:10\<close>
definition
	post_selectMinStep :: "Real1 VDMSet1 \<Rightarrow> Real1 \<Rightarrow> bool"
where
	"post_selectMinStep steps   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_selectMinStep` specification.\<close>
		((inv_VDMSet1' (inv_Real1) steps)  \<and>  (inv_Real1 RESULT))  \<and> 
		\<comment>\<open>User defined body of post_selectMinStep.\<close>
		(\<forall> elem \<in> steps  . (elem \<ge> RESULT))"

definition
	selectMinStep :: "Real1 VDMSet1 \<Rightarrow> Real1"
where
	"selectMinStep steps \<equiv> 
	\<comment>\<open>User defined body of selectMinStep.\<close>
	(minset steps   (10000::VDMNat1))"

end