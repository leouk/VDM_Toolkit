(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

files = [./src/test/resources/TestV2I.vdmsl]
*)
theory TestV2I
imports "VDMToolkit"
begin

record R = 
	field1 :: "VDMNat"
	field2 :: "VDMNat"

definition
	inv_R :: "R \<Rightarrow> \<bool>"
where
	"inv_R x \<equiv> 
		(((inv_VDMNat (field1 x))) \<and>
		 ((inv_VDMNat (field2 x)))
		)"

(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 9:7

S :: ;

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 11:3

 Explicitly typed values

*)
abbreviation
	t1 :: "\<bool>"
where
	"t1 \<equiv> (True::\<bool>)"

definition
	inv_t1 :: "\<bool>"
where
	"inv_t1  \<equiv> (inv_bool t1)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 12:43

TCBooleanType,TCBooleanLiteralExpression

*)
abbreviation
	t2 :: "VDMChar"
where
	"t2 \<equiv> (CHR ''a''::VDMChar)"

definition
	inv_t2 :: "\<bool>"
where
	"inv_t2  \<equiv> (inv_VDMChar t2)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 13:43

TCCharacterType,TCCharLiteralExpression

*)
abbreviation
	t3 :: "VDMChar VDMSeq"
where
	"t3 \<equiv> (''just text'')"

definition
	inv_t3 :: "\<bool>"
where
	"inv_t3  \<equiv> (inv_VDMSeq' (inv_VDMChar) t3)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 14:43

TCStringLiteralExpression; string literals can be VDMChar VDMSeq for Isabelle string type 

*)
abbreviation
	t4 :: "VDMInt"
where
	"t4 \<equiv> (10::VDMNat1)"

definition
	inv_t4 :: "\<bool>"
where
	"inv_t4  \<equiv> (inv_VDMInt t4)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 15:39

TCIntegerType, TCIntegerLiteralExpression

*)
abbreviation
	t5 :: "VDMNat"
where
	"t5 \<equiv> (10::VDMNat1)"

definition
	inv_t5 :: "\<bool>"
where
	"inv_t5  \<equiv> (inv_VDMNat t5)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 16:39

TCNaturalType

*)
abbreviation
	t6 :: "VDMNat1"
where
	"t6 \<equiv> (20::VDMNat1)"

definition
	inv_t6 :: "\<bool>"
where
	"inv_t6  \<equiv> (inv_VDMNat1 t6)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 17:39

TCNaturalOneType

*)
abbreviation
	t7 :: "VDMReal"
where
	"t7 \<equiv> (4.5)"

definition
	inv_t7 :: "\<bool>"
where
	"inv_t7  \<equiv> (inv_VDMReal t7)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 18:43

TCRealType,TCRealLiteralExpression

*)
abbreviation
	t8 :: "VDMRat"
where
	"t8 \<equiv> (4.5)"

definition
	inv_t8 :: "\<bool>"
where
	"inv_t8  \<equiv> (inv_VDMRat t8)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 19:39

TCRationalType

*)
abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1),(2::VDMNat1),(3::VDMNat1)}"

definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 21:55

TCSetType

*)
abbreviation
	t10 :: "VDMNat1 VDMSeq1"
where
	"t10 \<equiv> [(1::VDMNat1),(2::VDMNat1),(3::VDMNat1)]"

definition
	inv_t10 :: "\<bool>"
where
	"inv_t10  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) t10)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 22:55

TCSeqType, TCSeq1Type

*)
abbreviation
	t11 :: "VDMNat1 VDMSet1"
where
	"t11 \<equiv> {(1::VDMNat1)..(5::VDMNat1)}"

definition
	inv_t11 :: "\<bool>"
where
	"inv_t11  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t11)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 23:51

TCSet1Type

*)
abbreviation
	t12 :: "VDMNat1 VDMSet VDMSet"
where
	"t12 \<equiv> {{(1::VDMNat1),(2::VDMNat1)},{(2::VDMNat1),(4::VDMNat1)}}"

definition
	inv_t12 :: "\<bool>"
where
	"inv_t12  \<equiv> (inv_VDMSet' (inv_VDMSet' (inv_VDMNat1)) t12)"


abbreviation
	t13 :: "VDMNat1 VDMSeq VDMSeq"
where
	"t13 \<equiv> [[(1::VDMNat1),(2::VDMNat1)],[(3::VDMNat1),(4::VDMNat1)]]"

definition
	inv_t13 :: "\<bool>"
where
	"inv_t13  \<equiv> (inv_VDMSeq' (inv_VDMSeq' (inv_VDMNat1)) t13)"


abbreviation
	t14 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"t14 \<equiv> [(1::VDMNat1)\<mapsto>(1::VDMNat1),(2::VDMNat1)\<mapsto>(3::VDMNat1)]"

definition
	inv_t14 :: "\<bool>"
where
	"inv_t14  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) t14)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 26:51

TCMapType

*)
abbreviation
	t15 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"t15 \<equiv> [(3::VDMNat1)\<mapsto>(1::VDMNat1)]"

definition
	inv_t15 :: "\<bool>"
where
	"inv_t15  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) t15)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 29:3

 Implicitly typed values	

*)
abbreviation
	v1 :: "VDMNat1"
where
	"v1 \<equiv> (vdm_abs (10::VDMNat1))"

definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_VDMNat1 v1)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 30:39

TCAbsoluteExpression	

*)
abbreviation
	v2 :: "VDMInt"
where
	"v2 \<equiv> (vdm_floor (5::VDMNat1))"

definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_VDMInt v2)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 31:39

TCFloorExpression 		

*)
abbreviation
	v3 :: "VDMInt"
where
	"v3 \<equiv> (vdm_floor (4.5))"

definition
	inv_v3 :: "\<bool>"
where
	"inv_v3  \<equiv> (inv_VDMInt v3)"


abbreviation
	v4 :: "VDMInt"
where
	"v4 \<equiv> (- (4::VDMNat1))"

definition
	inv_v4 :: "\<bool>"
where
	"inv_v4  \<equiv> (inv_VDMInt v4)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 33:39

TCUnaryMinusExpression

*)
abbreviation
	v5 :: "VDMNat1"
where
	"v5 \<equiv> (5::VDMNat1)"

definition
	inv_v5 :: "\<bool>"
where
	"inv_v5  \<equiv> (inv_VDMNat1 v5)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 34:39

TCUnaryPlusExpression	

*)
abbreviation
	v6 :: "VDMNat1"
where
	"v6 \<equiv> (vdm_card t9)"

definition
	inv_v6 :: "\<bool>"
where
	"inv_v6  \<equiv> (inv_VDMNat1 v6)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 35:39

TCCardinalityExpression

*)
abbreviation
	v7 :: "VDMNat1 VDMSet VDMSet"
where
	"v7 \<equiv> (Fpow {(1::VDMNat1),(2::VDMNat1)})"

definition
	inv_v7 :: "\<bool>"
where
	"inv_v7  \<equiv> (inv_VDMSet' (inv_VDMSet' (inv_VDMNat1)) v7)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 36:39

TCPowerSetExpression

*)
abbreviation
	v8 :: "VDMNat1 VDMSet"
where
	"v8 \<equiv> (\<Union> t12)"

definition
	inv_v8 :: "\<bool>"
where
	"inv_v8  \<equiv> (inv_VDMSet' (inv_VDMNat1) v8)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 37:39

TCDistUnionExpression	

*)
abbreviation
	v9 :: "VDMNat1 VDMSet"
where
	"v9 \<equiv> (\<Inter> t12)"

definition
	inv_v9 :: "\<bool>"
where
	"inv_v9  \<equiv> (inv_VDMSet' (inv_VDMNat1) v9)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 38:39

TCDistIntersectExpression

*)
abbreviation
	v10 :: "VDMNat1"
where
	"v10 \<equiv> (len t10)"

definition
	inv_v10 :: "\<bool>"
where
	"inv_v10  \<equiv> (inv_VDMNat1 v10)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 39:39

TCLenExpression

*)
abbreviation
	v11 :: "VDMNat1"
where
	"v11 \<equiv> (hd t10)"

definition
	inv_v11 :: "\<bool>"
where
	"inv_v11  \<equiv> (inv_VDMNat1 v11)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 40:43

TCHeadExpression

*)
abbreviation
	v12 :: "VDMNat1 VDMSeq"
where
	"v12 \<equiv> (tl t10)"

definition
	inv_v12 :: "\<bool>"
where
	"inv_v12  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v12)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 41:43

TCTailExpression

*)
abbreviation
	v13 :: "VDMNat1 VDMSet"
where
	"v13 \<equiv> (inds t10)"

definition
	inv_v13 :: "\<bool>"
where
	"inv_v13  \<equiv> (inv_VDMSet' (inv_VDMNat1) v13)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 42:39

TCIndicesExpression

*)
abbreviation
	v14 :: "VDMNat1 VDMSet"
where
	"v14 \<equiv> (elems t10)"

definition
	inv_v14 :: "\<bool>"
where
	"inv_v14  \<equiv> (inv_VDMSet' (inv_VDMNat1) v14)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 43:39

TCElementsExpression 

*)
abbreviation
	v15 :: "VDMNat1 VDMSeq"
where
	"v15 \<equiv> (conc t13)"

definition
	inv_v15 :: "\<bool>"
where
	"inv_v15  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v15)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 44:39

TCDistConcatExpression

*)
abbreviation
	v16 :: "VDMNat1 VDMSeq1"
where
	"v16 \<equiv> (vdm_reverse t10)"

definition
	inv_v16 :: "\<bool>"
where
	"inv_v16  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v16)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 45:39

TCReverseExpression

*)
abbreviation
	v17 :: "VDMNat1 VDMSeq1"
where
	"v17 \<equiv> (t10 @ t10)"

definition
	inv_v17 :: "\<bool>"
where
	"inv_v17  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v17)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 46:39

TCSeqConcatExpression		

*)
abbreviation
	v18 :: "VDMNat1 VDMSeq"
where
	"v18 \<equiv> (t10 {(2::VDMNat1)$$(3::VDMNat1)})"

definition
	inv_v18 :: "\<bool>"
where
	"inv_v18  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v18)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 47:39

TCSubseqExpression

*)
abbreviation
	v19 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v19 \<equiv> (vdm_merge {t14,t15})"

definition
	inv_v19 :: "\<bool>"
where
	"inv_v19  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v19)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 48:43

TCDistMergeExpression

*)
abbreviation
	v20 :: "VDMNat1 VDMSet"
where
	"v20 \<equiv> (dom t14)"

definition
	inv_v20 :: "\<bool>"
where
	"inv_v20  \<equiv> (inv_VDMSet' (inv_VDMNat1) v20)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 49:39

TCMapDomainExpression

*)
abbreviation
	v21 :: "VDMNat1 VDMSet"
where
	"v21 \<equiv> (rng t14)"

definition
	inv_v21 :: "\<bool>"
where
	"inv_v21  \<equiv> (inv_VDMSet' (inv_VDMNat1) v21)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 50:39

TCMapRangeExpression

*)
abbreviation
	v22 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v22 \<equiv> (vdm_inverse t14)"

definition
	inv_v22 :: "\<bool>"
where
	"inv_v22  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v22)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 51:39

TCMapInverseExpression

*)
abbreviation
	v23 :: "VDMNat1"
where
	"v23 \<equiv> ((4::VDMNat1) + (3::VDMNat1))"

definition
	inv_v23 :: "\<bool>"
where
	"inv_v23  \<equiv> (inv_VDMNat1 v23)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 52:39

TCPlusExpression		

*)
abbreviation
	v24 :: "VDMInt"
where
	"v24 \<equiv> ((4::VDMNat1) - (2::VDMNat1))"

definition
	inv_v24 :: "\<bool>"
where
	"inv_v24  \<equiv> (inv_VDMInt v24)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 53:39

TCSubtractExpression	

*)
abbreviation
	v25 :: "VDMNat1"
where
	"v25 \<equiv> ((4::VDMNat1) * (2::VDMNat1))"

definition
	inv_v25 :: "\<bool>"
where
	"inv_v25  \<equiv> (inv_VDMNat1 v25)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 54:39

TCTimesExpression		

*)
abbreviation
	v26 :: "VDMInt"
where
	"v26 \<equiv> ((4::VDMNat1) vdmdiv (2::VDMNat1))"

definition
	inv_v26 :: "\<bool>"
where
	"inv_v26  \<equiv> (inv_VDMInt v26)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 55:39

TCDivExpression			

*)
abbreviation
	v27 :: "VDMReal"
where
	"v27 \<equiv> ((4::VDMNat1) / (2::VDMNat1))"

definition
	inv_v27 :: "\<bool>"
where
	"inv_v27  \<equiv> (inv_VDMReal v27)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 56:39

TCDivideExpression		

*)
abbreviation
	v28 :: "VDMInt"
where
	"v28 \<equiv> ((4::VDMNat1) vdmmod (3::VDMNat1))"

definition
	inv_v28 :: "\<bool>"
where
	"inv_v28  \<equiv> (inv_VDMInt v28)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 57:39

TCModExpression			

*)
abbreviation
	v29 :: "VDMInt"
where
	"v29 \<equiv> ((4::VDMNat1) vdmrem (3::VDMNat1))"

definition
	inv_v29 :: "\<bool>"
where
	"inv_v29  \<equiv> (inv_VDMInt v29)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 58:39

TCRemExpression			

*)
abbreviation
	v30 :: "VDMNat1"
where
	"v30 \<equiv> ((2::VDMNat1) ^ nat (3::VDMNat1))
	\<comment>\<open>result is context dependenant on second argument type being nat or real.\<close>"

definition
	inv_v30 :: "\<bool>"
where
	"inv_v30  \<equiv> (inv_VDMNat1 v30)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 59:39

TCStarStarExpression	

*)
abbreviation
	v31 :: "\<bool>"
where
	"v31 \<equiv> ((3::VDMNat1) = (3::VDMNat1))"

definition
	inv_v31 :: "\<bool>"
where
	"inv_v31  \<equiv> (inv_bool v31)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 60:39

TCEqualsExpression		

*)
abbreviation
	v32 :: "\<bool>"
where
	"v32 \<equiv> ((3::VDMNat1) \<noteq> (4::VDMNat1))"

definition
	inv_v32 :: "\<bool>"
where
	"inv_v32  \<equiv> (inv_bool v32)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 61:39

TCNotEqualExpression	

*)
abbreviation
	v33 :: "\<bool>"
where
	"v33 \<equiv> ((4::VDMNat1) \<le> (5::VDMNat1))"

definition
	inv_v33 :: "\<bool>"
where
	"inv_v33  \<equiv> (inv_bool v33)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 62:39

TCLessEqualExpression	

*)
abbreviation
	v34 :: "\<bool>"
where
	"v34 \<equiv> ((4::VDMNat1) < (5::VDMNat1))"

definition
	inv_v34 :: "\<bool>"
where
	"inv_v34  \<equiv> (inv_bool v34)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 63:39

TCLessExpression		

*)
abbreviation
	v35 :: "\<bool>"
where
	"v35 \<equiv> ((5::VDMNat1) \<ge> (4::VDMNat1))"

definition
	inv_v35 :: "\<bool>"
where
	"inv_v35  \<equiv> (inv_bool v35)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 64:39

TCGreaterEqualExpression

*)
abbreviation
	v36 :: "\<bool>"
where
	"v36 \<equiv> ((5::VDMNat1) > (4::VDMNat1))"

definition
	inv_v36 :: "\<bool>"
where
	"inv_v36  \<equiv> (inv_bool v36)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 65:39

TCGreaterExpression		

*)
abbreviation
	v37 :: "VDMNat option"
where
	"v37 \<equiv> None"

definition
	inv_v37 :: "\<bool>"
where
	"inv_v37  \<equiv> (inv_Option (inv_VDMNat) v37)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 66:39

TCNilExpression			TCOptionalType,

*)
abbreviation
	v38 :: "'UNKNOWN option"
where
	"v38 \<equiv> None"

definition
	inv_v38 :: "\<bool>"
where
	"inv_v38  \<equiv> (inv_Option inv_True
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close> v38)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 67:39

TCNilExpression (untyped)!TCUnknownType	

*)
abbreviation
	v39 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v39 \<equiv> (t14 \<dagger> t15)"

definition
	inv_v39 :: "\<bool>"
where
	"inv_v39  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v39)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 68:39

TCPlusPlusExpression	

*)
abbreviation
	v40 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v40 \<equiv> (t9 \<triangleleft> t14)"

definition
	inv_v40 :: "\<bool>"
where
	"inv_v40  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v40)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 69:39

TCDomainResByExpression	

*)
abbreviation
	v41 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v41 \<equiv> (t9 -\<triangleleft> t14)"

definition
	inv_v41 :: "\<bool>"
where
	"inv_v41  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v41)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 70:43

TCDomainResToExpression	

*)
abbreviation
	v42 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v42 \<equiv> (t14 \<triangleright> t9)"

definition
	inv_v42 :: "\<bool>"
where
	"inv_v42  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v42)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 71:39

TCRangeResByExpression	

*)
abbreviation
	v43 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v43 \<equiv> (t14 \<triangleright>- t9)"

definition
	inv_v43 :: "\<bool>"
where
	"inv_v43  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v43)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 72:43

TCRangeResToExpression	

*)
abbreviation
	v44 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v44 \<equiv> (t14 \<union>m t15)"

definition
	inv_v44 :: "\<bool>"
where
	"inv_v44  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v44)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 73:43

TCMapUnionExpression	

*)
abbreviation
	v45 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v45 \<equiv> (t14 \<circ>m t15)"

definition
	inv_v45 :: "\<bool>"
where
	"inv_v45  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v45)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 74:39

TCCompExpression			

*)
abbreviation
	v46 :: "\<bool>"
where
	"v46 \<equiv> (\<not> t1)"

definition
	inv_v46 :: "\<bool>"
where
	"inv_v46  \<equiv> (inv_bool v46)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 75:43

TCNotExpression

*)
abbreviation
	v47 :: "\<bool>"
where
	"v47 \<equiv> (t1 \<and> t1)"

definition
	inv_v47 :: "\<bool>"
where
	"inv_v47  \<equiv> (inv_bool v47)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 76:39

TCAndExpression

*)
abbreviation
	v48 :: "\<bool>"
where
	"v48 \<equiv> (t1 \<or> t1)"

definition
	inv_v48 :: "\<bool>"
where
	"inv_v48  \<equiv> (inv_bool v48)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 77:39

TCOrExpression

*)
abbreviation
	v49 :: "\<bool>"
where
	"v49 \<equiv> (t1 \<longrightarrow> t1)"

definition
	inv_v49 :: "\<bool>"
where
	"inv_v49  \<equiv> (inv_bool v49)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 78:39

TCImpliesExpression

*)
abbreviation
	v50 :: "\<bool>"
where
	"v50 \<equiv> (t1 \<longleftrightarrow> t1)"

definition
	inv_v50 :: "\<bool>"
where
	"inv_v50  \<equiv> (inv_bool v50)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 79:39

TCEquivalentExpression

*)
abbreviation
	v51 :: "\<bool>"
where
	"v51 \<equiv> ((1::VDMNat1) \<in> t9)"

definition
	inv_v51 :: "\<bool>"
where
	"inv_v51  \<equiv> (inv_bool v51)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 80:43

TCInSetExpression		

*)
abbreviation
	v52 :: "\<bool>"
where
	"v52 \<equiv> ((5::VDMNat1) \<notin> t9)"

definition
	inv_v52 :: "\<bool>"
where
	"inv_v52  \<equiv> (inv_bool v52)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 81:43

TCNotInSetExpression	

*)
abbreviation
	v53 :: "VDMNat VDMSet"
where
	"v53 \<equiv> (t9 \<union> t11)"

definition
	inv_v53 :: "\<bool>"
where
	"inv_v53  \<equiv> (inv_VDMSet' (inv_VDMNat) v53)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 82:51

TCSetUnionExpression	

*)
abbreviation
	v54 :: "VDMNat VDMSet"
where
	"v54 \<equiv> (t9 \<inter> t11)"

definition
	inv_v54 :: "\<bool>"
where
	"inv_v54  \<equiv> (inv_VDMSet' (inv_VDMNat) v54)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 83:51

TCSetIntersectExpression

*)
abbreviation
	v55 :: "VDMNat VDMSet"
where
	"v55 \<equiv> (t9 - t11)"

definition
	inv_v55 :: "\<bool>"
where
	"inv_v55  \<equiv> (inv_VDMSet' (inv_VDMNat) v55)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 84:51

TCSetDifferenceExpression

*)
abbreviation
	v56 :: "\<bool>"
where
	"v56 \<equiv> (t9 \<subseteq> t11)"

definition
	inv_v56 :: "\<bool>"
where
	"inv_v56  \<equiv> (inv_bool v56)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 85:39

TCSubsetExpression		

*)
abbreviation
	v57 :: "\<bool>"
where
	"v57 \<equiv> (t9 \<subset> t11)"

definition
	inv_v57 :: "\<bool>"
where
	"inv_v57  \<equiv> (inv_bool v57)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 86:43

TCProperSubsetExpression	

*)
abbreviation
	v58 :: "VDMNat1 VDMSet"
where
	"v58 \<equiv> {(1::VDMNat1)..(3::VDMNat1)}"

definition
	inv_v58 :: "\<bool>"
where
	"inv_v58  \<equiv> (inv_VDMSet' (inv_VDMNat1) v58)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 87:39

TCSetRangeExpression	

*)
abbreviation
	v59 :: "VDMNat1 VDMSet1"
where
	"v59 \<equiv> {(1::VDMNat1),(2::VDMNat1),(3::VDMNat1),(4::VDMNat1)}"

definition
	inv_v59 :: "\<bool>"
where
	"inv_v59  \<equiv> (inv_VDMSet1' (inv_VDMNat1) v59)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 88:39

TCSetEnumExpression		

*)
abbreviation
	v60 :: "VDMNat1 VDMSeq1"
where
	"v60 \<equiv> [(1::VDMNat1),(3::VDMNat1),(4::VDMNat1)]"

definition
	inv_v60 :: "\<bool>"
where
	"inv_v60  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v60)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 89:39

TCSeqEnumExpression		

*)
abbreviation
	v61 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v61 \<equiv> [(1::VDMNat1)\<mapsto>(2::VDMNat1),(2::VDMNat1)\<mapsto>(3::VDMNat1)]"

definition
	inv_v61 :: "\<bool>"
where
	"inv_v61  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v61)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 90:39

TCMapEnumExpression,TCMapletExpressionList,TCMapletExpression	

*)
abbreviation
	v62 :: "(VDMNat1\<times>VDMNat1)"
where
	"v62 \<equiv> ((1::VDMNat1),(2::VDMNat1))"

definition
	inv_v62 :: "\<bool>"
where
	"inv_v62  \<equiv> 
		((inv_VDMNat1 (fst v62))\<and>
		 (inv_VDMNat1 (snd v62))
		)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 91:39

TCTupleExpression		

*)
abbreviation
	v63 :: "(VDMNat1\<times>VDMNat1\<times>VDMNat1)"
where
	"v63 \<equiv> ((1::VDMNat1),(2::VDMNat1),(3::VDMNat1))"

definition
	inv_v63 :: "\<bool>"
where
	"inv_v63  \<equiv> 
		((inv_VDMNat1 (fst v63))\<and>
		 (inv_VDMNat1 (fst (snd v63)))\<and>
		 (inv_VDMNat1 (snd (snd v63)))
		)"


abbreviation
	v64 :: "(VDMNat1\<times>VDMNat1\<times>VDMNat1\<times>VDMNat1)"
where
	"v64 \<equiv> ((1::VDMNat1),(2::VDMNat1),(3::VDMNat1),(4::VDMNat1))"

definition
	inv_v64 :: "\<bool>"
where
	"inv_v64  \<equiv> 
		((inv_VDMNat1 (fst v64))\<and>
		 (inv_VDMNat1 (fst (snd v64)))\<and>
		 (inv_VDMNat1 (fst (snd (snd v64))))\<and>
		 (inv_VDMNat1 (snd (snd (snd v64))))
		)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 94:7

TODO: TCQuoteLiteralExpression quote literal requires quote type prior definition for Isabelle 

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 95:7

v13= merge mm;	

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 96:7

v18: S = mk_S();

*)
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>field1 = (1::VDMNat1), field2 = (2::VDMNat1)\<rparr>"

definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R v65"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 97:39

TCMkTypeExpression		

*)
abbreviation
	v66 :: "R"
where
	"v66 \<equiv> (v65)\<lparr>field1:=(10::VDMNat1),field2:=(20::VDMNat1)\<rparr>"

definition
	inv_v66 :: "\<bool>"
where
	"inv_v66  \<equiv> inv_R v66"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 98:54

TCMuExpression,TCRecordModifierList, TCRecordModifier

*)
abbreviation
	v67 :: "VDMNat"
where
	"v67 \<equiv> (field1 (v65))"

definition
	inv_v67 :: "\<bool>"
where
	"inv_v67  \<equiv> (inv_VDMNat v67)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 99:33

TCFieldExpression

*)
abbreviation
	v68 :: "VDMNat1"
where
	"v68 \<equiv> (fst (v64))"

definition
	inv_v68 :: "\<bool>"
where
	"inv_v68  \<equiv> (inv_VDMNat1 v68)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 100:34

TCFieldNumberExpression 

*)
abbreviation
	v69 :: "VDMNat1"
where
	"v69 \<equiv> (fst (snd (v64)))"

definition
	inv_v69 :: "\<bool>"
where
	"inv_v69  \<equiv> (inv_VDMNat1 v69)"


abbreviation
	v70 :: "VDMNat1"
where
	"v70 \<equiv> (fst (snd (snd (v64))))"

definition
	inv_v70 :: "\<bool>"
where
	"inv_v70  \<equiv> (inv_VDMNat1 v70)"


abbreviation
	v71 :: "VDMNat1"
where
	"v71 \<equiv> (snd (snd (snd (v64))))"

definition
	inv_v71 :: "\<bool>"
where
	"inv_v71  \<equiv> (inv_VDMNat1 v71)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 104:7

v72= not yet specified;	--TCNotYetSpecifiedExpression

*)
abbreviation
	v72 :: "VDMNat1"
where
	"v72 \<equiv> vdm_narrow_real (((4.0))::VDMReal)"

definition
	inv_v72 :: "\<bool>"
where
	"inv_v72  \<equiv> (inv_VDMNat1 v72)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 105:35

TCNarrowExpression

*)
abbreviation
	v722 :: "VDMNat1"
where
	"v722 \<equiv> (
	let (r::VDMReal) = (4.0)
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


abbreviation
	v73 :: "VDMNat1"
where
	"v73 \<equiv> (SOME var. (var \<in> t9) \<and> (var < (2::VDMNat1)))"

definition
	inv_v73 :: "\<bool>"
where
	"inv_v73  \<equiv> (inv_VDMNat1 v73)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 107:44

TCIotaExpression

*)
abbreviation
	v74 :: "VDMNat\<Rightarrow>VDMNat \<Rightarrow> VDMNat"
where
	"v74 \<equiv> (
	\<lambda> (var::VDMNat) (var2::VDMNat) .
		(if (inv_VDMNat var) \<and> (inv_VDMNat var2) then
			(var + var2)
		 else
			undefined
		)
	)"

definition
	inv_v74 :: "VDMNat\<Rightarrow>VDMNat \<Rightarrow> \<bool>"
where
	"inv_v74 dummy0 dummy1 \<equiv> (inv_VDMNat (v74 dummy0 dummy1))
	\<comment>\<open>function type invariant depends on its lambda definition dummy names used being equal.\<close>"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 108:56

TCLambdaExpression

*)
abbreviation
	v75 :: "\<bool>"
where
	"v75 \<equiv> (\<exists>! var \<in> t9. (var < (2::VDMNat1)))"

definition
	inv_v75 :: "\<bool>"
where
	"inv_v75  \<equiv> (inv_bool v75)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 109:47

 TCExists1Expression

*)
abbreviation
	v76 :: "\<bool>"
where
	"v76 \<equiv> (\<exists> var \<in> t9. (var < (2::VDMNat1)))"

definition
	inv_v76 :: "\<bool>"
where
	"inv_v76  \<equiv> (inv_bool v76)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 110:46

 TCExistsExpression

*)
abbreviation
	v78 :: "\<bool>"
where
	"v78 \<equiv> (\<forall> var \<in> t9. (var \<le> (3::VDMNat1)))"

definition
	inv_v78 :: "\<bool>"
where
	"inv_v78  \<equiv> (inv_bool v78)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 111:47

 TCForallExpression

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 112:7

TODO: not yet v65= t14(1);						--TCApplyExpression

*)
abbreviation
	v79 :: "VDMNat1"
where
	"v79 \<equiv> (
	let (var::VDMNat) = (10::VDMNat1);
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


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 113:67

 TCLetDefExpression

*)
abbreviation
	v80 :: "VDMNat1 VDMSet"
where
	"v80 \<equiv> { var .  var \<in> t9  \<and> (var > (1::VDMNat1)) }"

definition
	inv_v80 :: "\<bool>"
where
	"inv_v80  \<equiv> (inv_VDMSet' (inv_VDMNat1) v80)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 114:47

 TCSetCompExpression

*)
abbreviation
	v81 :: "VDMNat1 VDMSet"
where
	"v81 \<equiv> { (var + var2) | var var2 . var \<in> t9 \<and> var2 \<in> (elems t10)  \<and> (var > var2) }"

definition
	inv_v81 :: "\<bool>"
where
	"inv_v81  \<equiv> (inv_VDMSet' (inv_VDMNat1) v81)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 115:72

 TCSetCompExpression

*)
abbreviation
	v82 :: "VDMNat1 VDMSeq"
where
	"v82 \<equiv> [ var . var \<leftarrow> sorted_list_of_set (t9) , (var > (1::VDMNat1)) ]
	\<comment>\<open>Set bind @{term \<open>var \<in> t9\<close>} in sequence comprehension requires VDM set 
	   to be ordered (i.e. its Isabelle type instantiates type class linorder).
	   This can be a problem if the target type of @{term \<open>t9\<close>}
	  has a VDM ord_ predicate.\<close>"

definition
	inv_v82 :: "\<bool>"
where
	"inv_v82  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v82)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 116:47

 TCSeqCompExpression

*)
abbreviation
	v83 :: "VDMNat1 VDMSeq"
where
	"v83 \<equiv> [ var . var \<leftarrow> t10 , (var > (1::VDMNat1)) ]"

definition
	inv_v83 :: "\<bool>"
where
	"inv_v83  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v83)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 117:48

 TCSeqCompExpression

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 118:7

VDM not happy with v84-86, Isabelle would allow them

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 119:7

v84= [ mk_(var, var2) | var in set s1, var2 in seq t10 & var > var2 ];

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 120:7

v85= [ var | var in seq [1,2,3,7,8,9], var2 in seq [4,5,6] & var > var2];

*)
abbreviation
	v86 :: "VDMNat1 VDMSeq"
where
	"v86 \<equiv> [ var . var \<leftarrow> [(1::VDMNat1),(2::VDMNat1),(3::VDMNat1),(7::VDMNat1),(8::VDMNat1),(9::VDMNat1)] , (var > (4::VDMNat1)) ]"

definition
	inv_v86 :: "\<bool>"
where
	"inv_v86  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v86)"


(* @ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 122:7

v87= (let f: nat * nat -> nat f(var,var2) == var + var2 in f(10,20)); --TCFiendishLambdaExpression :-)

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 124:7

Isabelle is not happy with these wacky VDM binds, where A = 1 and B = 2 all with implicit types!

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 125:7

[A,B]=[1,2];

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 127:7

To test VDM warnings as errors

@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 128:7

x = 10;

*)
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
	 \<comment>\<open>Implicitly defined type invariant checks\<close>
	 (pre_const  \<longrightarrow> ((inv_VDMNat RESULT))) \<and>
	 \<comment>\<open>User defined body\<close>
	 (True::\<bool>)"

definition
	const :: "VDMNat"
where
	"const  \<equiv> 
	 \<comment>\<open>User defined body\<close>
	 (10::VDMNat1)"

definition
	f :: "VDMNat\<Rightarrow>VDMNat1 \<Rightarrow> VDMNat1"
where
	"f x y \<equiv> 
	 \<comment>\<open>User defined body\<close>
	 (x + y)"

definition
	pre_g :: "VDMNat\<Rightarrow>VDMNat1 \<Rightarrow> \<bool>"
where
	"pre_g x y \<equiv> 
	 \<comment>\<open>Implicitly defined type invariant checks\<close>
	 ((inv_VDMNat x) \<and>
	 (inv_VDMNat1 y)) \<and>
	 \<comment>\<open>User defined body\<close>
	 (x > (10::VDMNat1))"

definition
	post_g :: "VDMNat\<Rightarrow>VDMNat1\<Rightarrow>VDMNat1 \<Rightarrow> \<bool>"
where
	"post_g x y RESULT \<equiv> 
	 \<comment>\<open>Implicitly defined type invariant checks\<close>
	 (pre_g x  y \<longrightarrow> ((inv_VDMNat x) \<and>
	 (inv_VDMNat1 y) \<and>
	 (inv_VDMNat1 RESULT))) \<and>
	 \<comment>\<open>User defined body\<close>
	 (x < RESULT)"

definition
	g :: "VDMNat\<Rightarrow>VDMNat1 \<Rightarrow> VDMNat1"
where
	"g x y \<equiv> 
	 \<comment>\<open>User defined body\<close>
	 (x + y)"

definition
	pre_h :: "VDMNat \<Rightarrow> \<bool>"
where
	"pre_h x \<equiv> 
	 \<comment>\<open>Implicitly defined type invariant checks\<close>
	 ((inv_VDMNat x)) \<and>
	 \<comment>\<open>User defined body\<close>
	 ((pre_g x x) \<and> (x < (20::VDMNat1)))"

definition
	post_h :: "VDMNat\<Rightarrow>VDMNat \<Rightarrow> \<bool>"
where
	"post_h x RESULT \<equiv> 
	 \<comment>\<open>Implicitly defined type invariant checks\<close>
	 (pre_h x \<longrightarrow> ((inv_VDMNat x) \<and>
	 (inv_VDMNat RESULT))) \<and>
	 \<comment>\<open>User defined body\<close>
	 ((post_g x x RESULT) \<and> (x > (20::VDMNat1)))"

definition
	h :: "VDMNat \<Rightarrow> VDMNat"
where
	"h x \<equiv> 
	 \<comment>\<open>User defined body\<close>
	 (g x x)"

end