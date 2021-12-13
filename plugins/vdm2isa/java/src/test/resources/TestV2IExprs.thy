(* VDM to Isabelle Translation @2021-12-13T09:52:48.257519Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2IExprs.vdmsl' at line 1:8
files = [./src/test/resources/TestV2IExprs.vdmsl]
*)
theory TestV2IExprs
imports "VDMToolkit" 
begin


\<comment>\<open>VDM source: t1:bool = true\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 7:5\<close>
abbreviation
	t1 :: "bool"
where
	"t1 \<equiv> (True::\<bool>)"

	definition
	inv_t1 :: "\<bool>"
where
	"inv_t1  \<equiv> (inv_bool t1)"

	
	
\<comment>\<open>VDM source: t2:char = a\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 8:5\<close>
abbreviation
	t2 :: "VDMChar"
where
	"t2 \<equiv> (CHR ''a''::VDMChar)"

	definition
	inv_t2 :: "\<bool>"
where
	"inv_t2  \<equiv> (inv_VDMChar t2)"

	
	
\<comment>\<open>VDM source: t3:seq of (char) = "just text"\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 9:5\<close>
abbreviation
	t3 :: "VDMChar VDMSeq"
where
	"t3 \<equiv> (''just text'')"

	definition
	inv_t3 :: "\<bool>"
where
	"inv_t3  \<equiv> (inv_VDMSeq' (inv_VDMChar) t3)"

	
	
\<comment>\<open>VDM source: t4:int = 10\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 10:5\<close>
abbreviation
	t4 :: "VDMInt"
where
	"t4 \<equiv> (10::VDMNat1)"

	definition
	inv_t4 :: "\<bool>"
where
	"inv_t4  \<equiv> (inv_VDMInt t4)"

	
	
\<comment>\<open>VDM source: t5:nat = 10\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 11:5\<close>
abbreviation
	t5 :: "VDMNat"
where
	"t5 \<equiv> (10::VDMNat1)"

	definition
	inv_t5 :: "\<bool>"
where
	"inv_t5  \<equiv> (inv_VDMNat t5)"

	
	
\<comment>\<open>VDM source: t6:nat1 = 20\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 12:5\<close>
abbreviation
	t6 :: "VDMNat1"
where
	"t6 \<equiv> (20::VDMNat1)"

	definition
	inv_t6 :: "\<bool>"
where
	"inv_t6  \<equiv> (inv_VDMNat1 t6)"

	
	
\<comment>\<open>VDM source: t7:real = 4.5\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 13:5\<close>
abbreviation
	t7 :: "VDMReal"
where
	"t7 \<equiv> (4.5)"

	definition
	inv_t7 :: "\<bool>"
where
	"inv_t7  \<equiv> (inv_VDMReal t7)"

	
	
\<comment>\<open>VDM source: t8:rat = 4.5\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 14:5\<close>
abbreviation
	t8 :: "VDMRat"
where
	"t8 \<equiv> (4.5)"

	definition
	inv_t8 :: "\<bool>"
where
	"inv_t8  \<equiv> (inv_VDMRat t8)"

	
	
\<comment>\<open>VDM source: t9:set1 of (nat1) = {1, 2, 3}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 16:5\<close>
abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

	definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"

	
	
\<comment>\<open>VDM source: t10:seq1 of (nat1) = [1, 2, 3]\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 17:5\<close>
abbreviation
	t10 :: "VDMNat1 VDMSeq1"
where
	"t10 \<equiv> [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)]"

	definition
	inv_t10 :: "\<bool>"
where
	"inv_t10  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) t10)"

	
	
\<comment>\<open>VDM source: t11:set1 of (nat1) = {1, ... ,5}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 18:5\<close>
abbreviation
	t11 :: "VDMNat1 VDMSet1"
where
	"t11 \<equiv> {(1::VDMNat1)..(5::VDMNat1)}"

	definition
	inv_t11 :: "\<bool>"
where
	"inv_t11  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t11)"

	
	
\<comment>\<open>VDM source: t12:set of (set of (nat1)) = {{1, 2}, {2, 4}}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 19:5\<close>
abbreviation
	t12 :: "VDMNat1 VDMSet VDMSet"
where
	"t12 \<equiv> {{(1::VDMNat1), (2::VDMNat1)}, {(2::VDMNat1), (4::VDMNat1)}}"

	definition
	inv_t12 :: "\<bool>"
where
	"inv_t12  \<equiv> (inv_VDMSet' (inv_VDMSet' (inv_VDMNat1)) t12)"

	
	
\<comment>\<open>VDM source: t13:seq of (seq of (nat1)) = [[1, 2], [3, 4]]\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 20:5\<close>
abbreviation
	t13 :: "VDMNat1 VDMSeq VDMSeq"
where
	"t13 \<equiv> [[(1::VDMNat1), (2::VDMNat1)], [(3::VDMNat1), (4::VDMNat1)]]"

	definition
	inv_t13 :: "\<bool>"
where
	"inv_t13  \<equiv> (inv_VDMSeq' (inv_VDMSeq' (inv_VDMNat1)) t13)"

	
	
\<comment>\<open>VDM source: t14:map (nat1) to (nat1) = {1 |-> 1, 2 |-> 3}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 21:5\<close>
abbreviation
	t14 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"t14 \<equiv> [(1::VDMNat1)\<mapsto>(1::VDMNat1),(2::VDMNat1)\<mapsto>(3::VDMNat1)]"

	definition
	inv_t14 :: "\<bool>"
where
	"inv_t14  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) t14)"

	
	
\<comment>\<open>VDM source: t15:map (nat1) to (nat1) = {3 |-> 1}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 22:5\<close>
abbreviation
	t15 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"t15 \<equiv> [(3::VDMNat1)\<mapsto>(1::VDMNat1)]"

	definition
	inv_t15 :: "\<bool>"
where
	"inv_t15  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) t15)"

	
	
\<comment>\<open>VDM source: v1:nat1 = (abs 10)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 25:5\<close>
abbreviation
	v1 :: "VDMNat1"
where
	"v1 \<equiv> (vdm_abs (10::VDMNat1))"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_VDMNat1 v1)"

	
	
\<comment>\<open>VDM source: v2:int = (floor 5)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 26:5\<close>
abbreviation
	v2 :: "VDMInt"
where
	"v2 \<equiv> (vdm_floor (5::VDMNat1))"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_VDMInt v2)"

	
	
\<comment>\<open>VDM source: v3:int = (floor 4.5)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 27:5\<close>
abbreviation
	v3 :: "VDMInt"
where
	"v3 \<equiv> (vdm_floor (4.5))"

	definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_VDMInt v3)"

	
	
\<comment>\<open>VDM source: v4:int = -4\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 28:5\<close>
abbreviation
	v4 :: "VDMInt"
where
	"v4 \<equiv> (- (4::VDMNat1))"

	definition
	inv_v4 :: "\<bool>"
where
	"inv_v4  \<equiv> (inv_VDMInt v4)"

	
	
\<comment>\<open>VDM source: v5:nat1 = +5\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 29:5\<close>
abbreviation
	v5 :: "VDMNat1"
where
	"v5 \<equiv> (5::VDMNat1)"

	definition
	inv_v5 :: "\<bool>"
where
	"inv_v5  \<equiv> (inv_VDMNat1 v5)"

	
	
\<comment>\<open>VDM source: v6:nat1 = (card t9)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 30:5\<close>
abbreviation
	v6 :: "VDMNat1"
where
	"v6 \<equiv> (vdm_card t9)"

	definition
	inv_v6 :: "\<bool>"
where
	"inv_v6  \<equiv> (inv_VDMNat1 v6)"

	
	
\<comment>\<open>VDM source: v7:set of (set of (nat1)) = (power {1, 2})\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 31:5\<close>
abbreviation
	v7 :: "VDMNat1 VDMSet VDMSet"
where
	"v7 \<equiv> (Fpow {(1::VDMNat1), (2::VDMNat1)})"

	definition
	inv_v7 :: "\<bool>"
where
	"inv_v7  \<equiv> (inv_VDMSet' (inv_VDMSet' (inv_VDMNat1)) v7)"

	
	
\<comment>\<open>VDM source: v8:set of (nat1) = (dunion t12)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 32:5\<close>
abbreviation
	v8 :: "VDMNat1 VDMSet"
where
	"v8 \<equiv> (\<Union> t12)"

	definition
	inv_v8 :: "\<bool>"
where
	"inv_v8  \<equiv> (inv_VDMSet' (inv_VDMNat1) v8)"

	
	
\<comment>\<open>VDM source: v9:set of (nat1) = (dinter t12)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 33:5\<close>
abbreviation
	v9 :: "VDMNat1 VDMSet"
where
	"v9 \<equiv> (\<Inter> t12)"

	definition
	inv_v9 :: "\<bool>"
where
	"inv_v9  \<equiv> (inv_VDMSet' (inv_VDMNat1) v9)"

	
	
\<comment>\<open>VDM source: v10:nat1 = (len t10)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 34:5\<close>
abbreviation
	v10 :: "VDMNat1"
where
	"v10 \<equiv> (len t10)"

	definition
	inv_v10 :: "\<bool>"
where
	"inv_v10  \<equiv> (inv_VDMNat1 v10)"

	
	
\<comment>\<open>VDM source: v11:nat1 = (hd t10)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 35:5\<close>
abbreviation
	v11 :: "VDMNat1"
where
	"v11 \<equiv> (hd t10)"

	definition
	inv_v11 :: "\<bool>"
where
	"inv_v11  \<equiv> (inv_VDMNat1 v11)"

	
	
\<comment>\<open>VDM source: v12:seq of (nat1) = (tl t10)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 36:5\<close>
abbreviation
	v12 :: "VDMNat1 VDMSeq"
where
	"v12 \<equiv> (tl t10)"

	definition
	inv_v12 :: "\<bool>"
where
	"inv_v12  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v12)"

	
	
\<comment>\<open>VDM source: v13:set of (nat1) = (inds t10)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 37:5\<close>
abbreviation
	v13 :: "VDMNat1 VDMSet"
where
	"v13 \<equiv> (inds t10)"

	definition
	inv_v13 :: "\<bool>"
where
	"inv_v13  \<equiv> (inv_VDMSet' (inv_VDMNat1) v13)"

	
	
\<comment>\<open>VDM source: v14:set of (nat1) = (elems t10)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 38:5\<close>
abbreviation
	v14 :: "VDMNat1 VDMSet"
where
	"v14 \<equiv> (elems t10)"

	definition
	inv_v14 :: "\<bool>"
where
	"inv_v14  \<equiv> (inv_VDMSet' (inv_VDMNat1) v14)"

	
	
\<comment>\<open>VDM source: v15:seq of (nat1) = (conc t13)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 39:5\<close>
abbreviation
	v15 :: "VDMNat1 VDMSeq"
where
	"v15 \<equiv> (conc t13)"

	definition
	inv_v15 :: "\<bool>"
where
	"inv_v15  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v15)"

	
	
\<comment>\<open>VDM source: v16:seq1 of (nat1) = (reverse t10)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 40:5\<close>
abbreviation
	v16 :: "VDMNat1 VDMSeq1"
where
	"v16 \<equiv> (vdm_reverse t10)"

	definition
	inv_v16 :: "\<bool>"
where
	"inv_v16  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v16)"

	
	
\<comment>\<open>VDM source: v17:seq1 of (nat1) = (t10 ^ t10)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 41:5\<close>
abbreviation
	v17 :: "VDMNat1 VDMSeq1"
where
	"v17 \<equiv> (t10 @ t10)"

	definition
	inv_v17 :: "\<bool>"
where
	"inv_v17  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v17)"

	
	
\<comment>\<open>VDM source: v18:seq of (nat1) = (t10(2, ... ,3))\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 42:5\<close>
abbreviation
	v18 :: "VDMNat1 VDMSeq"
where
	"v18 \<equiv> (t10 {(2::VDMNat1)$$(3::VDMNat1)})"

	definition
	inv_v18 :: "\<bool>"
where
	"inv_v18  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v18)"

	
	
\<comment>\<open>VDM source: v19:map (nat1) to (nat1) = (merge {t14, t15})\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 43:5\<close>
abbreviation
	v19 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v19 \<equiv> (vdm_merge {t14, t15})"

	definition
	inv_v19 :: "\<bool>"
where
	"inv_v19  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v19)"

	
	
\<comment>\<open>VDM source: v20:set of (nat1) = (dom t14)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 44:5\<close>
abbreviation
	v20 :: "VDMNat1 VDMSet"
where
	"v20 \<equiv> (dom t14)"

	definition
	inv_v20 :: "\<bool>"
where
	"inv_v20  \<equiv> (inv_VDMSet' (inv_VDMNat1) v20)"

	
	
\<comment>\<open>VDM source: v21:set of (nat1) = (rng t14)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 45:5\<close>
abbreviation
	v21 :: "VDMNat1 VDMSet"
where
	"v21 \<equiv> (rng t14)"

	definition
	inv_v21 :: "\<bool>"
where
	"inv_v21  \<equiv> (inv_VDMSet' (inv_VDMNat1) v21)"

	
	
\<comment>\<open>VDM source: v22:map (nat1) to (nat1) = (inverse t14)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 46:5\<close>
abbreviation
	v22 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v22 \<equiv> (vdm_inverse t14)"

	definition
	inv_v22 :: "\<bool>"
where
	"inv_v22  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v22)"

	
	
\<comment>\<open>VDM source: v23:nat1 = (4 + 3)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 47:5\<close>
abbreviation
	v23 :: "VDMNat1"
where
	"v23 \<equiv> ((4::VDMNat1) + (3::VDMNat1))"

	definition
	inv_v23 :: "\<bool>"
where
	"inv_v23  \<equiv> (inv_VDMNat1 v23)"

	
	
\<comment>\<open>VDM source: v24:int = (4 - 2)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 48:5\<close>
abbreviation
	v24 :: "VDMInt"
where
	"v24 \<equiv> ((4::VDMNat1) - (2::VDMNat1))"

	definition
	inv_v24 :: "\<bool>"
where
	"inv_v24  \<equiv> (inv_VDMInt v24)"

	
	
\<comment>\<open>VDM source: v25:nat1 = (4 * 2)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 49:5\<close>
abbreviation
	v25 :: "VDMNat1"
where
	"v25 \<equiv> ((4::VDMNat1) * (2::VDMNat1))"

	definition
	inv_v25 :: "\<bool>"
where
	"inv_v25  \<equiv> (inv_VDMNat1 v25)"

	
	
\<comment>\<open>VDM source: v26:int = (4 div 2)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 50:5\<close>
abbreviation
	v26 :: "VDMInt"
where
	"v26 \<equiv> ((4::VDMNat1) vdmdiv (2::VDMNat1))"

	definition
	inv_v26 :: "\<bool>"
where
	"inv_v26  \<equiv> (inv_VDMInt v26)"

	
	
\<comment>\<open>VDM source: v27:real = (4 / 2)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 51:5\<close>
abbreviation
	v27 :: "VDMReal"
where
	"v27 \<equiv> ((4::VDMNat1) / (2::VDMNat1))"

	definition
	inv_v27 :: "\<bool>"
where
	"inv_v27  \<equiv> (inv_VDMReal v27)"

	
	
\<comment>\<open>VDM source: v28:int = (4 mod 3)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 52:5\<close>
abbreviation
	v28 :: "VDMInt"
where
	"v28 \<equiv> ((4::VDMNat1) vdmmod (3::VDMNat1))"

	definition
	inv_v28 :: "\<bool>"
where
	"inv_v28  \<equiv> (inv_VDMInt v28)"

	
	
\<comment>\<open>VDM source: v29:int = (4 rem 3)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 53:5\<close>
abbreviation
	v29 :: "VDMInt"
where
	"v29 \<equiv> ((4::VDMNat1) vdmrem (3::VDMNat1))"

	definition
	inv_v29 :: "\<bool>"
where
	"inv_v29  \<equiv> (inv_VDMInt v29)"

	
	
\<comment>\<open>VDM source: v30:nat1 = (2 ** 3)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 54:5\<close>
abbreviation
	v30 :: "VDMNat1"
where
	"v30 \<equiv> ((2::VDMNat1) ^ nat (3::VDMNat1))
	\<comment>\<open>Result of the power operator is context dependenant on second argument type being nat or real.\<close>
	"

	definition
	inv_v30 :: "\<bool>"
where
	"inv_v30  \<equiv> (inv_VDMNat1 v30)"

	
	
\<comment>\<open>VDM source: v31:bool = (3 = 3)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 55:5\<close>
abbreviation
	v31 :: "bool"
where
	"v31 \<equiv> ((3::VDMNat1) = (3::VDMNat1))"

	definition
	inv_v31 :: "\<bool>"
where
	"inv_v31  \<equiv> (inv_bool v31)"

	
	
\<comment>\<open>VDM source: v32:bool = (3 <> 4)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 56:5\<close>
abbreviation
	v32 :: "bool"
where
	"v32 \<equiv> ((3::VDMNat1) \<noteq> (4::VDMNat1))"

	definition
	inv_v32 :: "\<bool>"
where
	"inv_v32  \<equiv> (inv_bool v32)"

	
	
\<comment>\<open>VDM source: v33:bool = (4 <= 5)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 57:5\<close>
abbreviation
	v33 :: "bool"
where
	"v33 \<equiv> ((4::VDMNat1) \<le> (5::VDMNat1))"

	definition
	inv_v33 :: "\<bool>"
where
	"inv_v33  \<equiv> (inv_bool v33)"

	
	
\<comment>\<open>VDM source: v34:bool = (4 < 5)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 58:5\<close>
abbreviation
	v34 :: "bool"
where
	"v34 \<equiv> ((4::VDMNat1) < (5::VDMNat1))"

	definition
	inv_v34 :: "\<bool>"
where
	"inv_v34  \<equiv> (inv_bool v34)"

	
	
\<comment>\<open>VDM source: v35:bool = (5 >= 4)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 59:5\<close>
abbreviation
	v35 :: "bool"
where
	"v35 \<equiv> ((5::VDMNat1) \<ge> (4::VDMNat1))"

	definition
	inv_v35 :: "\<bool>"
where
	"inv_v35  \<equiv> (inv_bool v35)"

	
	
\<comment>\<open>VDM source: v36:bool = (5 > 4)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 60:5\<close>
abbreviation
	v36 :: "bool"
where
	"v36 \<equiv> ((5::VDMNat1) > (4::VDMNat1))"

	definition
	inv_v36 :: "\<bool>"
where
	"inv_v36  \<equiv> (inv_bool v36)"

	
	
\<comment>\<open>VDM source: v39:map (nat1) to (nat1) = (t14 ++ t15)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 61:5\<close>
abbreviation
	v39 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v39 \<equiv> (t14 \<dagger> t15)"

	definition
	inv_v39 :: "\<bool>"
where
	"inv_v39  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v39)"

	
	
\<comment>\<open>VDM source: v40:map (nat1) to (nat1) = (t9 <: t14)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 62:5\<close>
abbreviation
	v40 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v40 \<equiv> (t9 \<triangleleft> t14)"

	definition
	inv_v40 :: "\<bool>"
where
	"inv_v40  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v40)"

	
	
\<comment>\<open>VDM source: v41:map (nat1) to (nat1) = (t9 <-: t14)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 63:5\<close>
abbreviation
	v41 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v41 \<equiv> (t9 -\<triangleleft> t14)"

	definition
	inv_v41 :: "\<bool>"
where
	"inv_v41  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v41)"

	
	
\<comment>\<open>VDM source: v42:map (nat1) to (nat1) = (t14 :> t9)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 64:5\<close>
abbreviation
	v42 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v42 \<equiv> (t14 \<triangleright> t9)"

	definition
	inv_v42 :: "\<bool>"
where
	"inv_v42  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v42)"

	
	
\<comment>\<open>VDM source: v43:map (nat1) to (nat1) = (t14 :-> t9)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 65:5\<close>
abbreviation
	v43 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v43 \<equiv> (t14 \<triangleright>- t9)"

	definition
	inv_v43 :: "\<bool>"
where
	"inv_v43  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v43)"

	
	
\<comment>\<open>VDM source: v44:map (nat1) to (nat1) = (t14 munion t15)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 66:5\<close>
abbreviation
	v44 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v44 \<equiv> (t14 \<union>m t15)"

	definition
	inv_v44 :: "\<bool>"
where
	"inv_v44  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v44)"

	
	
\<comment>\<open>VDM source: v45:map (nat1) to (nat1) = (t14 comp t15)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 67:5\<close>
abbreviation
	v45 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v45 \<equiv> (t14 \<circ>m t15)"

	definition
	inv_v45 :: "\<bool>"
where
	"inv_v45  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v45)"

	
	
\<comment>\<open>VDM source: v46:bool = (not t1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 68:5\<close>
abbreviation
	v46 :: "bool"
where
	"v46 \<equiv> (\<not> t1)"

	definition
	inv_v46 :: "\<bool>"
where
	"inv_v46  \<equiv> (inv_bool v46)"

	
	
\<comment>\<open>VDM source: v47:bool = (t1 and t1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 69:5\<close>
abbreviation
	v47 :: "bool"
where
	"v47 \<equiv> (t1 \<and> t1)"

	definition
	inv_v47 :: "\<bool>"
where
	"inv_v47  \<equiv> (inv_bool v47)"

	
	
\<comment>\<open>VDM source: v48:bool = (t1 or t1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 70:5\<close>
abbreviation
	v48 :: "bool"
where
	"v48 \<equiv> (t1 \<or> t1)"

	definition
	inv_v48 :: "\<bool>"
where
	"inv_v48  \<equiv> (inv_bool v48)"

	
	
\<comment>\<open>VDM source: v49:bool = (t1 => t1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 71:5\<close>
abbreviation
	v49 :: "bool"
where
	"v49 \<equiv> (t1 \<longrightarrow> t1)"

	definition
	inv_v49 :: "\<bool>"
where
	"inv_v49  \<equiv> (inv_bool v49)"

	
	
\<comment>\<open>VDM source: v50:bool = (t1 <=> t1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 72:5\<close>
abbreviation
	v50 :: "bool"
where
	"v50 \<equiv> (t1 \<longleftrightarrow> t1)"

	definition
	inv_v50 :: "\<bool>"
where
	"inv_v50  \<equiv> (inv_bool v50)"

	
	
\<comment>\<open>VDM source: v51:bool = (1 in set t9)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 73:5\<close>
abbreviation
	v51 :: "bool"
where
	"v51 \<equiv> ((1::VDMNat1) \<in> t9)"

	definition
	inv_v51 :: "\<bool>"
where
	"inv_v51  \<equiv> (inv_bool v51)"

	
	
\<comment>\<open>VDM source: v52:bool = (5 not in set t9)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 74:5\<close>
abbreviation
	v52 :: "bool"
where
	"v52 \<equiv> ((5::VDMNat1) \<notin> t9)"

	definition
	inv_v52 :: "\<bool>"
where
	"inv_v52  \<equiv> (inv_bool v52)"

	
	
\<comment>\<open>VDM source: v53:set of (nat) = (t9 union t11)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 75:5\<close>
abbreviation
	v53 :: "VDMNat VDMSet"
where
	"v53 \<equiv> (t9 \<union> t11)"

	definition
	inv_v53 :: "\<bool>"
where
	"inv_v53  \<equiv> (inv_VDMSet' (inv_VDMNat) v53)"

	
	
\<comment>\<open>VDM source: v54:set of (nat) = (t9 inter t11)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 76:5\<close>
abbreviation
	v54 :: "VDMNat VDMSet"
where
	"v54 \<equiv> (t9 \<inter> t11)"

	definition
	inv_v54 :: "\<bool>"
where
	"inv_v54  \<equiv> (inv_VDMSet' (inv_VDMNat) v54)"

	
	
\<comment>\<open>VDM source: v55:set of (nat) = (t9 \ t11)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 77:5\<close>
abbreviation
	v55 :: "VDMNat VDMSet"
where
	"v55 \<equiv> (t9 - t11)"

	definition
	inv_v55 :: "\<bool>"
where
	"inv_v55  \<equiv> (inv_VDMSet' (inv_VDMNat) v55)"

	
	
\<comment>\<open>VDM source: v56:bool = (t9 subset t11)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 78:5\<close>
abbreviation
	v56 :: "bool"
where
	"v56 \<equiv> (t9 \<subseteq> t11)"

	definition
	inv_v56 :: "\<bool>"
where
	"inv_v56  \<equiv> (inv_bool v56)"

	
	
\<comment>\<open>VDM source: v57:bool = (t9 psubset t11)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 79:5\<close>
abbreviation
	v57 :: "bool"
where
	"v57 \<equiv> (t9 \<subset> t11)"

	definition
	inv_v57 :: "\<bool>"
where
	"inv_v57  \<equiv> (inv_bool v57)"

	
	
\<comment>\<open>VDM source: v58:set of (nat1) = {1, ... ,3}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 80:5\<close>
abbreviation
	v58 :: "VDMNat1 VDMSet"
where
	"v58 \<equiv> {(1::VDMNat1)..(3::VDMNat1)}"

	definition
	inv_v58 :: "\<bool>"
where
	"inv_v58  \<equiv> (inv_VDMSet' (inv_VDMNat1) v58)"

	
	
\<comment>\<open>VDM source: v59:set1 of (nat1) = {1, 2, 3, 4}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 81:5\<close>
abbreviation
	v59 :: "VDMNat1 VDMSet1"
where
	"v59 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}"

	definition
	inv_v59 :: "\<bool>"
where
	"inv_v59  \<equiv> (inv_VDMSet1' (inv_VDMNat1) v59)"

	
	
\<comment>\<open>VDM source: v60:seq1 of (nat1) = [1, 3, 4]\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 82:5\<close>
abbreviation
	v60 :: "VDMNat1 VDMSeq1"
where
	"v60 \<equiv> [(1::VDMNat1), (3::VDMNat1), (4::VDMNat1)]"

	definition
	inv_v60 :: "\<bool>"
where
	"inv_v60  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v60)"

	
	
\<comment>\<open>VDM source: v61:map (nat1) to (nat1) = {1 |-> 2, 2 |-> 3}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 83:5\<close>
abbreviation
	v61 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v61 \<equiv> [(1::VDMNat1)\<mapsto>(2::VDMNat1),(2::VDMNat1)\<mapsto>(3::VDMNat1)]"

	definition
	inv_v61 :: "\<bool>"
where
	"inv_v61  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v61)"

	
	
\<comment>\<open>VDM source: v62:(nat1 * nat1) = mk_(1, 2)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 84:5\<close>
abbreviation
	v62 :: "(VDMNat1\<times> VDMNat1)"
where
	"v62 \<equiv> ((1::VDMNat1), (2::VDMNat1))"

	definition
	inv_v62 :: "\<bool>"
where
	"inv_v62  \<equiv> 
		((inv_VDMNat1 (fst v62))\<and>
		 (inv_VDMNat1 (snd v62))
		)"

	
	
\<comment>\<open>VDM source: v63:(nat1 * nat1 * nat1) = mk_(1, 2, 3)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 85:5\<close>
abbreviation
	v63 :: "(VDMNat1\<times> VDMNat1\<times> VDMNat1)"
where
	"v63 \<equiv> ((1::VDMNat1), (2::VDMNat1), (3::VDMNat1))"

	definition
	inv_v63 :: "\<bool>"
where
	"inv_v63  \<equiv> 
		((inv_VDMNat1 (fst v63))\<and>
		 (inv_VDMNat1 (fst (snd v63)))\<and>
		 (inv_VDMNat1 (snd (snd v63)))
		)"

	
	
\<comment>\<open>VDM source: v64:(nat1 * nat1 * nat1 * nat1) = mk_(1, 2, 3, 4)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 86:5\<close>
abbreviation
	v64 :: "(VDMNat1\<times> VDMNat1\<times> VDMNat1\<times> VDMNat1)"
where
	"v64 \<equiv> ((1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1))"

	definition
	inv_v64 :: "\<bool>"
where
	"inv_v64  \<equiv> 
		((inv_VDMNat1 (fst v64))\<and>
		 (inv_VDMNat1 (fst (snd v64)))\<and>
		 (inv_VDMNat1 (fst (snd (snd v64))))\<and>
		 (inv_VDMNat1 (snd (snd (snd v64))))
		)"

	
	
\<comment>\<open>VDM source: v68:nat1 = (v64.#1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 87:5\<close>
abbreviation
	v68 :: "VDMNat1"
where
	"v68 \<equiv> (fst (v64))"

	definition
	inv_v68 :: "\<bool>"
where
	"inv_v68  \<equiv> (inv_VDMNat1 v68)"

	
	
\<comment>\<open>VDM source: v69:nat1 = (v64.#2)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 88:5\<close>
abbreviation
	v69 :: "VDMNat1"
where
	"v69 \<equiv> (fst (snd (v64)))"

	definition
	inv_v69 :: "\<bool>"
where
	"inv_v69  \<equiv> (inv_VDMNat1 v69)"

	
	
\<comment>\<open>VDM source: v70:nat1 = (v64.#3)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 89:5\<close>
abbreviation
	v70 :: "VDMNat1"
where
	"v70 \<equiv> (fst (snd (snd (v64))))"

	definition
	inv_v70 :: "\<bool>"
where
	"inv_v70  \<equiv> (inv_VDMNat1 v70)"

	
	
\<comment>\<open>VDM source: v71:nat1 = (v64.#4)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 90:5\<close>
abbreviation
	v71 :: "VDMNat1"
where
	"v71 \<equiv> (snd (snd (snd (v64))))"

	definition
	inv_v71 :: "\<bool>"
where
	"inv_v71  \<equiv> (inv_VDMNat1 v71)"

	
	
\<comment>\<open>VDM source: v72:nat1 = narrow_(4.0, nat1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 92:5\<close>
abbreviation
	v72 :: "VDMNat1"
where
	"v72 \<equiv> vdm_narrow_real (((4.0))::VDMReal)"

	definition
	inv_v72 :: "\<bool>"
where
	"inv_v72  \<equiv> (inv_VDMNat1 v72)"

	
	
\<comment>\<open>VDM source: v721:int = narrow_(4.0, int)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 93:5\<close>
abbreviation
	v721 :: "VDMInt"
where
	"v721 \<equiv> vdm_narrow_real (((4.0))::VDMReal)"

	definition
	inv_v721 :: "\<bool>"
where
	"inv_v721  \<equiv> (inv_VDMInt v721)"

	
	
\<comment>\<open>VDM source: v722:nat1 = let r:real = 4.0 in narrow_(r, nat1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 94:5\<close>
abbreviation
	v722 :: "VDMNat1"
where
	"v722 \<equiv> (
		let 
(r::VDMReal) = (4.0)
		in
			(if ((inv_VDMReal r)) then
			vdm_narrow_real ((r)::VDMReal)
		 else
			undefined
		)
		)"

	definition
	inv_v722 :: "\<bool>"
where
	"inv_v722  \<equiv> (inv_VDMNat1 v722)"

	
	
\<comment>\<open>VDM source: v723:nat1 = narrow_((6 / 2), nat1)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 95:5\<close>
abbreviation
	v723 :: "VDMNat1"
where
	"v723 \<equiv> vdm_narrow_real ((((6::VDMNat1) / (2::VDMNat1)))::VDMReal)"

	definition
	inv_v723 :: "\<bool>"
where
	"inv_v723  \<equiv> (inv_VDMNat1 v723)"

	
	
\<comment>\<open>VDM source: v73:nat1 = (iota var in set t9 & (var < 2))\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 96:5\<close>
abbreviation
	v73 :: "VDMNat1"
where
	"v73 \<equiv> (THE var. (((var \<in>t9)) \<and> (var < (2::VDMNat1))))"

	definition
	inv_v73 :: "\<bool>"
where
	"inv_v73  \<equiv> (inv_VDMNat1 v73)"

	
	
\<comment>\<open>VDM source: v74:(nat * nat1 -> nat1) = (lambda var:nat, var2:nat1 & (var + var2))\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 97:5\<close>
abbreviation
	v74 :: "VDMNat\<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1"
where
	"v74 \<equiv> (
	\<lambda> (var :: VDMNat)  (var2 :: VDMNat1) .
		(if (((inv_VDMNat var))) \<and>  (((inv_VDMNat1 var2))) \<and> (inv_VDMNat1 (var + var2)) then
		(var + var2)
	 else
		undefined
	)
	)"

	definition
	inv_v74 :: "\<bool>"
where
	"inv_v74  \<equiv> (inv_Lambda (inv_VDMNat) (inv_Lambda (inv_VDMNat1) (inv_VDMNat1))v74)"

	
	
\<comment>\<open>VDM source: v741:(nat * nat1 * real -> real) = (lambda var:nat, var2:nat1, var3:real & ((var + var2) + var3))\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 98:5\<close>
abbreviation
	v741 :: "VDMNat\<Rightarrow> VDMNat1\<Rightarrow> VDMReal \<Rightarrow> VDMReal"
where
	"v741 \<equiv> (
	\<lambda> (var :: VDMNat)  (var2 :: VDMNat1)  (var3 :: VDMReal) .
		(if (((inv_VDMNat var))) \<and>  (((inv_VDMNat1 var2))) \<and>  (((inv_VDMReal var3))) \<and> (inv_VDMReal ((var + var2) + var3)) then
		((var + var2) + var3)
	 else
		undefined
	)
	)"

	definition
	inv_v741 :: "\<bool>"
where
	"inv_v741  \<equiv> (inv_Lambda (inv_VDMNat) (inv_Lambda (inv_VDMNat1) (inv_Lambda (inv_VDMReal) (inv_VDMReal)))v741)"

	
	
\<comment>\<open>VDM source: v75:bool = (exists1 var in set t9 & (var < 2))\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 99:5\<close>
abbreviation
	v75 :: "bool"
where
	"v75 \<equiv> (\<exists>! var \<in> t9  . (var < (2::VDMNat1)))"

	definition
	inv_v75 :: "\<bool>"
where
	"inv_v75  \<equiv> (inv_bool v75)"

	
	
\<comment>\<open>VDM source: v76:bool = (exists [var in set t9] & (var < 2))\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 100:5\<close>
abbreviation
	v76 :: "bool"
where
	"v76 \<equiv> (\<exists> var \<in> t9  . (var < (2::VDMNat1)))"

	definition
	inv_v76 :: "\<bool>"
where
	"inv_v76  \<equiv> (inv_bool v76)"

	
	
\<comment>\<open>VDM source: v78:bool = (forall var in set t9 & (var <= 3))\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 101:5\<close>
abbreviation
	v78 :: "bool"
where
	"v78 \<equiv> (\<forall> var \<in> t9  . (var \<le> (3::VDMNat1)))"

	definition
	inv_v78 :: "\<bool>"
where
	"inv_v78  \<equiv> (inv_bool v78)"

	
	
\<comment>\<open>VDM source: v79:nat1 = let var:nat = 10, var2:nat1 = 20 in (var + var2)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 102:5\<close>
abbreviation
	v79 :: "VDMNat1"
where
	"v79 \<equiv> (
		let 
(var::VDMNat) = (10::VDMNat1);
		
(var2::VDMNat1) = (20::VDMNat1)
		in
			(if ((inv_VDMNat var)) \<and> 
	((inv_VDMNat1 var2)) then
			(var + var2)
		 else
			undefined
		)
		)"

	definition
	inv_v79 :: "\<bool>"
where
	"inv_v79  \<equiv> (inv_VDMNat1 v79)"

	
	
\<comment>\<open>VDM source: v80:nat1 = let x, y in set t9 be st ((x > 2) and (y < x)) in (x + y)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 103:5\<close>
abbreviation
	v80 :: "VDMNat1"
where
	"v80 \<equiv> (
		SOME (dummy0::VDMNat1) .(dummy0 \<in> { (x + y) | xy .  ((x \<in>t9)) \<and>  ((y \<in>t9))  \<and> ((x > (2::VDMNat1)) \<and> (y < x)) }))"

	definition
	inv_v80 :: "\<bool>"
where
	"inv_v80  \<equiv> (inv_VDMNat1 v80)"

	
	
\<comment>\<open>VDM source: v81:set of (nat1) = {var | var in set t9 & (var > 1)}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 104:5\<close>
abbreviation
	v81 :: "VDMNat1 VDMSet"
where
	"v81 \<equiv> { var .   ((var \<in>t9))  \<and> (var > (1::VDMNat1)) }"

	definition
	inv_v81 :: "\<bool>"
where
	"inv_v81  \<equiv> (inv_VDMSet' (inv_VDMNat1) v81)"

	
	
\<comment>\<open>VDM source: v82:set of (nat1) = {(var + var2) | var in set t9, var2 in seq t10 & (var > var2)}\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 105:5\<close>
abbreviation
	v82 :: "VDMNat1 VDMSet"
where
	"v82 \<equiv> { (var + var2) | var  var2 .  ((var \<in>t9)) \<and>  ((var2 \<in>(elems t10)))  \<and> (var > var2) }"

	definition
	inv_v82 :: "\<bool>"
where
	"inv_v82  \<equiv> (inv_VDMSet' (inv_VDMNat1) v82)"

	
	
\<comment>\<open>VDM source: v83:seq of (nat1) = [var | var in set t9 & (var > 1)]\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 106:5\<close>
abbreviation
	v83 :: "VDMNat1 VDMSeq"
where
	"v83 \<equiv> [ var . var \<leftarrow> sorted_list_of_set (t9) , ((var \<in>t9)) , (var > (1::VDMNat1)) ]
	\<comment>\<open>`Set bind `(var \<in> t9)` in sequence comprehension requires its Isabelle type to instantiate class linorder.`   This can be a problem if the target type of @{term \<open>t9\<close>}   has a VDM ord_ predicate.\<close> "

	definition
	inv_v83 :: "\<bool>"
where
	"inv_v83  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v83)"

	
	
\<comment>\<open>VDM source: v84:seq of (nat1) = [var | var in seq t10 & (var > 1)]\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 107:5\<close>
abbreviation
	v84 :: "VDMNat1 VDMSeq"
where
	"v84 \<equiv> [ var . var \<leftarrow> t10 , ((var \<in>(elems t10))) , (var > (1::VDMNat1)) ]"

	definition
	inv_v84 :: "\<bool>"
where
	"inv_v84  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v84)"

	
	
\<comment>\<open>VDM source: v88:seq of (nat1) = [var | var in seq [1, 2, 3, 7, 8, 9] & (var > 4)]\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 111:5\<close>
abbreviation
	v88 :: "VDMNat1 VDMSeq"
where
	"v88 \<equiv> [ var . var \<leftarrow> [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (7::VDMNat1), (8::VDMNat1), (9::VDMNat1)] , ((var \<in>(elems [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (7::VDMNat1), (8::VDMNat1), (9::VDMNat1)]))) , (var > (4::VDMNat1)) ]"

	definition
	inv_v88 :: "\<bool>"
where
	"inv_v88  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v88)"

	
	
\<comment>\<open>VDM source: v89:int = (if (v1 > v2)
then v1
else v2)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 112:5\<close>
abbreviation
	v89 :: "VDMInt"
where
	"v89 \<equiv> (
		if ((v1 > v2)) then
		(v1)
		else
		(v2))"

	definition
	inv_v89 :: "\<bool>"
where
	"inv_v89  \<equiv> (inv_VDMInt v89)"

	
	
\<comment>\<open>VDM source: v90:int = (if (v1 > v2)
then v1
else (if (v1 < v2)
then v2
else 0))\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 113:5\<close>
abbreviation
	v90 :: "VDMInt"
where
	"v90 \<equiv> (
		if ((v1 > v2)) then
		(v1)
		else
		((
		if ((v1 < v2)) then
		(v2)
		else
		((0::VDMNat)))))"

	definition
	inv_v90 :: "\<bool>"
where
	"inv_v90  \<equiv> (inv_VDMInt v90)"

	
	
\<comment>\<open>VDM source: v92:nat = def var:nat = 10 in
(var + var)\<close>
\<comment>\<open>in 'TestV2IExprs' (./src/test/resources/TestV2IExprs.vdmsl) at line 115:5\<close>
abbreviation
	v92 :: "VDMNat"
where
	"v92 \<equiv> (
		let 
(var::VDMNat) = (10::VDMNat1)
		in
			(if ((inv_VDMNat var)) then
			(var + var)
		 else
			undefined
		)
		)"

	definition
	inv_v92 :: "\<bool>"
where
	"inv_v92  \<equiv> (inv_VDMNat v92)"

	
end