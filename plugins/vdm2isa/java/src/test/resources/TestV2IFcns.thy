(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

files = [./src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns
imports "VDMToolkit"
begin

definition
	pre_f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_f x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat1 y))"

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
		\<comment>\<open>User defined body\<close>
		(x + y)"

		definition
	pre_const :: "\<bool>"
where
	"pre_const  \<equiv> 
		\<comment>\<open>User defined body\<close>
		(True::\<bool>)"

definition
	post_const :: "VDMNat \<Rightarrow> \<bool>"
where
	"post_const RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_const specification\<close>
		((inv_VDMNat RESULT)) \<and>
		\<comment>\<open>User defined body\<close>
		(True::\<bool>)"

definition
	const :: "VDMNat"
where
	"const  \<equiv> 
		\<comment>\<open>User defined body\<close>
		(10::VDMNat1)"

		definition
	pre_g :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_g x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_g specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat1 y)) \<and>
		\<comment>\<open>User defined body\<close>
		(x > (10::VDMNat1))"

definition
	post_g :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"post_g x y RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_g specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat1 y) \<and>
		(inv_VDMNat1 RESULT)) \<and>
		\<comment>\<open>User defined body\<close>
		(x < RESULT)"

definition
	g :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"g x y \<equiv> 
		\<comment>\<open>User defined body\<close>
		(x + y)"

		definition
	pre_h :: "VDMNat \<Rightarrow> \<bool>"
where
	"pre_h x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_h specification\<close>
		((inv_VDMNat x)) \<and>
		\<comment>\<open>User defined body\<close>
		((pre_g x  x) \<and> (x < (20::VDMNat1)))"

definition
	post_h :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_h x RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_h specification\<close>
		((inv_VDMNat x) \<and>
		(inv_VDMNat RESULT)) \<and>
		\<comment>\<open>User defined body\<close>
		((post_g x  x  RESULT) \<and> (x > (20::VDMNat1)))"

definition
	h :: "VDMNat \<Rightarrow> VDMNat"
where
	"h x \<equiv> 
		\<comment>\<open>User defined body\<close>
		(g x  x)"

end