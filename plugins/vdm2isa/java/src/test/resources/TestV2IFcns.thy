(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

files = [./src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns
imports "VDMToolkit"
begin

\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 6:7
 constant function with undeclared specification
\<close>definition
	pre_const :: "\<bool>"
where
	"pre_const  \<equiv> True"

definition
	post_const :: "VDMNat \<Rightarrow> \<bool>"
where
	"post_const RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_const specification\<close>
		((inv_VDMNat RESULT))"

definition
	const :: "VDMNat"
where
	"const  \<equiv> 
	\<comment>\<open>User defined body of const\<close>
	(10::VDMNat1)"

	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 10:7
 constant function with declared specification
\<close>definition
	pre_constS :: "\<bool>"
where
	"pre_constS  \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_constS specification\<close>
		
		\<comment>\<open>User defined body of pre_constS\<close>
		((10::VDMNat1) > (5::VDMNat1))"

definition
	post_constS :: "VDMNat \<Rightarrow> \<bool>"
where
	"post_constS RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_constS specification\<close>
		((inv_VDMNat RESULT)) \<and>
		\<comment>\<open>User defined body of post_constS\<close>
		(RESULT > (0::VDMNat))"

definition
	constS :: "VDMNat"
where
	"constS  \<equiv> 
	\<comment>\<open>User defined body of constS\<close>
	(10::VDMNat1)"

	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 16:7
 "normal" function with undeclared specification
\<close>definition
	pre_f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_f x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f specification\<close>
		((inv_VDMNat x) \<and> (inv_VDMNat1 y))"

definition
	post_f :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"post_f x y RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f specification\<close>
		((inv_VDMNat x) \<and> (inv_VDMNat1 y) \<and> (inv_VDMNat1 RESULT))"

definition
	f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"f x y \<equiv> 
	\<comment>\<open>User defined body of f\<close>
	(x + y)"

	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 20:7
 "normal" function with declared specification
\<close>definition
	pre_g :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_g x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_g specification\<close>
		((inv_VDMNat x) \<and> (inv_VDMNat1 y)) \<and>
		\<comment>\<open>User defined body of pre_g\<close>
		((x > (10::VDMNat1)) \<and> (y > (20::VDMNat1)))"

definition
	post_g :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"post_g x y RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_g specification\<close>
		((inv_VDMNat x) \<and> (inv_VDMNat1 y) \<and> (inv_VDMNat1 RESULT)) \<and>
		\<comment>\<open>User defined body of post_g\<close>
		(x < RESULT)"

definition
	g :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"g x y \<equiv> 
	\<comment>\<open>User defined body of g\<close>
	(x + y)"

	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 26:7
 "normal" function with declared specification and pre/post references
\<close>definition
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
		((inv_VDMNat x) \<and> (inv_VDMNat RESULT)) \<and>
		\<comment>\<open>User defined body of post_h\<close>
		((post_g x  x  RESULT) \<and> (x > (20::VDMNat1)))"

definition
	h :: "VDMNat \<Rightarrow> VDMNat"
where
	"h x \<equiv> 
	\<comment>\<open>User defined body of h\<close>
	(g x  x)"

	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 32:7
 curried function with undeclared specification	
\<close>definition
	pre_curried :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"pre_curried x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_curried specification\<close>
		((inv_VDMNat x)) \<and>((inv_VDMNat y))"

definition
	post_curried :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_curried x y RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_curried specification\<close>
		((inv_VDMNat x)) \<and>((inv_VDMNat y))"

definition
	curried :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"curried x y \<equiv> 
	\<comment>\<open>User defined body of curried\<close>
	(x + y)"

	\<comment>\<open>@ in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 36:7
 curried function with declared specification	
\<close>definition
	pre_curriedS :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"pre_curriedS x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_curriedS specification\<close>
		((inv_VDMNat x)) \<and>((inv_VDMNat y)) \<and>
		\<comment>\<open>User defined body of pre_curriedS\<close>
		(x > y)"

definition
	post_curriedS :: "VDMNat \<Rightarrow> VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_curriedS x y RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_curriedS specification\<close>
		((inv_VDMNat x)) \<and>((inv_VDMNat y)) \<and>
		\<comment>\<open>User defined body of post_curriedS\<close>
		((x < RESULT) \<and> (y < RESULT))"

definition
	curriedS :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"curriedS x y \<equiv> 
	\<comment>\<open>User defined body of curriedS\<close>
	(x + y)"

end