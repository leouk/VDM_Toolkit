theory HEAP01ReifyProofs
imports HEAP01ReifyLemmas
begin

(*========================================================================*)
section {* Refinement L0-L1 proof *}
(*========================================================================*)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* Adequacy proof *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(*
lemma "F0_inv f0 \<Longrightarrow> \<exists> f1  . F1_inv f1 \<and> f0 = retr0 f1"
unfolding retr0_def F1_inv_def F0_inv_def
thm finite_induct[of f0 "(\<lambda> x . \<exists> f1  . F1_inv f1 \<and> x = retr0 f1)"]
apply (rule finite_induct)
apply simp
apply (rule_tac x=empty in exI)
apply (metis l_nat1_map_empty l_disjoint_empty l_finite_empty l_locs_empty_iff l_sep_empty)
apply (elim conjE exE)
apply simp
apply (rule_tac x=f1 in exI)
apply simp
oops

lemma "F0_inv f0 \<Longrightarrow> \<exists> f1  . F1_inv f1 \<and> f0 = retr0 f1"
unfolding retr0_def F1_inv_def F0_inv_def
apply (rule exI)
apply (intro conjI)
prefer 5
unfolding locs_def
apply (simp_all)
apply (rule finite_map_upd_induct)
oops
*)

(*
lemma r_l01_retr_adequacy: 
   "PO_l01_adequacy"
unfolding PO_l01_adequacy_def F0_inv_def
apply auto -- this doesn't allow me to call the inductive rule, why? TODO: Ask Iain?
*)

theorem r_l01_retr_adequacy:
   "PO_l01_adequacy"
unfolding PO_l01_adequacy_def F0_inv_def
find_theorems simp:"\<exists>! _ . _" intro --"ex1I isn't quite right"
apply (intro allI impI ex_ex1I)
defer
apply (metis F1_inv_def l_locs_ext retr0_def)
apply (induct_tac rule: contig_nonabut_finite_set_induct) (* Aha! Needs to be induct_tac because of the \<And> f0 ! *)
apply assumption
apply (rule_tac x=empty in exI)
apply (rule conjI)
apply (metis l_locs_empty_iff retr0_def)
apply (metis l_F1_inv_empty)
apply (elim conjE exE)
  (*apply (rule_tac x="f1(Min(F') \<mapsto> card F')" in exI)*)
apply (rule_tac x="f1 \<union>m [Min F' \<mapsto> card F']" in exI)
apply (subgoal_tac "Min F' \<notin> dom f1")
  defer
  apply (metis l_disjoint_retr0_not_in_dom f_F1_inv_nat1_map)
  
  (* choice of witness *)
  apply (rule conjI)
  unfolding retr0_def
  apply (subst l_locs_munion_iff)
    apply (metis f_F1_inv_nat1_map)
    apply (metis l_nat1_map_singleton l_nat1_card)
    find_theorems "locs [_ \<mapsto> _]"
    apply simp
    apply (subst l_locs_singleton_iff)
      apply (metis l_nat1_card)
    thm b_contiguous_locs_off_iff
    apply (simp add: b_contiguous_locs_off_iff)

  (* invariant over chosen witness *)
  apply (rule l_F1_inv_singleton_upd)
    apply (simp add: card_gt_0_iff)
    apply simp
    apply simp
    apply (simp add: b_contiguous_locs_off_iff retr0_def l_disjoint_comm)
    apply (frule_tac[!] f_F1_inv_nat1_map)

    unfolding sep0_def
    apply (rule ballI)
    apply simp

    unfolding contiguous_def
    apply (frule_tac f=f1 and x=l in f_nat1_map_nat1_elem,simp)
    apply (erule_tac[!] exE)+
    apply (erule_tac[!] conjE)
    apply (rule notI)
    find_theorems simp:"disjoint _ _"
    apply (simp_all add: l_locs_of_min l_locs_of_card)
    
    unfolding non_abutting_def
    find_theorems "_ \<in> dom _ \<Longrightarrow> _ \<in> locs _"
    apply (frule_tac x=l and f=f1 in f_in_dom_locs,simp)
    apply (erule_tac x=m in ballE)
    apply (erule_tac x="l+ ((the (f1 l)))" in ballE)
    apply (simp_all add: l_locs_of_itself)
    
    apply (frule_tac f=f1 and x=l in f_nat1_map_nat1_elem,simp) 


    defer
    apply (rule notI)
    apply (frule_tac x="m+l" and f=f1 in f_in_dom_locs,simp)
    apply (erule_tac)
    find_theorems "(_ + _) \<notin> dom _"
    apply (subst l_disjoint_mapupd_keep_sep)
      apply simp
      apply (simp add: f_F1_inv_disjoint)
    find_theorems name:ind name:Nat
    apply (erule_tac n="the(f l)" in nat_induct)
    apply simp
    find_theorems "_ \<in> locs_of _ _"
    
    apply simp_all
    apply (erule disjE)
    
    unfolding disjoint_def 
    find_theorems "locs_of _ _ \<inter> locs _"
    apply (simp add: k_inter_locs_iff f_F1_inv_nat1_map)
    apply (erule_tac x=l in ballE,simp_all)
    apply (simp add: disjoint_iff_not_equal)
    (*
    find_theorems "the(_ ) > 0"
    apply (frule f_F1_inv_nat1_map)
    apply (frule_tac f=f1 and x=l in f_nat1_map_nat1_elem)
    apply (simp add: b_locs_of_as_set_interval)
    *)
    apply (erule_tac x=m in ballE)
    apply (erule_tac x=l in ballE)
    apply simp_all
    apply (rule notI)
    apply simp
    apply (elim notE)
    
    find_theorems "locs_of _ _ = _"
    apply (frule f_F1_inv_sep)
    unfolding sep_def
    apply (erule_tac x=l in ballE)
    apply simp_all
    
    

    (* see IJW sep_non_abutt and its uses *)

    (* abuttiness goal is the last one to go... argh *)
oops

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* Pre/post refinement proof *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* see IJWv2 widen pre *)
lemma r_free01_widen_pre: 
  "PO_l01_new_widen_pre"

unfolding PO_l01_new_widen_pre_def new1_pre_def new0_pre_def is_block_def retr0_def
apply safe
apply (rename_tac k)
find_theorems simp:"_ \<subseteq> _" 
apply (simp add: subset_eq)
apply (erule_tac x=k in ballE)
apply (simp_all add: l_locs_of_itself)
apply (frule f_F1_inv_nat1_map)
find_theorems simp:"_ \<in> locs _"
apply (simp add: k_in_locs_iff)
apply (erule bexE)
apply (case_tac "k \<noteq> y")
apply (case_tac "k \<in> dom f1")
apply (rule_tac x=k in bexI,simp_all) 
unfolding locs_of_def
apply (simp add: f_nat1_map_nat1_elem)

apply (rule_tac x=y in bexI,simp_all)
nitpick
(* IJWs *)
apply (rule_tac x=k in bexI)
apply (rule locs_subset_free1_map)
apply simp
apply (simp add: nat1)
apply (simp only: inv)
apply simp

(* Leos *)
apply (elim exE conjE)
find_theorems simp:"_ \<subseteq> _"
apply (simp add: subset_eq)
find_theorems "_ \<in> locs _"
apply (simp add: k_in_locs_iff f_F1_inv_nat1_map)
apply (erule_tac x=l in allE) 
apply (elim impE)
apply simp
apply (elim bexE)
apply (frule f_F1_inv_nat1_map)
apply (frule f_nat1_map_nat1_elem)
apply simp
apply (rule_tac x=y in bexI)
apply simp_all
unfolding locs_of_def
apply simp
apply (erule conjE)
nitpick
oops

lemma r_free01_narrow_post: 
  "F1_inv f1 \<Longrightarrow> F1_inv f1' \<Longrightarrow> nat1 s1 \<Longrightarrow> new0_pre (retr0 f1) s1 \<Longrightarrow> 
      new1_post f1 s1 f1' r \<Longrightarrow> new0_post (retr0 f1) s1 (retr0 f1') r"
sorry
(* see IJWv2 narrow post *)

end
