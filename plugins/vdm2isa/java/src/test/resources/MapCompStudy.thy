theory MapCompStudy
imports Main
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

lemma "(\<lambda> dummy . if (\<exists> x y . x \<in> {1,2,3::nat} \<and> y \<in> {4,5,6::nat} \<and> dummy = x + y) then 
                    Some (SOME z . z \<in> {7,8,9::nat}) 
                  else 
                    None) = M"

end