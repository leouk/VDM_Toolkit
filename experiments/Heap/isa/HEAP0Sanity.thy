(* $Id$ *)
(*<*)
theory HEAP0Sanity
imports HEAP0
begin
(*>*)
(*------------------------------------------------------------------------*)
section \<open> Proof of Some Properties of Interest \<close>
(*------------------------------------------------------------------------*)

(*------------------------------------------------------------------------*)
subsection \<open> Invariant \<close>
(*------------------------------------------------------------------------*)

definition 
  F0_ex :: "F0"
where
  "F0_ex \<equiv> {0,1,2,3}"

(* 
value "F0_inv {0, 1, 2, 3}" = Wellsortedness error no type arity nat :: finite
*)

definition
  F0_ex_inv :: "F0 \<Rightarrow> bool"
where
  "F0_ex_inv f \<equiv> F0_inv f"

lemmas F0_ex_inv_defs = F0_ex_inv_def F0_inv_def F0_ex_def

(*------------------------------------------------------------------------*)
subsection \<open> Operations \<close>
(*------------------------------------------------------------------------*)

(*------------------------------------------------------------------------*)
(* NEW0(n) shrinks f *)

definition
  PO_new0_post_shrinks_f :: "bool"
where
  "PO_new0_post_shrinks_f \<equiv> (\<forall> f n f' r . new0_post f n f' r \<longrightarrow> f' \<subset> f)"

context level0_new
begin

definition
  PO_new0_postcondition_shrinks_f :: "bool"
where
  "PO_new0_postcondition_shrinks_f \<equiv> (\<forall> f' r . new0_postcondition f' r \<longrightarrow> f' \<subset> f0)"

end

(*------------------------------------------------------------------------*)
(* NEW0(n) shrinks f by n, excactly *)

definition
  PO_new0_post_shrinks_f_exactly :: "bool"
where
  "PO_new0_post_shrinks_f_exactly \<equiv> (\<forall> f0 s0 f' r. finite f0 \<longrightarrow> new0_post f0 s0 f' r \<longrightarrow> card f' = card f0 - s0)"

(*------------------------------------------------------------------------*)
(* DISPOSE0 extends f*)

context level0_dispose
begin

definition
  PO_dispose0_postcondition_extends_f :: "bool"
where
  "PO_dispose0_postcondition_extends_f \<equiv> (\<forall> f'. dispose0_postcondition f' \<longrightarrow> f0 \<subset> f')"


(*------------------------------------------------------------------------*)
(* DISPOSE0 extends f by n exactly*)

definition
  PO_dispose0_postcondition_extends_f_exactly :: "bool"
where
  "PO_dispose0_postcondition_extends_f_exactly \<equiv> (\<forall> f' . dispose0_postcondition f' \<longrightarrow> card f' = (card f0 + s0))"

end

(*------------------------------------------------------------------------*)
(* DISPOSE0 NEW0(n) n = Id *)

definition
  PO_new0_dispose_0_identity :: "bool"
where
  "PO_new0_dispose_0_identity \<equiv> (\<forall> f n f' f'' r . new0_post f n f' r \<and> dispose0_post f' r n f'' \<and> F0_inv f \<longrightarrow> f = f'' \<and> F0_inv f'')"

end
