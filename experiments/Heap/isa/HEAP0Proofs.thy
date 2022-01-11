(* $Id$ *)
theory HEAP0Proofs
imports HEAP0 HEAP0Lemmas
begin

(*========================================================================*)
section \<open> Feasibility proof obligations for HEAP level 0 \<close>
(*========================================================================*)

context level0_new 
begin

theorem
  locale0_new_FSB: "PO_new0_feasibility"
unfolding PO_new0_feasibility_def
by (metis F0_inv_defs 
		 finite_Diff 
		 l0_invariant_def 
		 new0_post_def 
		 new0_postcondition_def 
		 new0_pre_def 
		 l0_new0_precondition_def)

end

context level0_dispose
begin

theorem
  locale0_dispose_FSB: "PO_dispose0_feasibility"
unfolding PO_dispose0_feasibility_def dispose0_postcondition_def dispose0_post_defs 
by (metis (full_types) F0_inv_defs finite_M_bounded_by_nat finite_Un l0_input_notempty_def l0_invariant_def)

end

end