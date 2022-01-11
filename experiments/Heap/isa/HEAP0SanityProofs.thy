(* $Id$ *)
theory HEAP0SanityProofs
imports HEAP0Sanity HEAP0Proofs
begin

(*------------------------------------------------------------------------*)
section \<open> Proof of some properties of interest \<close>
(*------------------------------------------------------------------------*)

(*------------------------------------------------------------------------*)
subsection \<open> Invariant \<close>
(*------------------------------------------------------------------------*)

(* The invariant holds and fails at expected examples *)
lemma l_F0_inv_example: "F0_ex_inv F0_ex"
unfolding F0_ex_inv_defs by auto

lemma l_F0_inv_counter_example: "\<not> F0_ex_inv UNIV"
unfolding F0_ex_inv_defs by auto

(*------------------------------------------------------------------------*)
subsection \<open> Operations \<close>
(*------------------------------------------------------------------------*)

(*------------------------------------------------------------------------*)
(* NEW0(n) shrinks f *)

lemma new0_post_shrinks_f: 
	"PO_new0_post_shrinks_f"
	unfolding PO_new0_post_shrinks_f_def new0_post_defs
	unfolding nat1_def inv_VDMNat1_def
  apply simp
  apply safe
  by (metis DiffE less_add_same_cancel1 mem_Collect_eq order_refl subset_iff)
(*by (smt Diff_subset mem_Collect_eq inv_VDMNat1_def set_diff_eq set_mp subset_iff_psubset_eq)*)

context level0_new
begin

lemma new0_postcondition_shrinks_f: 
	"PO_new0_postcondition_shrinks_f"
by (smt PO_new0_post_shrinks_f_def PO_new0_postcondition_shrinks_f_def new0_post_shrinks_f new0_postcondition_def)

end

(*------------------------------------------------------------------------*)
(* NEW0(n) shrinks f by n, excactly *)

thm card_Diff_subset[of "locs_of r n" f]

lemma new0_post_shrinks_f_exactly: 
	"PO_new0_post_shrinks_f_exactly"
unfolding PO_new0_post_shrinks_f_exactly_def new0_post_def is_block_def
apply safe
by (simp add: card_Diff_subset b_locs_of_finite b_locs_of_as_set_interval)

(*------------------------------------------------------------------------*)
(* DISPOSE0 extends f*)

context level0_dispose
begin

(* It's interesting what the difference is here: same goal, different proof script *)
lemma dispose0_postcondition_extends_f: 
    "PO_dispose0_postcondition_extends_f"
unfolding PO_dispose0_postcondition_extends_f_def 
          dispose0_postcondition_def
          dispose0_post_def
by (metis Un_commute b_locs_of_non_empty 
          dispose0_pre_def inf_sup_absorb   
          inf_sup_ord(3) l0_dispose0_precondition_def 
          l0_input_notempty_def less_le)

lemma 
	"dispose0_postcondition f' \<Longrightarrow> f0 \<subset> f'"
unfolding dispose0_postcondition_def dispose0_post_def
by (metis b_locs_of_non_empty dispose0_pre_def 
          l0_dispose0_precondition_def inf_absorb2 
          inf_commute inf_sup_ord(4) l0_input_notempty_def 
          le_iff_sup less_le sup.left_idem)
	(*NOTE: we need the precondition *)


(*------------------------------------------------------------------------*)
(* DISPOSE0 extends f by n exactly*)

thm card_Un_disjoint[of f0 "locs_of d0 s0"]
	(* finite f0 \<Longrightarrow>
finite (locs_of d0 s0) \<Longrightarrow>
f0 \<inter> locs_of d0 s0 = {} \<Longrightarrow> card (f0 \<union> locs_of d0 s0) = card f0 + card (locs_of d0 s0)
*)

lemma dispose0_postcondition_extends_f_exactly:
	"PO_dispose0_postcondition_extends_f_exactly"
unfolding PO_dispose0_postcondition_extends_f_exactly_def   
          dispose0_postcondition_def dispose0_post_def F0_inv_def
by (metis Int_commute add_0_iff card_Un_Int card_empty 
          dispose0_pre_def finite_Un l0_dispose0_precondition_def 
          l0_input_notempty_def l_locs_of_card)

lemma 
	"dispose0_postcondition f' \<Longrightarrow> card f' = card f0 + s0"
unfolding dispose0_postcondition_def dispose0_post_def F0_inv_def
by (metis card_Un_Int [symmetric] card_empty comm_monoid_add_class.add.left_neutral 
      dispose0_pre_def finite_Un inf_commute l0_dispose0_precondition_def 
      l0_input_notempty_def l_locs_of_card add.commute)
	(*NOTE: we need the precondition *)
end

(*------------------------------------------------------------------------*)
(* DISPOSE0 NEW0(n) n = Id *)

lemma "PO_new0_dispose_0_identity"
unfolding PO_new0_dispose_0_identity_def 
          new0_post_def dispose0_post_def F0_inv_def
apply (safe)
apply (metis is_block_def set_mp)
apply (metis finite_Diff)
by (metis b_locs_of_finite is_block_def)

lemma new0_dispose_0_identity: 
	"PO_new0_dispose_0_identity"
by (metis PO_new0_dispose_0_identity_def 
          Un_Diff_cancel dispose0_post_def 
          is_block_def new0_post_def sup_absorb1 sup_commute)

end
