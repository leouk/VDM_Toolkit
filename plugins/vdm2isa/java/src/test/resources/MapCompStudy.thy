theory MapCompStudy
imports VDMToolkit
begin

(* { x+y \<mapsto> 10 | x \<in> {1,2,3}, y \<in> {4,5,6} } *)
lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2,3::nat} \<and> y \<in> {4,5,6::nat} \<and> dummy = x + y) then Some 10 else None) = 
  [5 \<mapsto> 10, 6 \<mapsto> 10, 7 \<mapsto> 10, 8 \<mapsto> 10, 9 \<mapsto> 10]"
  apply rule
  find_theorems "(if _ then _ else _) = _" -name:SMT
  apply (simp split:if_splits)
  apply rule+
        apply (elim exE conjE)
  apply simp  
        apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
(*
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
  apply rule+
        apply (elim exE conjE)
  apply simp  
  apply (smt (z3) add_Suc add_cancel_right_left eval_nat_numeral(3) numeral_1_eq_Suc_0 numeral_Bit0)
*)
  oops

(* { x+y \<mapsto> True | x \<in> {1,2,3}, y \<in> {4,5,6} } ; use true so that we can get past the if without the blowup ? *)
lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2,3::nat} \<and> y \<in> {4,5,6::nat} \<and> dummy = x + y) then Some True else None) = 
  [5 \<mapsto> True, 6 \<mapsto> True, 7 \<mapsto> True, 8 \<mapsto> True, 9 \<mapsto> True]"
  apply rule
  apply (cut_tac if_bool_eq_conj)  
  apply simp
  oops

lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2,3::nat} \<and> y \<in> {4,5,6::nat} \<and> dummy = x + y) then Some 10 else None) = 
  [5 \<mapsto> 10, 6 \<mapsto> 10, 7 \<mapsto> 10, 8 \<mapsto> 10, 9 \<mapsto> 10]"
  apply rule 
  find_theorems "(if _ then _ else _) = _" -name:SMT
  apply (simp split:if_splits)
  apply (intro conjI impI, elim exE conjE) oops

lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2::nat} \<and> y \<in> {4,5::nat} \<and> dummy = x + y) then Some 10 else None) = 
  [5 \<mapsto> 10, 6 \<mapsto> 10, 7 \<mapsto> 10]"
  apply rule 
  find_theorems "(if _ then _ else _) = _" -name:SMT
  apply (simp split:if_splits)
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
     apply rule+
     apply (metis One_nat_def Suc_numeral plus_1_eq_Suc semiring_norm(5) semiring_norm(8))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
      apply blast
      apply (metis add_2_eq_Suc eval_nat_numeral(2) eval_nat_numeral(3) semiring_norm(28))
  apply rule+
      apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
    apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
    apply rule+
     apply (metis One_nat_def eval_nat_numeral(2) plus_1_eq_Suc semiring_norm(28))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
  apply rule+
  apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
   apply rule+
      apply (metis add_2_eq_Suc eval_nat_numeral(2) eval_nat_numeral(3) semiring_norm(28))
  apply rule+
      apply (metis add_2_eq_Suc eval_nat_numeral(2) eval_nat_numeral(3) semiring_norm(28))
    apply (smt (z3) One_nat_def add_2_eq_Suc eval_nat_numeral(3) numeral_eq_iff plus_1_eq_Suc semiring_norm(89) semiring_norm(90))
      apply (metis add_2_eq_Suc eval_nat_numeral(2) eval_nat_numeral(3) semiring_norm(28))
  done

type_synonym  Map = "nat \<rightharpoonup> nat"

value "[1::nat \<mapsto> 2::nat, 1 \<mapsto> 3] 1"

(* { d |-> r | d in set {1,2::nat}, r in set {2,4::nat} & r = d*2 } *)
lemma "(\<lambda> dummy::nat . if (\<exists> d r . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2::nat} \<and> r \<in> {2,4::nat} \<and> dummy = d \<and> r = d*2) then 
              Some 10 
          else undefined) = 
  [1 \<mapsto> 10, 2 \<mapsto> 10, 3 \<mapsto> 10]"
    apply rule 
  apply (simp split:if_splits)
  find_theorems "undefined"

  oops

(* { d |-> 10 | d in set {1,2::nat}, r in set {2,4::nat} & r = d*2 } *)
lemma "(\<lambda> dummy::nat . if (\<exists> d r . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2::nat} \<and> r \<in> {2,4::nat} \<and> dummy = d \<and> r = d*2) then 
              Some 10 
          else None) = 
  [1 \<mapsto> 10, 2 \<mapsto> 10]"
  unfolding inv_VDMNat_def
    apply rule 
  by (simp split:if_splits)
  
(* { d |-> r | d in set {1,2::nat}, r in set {2,4::nat} & r = d*2 } *)
lemma "(\<lambda> dummy::nat . if (\<exists> d r . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2::VDMNat} \<and> r \<in> {2,4::VDMNat} \<and> dummy = d \<and> r = d*2) then 
              Some (THE r . (\<exists> d . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2::VDMNat} \<and> r \<in> {2,4::VDMNat} \<and> dummy = d \<and> r = d*2)) 
          else None) = 
  [1 \<mapsto> 2, 2 \<mapsto> 3, 3 \<mapsto> 6]" (* DUH! mistaken input set! *)
  unfolding inv_VDMNat_def
    apply rule 
  apply (simp split:if_splits)
  apply (rule+, simp_all)
  apply rule+ (* THE is not quite right; SOME?! NOOOO 2\<mapsto> 4 dummy! *)
  oops

(* { d |-> r | d in set {1,2,3::nat}, r in set {2,4,6::nat} & r = d*2 } *)
lemma "(\<lambda> dummy::nat . if (\<exists> d r . inv_VDMNat d \<and> inv_VDMNat r \<and> d \<in> {1,2,3::VDMNat} \<and> r \<in> {2,4,6::VDMNat} \<and> dummy = d \<and> r = d*2) then 
              Some (THE r . (\<exists> v . dummy = v \<and> r = v*2)) 
          else None) = 
  [1 \<mapsto> 2, 2 \<mapsto> 4, 3 \<mapsto> 6]"
  unfolding inv_VDMNat_def
    apply rule 
  by (simp split:if_splits) 

(* { d |-> r | d in set {1,2,3::nat}, r in set {2,4,6::nat} & r = d*2 } *)
lemma mapComp1: "(\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r = d*2) then 
              Some (THE r . (\<exists> d \<in> {1,2,3::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r \<in> {2,4,6::VDMNat} \<and> r = d*2)) 
          else None) = 
  [1 \<mapsto> 2, 2 \<mapsto> 4, 3 \<mapsto> 6]"
  unfolding inv_VDMNat_def
  apply rule
  apply (simp split:if_splits) 
  apply (rule+, simp_all) 
  apply (rule+, simp_all)
  by auto 
  
definition 
  mapComp1 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "mapComp1 \<equiv> (\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r = d*2) then
              Some (THE r . (\<exists> d \<in> {1,2::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> r \<in> {2,4,6::VDMNat} \<and> dummy = d \<and> r = d*2)) 
          else None)"

lemma "x \<notin> {1,2,3::VDMNat} \<Longrightarrow>  mapComp1 x = None"
  by (simp add: mapComp1_def inv_VDMNat_def)

lemma "\<not> inv_VDMNat x  \<Longrightarrow> mapComp1  x = None"
  by (simp add: mapComp1_def inv_VDMNat_def)

lemma "x \<in> {1,2,3::VDMNat} \<Longrightarrow> v \<in> {2,4,6::VDMNat} \<Longrightarrow> mapComp1 x = Some v"
  apply (simp add: mapComp1_def inv_VDMNat_def)
  apply (safe, simp_all)
  find_theorems "(THE _ . _) = _"
          apply (rule the1_equality, simp_all)
  find_theorems "(\<exists>! _ . _)" intro 
  apply (rule_tac a=2 in ex1I, safe, simp)
          apply (rule the1_equality, simp_all)
  apply (rule_tac a=2 in ex1I, safe, simp) defer
          apply (rule the1_equality, simp_all)
          apply (rule_tac a=2 in ex1I, safe, simp) defer
          apply (rule the1_equality, simp_all)
          apply (rule_tac a=4 in ex1I, safe, simp) defer
         apply (rule the1_equality) defer defer
          apply (rule the1_equality, simp_all)
  apply (rule_tac a=4 in ex1I, safe, simp)
          apply (rule the1_equality, simp_all)
  apply (rule_tac a=4 in ex1I, safe, simp) defer
          apply (rule the1_equality) defer defer
          apply (rule the1_equality) 
   (* Ah! has to be THE on both domain and range? No: the mapping isn't direct of course! *)
  oops

definition 
  mapComp2 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "mapComp2 \<equiv> (\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r = d*2) then
              Some (THE r . (\<exists> d \<in> {1,2, 3::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> r \<in> {2,4,6::VDMNat} \<and> dummy = d \<and> r = d*2)) 
          else None)"

lemma "x \<notin> dom mapComp2  \<Longrightarrow>  mapComp2 x = None"
  by (simp add: domIff mapComp2_def)

lemma "dom mapComp2 = {1,2,3::VDMNat}"
  unfolding dom_def mapComp2_def inv_VDMNat_def
  by (simp split:if_splits, safe)

lemma "rng mapComp2 = {2,4,6::VDMNat}"
  unfolding ran_def rng_def mapComp2_def inv_VDMNat_def
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all)
   apply (elim exE conjE impE)
  (* this will be fiddly! *)
  oops

lemma "rng mapComp2 = {2,4,6::VDMNat}"
  unfolding ran_def rng_def mapComp2_def inv_VDMNat_def
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all)
   apply (elim exE conjE disjE, simp_all)
     apply fastforce
  apply fastforce
   apply fastforce
  by (smt (z3) semiring_norm(83) the_equality verit_eq_simplify(14) zero_le_numeral)

end