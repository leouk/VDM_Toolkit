(* VDM to Isabelle Translation @2021-11-30T10:20:27.473622Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IFcns.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IFcns.vdmsl]
*)
theory TestV2IFcns
imports VDMToolkit
begin


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 7:5\<close>

\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 7:5\<close>
definition
	pre_const :: "\<bool>"
where
	"pre_const  \<equiv> True"


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 7:5\<close>
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
	10"

	
\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 11:5\<close>

\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 13:12\<close>
definition
	pre_constS :: "\<bool>"
where
	"pre_constS  \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_constS specification\<close>
		
		\<comment>\<open>User defined body of pre_constS\<close>
		(10 > 5)"


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 14:17\<close>
definition
	post_constS :: "VDMNat \<Rightarrow> \<bool>"
where
	"post_constS RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_constS specification\<close>
		((inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_constS\<close>
		(RESULT > 0)"

definition
	constS :: "VDMNat"
where
	"constS  \<equiv> 
	\<comment>\<open>User defined body of constS\<close>
	10"

	
\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 17:5\<close>

\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 17:5\<close>
definition
	pre_f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_f x  y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_f specification\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))"


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 17:5\<close>
definition
	post_f :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"post_f x  y  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_f specification\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat1 RESULT))"

definition
	f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"f x  y \<equiv> 
	\<comment>\<open>User defined body of f\<close>
	(x + y)"

	
\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 21:5\<close>

\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 23:16\<close>
definition
	pre_g :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_g x  y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_g specification\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))  \<and> 
		\<comment>\<open>User defined body of pre_g\<close>
		((x > 10) \<and> (y > 20))"


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 24:12\<close>
definition
	post_g :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"post_g x  y  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_g specification\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat1 RESULT))  \<and> 
		\<comment>\<open>User defined body of post_g\<close>
		(x < RESULT)"

definition
	g :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"g x  y \<equiv> 
	\<comment>\<open>User defined body of g\<close>
	(x + y)"

	
\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 27:5\<close>

\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 29:21\<close>
definition
	pre_h :: "VDMNat \<Rightarrow> \<bool>"
where
	"pre_h x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_h specification\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h\<close>
		((pre_g x  x) \<and> (x < 20))"


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 30:31\<close>
definition
	post_h :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_h x  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_h specification\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h\<close>
		((post_g x  x  RESULT) \<and> (x > 20))"

definition
	h :: "VDMNat \<Rightarrow> VDMNat"
where
	"h x \<equiv> 
	\<comment>\<open>User defined body of h\<close>
	(g x  x)"

	
\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 33:5\<close>

\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 35:11\<close>
definition
	pre_h' :: "VDMNat \<Rightarrow> \<bool>"
where
	"pre_h' x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_h' specification\<close>
		((inv_VDMNat x))  \<and> 
		\<comment>\<open>User defined body of pre_h'\<close>
		(x < 20)"


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 36:12\<close>
definition
	post_h' :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_h' x  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_h' specification\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_h'\<close>
		(x > 20)"

definition
	h' :: "VDMNat \<Rightarrow> VDMNat"
where
	"h' x \<equiv> 
	\<comment>\<open>User defined body of h'\<close>
	(g x  x)"

	
\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 39:5\<close>

\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 39:5\<close>
definition
	pre_curried :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"pre_curried x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_curried specification\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))"


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 39:5\<close>
definition
	post_curried :: "VDMNat \<Rightarrow> VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_curried x y  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_curried specification\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))"

definition
	curried :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"curried x y \<equiv> 
	\<comment>\<open>User defined body of curried\<close>
	(x + y)"

	
\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 43:5\<close>

\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 45:11\<close>
definition
	pre_curriedS :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"pre_curriedS x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_curriedS specification\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))  \<and> 
		\<comment>\<open>User defined body of pre_curriedS\<close>
		(x > y)"


\<comment>\<open>in 'TestV2IFcns' (./src/test/resources/TestV2IFcns.vdmsl) at line 46:21\<close>
definition
	post_curriedS :: "VDMNat \<Rightarrow> VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_curriedS x y  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_curriedS specification\<close>
		((inv_VDMNat x))  \<and> ((inv_VDMNat y))  \<and> 
		\<comment>\<open>User defined body of post_curriedS\<close>
		((x < RESULT) \<and> (y < RESULT))"

definition
	curriedS :: "VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"curriedS x y \<equiv> 
	\<comment>\<open>User defined body of curriedS\<close>
	(x + y)"

end