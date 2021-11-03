(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2ICompleExpr.vdmsl' at line 1:8files = [./src/test/resources/TestV2ICompleExpr.vdmsl]
*)
theory TestV2IComplexExpr
imports VDMToolkit
begin

abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"


	abbreviation
	t10 :: "VDMInt VDMSeq1"
where
	"t10 \<equiv> [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)]"

definition
	inv_t10 :: "\<bool>"
where
	"inv_t10  \<equiv> (inv_VDMSeq1' (inv_VDMInt) t10)"


	abbreviation
	vc1 :: "\<bool>"
where
	"vc1 \<equiv> (\<forall> var1  var2 \<in> t9 . (var1 \<le> var2))"

definition
	inv_vc1 :: "\<bool>"
where
	"inv_vc1  \<equiv> (inv_bool vc1)"


	\<comment>\<open>@ in 'TestV2IComplexExpr' (./src/test/resources/TestV2ICompleExpr.vdmsl) at line 8:58
TCForallExpression multiple set binds!
\<close>
abbreviation
	vc2 :: "\<bool>"
where
	"vc2 \<equiv> (\<forall> var1  var2 \<in> (elems t10) . (var1 \<le> var2))"

definition
	inv_vc2 :: "\<bool>"
where
	"inv_vc2  \<equiv> (inv_bool vc2)"


	\<comment>\<open>@ in 'TestV2IComplexExpr' (./src/test/resources/TestV2ICompleExpr.vdmsl) at line 9:58
TCForallExpression multiple seq binds!
\<close>
 
\<comment>\<open>@ in 'TestV2IComplexExpr' (./src/test/resources/TestV2ICompleExpr.vdmsl) at line 12:7
 has to be a function for executability because of the type bind!
\<close>
definition
	pre_vc3 :: "\<bool>"
where
	"pre_vc3  \<equiv> True"

definition
	post_vc3 :: "\<bool> \<Rightarrow> \<bool>"
where
	"post_vc3 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc3 specification\<close>
		((inv_bool RESULT))"

definition
	vc3 :: "\<bool>"
where
	"vc3  \<equiv> 
	\<comment>\<open>User defined body of vc3\<close>
	(\<forall> (var1::VDMNat)  (var2::VDMNat)  . ((inv_VDMNat var1) \<and>  (inv_VDMNat var2) \<longrightarrow> (var1 < var2)))"

	\<comment>\<open>@ in 'TestV2IComplexExpr' (./src/test/resources/TestV2ICompleExpr.vdmsl) at line 14:58
 multiple type binds
\<close>
definition
	pre_vc4 :: "\<bool>"
where
	"pre_vc4  \<equiv> True"

definition
	post_vc4 :: "\<bool> \<Rightarrow> \<bool>"
where
	"post_vc4 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc4 specification\<close>
		((inv_bool RESULT))"

definition
	vc4 :: "\<bool>"
where
	"vc4  \<equiv> 
	\<comment>\<open>User defined body of vc4\<close>
	(\<forall> (var1::VDMNat) . (\<forall> (var2::VDMNat) . (\<forall> var3  var4 \<in> t9 . ((inv_VDMNat var1) \<and>  (inv_VDMNat var2) \<and>   \<longrightarrow> ((var1 + var3) < (var2 + var4))))))"

	\<comment>\<open>@ in 'TestV2IComplexExpr' (./src/test/resources/TestV2ICompleExpr.vdmsl) at line 17:94
 multiple type binds
\<close>
 
\<comment>\<open>@ in 'TestV2IComplexExpr' (./src/test/resources/TestV2ICompleExpr.vdmsl) at line 19:7
 for issuing pre/post calls needs spec
\<close>
definition
	pre_f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_f x y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_f specification\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))  \<and> 
		\<comment>\<open>User defined body of pre_f\<close>
		(x < y)"

definition
	post_f :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_f x y RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_f specification\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_f\<close>
		(RESULT > (0::VDMNat))"

definition
	f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat"
where
	"f x y \<equiv> 
	\<comment>\<open>User defined body of f\<close>
	(x + y)"

	definition
	pre_vc5 :: "\<bool>"
where
	"pre_vc5  \<equiv> True"

definition
	post_vc5 :: "\<bool> \<Rightarrow> \<bool>"
where
	"post_vc5 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc5 specification\<close>
		((inv_bool RESULT))"

definition
	vc5 :: "\<bool>"
where
	"vc5  \<equiv> 
	\<comment>\<open>User defined body of vc5\<close>
	(\<forall> (x::VDMNat)  (y::VDMNat1)  . ((inv_VDMNat x) \<and>  (inv_VDMNat1 y) \<longrightarrow> ((pre_f x  y) \<longrightarrow> (post_f x  y  (x + y)))))"

end