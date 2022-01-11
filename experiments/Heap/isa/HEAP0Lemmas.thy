(* $Id$ *)
theory HEAP0Lemmas
imports HEAP0
begin

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
section \<open> HEAP0 Isabelle (automation) lemmas \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsection \<open> locs_of weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* Bridge: locs_of as set interval (useful to access Set_Interval lemmas) *)
lemma b_locs_of_as_set_interval:
	"nat1 n \<Longrightarrow> locs_of l n = {l..<l+n}"
unfolding locs_of_def
by (metis Collect_conj_eq atLeastLessThan_def atLeast_def lessThan_def)

(* Bridge: locs_of is finite *)
lemma b_locs_of_finite:
	"nat1 n \<Longrightarrow> finite(locs_of i n)"
by (metis finite_atLeastLessThan b_locs_of_as_set_interval)

(* Bridge: locs_of is not empty *)
lemma b_locs_of_non_empty:
	"nat1 n \<Longrightarrow> locs_of l n \<noteq> {}"
	unfolding locs_of_def nat1_def inv_VDMNat1_def
	by (metis Collect_empty_eq comm_monoid_add_class.add_0 le_eq_less_or_eq less_add_eq_less nat_int_comparison(1) pos_int_cases)

(* Bridge: locs_of specific cardinality *)
lemma l_locs_of_card:
	"nat1 n \<Longrightarrow> card(locs_of l n) = n"
by (metis add_diff_cancel_left' b_locs_of_as_set_interval card_atLeastLessThan)

end