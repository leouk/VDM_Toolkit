(* VDM to Isabelle Translation @2021-12-13T09:52:48.268946Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsComplex.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsComplex.vdmsl]
*)
theory TestV2IExprsComplex
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: t9:set1 of (nat1) = {1, 2, 3}\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 6:5\<close>
abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

	definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"

	
	
\<comment>\<open>VDM source: t10:seq1 of (int) = [1, 2, 3]\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 7:5\<close>
abbreviation
	t10 :: "VDMInt VDMSeq1"
where
	"t10 \<equiv> [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)]"

	definition
	inv_t10 :: "\<bool>"
where
	"inv_t10  \<equiv> (inv_VDMSeq1' (inv_VDMInt) t10)"

	
	
\<comment>\<open>VDM source: vc1:bool = (forall var1, var2 in set t9 & (var1 <= var2))\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 8:5\<close>
abbreviation
	vc1 :: "bool"
where
	"vc1 \<equiv> (\<forall> var1 \<in> t9  . (\<forall> var2 \<in> t9  . (var1 \<le> var2)))"

	definition
	inv_vc1 :: "\<bool>"
where
	"inv_vc1  \<equiv> (inv_bool vc1)"

	
	
\<comment>\<open>VDM source: vc2:bool = (forall var1, var2 in seq t10 & (var1 <= var2))\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 9:5\<close>
abbreviation
	vc2 :: "bool"
where
	"vc2 \<equiv> (\<forall> var1 \<in> (elems t10)  . (\<forall> var2 \<in> (elems t10)  . (var1 \<le> var2)))"

	definition
	inv_vc2 :: "\<bool>"
where
	"inv_vc2  \<equiv> (inv_bool vc2)"

	
	
\<comment>\<open>VDM source: vc3: (() -> bool)
	vc3() ==
(forall var1:nat, var2:nat & (var1 < var2))\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 15:5\<close>

\<comment>\<open>VDM source: pre_vc3 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 15:5\<close>
definition
	pre_vc3 :: "bool"
where
	"pre_vc3  \<equiv> True"


\<comment>\<open>VDM source: post_vc3 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 15:5\<close>
definition
	post_vc3 :: "bool \<Rightarrow> bool"
where
	"post_vc3 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc3` specification.\<close>
		((inv_bool RESULT))"

definition
	vc3 :: "bool"
where
	"vc3  \<equiv> 
	\<comment>\<open>User defined body of vc3.\<close>
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	(\<forall> (var1 :: VDMNat)  (var2 :: VDMNat)  . ((((inv_VDMNat var1))) \<and>  (((inv_VDMNat var2))) \<longrightarrow> (var1 < var2)))"

	
\<comment>\<open>VDM source: vc31: (() -> set of (nat))
	vc31() ==
{x | x:nat & (x > 10)}\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 19:5\<close>

\<comment>\<open>VDM source: pre_vc31 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 19:5\<close>
definition
	pre_vc31 :: "bool"
where
	"pre_vc31  \<equiv> True"


\<comment>\<open>VDM source: post_vc31 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 19:5\<close>
definition
	post_vc31 :: "VDMNat VDMSet \<Rightarrow> bool"
where
	"post_vc31 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc31` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) RESULT))"

definition
	vc31 :: "VDMNat VDMSet"
where
	"vc31  \<equiv> 
	\<comment>\<open>User defined body of vc31.\<close>
	{ x .   \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (((inv_VDMNat x)))  \<and> (x > (10::VDMNat1)) }"

	
\<comment>\<open>VDM source: vc32: (() -> set of (nat))
	vc32() ==
{(x + y) | x:nat, y:nat & (x > y)}\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 23:5\<close>

\<comment>\<open>VDM source: pre_vc32 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 23:5\<close>
definition
	pre_vc32 :: "bool"
where
	"pre_vc32  \<equiv> True"


\<comment>\<open>VDM source: post_vc32 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 23:5\<close>
definition
	post_vc32 :: "VDMNat VDMSet \<Rightarrow> bool"
where
	"post_vc32 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc32` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) RESULT))"

definition
	vc32 :: "VDMNat VDMSet"
where
	"vc32  \<equiv> 
	\<comment>\<open>User defined body of vc32.\<close>
	{ (x + y) | (x :: VDMNat)  (y :: VDMNat) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (((inv_VDMNat x))) \<and>  (((inv_VDMNat y)))  \<and> (x > y) }"

	
\<comment>\<open>VDM source: vc4: (() -> bool)
	vc4() ==
(forall var1:nat, var2:nat, var3, var4 in set t9 & ((var1 + var3) < (var2 + var4)))\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 27:5\<close>

\<comment>\<open>VDM source: pre_vc4 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 27:5\<close>
definition
	pre_vc4 :: "bool"
where
	"pre_vc4  \<equiv> True"


\<comment>\<open>VDM source: post_vc4 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 27:5\<close>
definition
	post_vc4 :: "bool \<Rightarrow> bool"
where
	"post_vc4 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc4` specification.\<close>
		((inv_bool RESULT))"

definition
	vc4 :: "bool"
where
	"vc4  \<equiv> 
	\<comment>\<open>User defined body of vc4.\<close>
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	(\<forall> var1 :: VDMNat  . (\<forall> var2 :: VDMNat  . (\<forall> var3 \<in> t9  . (\<forall> var4 \<in> t9  . (((inv_VDMNat var1)) \<and>  ((inv_VDMNat var2)) \<and>  (var3 \<in>t9) \<and>  (var4 \<in>t9) \<longrightarrow> ((var1 + var3) < (var2 + var4)))))))"

	
\<comment>\<open>VDM source: vc41: (() -> set of (nat))
	vc41() ==
{x | x:nat & (x > 10)}\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 31:5\<close>

\<comment>\<open>VDM source: pre_vc41 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 31:5\<close>
definition
	pre_vc41 :: "bool"
where
	"pre_vc41  \<equiv> True"


\<comment>\<open>VDM source: post_vc41 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 31:5\<close>
definition
	post_vc41 :: "VDMNat VDMSet \<Rightarrow> bool"
where
	"post_vc41 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc41` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) RESULT))"

definition
	vc41 :: "VDMNat VDMSet"
where
	"vc41  \<equiv> 
	\<comment>\<open>User defined body of vc41.\<close>
	{ x .   \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (((inv_VDMNat x)))  \<and> (x > (10::VDMNat1)) }"

	
\<comment>\<open>VDM source: vc42: (() -> set of (nat))
	vc42() ==
{(x + y) | x:nat, y in set {1, 2, 3} & (x > y)}\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 35:5\<close>

\<comment>\<open>VDM source: pre_vc42 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 35:5\<close>
definition
	pre_vc42 :: "bool"
where
	"pre_vc42  \<equiv> True"


\<comment>\<open>VDM source: post_vc42 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 35:5\<close>
definition
	post_vc42 :: "VDMNat VDMSet \<Rightarrow> bool"
where
	"post_vc42 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc42` specification.\<close>
		((inv_VDMSet' (inv_VDMNat) RESULT))"

definition
	vc42 :: "VDMNat VDMSet"
where
	"vc42  \<equiv> 
	\<comment>\<open>User defined body of vc42.\<close>
	{ (x + y) | (x :: VDMNat)  y .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (((inv_VDMNat x))) \<and>  ((y \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}))  \<and> (x > y) }"

	
\<comment>\<open>VDM source: vc5: (() -> nat)
	vc5() ==
(iota var:nat & (var < 1))\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 43:5\<close>

\<comment>\<open>VDM source: pre_vc5 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 43:5\<close>
definition
	pre_vc5 :: "bool"
where
	"pre_vc5  \<equiv> True"


\<comment>\<open>VDM source: post_vc5 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 43:5\<close>
definition
	post_vc5 :: "VDMNat \<Rightarrow> bool"
where
	"post_vc5 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc5` specification.\<close>
		((inv_VDMNat RESULT))"

definition
	vc5 :: "VDMNat"
where
	"vc5  \<equiv> 
	\<comment>\<open>User defined body of vc5.\<close>
	(THE var. ((((inv_VDMNat var))) \<and> (var < (1::VDMNat1))))"

	
\<comment>\<open>VDM source: vc51: (() -> nat)
	vc51() ==
(iota var in set {1, 2, 3} & (var < 1))\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 47:5\<close>

\<comment>\<open>VDM source: pre_vc51 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 47:5\<close>
definition
	pre_vc51 :: "bool"
where
	"pre_vc51  \<equiv> True"


\<comment>\<open>VDM source: post_vc51 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 47:5\<close>
definition
	post_vc51 :: "VDMNat \<Rightarrow> bool"
where
	"post_vc51 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc51` specification.\<close>
		((inv_VDMNat RESULT))"

definition
	vc51 :: "VDMNat"
where
	"vc51  \<equiv> 
	\<comment>\<open>User defined body of vc51.\<close>
	(THE var. (((var \<in>{(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)})) \<and> (var < (1::VDMNat1))))"

	
\<comment>\<open>VDM source: vc6: (() -> nat1)
	vc6() ==
(lambda var:nat, var2:nat & (var + var2))(10, 20)\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 51:5\<close>

\<comment>\<open>VDM source: pre_vc6 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 51:5\<close>
definition
	pre_vc6 :: "bool"
where
	"pre_vc6  \<equiv> True"


\<comment>\<open>VDM source: post_vc6 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 51:5\<close>
definition
	post_vc6 :: "VDMNat1 \<Rightarrow> bool"
where
	"post_vc6 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc6` specification.\<close>
		((inv_VDMNat1 RESULT))"

definition
	vc6 :: "VDMNat1"
where
	"vc6  \<equiv> 
	\<comment>\<open>User defined body of vc6.\<close>
	((
	\<lambda> (var :: VDMNat)  (var2 :: VDMNat) .
		(if (((inv_VDMNat var))) \<and>  (((inv_VDMNat var2))) \<and> (inv_VDMNat (var + var2)) then
		(var + var2)
	 else
		undefined
	)
	) (10::VDMNat1)  (20::VDMNat1))"

	
\<comment>\<open>VDM source: f: (nat * nat1 -> nat)
	f(x, y) ==
(x + y)
	pre (x < y)
	post (RESULT > 0)\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 59:5\<close>

\<comment>\<open>VDM source: pre_f: (nat * nat1 +> bool)
	pre_f(x, y) ==
(x < y)\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 61:11\<close>
definition
	pre_f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> bool"
where
	"pre_f x  y \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y))  \<and> 
		\<comment>\<open>User defined body of pre_f.\<close>
		(x < y)"


\<comment>\<open>VDM source: post_f: (nat * nat1 * nat +> bool)
	post_f(x, y, RESULT) ==
(RESULT > 0)\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 62:17\<close>
definition
	post_f :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_f x  y  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_f` specification.\<close>
		((inv_VDMNat x)  \<and>  (inv_VDMNat1 y)  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>User defined body of post_f.\<close>
		(RESULT > (0::VDMNat))"

definition
	f :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat"
where
	"f x  y \<equiv> 
	\<comment>\<open>User defined body of f.\<close>
	(x + y)"

	
\<comment>\<open>VDM source: vc7: (() -> bool)
	vc7() ==
(forall x:nat, y:nat1 & (pre_f(x, y) => post_f(x, y, (x + y))))\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 65:5\<close>

\<comment>\<open>VDM source: pre_vc7 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 65:5\<close>
definition
	pre_vc7 :: "bool"
where
	"pre_vc7  \<equiv> True"


\<comment>\<open>VDM source: post_vc7 = ?\<close>
\<comment>\<open>in 'TestV2IExprsComplex' (./src/test/resources/TestV2IExprsComplex.vdmsl) at line 65:5\<close>
definition
	post_vc7 :: "bool \<Rightarrow> bool"
where
	"post_vc7 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc7` specification.\<close>
		((inv_bool RESULT))"

definition
	vc7 :: "bool"
where
	"vc7  \<equiv> 
	\<comment>\<open>User defined body of vc7.\<close>
	\<comment>\<open>Implicitly defined type invariant checks for quantified type binds\<close> 
	(\<forall> (x :: VDMNat)  (y :: VDMNat1)  . ((((inv_VDMNat x))) \<and>  (((inv_VDMNat1 y))) \<longrightarrow> ((pre_f x  y) \<longrightarrow> (post_f x  y  (x + y)))))"

end