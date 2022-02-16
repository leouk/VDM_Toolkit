(* VDM to Isabelle Translation @2022-02-16T13:57:53.828715Z
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

		

\<comment>\<open>VDM source: ord_Action: (Action * Action +> bool)
	ord_Action(a, b) ==
((a.port) < (b.port))\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 90:9\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 97:5\<close>
record FMURef = 
	name\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Name"
		 
		 ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f :: "Ref"
	

\<comment>\<open>VDM source: inv_FMURef: (FMURef +> bool)
	inv_FMURef(dummy0) ==
null\<close>
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 97:5\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 101:8\<close>
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
\<comment>\<open>in 'Clocks' (Clocks.vdmsl) at line 100:9\<close>
definition
	ord_FMURef :: "FMURef \<Rightarrow> FMURef \<Rightarrow> bool"
where
	"ord_FMURef a   b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_FMURef` specification.\<close>
		(inv_FMURef a  \<and>  inv_FMURef b)  \<and> 
		\<comment>\<open>User defined body of ord_FMURef.\<close>
		((ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f a) < (ref\<^sub>F\<^sub>M\<^sub>U\<^sub>R\<^sub>e\<^sub>f b))"

		
lemmas inv_FMURef_defs = inv_FMURef_def inv_Name_def inv_Ref_def inv_VDMChar_def inv_VDMNat_def inv_VDMSeq1'_def inv_VDMSeq1'_defs 


end