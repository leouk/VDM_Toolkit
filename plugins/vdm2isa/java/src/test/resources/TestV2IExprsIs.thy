(* VDM to Isabelle Translation @2021-12-01T15:26:51.241556Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsIs.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsIs.vdmsl]
*)
theory TestV2IExprsIs
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 6:5\<close>
type_synonym T = "VDMReal"
	

\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 7:9\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_T specification\<close>
		(((inv_VDMReal t)))  \<and> 
		\<comment>\<open>User defined body of inv_T\<close>
		(t > (0::VDMNat))"

		 

	
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 9:5\<close>
type_synonym TS = "T VDMSet"
	

\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 9:5\<close>
definition
	inv_TS :: "TS \<Rightarrow> bool"
where
	"inv_TS dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared inv_TS specification\<close>
		(((inv_VDMSet' (inv_T) dummy0)))"

		 

	
abbreviation
	s1 :: "VDMReal VDMSet"
where
	"s1 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

	definition
	inv_s1 :: "\<bool>"
where
	"inv_s1  \<equiv> (inv_VDMSet' (inv_VDMReal) s1)"

	
	
abbreviation
	s2 :: "VDMReal VDMSet"
where
	"s2 \<equiv> {(0.5), (1::VDMNat1), (2::VDMNat1)}"

	definition
	inv_s2 :: "\<bool>"
where
	"inv_s2  \<equiv> (inv_VDMSet' (inv_VDMReal) s2)"

	
	
abbreviation
	v1 :: "bool"
where
	"v1 \<equiv> isTest (s1) (inv_VDMSet' (inv_VDMNat))"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_bool v1)"

	
	
abbreviation
	v2 :: "bool"
where
	"v2 \<equiv> isTest (s2) (inv_VDMSet' (inv_VDMNat))"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_bool v2)"

	
	
abbreviation
	v3 :: "bool"
where
	"v3 \<equiv> isTest (s1) (inv_VDMSet' ((inv_VDMReal)))"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_bool v3)"

	
	
abbreviation
	v4 :: "bool"
where
	"v4 \<equiv> isTest (s1) inv_TS"

	definition
	inv_v4 :: "\<bool>"
where
	"inv_v4  \<equiv> (inv_bool v4)"

	
end