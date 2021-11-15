(* VDM to Isabelle Translation @2021-11-15T09:43:13.114786Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2INamedTypes.vdmsl' at line 1:8
files = [./src/test/resources/TestV2INamedTypes.vdmsl]
*)
theory TestV2INamedTypes
imports VDMToolkit
begin


type_synonym TBasic1 = "VDMNat1"
	

definition
	inv_TBasic1 :: "TBasic1 \<Rightarrow> \<bool>"
where
	"inv_TBasic1 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasic1 specification\<close>
		((inv_VDMNat1 dummy0))"
 

	
type_synonym TBasic2 = "TBasic1"
	

definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> \<bool>"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic2 specification\<close>
		((inv_TBasic2 t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2\<close>
		(t > (10::VDMNat1))"

		 

definition
	eq_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> \<bool>"
where
	"eq_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TBasic2 specification\<close>
		((inv_TBasic2 t1)  \<and>  (inv_TBasic2 t2))  \<and> 
		\<comment>\<open>User defined body of eq_TBasic2\<close>
		(t1 = t2)"

		 

definition
	ord_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> \<bool>"
where
	"ord_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>User defined body of ord_TBasic2\<close>
		(t1 < t2)"

		 

definition
	min_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"min_TBasic2 a b \<equiv> 
		\<comment>\<open>User defined body of min_TBasic2\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))"

	

definition
	max_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"max_TBasic2 a b \<equiv> 
		\<comment>\<open>User defined body of max_TBasic2\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))"

	

end