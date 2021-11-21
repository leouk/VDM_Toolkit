(* VDM to Isabelle Translation @2021-11-21T07:53:49.877748Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ITypesNamed.vdmsl' at line 1:8
files = [./src/test/resources/TestV2ITypesNamed.vdmsl]
*)
theory TestV2ITypesNamed
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 11:5\<close>
type_synonym TBasic1 = "VDMNat1"
	

\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 11:5\<close>
definition
	inv_TBasic1 :: "TBasic1 \<Rightarrow> \<bool>"
where
	"inv_TBasic1 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TBasic1 specification\<close>
		((inv_VDMNat1 dummy0))"
 

	
\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 14:5\<close>
type_synonym TBasic2 = "TBasic1"
	

\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 15:9\<close>
definition
	inv_TBasic2 :: "TBasic2 \<Rightarrow> \<bool>"
where
	"inv_TBasic2 t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_TBasic2 specification\<close>
		((inv_TBasic1 t))  \<and> 
		\<comment>\<open>User defined body of inv_TBasic2\<close>
		(t > (10::VDMNat1))"

		 

\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 16:23\<close>
definition
	eq_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> \<bool>"
where
	"eq_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for eq_TBasic2 specification\<close>
		((inv_TBasic2 t1)  \<and>  (inv_TBasic2 t2))  \<and> 
		\<comment>\<open>User defined body of eq_TBasic2\<close>
		(t1 = t2)"

		 

\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 17:23\<close>
definition
	ord_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> \<bool>"
where
	"ord_TBasic2 t1 t2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for ord_TBasic2 specification\<close>
		((inv_TBasic2 t1)  \<and>  (inv_TBasic2 t2))  \<and> 
		\<comment>\<open>User defined body of ord_TBasic2\<close>
		(t1 < t2)"

		 

\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 17:23\<close>
definition
	min_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"min_TBasic2 a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for min_TBasic2 specification\<close>
		(if ((inv_TBasic2 a)  \<and>  (inv_TBasic2 b)) then
			
		\<comment>\<open>User defined body of min_TBasic2\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(a)
		else
		(b))
			else
			undefined)"

	

\<comment>\<open>in 'TestV2ITypesNamed' (./src/test/resources/TestV2ITypesNamed.vdmsl) at line 17:23\<close>
definition
	max_TBasic2 :: "TBasic2\<Rightarrow> TBasic2 \<Rightarrow> TBasic2"
where
	"max_TBasic2 a b \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for max_TBasic2 specification\<close>
		(if ((inv_TBasic2 a)  \<and>  (inv_TBasic2 b)) then
			
		\<comment>\<open>User defined body of max_TBasic2\<close>
		(
		if (((a < b) \<or> (a = b))) then
		(b)
		else
		(a))
			else
			undefined)"

	

end