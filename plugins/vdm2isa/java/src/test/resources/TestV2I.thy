(* VDM to Isabelle Translation @2021-11-16T12:07:21.912631Z
   Copyright 2021, Leo Freitas, leo.freitas@newcastle.ac.uk

in './src/test/resources/TestV2I.vdmsl' at line 1:8
files = [./src/test/resources/TestV2I.vdmsl]
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
	"inv_R r \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for inv_R specification\<close>
		( (((inv_VDMNat (x\<^sub>R r))) \<and>
		 ((inv_VDMNat (y\<^sub>R r))) ))  \<and> 
		\<comment>\<open>User defined body of inv_R\<close>
		((x\<^sub>R (r)) < (y\<^sub>R (r)))"
 

	

definition
	pre_mkr :: "VDMNat \<Rightarrow> \<bool>"
where
	"pre_mkr n \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_mkr specification\<close>
		((inv_VDMNat n))"


definition
	post_mkr :: "VDMNat\<Rightarrow> R \<Rightarrow> \<bool>"
where
	"post_mkr n  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_mkr specification\<close>
		((inv_VDMNat n)  \<and>   (((inv_VDMNat (x\<^sub>R RESULT))) \<and>
		 ((inv_VDMNat (y\<^sub>R RESULT))) ))"

definition
	mkr :: "VDMNat \<Rightarrow> R"
where
	"mkr n \<equiv> 
	\<comment>\<open>User defined body of mkr\<close>
	\<lparr>x\<^sub>R = n, y\<^sub>R = (n+(1::VDMNat1))\<rparr>"

	

definition
	pre_recbind :: "R \<Rightarrow> \<bool>"
where
	"pre_recbind dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared pre_recbind specification\<close>
		( (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0))) ))"


definition
	post_recbind :: "R\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_recbind dummy0  RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_recbind specification\<close>
		( (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0))) )  \<and>  (inv_VDMNat RESULT))"

definition
	recbind :: "R \<Rightarrow> VDMNat"
where
	"recbind dummy0 \<equiv> 
	\<comment>\<open>Implicit record pattern projection conversion\<close>
	(let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
			\<comment>\<open>User defined body of recbind\<close>
			(x + y))"

	

definition
	pre_recbindSpec :: "R \<Rightarrow> \<bool>"
where
	"pre_recbindSpec dummy0 \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for pre_recbindSpec specification\<close>
		( (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0))) ))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
			\<comment>\<open>User defined body of pre_recbindSpec\<close>
			(x < y))"


definition
	post_recbindSpec :: "R\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"post_recbindSpec dummy0 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for post_recbindSpec specification\<close>
		( (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0))) )  \<and>  (inv_VDMNat RESULT))  \<and> 
		\<comment>\<open>Implicit record pattern projection conversion\<close>
		(let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
			\<comment>\<open>User defined body of post_recbindSpec\<close>
			((x < RESULT) \<and> (y < RESULT)))"

definition
	recbindSpec :: "R \<Rightarrow> VDMNat"
where
	"recbindSpec dummy0 \<equiv> 
	\<comment>\<open>Implicit record pattern projection conversion\<close>
	(let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
			\<comment>\<open>User defined body of recbindSpec\<close>
			(x + y))"

	

definition
	pre_letbest :: "\<bool>"
where
	"pre_letbest  \<equiv> True"


definition
	post_letbest :: "VDMNat \<Rightarrow> \<bool>"
where
	"post_letbest RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_letbest specification\<close>
		((inv_VDMNat RESULT))"

definition
	letbest :: "VDMNat"
where
	"letbest  \<equiv> 
	\<comment>\<open>User defined body of letbest\<close>
	(
		SOME (dummy0::VDMNat) .(dummy0 \<in> { (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x + y)) | (dummy0 :: R) .  \<comment>\<open>Type bound set compression will generate a (possibly spurious, i.e. inv_VDMSet') difficult set finiteness proof!!!\<close>  (( (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0))) )))  \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x > y)) }))"

	
abbreviation
	t1 :: "\<bool>"
where
	"t1 \<equiv> (True::\<bool>)"

	definition
	inv_t1 :: "\<bool>"
where
	"inv_t1  \<equiv> (inv_bool t1)"

	
	
abbreviation
	t2 :: "VDMChar"
where
	"t2 \<equiv> (CHR ''a''::VDMChar)"

	definition
	inv_t2 :: "\<bool>"
where
	"inv_t2  \<equiv> (inv_VDMChar t2)"

	
	
abbreviation
	t3 :: "VDMChar VDMSeq"
where
	"t3 \<equiv> (''just text'')"

	definition
	inv_t3 :: "\<bool>"
where
	"inv_t3  \<equiv> (inv_VDMSeq' (inv_VDMChar) t3)"

	
	
abbreviation
	t4 :: "VDMInt"
where
	"t4 \<equiv> (10::VDMNat1)"

	definition
	inv_t4 :: "\<bool>"
where
	"inv_t4  \<equiv> (inv_VDMInt t4)"

	
	
abbreviation
	t5 :: "VDMNat"
where
	"t5 \<equiv> (10::VDMNat1)"

	definition
	inv_t5 :: "\<bool>"
where
	"inv_t5  \<equiv> (inv_VDMNat t5)"

	
	
abbreviation
	t6 :: "VDMNat1"
where
	"t6 \<equiv> (20::VDMNat1)"

	definition
	inv_t6 :: "\<bool>"
where
	"inv_t6  \<equiv> (inv_VDMNat1 t6)"

	
	
abbreviation
	t7 :: "VDMReal"
where
	"t7 \<equiv> (4.5)"

	definition
	inv_t7 :: "\<bool>"
where
	"inv_t7  \<equiv> (inv_VDMReal t7)"

	
	
abbreviation
	t8 :: "VDMRat"
where
	"t8 \<equiv> (4.5)"

	definition
	inv_t8 :: "\<bool>"
where
	"inv_t8  \<equiv> (inv_VDMRat t8)"

	
	
abbreviation
	t9 :: "VDMNat1 VDMSet1"
where
	"t9 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)}"

	definition
	inv_t9 :: "\<bool>"
where
	"inv_t9  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t9)"

	
	
abbreviation
	t10 :: "VDMNat1 VDMSeq1"
where
	"t10 \<equiv> [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1)]"

	definition
	inv_t10 :: "\<bool>"
where
	"inv_t10  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) t10)"

	
	
abbreviation
	t11 :: "VDMNat1 VDMSet1"
where
	"t11 \<equiv> {(1::VDMNat1)..(5::VDMNat1)}"

	definition
	inv_t11 :: "\<bool>"
where
	"inv_t11  \<equiv> (inv_VDMSet1' (inv_VDMNat1) t11)"

	
	
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
	t14 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"t14 \<equiv> [(1::VDMNat1)\<mapsto>(1::VDMNat1),(2::VDMNat1)\<mapsto>(3::VDMNat1)]"

	definition
	inv_t14 :: "\<bool>"
where
	"inv_t14  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) t14)"

	
	
abbreviation
	t15 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"t15 \<equiv> [(3::VDMNat1)\<mapsto>(1::VDMNat1)]"

	definition
	inv_t15 :: "\<bool>"
where
	"inv_t15  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) t15)"

	
	
abbreviation
	v1 :: "VDMNat1"
where
	"v1 \<equiv> (vdm_abs (10::VDMNat1))"

	definition
	inv_v1 :: "\<bool>"
where
	"inv_v1  \<equiv> (inv_VDMNat1 v1)"

	
	
abbreviation
	v2 :: "VDMInt"
where
	"v2 \<equiv> (vdm_floor (5::VDMNat1))"

	definition
	inv_v2 :: "\<bool>"
where
	"inv_v2  \<equiv> (inv_VDMInt v2)"

	
	
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

	
	
abbreviation
	v5 :: "VDMNat1"
where
	"v5 \<equiv> (5::VDMNat1)"

	definition
	inv_v5 :: "\<bool>"
where
	"inv_v5  \<equiv> (inv_VDMNat1 v5)"

	
	
abbreviation
	v6 :: "VDMNat1"
where
	"v6 \<equiv> (vdm_card t9)"

	definition
	inv_v6 :: "\<bool>"
where
	"inv_v6  \<equiv> (inv_VDMNat1 v6)"

	
	
abbreviation
	v7 :: "VDMNat1 VDMSet VDMSet"
where
	"v7 \<equiv> (Fpow {(1::VDMNat1), (2::VDMNat1)})"

	definition
	inv_v7 :: "\<bool>"
where
	"inv_v7  \<equiv> (inv_VDMSet' (inv_VDMSet' (inv_VDMNat1)) v7)"

	
	
abbreviation
	v8 :: "VDMNat1 VDMSet"
where
	"v8 \<equiv> (\<Union> t12)"

	definition
	inv_v8 :: "\<bool>"
where
	"inv_v8  \<equiv> (inv_VDMSet' (inv_VDMNat1) v8)"

	
	
abbreviation
	v9 :: "VDMNat1 VDMSet"
where
	"v9 \<equiv> (\<Inter> t12)"

	definition
	inv_v9 :: "\<bool>"
where
	"inv_v9  \<equiv> (inv_VDMSet' (inv_VDMNat1) v9)"

	
	
abbreviation
	v10 :: "VDMNat1"
where
	"v10 \<equiv> (len t10)"

	definition
	inv_v10 :: "\<bool>"
where
	"inv_v10  \<equiv> (inv_VDMNat1 v10)"

	
	
abbreviation
	v11 :: "VDMNat1"
where
	"v11 \<equiv> (hd t10)"

	definition
	inv_v11 :: "\<bool>"
where
	"inv_v11  \<equiv> (inv_VDMNat1 v11)"

	
	
abbreviation
	v12 :: "VDMNat1 VDMSeq"
where
	"v12 \<equiv> (tl t10)"

	definition
	inv_v12 :: "\<bool>"
where
	"inv_v12  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v12)"

	
	
abbreviation
	v13 :: "VDMNat1 VDMSet"
where
	"v13 \<equiv> (inds t10)"

	definition
	inv_v13 :: "\<bool>"
where
	"inv_v13  \<equiv> (inv_VDMSet' (inv_VDMNat1) v13)"

	
	
abbreviation
	v14 :: "VDMNat1 VDMSet"
where
	"v14 \<equiv> (elems t10)"

	definition
	inv_v14 :: "\<bool>"
where
	"inv_v14  \<equiv> (inv_VDMSet' (inv_VDMNat1) v14)"

	
	
abbreviation
	v15 :: "VDMNat1 VDMSeq"
where
	"v15 \<equiv> (conc t13)"

	definition
	inv_v15 :: "\<bool>"
where
	"inv_v15  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v15)"

	
	
abbreviation
	v16 :: "VDMNat1 VDMSeq1"
where
	"v16 \<equiv> (vdm_reverse t10)"

	definition
	inv_v16 :: "\<bool>"
where
	"inv_v16  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v16)"

	
	
abbreviation
	v17 :: "VDMNat1 VDMSeq1"
where
	"v17 \<equiv> (t10 @ t10)"

	definition
	inv_v17 :: "\<bool>"
where
	"inv_v17  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v17)"

	
	
abbreviation
	v18 :: "VDMNat1 VDMSeq"
where
	"v18 \<equiv> (t10 {(2::VDMNat1)$$(3::VDMNat1)})"

	definition
	inv_v18 :: "\<bool>"
where
	"inv_v18  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v18)"

	
	
abbreviation
	v19 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v19 \<equiv> (vdm_merge {t14, t15})"

	definition
	inv_v19 :: "\<bool>"
where
	"inv_v19  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v19)"

	
	
abbreviation
	v20 :: "VDMNat1 VDMSet"
where
	"v20 \<equiv> (dom t14)"

	definition
	inv_v20 :: "\<bool>"
where
	"inv_v20  \<equiv> (inv_VDMSet' (inv_VDMNat1) v20)"

	
	
abbreviation
	v21 :: "VDMNat1 VDMSet"
where
	"v21 \<equiv> (rng t14)"

	definition
	inv_v21 :: "\<bool>"
where
	"inv_v21  \<equiv> (inv_VDMSet' (inv_VDMNat1) v21)"

	
	
abbreviation
	v22 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v22 \<equiv> (vdm_inverse t14)"

	definition
	inv_v22 :: "\<bool>"
where
	"inv_v22  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v22)"

	
	
abbreviation
	v23 :: "VDMNat1"
where
	"v23 \<equiv> ((4::VDMNat1) + (3::VDMNat1))"

	definition
	inv_v23 :: "\<bool>"
where
	"inv_v23  \<equiv> (inv_VDMNat1 v23)"

	
	
abbreviation
	v24 :: "VDMInt"
where
	"v24 \<equiv> ((4::VDMNat1) - (2::VDMNat1))"

	definition
	inv_v24 :: "\<bool>"
where
	"inv_v24  \<equiv> (inv_VDMInt v24)"

	
	
abbreviation
	v25 :: "VDMNat1"
where
	"v25 \<equiv> ((4::VDMNat1) * (2::VDMNat1))"

	definition
	inv_v25 :: "\<bool>"
where
	"inv_v25  \<equiv> (inv_VDMNat1 v25)"

	
	
abbreviation
	v26 :: "VDMInt"
where
	"v26 \<equiv> ((4::VDMNat1) vdmdiv (2::VDMNat1))"

	definition
	inv_v26 :: "\<bool>"
where
	"inv_v26  \<equiv> (inv_VDMInt v26)"

	
	
abbreviation
	v27 :: "VDMReal"
where
	"v27 \<equiv> ((4::VDMNat1) / (2::VDMNat1))"

	definition
	inv_v27 :: "\<bool>"
where
	"inv_v27  \<equiv> (inv_VDMReal v27)"

	
	
abbreviation
	v28 :: "VDMInt"
where
	"v28 \<equiv> ((4::VDMNat1) vdmmod (3::VDMNat1))"

	definition
	inv_v28 :: "\<bool>"
where
	"inv_v28  \<equiv> (inv_VDMInt v28)"

	
	
abbreviation
	v29 :: "VDMInt"
where
	"v29 \<equiv> ((4::VDMNat1) vdmrem (3::VDMNat1))"

	definition
	inv_v29 :: "\<bool>"
where
	"inv_v29  \<equiv> (inv_VDMInt v29)"

	
	
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

	
	
abbreviation
	v31 :: "\<bool>"
where
	"v31 \<equiv> ((3::VDMNat1) = (3::VDMNat1))"

	definition
	inv_v31 :: "\<bool>"
where
	"inv_v31  \<equiv> (inv_bool v31)"

	
	
abbreviation
	v32 :: "\<bool>"
where
	"v32 \<equiv> ((3::VDMNat1) \<noteq> (4::VDMNat1))"

	definition
	inv_v32 :: "\<bool>"
where
	"inv_v32  \<equiv> (inv_bool v32)"

	
	
abbreviation
	v33 :: "\<bool>"
where
	"v33 \<equiv> ((4::VDMNat1) \<le> (5::VDMNat1))"

	definition
	inv_v33 :: "\<bool>"
where
	"inv_v33  \<equiv> (inv_bool v33)"

	
	
abbreviation
	v34 :: "\<bool>"
where
	"v34 \<equiv> ((4::VDMNat1) < (5::VDMNat1))"

	definition
	inv_v34 :: "\<bool>"
where
	"inv_v34  \<equiv> (inv_bool v34)"

	
	
abbreviation
	v35 :: "\<bool>"
where
	"v35 \<equiv> ((5::VDMNat1) \<ge> (4::VDMNat1))"

	definition
	inv_v35 :: "\<bool>"
where
	"inv_v35  \<equiv> (inv_bool v35)"

	
	
abbreviation
	v36 :: "\<bool>"
where
	"v36 \<equiv> ((5::VDMNat1) > (4::VDMNat1))"

	definition
	inv_v36 :: "\<bool>"
where
	"inv_v36  \<equiv> (inv_bool v36)"

	
	
abbreviation
	v37 :: "VDMNat option"
where
	"v37 \<equiv> None"

	definition
	inv_v37 :: "\<bool>"
where
	"inv_v37  \<equiv> (inv_Option (inv_VDMNat) v37)"

	
	
abbreviation
	v371 :: "VDMNat option"
where
	"v371 \<equiv> Some((100::VDMNat1))"

	definition
	inv_v371 :: "\<bool>"
where
	"inv_v371  \<equiv> (inv_Option (inv_VDMNat) v371)"

	
	
abbreviation
	v38 :: "'UNKNOWN option"
where
	"v38 \<equiv> None"

	definition
	inv_v38 :: "\<bool>"
where
	"inv_v38  \<equiv> (inv_Option inv_True
	\<comment>\<open>Unknown VDM types will generate Isabelle additional type variable `a warning.\<close> v38)"

	
	
abbreviation
	v39 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v39 \<equiv> (t14 \<dagger> t15)"

	definition
	inv_v39 :: "\<bool>"
where
	"inv_v39  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v39)"

	
	
abbreviation
	v40 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v40 \<equiv> (t9 \<triangleleft> t14)"

	definition
	inv_v40 :: "\<bool>"
where
	"inv_v40  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v40)"

	
	
abbreviation
	v41 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v41 \<equiv> (t9 -\<triangleleft> t14)"

	definition
	inv_v41 :: "\<bool>"
where
	"inv_v41  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v41)"

	
	
abbreviation
	v42 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v42 \<equiv> (t14 \<triangleright> t9)"

	definition
	inv_v42 :: "\<bool>"
where
	"inv_v42  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v42)"

	
	
abbreviation
	v43 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v43 \<equiv> (t14 \<triangleright>- t9)"

	definition
	inv_v43 :: "\<bool>"
where
	"inv_v43  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v43)"

	
	
abbreviation
	v44 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v44 \<equiv> (t14 \<union>m t15)"

	definition
	inv_v44 :: "\<bool>"
where
	"inv_v44  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v44)"

	
	
abbreviation
	v45 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v45 \<equiv> (t14 \<circ>m t15)"

	definition
	inv_v45 :: "\<bool>"
where
	"inv_v45  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v45)"

	
	
abbreviation
	v46 :: "\<bool>"
where
	"v46 \<equiv> (\<not> t1)"

	definition
	inv_v46 :: "\<bool>"
where
	"inv_v46  \<equiv> (inv_bool v46)"

	
	
abbreviation
	v47 :: "\<bool>"
where
	"v47 \<equiv> (t1 \<and> t1)"

	definition
	inv_v47 :: "\<bool>"
where
	"inv_v47  \<equiv> (inv_bool v47)"

	
	
abbreviation
	v48 :: "\<bool>"
where
	"v48 \<equiv> (t1 \<or> t1)"

	definition
	inv_v48 :: "\<bool>"
where
	"inv_v48  \<equiv> (inv_bool v48)"

	
	
abbreviation
	v49 :: "\<bool>"
where
	"v49 \<equiv> (t1 \<longrightarrow> t1)"

	definition
	inv_v49 :: "\<bool>"
where
	"inv_v49  \<equiv> (inv_bool v49)"

	
	
abbreviation
	v50 :: "\<bool>"
where
	"v50 \<equiv> (t1 \<longleftrightarrow> t1)"

	definition
	inv_v50 :: "\<bool>"
where
	"inv_v50  \<equiv> (inv_bool v50)"

	
	
abbreviation
	v51 :: "\<bool>"
where
	"v51 \<equiv> ((1::VDMNat1) \<in> t9)"

	definition
	inv_v51 :: "\<bool>"
where
	"inv_v51  \<equiv> (inv_bool v51)"

	
	
abbreviation
	v52 :: "\<bool>"
where
	"v52 \<equiv> ((5::VDMNat1) \<notin> t9)"

	definition
	inv_v52 :: "\<bool>"
where
	"inv_v52  \<equiv> (inv_bool v52)"

	
	
abbreviation
	v53 :: "VDMNat VDMSet"
where
	"v53 \<equiv> (t9 \<union> t11)"

	definition
	inv_v53 :: "\<bool>"
where
	"inv_v53  \<equiv> (inv_VDMSet' (inv_VDMNat) v53)"

	
	
abbreviation
	v54 :: "VDMNat VDMSet"
where
	"v54 \<equiv> (t9 \<inter> t11)"

	definition
	inv_v54 :: "\<bool>"
where
	"inv_v54  \<equiv> (inv_VDMSet' (inv_VDMNat) v54)"

	
	
abbreviation
	v55 :: "VDMNat VDMSet"
where
	"v55 \<equiv> (t9 - t11)"

	definition
	inv_v55 :: "\<bool>"
where
	"inv_v55  \<equiv> (inv_VDMSet' (inv_VDMNat) v55)"

	
	
abbreviation
	v56 :: "\<bool>"
where
	"v56 \<equiv> (t9 \<subseteq> t11)"

	definition
	inv_v56 :: "\<bool>"
where
	"inv_v56  \<equiv> (inv_bool v56)"

	
	
abbreviation
	v57 :: "\<bool>"
where
	"v57 \<equiv> (t9 \<subset> t11)"

	definition
	inv_v57 :: "\<bool>"
where
	"inv_v57  \<equiv> (inv_bool v57)"

	
	
abbreviation
	v58 :: "VDMNat1 VDMSet"
where
	"v58 \<equiv> {(1::VDMNat1)..(3::VDMNat1)}"

	definition
	inv_v58 :: "\<bool>"
where
	"inv_v58  \<equiv> (inv_VDMSet' (inv_VDMNat1) v58)"

	
	
abbreviation
	v59 :: "VDMNat1 VDMSet1"
where
	"v59 \<equiv> {(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (4::VDMNat1)}"

	definition
	inv_v59 :: "\<bool>"
where
	"inv_v59  \<equiv> (inv_VDMSet1' (inv_VDMNat1) v59)"

	
	
abbreviation
	v60 :: "VDMNat1 VDMSeq1"
where
	"v60 \<equiv> [(1::VDMNat1), (3::VDMNat1), (4::VDMNat1)]"

	definition
	inv_v60 :: "\<bool>"
where
	"inv_v60  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) v60)"

	
	
abbreviation
	v61 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v61 \<equiv> [(1::VDMNat1)\<mapsto>(2::VDMNat1),(2::VDMNat1)\<mapsto>(3::VDMNat1)]"

	definition
	inv_v61 :: "\<bool>"
where
	"inv_v61  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v61)"

	
	
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

	
	
abbreviation
	v65 :: "R"
where
	"v65 \<equiv> \<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>"

	definition
	inv_v65 :: "\<bool>"
where
	"inv_v65  \<equiv> inv_R v65"

	
	
abbreviation
	v651 :: "VDMNat"
where
	"v651 \<equiv> (x\<^sub>R (\<lparr>x\<^sub>R = (1::VDMNat1), y\<^sub>R = (2::VDMNat1)\<rparr>))"

	definition
	inv_v651 :: "\<bool>"
where
	"inv_v651  \<equiv> (inv_VDMNat v651)"

	
	
abbreviation
	v652 :: "VDMNat"
where
	"v652 \<equiv> (x\<^sub>R (v65))"

	definition
	inv_v652 :: "\<bool>"
where
	"inv_v652  \<equiv> (inv_VDMNat v652)"

	
	
abbreviation
	v653 :: "VDMNat"
where
	"v653 \<equiv> (x\<^sub>R ((mkr (1::VDMNat1))))"

	definition
	inv_v653 :: "\<bool>"
where
	"inv_v653  \<equiv> (inv_VDMNat v653)"

	
	
abbreviation
	v67 :: "R"
where
	"v67 \<equiv> (v65)\<lparr>x\<^sub>R := (10::VDMNat1), y\<^sub>R := (20::VDMNat1)\<rparr>"

	definition
	inv_v67 :: "\<bool>"
where
	"inv_v67  \<equiv> inv_R v67"

	
	
abbreviation
	v68 :: "VDMNat1"
where
	"v68 \<equiv> (fst (v64))"

	definition
	inv_v68 :: "\<bool>"
where
	"inv_v68  \<equiv> (inv_VDMNat1 v68)"

	
	
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

	
	
abbreviation
	v72 :: "VDMNat1"
where
	"v72 \<equiv> vdm_narrow_real (((4.0))::VDMReal)"

	definition
	inv_v72 :: "\<bool>"
where
	"inv_v72  \<equiv> (inv_VDMNat1 v72)"

	
	
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
	"v73 \<equiv> (THE var. (((var \<in>t9)) \<and> (var < (2::VDMNat1))))"

	definition
	inv_v73 :: "\<bool>"
where
	"inv_v73  \<equiv> (inv_VDMNat1 v73)"

	
	
abbreviation
	v731 :: "R"
where
	"v731 \<equiv> (THE dummy0. (((dummy0 \<in>{v65})) \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y))))"

	definition
	inv_v731 :: "\<bool>"
where
	"inv_v731  \<equiv> inv_R v731"

	
	
abbreviation
	v74 :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> VDMNat"
where
	"v74 \<equiv> (
	\<lambda> (var :: VDMNat)  (var2 :: VDMNat) .
		(if (((inv_VDMNat var))) \<and>  (((inv_VDMNat var2))) then
		(var + var2)
	 else
		undefined
	)
	)"

	definition
	inv_v74 :: "VDMNat\<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
	"inv_v74 dummy0 dummy1 \<equiv> 
	\<comment>\<open>function type invariant depends on its lambda definition dummy names used being equal.\<close>
	(inv_VDMNat (v74 dummy0 dummy1))"

	
	
abbreviation
	v741 :: "R \<Rightarrow> VDMNat"
where
	"v741 \<equiv> (
	\<lambda> (dummy0 :: R) .let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
		(if (( (((inv_VDMNat (x\<^sub>R dummy0))) \<and>
		 ((inv_VDMNat (y\<^sub>R dummy0))) ))) then
		(x + y)
	 else
		undefined
	)
	)"

	definition
	inv_v741 :: "R \<Rightarrow> \<bool>"
where
	"inv_v741 dummy0 \<equiv> 
	\<comment>\<open>function type invariant depends on its lambda definition dummy names used being equal.\<close>
	(inv_VDMNat (v741 dummy0))"

	
	
abbreviation
	v75 :: "\<bool>"
where
	"v75 \<equiv> (\<exists>! var \<in> t9  . (var < (2::VDMNat1)))"

	definition
	inv_v75 :: "\<bool>"
where
	"inv_v75  \<equiv> (inv_bool v75)"

	
	
abbreviation
	v76 :: "\<bool>"
where
	"v76 \<equiv> (\<exists> var \<in> t9  . (var < (2::VDMNat1)))"

	definition
	inv_v76 :: "\<bool>"
where
	"inv_v76  \<equiv> (inv_bool v76)"

	
	
abbreviation
	v78 :: "\<bool>"
where
	"v78 \<equiv> (\<forall> var \<in> t9  . (var \<le> (3::VDMNat1)))"

	definition
	inv_v78 :: "\<bool>"
where
	"inv_v78  \<equiv> (inv_bool v78)"

	
	
abbreviation
	v781 :: "\<bool>"
where
	"v781 \<equiv> (\<forall> dummy0 \<in> {v65}  . (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (y < x)))"

	definition
	inv_v781 :: "\<bool>"
where
	"inv_v781  \<equiv> (inv_bool v781)"

	
	
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

	
	
abbreviation
	v791 :: "VDMNat"
where
	"v791 \<equiv> (
		let 
(dummy0::R) = v65;
		
(var1::VDMNat) = (10::VDMNat1)
		in
			let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in 
		(if (inv_R dummy0) \<and> 
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

	
	
abbreviation
	v80 :: "VDMNat1"
where
	"v80 \<equiv> (
		SOME (dummy0::VDMNat1) .(dummy0 \<in> { (x + y) | x  y .  ((x \<in>t9)) \<and>  ((y \<in>t9))  \<and> ((x > (2::VDMNat1)) \<and> (y < x)) }))"

	definition
	inv_v80 :: "\<bool>"
where
	"inv_v80  \<equiv> (inv_VDMNat1 v80)"

	
	
abbreviation
	v801 :: "VDMNat"
where
	"v801 \<equiv> (
		SOME (dummy0::VDMNat) .(dummy0 \<in> { (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x + y)) | dummy0 .  ((dummy0 \<in>{v65}))  \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x < y)) }))"

	definition
	inv_v801 :: "\<bool>"
where
	"inv_v801  \<equiv> (inv_VDMNat v801)"

	
	
abbreviation
	v81 :: "VDMNat1 VDMSet"
where
	"v81 \<equiv> { var .   ((var \<in>t9))  \<and> (var > (1::VDMNat1)) }"

	definition
	inv_v81 :: "\<bool>"
where
	"inv_v81  \<equiv> (inv_VDMSet' (inv_VDMNat1) v81)"

	
	
abbreviation
	v810 :: "VDMNat VDMSet"
where
	"v810 \<equiv> { (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (x + y)) | dummy0 .  ((dummy0 \<in>{v65}))  \<and> (let x = (x\<^sub>R dummy0); y = (y\<^sub>R dummy0) in (y < x)) }"

	definition
	inv_v810 :: "\<bool>"
where
	"inv_v810  \<equiv> (inv_VDMSet' (inv_VDMNat) v810)"

	
	
abbreviation
	v82 :: "VDMNat1 VDMSet"
where
	"v82 \<equiv> { (var + var2) | var  var2 .  ((var \<in>t9)) \<and>  ((var2 \<in>(elems t10)))  \<and> (var > var2) }"

	definition
	inv_v82 :: "\<bool>"
where
	"inv_v82  \<equiv> (inv_VDMSet' (inv_VDMNat1) v82)"

	
	
abbreviation
	v83 :: "VDMNat1 VDMSeq"
where
	"v83 \<equiv> [ var . var \<leftarrow> sorted_list_of_set (t9) , ((var \<in>t9)) , (var > (1::VDMNat1)) ] \<comment>\<open>Set bind `(var \<in> t9)` in sequence comprehension requires its Isabelle type to instantiate class linorder.  This can be a problem if the target type of @{term \<open>t9\<close>}  has a VDM ord_ predicate.\<close> "

	definition
	inv_v83 :: "\<bool>"
where
	"inv_v83  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v83)"

	
	
abbreviation
	v830 :: "VDMNat VDMSeq"
where
	"v830 \<equiv> [ (let x = (x\<^sub>R dummy0); _ = (_\<^sub>R dummy0) in x) . dummy0 \<leftarrow> sorted_list_of_set ({v65}) , ((dummy0 \<in>{v65})) , (let x = (x\<^sub>R dummy0); _ = (_\<^sub>R dummy0) in ((0::VDMNat) < x)) ] \<comment>\<open>Set bind `(dummy0 \<in> {v65})` in sequence comprehension requires its Isabelle type to instantiate class linorder.  This can be a problem if the target type of @{term \<open>{v65}\<close>}  has a VDM ord_ predicate.\<close> "

	definition
	inv_v830 :: "\<bool>"
where
	"inv_v830  \<equiv> (inv_VDMSeq' (inv_VDMNat) v830)"

	
	
abbreviation
	v84 :: "VDMNat1 VDMSeq"
where
	"v84 \<equiv> [ var . var \<leftarrow> t10 , ((var \<in>(elems t10))) , (var > (1::VDMNat1)) ]"

	definition
	inv_v84 :: "\<bool>"
where
	"inv_v84  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v84)"

	
	
abbreviation
	v88 :: "VDMNat1 VDMSeq"
where
	"v88 \<equiv> [ var . var \<leftarrow> [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (7::VDMNat1), (8::VDMNat1), (9::VDMNat1)] , ((var \<in>(elems [(1::VDMNat1), (2::VDMNat1), (3::VDMNat1), (7::VDMNat1), (8::VDMNat1), (9::VDMNat1)]))) , (var > (4::VDMNat1)) ]"

	definition
	inv_v88 :: "\<bool>"
where
	"inv_v88  \<equiv> (inv_VDMSeq' (inv_VDMNat1) v88)"

	
	
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

	
	
abbreviation
	v921 :: "VDMNat"
where
	"v921 \<equiv> (
		let 
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

	
	
abbreviation
	v93 :: "VDMNat"
where
	"v93 \<equiv> (\<comment>\<open>Isabelle `case` requires types it can deconstruct (e.g. tuples, datatypes, etc.). VDMSL `cases` is richer, hence som errors might occur.\<close>case v37 of None \<Rightarrow> (0::VDMNat)| 
		v \<Rightarrow> (v + v))"

	definition
	inv_v93 :: "\<bool>"
where
	"inv_v93  \<equiv> (inv_VDMNat v93)"

	
	
abbreviation
	[A  B] :: "VDMNat1 VDMSeq1"
where
	"[A  B] \<equiv> [(1::VDMNat1), (2::VDMNat1)]"

	definition
	inv_[A  B] :: "\<bool>"
where
	"inv_[A  B]  \<equiv> (inv_VDMSeq1' (inv_VDMNat1) [A  B])"

	
	
abbreviation
	v94 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v94 \<equiv> [(1::VDMNat1)\<mapsto>(2::VDMNat1),(2::VDMNat1)\<mapsto>(3::VDMNat1),(4::VDMNat1)\<mapsto>(5::VDMNat1)]"

	definition
	inv_v94 :: "\<bool>"
where
	"inv_v94  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v94)"

	
	
abbreviation
	v95 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v95 \<equiv> null"

	definition
	inv_v95 :: "\<bool>"
where
	"inv_v95  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v95)"

	
	
abbreviation
	v952 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v952 \<equiv> null"

	definition
	inv_v952 :: "\<bool>"
where
	"inv_v952  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v952)"

	
	
abbreviation
	v953 :: "(R \<rightharpoonup> VDMNat1)"
where
	"v953 \<equiv> null"

	definition
	inv_v953 :: "\<bool>"
where
	"inv_v953  \<equiv> (inv_Map inv_R  (inv_VDMNat1) v953)"

	
	
abbreviation
	v954 :: "(VDMNat1 \<rightharpoonup> VDMNat1)"
where
	"v954 \<equiv> null"

	definition
	inv_v954 :: "\<bool>"
where
	"inv_v954  \<equiv> (inv_Map (inv_VDMNat1) (inv_VDMNat1) v954)"

	
	

definition
	pre_v96 :: "\<bool>"
where
	"pre_v96  \<equiv> True"


definition
	post_v96 :: "(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> \<bool>"
where
	"post_v96 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_v96 specification\<close>
		((inv_Map (inv_VDMNat) (inv_VDMNat) RESULT))"

definition
	v96 :: "(VDMNat \<rightharpoonup> VDMNat)"
where
	"v96  \<equiv> 
	\<comment>\<open>User defined body of v96\<close>
	null"

	

definition
	pre_v961 :: "\<bool>"
where
	"pre_v961  \<equiv> True"


definition
	post_v961 :: "(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> \<bool>"
where
	"post_v961 RESULT \<equiv> 
		\<comment>\<open>Implicitly defined type invariant checks for undeclared post_v961 specification\<close>
		((inv_Map (inv_VDMNat) (inv_VDMNat) RESULT))"

definition
	v961 :: "(VDMNat \<rightharpoonup> VDMNat)"
where
	"v961  \<equiv> 
	\<comment>\<open>User defined body of v961\<close>
	null"

end