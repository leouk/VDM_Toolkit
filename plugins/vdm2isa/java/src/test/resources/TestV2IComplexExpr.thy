(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IComplexExpr.vdmsl' at line 1:8files = [./src/test/resources/TestV2IComplexExpr.vdmsl]
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
	"vc1 \<equiv> (\<forall> var1 \<in> t9  var2 \<in> t9 . (var1 \<le> var2))"

definition
	inv_vc1 :: "\<bool>"
where
	"inv_vc1  \<equiv> (inv_bool vc1)"


	
abbreviation
	vc2 :: "\<bool>"
where
	"vc2 \<equiv> (\<forall> var1  var2 \<in> (elems t10) . (var1 \<le> var2))"

definition
	inv_vc2 :: "\<bool>"
where
	"inv_vc2  \<equiv> (inv_bool vc2)"


	
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
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close>  \<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> (\<forall> (var1::VDMNat)  (var2::VDMNat)  . ((inv_VDMNat var1) \<and>  (inv_VDMNat var2) \<longrightarrow> (var1 < var2)))"

	
definition
	pre_vc31 :: "\<bool>"
where
	"pre_vc31  \<equiv> True"

definition
	post_vc31 :: "VDMNat VDMSet \<Rightarrow> \<bool>"
where
	"post_vc31 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc31 specification\<close>
		((inv_VDMSet' (inv_VDMNat) RESULT))"

definition
	vc31 :: "VDMNat VDMSet"
where
	"vc31  \<equiv> 
	\<comment>\<open>User defined body of vc31\<close>
	{ x .   (inv_VDMNat x)  \<and> (x > (10::VDMNat1)) }"

	
definition
	pre_vc32 :: "\<bool>"
where
	"pre_vc32  \<equiv> True"

definition
	post_vc32 :: "VDMNat VDMSet \<Rightarrow> \<bool>"
where
	"post_vc32 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc32 specification\<close>
		((inv_VDMSet' (inv_VDMNat) RESULT))"

definition
	vc32 :: "VDMNat VDMSet"
where
	"vc32  \<equiv> 
	\<comment>\<open>User defined body of vc32\<close>
	{ (x + y) | (x :: VDMNat)  (y :: VDMNat) .  (inv_VDMNat x) \<and>  (inv_VDMNat y)  \<and> (x > y) }"

	
definition
	pre_vc33 :: "\<bool>"
where
	"pre_vc33  \<equiv> True"

definition
	post_vc33 :: "VDMNat VDMSeq \<Rightarrow> \<bool>"
where
	"post_vc33 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc33 specification\<close>
		((inv_VDMSeq' (inv_VDMNat) RESULT))"

definition
	vc33 :: "VDMNat VDMSeq"
where
	"vc33  \<equiv> 
	\<comment>\<open>User defined body of vc33\<close>
	[ x .  (inv_VDMNat x) , (x > (10::VDMNat1)) ]"

	
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
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close>  
\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
(\<forall> (var1::VDMNat) . (\<forall> (var2::VDMNat) . (\<forall> var3 \<in> t9  var4 \<in> t9 . ((inv_VDMNat var1) \<and>  (inv_VDMNat var2) \<and>  var3 \<in> t9 \<and>  var4\<in> t9 \<longrightarrow> ((var1 + var3) < (var2 + var4))))))"

	
definition
	pre_vc41 :: "\<bool>"
where
	"pre_vc41  \<equiv> True"

definition
	post_vc41 :: "VDMNat VDMSet \<Rightarrow> \<bool>"
where
	"post_vc41 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc41 specification\<close>
		((inv_VDMSet' (inv_VDMNat) RESULT))"

definition
	vc41 :: "VDMNat VDMSet"
where
	"vc41  \<equiv> 
	\<comment>\<open>User defined body of vc41\<close>
	{ x .   (inv_VDMNat x)  \<and> (x > (10::VDMNat1)) }"

	
definition
	pre_vc42 :: "\<bool>"
where
	"pre_vc42  \<equiv> True"

definition
	post_vc42 :: "VDMNat VDMSet \<Rightarrow> \<bool>"
where
	"post_vc42 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc42 specification\<close>
		((inv_VDMSet' (inv_VDMNat) RESULT))"

definition
	vc42 :: "VDMNat VDMSet"
where
	"vc42  \<equiv> 
	\<comment>\<open>User defined body of vc42\<close>
	{ (x + y) | (x :: VDMNat)  y .  (inv_VDMNat x) \<and>  y \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}  \<and> (x > y) }"

	
definition
	pre_vc5 :: "\<bool>"
where
	"pre_vc5  \<equiv> True"

definition
	post_vc5 :: "VDMNat \<Rightarrow> \<bool>"
where
	"post_vc5 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc5 specification\<close>
		((inv_VDMNat RESULT))"

definition
	vc5 :: "VDMNat"
where
	"vc5  \<equiv> 
	\<comment>\<open>User defined body of vc5\<close>
	THE var. ((inv_VDMNat var) \<and> (var < (1::VDMNat1)))(THE var. ((inv_VDMNat var) \<and> (var < (1::VDMNat1))))"

	
definition
	pre_vc51 :: "\<bool>"
where
	"pre_vc51  \<equiv> True"

definition
	post_vc51 :: "VDMNat \<Rightarrow> \<bool>"
where
	"post_vc51 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc51 specification\<close>
		((inv_VDMNat RESULT))"

definition
	vc51 :: "VDMNat"
where
	"vc51  \<equiv> 
	\<comment>\<open>User defined body of vc51\<close>
	THE var. (var \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)} \<and> (var < (1::VDMNat1)))(THE var. (var \<in> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)} \<and> (var < (1::VDMNat1))))"

	
definition
	pre_vc6 :: "\<bool>"
where
	"pre_vc6  \<equiv> True"

definition
	post_vc6 :: "VDMNat1 \<Rightarrow> \<bool>"
where
	"post_vc6 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc6 specification\<close>
		((inv_VDMNat1 RESULT))"

definition
	vc6 :: "VDMNat1"
where
	"vc6  \<equiv> 
	\<comment>\<open>User defined body of vc6\<close>
	((
	\<lambda> (var::VDMNat)  (var2::VDMNat) .
		(if (inv_VDMNat var) \<and>  (inv_VDMNat var2) then
		(var + var2)
	 else
		undefined
	)
	) (10::VDMNat1)  (20::VDMNat1))"

	
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
	pre_vc7 :: "\<bool>"
where
	"pre_vc7  \<equiv> True"

definition
	post_vc7 :: "\<bool> \<Rightarrow> \<bool>"
where
	"post_vc7 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_vc7 specification\<close>
		((inv_bool RESULT))"

definition
	vc7 :: "\<bool>"
where
	"vc7  \<equiv> 
	\<comment>\<open>User defined body of vc7\<close>
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close>  \<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> (\<forall> (x::VDMNat)  (y::VDMNat1)  . ((inv_VDMNat x) \<and>  (inv_VDMNat1 y) \<longrightarrow> ((pre_f x  y) \<longrightarrow> (post_f x  y  (x + y)))))"

end