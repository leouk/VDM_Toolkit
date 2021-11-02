(* VDM to Isabelle Translated
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2I.vdmsl' at line 1:8files = [./src/test/resources/TestV2I.vdmsl]
*)
theory TestV2I
imports VDMToolkit
begin

record R = 
	x\<^sub>R :: "VDMNat"
	 y\<^sub>R :: "VDMNat"

definition
	inv_R :: "R \<Rightarrow> \<bool>"
where
	"inv_R dummy0 \<equiv> 
		(((inv_VDMNat (x\<^sub>R dummy0))) \<and>
	 ((inv_VDMNat (y\<^sub>R dummy0)))
		)"

	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 12:7
Isabelle does not allow empty records
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 13:7
S :: ;
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 16:7
 Auxiliary to allow for TCApplicationExpression of TCRecordType result for mkr(1).x
\<close>
definition
	pre_mkr :: "VDMNat \<Rightarrow> \<bool>"
where
	"pre_mkr n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_mkr specification\<close>
		((inv_VDMNat n))"

definition
	post_mkr :: "VDMNat\<Rightarrow> R \<Rightarrow> \<bool>"
where
	"post_mkr n RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_mkr specification\<close>
		((inv_VDMNat n) \<and> 
		(((inv_VDMNat (x\<^sub>R RESULT))) \<and>
	 ((inv_VDMNat (y\<^sub>R RESULT)))
		))"

definition
	mkr :: "VDMNat \<Rightarrow> R"
where
	"mkr n \<equiv> 
	\<comment>\<open>User defined body of mkr\<close>
	\<lparr>x\<^sub>R = n, y\<^sub>R = (n + (1::VDMNat1))\<rparr>"

	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 20:7
TCRecordBind
\<close>
definition
	pre_recbind :: "R \<Rightarrow> \<bool>"
where
	"pre_recbind dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_recbind specification\<close>
		(
		(((inv_VDMNat (x\<^sub>R dummy0))) \<and>
	 ((inv_VDMNat (y\<^sub>R dummy0)))
		))"

definition
	post_recbind :: "R\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_recbind dummy0 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_recbind specification\<close>
		(
		(((inv_VDMNat (x\<^sub>R dummy0))) \<and>
	 ((inv_VDMNat (y\<^sub>R dummy0)))
		) \<and> (inv_VDMNat RESULT))"

definition
	recbind :: "R \<Rightarrow> VDMNat"
where
	"recbind dummy0 \<equiv> 
	\<comment>\<open>Implicit record pattern projection conversion\<close>
	let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
			\<comment>\<open>User defined body of recbind\<close>
			(x + y)"

	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 25:3
 Explicitly typed values
\<close>
abbreviation
	t1 :: "\<bool>"
where
	"t1 \<equiv> (True::\<bool>)"

definition
	inv_t1 :: "\<bool>"
where
	"inv_t1  \<equiv> (inv_bool t1)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 26:43
TCBooleanType,TCBooleanLiteralExpression
\<close>
abbreviation
	t2 :: "VDMChar"
where
	"t2 \<equiv> (CHR ''a''::VDMChar)"

definition
	inv_t2 :: "\<bool>"
where
	"inv_t2  \<equiv> (inv_VDMChar t2)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 27:43
TCCharacterType,TCCharLiteralExpression
\<close>
abbreviation
	t3 :: "VDMChar VDMSeq"
where
	"t3 \<equiv> (''just text'')"

definition
	inv_t3 :: "\<bool>"
where
	"inv_t3  \<equiv> (inv_VDMSeq' (inv_VDMChar) t3)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 28:43
TCStringLiteralExpression; string literals can be VDMChar VDMSeq for Isabelle string type 
\<close>
abbreviation
	t4 :: "VDMInt"
where
	"t4 \<equiv> (10::VDMNat1)"

definition
	inv_t4 :: "\<bool>"
where
	"inv_t4  \<equiv> (inv_VDMInt t4)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 29:39
TCIntegerType, TCIntegerLiteralExpression
\<close>
abbreviation
	t5 :: "VDMNat"
where
	"t5 \<equiv> (10::VDMNat1)"

definition
	inv_t5 :: "\<bool>"
where
	"inv_t5  \<equiv> (inv_VDMNat t5)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 30:39
TCNaturalType
\<close>
abbreviation
	t6 :: "VDMNat1"
where
	"t6 \<equiv> (20::VDMNat1)"

definition
	inv_t6 :: "\<bool>"
where
	"inv_t6  \<equiv> (inv_VDMNat1 t6)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 31:39
TCNaturalOneType
\<close>
abbreviation
	t7 :: "VDMReal"
where
	"t7 \<equiv> (4.5)"

definition
	inv_t7 :: "\<bool>"
where
	"inv_t7  \<equiv> (inv_VDMReal t7)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 32:43
TCRealType,TCRealLiteralExpression
\<close>
abbreviation
	t8 :: "VDMRat"
where
	"t8 \<equiv> (4.5)"

definition
	inv_t8 :: "\<bool>"
where
	"inv_t8  \<equiv> (inv_VDMRat t8)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 33:39
TCRationalType
\<close>
abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 35:55
TCSetType
\<close>
abbreviation
	t10 :: "VDMNat1 VDMSeq1"
where
	"t10 \<equiv> [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)]"

definition
	inv_t10 :: "\<bool>"
where
	"inv_t10  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) t10)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 36:55
TCSeqType, TCSeq1Type
\<close>
abbreviation
	t11 :: "VDMNat1 VDMSet1"
where
	"t11 \<equiv> {(1::VDMNat1)..(5::VDMNat1)}"

definition
	inv_t11 :: "\<bool>"
where
	"inv_t11  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t11)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 37:51
TCSet1Type
\<close>
abbreviation
	t12 :: "VDMNat1 VDMSet VDMSet"
where
	"t12 \<equiv> {{(1::VDMNat1), (2::VDMNat1)}, {(2::VDMNat1), (4::VDMNat1)}}"

definition
	inv_t12 :: "\<bool>"
where
	"inv_t12  \<equiv> (inv_VDMSet' (inv_VDMSet' (inv_VDMNat1)) t12)"


	abbreviation
	t13 :: "VDMNat1 VDMSeq VDMSeq"
where
	"t13 \<equiv> [[(1::VDMNat1), (2::VDMNat1)], [(3::VDMNat1), (4::VDMNat1)]]"

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


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 40:51
TCMapType
\<close>
abbreviation
	t15 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"t15 \<equiv> [(3::VDMNat1)\<mapsto>(1::VDMNat1)]"

definition
	inv_t15 :: "\<bool>"
where
	"inv_t15  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) t15)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 43:3
 Implicitly typed values	
\<close>
abbreviation
	v1 :: "VDMNat1"
where
	"v1 \<equiv> (vdm_abs (10::VDMNat1))"

definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_VDMNat1 v1)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 44:39
TCAbsoluteExpression	
\<close>
abbreviation
	v2 :: "VDMInt"
where
	"v2 \<equiv> (vdm_floor (5::VDMNat1))"

definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_VDMInt v2)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 45:39
TCFloorExpression 		
\<close>
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


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 47:39
TCUnaryMinusExpression
\<close>
abbreviation
	v5 :: "VDMNat1"
where
	"v5 \<equiv> (5::VDMNat1)"

definition
	inv_v5 :: "\<bool>"
where
	"inv_v5  \<equiv> (inv_VDMNat1 v5)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 48:39
TCUnaryPlusExpression	
\<close>
abbreviation
	v6 :: "VDMNat1"
where
	"v6 \<equiv> (vdm_card t9)"

definition
	inv_v6 :: "\<bool>"
where
	"inv_v6  \<equiv> (inv_VDMNat1 v6)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 49:39
TCCardinalityExpression
\<close>
abbreviation
	v7 :: "VDMNat1 VDMSet VDMSet"
where
	"v7 \<equiv> (Fpow {(1::VDMNat1), (2::VDMNat1)})"

definition
	inv_v7 :: "\<bool>"
where
	"inv_v7  \<equiv> (inv_VDMSet' (inv_VDMSet' (inv_VDMNat1)) v7)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 50:39
TCPowerSetExpression
\<close>
abbreviation
	v8 :: "VDMNat1 VDMSet"
where
	"v8 \<equiv> (\<Union> t12)"

definition
	inv_v8 :: "\<bool>"
where
	"inv_v8  \<equiv> (inv_VDMSet' (inv_VDMNat1) v8)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 51:39
TCDistUnionExpression	
\<close>
abbreviation
	v9 :: "VDMNat1 VDMSet"
where
	"v9 \<equiv> (\<Inter> t12)"

definition
	inv_v9 :: "\<bool>"
where
	"inv_v9  \<equiv> (inv_VDMSet' (inv_VDMNat1) v9)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 52:39
TCDistIntersectExpression
\<close>
abbreviation
	v10 :: "VDMNat1"
where
	"v10 \<equiv> (len t10)"

definition
	inv_v10 :: "\<bool>"
where
	"inv_v10  \<equiv> (inv_VDMNat1 v10)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 53:39
TCLenExpression
\<close>
abbreviation
	v11 :: "VDMNat1"
where
	"v11 \<equiv> (hd t10)"

definition
	inv_v11 :: "\<bool>"
where
	"inv_v11  \<equiv> (inv_VDMNat1 v11)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 54:43
TCHeadExpression
\<close>
abbreviation
	v12 :: "VDMNat1 VDMSeq"
where
	"v12 \<equiv> (tl t10)"

definition
	inv_v12 :: "\<bool>"
where
	"inv_v12  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v12)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 55:43
TCTailExpression
\<close>
abbreviation
	v13 :: "VDMNat1 VDMSet"
where
	"v13 \<equiv> (inds t10)"

definition
	inv_v13 :: "\<bool>"
where
	"inv_v13  \<equiv> (inv_VDMSet' (inv_VDMNat1) v13)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 56:39
TCIndicesExpression
\<close>
abbreviation
	v14 :: "VDMNat1 VDMSet"
where
	"v14 \<equiv> (elems t10)"

definition
	inv_v14 :: "\<bool>"
where
	"inv_v14  \<equiv> (inv_VDMSet' (inv_VDMNat1) v14)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 57:39
TCElementsExpression 
\<close>
abbreviation
	v15 :: "VDMNat1 VDMSeq"
where
	"v15 \<equiv> (conc t13)"

definition
	inv_v15 :: "\<bool>"
where
	"inv_v15  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v15)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 58:39
TCDistConcatExpression
\<close>
abbreviation
	v16 :: "VDMNat1 VDMSeq1"
where
	"v16 \<equiv> (vdm_reverse t10)"

definition
	inv_v16 :: "\<bool>"
where
	"inv_v16  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v16)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 59:39
TCReverseExpression
\<close>
abbreviation
	v17 :: "VDMNat1 VDMSeq1"
where
	"v17 \<equiv> (t10 @ t10)"

definition
	inv_v17 :: "\<bool>"
where
	"inv_v17  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v17)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 60:39
TCSeqConcatExpression		
\<close>
abbreviation
	v18 :: "VDMNat1 VDMSeq"
where
	"v18 \<equiv> (t10 {(2::VDMNat1)$$(3::VDMNat1)})"

definition
	inv_v18 :: "\<bool>"
where
	"inv_v18  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v18)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 61:39
TCSubseqExpression
\<close>
abbreviation
	v19 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v19 \<equiv> (vdm_merge {t14, t15})"

definition
	inv_v19 :: "\<bool>"
where
	"inv_v19  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v19)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 62:43
TCDistMergeExpression
\<close>
abbreviation
	v20 :: "VDMNat1 VDMSet"
where
	"v20 \<equiv> (dom t14)"

definition
	inv_v20 :: "\<bool>"
where
	"inv_v20  \<equiv> (inv_VDMSet' (inv_VDMNat1) v20)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 63:39
TCMapDomainExpression
\<close>
abbreviation
	v21 :: "VDMNat1 VDMSet"
where
	"v21 \<equiv> (rng t14)"

definition
	inv_v21 :: "\<bool>"
where
	"inv_v21  \<equiv> (inv_VDMSet' (inv_VDMNat1) v21)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 64:39
TCMapRangeExpression
\<close>
abbreviation
	v22 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v22 \<equiv> (vdm_inverse t14)"

definition
	inv_v22 :: "\<bool>"
where
	"inv_v22  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v22)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 65:39
TCMapInverseExpression
\<close>
abbreviation
	v23 :: "VDMNat1"
where
	"v23 \<equiv> ((4::VDMNat1) + (3::VDMNat1))"

definition
	inv_v23 :: "\<bool>"
where
	"inv_v23  \<equiv> (inv_VDMNat1 v23)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 66:39
TCPlusExpression		
\<close>
abbreviation
	v24 :: "VDMInt"
where
	"v24 \<equiv> ((4::VDMNat1) - (2::VDMNat1))"

definition
	inv_v24 :: "\<bool>"
where
	"inv_v24  \<equiv> (inv_VDMInt v24)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 67:39
TCSubtractExpression	
\<close>
abbreviation
	v25 :: "VDMNat1"
where
	"v25 \<equiv> ((4::VDMNat1) * (2::VDMNat1))"

definition
	inv_v25 :: "\<bool>"
where
	"inv_v25  \<equiv> (inv_VDMNat1 v25)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 68:39
TCTimesExpression		
\<close>
abbreviation
	v26 :: "VDMInt"
where
	"v26 \<equiv> ((4::VDMNat1) vdmdiv (2::VDMNat1))"

definition
	inv_v26 :: "\<bool>"
where
	"inv_v26  \<equiv> (inv_VDMInt v26)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 69:39
TCDivExpression			
\<close>
abbreviation
	v27 :: "VDMReal"
where
	"v27 \<equiv> ((4::VDMNat1) / (2::VDMNat1))"

definition
	inv_v27 :: "\<bool>"
where
	"inv_v27  \<equiv> (inv_VDMReal v27)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 70:39
TCDivideExpression		
\<close>
abbreviation
	v28 :: "VDMInt"
where
	"v28 \<equiv> ((4::VDMNat1) vdmmod (3::VDMNat1))"

definition
	inv_v28 :: "\<bool>"
where
	"inv_v28  \<equiv> (inv_VDMInt v28)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 71:39
TCModExpression			
\<close>
abbreviation
	v29 :: "VDMInt"
where
	"v29 \<equiv> ((4::VDMNat1) vdmrem (3::VDMNat1))"

definition
	inv_v29 :: "\<bool>"
where
	"inv_v29  \<equiv> (inv_VDMInt v29)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 72:39
TCRemExpression			
\<close>
abbreviation
	v30 :: "VDMNat1"
where
	"v30 \<equiv> ((2::VDMNat1) ^ nat (3::VDMNat1))
	\<comment>\<open>result is context dependenant on second argument type being nat or real.\<close>"

definition
	inv_v30 :: "\<bool>"
where
	"inv_v30  \<equiv> (inv_VDMNat1 v30)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 73:39
TCStarStarExpression	
\<close>
abbreviation
	v31 :: "\<bool>"
where
	"v31 \<equiv> ((3::VDMNat1) = (3::VDMNat1))"

definition
	inv_v31 :: "\<bool>"
where
	"inv_v31  \<equiv> (inv_bool v31)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 74:39
TCEqualsExpression		
\<close>
abbreviation
	v32 :: "\<bool>"
where
	"v32 \<equiv> ((3::VDMNat1) \<noteq> (4::VDMNat1))"

definition
	inv_v32 :: "\<bool>"
where
	"inv_v32  \<equiv> (inv_bool v32)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 75:39
TCNotEqualExpression	
\<close>
abbreviation
	v33 :: "\<bool>"
where
	"v33 \<equiv> ((4::VDMNat1) \<le> (5::VDMNat1))"

definition
	inv_v33 :: "\<bool>"
where
	"inv_v33  \<equiv> (inv_bool v33)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 76:39
TCLessEqualExpression	
\<close>
abbreviation
	v34 :: "\<bool>"
where
	"v34 \<equiv> ((4::VDMNat1) < (5::VDMNat1))"

definition
	inv_v34 :: "\<bool>"
where
	"inv_v34  \<equiv> (inv_bool v34)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 77:39
TCLessExpression		
\<close>
abbreviation
	v35 :: "\<bool>"
where
	"v35 \<equiv> ((5::VDMNat1) \<ge> (4::VDMNat1))"

definition
	inv_v35 :: "\<bool>"
where
	"inv_v35  \<equiv> (inv_bool v35)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 78:39
TCGreaterEqualExpression
\<close>
abbreviation
	v36 :: "\<bool>"
where
	"v36 \<equiv> ((5::VDMNat1) > (4::VDMNat1))"

definition
	inv_v36 :: "\<bool>"
where
	"inv_v36  \<equiv> (inv_bool v36)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 79:39
TCGreaterExpression		
\<close>
abbreviation
	v37 :: "VDMNat option"
where
	"v37 \<equiv> None"

definition
	inv_v37 :: "\<bool>"
where
	"inv_v37  \<equiv> (inv_Option (inv_VDMNat) v37)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 80:39
TCNilExpression			TCOptionalType,
\<close>
abbreviation
	v38 :: "'UNKNOWN option"
where
	"v38 \<equiv> None"

definition
	inv_v38 :: "\<bool>"
where
	"inv_v38  \<equiv> (inv_Option inv_True
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close> v38)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 81:39
TCNilExpression (untyped)!TCUnknownType	
\<close>
abbreviation
	v39 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v39 \<equiv> (t14 \<dagger> t15)"

definition
	inv_v39 :: "\<bool>"
where
	"inv_v39  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v39)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 82:39
TCPlusPlusExpression	
\<close>
abbreviation
	v40 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v40 \<equiv> (t9 \<triangleleft> t14)"

definition
	inv_v40 :: "\<bool>"
where
	"inv_v40  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v40)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 83:39
TCDomainResByExpression	
\<close>
abbreviation
	v41 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v41 \<equiv> (t9 -\<triangleleft> t14)"

definition
	inv_v41 :: "\<bool>"
where
	"inv_v41  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v41)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 84:43
TCDomainResToExpression	
\<close>
abbreviation
	v42 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v42 \<equiv> (t14 \<triangleright> t9)"

definition
	inv_v42 :: "\<bool>"
where
	"inv_v42  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v42)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 85:39
TCRangeResByExpression	
\<close>
abbreviation
	v43 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v43 \<equiv> (t14 \<triangleright>- t9)"

definition
	inv_v43 :: "\<bool>"
where
	"inv_v43  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v43)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 86:43
TCRangeResToExpression	
\<close>
abbreviation
	v44 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v44 \<equiv> (t14 \<union>m t15)"

definition
	inv_v44 :: "\<bool>"
where
	"inv_v44  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v44)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 87:43
TCMapUnionExpression	
\<close>
abbreviation
	v45 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v45 \<equiv> (t14 \<circ>m t15)"

definition
	inv_v45 :: "\<bool>"
where
	"inv_v45  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v45)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 88:39
TCCompExpression			
\<close>
abbreviation
	v46 :: "\<bool>"
where
	"v46 \<equiv> (\<not> t1)"

definition
	inv_v46 :: "\<bool>"
where
	"inv_v46  \<equiv> (inv_bool v46)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 89:43
TCNotExpression
\<close>
abbreviation
	v47 :: "\<bool>"
where
	"v47 \<equiv> (t1 \<and> t1)"

definition
	inv_v47 :: "\<bool>"
where
	"inv_v47  \<equiv> (inv_bool v47)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 90:39
TCAndExpression
\<close>
abbreviation
	v48 :: "\<bool>"
where
	"v48 \<equiv> (t1 \<or> t1)"

definition
	inv_v48 :: "\<bool>"
where
	"inv_v48  \<equiv> (inv_bool v48)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 91:39
TCOrExpression
\<close>
abbreviation
	v49 :: "\<bool>"
where
	"v49 \<equiv> (t1 \<longrightarrow> t1)"

definition
	inv_v49 :: "\<bool>"
where
	"inv_v49  \<equiv> (inv_bool v49)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 92:39
TCImpliesExpression
\<close>
abbreviation
	v50 :: "\<bool>"
where
	"v50 \<equiv> (t1 \<longleftrightarrow> t1)"

definition
	inv_v50 :: "\<bool>"
where
	"inv_v50  \<equiv> (inv_bool v50)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 93:39
TCEquivalentExpression
\<close>
abbreviation
	v51 :: "\<bool>"
where
	"v51 \<equiv> ((1::VDMNat1) \<in> t9)"

definition
	inv_v51 :: "\<bool>"
where
	"inv_v51  \<equiv> (inv_bool v51)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 94:43
TCInSetExpression		
\<close>
abbreviation
	v52 :: "\<bool>"
where
	"v52 \<equiv> ((5::VDMNat1) \<notin> t9)"

definition
	inv_v52 :: "\<bool>"
where
	"inv_v52  \<equiv> (inv_bool v52)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 95:43
TCNotInSetExpression	
\<close>
abbreviation
	v53 :: "VDMNat VDMSet"
where
	"v53 \<equiv> (t9 \<union> t11)"

definition
	inv_v53 :: "\<bool>"
where
	"inv_v53  \<equiv> (inv_VDMSet' (inv_VDMNat) v53)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 96:51
TCSetUnionExpression	
\<close>
abbreviation
	v54 :: "VDMNat VDMSet"
where
	"v54 \<equiv> (t9 \<inter> t11)"

definition
	inv_v54 :: "\<bool>"
where
	"inv_v54  \<equiv> (inv_VDMSet' (inv_VDMNat) v54)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 97:51
TCSetIntersectExpression
\<close>
abbreviation
	v55 :: "VDMNat VDMSet"
where
	"v55 \<equiv> (t9 - t11)"

definition
	inv_v55 :: "\<bool>"
where
	"inv_v55  \<equiv> (inv_VDMSet' (inv_VDMNat) v55)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 98:51
TCSetDifferenceExpression
\<close>
abbreviation
	v56 :: "\<bool>"
where
	"v56 \<equiv> (t9 \<subseteq> t11)"

definition
	inv_v56 :: "\<bool>"
where
	"inv_v56  \<equiv> (inv_bool v56)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 99:39
TCSubsetExpression		
\<close>
abbreviation
	v57 :: "\<bool>"
where
	"v57 \<equiv> (t9 \<subset> t11)"

definition
	inv_v57 :: "\<bool>"
where
	"inv_v57  \<equiv> (inv_bool v57)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 100:43
TCProperSubsetExpression	
\<close>
abbreviation
	v58 :: "VDMNat1 VDMSet"
where
	"v58 \<equiv> {(1::VDMNat1)..(3::VDMNat1)}"

definition
	inv_v58 :: "\<bool>"
where
	"inv_v58  \<equiv> (inv_VDMSet' (inv_VDMNat1) v58)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 101:39
TCSetRangeExpression	
\<close>
abbreviation
	v59 :: "VDMNat1 VDMSet1"
where
	"v59 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}"

definition
	inv_v59 :: "\<bool>"
where
	"inv_v59  \<equiv> (inv_VDMSet1' (inv_VDMNat1) v59)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 102:39
TCSetEnumExpression		
\<close>
abbreviation
	v60 :: "VDMNat1 VDMSeq1"
where
	"v60 \<equiv> [(1::VDMNat1), (3::VDMNat1), (4::VDMNat1)]"

definition
	inv_v60 :: "\<bool>"
where
	"inv_v60  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v60)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 103:39
TCSeqEnumExpression		
\<close>
abbreviation
	v61 :: "VDMNat1 \<rightharpoonup> VDMNat1"
where
	"v61 \<equiv> [(1::VDMNat1)\<mapsto>(2::VDMNat1),(2::VDMNat1)\<mapsto>(3::VDMNat1)]"

definition
	inv_v61 :: "\<bool>"
where
	"inv_v61  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v61)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 104:39
TCMapEnumExpression,TCMapletExpressionList,TCMapletExpression	
\<close>
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


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 105:39
TCTupleExpression		
\<close>
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


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 108:7
TODO: TCQuoteLiteralExpression quote literal requires quote type prior definition for Isabelle 
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 109:7
v13= merge mm;	
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 110:7
v18: S = mk_S();
\<close>
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>"

definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R v65"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 111:39
TCMkTypeExpression		
\<close>
abbreviation
	v651 :: "VDMNat"
where
	"v651 \<equiv> (x\<^sub>R (\<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"

definition
	inv_v651 :: "\<bool>"
where
	"inv_v651  \<equiv> (inv_VDMNat v651)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 112:40
TCFieldExpression via TRMkTypeExpression
\<close>
abbreviation
	v652 :: "VDMNat"
where
	"v652 \<equiv> (x\<^sub>R (v65))"

definition
	inv_v652 :: "\<bool>"
where
	"inv_v652  \<equiv> (inv_VDMNat v652)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 113:40
TCFieldExpression via TRVariableExpression
\<close>
abbreviation
	v653 :: "VDMNat"
where
	"v653 \<equiv> (x\<^sub>R ((mkr (1::VDMNat1))))"

definition
	inv_v653 :: "\<bool>"
where
	"inv_v653  \<equiv> (inv_VDMNat v653)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 114:43
TCFieldExpression via TRApplyExpression
\<close>
abbreviation
	v67 :: "R"
where
	"v67 \<equiv> (v65)\<lparr>x\<^sub>R := (10::VDMNat1), y\<^sub>R := (20::VDMNat1)\<rparr>"

definition
	inv_v67 :: "\<bool>"
where
	"inv_v67  \<equiv> inv_R v67"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 115:44
TCMuExpression,TCRecordModifierList, TCRecordModifier
\<close>
abbreviation
	v68 :: "VDMNat1"
where
	"v68 \<equiv> (fst (v64))"

definition
	inv_v68 :: "\<bool>"
where
	"inv_v68  \<equiv> (inv_VDMNat1 v68)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 117:34
TCFieldNumberExpression 
\<close>
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


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 121:7
v72= not yet specified;	--TCNotYetSpecifiedExpression
\<close>
abbreviation
	v72 :: "VDMNat1"
where
	"v72 \<equiv> vdm_narrow_real (((4.0))::VDMReal)"

definition
	inv_v72 :: "\<bool>"
where
	"inv_v72  \<equiv> (inv_VDMNat1 v72)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 122:35
TCNarrowExpression
\<close>
abbreviation
	v721 :: "VDMInt"
where
	"v721 \<equiv> vdm_narrow_real (((4.0))::VDMReal)"

definition
	inv_v721 :: "\<bool>"
where
	"inv_v721  \<equiv> (inv_VDMInt v721)"


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
	v723 :: "VDMNat1"
where
	"v723 \<equiv> vdm_narrow_real ((((6::VDMNat1) / (2::VDMNat1)))::VDMReal)"

definition
	inv_v723 :: "\<bool>"
where
	"inv_v723  \<equiv> (inv_VDMNat1 v723)"


	abbreviation
	v73 :: "VDMNat1"
where
	"v73 \<equiv> (THE var. (var \<in> t9) \<and> (var < (2::VDMNat1)))"

definition
	inv_v73 :: "\<bool>"
where
	"inv_v73  \<equiv> (inv_VDMNat1 v73)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 126:44
TCIotaExpression
\<close>
abbreviation
	v74 :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> VDMNat"
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
	inv_v74 :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"inv_v74 dummy0 dummy1 \<equiv> (inv_VDMNat (v74 dummy0 dummy1))
	\<comment>\<open>function type invariant depends on its lambda definition dummy names used being equal.\<close>"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 127:56
TCLambdaExpression + TCMultipleTypeBind
\<close>
abbreviation
	v75 :: "\<bool>"
where
	"v75 \<equiv> (\<exists>! var \<in> t9. (var < (2::VDMNat1)))"

definition
	inv_v75 :: "\<bool>"
where
	"inv_v75  \<equiv> (inv_bool v75)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 128:47
 TCExists1Expression
\<close>
abbreviation
	v76 :: "\<bool>"
where
	"v76 \<equiv> (\<exists> var \<in> t9. (var < (2::VDMNat1)))"

definition
	inv_v76 :: "\<bool>"
where
	"inv_v76  \<equiv> (inv_bool v76)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 129:46
 TCExistsExpression
\<close>
abbreviation
	v78 :: "\<bool>"
where
	"v78 \<equiv> (\<forall> var \<in> t9. (var \<le> (3::VDMNat1)))"

definition
	inv_v78 :: "\<bool>"
where
	"inv_v78  \<equiv> (inv_bool v78)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 130:47
 TCForallExpression
\<close>
abbreviation
	v781 :: "\<bool>"
where
	"v781 \<equiv> (\<forall> var1 var2 \<in> t9. (var1 \<le> var2))"

definition
	inv_v781 :: "\<bool>"
where
	"inv_v781  \<equiv> (inv_bool v781)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 131:58
TCForallExpression multiple set binds!
\<close>
abbreviation
	v783 :: "\<bool>"
where
	"v783 \<equiv> (\<forall> var1 var2 \<in> (elems t10). (var1 \<le> var2))"

definition
	inv_v783 :: "\<bool>"
where
	"inv_v783  \<equiv> (inv_bool v783)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 132:58
TCForallExpression multiple seq binds!
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 133:7
TODO: not yet v65= t14(1);						--TCApplyExpression
\<close>
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


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 134:67
 TCLetDefExpression
\<close>
abbreviation
	v80 :: "VDMNat1 VDMSet"
where
	"v80 \<equiv> { var .  var \<in> t9  \<and> (var > (1::VDMNat1)) }"

definition
	inv_v80 :: "\<bool>"
where
	"inv_v80  \<equiv> (inv_VDMSet' (inv_VDMNat1) v80)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 135:47
 TCSetCompExpression
\<close>
abbreviation
	v81 :: "VDMNat1 VDMSet"
where
	"v81 \<equiv> { (var + var2) | var var2 . var \<in> t9 \<and> var2 \<in> (elems t10)  \<and> (var > var2) }"

definition
	inv_v81 :: "\<bool>"
where
	"inv_v81  \<equiv> (inv_VDMSet' (inv_VDMNat1) v81)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 136:72
 TCSetCompExpression
\<close>
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


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 137:47
 TCSeqCompExpression
\<close>
abbreviation
	v83 :: "VDMNat1 VDMSeq"
where
	"v83 \<equiv> [ var . var \<leftarrow> t10 , (var > (1::VDMNat1)) ]"

definition
	inv_v83 :: "\<bool>"
where
	"inv_v83  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v83)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 138:48
 TCSeqCompExpression
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 139:7
VDM not happy with v84-86, Isabelle would allow them
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 140:7
v84= [ mk_(var, var2) | var in set s1, var2 in seq t10 & var > var2 ];
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 141:7
v85= [ var | var in seq [1,2,3,7,8,9], var2 in seq [4,5,6] & var > var2];
\<close>
abbreviation
	v86 :: "VDMNat1 VDMSeq"
where
	"v86 \<equiv> [ var . var \<leftarrow> [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (7::VDMNat1), (8::VDMNat1), (9::VDMNat1)] , (var > (4::VDMNat1)) ]"

definition
	inv_v86 :: "\<bool>"
where
	"inv_v86  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v86)"


	abbreviation
	v87 :: "VDMInt"
where
	"v87 \<equiv> (
		if ((v1 > v2)) then
		(v1)
		else
		(v2))"

definition
	inv_v87 :: "\<bool>"
where
	"inv_v87  \<equiv> (inv_VDMInt v87)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 143:59
TCIfExpression
\<close>
abbreviation
	v88 :: "VDMInt"
where
	"v88 \<equiv> (
		if ((v1 > v2)) then
		(v1)
		else
		((
		if ((v1 < v2)) then
		(v2)
		else
		((0::VDMNat)))))"

definition
	inv_v88 :: "\<bool>"
where
	"inv_v88  \<equiv> (inv_VDMInt v88)"


	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 144:63
TCElseIfListExpression
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 145:7
v87= (let f: nat * nat -> nat f(var,var2) == var + var2 in f(10,20)); --TCFiendishLambdaExpression :-)
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 147:7
Isabelle is not happy with these wacky VDM binds, where A = 1 and B = 2 all with implicit types!
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 148:7
[A,B]=[1,2];
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 150:7
To test VDM warnings as errors
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 151:7
x = 10;
\<close>
 
\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 154:7
 has to be a function for executability because of the type bind!
\<close>
definition
	pre_v782 :: "\<bool>"
where
	"pre_v782  \<equiv> True"

definition
	post_v782 :: "\<bool> \<Rightarrow> \<bool>"
where
	"post_v782 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_v782 specification\<close>
		((inv_bool RESULT))"

definition
	v782 :: "\<bool>"
where
	"v782  \<equiv> 
	\<comment>\<open>User defined body of v782\<close>
	(\<forall> (var1::VDMNat) (var2::VDMNat). (var1 < var2))"

	\<comment>\<open>@ in 'TestV2I' (./src/test/resources/TestV2I.vdmsl) at line 156:59
 multiple type binds
\<close>
definition
	pre_v7821 :: "\<bool>"
where
	"pre_v7821  \<equiv> True"

definition
	post_v7821 :: "\<bool> \<Rightarrow> \<bool>"
where
	"post_v7821 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_v7821 specification\<close>
		((inv_bool RESULT))"

definition
	v7821 :: "\<bool>"
where
	"v7821  \<equiv> 
	\<comment>\<open>User defined body of v7821\<close>
	(\<forall> (var1::VDMNat) (var2::VDMNat) var3 var4 \<in> t9. ((var1 + var3) < (var2 + var4)))"

end