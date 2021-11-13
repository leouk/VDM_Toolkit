(* VDM to Isabelle Translation @2021-11-13T07:15:06.399953Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypes.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypes.vdmsl]
*)
theory TestV2ITypes
imports VDMToolkit
begin


type_synonym TBasic1 = "VDMNat1"
	

	
type_synonym TBasic2 = "TBasic1"
	
definition
	inv_TBasic2 :: "TBasic1 = "VDMNat1" \<Rightarrow> \<bool>"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic2 specification\<close>
		((inv_VDMNat1 t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2\<close>
		(t > (10::VDMNat1))"

		 
definition
	eq_TBasic2 :: "TBasic1 = "VDMNat1"\<Rightarrow> TBasic1 = "VDMNat1" \<Rightarrow> \<bool>"
where
	"eq_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TBasic2 specification\<close>
		((inv_VDMNat1 t1)  \<and>  (inv_VDMNat1 t2))  \<and> 
		\<comment>\<open>User defined body of eq_TBasic2\<close>
		(t1 = t2)"

		 
definition
	ord_TBasic2 :: "TBasic1 = "VDMNat1"\<Rightarrow> TBasic1 = "VDMNat1" \<Rightarrow> \<bool>"
where
	"ord_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_TBasic2 specification\<close>
		((inv_VDMNat1 t1)  \<and>  (inv_VDMNat1 t2))  \<and> 
		\<comment>\<open>User defined body of ord_TBasic2\<close>
		(t1 < t2)"

		 

end