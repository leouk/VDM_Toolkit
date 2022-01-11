(* $Id$ *)
theory HEAP1SanityProofs
imports HEAP1Sanity HEAP1Proofs
begin

(* ================================================================= *)
section {* Proof of some properties of interest *}
(* ================================================================= *)

(*------------------------------------------------------------------------*)
subsection {* Invariant testing *}
(*------------------------------------------------------------------------*)

(* The invariant holds and fails at expected examples *)
lemma l_F1_inv_example: "F1_ex_inv F1_ex"
unfolding F1_ex_inv_defs by auto

lemma "F1_inv [0 \<mapsto> 4, 5 \<mapsto> 11]"
unfolding F1_inv_defs by auto

lemma "F1_inv [0 \<mapsto> 4, 10 \<mapsto> 6, 20 \<mapsto> 2]"
unfolding F1_inv_defs by auto

lemma "\<not> F1_inv [0 \<mapsto> 4, 4 \<mapsto> 11]"
unfolding F1_inv_defs by auto

(*------------------------------------------------------------------------*)
subsection {* Operations properties *}
(*------------------------------------------------------------------------*)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* NEW 1 shrinks the memory  *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

context level1_new
begin

text_raw{* @{text "f1' \<subseteq>\<^sub>m f1"} not true of course on the $new\_gr$ *}
lemma new1_postcondition_state_changes_headon: 
	"PO_new1_postcondition_state_changes r"
unfolding PO_new1_postcondition_state_changes_def new1_postcondition_def new1_post_defs 
apply (intro allI impI)
apply (elim conjE disjE)
apply (simp_all (no_asm_simp) add: l_map_dom_ar_neq)
apply (insert l1_invariant_def)
apply (insert l1_input_notempty_def)
unfolding F1_inv_def
apply (elim conjE)
apply (subst fun_eq_iff)
apply (insert l_disjoint_mapupd_keep_sep[of f1 r s1])
apply (simp (no_asm_simp))
apply simp
apply (subgoal_tac "dom ({r} -\<triangleleft> f1) \<inter> dom [r + s1 \<mapsto> the (f1 r) - s1] = {}")
apply (simp add: l_munion_apply)
unfolding dom_antirestr_def
by auto

lemma new1_postcondition_state_locs_subset_headon: 
	"PO_new1_postcondition_state_locs_subset r"
unfolding PO_new1_postcondition_state_locs_subset_def
apply (intro allI impI)
apply (insert l1_invariant_def)
apply (insert l1_input_notempty_def)
  -- "prepare goal: add invariants"
apply (rule subsetI)
  -- "prepare goals: expand main ops"
  -- "G1: locs-subset"
unfolding new1_postcondition_def F1_inv_def locs_def
apply simp_all
  -- "prepare goals: expand main defs (no disjunctions)"
unfolding new1_post_defs
apply (elim conjE disjE bexE)
  -- "prepare goal: flatten assumptions of G1"
  apply (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
    -- "G1.1: new1_eq locs-subset"
apply (subgoal_tac "dom ({r} -\<triangleleft> f1) \<inter> dom [r+s1 \<mapsto> the(f1 r) - s1] = {}")
  -- "G1.2: new1_gr locs-subset (assuming munion WD)"
  apply (simp add: l_munion_dom l_munion_apply)
  apply (insert l_disjoint_mapupd_keep_sep[of f1 r s1])
  apply (erule disjE)
  apply simp_all
  apply (rule_tac x=r in bexI)
  apply (smt b_new1_gr_upd_within_req_size l1_input_notempty_def set_mp)
    -- "G1.2.1: new1_gr locs-subset RHS-munion"
    apply assumption
      -- "G1.2.1.1: bexI impI of G1.2.1"
  apply (split split_if_asm)
    apply simp
      -- "G1.2.1: repeated because of the if-asm"
  apply (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
    -- "G1.2.2: new1_gr locs-subset LHS-munion"
  apply (metis f_in_dom_ar_subsume)
    -- "G1.2.3: subgoal-tac discharge"
done

lemma new1_postcondition_state_locs_subset_planned: 
	"PO_new1_postcondition_state_locs_subset r"
unfolding PO_new1_postcondition_state_locs_subset_def
apply (intro allI impI)
unfolding new1_postcondition_def F1_inv_def locs_def
apply (elim conjE)
apply simp
apply (intro conjI impI)
defer 1
apply (metis F1_inv_def l1_invariant_def)
apply (rule subsetI)
apply simp
apply (erule bexE)
unfolding new1_post_defs
apply (elim conjE disjE)
apply simp_all
thm Diff_iff l_dom_dom_ar
apply (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
    (* 
    NOTE: some interesting answers on variety of theorems that could be nice. 
          also, the first time I got the "power user" note :-)... 21/06/2013 16:40
    
    "e": Try this: apply (metis Diff_iff f_in_dom_ar_the_subsume l_dom_dom_ar) (61 ms). 
    "remote_vampire": Try this: apply (metis f_dom_ar_subset_dom f_in_dom_ar_the_subsume in_mono) (60 ms). 
    "remote_e_sine": Try this: apply (metis (full_types) F1_inv_def k_in_locs_iff new1_post_def new1_postcondition_def new1_postcondition_within_f_locs subsetD zw_new1_post_eq) (70 ms). 
    Important message from Dr. Geoff Sutcliffe:
    "Congratulations - you have become a registered power user of SystemOnTPTP.
     Please consider donating to the TPTP project - see www.tptp.org for details.
     When you donate this message will disappear.
     If you do not donate a random delay may be added to your processing time." 
    "spass": Try this: apply (metis (hide_lams, full_types) f_in_dom_ar_subsume f_in_dom_ar_the_subsume) (38 ms). 
    "z3": Try this: apply (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume) (45 ms).
    *)
apply (insert l1_input_notempty_def)
apply (insert l1_invariant_def)
unfolding F1_inv_def
apply (erule conjE)+
apply (frule l_disjoint_mapupd_keep_sep[of f1 r s1])
apply assumption+
thm l_munion_apply
apply (subgoal_tac "dom f1 \<inter> dom [r + s1 \<mapsto> the (f1 r) - s1] = {}")
apply simp
apply (simp add: l_munion_dom_ar_assoc l_munion_apply f_in_dom_ar_the_subsume)
  (*apply (simp add: l_munion_dom_ar_assoc l_munion_apply f_in_dom_ar_subsume f_in_dom_ar_the_subsume)*)
  -- "NOTE: the above simp is VERY slow :-( "
apply (split split_if_asm)
apply simp_all
apply (rule_tac x="r" in bexI) 
apply (smt b_new1_gr_upd_within_req_size l1_input_notempty_def set_mp)
  -- "NOTE: sledgehammer didn't find this! I just used a previous case that it succeeded and it worked! " 
apply assumption
apply (frule f_in_dom_ar_subsume)
apply (simp add: l_munion_dom)
by metis

lemma new1_postcondition_state_locs_subset_algebraic: 
	"PO_new1_postcondition_state_locs_subset r"
unfolding PO_new1_postcondition_state_locs_subset_def
apply (intro allI impI)
apply (insert l1_invariant_def)
unfolding new1_postcondition_def new1_post_defs
apply (elim conjE disjE)
apply simp_all
thm l_locs_dom_ar_iff[of f1 r] 
      --"expanding dom_ar: depends on nat1_map and disjoint explicitly"
    l_locs_munion_iff[of "{r}-\<triangleleft>f1" "[r + s1 \<mapsto> the (f1 r) - s1]"] 
      --"expanding munion: depends on specialised nat1_map (i.e. dom_ar and singleton) and aux lemma above"
      --"expanding dom_ar: depends on same as above (but for the 2nd goal as well)"
    l_nat1_map_singleton[of "the(f1 r) - s1" "r+s1"]
      --"Given nat1_iff rule and given assumtpions, just depend on nat1 s1"
    l_locs_singleton_iff[of "the(f1 r) - s1" "r+s1"]
      --"expanding locs: singleton depends on nat1 s1"
    (* NOTE: For the next step, ideally, I would like to have simp_all working by having all the 
             side-conditions satisfied such that both l_locs_XXX_iff lemmas would apply to each goal. 
             For new1_eq it works. For new1_gr, it's still fiddly (and annoying). I would like it
             to be:
             
                apply (simp_all add: l_locs_dom_ar_iff 
                                         f_F1_inv_disjoint f_F1_inv_nat1_map 
                                            Diff_subset   --"kills first goal on new1_eq"

                                     l_locs_munion_iff
                                         k_nat1_map_dom_ar_specific
                                            f_F1_inv_nat1_map
                                         l_nat1_map_singleton
                                            l1_input_notempty
                                         k_new1_gr_dom_ar_dagger_aux
                                            f_F1_inv_disjoint
                                            
                                            l_locs_dom_ar_iff 
                                            l_locs_singleton_iff
                                            Diff_subset)   --"kills second goal on new1_gr"

             These steps almost acheive it. 
                defer
                apply (frule f_F1_inv_nat1_map)
                apply (frule f_F1_inv_disjoint)
                apply (frule k_nat1_map_dom_ar[of _ "{r}"])
                apply (insert l1_input_notempty)
                apply (insert l_locs_munion_iff[of "{r}-\<triangleleft>f1" "[r + s1 \<mapsto> the (f1 r) - s1]"] )
                apply (simp add: l_locs_dom_ar_iff 
                                 l_nat1_map_singleton
                                 k_new1_gr_dom_ar_dagger_aux2
                                 l_locs_singleton_iff)

             The missing clauses include r + s1 \<notin> dom ({r} -\<triangleleft> f1) and nat1_map ({r} -\<triangleleft> f1).
             Adding the frules theorems to the simp list, what we thought would work, doesn't.
             
             TODO: Iain, help?

             Instead, we decided to separate the two goals, and apply simp for the one that 
             works (new1_eq), and apply subst for the one that doesn't (new1_gr). For here, 
             we are splitting the two goals, and doing it with subst instead for new1_gr.
     *)
apply (simp add: l_locs_dom_ar_iff 
                        f_F1_inv_disjoint f_F1_inv_nat1_map 
                 Diff_subset)
apply (subst l_locs_munion_iff)
  apply (simp add: f_F1_inv_nat1_map k_nat1_map_dom_ar_specific)
  apply (simp add: l_nat1_map_singleton)
  apply (metis f_F1_inv_disjoint f_F1_inv_nat1_map l1_input_notempty_def k_new1_gr_dom_ar_dagger_aux)
  apply (simp add: l_locs_dom_ar_iff 
                          f_F1_inv_disjoint f_F1_inv_nat1_map
                   l_locs_singleton_iff
                   Diff_subset)
by (metis F1_inv_def b_new1_gr_upd_within_req_size l_locs_of_within_locs subset_trans)

lemma new1_postcondition_diff_f_locs_headon: 
	"PO_new1_postcondition_diff_f_locs r"
unfolding PO_new1_postcondition_diff_f_locs_def
apply (intro allI impI)
unfolding new1_postcondition_def new1_post_defs
apply (elim conjE disjE)
  (* NEW1_eq: locs neq *)
  thm l_locs_dom_ar_iff
      f_F1_inv_disjoint
      l1_invariant_def
  apply (simp add: l_locs_dom_ar_iff    --"rely on the two inv properties"
                      f_F1_inv_disjoint
                      f_F1_inv_nat1_map --"rely on invariant over f1 not f1'!"
                         l1_invariant_def)
  apply (metis Diff_iff F1_inv_def k_in_locs_iff l1_invariant_def f_dom_locs_of)

  (* NEW1_gr: locs neq *)
  find_theorems "_ -\<triangleleft> _ \<union>m _"
  thm l_munion_dom_ar_assoc[of "{r}" f1 "[r + s1 \<mapsto> the (f1 r) - s1]",simplified]
      l_disjoint_mapupd_keep_sep[of f1 r s1]
      l1_input_notempty_def
       (* apply (simp add: l_munion_dom_ar_assoc
                      l_disjoint_mapupd_keep_sep
                        f_F1_inv_disjoint
                        f_F1_inv_nat1_map --"rely on invariant over f1 not f1'!"
                           l1_invariant
                        l1_input_notempty) DIDN'T WORK TRY SOMETHING ELSE: missing atomize_not! *)
  find_theorems "locs (_ \<union>m _)"
    find_theorems "nat1_map [_ \<mapsto> _]"
    find_theorems "nat1_map (_ -\<triangleleft> _)"
  thm l_locs_munion_iff[of "{r} -\<triangleleft> f1" "[r + s1 \<mapsto> the (f1 r) - s1]",simplified]
    thm l_nat1_map_singleton[of "the(f1 r) - s1" "r+s1",simplified]
        k_new1_nat1_map_dom_ar

  (* Establish the side conditions as assumptions to force the LEMMA through! *)
  apply (insert l1_invariant_def)
  apply (frule f_F1_inv_disjoint[of f1])
  apply (frule f_F1_inv_nat1_map[of f1])
  apply (insert l1_input_notempty_def)
  apply (insert l_disjoint_mapupd_keep_sep[of f1 r s1])
    find_theorems simp:"(_ \<Longrightarrow> False)"
  apply (insert k_new1_nat1_map_dom_ar[of r])
  apply (insert f_in_dom_ar_subsume[of "r+s1" "{r}" f1])
  apply (insert l_nat1_map_singleton[of "the(f1 r) - s1" "r+s1",simplified])
    find_theorems "locs [_ \<mapsto> _]"
  apply (simp add: l_locs_munion_iff 
                      atomize_not
                   l_locs_dom_ar_iff
                   l_locs_singleton_iff)
  find_theorems "(_ - _) \<union> _"
  find_theorems "_ - _ = _" name:Set
    thm Un_Diff
        Diff_Un[of "locs f1" "locs_of r (the (f1 r))"  "locs_of (r + s1) (the (f1 r) - s1)"]
  
  apply (simp add: l_diff_un_not_equal
                      l_locs_of_within_locs
                      b_new1_gr_upd_psubset_req_size)
done

lemma new1_postcondition_shrinks_f_locs: 
	"PO_new1_postcondition_shrinks_f_locs r"
unfolding PO_new1_postcondition_shrinks_f_locs_def
find_theorems "_ \<subset> _"
apply (intro allI impI)
apply (rule psubsetI)
apply (metis PO_new1_postcondition_state_locs_subset_def new1_postcondition_state_locs_subset_planned)
by (metis PO_new1_postcondition_diff_f_locs_def new1_postcondition_diff_f_locs_headon)

(*
lemmX new1_postcondition_f_locs_subset: 
	"new1_postcondition f1' r \<Longrightarrow> locs f1 \<subseteq> locs f1'"
apply (rule subsetI)
apply (insert l1_invariant)
apply (insert l1_input_notempty)
apply (subst k_in_locs_iff)
apply (metis F1_inv_def new1_postcondition_def)
apply (frule f_F1_inv_nat1_map)
thm k_in_locs_iff
    subst
    k_in_locs_iff[THEN subst, of f1]
    k_in_locs_iff[THEN subst, of f1 "(\<lambda>x . x)"]
apply (frule k_in_locs_iff[THEN subst, of f1 "(\<lambda>x . x)"],assumption) --"BLODDY FINALLY!"
oops  NOTE: Finally managed to make a meaningful change with an k_rule as a FD rule using subst! 
*)

(*
lemmX new1_postcondition_f_locs_subset: 
	"new1_postcondition f1' r \<Longrightarrow> locs f1 \<subseteq> locs f1'"
apply (rule subsetI)
apply (insert l1_invariant)
apply (insert l1_input_notempty)
unfolding new1_postcondition_def new1_post_defs
apply (elim conjE disjE)
apply (simp add: f_F1_inv_disjoint f_F1_inv_nat1_map 
                 k_in_locs_iff l_locs_dom_ar_iff) --"BLODDY FINALLY! the weaking FD works!"
     NOTE: NICE! Finally I managed to use the frules properly and 
             even without explicitly giving it as a new assumption,
             I convinced the simplifier things are okay. 
     
apply (erule bexE)
apply (frule f_F1_inv_disjoint) --"[of "{r} -\<triangleleft> f1"])"
unfolding Disjoint_def disjoint_def
apply (simp add: k_locs_of_Locs_of)
apply (erule_tac x=r in ballE)
apply (erule_tac x=y in ballE)
apply simp_all
apply (erule impE)
defer
apply (metis disjoint_iff_not_equal)
  thm IntI emptyE
apply (subst l_locs_munion_iff)
  apply (metis k_new1_nat1_map_dom_ar)
  apply (metis l_nat1_map_singleton nat1_def zero_less_diff)

  apply (simp add: disjoint_iff_not_equal)
  apply (rule ballI)
  apply (metis f_F1_inv_disjoint f_F1_inv_nat1_map f_in_dom_ar_subsume l1_input_notempty l_disjoint_mapupd_keep_sep)
   NOTE: Appealed to subst (instead of simp add) for locs_munion because
           it wasn't possible to convince Isabelle. This leads to various
           spurious subgoals. TODO: Iain help?

           Well, even with an earlier simp adding all the facts I need, the
           lack of the \<inter> = {} part for l_locs_munion_iff creates the trouble.
           Perhaps subgoal_tac?
   
apply simp
apply (rule disjI1)
apply (simp add: f_F1_inv_disjoint f_F1_inv_nat1_map l_locs_dom_ar_iff)
   NOTE: Aha! Simp does work whenever all conditions are met for conditional simplication

           Only interested in the subset (dom_ar) case (rather than the update) for containment 
           (i.e. the LHS of implication was a \<or> when simp wasn't working)

            apply (frule b_new1_gr_upd_within_req_size[of r f1 s1]) --- not useful? why not?
   
apply (simp add: f_F1_inv_nat1_map k_in_locs_iff)
apply (frule f_F1_inv_disjoint)
unfolding Disjoint_def disjoint_def
apply (erule bexE)
apply (erule_tac x=r in ballE)
apply (erule_tac x=y in ballE)
apply (simp_all add: k_locs_of_Locs_of)
apply (erule impE)
defer
apply (metis IntI empty_iff)
oops
*)

lemma new1_postcondition_f_equiv: 
	"PO_new1_postcondition_f_equiv r"
unfolding PO_new1_postcondition_f_equiv_def new1_postcondition_def new1_post_defs
apply (intro allI impI)
apply (elim conjE disjE)
by (simp_all add: Un_absorb l_dom_ar_accum)

end 

(*------------------------------------------------------------------------*)
(* NEW1(n); DISPOSE(r, n) = Id *)

(*
lemmX l1: "0 < n \<Longrightarrow>
    r \<in> dom f \<Longrightarrow>
    n < the (f r) \<Longrightarrow> F1_inv f \<Longrightarrow> f = ({r} -\<triangleleft> f) \<union>m [r + n \<mapsto> the (f r) - n] \<union>m [r \<mapsto> n]"
apply (subst l_munion_assoc)
  apply (metis (mono_tags) f_F1_inv_disjoint f_F1_inv_nat1_map k_new1_gr_dom_ar_dagger_aux nat1_def)
  apply (metis (full_types) Collect_conj_eq Collect_conv_if2 add_eq_self_zero dom_eq_singleton_conv gr_implies_not0 singleton_conv2)
apply (subst l_munion_commute) back
  apply (metis (full_types) Collect_conj_eq Collect_conv_if2 add_eq_self_zero dom_eq_singleton_conv gr_implies_not0 singleton_conv2)
apply (subst l_munion_assoc[symmetric])  
  apply (metis Int_empty_left Int_insert_left_if0 dom_eq_singleton_conv f_in_dom_ar_notelem inf_commute)
  apply (metis (full_types) Collect_conj_eq Collect_conv_if2 add_eq_self_zero dom_eq_singleton_conv gr_implies_not0 singleton_conv2)
apply (subst fun_eq_iff)
apply (rule allI)
apply (subst l_munion_apply)
  apply (subst disjoint_iff_not_equal)
  apply (rule ballI)+
  thm l_munion_dom[of "{r} -\<triangleleft> f" "[r \<mapsto> n]",simplified]
  apply (subgoal_tac "r \<notin> dom({r} -\<triangleleft> f)")
  apply (simp add: l_munion_dom)
  apply (erule disjE)
  apply simp
  defer
  apply (metis f_in_dom_ar_notelem)
  apply simp
  apply (intro conjI impI)
  find_theorems simp:"_ \<in> dom( _ -\<triangleleft> _)"
oops

lemmX l2: "r + n \<notin> dom (({r} -\<triangleleft> f) \<union>m [r + n \<mapsto> the (f r) - n]) \<Longrightarrow> P"
apply (erule notE)
thm l_munion_dom[of "({r} -\<triangleleft> f)" "[r + n \<mapsto> the (f r) - n]"]
apply (subst l_munion_dom)
apply simp_all
oops
*)

text_raw{* "case 2.2.2 [14]: @{text "new1_gr; above \<noteq> empty; below \<noteq> empty"} *}
lemma l_new1_dispose_1_identity_case_14:
      "0 < n \<Longrightarrow> r \<in> dom f \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow>  r + n \<notin> dom ({r} -\<triangleleft> f) \<Longrightarrow>
        l \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) \<Longrightarrow>
        l + the (({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) l) = r \<Longrightarrow>
        f = ( {r + n, l} 
              -\<triangleleft> 
              (({r} -\<triangleleft> f) \<union>m [r + n \<mapsto> the (f r) - n])
            )
            \<union>m
            [l \<mapsto> the (({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) (r + n)) + the (({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) l) + n]"
apply (simp add:  l_munion_apply l_munion_dom f_in_dom_ar_apply_subsume)
apply (cases "l=r+n")
(*using [[simp_trace]]*) apply (simp del: diff_is_0_eq' diff_is_0_eq)
    (* remove any worries about proofs involving m-n=0 when m\<le>n *)
apply (simp add: f_in_dom_ar_apply_subsume)
by (metis l_dom_ar_not_in_dom sep_def)
  (*  ({r + n, l} -\<triangleleft> (({r} -\<triangleleft> f) \<union>m [r + n \<mapsto> the (f r) - n])) \<union>m [l \<mapsto> the (f r) - n + the (({r} -\<triangleleft> f) l) + n] *)
thm l_munion_dom_ar_assoc[of "{r}" f "[r + n \<mapsto> the (f r) - n]", symmetric,simplified]
    l_munion_dom_ar_assoc[of "{r+n,l}" "(({r} -\<triangleleft> f) \<union>m [r + n \<mapsto> the (f r) - n])" 
                             "[l \<mapsto> the (f r) - n + the (({r} -\<triangleleft> f) l) + n]",symmetric,simplified]


lemma new1_dispose1_identity: 
	"PO_new1_dispose1_identity_post f n r"
unfolding PO_new1_dispose1_identity_post_def
apply (intro allI impI)
apply (erule conjE)
apply (simp only: dispose1_equiv)
unfolding new1_post_def dispose1_post2_def 
apply (elim disjE conjE exE)+

--" case1 [1]: new1_eq"
  apply (simp_all)
  apply (frule k_F1_inv_dom_ar[of _ "{r}"])
  unfolding new1_post_eq_def F1_inv_def
  apply (elim conjE)
  apply (simp add: l_min_loc_dispose1_ext_absorb_above)
  unfolding dispose1_ext_def
  -- "case1.1 [2]: new1_eq; below=empty"
    apply (cases "dispose1_below ({r} -\<triangleleft> f) r = empty")
      thm l_sum_size_munion_singleton[simplified] f_d1_not_dispose_above[of n r "{r} -\<triangleleft> f",simplified]
      apply (frule f_d1_not_dispose_above[of n r "{r} -\<triangleleft> f",simplified])
      apply (subst l_sum_size_munion_singleton)
        apply (metis k_finite_dispose_abovebelow_munion nat1_def)
        apply (smt Un_commute disjoint_iff_not_equal empty_iff insert_is_Un l_dom_extend l_map_non_empty_dom_conv singleton_iff unionm_in_dom_right)       
      apply (simp add: l_munion_empty_lhs l_munion_empty_rhs
                        l_min_loc_singleton)
    
      -- "case 1.1.1 [3]: new1_eq; below=above=empty"
        apply (cases "dispose1_above ({r} -\<triangleleft> f) r n = empty")
        apply (simp_all add: l_munion_empty_lhs l_dom_ar_none)
        apply (metis l_munion_subsume)

      -- "case 1.1.2 [4]: new1_eq; below=empty; not above = empty"
        apply (simp add: l_dispose1_nonempty_above_singleton l_sum_size_singleton)
        apply (metis (full_types) k_empty_dispose_above l_dom_ar_notin_dom_or sep_def)

     -- "case1.2 [5]: new1_eq; not below = empty"
       -- "case 1.2.1 [6]: above=empty; not below = empty"
          apply (cases "dispose1_above ({r} -\<triangleleft> f) r n = empty")
          apply (simp add: l_dispose1_sep0_below_empty_iff[of "{r} -\<triangleleft> f" r n])
          apply (unfold sep0_def)
          apply simp
          apply (erule bexE)
          find_theorems "_ -\<triangleleft> _ -\<triangleleft> _"
          thm k_min_loc_munion_singleton[simplified]
          apply (simp add: l_munion_empty_lhs l_dispose1_below_singleton_useful l_dom_ar_accum)

          apply (subst k_min_loc_munion_singleton)
            apply (metis finite_singleton)
            apply (simp add: disjoint_iff_not_equal f_in_dom_ar_notelem)
            apply (simp)
          apply (subst l_sum_size_munion_singleton)
            apply (metis finite_singleton)
            apply (simp add: disjoint_iff_not_equal f_in_dom_ar_notelem)
            apply (simp add: l_sum_size_singleton min_def)

          apply (metis f_in_dom_ar_apply_subsume l_dom_ar_not_in_dom sep_def)

       -- "case 1.2.2 [7]: new1_eq; not above = empty; not below = empty"
          apply (simp add: l_dispose1_sep0_below_empty_iff[of "{r} -\<triangleleft> f" r n])
          apply (unfold sep0_def)
          apply simp
          apply (erule bexE)
          find_theorems "_ -\<triangleleft> _ -\<triangleleft> _"
          thm k_min_loc_munion_singleton[simplified]
          apply (simp add:  l_dispose1_below_singleton_useful
                            l_dispose1_nonempty_above_singleton l_sum_size_singleton)

          apply (subst k_min_loc_munion_singleton)
            apply (metis finite_singleton)
            apply (simp add: disjoint_iff_not_equal f_in_dom_ar_notelem)
            apply (simp)
          apply (subst l_sum_size_munion_singleton)
                -- "slightly more complicated because there is two munion"
            apply (smt k_finite_dispose_abovebelow_munion l_dispose1_below_singleton_useless l_dispose1_nonempty_above_singleton nat1_def)
            apply (simp add: disjoint_iff_not_equal)
              apply (rule ballI)
              apply (simp add: l_munion_dom)
              apply (metis sep_def)

            apply (subst l_sum_size_munion_singleton)
              apply (metis finite_singleton)
              apply (simp add: disjoint_iff_not_equal)
              
            apply (simp add: l_sum_size_singleton min_def l_munion_empty_iff)

          apply (metis f_in_dom_ar_apply_subsume l_dom_ar_not_in_dom sep_def)

--" case 2 [8]: new1_gr"
  apply (fold F1_inv_def)
  apply (fold dispose1_ext_def)
  unfolding new1_post_gr_def
  apply (elim conjE)
  apply (frule k_F1_inv_dom_munion)
  apply (simp_all (no_asm))
  unfolding F1_inv_def
  apply (elim conjE)
  apply (simp add: l_min_loc_dispose1_ext_absorb_above)
  unfolding dispose1_ext_def

  -- "case2.1 [9]: new1_gr; below=empty"
    apply (cases "dispose1_below ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) r = empty")
      apply (simp add: l_munion_empty_rhs l_munion_empty_lhs)
      thm l_sum_size_munion_singleton[simplified] f_d1_not_dispose_above[of n r "{r} -\<triangleleft> f",simplified]
      apply (frule f_d1_not_dispose_above[of n r "({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])",simplified])
      apply (subst l_sum_size_munion_singleton)
        apply (metis k_finite_dispose_above)
        apply (smt Diff_disjoint Int_commute dom_empty dom_fun_upd l_dom_dom_ar l_munion_dom_ar_singleton_subsume option.distinct(1))
      apply (simp add: l_munion_empty_lhs l_munion_empty_rhs
                        l_min_loc_singleton)

      -- "case 2.1.1 [10]: new1_gr; below=above=empty"
        apply (cases "dispose1_above ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) r n = empty")
        apply (simp_all add: l_munion_empty_lhs l_dom_ar_none l_sum_size_singleton)
        
        thm l_munion_subsume l_dispose1_sep0_below_empty_iff[of _ r n]
        (* We need some property about above/below being empty after a NEW1_gr for contradiction? *)
        apply (simp add: l_dispose1_sep0_above_empty_iff)
        unfolding sep0_def
        apply (simp)
        apply (erule notE)
        thm l_munion_dom[of "({r} -\<triangleleft> f)" "[r + n \<mapsto> the (f r) - n]"]
        apply (subst l_munion_dom)
        apply simp_all
          thm l_disjoint_mapupd_keep_sep k_new1_gr_dom_ar_dagger_aux2
         --"apply (metis k_new1_gr_dom_ar_dagger_aux2 nat1_def)"
         apply (metis l_disjoint_mapupd_keep_sep l_dom_ar_notin_dom_or nat1_def)

      -- "case 2.1.2 [11]: new1_gr; below=empty; not above = empty"
        (*using [[simp_trace]]*) 
        apply (simp add: l_dispose1_nonempty_above_singleton)  
        (* quite SLOW! *)
        apply (simp add: l_sum_size_singleton)

        thm l_munion_apply[of "{r} -\<triangleleft> f" "[r + n \<mapsto> the (f r) - n]",simplified]
             k_new1_gr_dom_ar_dagger_aux2[of f r n]
        apply (simp add: l_munion_apply  k_new1_gr_dom_ar_dagger_aux2[of f r n])
        apply (insert k_new1_gr_dom_ar_dagger_aux2[of f r n])

        apply (simp add: l_dispose1_sep0_above_empty_iff l_dispose1_sep0_below_empty_iff[of _ r n])
        unfolding sep0_def
        apply (simp add: l_munion_apply)
        apply (erule_tac x="r+n" in ballE,simp_all)
        apply (metis l_munion_dom_ar_singleton_subsume l_munion_subsume)
          (*apply (simp add: l_new1_dispose_1_identity_case_11)*)

     -- "case2.2 [12]: new1_gr; not below =empty" 
       -- "case 2.2.1 [13]: new1_gr; above=empty; not below = empty"
          apply (cases "dispose1_above ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) r n = empty")
          apply (simp add: l_dispose1_sep0_above_empty_iff)
          apply (unfold sep0_def)
            (* Stablishes contradiction: r+n \<notin> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])*)
          apply (simp add: l_munion_dom)
       (*
          apply (cases "dispose1_above ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) r n = empty")
          apply (simp add: l_dispose1_sep0_below_empty_iff[of "({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])" r n]
                           )
          apply (simp add: l_dispose1_sep0_above_empty_iff)
          apply (unfold sep0_def)
          apply simp
          apply (erule bexE)
          find_theorems "_ -\<triangleleft> _ -\<triangleleft> _"
          thm k_min_loc_munion_singleton[simplified]
          apply (simp add: l_munion_empty_lhs l_dispose1_below_singleton_useful l_dom_ar_accum)
          apply (subst k_min_loc_munion_singleton)
            apply (metis finite_singleton)
            apply (simp add: disjoint_iff_not_equal)
              apply (metis sep_def)
            apply (simp)
          apply (subst l_sum_size_munion_singleton)
            apply (metis finite_singleton)
            apply (simp add: disjoint_iff_not_equal f_in_dom_ar_notelem)
              apply (metis sep_def)
            apply (simp add: l_sum_size_singleton min_def)
          apply (simp add: l_new1_dispose_1_identity_case_13)
       *)

       -- "case 2.2.2 [14]: new1_gr; not above = empty; not below = empty"
          apply (simp add: l_dispose1_sep0_below_empty_iff[of "({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])" r n])
          apply (unfold sep0_def)
          apply simp
          apply (erule bexE)
          find_theorems "_ -\<triangleleft> _ -\<triangleleft> _"
          thm k_min_loc_munion_singleton[simplified]
          apply (simp add:  l_dispose1_below_singleton_useful
                            l_dispose1_nonempty_above_singleton 
                            l_sum_size_singleton)

          apply (subst k_min_loc_munion_singleton)
            apply (metis finite_singleton)
            apply (simp add: disjoint_iff_not_equal)
              apply (metis sep_def)
            apply (simp)
          apply (subst l_sum_size_munion_singleton)
                -- "slightly more complicated because there is two munion"
            apply (smt k_finite_dispose_abovebelow_munion 
                       l_dispose1_below_singleton_useless 
                       l_dispose1_nonempty_above_singleton nat1_def)
            apply (simp add: disjoint_iff_not_equal)
              apply (rule ballI)
              apply (simp add: l_munion_dom)
              apply (metis add_eq_self_zero f_in_dom_ar_notelem neq0_conv)
              (*apply (smt f_in_dom_ar_notelem)*)

            apply (subst l_sum_size_munion_singleton)
              apply (metis finite_singleton)
              apply (simp add: disjoint_iff_not_equal)
              
            apply (simp add: l_sum_size_singleton min_def l_munion_empty_iff)

          --"apply (metis f_in_dom_ar_apply_subsume l_dom_ar_not_in_dom sep_def)"
          apply (simp add: l_new1_dispose_1_identity_case_14)
done

lemma l_new1_dispose_1_identity_case_11:
   "0 < n \<Longrightarrow> r \<in> dom f \<Longrightarrow> nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r + n \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) \<Longrightarrow>
    r + n \<notin> dom ({r} -\<triangleleft> f) \<Longrightarrow> f = {r + n} -\<triangleleft> ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) \<union>m [r \<mapsto> the (f r)]"
by (metis l_munion_dom_ar_singleton_subsume l_munion_subsume)

lemma l_new1_dispose_1_identity_case_11_original:
   "0 < n \<Longrightarrow> r \<in> dom f \<Longrightarrow> nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r + n \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) \<Longrightarrow>
    r + n \<notin> dom ({r} -\<triangleleft> f) \<Longrightarrow> f = {r + n} -\<triangleleft> ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) \<union>m [r \<mapsto> the (f r)]"
find_theorems simp:"_ -\<triangleleft> _ \<union>m _"
thm l_munion_dom_ar_assoc[of "{r+n}" "({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])" "[r \<mapsto> the (f r)]",simplified]
    l_munion_subsume l_munion_assoc
     k_new1_gr_dom_ar_dagger_aux[of _ r n]
apply (subst l_munion_dom_ar_assoc[of "{r+n}" "({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n])" "[r \<mapsto> the (f r)]",simplified])
  apply simp
  apply (simp add: l_munion_dom l_dom_dom_ar)
thm l_munion_assoc[of "{r} -\<triangleleft> f"  "[r + n \<mapsto> the (f r) - n]"  "[r \<mapsto> the (f r)]"]
apply (subst l_munion_assoc[of "{r} -\<triangleleft> f"  "[r + n \<mapsto> the (f r) - n]"  "[r \<mapsto> the (f r)]"],simp_all)
thm l_munion_commute[of  "[r + n \<mapsto> the (f r) - n]"  "[r \<mapsto> the (f r)]"]
apply (subst l_munion_commute[of  "[r + n \<mapsto> the (f r) - n]"  "[r \<mapsto> the (f r)]"],simp)
thm l_munion_assoc[of "{r} -\<triangleleft> f"  "[r \<mapsto> the (f r)]" "[r + n \<mapsto> the (f r) - n]",symmetric]
apply (subst l_munion_assoc[of "{r} -\<triangleleft> f"  "[r \<mapsto> the (f r)]" "[r + n \<mapsto> the (f r) - n]",symmetric])
  apply (simp add: l_dom_dom_ar)
  apply simp
apply (subst l_munion_subsume[of r f "the(f r)",symmetric],simp_all)
thm l_munion_subsume[of "r+n" f "(the(f r)) - n",symmetric]
    (* {r + n} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n] = f *)
    l_munion_dom_ar_assoc[of "{r+n}" f "[r + n \<mapsto> the (f r) - n]",simplified,symmetric]
    (* f = {r + n} -\<triangleleft> (f \<union>m [r + n \<mapsto> the (f r) - n]) !!! Argh !!! *)
    (* apply (subst l_munion_subsume[of "r+n" f "(the(f r)) - n"]) *)

find_theorems simp:"dom(_ -\<triangleleft> _)"
apply (simp add: l_dom_dom_ar)

(*AHA!!! simp add these doesn't work, though :-( *)
thm b_dagger_munion[of f "[r + n \<mapsto> the (f r) - n]",symmetric,simplified]
    antirestr_then_dagger_notin[of "r+n" f]

(* AHA! Suggest the lemma: l_munion_dom_ar_singleton_subsume *)
apply (simp add: l_munion_dom_ar_singleton_subsume)
    (* !!! YESSS !!!! *) 
done

 -- "case 2.2.1 [13]: new1_gr; above=empty; not below = empty"
lemma l_new1_dispose_1_identity_case_13_original:
       "r + n \<notin> dom ({r} -\<triangleleft> f) \<Longrightarrow>
        r + n \<notin> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) \<Longrightarrow>
        l \<in> dom ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) \<Longrightarrow>
        l + the (({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) l) = r \<Longrightarrow>
        f = {l} -\<triangleleft> ({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) \<union>m [l \<mapsto> the (({r} -\<triangleleft> f \<union>m [r + n \<mapsto> the (f r) - n]) l) + n]"
                                                            (* l \<mapsto> r-l+n *)
by (simp add: l_munion_dom)
  (* NOTE: key here was to see the second (contradictory) hypothesis *)

find_theorems "locs _"

thm  l_locs_dom_ar_iff   (* Lemmas.thy-179 *)
       HEAP1SanityProofs.level1_new.new1_postcondition_state_locs_subset_algebraic (* 1054; 1057 *)
       l_disjoint_dispose1_ext (* 1359; 1375; 1402*)
          HEAP1Proofs.level1_dispose.z_F1_inv_dispose1_Disjoint (* 758; 770 *)

(* See: example of lemma that was sep f and jus needed nat1 s as side condtion (See SVN revision) *)

thm l_disjoint_singleton_upd (* Lemma.thy-527 *)
       HEAP1Proofs.level1_dispose.z_F1_inv_dispose1_Disjoint (* 758; 764 *)

find_theorems "locs _ = locs _"


end
