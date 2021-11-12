(* VDM to Isabelle Translation @2021-11-11T14:20:31.565957Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypes.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypes.vdmsl]
*)
theory TestV2ITypes
imports VDMToolkit
begin


type_synonym TBasic = "VDMNat1"
	
definition
	inv_TBasic :: "VDMNat1 \<Rightarrow> \<bool>"
where
	"inv_TBasic t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic specification\<close>
		((inv_VDMNat1 t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic\<close>
		(t > (10::VDMNat1))"

		 
definition
	eq_TBasic :: "VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"eq_TBasic t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TBasic specification\<close>
		((inv_VDMNat1 t1)  \<and>  (inv_VDMNat1 t2))  \<and> 
		\<comment>\<open>User defined body of eq_TBasic\<close>
		(t1 = t2)"

		 
definition
	ord_TBasic :: "VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"ord_TBasic t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_TBasic specification\<close>
		((inv_VDMNat1 t1)  \<and>  (inv_VDMNat1 t2))  \<and> 
		\<comment>\<open>User defined body of ord_TBasic\<close>
		(t1 < t2)"

		 

	
type_synonym TOptional = "VDMNat1 option"
	
definition
	inv_TOptional :: "VDMNat1 option \<Rightarrow> \<bool>"
where
	"inv_TOptional o1 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TOptional specification\<close>
		((inv_Option (inv_VDMNat1) o1))  \<and> 
		\<comment>\<open>User defined body of inv_TOptional\<close>
		((\<comment>\<open>Optional type variable  might not need extra the operator!\<close>
    ((o1)) \<noteq> None) \<longrightarrow> (\<comment>\<open>Optional type variable might not need extra @{term the} operator!\<close>(the(o1)) > (10::VDMNat1)))"

		 

end