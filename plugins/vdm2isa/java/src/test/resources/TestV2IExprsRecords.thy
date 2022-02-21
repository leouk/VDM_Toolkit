(* VDM to Isabelle Translation @2022-02-21T09:20:05.027366Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprsRecords.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprsRecords.vdmsl]
*)
theory TestV2IExprsRecords
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: R = compose R of x:nat, y:nat end
	inv r == ((r.x) < (r.y))\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 7:5\<close>
record R = 
	x\<^sub>R :: "VDMNat"
		 
		 y\<^sub>R :: "VDMNat"
	

\<comment>\<open>VDM source: inv_R: (R +> bool)
	inv_R(r) ==
((r.x) < (r.y))\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 10:9\<close>
definition
	inv_R :: "R \<Rightarrow> bool"
where
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `inv_R` specification.\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and> 
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R.\<close>
		((x\<^sub>R r) < (y\<^sub>R r))"
 
lemmas inv_R_defs = inv_R_def inv_VDMNat_def 


	
	
\<comment>\<open>VDM source: mkr: (nat -> R)
	mkr(n) ==
mk_R(n, (n + 1))\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 14:5\<close>

\<comment>\<open>VDM source: pre_mkr: (nat +> bool)
	pre_mkr(n) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 14:5\<close>
definition
	pre_mkr :: "VDMNat \<Rightarrow> bool"
where
	"pre_mkr n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_mkr` specification.\<close>
		((inv_VDMNat n))"


\<comment>\<open>VDM source: post_mkr: (nat * R +> bool)
	post_mkr(n, RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 14:5\<close>
definition
	post_mkr :: "VDMNat \<Rightarrow> R \<Rightarrow> bool"
where
	"post_mkr n   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_mkr` specification.\<close>
		((inv_VDMNat n)  \<and>  inv_R RESULT)"

definition
	mkr :: "VDMNat \<Rightarrow> R"
where
	"mkr n \<equiv> 
	\<comment>\<open>User defined body of mkr.\<close>
	\<lparr>x\<^sub>R = n, y\<^sub>R = (n + (1::VDMNat1))\<rparr>"

	
	
\<comment>\<open>VDM source: recbind: (R -> nat)
	recbind(mk_R(x, y)) ==
(x + y)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 18:5\<close>

\<comment>\<open>VDM source: pre_recbind: (R +> bool)
	pre_recbind(mk_R(x, y)) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 18:5\<close>
definition
	pre_recbind :: "R \<Rightarrow> bool"
where
	"pre_recbind dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `pre_recbind` specification.\<close>
		(inv_R dummy0)"


\<comment>\<open>VDM source: post_recbind: (R * nat +> bool)
	post_recbind(mk_R(x, y), RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 18:5\<close>
definition
	post_recbind :: "R \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_recbind dummy0   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_recbind` specification.\<close>
		(inv_R dummy0  \<and>  (inv_VDMNat RESULT))"

definition
	recbind :: "R \<Rightarrow> VDMNat"
where
	"recbind dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context conversion\<close>
	(let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
	\<comment>\<open>User defined body of recbind.\<close>
	(x + y))"

	
	
\<comment>\<open>VDM source: recbindSpec: (R -> nat)
	recbindSpec(mk_R(x, y)) ==
(x + y)
	pre (x < y)
	post ((x < RESULT) and (y < RESULT))\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 22:5\<close>

\<comment>\<open>VDM source: pre_recbindSpec: (R +> bool)
	pre_recbindSpec(mk_R(x, y)) ==
(x < y)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 25:11\<close>
definition
	pre_recbindSpec :: "R \<Rightarrow> bool"
where
	"pre_recbindSpec dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `pre_recbindSpec` specification.\<close>
		(inv_R dummy0)  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
		\<comment>\<open>User defined body of pre_recbindSpec.\<close>
		(x < y))"


\<comment>\<open>VDM source: post_recbindSpec: (R * nat +> bool)
	post_recbindSpec(mk_R(x, y), RESULT) ==
((x < RESULT) and (y < RESULT))\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 26:21\<close>
definition
	post_recbindSpec :: "R \<Rightarrow> VDMNat \<Rightarrow> bool"
where
	"post_recbindSpec dummy0   RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for  `post_recbindSpec` specification.\<close>
		(inv_R dummy0  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>Implicit pattern context conversion\<close>
		(let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
		\<comment>\<open>User defined body of post_recbindSpec.\<close>
		((x < RESULT) \<and> (y < RESULT)))"

definition
	recbindSpec :: "R \<Rightarrow> VDMNat"
where
	"recbindSpec dummy0 \<equiv> 
	\<comment>\<open>Implicit pattern context conversion\<close>
	(let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
	\<comment>\<open>User defined body of recbindSpec.\<close>
	(x + y))"

	
	
\<comment>\<open>VDM source: letbest: (() -> nat)
	letbest() ==
let mk_R(x, y):R be st (x > y) in (x + y)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 30:5\<close>

\<comment>\<open>VDM source: pre_letbest: (() +> bool)
	pre_letbest() ==
null\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 30:5\<close>
definition
	pre_letbest :: "bool"
where
	"pre_letbest  \<equiv> True"


\<comment>\<open>VDM source: post_letbest: (nat +> bool)
	post_letbest(RESULT) ==
null\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 30:5\<close>
definition
	post_letbest :: "VDMNat \<Rightarrow> bool"
where
	"post_letbest RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared `post_letbest` specification.\<close>
		((inv_VDMNat RESULT))"

definition
	letbest :: "VDMNat"
where
	"letbest  \<equiv> 
	\<comment>\<open>User defined body of letbest.\<close>
	(
		SOME (dummy0::VDMNat) .(dummy0 \<in> { (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x + y)) | (dummy0 :: R) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (( (((inv_VDMNat (x\<^sub>R dummy0))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0))) )))  \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x > y)) }))"

	
	
\<comment>\<open>VDM source: v64:(nat1 * nat1 * nat1 * nat1) = mk_(1, 2, 3, 4)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 35:5\<close>
abbreviation
	v64 :: "(VDMNat1 \<times> VDMNat1 \<times> VDMNat1 \<times> VDMNat1)"
where
	"v64 \<equiv> ((1::VDMNat1) , (2::VDMNat1) , (3::VDMNat1) , (4::VDMNat1))"

	definition
	inv_v64 :: "\<bool>"
where
	"inv_v64  \<equiv> 
		((inv_VDMNat1 (fst v64))\<and>
		 (inv_VDMNat1 (fst (snd v64)))\<and>
		 (inv_VDMNat1 (fst (snd (snd v64))))\<and>
		 (inv_VDMNat1 (snd (snd (snd v64))))
		)"

	
	
	
\<comment>\<open>VDM source: v65:R = mk_R(1, 2)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 39:6\<close>
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R v65"

	
	
	
\<comment>\<open>VDM source: v651:nat = (mk_R(1, 2).x)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 40:5\<close>
abbreviation
	v651 :: "VDMNat"
where
	"v651 \<equiv> (x\<^sub>R \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>)"

	definition
	inv_v651 :: "\<bool>"
where
	"inv_v651  \<equiv> (inv_VDMNat v651)"

	
	
	
\<comment>\<open>VDM source: v652:nat = (v65.x)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 41:5\<close>
abbreviation
	v652 :: "VDMNat"
where
	"v652 \<equiv> (x\<^sub>R v65)"

	definition
	inv_v652 :: "\<bool>"
where
	"inv_v652  \<equiv> (inv_VDMNat v652)"

	
	
	
\<comment>\<open>VDM source: v653:nat = (mkr(1).x)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 42:5\<close>
abbreviation
	v653 :: "VDMNat"
where
	"v653 \<equiv> (x\<^sub>R (mkr (1::VDMNat1)))"

	definition
	inv_v653 :: "\<bool>"
where
	"inv_v653  \<equiv> (inv_VDMNat v653)"

	
	
	
\<comment>\<open>VDM source: v67:R = mu(v65, x |-> 10, y |-> 20)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 43:5\<close>
abbreviation
	v67 :: "R"
where
	"v67 \<equiv> (v65)\<lparr>x\<^sub>R := (10::VDMNat1), y\<^sub>R := (20::VDMNat1)\<rparr>"

	definition
	inv_v67 :: "\<bool>"
where
	"inv_v67  \<equiv> inv_R v67"

	
	
	
\<comment>\<open>VDM source: v731:R = (iota mk_R(x, y) in set {v65} & (x < y))\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 45:5\<close>
abbreviation
	v731 :: "R"
where
	"v731 \<equiv> (THE dummy0. (((dummy0 \<in>{v65})) \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y))))"

	definition
	inv_v731 :: "\<bool>"
where
	"inv_v731  \<equiv> inv_R v731"

	
	
	
\<comment>\<open>VDM source: v741:(R -> nat) = (lambda mk_R(x, y):R & (x + y))\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 46:5\<close>
abbreviation
	v741 :: "R \<Rightarrow> VDMNat"
where
	"v741 \<equiv> (
	\<lambda> (dummy0 :: R) .let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
		(if (( (((inv_VDMNat (x\<^sub>R dummy0))) \<and> 
		 ((inv_VDMNat (y\<^sub>R dummy0))) ))) \<and> (inv_VDMNat (x + y)) then
			(x + y)
		 else
			undefined
		)
		)"

	definition
	inv_v741 :: "\<bool>"
where
	"inv_v741  \<equiv> (inv_Lambda inv_R  (inv_VDMNat)v741)"

	
	
	
\<comment>\<open>VDM source: v781:bool = (forall mk_R(x, y) in set {v65} & (y < x))\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 48:5\<close>
abbreviation
	v781 :: "bool"
where
	"v781 \<equiv> (\<forall> dummy0 \<in> {v65}  . (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (y < x)))"

	definition
	inv_v781 :: "\<bool>"
where
	"inv_v781  \<equiv> (inv_bool v781)"

	
	
	
\<comment>\<open>VDM source: v791:nat = let mk_R(x, y):R = v65, var1:nat = 10 in ((var1 + x) + y)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 49:5\<close>
abbreviation
	v791 :: "VDMNat"
where
	"v791 \<equiv> (
		let 
(dummy0::R) = v65;
(dummy0::R) = v65
		;
		
(var1::VDMNat) = (10::VDMNat1)
		in
			let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
		(if (inv_R dummy0)
	 \<and> 
	((inv_VDMNat var1)) then
			((var1 + x) + y)
		 else
			undefined
		)
		)"

	definition
	inv_v791 :: "\<bool>"
where
	"inv_v791  \<equiv> (inv_VDMNat v791)"

	
	
	
\<comment>\<open>VDM source: v801:nat = let mk_R(x, y) in set {v65} be st (x < y) in (x + y)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 51:5\<close>
abbreviation
	v801 :: "VDMNat"
where
	"v801 \<equiv> (
		SOME (dummy0::VDMNat) .(dummy0 \<in> { (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x + y)) | dummy0 .  ((dummy0 \<in>{v65}))  \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y)) }))"

	definition
	inv_v801 :: "\<bool>"
where
	"inv_v801  \<equiv> (inv_VDMNat v801)"

	
	
	
\<comment>\<open>VDM source: v810:set of (nat) = {(x + y) | mk_R(x, y) in set {v65} & (y < x)}\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 52:5\<close>
abbreviation
	v810 :: "VDMNat VDMSet"
where
	"v810 \<equiv> { (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x + y)) | dummy0 .  ((dummy0 \<in>{v65}))  \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (y < x)) }"

	definition
	inv_v810 :: "\<bool>"
where
	"inv_v810  \<equiv> (inv_VDMSet' (inv_VDMNat) v810)"

	
	
	
\<comment>\<open>VDM source: v921:nat = def mk_R(x, y) = v65 in
(x + y)\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 54:5\<close>
abbreviation
	v921 :: "VDMNat"
where
	"v921 \<equiv> (
		let 
(dummy0::R) = v65;
(dummy0::R) = v65
		in
			let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (if (inv_R dummy0) then
			(x + y)
		 else
			undefined
		)
		)"

	definition
	inv_v921 :: "\<bool>"
where
	"inv_v921  \<equiv> (inv_VDMNat v921)"

	
	
	
\<comment>\<open>VDM source: v923:set of (R) = {mk_R(x, y) | mk_R(x, y) in set {v65} & (x < y)}\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 57:5\<close>
abbreviation
	v923 :: "R VDMSet"
where
	"v923 \<equiv> { (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in \<lparr>x\<^sub>R = x, y\<^sub>R = y\<rparr>) | dummy0 .  ((dummy0 \<in>{v65}))  \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y)) }"

	definition
	inv_v923 :: "\<bool>"
where
	"inv_v923  \<equiv> (inv_VDMSet' inv_R  v923)"

	
	
	
\<comment>\<open>VDM source: v924:set of (R) = {r | r in set {v65} & ((r.x) < (r.y))}\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 58:5\<close>
abbreviation
	v924 :: "R VDMSet"
where
	"v924 \<equiv> { r .   ((r \<in>{v65}))  \<and> ((x\<^sub>R r) < (y\<^sub>R r)) }"

	definition
	inv_v924 :: "\<bool>"
where
	"inv_v924  \<equiv> (inv_VDMSet' inv_R  v924)"

	
	
	
\<comment>\<open>VDM source: v925:set of (R) = {r | r in seq [v65] & ((r.x) < (r.y))}\<close>
\<comment>\<open>in 'TestV2IExprsRecords' (./src/test/resources/TestV2IExprsRecords.vdmsl) at line 59:5\<close>
abbreviation
	v925 :: "R VDMSet"
where
	"v925 \<equiv> { r .   ((r \<in>(elems [v65])))  \<and> ((x\<^sub>R r) < (y\<^sub>R r)) }"

	definition
	inv_v925 :: "\<bool>"
where
	"inv_v925  \<equiv> (inv_VDMSet' inv_R  v925)"

	
end