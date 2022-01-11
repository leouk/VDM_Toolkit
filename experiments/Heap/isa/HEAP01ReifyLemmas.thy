(* $Id$ *)
theory HEAP01ReifyLemmas
imports HEAP01Reify HEAP1Lemmas
begin

(*========================================================================*)
section {* Refinement L0-L1 lemmas *}
(*========================================================================*)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* Lemmas for invariant sub parts over empty maps *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

lemma l_disjoint_empty: "Disjoint empty"
unfolding Disjoint_def disjoint_def Locs_of_def locs_of_def
by (metis dom_empty ex_in_conv)

lemma l_sep_empty: "sep empty"
unfolding sep_def
by (metis dom_empty empty_iff)

(*lemma l_nat1_map_empty: "nat1_map empty"
unfolding nat1_map_def
by (metis dom_empty empty_iff) - already above to help proofs of l_locs_empty_iff*)

lemma l_finite_empty: "finite (dom empty)"
by (metis dom_empty finite.emptyI)

lemma l_F1_inv_empty: "F1_inv empty"
by (metis F1_inv_def l_nat1_map_empty dom_empty finite.emptyI l_disjoint_empty l_sep_empty)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* Lemmas for HEAP definitions - properties of interest *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text {* This lemma I tried to prove earlier on when doing the proof for
        memory_shrink property of DISPOSE1 alongside the lemma that NEW
        followed by dispose lead to identify map. In there I failed and
        simplified the goal to be simply new1_postcondition_diff_f_locs_headon

        Now, if I am to prove that the retrieve is functional, I still need 
        the same lemma again, which is given below.

        I know how to prove it now, though: I just need Disjoint to show that's true,
        phrased through a couple of lemmas that say:
            a \<in> dom f \<Longrightarrow> a \<in> locs_of a (the(f a))    [f_dom_locs_of]
            
            a \<in> dom f \<and> b \<in> dom f \<and>
            Disjoint f \<and> a \<in> locs_of b (the (f b)) \<Longrightarrow> a = b (!!!) ???
      *}

lemma l_locs_of_uniqueness:
  "a \<in> dom f \<Longrightarrow> b \<in> dom f \<Longrightarrow> Disjoint f \<Longrightarrow> a \<in> locs_of b (the (f b)) \<Longrightarrow> a = b"
unfolding Disjoint_def disjoint_def
find_theorems "Locs_of _ _"
apply (simp add: l_locs_of_Locs_of_iff)
apply (erule_tac x=a in ballE)
apply (erule_tac x=b in ballE,simp_all)
find_theorems simp:"_ \<longrightarrow> _ = _"
thm contrapos_pp[of "locs_of a (the (f a)) \<inter> locs_of b (the (f b)) = {}" "a=b"]
apply (rule contrapos_np[of "locs_of a (the (f a)) \<inter> locs_of b (the (f b)) = {}" "a=b"],simp_all)
sorry 

lemma l_locs_ext:
  "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> Disjoint f \<Longrightarrow> Disjoint g \<Longrightarrow> locs f = locs g \<Longrightarrow> f = g"
unfolding locs_def
(*
"locs f = locs g \<Longrightarrow> dom f = dom g"
"\<forall> x \<in> dom f. locs_of x f x = locs_of x g x"
"locs_of x f x = locs_of x g x \<Longrightarrow> f x = g x"
*)
apply (rule ext)
apply (case_tac "x \<in> dom f")
thm fun_eq_iff 
apply (rule fun_eq_iff)

find_theorems name:set name:iff
find_theorems (200) "_ = (_::('a \<rightharpoonup> 'b))" -name:HEAP -name:VDMMaps
thm map_le_antisym[of f g] fun_eq_iff[of f g]
apply (rule map_le_antisym)
  (* NOTE: This is better than simply using fun_eq_iff because of \<in> dom extra *)
find_theorems simp:"_ \<subseteq>\<^sub>m  _" 
  (* hum... could this help with an induction principle? i.e. lemmas about \<subseteq>\<^sub>m giving hints for the shape *)
unfolding map_le_def
apply (rule_tac[!] ballI)
find_theorems "_ \<in> dom _ \<Longrightarrow> _ \<in> locs_of _ _"
find_theorems "_ \<in> dom _ \<Longrightarrow> _ \<in> locs _"
find_theorems simp:"_ \<subseteq> _" name:Set
apply (erule equalityE)
apply (simp add: subset_eq)
apply (frule f_dom_locs_of,simp)
apply (frule f_in_dom_locs,simp)
apply (erule_tac x=a in ballE)
defer
  apply simp
  defer
find_theorems "_ \<in> locs _"
thm k_in_locs_iff[of f _, THEN subst[of _ _ "(\<lambda> x . x)"]]
   (* NOTE: Whaa... we need the complicated expression because of assumption equality :-( *)
pr
thm k_in_locs_iff
apply (frule_tac x=a in k_in_locs_iff) 
apply (frule_tac f=g and x=a in k_in_locs_iff) 
apply simp
apply (elim bexE)
thm l_locs_of_uniqueness
apply (cut_tac a=a and b=y and f=f in l_locs_of_uniqueness,simp_all)
apply (simp add: l_locs_of_uniqueness)
apply simp_all
apply (frule k_in_locs_iff[of f _],simp)
unfolding locs_def
find_theorems name:"fun" name:iff
sorry

lemma l_locs_of_itself:
  "nat1 y \<Longrightarrow> x \<in> locs_of x y"
unfolding locs_of_def
by auto

(*========================================================================*)
section {* Refinement L0-L1 adequacy proof lemmas *}
(*========================================================================*)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* Lemmas about L0-L1 definitions *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

lemma l_nat1_card:
  "finite F \<Longrightarrow> F \<noteq> {} \<Longrightarrow> nat1 (card F)"
by (simp add: card_gt_0_iff)

lemma l_loc_of_singleton: 
  "locs_of x (Suc 0) = {x}"
unfolding locs_of_def
by auto

lemma "nat1 y \<Longrightarrow> Min(locs_of x y) \<in> locs_of x y"
apply (rule Min_in)
apply (metis b_locs_of_finite)
by (metis b_locs_of_non_empty)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* Lemmas about retrieve function *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

lemma l_nat1_map_dom_in_retr0: "nat1_map f \<Longrightarrow> x\<in>dom f \<Longrightarrow> x \<in> (retr0 f)"
unfolding retr0_def locs_def 
by (simp, metis f_dom_locs_of)

lemma l_dom_within_retr0: "nat1_map f \<Longrightarrow> dom f \<subseteq> retr0 f"
by (metis l_nat1_map_dom_in_retr0 subsetI)

lemma l_disjoint_retr0_not_in_dom: 
    "F' \<noteq> {} \<Longrightarrow> finite F' \<Longrightarrow> nat1_map f1 \<Longrightarrow> disjoint F' (retr0 f1) \<Longrightarrow> Min F' \<notin> dom f1"
unfolding disjoint_def
by (metis Min_in disjoint_iff_not_equal l_nat1_map_dom_in_retr0)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* Lemmas about Level0 contiguousness function *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

lemma f_contiguous_finite:
    "contiguous F \<Longrightarrow> finite F"
unfolding contiguous_def
by (metis b_locs_of_finite)
find_theorems "finite(locs_of _ _)" --"changed definition of contiguous!"

lemma f_contiguous_non_empty:
    "contiguous F \<Longrightarrow> F \<noteq> {}"
unfolding contiguous_def
by (metis b_locs_of_non_empty)

(* Thanks to IJW eq_locs 
lemma b_contiguous_locs_off_iff:
  "contiguous F \<Longrightarrow> locs_of (Min F) (card F) = F"
apply (frule f_contiguous_finite)
apply (frule f_contiguous_non_empty)
(*apply (induct_tac F rule: finite_induct) 
      WAHHHA... Here if I used \<longrightarrow> instead of \<Longrightarrow> it wouldn't complain
      yet it wouldn't give me the other bits I need for the frule above...
apply (rule finite_induct) - wrong rule!
 *)
find_theorems  name:indu  name:Finite
apply (rule finite_ne_induct)
apply (simp_all add: l_loc_of_singleton)
unfolding locs_of_def
find_theorems "card _ > 0"
apply (simp_all add: card_gt_0_iff)
find_theorems "_ = (_::'a set)" name:Set -name:Inter
apply (rule equalityI)
apply (rule subsetI)
unfolding min_def
apply (simp_all split: split_if_asm)
oops
*)

lemma l_locs_of_min:
  "nat1 y \<Longrightarrow> Min(locs_of x y) = x"
(*
find_theorems  name:Nat name:ind
thm strict_inc_induct[of x _ "(\<lambda> l . Min(locs_of x y )=l)"]
thm nat_less_induct[of "(\<lambda> l . Min(locs_of x y )=l)" x]
thm full_nat_induct[of "(\<lambda> l . Min(locs_of x y )=l)" x]
thm less_induct
apply (induct y rule: full_nat_induct)
apply (metis less_not_refl nat1_def)
unfolding nat1_def locs_of_def
apply simp
find_theorems "Min {_ . _}"
thm add_Min_commute[of "{x..<y}" 0,simplified]
find_theorems simp:"{_ .. _}"

apply (subst add_Min_commute)
apply (induct_tac rule: strict_inc_induct)
find_theorems simp:"_(locs_of _ _)"

TODO: see IJW's min_contig proof and adjust? 
*) 
sorry

(* NOTE: Thank you to Iain for sharing the idea of the lemma above; card lemma already in HEAP0Lemmas -- see his eq_locs *)
lemma b_contiguous_locs_off_iff:
  "finite F \<Longrightarrow> F \<noteq> {} \<Longrightarrow> contiguous F \<Longrightarrow> locs_of (Min F) (card F) = F"
unfolding contiguous_def
apply (elim exE conjE)
by (simp add: l_locs_of_min l_locs_of_card)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection {* Induction principle for adequacy proof *}
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* TODO: adjust this to get closer to the F1_inv (i.e. IJW's "invariant preserving induction") *)
(* Induction rule as suggested by Cliff *) 
lemma contig_nonabut_finite_set_induct [case_names empty extend, induct set: finite]:
  assumes fin: "finite F" (* Requires a finite set *)
    and empty: "P {}" (* Base case for the empty set *)
    and extend: "\<And> F F'. finite F \<Longrightarrow> 
                          finite F' \<Longrightarrow> 
                          F' \<noteq> {} \<Longrightarrow> 
                          contiguous F' \<Longrightarrow>
                          (* keep this order F' F for convenience because of locs_of \<inter> locs lemmas *)
                          disjoint F' F \<Longrightarrow> 
                          non_abutting F' F \<Longrightarrow> 
                          P F \<Longrightarrow> 
                          P (F \<union> F')"
  shows "P F"
using `finite F`
find_theorems name:Finite_Set name:induc
proof (induct rule: finite_induct)
  show "P {}" by fact
  fix x F assume F: "finite F" and P: "P F"
  show "P (insert x F)"
  proof cases
    assume "x \<in> F"
    hence "insert x F = F" by (rule insert_absorb)
    with P show ?thesis by (simp only:)
  next
    assume "x \<notin> F"
    from F this P show ?thesis sorry
  qed
qed

(*
using assms
proof induct
  case empty then show ?case by simp
next
  case (insert x F) then show ?case by cases auto
qed
*)


(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ F1_inv update ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

(* Coalesce together (rather artificially) the conditions needed for the invariant proofs.
   They come from the separate lemmas created for each part of the invariant. This makes
   the underlying refinement proof a little bit shorter/direct. In a way, that could be
   viewed as a proof pattern/family being reused?
 *)
lemma l_F1_inv_singleton_upd:
  "nat1 y \<Longrightarrow> x \<notin> dom f \<Longrightarrow> F1_inv f \<Longrightarrow> 
      disjoint (locs_of x y) (locs f) \<Longrightarrow> 
      sep0 f [x\<mapsto>y] \<Longrightarrow> x+y \<notin> dom f \<Longrightarrow> F1_inv(f \<union>m [x \<mapsto> y])" 
unfolding F1_inv_def
apply (elim conjE)
apply (intro conjI)
apply (simp add: l_disjoint_singleton_upd)
apply (simp add: l_sep_singleton_upd)
apply (simp add: l_nat1_map_singleton_upd)
apply (simp add: l_finite_singleton_upd)
done


end
