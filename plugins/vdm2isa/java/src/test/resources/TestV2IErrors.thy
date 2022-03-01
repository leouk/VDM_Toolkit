(* VDM to Isabelle Translation @2022-03-01T08:21:22.905347Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IErrors.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IErrors.vdmsl]
*)
theory TestV2IErrors
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: S = compose S of  end\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 9:5\<close>
record S = 
	
	

\<comment>\<open>VDM source: inv_S: (S +> bool)
	inv_S(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 9:5\<close>
definition
	inv_S :: "S \<Rightarrow> bool"
where
	"inv_S dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_S` specification.\<close>
		( ( ))"

		
lemmas inv_S_defs = inv_S_def 


	
	
\<comment>\<open>VDM source: R = compose R of x:nat, y:nat end
	inv r == ((r.x) < (r.y))
	eq mk_R(x1, y1) = mk_R(x2, y2) == ((x1 = x2) and (y1 = y2))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 11:5\<close>
record R = 
	x\<^sub>R :: "VDMNat"
		 
		 y\<^sub>R :: "VDMNat"
	

\<comment>\<open>VDM source: inv_R: (R +> bool)
	inv_R(r) ==
((r.x) < (r.y))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 14:9\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_R` specification.\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R.\<close>
		((x\<^sub>R r) < (y\<^sub>R r))"

		

\<comment>\<open>VDM source: eq_R: (R * R +> bool)
	eq_R(mk_R(x1, y1), mk_R(x2, y2)) ==
((x1 = x2) and (y1 = y2))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 15:8\<close>
definition
	eq_R :: "R \<Rightarrow> R \<Rightarrow> bool"
where
	"eq_R dummy0   dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `eq_R` specification.\<close>
		(inv_R dummy0  \<and>  inv_R dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let x1 = (x\<^sub>R dummy0); y1 = (y\<^sub>R dummy0); 
			x1 = (x\<^sub>R dummy0); y1 = (y\<^sub>R dummy0) in 
		\<comment>\<open>User defined body of eq_R.\<close>
		((x1 = x2) \<and> (y1 = y2)))"

		
lemmas inv_R_defs = inv_R_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: TUnion = set of (real)\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 19:5\<close>
type_synonym TUnion = "U_VDMReal "VDMReal" VDMSet"
	

\<comment>\<open>VDM source: inv_TUnion: (TUnion +> bool)
	inv_TUnion(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 19:5\<close>
definition
	inv_TUnion :: "TUnion \<Rightarrow> bool"
where
	"inv_TUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TUnion` specification.\<close>
		(((inv_VDMSet' (inv_TUnion ) dummy0)))"

		 
lemmas inv_TUnion_defs = inv_TUnion_def inv_VDMReal_def inv_VDMSet'_def inv_VDMSet'_defs 


	
	
\<comment>\<open>VDM source: TInnerUnion = real\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 22:5\<close>
datatype TInnerUnion = U_VDMReal "VDMReal"
	

\<comment>\<open>VDM source: inv_TInnerUnion: (TInnerUnion +> bool)
	inv_TInnerUnion(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 22:5\<close>
definition
	inv_TInnerUnion :: "TInnerUnion \<Rightarrow> bool"
where
	"inv_TInnerUnion dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TInnerUnion` specification.\<close>
		(((case dummy0 of
		 TInnerUnion.U_VDMReal dummy0 \<Rightarrow> (inv_VDMReal dummy0)
		 )))"

		 
lemmas inv_TInnerUnion_defs = inv_TInnerUnion_def inv_VDMReal_def 


	
	
\<comment>\<open>VDM source: TInnerUnion' = set of (TInnerUnion)\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 23:5\<close>
type_synonym TInnerUnion' = "TInnerUnion VDMSet"
	

\<comment>\<open>VDM source: inv_TInnerUnion': (TInnerUnion' +> bool)
	inv_TInnerUnion'(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 23:5\<close>
definition
	inv_TInnerUnion' :: "TInnerUnion' \<Rightarrow> bool"
where
	"inv_TInnerUnion' dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_TInnerUnion'` specification.\<close>
		(((inv_VDMSet' ((inv_TInnerUnion )) dummy0)))"

		 
lemmas inv_TInnerUnion'_defs = inv_TInnerUnion_def inv_TInnerUnion'_def inv_VDMReal_def inv_VDMSet'_def inv_VDMSet'_defs 


	
	
\<comment>\<open>VDM source: E = compose E of e:set of (int) end
	inv mk_E({i, j, k}) == ((i < j) and (j < k))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 26:5\<close>
record E = 
	e\<^sub>E :: "VDMInt VDMSet"
	

\<comment>\<open>VDM source: inv_E: (E +> bool)
	inv_E(mk_E({i, j, k})) ==
((i < j) and (j < k))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 27:9\<close>
definition
	inv_E :: "E \<Rightarrow> bool"
where
	"inv_E dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_E` specification.\<close>
		( (((inv_VDMSet' (inv_VDMInt) (e\<^sub>E dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let  = (e\<^sub>E dummy0) in 
		\<comment>\<open>User defined body of inv_E.\<close>
		((i < j) \<and> (j < k)))"

		
lemmas inv_E_defs = inv_E_def inv_VDMInt_def inv_VDMSet'_def inv_VDMSet'_defs 


	
	
\<comment>\<open>VDM source: F = compose F of f:seq of (int) end
	inv mk_F(s ^ t) == ((len s) < (len t))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 30:5\<close>
record F = 
	f\<^sub>F :: "VDMInt VDMSeq"
	

\<comment>\<open>VDM source: inv_F: (F +> bool)
	inv_F(mk_F(s ^ t)) ==
((len s) < (len t))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 31:9\<close>
definition
	inv_F :: "F \<Rightarrow> bool"
where
	"inv_F dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_F` specification.\<close>
		( (((inv_VDMSeq' (inv_VDMInt) (f\<^sub>F dummy0))) ))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let  = (f\<^sub>F dummy0) in 
		\<comment>\<open>User defined body of inv_F.\<close>
		((len s) < (len t)))"

		
lemmas inv_F_defs = inv_F_def inv_VDMInt_def inv_VDMSeq'_def inv_VDMSeq'_defs 


	
	
\<comment>\<open>VDM source: T = set of (nat)
	inv {a, b, c} == ((a < b) and (b < c))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 34:5\<close>
type_synonym T = "VDMNat VDMSet"
	

\<comment>\<open>VDM source: inv_T: (set of (nat) +> bool)
	inv_T({a, b, c}) ==
((a < b) and (b < c))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 35:9\<close>
definition
	inv_T :: "T \<Rightarrow> bool"
where
	"inv_T {a ,  b ,  c} \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_T` specification.\<close>
		(((inv_VDMSet' (inv_VDMNat) {a ,  b ,  c})))  \<and> 
		\<comment>\<open>User defined body of inv_T.\<close>
		((a < b) \<and> (b < c))"

		 
lemmas inv_T_defs = inv_T_def inv_VDMNat_def inv_VDMSet'_def inv_VDMSet'_defs 


	
	
\<comment>\<open>VDM source: R2 = compose R2 of x:nat end
	ord r1 < r2 == ((r1.x) < (r2.x))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 42:5\<close>
record R2 = 
	x\<^sub>R\<^sub>2 :: "VDMNat"
	

\<comment>\<open>VDM source: inv_R2: (R2 +> bool)
	inv_R2(dummy0) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 42:5\<close>
definition
	inv_R2 :: "R2 \<Rightarrow> bool"
where
	"inv_R2 dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `inv_R2` specification.\<close>
		( (((inv_VDMNat (x\<^sub>R\<^sub>2 dummy0))) ))"
 

\<comment>\<open>VDM source: ord_R2: (R2 * R2 +> bool)
	ord_R2(r1, r2) ==
((r1.x) < (r2.x))\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 44:9\<close>
definition
	ord_R2 :: "R2 \<Rightarrow> R2 \<Rightarrow> bool"
where
	"ord_R2 r1   r2 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `ord_R2` specification.\<close>
		(inv_R2 r1  \<and>  inv_R2 r2)  \<and> 
		\<comment>\<open>User defined body of ord_R2.\<close>
		((x\<^sub>R\<^sub>2 r1) < (x\<^sub>R\<^sub>2 r2))"
 
lemmas inv_R2_defs = inv_R2_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: vc33: (() -> seq of (nat))
	vc33() ==
[x | x:nat & (x > 10)]\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 49:5\<close>

\<comment>\<open>VDM source: pre_vc33: (() +> bool)
	pre_vc33() ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 49:5\<close>
definition
	pre_vc33 :: "bool"
where
	"pre_vc33  \<equiv> True"


\<comment>\<open>VDM source: post_vc33: (seq of (nat) +> bool)
	post_vc33(RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 49:5\<close>
definition
	post_vc33 :: "VDMNat VDMSeq \<Rightarrow> bool"
where
	"post_vc33 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_vc33` specification.\<close>
		((inv_VDMSeq' (inv_VDMNat) RESULT))"

definition
	vc33 :: "VDMNat VDMSeq"
where
	"vc33  \<equiv> 
	\<comment>\<open>User defined body of vc33.\<close>
	[ x . \<comment>\<open>Type bound sequence compression is not supported in Isabelle.\<close>  (((inv_VDMNat x))) , (x > (10::VDMNat1)) ]"

	
	
\<comment>\<open>VDM source: f1: (int -> (<ERROR> | bool))
	f1(x) ==
(if (x > 10)
then <ERROR>
else false)\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 53:5\<close>

\<comment>\<open>VDM source: pre_f1: (int +> bool)
	pre_f1(x) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 53:5\<close>
definition
	pre_f1 :: "VDMInt \<Rightarrow> bool"
where
	"pre_f1 x \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f1` specification.\<close>
		((inv_VDMInt x))"


\<comment>\<open>VDM source: post_f1: (int * (<ERROR> | bool) +> bool)
	post_f1(x, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 53:5\<close>
definition
	post_f1 :: "VDMInt \<Rightarrow> U_ERROR  | 
		 U_bool "bool" \<Rightarrow> bool"
where
	"post_f1 x   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f1` specification.\<close>
		((inv_VDMInt x)  \<and>  (case RESULT of U_ERROR  \<Rightarrow> (inv_True RESULT)
		  | U_bool RESULT \<Rightarrow> (inv_bool RESULT)
		 ))"

definition
	f1 :: "VDMInt \<Rightarrow> U_ERROR  | 
		 U_bool "bool""
where
	"f1 x \<equiv> 
	\<comment>\<open>User defined body of f1.\<close>
	(
		if ((x > (10::VDMNat1))) then
		(U_ERROR )
		else
		((False::\<bool>)))"

	
	
\<comment>\<open>VDM source: f1': (int -> <ERROR>)
	f1'(-) ==
<ERROR>\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 57:5\<close>

\<comment>\<open>VDM source: pre_f1': (int +> bool)
	pre_f1'(-) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 57:5\<close>
definition
	pre_f1' :: "VDMInt \<Rightarrow> bool"
where
	"pre_f1' dummy0_ignore \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_f1'` specification.\<close>
		((inv_VDMInt dummy0_ignore))"


\<comment>\<open>VDM source: post_f1': (int * <ERROR> +> bool)
	post_f1'(-, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 57:5\<close>
definition
	post_f1' :: "VDMInt \<Rightarrow> U_ERROR  \<Rightarrow> bool"
where
	"post_f1' dummy0_ignore   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_f1'` specification.\<close>
		((inv_VDMInt dummy0_ignore)  \<and>  (inv_True RESULT))"

definition
	f1' :: "VDMInt \<Rightarrow> U_ERROR "
where
	"f1' dummy0_ignore \<equiv> 
	\<comment>\<open>User defined body of f1'.\<close>
	U_ERROR "

	
	
\<comment>\<open>VDM source: rcomp: (R2 * R2 -> bool)
	rcomp(r0, r1) ==
(r0 >= r1)\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 61:5\<close>

\<comment>\<open>VDM source: pre_rcomp: (R2 * R2 +> bool)
	pre_rcomp(r0, r1) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 61:5\<close>
definition
	pre_rcomp :: "R2 \<Rightarrow> R2 \<Rightarrow> bool"
where
	"pre_rcomp r0   r1 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_rcomp` specification.\<close>
		(inv_R2 r0  \<and>  inv_R2 r1)"


\<comment>\<open>VDM source: post_rcomp: (R2 * R2 * bool +> bool)
	post_rcomp(r0, r1, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 61:5\<close>
definition
	post_rcomp :: "R2 \<Rightarrow> R2 \<Rightarrow> bool \<Rightarrow> bool"
where
	"post_rcomp r0   r1   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_rcomp` specification.\<close>
		(inv_R2 r0  \<and>  inv_R2 r1  \<and>  (inv_bool RESULT))"

definition
	rcomp :: "R2 \<Rightarrow> R2 \<Rightarrow> bool"
where
	"rcomp r0   r1 \<equiv> 
	\<comment>\<open>User defined body of rcomp.\<close>
	(r0 \<ge> r1)"

	
	
\<comment>\<open>VDM source: v65:R = mk_R(1, 2)\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 65:5\<close>
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R  v65"

	
	
	
\<comment>\<open>VDM source: v830:seq of (nat) = [x | mk_R(x, -) in set {v65} & (0 < x)]\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 70:5\<close>
abbreviation
	v830 :: "VDMNat VDMSeq"
where
	"v830 \<equiv> [ (let x = (x\<^sub>R dummy0); dummy0_ignore = (y\<^sub>R dummy0) in x) . dummy0 \<leftarrow> sorted_list_of_set ({v65}) , ((dummy0 \<in>{v65})) , (let x = (x\<^sub>R dummy0); dummy0_ignore = (y\<^sub>R dummy0) in ((0::VDMNat) < x)) ]
	\<comment>\<open>`Set bind `(dummy0 \<in> {v65})` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>{v65}\<close>}   has a VDM ord_ predicate.\<close> "

	definition
	inv_v830 :: "\<bool>"
where
	"inv_v830  \<equiv> (inv_VDMSeq' (inv_VDMNat) v830)"

	
	
	
\<comment>\<open>VDM source: v954:map (nat1) to (nat1) = {(x + y) |-> 10 | [x, y] in set {[1, 2], [3, 4], [4, 5]}}\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 74:5\<close>
abbreviation
	v954 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v954 \<equiv> (\<comment>\<open>VDM Map comprehension is translated as a lambda-term through mapCompSetBound\<close>
		mapCompSetBound 
		{(x + y)} 
		{(10::VDMNat1)} 
		(inv_VDMNat1) 
		(inv_VDMNat1) 
		(
	\<lambda> (dummy0DOMAIN :: VDMNat1)   (dummy0RANGE :: VDMNat1) .
		(if (((inv_VDMNat1 dummy0DOMAIN)))  \<and>  (((inv_VDMNat1 dummy0RANGE))) \<and> (inv_VDMNat1 (
		if ((\<exists> (dummy0DOMAIN :: VDMNat1)   (dummy0DOMAIN :: VDMNat1)  . ((((inv_VDMNat1 dummy0DOMAIN)))  \<and>  (((inv_VDMNat1 dummy0DOMAIN))) \<longrightarrow> ((dummy0DOMAIN = (x + y)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))) then
			(
		if ((\<exists> (dummy0DOMAIN :: VDMNat1)   (dummy0DOMAIN :: VDMNat1)  . ((((inv_VDMNat1 dummy0DOMAIN)))  \<and>  (((inv_VDMNat1 dummy0DOMAIN))) \<longrightarrow> ((dummy0DOMAIN = (x + y)) \<and> (True::\<bool>))))) then
		(dummy0DOMAIN)
		else
		(undefined))
		 else
			undefined
		)
		) 
		(rngcnst (10::VDMNat1)) 
		(truecnst ))"

	definition
	inv_v954 :: "\<bool>"
where
	"inv_v954  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v954)"

	
	
	
\<comment>\<open>VDM source: -:nat = 10\<close>
\<comment>\<open>in 'TestV2IErrors' (./src/test/resources/TestV2IErrors.vdmsl) at line 77:5\<close>
abbreviation
	dummy0_ignore :: "VDMNat"
where
	"dummy0_ignore \<equiv> (10::VDMNat1)"

	definition
	inv_dummy0_ignore :: "\<bool>"
where
	"inv_dummy0_ignore  \<equiv> (inv_VDMNat dummy0_ignore)"

	
end