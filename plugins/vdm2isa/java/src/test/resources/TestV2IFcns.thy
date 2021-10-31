(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

files = [./src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns
imports "VDMToolkit"
begin

\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 7:5
implicitly constructed PRE specification\<close>
definition
	pre_f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_f x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat1 y))"

\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 7:5
implicitly constructed POST specification
\<close>
definition
	post_f :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"post_f x y RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat1 y) \<and>
		(inv_VDMNat1 RESULT))"

definition
	f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"f x y \<equiv> 
	\<comment>\<open>User defined body of f\<close>
	(x + y)"

	definition
	pre_const :: "\<bool>"
where
	"pre_const  \<equiv> 
		\<comment>\<open>User defined body of pre_const\<close>
		(True::\<bool>)"

definition
	post_const :: "VDMNat \<Rightarrow> \<bool>"
where
	"post_const RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_const specification\<close>
		((inv_VDMNat RESULT)) \<and>
		\<comment>\<open>User defined body of post_const\<close>
		(True::\<bool>)"

definition
	const :: "VDMNat"
where
	"const  \<equiv> 
	\<comment>\<open>User defined body of const\<close>
	(10::VDMNat1)"

	definition
	pre_g :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_g x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_g specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat1 y)) \<and>
		\<comment>\<open>User defined body of pre_g\<close>
		(x > (10::VDMNat1))"

definition
	post_g :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"post_g x y RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_g specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat1 y) \<and>
		(inv_VDMNat1 RESULT)) \<and>
		\<comment>\<open>User defined body of post_g\<close>
		(x < RESULT)"

definition
	g :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"g x y \<equiv> 
	\<comment>\<open>User defined body of g\<close>
	(x + y)"

	definition
	pre_h :: "VDMNat \<Rightarrow> \<bool>"
where
	"pre_h x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_h specification\<close>
		((inv_VDMNat x)) \<and>
		\<comment>\<open>User defined body of pre_h\<close>
		((pre_g x  x) \<and> (x < (20::VDMNat1)))"

definition
	post_h :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_h x RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_h specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat RESULT)) \<and>
		\<comment>\<open>User defined body of post_h\<close>
		((post_g x  x  RESULT) \<and> (x > (20::VDMNat1)))"

definition
	h :: "VDMNat \<Rightarrow> VDMNat"
where
	"h x \<equiv> 
	\<comment>\<open>User defined body of h\<close>
	(g x  x)"

end