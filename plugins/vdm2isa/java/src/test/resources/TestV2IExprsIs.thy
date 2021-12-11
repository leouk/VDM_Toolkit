(* VDM to Isabelle Translation @2021-12-11T13:31:51.646746Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsIs.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsIs.vdmsl]
*)
theory TestV2IExprsIs
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: T = real
	inv t == (t > 0)\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 6:5\<close>
type_synonym T = "VDMReal"
	

\<comment>\<open>VDM source: inv_T: (real +> bool)
	inv_T(t) ==
(t > 0)\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 7:9\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T t \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_T` specification.\<close>
		(((inv_VDMReal t)))  \<and> 
		\<comment>\<open>User defined body of inv_T.\<close>
		(t > (0::VDMNat))"

		 

	
\<comment>\<open>VDM source: TS = set of (T)\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 9:5\<close>
type_synonym TS = "T VDMSet"
	

\<comment>\<open>VDM source: inv_TS = ?\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 9:5\<close>
definition
	inv_TS :: "TS \<Rightarrow> bool"
where
	"inv_TS dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TS` specification.\<close>
		(((inv_VDMSet' (inv_T) dummy0)))"

		 

	
\<comment>\<open>VDM source: s1:set of (real) = {1, 2, 3}\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 12:5\<close>
abbreviation
	s1 :: "VDMReal VDMSet"
where
	"s1 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

	definition
	inv_s1 :: "\<bool>"
where
	"inv_s1  \<equiv> (inv_VDMSet' (inv_VDMReal) s1)"

	
	
\<comment>\<open>VDM source: s2:set of (real) = {0.5, 1, 2}\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 13:5\<close>
abbreviation
	s2 :: "VDMReal VDMSet"
where
	"s2 \<equiv> {(0.5), (1::VDMNat1), (2::VDMNat1)}"

	definition
	inv_s2 :: "\<bool>"
where
	"inv_s2  \<equiv> (inv_VDMSet' (inv_VDMReal) s2)"

	
	
\<comment>\<open>VDM source: v1:bool = is_(s1, set of (nat))\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 16:5\<close>
abbreviation
	v1 :: "bool"
where
	"v1 \<equiv> isTest (s1) (inv_VDMSet' (inv_VDMNat))"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_bool v1)"

	
	
\<comment>\<open>VDM source: v2:bool = is_(s2, set of (nat))\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 18:5\<close>
abbreviation
	v2 :: "bool"
where
	"v2 \<equiv> isTest (s2) (inv_VDMSet' (inv_VDMNat))"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_bool v2)"

	
	
\<comment>\<open>VDM source: v3:bool = is_(s1, set of (T))\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 20:5\<close>
abbreviation
	v3 :: "bool"
where
	"v3 \<equiv> isTest (s1) (inv_VDMSet' ((inv_VDMReal)))"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_bool v3)"

	
	
\<comment>\<open>VDM source: v4:bool = is_(s1, TS)\<close>
\<comment>\<open>in 'TestV2IExprsIs' (./src/test/resources/TestV2IExprsIs.vdmsl) at line 22:5\<close>
abbreviation
	v4 :: "bool"
where
	"v4 \<equiv> isTest (s1) inv_TS"

	definition
	inv_v4 :: "\<bool>"
where
	"inv_v4  \<equiv> (inv_bool v4)"

	
end