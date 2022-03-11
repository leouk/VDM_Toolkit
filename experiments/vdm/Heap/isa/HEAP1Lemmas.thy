(* $Id$ *)
theory HEAP1Lemmas
imports HEAP1 HEAP0Lemmas
begin

text \<open> This theory provides various lemmas for breaking the problem into managelable chunks \<close>

(*========================================================================*)
section \<open> General Lemmas \<close>
(*========================================================================*)

text
\<open> These lemmas are used in the context of NEW1 FSB locale proofs.
   Prefixes determine the intent (our whys?) as given by the expert.
   Depending on context, some intents could have more than one prefix
   or even change prefix (as determined by the expert). These "tags"
   should serve as clues for strategy languages and learning mechanisms
   to infer new (useful) lemmas or indeed strategies (proof patterns).
 
   Prefixes:
    ``k\_'' = weakening goal     (barkward reasonsing)
    ``f\_'' = deduction from asm (forward reasonsing)
    ``b\_'' = type/concept bridges 
    ``l\_'' = expert lemmas 
 \<close>
 
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> nat1\_map weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* FD (Forward Deduduction): nat1_map elements are nat 1 *)
lemma f_nat1_map_nat1_elem:
	"nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> 0 < (the(f x))"
	unfolding nat1_map_def nat1_def inv_VDMNat1_def
  by auto
    (* SHAPE: This LEMMA needs to be "0 < bla" because nat1_def has iff status *)

(* FD: submap extends nat1_map *)
lemma f_nat1_map_extends_map_le: 
  "g \<subseteq>\<^sub>m f \<Longrightarrow> nat1_map f \<Longrightarrow> nat1_map g"
apply (frule map_le_implies_dom_le)
unfolding map_le_def nat1_map_def
apply (intro allI impI)
apply (drule bspec, assumption)
apply (drule spec, drule mp)
apply simp_all
by (drule subsetD, assumption) 
(* NEVER USED: because found fun_eq_iff; perhaps useful later? *)

(* Weaken: nat1_map subsumes dom_ar: taken to the top for use with other locs_of lemmas *)
lemma k_nat1_map_dom_ar:
   "nat1_map f \<Longrightarrow> nat1_map (S -\<triangleleft> f)"
by (metis nat1_map_def f_in_dom_ar_subsume f_in_dom_ar_the_subsume)

(* Weaken: specific version of previous LEMMA. TODO: Iain help to avoid? *)
lemma k_nat1_map_dom_ar_specific: 
   "nat1_map f \<Longrightarrow> nat1_map ({r} -\<triangleleft> f)"
by (metis k_nat1_map_dom_ar)

(* Lemma: nat1_map over dagger *)
lemma l_nat1_map_dagger: "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> nat1_map(f \<dagger> g)"
unfolding nat1_map_def
apply (intro allI impI)
apply (simp add: l_dagger_dom l_dagger_apply)
by metis

(* Lemma: nat1_map over munion *)
lemma l_nat1_map_munion: "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> nat1_map(f \<union>m g)"
unfolding nat1_map_def
apply (intro allI impI)
apply (simp add: l_munion_dom l_munion_apply)
by metis

(* Lemma: nat1_map over map singleton *)
lemma l_nat1_map_singleton: "nat1 y \<Longrightarrow> nat1_map([x \<mapsto> y])"
(*
"spass": Try this: by (smt dom_empty empty_iff fun_upd_same l_inmapupd_dom_iff nat1_map_def the.simps) (65 ms). 
"z3": Try this: by (metis (lifting, mono_tags) fun_upd_def l_inmapupd_dom_iff l_map_non_empty_has_elem_conv nat1_map_def the.simps) (316 ms).
*)
by (metis fun_upd_triv map_add_empty map_add_upd map_le_map_add nat1_map_def f_nat1_map_extends_map_le option.sel)
  (* NOTE: This is an interesting case. Sledgehammer on the smaller set of assumptions 
           finds the proof, yet when called under the locs f1' \<subseteq> locs f1 (after NEW1_gr)
           it fails, despite having (larger set of) assumptions to finish it. 

           Metis, by using f_nat1_map_extends_map_le goes around the block instead of doing it more directly. 
   *)

(* Lemma: nat1_map on empty map *)
lemma l_nat1_map_empty: "nat1_map Map.empty"
by (metis dom_empty empty_iff nat1_map_def)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> locs\_of weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> These lemmas were useful in the Z/EVES development and now here.
		At first we had difficulties with the style of declaration as 
		intro/elim/dest rules. I tried to keep them as iff is possible.
	  \<close>

(* Weaken: Locs_of (over f) to locs_of (over f's range) *)
lemma l_locs_of_Locs_of_iff:
	"l \<in> dom f \<Longrightarrow> Locs_of f l = locs_of l (the (f l))"
unfolding Locs_of_def
by simp
	
(* Weaken: locs_of common term (disjointness) to arithmetic b_ ? *)
lemma k_locs_of_arithIff:
	"nat1 n \<Longrightarrow> nat1 m \<Longrightarrow> (locs_of a n \<inter> locs_of b m = {}) = (a+n \<le> b \<or> b+m \<le> a)"
unfolding locs_of_def 
apply simp
apply (rule iffI)
find_theorems "_ \<inter> _ = {}" (* interesting LEMMA about Set_Interval suggests itself *)
apply (erule equalityE)
  apply (simp_all add: disjoint_iff_not_equal)
  apply (metis inv_VDMNat1_def le_less less_add_same_cancel1 not_less of_nat_0_less_iff)
by (metis le_trans not_less)

(* Weaken: dom_ar locs_of subset *)
lemma k_locs_of_dom_ar_subset: 
  "nat1_map f \<Longrightarrow> x \<in> dom (S -\<triangleleft> f) \<Longrightarrow> locs_of x (the((S -\<triangleleft> f) x)) \<subseteq> locs_of x (the(f x))"
apply (frule k_nat1_map_dom_ar[of _ S])
apply (frule f_nat1_map_nat1_elem[of "S -\<triangleleft> f" _],assumption)
  (* NOTE: nice massaging of assumptions. TODO: Iain, anyway to do this simply? *)
apply (rule subsetI)
by (metis f_in_dom_ar_apply_subsume)
(*
  unfolding locs_of_def
  apply (simp split: split_if_asm)
  apply (frule f_in_dom_ar_the_subsume)
  apply (erule conjE, intro conjI impI)
  by simp_all
*)

(* Weaken: Locs_of common term to arithmetic *)
lemma k_Locs_of_arithIff:
	"nat1_map f \<Longrightarrow> l \<in> dom f \<Longrightarrow> k \<in> dom f \<Longrightarrow> (Locs_of f l \<inter> Locs_of f k = {}) = (l+the(f l) \<le> k \<or> k+the(f k) \<le> l)"
	unfolding Locs_of_def 
	by (simp add: k_locs_of_arithIff nat1_map_def)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> locs weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* Weaken: extend locs elem *)
lemma k_in_locs_iff: "nat1_map f \<Longrightarrow> (x \<in> locs f) = (\<exists>y \<in> dom f . x \<in> locs_of y (the(f y)))"
unfolding locs_def
by (metis (mono_tags) UN_iff)

(* Lemma: locs_of within locs *)
lemma l_locs_of_within_locs:
  "nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> locs_of x (the(f x)) \<subseteq> locs f"
by (metis k_in_locs_iff subsetI)
  (* NOTE: Another example where sledgehammer fails in the context of more assumptions. *)

(* Weaken: extend locs_of disjoint locs *)
lemma k_inter_locs_iff: "nat1 s \<Longrightarrow> nat1_map f \<Longrightarrow> (locs_of x s \<inter> locs f = {}) = (\<forall> y \<in> dom f . locs_of x s \<inter> locs_of y (the(f y)) = {})"
unfolding locs_def 
by (smt UNION_empty_conv(1) inf_SUP)

(* Lemma: locs subset of submap *)
lemma l_locs_subset:
  "nat1_map f \<Longrightarrow> g \<subseteq>\<^sub>m f \<Longrightarrow> locs g \<subseteq> locs f"
apply (frule f_nat1_map_extends_map_le, assumption)
apply (rule subsetI)
unfolding locs_def
apply (simp)
apply (erule bexE)
apply (frule map_le_implies_dom_le)
unfolding map_le_def
apply (drule bspec, assumption)
thm in_mono set_rev_mp set_mp
by (metis set_mp)

(* Lemma: locs of dom_ar equivalence *)
lemma l_locs_dom_ar_iff:
  "nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> locs({r} -\<triangleleft> f) = locs f - locs_of r (the(f r))"
apply (rule equalityI)
apply (rule_tac [1-] subsetI)
apply (frule_tac [1-] k_nat1_map_dom_ar[of _ "{r}"])
apply (simp_all add: k_in_locs_iff)
defer 
apply (elim conjE)
defer 
apply (intro conjI)
apply (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
apply (erule_tac [1-] bexE)
defer 
apply (rule_tac x=y in bexI)
apply (metis f_in_dom_ar_apply_not_elem singleton_iff)
apply (metis l_dom_dom_ar member_remove remove_def)
apply (frule f_in_dom_ar_subsume)
apply (frule f_in_dom_ar_the_subsume)
unfolding Disjoint_def disjoint_def
apply (simp add: l_locs_of_Locs_of_iff)
by (metis disjoint_iff_not_equal f_in_dom_ar_notelem)

lemma l_locs_dom_ar_general_iff:
  "nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> S \<subseteq> dom f \<Longrightarrow> locs(S -\<triangleleft> f) = locs f - (\<Union>r\<in>S . locs_of r (the(f r)))"
apply (rule equalityI)
apply (rule_tac [1-] subsetI)
apply (frule_tac [1-] k_nat1_map_dom_ar[of _ S])
apply (simp_all add: k_in_locs_iff)
defer 
apply (elim conjE)
defer 
apply (intro conjI)
apply (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
apply (erule_tac [1-] bexE)
apply (rule ballI)
apply (metis Disjoint_def disjoint_def disjoint_iff_not_equal f_in_dom_ar_apply_subsume l_dom_ar_notin_dom_or l_locs_of_Locs_of_iff set_rev_mp)
apply (cases "S = {}")
  apply (simp add: l_dom_ar_none)
  apply metis
by (metis domIff f_in_dom_ar_apply_not_elem)

(* Lemma: locs empty map *)
lemma l_locs_empty_iff:
    "locs Map.empty = {}"
apply (rule equalityI)
apply (rule_tac [1-] subsetI)
apply simp_all
apply (subgoal_tac "nat1_map Map.empty")
  apply (simp add: locs_def)
by (rule l_nat1_map_empty)

(* Lemma: locs singleton map *)
lemma l_locs_singleton_iff:
  "nat1 y \<Longrightarrow> locs [x \<mapsto> y] = locs_of x y"
unfolding locs_def locs_of_def nat1_map_def
by simp
  (* NOTE: Another example where sledgehammer can't find the proof because of
           this missing (easy) LEMMA occurs for the proof of locs f1' \<subseteq> locs f1
           for NEW1_gr.
   *)

(* FD: in dom in locs_of *)
lemma f_dom_locs_of: "nat1_map f \<Longrightarrow> (x \<in> dom f) \<Longrightarrow> (x \<in> locs_of x (the (f x)))"
  unfolding locs_of_def
  by (simp add: f_nat1_map_nat1_elem inv_VDMNat1_def)
(*
by (metis (lifting) add_diff_cancel_left' comm_monoid_diff_class.diff_cancel 
                    eq_imp_le f_nat1_map_nat1_elem le_add1 le_neq_implies_less 
                    mem_Collect_eq nat1_map_def nat_neq_iff)

*)

(* FD: in dom is in locs *)
lemma f_in_dom_locs: "nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> x \<in> locs f"
apply (simp add: k_in_locs_iff)
apply (rule bexI)
by (simp_all add: f_dom_locs_of)

(* Lemma: locs munion equivalence *)
lemma l_locs_munion_iff:
      "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> locs(f \<union>m g) = locs f \<union> locs g"
apply (rule equalityI)
apply (rule_tac [1-] subsetI) \<comment> \<open>Little trick to cover all goals\<close>
apply simp_all
apply (rule disjCI) \<comment> \<open>Keep the contrapositive information; it's useful later \<close>
defer 
apply (erule disjE)
apply (simp_all add: k_in_locs_iff l_nat1_map_munion l_munion_dom l_munion_apply)
apply (erule_tac [1-] bexE)
apply (rule_tac [1-2] x=y in bexI)
apply (simp_all)
apply (metis disjoint_iff_not_equal)
  (* NOTE: see also *)
  thm all_not_in_conv
apply (erule disjE)
apply (rule_tac x=y in bexI)
apply (metis (full_types))
apply assumption
by (metis (full_types))
  (* NOTE: This theorem, although for munion, is easier than its version for dagger. 
           That's because of the stronger condition needed for munion well-definedness
           gives the right assumption necessary for the proof. Dagger needs similar, yet
           weaker asssumption. 

           Next we prove both sides of equality for locs and dagger where different
           sets of assumptions are needed. *)

(* Lemma: locs dagger within locs union *)
lemma l_locs_dagger_union_subset:
  "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> locs(f \<dagger> g) \<subseteq> locs f \<union> locs g"
apply (rule subsetI)
apply simp
apply (rule disjCI)
apply (simp_all add: k_in_locs_iff l_nat1_map_dagger l_dagger_dom l_dagger_apply)
apply (erule bexE)
apply simp
apply (erule disjE)
apply (metis (full_types))
by (metis (full_types))

(* Lemma: locs dagger equivalence *)
lemma l_locs_dagger_iff:
  "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> (\<forall> x \<in> dom f \<inter> dom g . the(f x) \<le> the(g x)) \<Longrightarrow> locs(f \<dagger> g) = locs f \<union> locs g"
apply (rule equalityI)
apply (simp add: l_locs_dagger_union_subset)
apply (rule  subsetI)
apply simp
apply (erule disjE)
apply (simp_all add: k_in_locs_iff l_nat1_map_dagger l_dagger_dom l_dagger_apply)
apply (erule_tac [1-] bexE)
apply (rule_tac [1-] x=y in bexI)
apply (simp_all)
apply (rule impI)
apply (simp add: b_locs_of_as_set_interval f_nat1_map_nat1_elem inv_VDMNat1_def)
apply (erule conjE)
apply (erule_tac x=y in ballE)
by simp_all
  (* NOTE: Here the extra assumption is subtle (if obvious): wherever they share an element,
           the value in x better be within the value in g otherwise the update wouldn't be just union.
   *)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> min_loc lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

lemma k_min_loc_munion:
  "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> 
    g \<noteq> Map.empty \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> 
        min_loc(f \<union>m g) = (if f = Map.empty then min_loc g else min (min_loc f) (min_loc g))"
unfolding min_loc_def munion_def
by (simp add: l_dagger_not_empty l_dagger_dom Min_Un)

lemma l_min_loc_singleton:
  "min_loc [d \<mapsto> s] = d"
unfolding min_loc_def
by simp
\<comment> \<open>by (metis dom_empty finite.emptyI inf_bot_left k_min_loc_munion_singleton l_munion_empty_lhs) = Overkill!\<close>

lemma k_min_loc_munion_singleton:
  "finite (dom f) \<Longrightarrow>
    dom f \<inter> dom [d \<mapsto> s] = {} \<Longrightarrow> 
        min_loc(f \<union>m [d \<mapsto> s]) = (if f = Map.empty then d else min (Min (dom f)) d)"
apply (simp add: k_min_loc_munion l_min_loc_singleton)
by (metis min_loc_def) 

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> sum_size lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

lemma l_sum_size_munion:
  "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> 
    g \<noteq> Map.empty \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> 
        sum_size(f \<union>m g) = (if f = Map.empty then sum_size g else (sum_size f) + (sum_size g))"
unfolding sum_size_def munion_def
apply (simp add: l_dagger_not_empty l_dagger_empty_lhs l_dagger_dom l_dagger_apply)
apply (rule impI)
  find_theorems "(\<Sum> _ \<in> _ . _) = ((\<Sum> _ \<in> _ . _) + (\<Sum> _ \<in> _ . _))"
  find_theorems name:disjoint name:union
  (*thm setsum.F_Un_neutral[of "dom f" "dom g" "(\<lambda> x . the (if x \<in> dom g then g x else f x))",simplified]
  thm setsum_Un_disjoint[of "dom f" "dom g" "(\<lambda> x . the (if x \<in> dom g then g x else f x))",simplified]*)
  (*thm setprod.union_inter_neutral[of "dom f" "dom g" "(\<lambda> x . the (if x \<in> dom g then g x else f x))",simplified]
  thm setsum.union_disjoint[of "dom f" "dom g" "(\<lambda> x . the (if x \<in> dom g then g x else f x))",simplified]*)
apply (simp add: sum.union_disjoint)
apply (rule sum.cong,simp)
by (metis (full_types) disjoint_iff_not_equal)

lemma l_sum_size_singleton:
  "sum_size [d \<mapsto> s] = s"
unfolding sum_size_def
by simp

lemma l_sum_size_munion_singleton:
  "finite (dom f) \<Longrightarrow>
    dom f \<inter> dom [d \<mapsto> s] = {} \<Longrightarrow> 
        sum_size(f \<union>m [d \<mapsto> s]) = (if f = Map.empty then s else sum_size f + s)"
by (simp add: l_sum_size_munion l_sum_size_singleton)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> Other (less useful) lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* Lemma: disjoint commutes *)
lemma l_disjoint_comm:
	"(disjoint A B) = (disjoint B A)"
by (metis disjoint_def inf_commute)

lemma f_F1_inv_disjoint: 
  "F1_inv f \<Longrightarrow>  Disjoint f"
by (metis F1_inv_def)

lemma f_F1_inv_nat1_map: 
  "F1_inv f \<Longrightarrow> nat1_map f"
by (metis F1_inv_def)

lemma f_F1_inv_sep: 
  "F1_inv f \<Longrightarrow> sep f"
by (metis F1_inv_def)

lemma f_F1_inv_finite: 
  "F1_inv f \<Longrightarrow>  finite(dom f)"
by (metis F1_inv_def)

(*========================================================================*)
section \<open> Goal-oriented - invariant update \<close>
(*========================================================================*)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> Lemmas for invariant sub parts over known operators \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> This is a great example of repeated patterns. \<close>

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ SEP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

(*
lemmX "nat1_map f \<Longrightarrow> sep f \<Longrightarrow> Disjoint f"
unfolding sep_def Disjoint_def disjoint_def
apply (intro ballI impI)
apply (simp add: l_locs_of_Locs_of_iff)
apply (simp add:  k_locs_of_arithIff f_nat1_map_nat1_elem)
apply (rule disjI1)
find_theorems simp:"_ \<le> _" intro
apply (erule_tac x=a in ballE)
apply (rule less_imp_le_nat)
apply (frule f_dom_locs_of)
apply simp
back
apply (frule f_nat1_map_nat1_elem)
apply simp
back
unfolding locs_of_def
apply simp
oops
*)

(*
lemmX l_sep_singleton_ext: 
    "nat1_map f \<Longrightarrow> x \<notin> dom f \<Longrightarrow> nat1 y \<Longrightarrow> sep f \<Longrightarrow> 
          disjoint (locs_of x y) (locs f) \<Longrightarrow> sep(f \<union>m [x \<mapsto> y])"
unfolding disjoint_def sep_def
apply (simp add: l_locs_of_Locs_of_iff)
apply (intro ballI impI)
apply (simp add: l_munion_dom l_munion_apply)
apply (intro conjI impI)
apply (simp_all add: k_inter_locs_iff 
                     k_locs_of_arithIff f_nat1_map_nat1_elem)
defer
apply (erule_tac x=l in ballE)
apply (erule_tac x=l in ballE)
apply (simp_all)
apply (erule disjE)
apply simp \<comment> \<open>Ahh!: Condition is wrong, needs to be strictly less than\<close>
defer
apply (cases "f = empty")
find_theorems "_ \<noteq> empty"
apply (simp_all add: l_map_non_empty_has_elem_conv)
apply (erule exE)
apply (erule_tac x=xa in ballE)
apply (erule_tac x=xa in ballE)
apply (simp_all)
oops -- "NOTE: not quite right the side condition here"
*)

lemma l_sep_singleton: "nat1 y \<Longrightarrow> sep([x \<mapsto> y])"
unfolding sep_def nat1_def inv_VDMNat1_def
by simp

(* LF: Iain how to do that without isar?
lemmX finite_map_upd_induct_2 [case_names empty insert, induct set: finite]:
    "\<lbrakk>finite (dom f) ; P Map.empty ;
      (\<And> e r f. finite (dom f) \<Longrightarrow> e \<notin> dom f \<Longrightarrow> P f \<Longrightarrow> P (f(e \<mapsto> r)))\<rbrakk> \<Longrightarrow> P f"
apply (induct "dom f" arbitrary: f rule:finite_induct)
apply (metis (full_types) b_dagger_munion dom_empty empty_iff empty_subsetI l_dagger_lhs_absorb_ALT_PROOF l_munion_subsumeG)
find_theorems "(\<And> _ . _)" name:HOL
apply (subgoal_tac "\<exists> x .  x = f |` F")
apply (erule exE)
apply auto
apply (rename_tac y G g)
apply (subgoal_tac "")
apply (erule )
apply (frule_tac x=f in allI)
apply (erule allE)
oops
*)

definition 
  sep0 :: "F1 \<Rightarrow> F1 \<Rightarrow> bool" 
where
  "sep0 f g \<equiv> (\<forall> l \<in> dom f . l + the(f l) \<notin> dom g)"

lemma "sep0 f f = sep f"
unfolding sep0_def sep_def
by simp

lemma l_sep_singleton_upd: 
    "nat1_map f \<Longrightarrow> x \<notin> dom f \<Longrightarrow> x+y \<notin> dom f \<Longrightarrow> nat1 y \<Longrightarrow> sep f \<Longrightarrow> 
          sep0 f [x\<mapsto>y] \<Longrightarrow> sep(f \<union>m [x \<mapsto> y])"
unfolding sep_def sep0_def
apply (rule ballI)
apply (simp add: l_munion_dom l_munion_apply)
apply (erule disjE)
by (simp_all add: inv_VDMNat1_def)

lemma l_sep_munion:
    "dom f \<inter> dom g = {} \<Longrightarrow> sep f \<Longrightarrow> sep g \<Longrightarrow> sep0 f g \<Longrightarrow> sep0 g f \<Longrightarrow> sep(f \<union>m g)"
unfolding sep_def sep0_def
by (auto simp: l_munion_dom l_munion_apply)

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ DISJOINT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

lemma "nat1_map f \<Longrightarrow> x \<notin> dom f \<Longrightarrow> nat1 y \<Longrightarrow> Disjoint f \<Longrightarrow> 
          (\<forall> c \<in> dom f . x+y \<le> c \<or> c+the(f c) \<le> x) \<Longrightarrow> Disjoint(f \<union>m [x \<mapsto> y])"
unfolding Disjoint_def 
apply (simp add: l_locs_of_Locs_of_iff)
apply (intro ballI impI)
apply (simp add: l_munion_dom l_munion_apply)
apply (intro conjI impI)
apply (simp_all add: l_disjoint_comm)
unfolding disjoint_def
find_theorems "locs_of _ _ \<inter> _ = {}"
by (simp_all add: k_locs_of_arithIff f_nat1_map_nat1_elem inv_VDMNat1_def)
     (* NOTE: A general LEMMA here is difficult: we need the side condition for where the new map belongs
              (\<forall> c \<in> dom f . x+y \<le> c \<or> c+the(f c) \<le> x) 
      *)
thm k_locs_of_arithIff[of y "the(f c)" x c,symmetric]
     (*  x+y \<le> c \<or> c+the(f c) \<le> x *)

lemma l_disjoint_singleton_upd: 
    "nat1_map f \<Longrightarrow> x \<notin> dom f \<Longrightarrow> nat1 y \<Longrightarrow> Disjoint f \<Longrightarrow> 
          disjoint (locs_of x y) (locs f) \<Longrightarrow> Disjoint(f \<union>m [x \<mapsto> y])"
unfolding Disjoint_def 
apply (simp add: l_locs_of_Locs_of_iff)
apply (intro ballI impI)
apply (simp add: l_munion_dom l_munion_apply)
apply (intro conjI impI)
apply (simp_all)
unfolding disjoint_def
find_theorems "locs _"
find_theorems "locs_of _ _ \<inter> _ = {}"
apply (metis k_inter_locs_iff nat1_def)
by (metis inf_commute k_inter_locs_iff nat1_def)

lemma l_disjoint_singleton: "Disjoint([x \<mapsto> y])"
unfolding Disjoint_def
by simp

lemma l_disjoint_locs_locs_of:
  "nat1_map f \<Longrightarrow>
   nat1_map g \<Longrightarrow>
   Disjoint f \<Longrightarrow>
   Disjoint g \<Longrightarrow>
   a \<in> dom g \<Longrightarrow>
   b \<in> dom f \<Longrightarrow> 
   dom f \<inter> dom g = {} \<Longrightarrow>
   disjoint (locs f) (locs g) \<Longrightarrow> 
   disjoint (locs_of a (the (g a))) (locs_of b (the (f b)))"
unfolding disjoint_def
apply (frule f_in_dom_locs[of f], simp_all)
apply (frule f_in_dom_locs[of g], simp_all)
apply (simp add: disjoint_iff_not_equal[of "locs_of a (the (g a))"])
apply (intro ballI)
thm l_locs_of_within_locs[of f b]
apply (frule l_locs_of_within_locs[of f b],simp)
apply (frule l_locs_of_within_locs[of g a],simp)
apply (simp add: disjoint_iff_not_equal[of "dom f"])
apply (erule ballE[where x=b], erule ballE[where x=a],simp_all)
by blast

lemma l_disjoint_munion: 
  "nat1_map f \<Longrightarrow> nat1_map g \<Longrightarrow> Disjoint f \<Longrightarrow> Disjoint g \<Longrightarrow> 
      dom f \<inter> dom g = {} \<Longrightarrow> disjoint (locs f) (locs g) \<Longrightarrow> sep0 f g \<Longrightarrow> sep0 g f \<Longrightarrow> Disjoint (f \<union>m g)"
unfolding Disjoint_def
apply (intro impI ballI)
apply (simp add: l_locs_of_Locs_of_iff l_munion_apply l_munion_dom)
apply (intro impI conjI)
apply simp_all
apply (simp_all add: l_locs_of_Locs_of_iff[symmetric])
apply (fold Disjoint_def)
apply (simp_all add: l_locs_of_Locs_of_iff)
apply (simp add: l_disjoint_locs_locs_of)
thm l_disjoint_locs_locs_of[of g f]
  (* LF: this is annoying; need to learn Isar :-( *)
apply (frule l_disjoint_locs_locs_of[of g f],simp_all)
apply (simp add: Int_commute)
apply (simp add: l_disjoint_comm)
done

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ nat1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

lemma l_nat1_map_singleton_upd: "nat1 y \<Longrightarrow> x \<notin> dom f \<Longrightarrow> nat1_map f \<Longrightarrow> nat1_map(f \<union>m [x \<mapsto> y])"
unfolding nat1_map_def
by (simp add: l_munion_dom l_munion_apply)

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ finite ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

lemma l_finite_singleton_upd: 
  "nat1 y \<Longrightarrow> x \<notin> dom f \<Longrightarrow> finite(dom f) \<Longrightarrow> finite(dom(f \<union>m [x \<mapsto> y]))"
by (simp add: l_munion_dom)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> NEW1 update - equal case \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> Most lemmas are marked as weakening rules. That's because they
        used by the top-level goals for the proof obligations. In other
        scenarios, they could be used a deduction (FD) rules as well.
      \<close>

(* Weaken: Disjointness subsumes dom_ar *)
lemma k_Disjoint_dom_ar:
	"Disjoint f \<Longrightarrow> Disjoint (S -\<triangleleft> f)"
by (smt Disjoint_def Locs_of_def domIff dom_antirestr_def)

(* Weaken: separatedness subsumes dom_ar *)
lemma k_sep_dom_ar:
   "sep f \<Longrightarrow> sep (S -\<triangleleft> f)"
by (metis (full_types) f_in_dom_ar_subsume f_in_dom_ar_the_subsume sep_def)


lemma "Disjoint f \<Longrightarrow> sep({x} -\<triangleleft> f) = sep f"
apply rule
defer
apply (metis k_sep_dom_ar)
unfolding sep_def 
apply (intro ballI)
find_theorems "the((_ -\<triangleleft> _) _)"
find_theorems simp:"dom(_ -\<triangleleft> _)"
apply (simp add: f_in_dom_ar_the_subsume l_dom_dom_ar)
apply (erule_tac x=l in ballE)
apply (rule notI,simp)
unfolding Disjoint_def disjoint_def Locs_of_def
apply (erule_tac x=l in ballE)
apply (erule_tac x="l + the (f l)" in ballE)
apply simp_all
defer
apply (erule_tac x=l in ballE)
apply (erule_tac x="l + the (f l)" in ballE)
apply simp_all
nitpick
oops

(* Weaken: nat1_map subsumes dom_ar: taken to the top for use with other locs_of lemmas 
lemmX k_nat1_map_dom_ar:
   "nat1_map f \<Longrightarrow> nat1_map (S -\<triangleleft> f)"
by (metis nat1_map_def f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
*)

(* Weaken: finiteness subsumes dom_ar *)
lemma k_finite_dom_ar:
   "finite (dom f) \<Longrightarrow> finite (dom (S -\<triangleleft> f))"
by (metis finite_subset f_in_dom_ar_subsume subsetI)

lemma k_F1_inv_dom_ar: 
   "F1_inv f \<Longrightarrow> F1_inv(S -\<triangleleft> f)"
by (metis F1_inv_def k_Disjoint_dom_ar k_finite_dom_ar k_nat1_map_dom_ar k_sep_dom_ar)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> NEW1 update - greater than case \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> In this final subsection, we get to the actual lemmas used by
        top-level goals. These lemmas were first defined in terms of @{text "f \<dagger> g"},
        which later turned into @{text "f \<union> g"}. 

        The proof strategy here is the same for each of the four parts
        of the invariant, providing we expose a key fact about the specific
        (greater than update) case: the updated value cannot be in dom f.
        This is crucial for the @{text "(f \<union>m g)"} operation to be well-defined.

        A more specific lemma, useful only for the Disjoint invariant, is
        proved. It shows that the locations of the update are within the
        locations prior to the update, as expected. That is, we lift/bridge
        the update locations from the given value (r+s) to original (r).
      \<close>

(* Lemma: updated value (r+s) cannot be in domain f *)
lemma l_disjoint_mapupd_keep_sep:
	"nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> nat1 s \<Longrightarrow> the(f r) > s \<Longrightarrow> (r+s) \<notin> dom f"
unfolding Disjoint_def
apply (erule_tac x=r in ballE)
apply (erule_tac x="(r+s)" in ballE)
apply (erule impE)
apply (simp_all add: inv_VDMNat1_def)
apply (rule notI)
apply (simp add: l_locs_of_Locs_of_iff)
(* Failed after 2014
unfolding disjoint_def
by (smt k_locs_of_arithIff nat1_map_def)
*)
  apply (simp add: k_locs_of_arithIff nat1_map_def)
sledgehammer
  by (simp add: F1_inv_defs(7) k_locs_of_arithIff)

(* Weaken (aux): updated value (r+s) cannot be in domain f restricted *)
lemma k_new1_gr_dom_ar_dagger_aux2:
	"nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> nat1 s \<Longrightarrow> the(f r) > s \<Longrightarrow> r+s \<notin> dom ({r} -\<triangleleft> f)"
by (metis f_in_dom_ar_subsume l_disjoint_mapupd_keep_sep)

(* Weaken (aux): domains of involved map expressions are disjoint (for munion proofs) *)
lemma k_new1_gr_dom_ar_dagger_aux:
	"nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> nat1 s \<Longrightarrow> the(f r) > s \<Longrightarrow> dom ({r} -\<triangleleft> f) \<inter> dom [r + s \<mapsto> the (f r) - s] = {}"
apply (subst disjoint_iff_not_equal)
by (metis dom_eq_singleton_conv f_in_dom_ar_subsume l_disjoint_mapupd_keep_sep singletonE)

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ DISJOINT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

(* Bridge: locations of updated value (r+s) within original locations (r) *)
lemma b_new1_gr_upd_within_req_size:
	"r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1_map f \<Longrightarrow> 
		locs_of (r+s) (the (f r) - s) \<subseteq> locs_of r (the(f r))"
	thm b_locs_of_as_set_interval
	by (simp add: b_locs_of_as_set_interval inv_VDMNat1_def)
	(* NOTE: Sledgehammer fails here, why? *)
	(* NOTE: In the presence of k_locs_of_arithIff and b_locs_of_as_set_interval, 
			     this leads to a LEMMA about subset of ranges *)
            find_theorems "{_ ..< _} \<subseteq> {_ ..< _}"
            thm b_locs_of_as_set_interval[of "the(f r) - s" "r + s"]
                b_locs_of_as_set_interval[of "the(f r)" "r"]
                ivl_subset[of "r + s" "r + s + the(f r) - s" "r" "the (f r)"]

(* Bridge: locations of updated value (r+s) within original locations (r) *)
lemma b_new1_gr_upd_psubset_req_size:
	"nat1 s \<Longrightarrow> r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1_map f \<Longrightarrow> 
		locs_of (r+s) (the (f r) - s) \<subset> locs_of r (the(f r))"
apply (rule psubsetI)
apply (simp add: b_new1_gr_upd_within_req_size)
apply (simp add: b_locs_of_as_set_interval inv_VDMNat1_def)
by (metis add_0_iff add_lessD1 add_less_cancel_left atLeastLessThan_inj(1) not_less0)

(* Weaken: Disjoint distributes through dom_ar and dagger *)
lemma k_Disjoint_dom_ar_dagger:
	"r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> Disjoint (({r} -\<triangleleft> f) \<dagger> [r + s \<mapsto> the (f r) - s])"
unfolding Disjoint_def disjoint_def
apply (intro impI ballI)+
apply (simp add: l_locs_of_Locs_of_iff l_dagger_apply)
apply (intro impI conjI)+
apply (simp_all add: l_dagger_dom)
prefer 3
apply (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
apply (simp_all add: f_in_dom_ar_the_subsume)
	apply (erule_tac x=r in ballE)
	apply (erule_tac x=b in ballE)
	apply (frule_tac [1-4] f_in_dom_ar_notelem)
	apply (frule_tac [1-4] f_in_dom_ar_subsume)
  apply (simp_all)
    thm b_new1_gr_upd_within_req_size[of r f s]
        f_nat1_map_nat1_elem[of f r]
        b_locs_of_as_set_interval[of "the(f r)"]
  (* too slow - apply (simp_all add: b_new1_gr_upd_within_req_size f_nat1_map_nat1_elem b_locs_of_as_set_interval) *)
  apply (simp_all add: inv_VDMNat1_def b_new1_gr_upd_within_req_size f_nat1_map_nat1_elem b_locs_of_as_set_interval)
	apply (metis add_lessD1)
done
	(* NOTE: The discovery of how to properly apply frules (and throughout all goals 1-4) saved repetition :-) *)

find_theorems "sep(_ -\<triangleleft> _)"
(* Weaken: Disjoint distributes through dom_ar and munion *)
lemma k_Disjoint_dom_ar_munion:
	"r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1 s \<Longrightarrow> nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> Disjoint (({r} -\<triangleleft> f) \<union>m [r + s \<mapsto> the (f r) - s])"
apply (frule l_disjoint_mapupd_keep_sep[of f r s])
apply (assumption)+
unfolding munion_def
apply (simp add: k_Disjoint_dom_ar_dagger)
by (metis f_in_dom_ar_subsume)

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ SEP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

(* TODO: REMOVE  These are just auxiliary lemmas used to expose the necessary condition
                  for the expansion of munion, which I didn't want to do in the middle
                  of the more complicated proof. They are trivial. Could do via subgoal_tac
 *)
lemma k_sep_dom_ar_dagger_aux2:
	"nat1 s \<Longrightarrow> {r} \<inter> dom [r + s \<mapsto> the (f r) - s] = {}"
apply (subst disjoint_iff_not_equal)
by (simp add: inv_VDMNat1_def)

(* Weaken: sep distributes through dom_ar and munion *)
lemma k_sep_dom_ar_dagger:
   "r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1 s \<Longrightarrow> nat1_map f \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> sep ({r} -\<triangleleft> f \<dagger> [r + s \<mapsto> the (f r) - s])"
apply (insert k_sep_dom_ar_dagger_aux2[of s r f])
apply (simp add: l_dagger_dom_ar_assoc)
apply (rule k_sep_dom_ar)
unfolding sep_def
apply (intro ballI)
apply (simp add: l_dagger_apply l_dagger_dom)
apply (intro impI conjI)
apply (simp_all)
find_theorems "_ \<noteq> _" elim
apply (erule neqE)
apply simp_all
apply (rule notI)
apply (erule_tac x=l in ballE)
apply (simp_all)
unfolding Disjoint_def disjoint_def 
(* Failed after 2014
by (smt l_locs_of_Locs_of_iff k_locs_of_arithIff nat1_def)
  -- k_locs_of_arithIff no longer work
*)
apply (simp add: l_locs_of_Locs_of_iff b_locs_of_as_set_interval f_nat1_map_nat1_elem)
  apply (erule ballE[where x=r], erule_tac x=l in ballE,simp_all add: inv_VDMNat1_def)
  using k_locs_of_arithIff nat1_map_def by auto

(* Weaken: sep distributes through dom_ar and munion *)
lemma k_sep_dom_ar_munion:
   "nat1_map f \<Longrightarrow> r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1 s \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> sep ({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s])"
unfolding munion_def
apply (simp add: k_sep_dom_ar_dagger)
by (metis l_disjoint_mapupd_keep_sep f_in_dom_ar_subsume nat1_def)

(* ADDED assumptions only and when needed (even if I knew a priori they would be needed, I waited to see how it would turn up for Isabelle's simp *)

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ NAT1_MAP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

(* Weaken: nat1_map distributes through dom_ar and dagger *)
lemma k_nat1_map_dom_ar_dagger:
   "nat1 s \<Longrightarrow> r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1_map f \<Longrightarrow> nat1_map ({r} -\<triangleleft> f \<dagger> [r + s \<mapsto> the (f r) - s])"
unfolding nat1_map_def
apply (intro allI impI)
apply (simp add: l_dagger_dom l_dagger_apply)
apply (intro conjI impI)+
apply (simp add: inv_VDMNat1_def)
by (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume)

(* Weaken: nat1_map distributes through dom_ar and munion *)
lemma k_nat1_map_dom_ar_munion:
   "nat1 s \<Longrightarrow> r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> Disjoint f \<Longrightarrow> nat1_map f \<Longrightarrow> nat1_map ({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s])"
unfolding munion_def
apply (simp add: k_nat1_map_dom_ar_dagger)
by (metis l_disjoint_mapupd_keep_sep f_in_dom_ar_subsume nat1_def)
	(* NOTE: The version with \<union>m requires more side conditions (i.e. Disjoint f here to allow for l_disjoint_mapupd_keep_sep). The strategy repeats across *)

(* ~~~~~~~~~~~~~~~~~~~~~~~~~~ FINITE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ *)

(* Weaken: finite distributes through dom_ar and dagger *)
lemma k_finite_dom_ar_dagger:
   "r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> finite (dom f) \<Longrightarrow> finite (dom({r} -\<triangleleft> f \<dagger> [r + s \<mapsto> the (f r) - s]))"
by (simp add: l_dagger_dom l_dagger_apply k_finite_dom_ar)

(* Weaken: finite distributes through dom_ar and munion *)
lemma k_finite_dom_ar_munion:
   "r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> nat1 s \<Longrightarrow> nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> finite (dom f) \<Longrightarrow> finite (dom({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s]))"
unfolding munion_def
apply (simp add: k_finite_dom_ar_dagger)
by (metis l_disjoint_mapupd_keep_sep f_in_dom_ar_subsume nat1_def)
	(* NOTE: The version with \<union>m requires more side conditions (i.e. Disjoint f here to allow for l_disjoint_mapupd_keep_sep). The strategy repeats across *)

lemma k_finite_dom_ar_munion_ALT_PROOF:
   "r+s \<notin> dom f \<Longrightarrow> r \<in> dom f \<Longrightarrow> the (f r) > s \<Longrightarrow> finite (dom f) \<Longrightarrow> finite (dom({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s]))"
   thm l_munion_dom[of "{r} -\<triangleleft>f" "[r + s \<mapsto> the(f r) - s]"]
apply (insert l_munion_dom[of "{r} -\<triangleleft>f" "[r + s \<mapsto> the(f r) - s]"])
apply (insert f_dom_ar_subset_dom[of "{r}" f])
apply (simp)
by (metis finite_Diff finite_insert l_dom_dom_ar f_in_dom_ar_subsume)
	(* NOTE: The version with \<union>m with the explicit assumption about r+s not in dom f *)

lemma k_F1_inv_dom_munion: 
   "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> r \<in> dom f \<Longrightarrow> the(f r) > s \<Longrightarrow> F1_inv({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s])"
by (metis F1_inv_def k_Disjoint_dom_ar_munion k_finite_dom_ar_munion k_nat1_map_dom_ar_munion k_sep_dom_ar_munion)

(*========================================================================*)
section \<open> Goal-oriented - DISPOSE1 invariant update \<close>
(*========================================================================*)

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> DISPOSE1 update - equal case \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

lemma l_min_loc_dom_r_iff: 
  "S \<triangleleft> g \<noteq> Map.empty \<Longrightarrow> min_loc (S \<triangleleft> g) = Min (S \<inter> dom g)"
by (metis min_loc_def l_dom_r_iff)

(*
lemmX nat1_sum_size:
  "finite (dom g) \<Longrightarrow> g \<noteq> empty \<Longrightarrow> nat1_map g \<Longrightarrow> nat1 (sum_size g)"
unfolding  nat1_set_def sum_size_def
apply simp
oops

find_theorems name:Finite_Set name:induc
thm  finite_ne_induct[of "dom g"]
apply (induct "dom g" rule: finite_ne_induct)
apply (metis Nat.add_0_right 
             empty_iff finite.emptyI 
             insertI1 setsum.empty setsum.insert)
by (metis Nat.add_0_right bot_least bot_less 
          bot_nat_def eq_iff finite_insert 
          insertI1 nat1_prop setsum.insert 
          setsum_mono3 subset_insertI)
*)

lemma k_Min_subset:
  "S \<noteq> {} \<Longrightarrow> finite T \<Longrightarrow> S \<subseteq> T \<Longrightarrow> Min S \<in> T"
by (metis Min_in finite_subset set_mp)

lemma k_min_loc_dom:
  "g \<noteq> Map.empty \<Longrightarrow> finite(dom g) \<Longrightarrow> dom g \<subseteq> dom f \<Longrightarrow> min_loc g \<in> dom f"
unfolding min_loc_def
by (metis Min_in dom_eq_empty_conv set_mp)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ FINITE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

lemma k_dispose_abovebelow_dom_disjoint:
  "nat1 s1 \<Longrightarrow> dom (dispose1_above f1 d1 s1) \<inter> dom(dispose1_below f1 d1) = {}"
find_theorems "_ \<inter> _ = {}" name:disjoint name:equal
apply (subst disjoint_iff_not_equal)
apply (rule ballI)+
unfolding dispose1_above_def dispose1_below_def
apply (simp only: l_dom_r_iff)
using [[simp_trace]] apply (simp add: inv_VDMNat1_def)
(* sep f1 ==>
apply (elim conjE)
apply (metis nat_neq_iff not_add_less1 sep_def)
*)
done

lemma f_d1_not_dispose_above :
  "nat1 s1 \<Longrightarrow> d1 \<notin> dom (dispose1_above f1 d1 s1)"
unfolding dispose1_above_def
find_theorems "dom(_ \<triangleleft> _)"
by (simp add: l_dom_r_iff inv_VDMNat1_def)

lemma f_d1_not_dispose_below:
  "nat1_map f1 \<Longrightarrow> nat1 s1 \<Longrightarrow> d1 \<notin> dom (dispose1_below f1 d1)"
unfolding dispose1_below_def
find_theorems "dom(_ \<triangleleft> _)"
apply (simp add: l_dom_r_iff)
apply (rule impI) 
(* NOTE: here either we assume the dispose1_pre fo a contradiction, or that nat1_map f1 is true for a proof *)
by (metis f_nat1_map_nat1_elem)

lemma f_d1_not_dispose_abovebelow_ext:
  "nat1_map f1 \<Longrightarrow> sep f1 \<Longrightarrow> nat1 s1 \<Longrightarrow> d1 \<notin> dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1)"
by (metis UnE f_d1_not_dispose_above f_d1_not_dispose_below k_dispose_abovebelow_dom_disjoint l_dagger_dom munion_def)

lemma k_dispose_abovebelow_munion_dom:
  "nat1 s1 \<Longrightarrow> dom(dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1) 
    = 
   { x \<in> dom f1 . x + the(f1 x) = d1 \<or> x = d1 + s1 }"
apply (rule equalityI)
apply (simp_all add: l_munion_dom k_dispose_abovebelow_dom_disjoint)
unfolding dispose1_above_def dispose1_below_def
apply (simp_all add: l_dom_r_iff)
apply (rule conjI)
apply (rule_tac [1-] subsetI)
by auto
(* NOTE: sledgehammer manages two of the three subgoals,
         yet its solution is rather lengthy and time
         consuming. This is possibly because of the set-theoretical
         nature of the goals, which are rather easy. 

        apply (smt Int_Collect_mono equalityE inf_commute le_inf_iff)
        apply (metis Collect_conj_eq Collect_disj_eq Collect_mem_eq inf.left_idem inf_commute inf_mono subset_refl sup_commute sup_ge2)
*)

lemma k_finite_dispose_above: 
  "finite(dom f1) \<Longrightarrow> finite (dom (dispose1_above f1 d1 s1))"
unfolding dispose1_above_def
by (metis finite_Int l_dom_r_iff)

lemma k_finite_dispose_below: 
  "finite(dom f1) \<Longrightarrow> finite (dom (dispose1_below f1 d1))"
unfolding dispose1_below_def
by (smt finite_Int l_dom_r_iff)

lemma k_finite_dispose_abovebelow_munion: 
  "finite (dom f1) \<Longrightarrow> nat1 s1 \<Longrightarrow> finite (dom (dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1))"
  thm k_finite_munion[of "dispose1_above f1 d1 s1" "dispose1_below f1 d1"]
by (metis k_dispose_abovebelow_dom_disjoint k_finite_dispose_above k_finite_dispose_below k_finite_munion)
  (* NOTE: This is a nice example of where/what lemmas to create. That is, all
           those that would weaken the simplification enough such that all side
           conditions could be chained towards true. k_finite_munion is just an example.    

           The LEMMA itself is in turn needed by the side conditions of by 
           k_min_loc_munion_singleton for the proof of z_F1_inv_dispose1_finite,
           the ultimate goal of interest.
   *)

lemma k_empty_dispose_above: 
  "d1 + s1 \<notin> dom f1 \<Longrightarrow> (dispose1_above f1 d1 s1) = Map.empty"
unfolding dispose1_above_def
by (smt disjoint_iff_not_equal l_dom_r_iff l_map_non_empty_dom_conv mem_Collect_eq)

lemma k_nonempty_dispose_below: 
  "x \<in> dom f1 \<Longrightarrow> x + the(f1 x) = d1 \<Longrightarrow> (dispose1_below f1 d1) \<noteq> Map.empty"
unfolding dispose1_below_def
by (smt dom_def f_in_dom_r_apply_elem mem_Collect_eq)
(* LF: this worked when using old version of f_in_dom_r_apply_elem
apply (smt Collect_conj_eq domIff f_in_dom_r_apply_elem mem_Collect_eq)
  thm f_in_dom_r_apply_elem[of x f1 "{x \<in> dom f1. x + the (f1 x) = d1}",simplified]
*)

lemma k_dispose1_abovebelow_nonempty:
  "nat1 s1 \<Longrightarrow> d1 + s1 \<in> dom f1 \<or> x \<in> dom f1 \<and> x + the(f1 x) = d1 \<Longrightarrow> 
    dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 \<noteq> Map.empty"
apply (erule disjE)
  (*apply (smt Collect_empty_eq dom_eq_empty_conv k_dispose_abovebelow_munion_dom)
       --> outside locale the sledgehammered proof above failed
   *)
  apply (rule notI)
  apply (simp only: dom_eq_empty_conv[symmetric] k_dispose_abovebelow_munion_dom)
  apply blast
by (metis domIff k_dispose_abovebelow_dom_disjoint k_nonempty_dispose_below l_munion_apply)

lemma k_dispose1_abovebelow_empty:
  "nat1 s1 \<Longrightarrow> sep0 [d1 \<mapsto> s1] f1 \<Longrightarrow> sep0 f1 [d1 \<mapsto> s1] \<Longrightarrow> 
    dispose1_above f1 d1 s1 \<union>m dispose1_below f1 d1 = Map.empty"
unfolding sep0_def
apply (simp only: dom_eq_empty_conv[symmetric] k_dispose_abovebelow_munion_dom)
apply simp
by blast

lemma k_dispose1_sep0_above_empty:
  "sep0 [d1 \<mapsto> s1] f1 \<Longrightarrow> dispose1_above f1 d1 s1 = Map.empty"
apply (simp only: dom_eq_empty_conv[symmetric])
unfolding sep0_def dispose1_above_def
find_theorems "dom(_ \<triangleleft> _)"
apply (simp add: dom_eq_empty_conv[symmetric] l_dom_r_iff)
by blast

lemma k_dispose1_sep0_below_empty:
  "sep0 f1 [d1 \<mapsto> s1] \<Longrightarrow> dispose1_below f1 d1 = Map.empty"
apply (simp only: dom_eq_empty_conv[symmetric])
unfolding sep0_def dispose1_below_def
apply (simp add: dom_eq_empty_conv[symmetric] l_dom_r_iff)
by blast

lemma l_dispose1_sep0_above_empty_iff:
  "(dispose1_above f1 d1 s1 = Map.empty) = sep0 [d1 \<mapsto> s1] f1"
apply (rule iffI)
defer
apply (rule k_dispose1_sep0_above_empty,assumption)
unfolding sep0_def dispose1_above_def
apply (rule ballI)
apply simp
apply (rule notI)
apply (simp add: fun_eq_iff)
apply (erule_tac x="d1+s1" in allE)
find_theorems "(_ \<triangleleft> _) _"
apply (simp add: f_in_dom_r_apply_elem)
by (metis domIff)

(* NOTE: This LEMMA is *CRUCIAL* to enable talking about some free variable l satisfying sep0; otherwise we don't have l\<in> dom f *)
lemma l_dispose1_sep0_below_empty_iff:
  "(dispose1_below f1 d1 = Map.empty) = sep0 f1 [d1 \<mapsto> s1]"
apply (rule iffI)
defer
apply (rule k_dispose1_sep0_below_empty,assumption)
unfolding sep0_def dispose1_below_def
apply (rule ballI)
apply simp
apply (rule notI)
apply (simp add: fun_eq_iff)
apply (erule_tac x="l" in allE)
find_theorems "(_ \<triangleleft> _) _"
apply (simp add: f_in_dom_r_apply_elem)
by (metis domIff)

lemma f_dispose1_pre_not_in_dom: 
  "nat1_map f \<Longrightarrow> nat1 s \<Longrightarrow> locs_of d s \<inter> locs f = {} \<Longrightarrow> d \<notin> dom f"
apply (rule notI)
find_theorems name:disjoint name:iff
find_theorems "_ \<in> locs_of _ _"
find_theorems "_ \<in> locs _"
apply (simp add: disjoint_iff_not_equal)
apply (frule f_dom_locs_of,assumption)
apply (frule f_in_dom_locs,assumption)
apply (erule_tac x=d in ballE)
apply (erule_tac x=d in ballE)
unfolding locs_of_def 
  by (simp_all add: inv_VDMNat1_def)

(*
lemmX f_dispose1_pre_not_in_dom_size: 
  "nat1_map f \<Longrightarrow> nat1 s \<Longrightarrow> locs_of d s \<inter> locs f = {} \<Longrightarrow> d+s \<notin> dom f"
apply (rule notI)
apply (simp add: disjoint_iff_not_equal)
apply (frule f_dom_locs_of,assumption)
apply (frule f_in_dom_locs,assumption)
apply (erule_tac x=d in ballE)
apply (erule_tac x=d in ballE)
unfolding locs_of_def
oops
*)

lemma l_dispose1_above_singleton:
  "d1+s1 \<in> dom f1 \<Longrightarrow> dispose1_above f1 d1 s1 = [d1+s1 \<mapsto> the(f1 (d1+s1))]"
unfolding dispose1_above_def
apply (subst fun_eq_iff)
apply (rule allI)
find_theorems "(_ \<triangleleft> _) _"
unfolding dom_restr_def
by auto

lemma l_dispose1_nonempty_above_singleton:
  "dispose1_above f1 d1 s1 \<noteq> Map.empty \<Longrightarrow> dispose1_above f1 d1 s1 = [d1+s1 \<mapsto> the(f1 (d1+s1))]"
by (metis k_empty_dispose_above l_dispose1_above_singleton)
(* NOTE: the same LEMMA is not as easy with below :-( because of free l *)

(* NOTE: Toy problem to try and identify the bloody useful way to declare the lemma!!! ARGHHH ! *)
lemma "a = x \<Longrightarrow> ([x \<mapsto> y] a) = Some y"
by simp

lemma "a \<noteq> x \<Longrightarrow> ([x \<mapsto> y] a) = None"
by simp

definition
    fbelow :: "F1"
where
    "fbelow \<equiv> [0\<mapsto>4, 5 \<mapsto> 6, 15 \<mapsto> 3]"

lemma "F1_inv fbelow"
unfolding fbelow_def F1_inv_defs inv_VDMNat1_def
by auto

lemma "dispose1_below fbelow 11 = [5\<mapsto>6]"
unfolding fbelow_def dispose1_below_def
apply (simp add: fun_eq_iff)
apply (intro conjI allI impI)
apply (simp add: f_in_dom_r_apply_elem)
unfolding dom_restr_def restrict_map_def
using [[simp_trace]] apply simp
apply auto
done

lemma "l \<in> dom fbelow \<Longrightarrow> l+the(fbelow l)=11 \<Longrightarrow> dispose1_below fbelow 11 = [l\<mapsto>the(fbelow l)]"
unfolding fbelow_def dispose1_below_def 
apply safe
apply (simp add: fun_eq_iff)
  apply (intro conjI allI impI)
find_theorems name:split name:"if" name:asm
apply (simp_all split: if_split_asm)
unfolding dom_restr_def restrict_map_def
apply simp
apply auto
done

lemma l_dispose1_below_singleton_useless:
  "l \<in> dom f \<Longrightarrow>  l+the(f l) = d \<Longrightarrow> nat1_map f \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> dispose1_below f d = [l \<mapsto> the(f l)]"
unfolding dispose1_below_def 
find_theorems simp:"_ = (_::('a \<Rightarrow> 'b))" -name:HEAP -name:VDM
apply (subst fun_eq_iff)
apply simp
apply (intro allI impI conjI)
apply (simp add: f_in_dom_r_apply_the_elem)
unfolding dom_restr_def restrict_map_def
apply (simp_all)
apply (rule impI)
apply (erule conjE)
unfolding Disjoint_def disjoint_def
apply (erule_tac x=l in ballE)
apply (erule_tac x=x in ballE)
find_theorems "locs_of _ _ \<inter> locs_of _ _"
apply (simp_all add: l_locs_of_Locs_of_iff 
                        k_locs_of_arithIff f_nat1_map_nat1_elem inv_VDMNat1_def)
by (metis antisym le_iff_add sep_def)

lemma l_dispose1_below_singleton_useful:
  "nat1_map f \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> \<forall> l \<in> dom f .  l+the(f l) = d \<longrightarrow> dispose1_below f d = [l \<mapsto> the(f l)]"
by (metis l_dispose1_below_singleton_useless)

(*

lemmX "nat1_map f \<Longrightarrow> nat1 s \<Longrightarrow> dispose1_pre f d s \<Longrightarrow> l \<in> dom f \<Longrightarrow>  l+the(f l) = d \<Longrightarrow> (\<forall> k \<in> dom f-{l} . k+the(f k) \<noteq> d)"
unfolding dispose1_pre_def disjoint_def
find_theorems "locs_of _ _ \<inter> locs _ = {}"
apply (rule ballI)
apply (simp add: k_inter_locs_iff)
apply (erule conjE)
apply (erule_tac x=k in ballE)
apply (simp_all add: disjoint_iff_not_equal)
apply (erule_tac x=d in ballE)
apply (erule_tac x=k in ballE)
apply (simp_all)
oops

apply (erule disjE)
unfolding sep_def
apply (frule_tac x=l in ballE)
apply (erule_tac x=x in ballE)
apply (simp_all)

lemmX l_dispose1_below_singleton:
  "l \<in> dom f \<Longrightarrow>  l+the(f l) = d \<Longrightarrow> (\<forall> k \<in> dom f - {l} . k+the(f k) \<noteq> d) \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> dispose1_below f d = [l \<mapsto> the(f l)]"
"apply (cases "(\<forall> k \<in> dom f - {l} . k+the(f k) \<noteq> d)")
apply (erule_tac x=x in ballE)
"


lemmX l_dispose1_below_singleton:
  "l \<in> dom f \<Longrightarrow>  l+the(f l) = d \<Longrightarrow> 
      (\<forall> k \<in> dom f - {l} . k+the(f k) \<noteq> d) \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> dispose1_below f d = [l \<mapsto> the(f l)]"
unfolding dispose1_below_def 
find_theorems simp:"_ = (_::('a \<Rightarrow> 'b))" -name:HEAP -name:VDM
apply (subst fun_eq_iff)
apply simp
apply (intro allI impI conjI)
apply (simp add: f_in_dom_r_apply_the_elem)
apply (erule_tac x=x in ballE)
unfolding dom_restr_def restrict_map_def
by (simp_all)


lemmX l_dispose1_below_singleton:
  "l \<in> dom f \<Longrightarrow> l+the(f l) = d \<Longrightarrow> \<exists>! x \<in> dom f . x+the(f x) = d \<longrightarrow> dispose1_below f d = [x \<mapsto> the(f x)]"
unfolding dispose1_below_def
apply (subst fun_eq_iff)
apply (rule ex_ex1I)
apply (rule_tac x=l in exI)
apply (simp)
apply (intro allI impI conjI)
apply (simp add: f_in_dom_r_apply_elem)
apply simp_all
apply (cases "{x \<in> dom f. x + the (f x) = d} = {}")
apply auto
unfolding ran_def
apply auto
apply (rule allI)
find_theorems "(_ \<triangleleft> _) _"
thm f_in_dom_r_apply_elem[of _ "{l\<in> dom f1 . l+the(f1 l)=d1}" f1]
apply (subst f_in_dom_r_apply_elem)
apply simp_all
apply auto
apply simp
apply (intro conjI impI)
pr
apply (cases "x \<in> {l\<in> dom f1 . l+the(f1 l)=d1}")
apply (simp_all)
unfolding dom_restr_def
apply auto
oops
*)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ NAT1_MAP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

lemma l_sum_size_upd: 
  "finite(dom f) \<Longrightarrow> x \<notin> dom f \<Longrightarrow> sum_size(f(x\<mapsto>y)) = (if f = Map.empty then y else sum_size f + y)"
unfolding sum_size_def
apply simp
apply (intro impI)
by (rule sum.cong,simp_all,rule impI,simp)
thm sum.cong[of "dom f" "dom f" "(\<lambda> xa . the (if xa = x then Some y else f xa))" "(\<lambda> x .  the (f x))"]

lemma l_nat1_sum_size_dispose1_ext: 
    "nat1_map f1 \<Longrightarrow> finite (dom f1) \<Longrightarrow> sep f1 \<Longrightarrow> nat1 s1 \<Longrightarrow> nat1 (sum_size (dispose1_ext f1 d1 s1))"
unfolding dispose1_ext_def
apply (subst l_munion_upd)
apply (simp add: l_munion_dom k_dispose_abovebelow_dom_disjoint)
apply (rule conjI)
apply (rule f_d1_not_dispose_above,simp)
apply (rule f_d1_not_dispose_below,simp_all)
apply (frule f_d1_not_dispose_abovebelow_ext[of f1 s1 d1],simp_all)
apply (frule k_finite_dispose_abovebelow_munion[of f1 s1 d1],simp)
by (simp add: l_sum_size_upd inv_VDMNat1_def)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ SEP ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

lemma l_d1_s1_not_dispose1_below: 
    "nat1_map f \<Longrightarrow> sep f \<Longrightarrow> Disjoint f \<Longrightarrow> nat1 s \<Longrightarrow> d + s \<notin> dom (dispose1_below f d)"
apply (cases "dispose1_below f d = Map.empty")
apply simp
apply (simp add: l_dispose1_sep0_below_empty_iff[of f d s])
unfolding sep0_def
apply (simp,erule bexE)
thm l_dispose1_below_singleton_useful
by (simp add: l_dispose1_below_singleton_useful inv_VDMNat1_def)

(* NOTE: This proof is rather protracted. Various simp rules didn't apply and we needed tedious 
         repetition of side conditions for munion to discharge.
 *)
lemma l_min_loc_dispose1_ext_absorb_above:
      "finite(dom f) \<Longrightarrow> nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> sep f \<Longrightarrow> nat1 s \<Longrightarrow> 
        min_loc (dispose1_ext f d s) = min_loc(dispose1_below f d \<union>m [d \<mapsto> s])"
unfolding dispose1_ext_def
apply (cases "dispose1_above f d s = Map.empty")
apply (simp add: l_munion_empty_lhs)
apply (simp add: l_dispose1_nonempty_above_singleton)
thm l_munion_commute[of "[d + s \<mapsto> the (f (d + s))]" "dispose1_below f d \<union>m [d \<mapsto> s]"]
apply (subst l_munion_commute)
  apply (metis (full_types) k_dispose_abovebelow_dom_disjoint l_dispose1_nonempty_above_singleton nat1_def)
  (*apply (metis k_dispose_abovebelow_dom_disjoint l_dispose1_nonempty_above_singleton)*)
apply (subst l_munion_assoc)
  apply (metis (full_types) inf.commute k_dispose_abovebelow_dom_disjoint l_dispose1_nonempty_above_singleton nat1_def)
  (*apply (metis inf_sup_aci(1) k_dispose_abovebelow_dom_disjoint l_dispose1_nonempty_above_singleton)*)
  apply (simp add: disjoint_iff_not_equal inv_VDMNat1_def)
   (* TOO SLOW
   apply (metis (full_types) Collect_conj_eq Collect_conv_if add_diff_cancel_right' comm_monoid_diff_class.diff_cancel dom_empty dom_fun_upd gr_implies_not0 nat_add_commute option.distinct(1) singleton_conv)
   *)
apply (subst l_munion_commute)
back
  apply (simp add: disjoint_iff_not_equal inv_VDMNat1_def)
  apply (subst l_munion_assoc[symmetric])
  apply (frule f_d1_not_dispose_below,simp_all add: inv_VDMNat1_def)
    (* TOO SLOW
    apply (metis Collect_conj_eq Collect_conv_if2 dom_def dom_empty dom_fun_upd f_d1_not_dispose_below inf_commute mem_Collect_eq nat1_def option.distinct(1) singleton_conv2)
    *)
find_theorems "min_loc (_ \<union>m _)"
thm k_min_loc_munion_singleton[of "dispose1_below f d \<union>m [d \<mapsto> s]" "d + s" "the (f (d + s))"]
apply (subst k_min_loc_munion_singleton)
  apply (rule k_finite_munion, simp_all)
   apply (metis k_finite_dispose_below)
  apply (simp add: f_d1_not_dispose_below inv_VDMNat1_def)
  apply (subst l_munion_dom)
    apply (frule f_d1_not_dispose_below,simp_all add: l_d1_s1_not_dispose1_below inv_VDMNat1_def)
apply (intro conjI impI)
apply (simp add: l_munion_singleton_not_empty f_d1_not_dispose_below inv_VDMNat1_def)
apply (cases "dispose1_below f d = Map.empty")
apply (simp add: l_munion_empty_lhs l_min_loc_singleton)
apply (simp add: l_dispose1_sep0_below_empty_iff[of f d s])
unfolding sep0_def
apply simp
apply (erule bexE)
apply (simp add: l_dispose1_below_singleton_useless) \<comment> \<open>so the useless version works?! hum... \<close>
apply (subst k_min_loc_munion_singleton)
  apply (metis finite_singleton)
  apply (frule f_nat1_map_nat1_elem,simp_all)
  apply (metis sep_def)
apply (subst l_munion_dom)
  apply (frule f_nat1_map_nat1_elem,simp_all)
  apply (metis sep_def)
done

lemma l_sep0_dispose1_abovebelow_ext:
 "finite(dom f1) \<Longrightarrow> nat1_map f1 \<Longrightarrow> Disjoint f1 \<Longrightarrow> sep f1 \<Longrightarrow> nat1 s1 \<Longrightarrow> 
  sep0 ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1)
     [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]"
unfolding sep0_def
apply (rule ballI)
apply (simp add: l_min_loc_dispose1_ext_absorb_above)
find_theorems "_ \<in> dom( _ -\<triangleleft> _)"
apply (simp add: f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
apply (cases "dispose1_below f1 d1 = Map.empty")
apply (simp add: l_min_loc_singleton l_munion_empty_lhs)
apply (metis k_nonempty_dispose_below l_dom_ar_not_in_dom)
  (* NOTE: Here is a repeated strategy: when dispose1_below isn't Map.empty, we need to go through sep0 negated
           to get the right withness for the l_dispose1_below_singleton_useful lemma
   *)
    apply (simp add: l_dispose1_sep0_below_empty_iff[of f1 d1 s1])
    unfolding sep0_def
    apply simp
    apply (erule bexE)
    apply (simp add: l_dispose1_below_singleton_useless) \<comment> \<open>so the useless version works?! hum... \<close>
    apply (subst k_min_loc_munion_singleton,simp_all)
      apply (metis sep_def)
      apply (metis l_dom_ar_notin_dom_or le_add1 min.absorb_iff1 sep_def)
done

lemma l_sep0_dispose1_ext_abovebelow:
   "finite(dom f1) \<Longrightarrow> nat1_map f1 \<Longrightarrow> Disjoint f1 \<Longrightarrow> sep f1 \<Longrightarrow> nat1 s1 \<Longrightarrow> 
    sep0 [min_loc (dispose1_ext f1 d1 s1) \<mapsto> HEAP1.sum_size (dispose1_ext f1 d1 s1)]
     ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1)"
unfolding sep0_def
apply (rule ballI)
apply (simp add: l_min_loc_dispose1_ext_absorb_above)
find_theorems simp:"_ \<in> dom( _ -\<triangleleft> _)"
apply (subst l_dom_ar_not_in_dom,simp_all)
unfolding dispose1_ext_def
apply (subst l_sum_size_munion_singleton) 
  apply (metis k_finite_dispose_abovebelow_munion nat1_def)
  apply (simp add: k_dispose_abovebelow_dom_disjoint f_d1_not_dispose_abovebelow_ext)
apply (cases "dispose1_below f1 d1 = Map.empty")
apply (simp add: l_min_loc_singleton l_munion_empty_rhs l_munion_empty_lhs)
  apply (intro conjI impI)
  apply (simp add: l_dispose1_sep0_above_empty_iff) 
  apply (metis k_dispose1_abovebelow_empty k_dispose1_abovebelow_nonempty l_dispose1_sep0_below_empty_iff nat1_def)
  apply (simp add: l_dispose1_nonempty_above_singleton l_sum_size_singleton)
  apply (simp add: l_dispose1_sep0_above_empty_iff) 
  unfolding sep0_def sep_def 
  apply simp
  apply (rule notI)
  apply (erule_tac x="d1+s1" in ballE,simp_all)
  apply (simp add: add.assoc add.commute)
  apply (fold sep_def)
apply (cases "dispose1_above f1 d1 s1 = Map.empty")
apply (simp add: l_min_loc_singleton l_munion_empty_rhs l_munion_empty_lhs)
apply (simp add: l_dispose1_sep0_above_empty_iff
                 l_dispose1_sep0_below_empty_iff[of f1 d1 s1])
  unfolding sep0_def
  apply simp
  apply (erule bexE)
    thm l_dispose1_below_singleton_useful
        k_min_loc_munion_singleton[simplified]
  apply (simp add: l_dispose1_below_singleton_useful 
                   l_sum_size_singleton)
  apply (subst k_min_loc_munion_singleton)
    apply (metis finite_singleton)
    apply (frule f_nat1_map_nat1_elem,simp)
      apply (simp add: disjoint_iff_not_equal)
    apply (frule f_nat1_map_nat1_elem,simp)
    unfolding min_def 
    apply (simp)
    unfolding sep_def 
    apply (rule notI)
    apply (erule_tac x="la" in ballE,simp_all)
    apply (metis add.assoc)
    apply (fold sep_def)
apply (simp add: l_munion_empty_iff k_dispose_abovebelow_dom_disjoint)
  apply (simp add: l_dispose1_nonempty_above_singleton l_sum_size_singleton)
  apply (simp add: l_dispose1_sep0_above_empty_iff
                   l_dispose1_sep0_below_empty_iff[of f1 d1 s1]) 
  unfolding sep0_def
  apply simp
  apply (erule bexE)
  thm k_min_loc_munion_singleton[simplified]
  apply (frule f_nat1_map_nat1_elem,simp)
    back
  apply (simp add: l_dispose1_below_singleton_useful 
                   l_sum_size_munion_singleton l_sum_size_singleton
                   k_min_loc_munion_singleton)
  unfolding min_def sep_def
  apply simp
  apply (rule notI)
  apply (erule_tac x="d1+s1" in ballE,simp_all)
by (metis add.commute add.left_commute)

(*~~~~~~~~~~~~~~~~~~~~~~~~~~ DISJOINT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)

lemma l_disjoint_dispose1_ext:
    "finite(dom f1) \<Longrightarrow> nat1_map f1 \<Longrightarrow> Disjoint f1 \<Longrightarrow> sep f1 \<Longrightarrow> nat1 s1 \<Longrightarrow> dispose1_pre f1 d1 s1 \<Longrightarrow> 
      disjoint (locs_of (min_loc (dispose1_ext f1 d1 s1)) (HEAP1.sum_size (dispose1_ext f1 d1 s1)))
        (locs ((dom (dispose1_below f1 d1) \<union> dom (dispose1_above f1 d1 s1)) -\<triangleleft> f1))"
apply (simp add: l_min_loc_dispose1_ext_absorb_above)
find_theorems simp:"(_ -\<triangleleft> _)"
thm l_locs_dom_ar_iff l_dom_ar_accum
apply (simp add: l_dom_ar_accum[symmetric])
unfolding disjoint_def dispose1_ext_def dispose1_pre_def
apply (cases "dispose1_below f1 d1 = Map.empty")
apply (simp add: l_munion_empty_lhs l_min_loc_singleton l_munion_empty_rhs l_dom_ar_none)
  apply (cases "dispose1_above f1 d1 s1 = Map.empty")
    apply (simp add: l_munion_empty_lhs l_sum_size_singleton l_dom_ar_none)
  apply (simp add: l_dispose1_nonempty_above_singleton l_dispose1_sep0_above_empty_iff
                   l_sum_size_munion l_sum_size_singleton) 
  (* HERE IS WHERE Cliff's "that lemma" comes from? *)
  unfolding sep0_def 
  apply (simp add: l_locs_dom_ar_iff)
  apply (simp add: disjoint_iff_not_equal)
  apply (rule ballI)+
  apply (frule f_nat1_map_nat1_elem,simp)
  unfolding locs_of_def
  apply simp
apply auto[1]
(*
  apply smt (* NOTE: 
               I should have had more lemmas about disjoint/locs_of under set theory.
               Given that, I wouldn't need to unfold definitions down to logic. This
               promoted the discussion to the rippling + CliffWhyM view of this.
             *)
*)
  apply (fold locs_of_def)
  apply (cases "dispose1_above f1 d1 s1 = Map.empty")
    apply (simp add: l_munion_empty_lhs l_sum_size_singleton l_dom_ar_none inv_VDMNat1_def)
    apply (simp add: l_dispose1_sep0_below_empty_iff[of f1 d1 s1] inv_VDMNat1_def)
    unfolding sep0_def
      apply (simp add: inv_VDMNat1_def)
      apply (simp add: domIff l_dispose1_above_singleton)
    using inv_VDMNat1_def l_sum_size_munion_singleton l_sum_size_singleton apply auto[1]
        thm l_sum_size_munion_singleton[simplified] l_sum_size_singleton
                     k_min_loc_munion_singleton[simplified]
                     l_dispose1_nonempty_above_singleton
        apply (subst k_min_loc_munion_singleton)
        using k_finite_dispose_below apply presburger
         apply (simp add: f_d1_not_dispose_below)
      apply (simp add: disjoint_iff_not_equal)
        apply (subst l_sum_size_munion_singleton)
        using k_finite_dispose_abovebelow_munion nat1_def apply presburger
         apply (simp add: disjoint_iff_not_equal)
        apply (metis f_d1_not_dispose_abovebelow_ext nat1_def)
    apply (simp add: l_sum_size_singleton l_locs_dom_ar_iff)
    apply (intro impI conjI ballI)
         apply (frule f_nat1_map_nat1_elem)
        apply (simp add: inv_VDMNat1_def)
    unfolding locs_of_def
      apply simp
      apply (metis domIff inv_VDMNat1_def k_dispose_abovebelow_dom_disjoint l_munion_apply less_imp_of_nat_less nat1_def of_nat_eq_0_iff)
    apply (metis (no_types) domIff k_dispose_abovebelow_dom_disjoint l_munion_apply nat1_def)
   apply (fold locs_of_def)
    
  apply (simp add: l_dispose1_nonempty_above_singleton l_dispose1_sep0_above_empty_iff
                   l_dispose1_sep0_below_empty_iff[of f1 d1 s1]
                   l_sum_size_munion l_sum_size_singleton inv_VDMNat1_def)
  unfolding sep0_def
  apply simp
  apply (erule bexE)
  
  thm l_dispose1_below_singleton_useful
  apply (simp add: l_dispose1_below_singleton_useful)
  apply (insert k_min_loc_munion_singleton[of f1])
  apply (subst k_min_loc_munion_singleton)
    apply (metis finite_singleton)
    apply (simp add: disjoint_iff_not_equal)
    apply (metis sep_def)
    apply (simp add: min_def)
  apply (subst l_sum_size_munion_singleton)
    apply (metis (lifting) k_finite_dispose_abovebelow_munion l_dispose1_above_singleton l_dispose1_below_singleton_useless nat1_def)

    apply (simp add: disjoint_iff_not_equal)
    apply (rule ballI)+
    apply (simp add: l_munion_dom)
    apply (metis sep_def)

  apply (simp add: l_munion_empty_iff)
  apply (subst l_sum_size_munion_singleton)
    apply (metis finite_singleton)
    apply (simp add: disjoint_iff_not_equal)
    apply (simp add: l_sum_size_singleton l_dom_ar_accum l_locs_dom_ar_general_iff)

    -- "Perhaps use l_right_diff_left_dist? Nah... just follow previous strategy"
    apply (simp add: disjoint_iff_not_equal)
    apply (rule ballI)+
    apply (frule f_nat1_map_nat1_elem,simp)
    apply (frule f_nat1_map_nat1_elem)
    apply simp back
    unfolding locs_of_def
    apply simp
by (metis add.commute add.left_commute leI)

find_theorems "_ \<in> locs _"

(* ========== *)

lemma l_locs_maximal_quickspec:
  "(locs f) -\<triangleleft> f = (locs g) -\<triangleleft> g"
oops

(* subsumes previous *)
lemma l_locs_maximal_quickspec:
  "(locs f) -\<triangleleft> f = Map.empty"
oops

lemma l_locs_empty_quickspec:
  "(locs Map.empty = {})"
oops
 
find_theorems "locs Map.empty"

find_theorems "locs (_ -\<triangleleft> _)"

end