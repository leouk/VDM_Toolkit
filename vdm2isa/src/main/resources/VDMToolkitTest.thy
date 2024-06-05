theory VDMToolkitTest
imports VDMToolkit
begin

text \<open> VDM maps auxiliary functions \<close>

(* dom exists already *)
thm dom_def
find_theorems "dom _"

subsection \<open> Map translations: enumeration, comprehension \<close>

(* map values are given as *)
value "[ (0::nat) \<mapsto> (7::nat), 1  \<mapsto> 5 ]"
value "[ (0::int) \<mapsto> (1::int), 1  \<mapsto> 5 ] 0"
value "the ([ (0::int) \<mapsto> (1::int), 1  \<mapsto> 5 ] 0)"

value "the (Some b)"
value "Map.empty(A \<mapsto> 0)"
value "Map.empty(A := Some 0)"
value "[A \<mapsto> 0]"
value "[A \<mapsto> 0, B \<mapsto> 1]"

(*
value "the None"
value "Map.empty"
value "the ([ (1::int) \<mapsto> (1::int), 2  \<mapsto> 1, 3 \<mapsto> 2 ] (4::int)) + (3::int)"
value "the ([ (0::nat) \<mapsto> (0::nat), 1  \<mapsto> 5 ] (4::nat))"
*)
lemma "the ([ (1::int) \<mapsto> (1::int), 2  \<mapsto> 1, 3 \<mapsto> 2 ] (4::int)) + (3::int) = A" apply simp oops
lemma "the ([ (1::int) \<mapsto> (1::int), 2  \<mapsto> 1, 3 \<mapsto> 2 ] 2) + 3 = 4" by simp

find_theorems "the _"

text \<open> Not always it's possible to see their values as  
   maps encodings are more complex. You could use
   Isabelle prover as a debugger
 \<close>

lemma "dom [ A \<mapsto> 0, B \<mapsto> 1] = LOOK_HERE" apply simp oops

value "Map.empty(A \<mapsto> 0)"
value "Map.empty(A := Some 0)"
value "[A \<mapsto> 0]"
value "[A \<mapsto> 0, B \<mapsto> 1]"
  
lemma "dom [ A \<mapsto> 0, B \<mapsto> 1] = LOOK_HERE" apply simp oops
lemma "ran [ A \<mapsto> (0::nat), B \<mapsto> 1] = {0,1}" apply simp oops

(* rng also exists as ran *)
thm ran_def
find_theorems "ran _"

lemma "ran [ A \<mapsto> (0::nat), B \<mapsto> 1] = {0,1}" apply simp oops

subsection \<open>Map comprehension examples, pitfalls and proof scenarios\<close>

(*On the explicit (narrower/declared) type, add inv_VDMNat1 
  v98: map nat to nat1 = { d \<mapsto> r | d in set {1,2,3}, r in set {2,4,6} & r = d*2 } *)
definition
  ex1 :: "VDMNat \<rightharpoonup> VDMNat1"
  where
  "ex1 \<equiv> mapCompSetBound {1,2,3::VDMNat} {2,4,6::VDMNat} inv_VDMNat inv_VDMNat1 domid rngid (\<lambda> d r . r = d*2)"

lemmas ex1_defs = ex1_def mapCompSetBound_defs inv_VDMNat1_def inv_VDMNat_def 

lemma ex1_none: "x \<notin> dom ex1  \<Longrightarrow> ex1 x = None"
  by (simp add: domIff)

lemma ex1_dom: "dom ex1 = {1,2,3}"
  unfolding dom_def ex1_defs
  by (simp split:if_splits, safe)

lemma ex1_rng:"rng ex1 = {2,4,6}"
  unfolding rng_defs ex1_defs
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all)
  (* apply (elim exE conjE impE)*) (* this will be fiddly! *)
  apply (elim exE conjE disjE, simp_all)
     apply (fastforce, fastforce, fastforce)
  by (smt (z3) semiring_norm(83) the_equality verit_eq_simplify(14) zero_le_numeral)

(*@TODO add invariant failure to undefined tests! *)


lemma ex1_map: "x \<in> dom ex1 \<Longrightarrow> ex1 x = Some (2*x)"
  unfolding ex1_defs
  apply (simp split:if_splits, safe, force+) 
  thm option.discI
  by (metis option.discI)

(*On the implicit (wider/presumed) type, add inv_VDMNat; these funny binds are tricky!
  v98 = { x+y |-> 10 | x in set {1,2,3}, y in set {4,5,6} } *)
definition
  ex2 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "ex2 \<equiv> mapCompSetBound {1,2,3::VDMNat} {4,5,6::VDMNat} inv_VDMNat inv_VDMNat (\<lambda> x . (\<lambda> y . x+y)) (rngcnst 10) truecnst"

lemmas ex2_defs = ex2_def mapCompSetBound_defs inv_VDMNat_def 

lemma ex2_none: "x \<notin> dom ex2  \<Longrightarrow> ex2 x = None"
  by (simp add: domIff)

lemma ex2_dom: "dom ex2 = {5,6,7,8,9}"
  unfolding ex2_defs
  apply (simp split:if_splits)
  oops

definition
  ex2' :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "ex2' \<equiv> mapCompSetBound { x + y | x y . x \<in> {1,2,3::VDMNat} \<and> y \<in> {4,5,6::VDMNat} } {10::VDMNat} 
                inv_VDMNat inv_VDMNat domid (rngcnst 10) truecnst"

lemmas ex2'_defs = ex2'_def mapCompSetBound_defs inv_VDMNat_def truecnst_def domid_def 

lemma ex2'_none: "x \<notin> dom ex2'  \<Longrightarrow> ex2' x = None"
  unfolding ex2'_defs
  by (simp add: domIff)

lemma ex2'_dom: "dom ex2' = {5,6,7,8,9}"
  unfolding ex2'_defs
  apply (simp split:if_splits, safe) oops

lemma ex2'_dom_finite: "finite { x + y | x y . x \<in> {1,2,3::VDMNat} \<and> y \<in> {4,5,6::VDMNat} }"
  by (simp add: finite_image_set2) 

lemma ex2'_dom_clearer: "{ x + y | x y . x \<in> {1,2,3::VDMNat} \<and> y \<in> {4,5,6::VDMNat} } = {5..9::VDMNat}"
  apply (safe, simp_all) 
  by presburger

lemma ex2'_dom_inv: "inv_SetElems ((\<le>) (0::VDMNat)) {5..(9::VDMNat)}" 
  unfolding inv_SetElems_def 
  by (safe,simp)

lemma ex2'_dom_inv': "inv_SetElems inv_VDMNat {5..9}" 
  unfolding inv_SetElems_def inv_VDMNat_def
  by (safe,simp)

lemma ex2'_dom: "dom ex2' = {5,6,7,8,9}"
  unfolding ex2'_def mapCompSetBound_def inv_VDMSet'_def inv_VDMSet_def truecnst_def
  apply (simp only: ex2'_dom_finite ex2'_dom_clearer, simp split:if_splits add: ex2'_dom_inv' inv_VDMNat_def)
  unfolding domid_def rngcnst_def inv_True_def inv_VDMNat_def
  apply (safe, simp_all) 
  thm option.distinct
  by (smt (z3) option.distinct(1))
   
lemma ex2'_rng:"rng ex2' = {10}"
  unfolding rng_defs ex2'_def mapCompSetBound_def inv_VDMSet'_def inv_VDMSet_def truecnst_def
  apply (simp only: ex2'_dom_finite ex2'_dom_clearer, simp split:if_splits add: ex2'_dom_inv' inv_VDMNat_def)
  by (safe, simp_all, force+)
  
lemma ex2'_map: "x \<in> dom ex2' \<Longrightarrow> ex2' x = Some 10"
  unfolding ex2'_defs (* don't expand inv_VDMNat *)
  apply (simp split:if_splits)
  (* complex domain patterns lead to loads of cases Jeez! no safe *)
  apply (intro conjI impI, force) oops

lemma ex2'_map: "x \<in> dom ex2' \<Longrightarrow> ex2' x = Some 10"
  unfolding ex2'_def mapCompSetBound_def domid_def rngcnst_def truecnst_def inv_True_def 
  apply (simp split:if_splits)
  (* complex domain patterns lead to loads of cases Jeez! no safe *)
  apply (intro conjI impI) 
  find_theorems intro name:the
     apply (rule the_equality, simp add: inv_VDMNat_def, blast)
  apply (simp add: inv_VDMSet'_def inv_VDMSet_def inv_VDMNat_def) (* clearly true by contradiction, but finite is struggling *)
  oops

lemma l_finite_setcomp_finite[simp]: "finite S \<Longrightarrow> finite T \<Longrightarrow> finite { P x y | x y . x \<in> S \<and> y \<in> T }"
  by (simp add: finite_image_set2)

thm finite_image_set2 finite_subset
lemma ex2'_map: "x \<in> dom ex2' \<Longrightarrow> ex2' x = Some 10"
  unfolding ex2'_defs
  apply (insert l_finite_setcomp_finite[of _ _ "\<lambda> x y . x+y"]) (* lemma above not quite in right shape *)
  oops

lemma ex2'_map: "x \<in> dom ex2' \<Longrightarrow> ex2' x = Some 10"
  unfolding ex2'_def mapCompSetBound_def domid_def rngcnst_def truecnst_def inv_True_def 
  apply (simp split:if_splits)
  apply (intro conjI impI) 
     apply (rule the_equality, simp add: inv_VDMNat_def, blast)
  (*apply (smt (z3) Collect_cong atLeastAtMost_iff ex2'_dom_clearer ex2'_dom_finite mem_Collect_eq) *)(* horrible! *)
  apply (elim impE)
     apply (simp add: inv_VDMSet'_def inv_VDMSet_def inv_VDMNat_def inv_SetElems_def) 
  apply (rule conjI) 
  using ex2'_dom_finite apply force
     apply fastforce 
  oops

lemma l_invVDMSet_finite[simp]: "finite S \<Longrightarrow> inv_SetElems inv_T S \<Longrightarrow> inv_VDMSet' inv_T S"
  by (simp add: inv_VDMSet'_def)

lemma ex2'_map: "x \<in> dom ex2' \<Longrightarrow> ex2' x = Some 10"
  unfolding ex2'_def mapCompSetBound_def domid_def rngcnst_def truecnst_def inv_True_def 
  apply (simp split:if_splits)
  apply (intro conjI impI, simp)
     apply (rule the_equality, simp add: inv_VDMNat_def, blast)
    apply (erule impE)
  using ex2'_dom_clearer ex2'_dom_inv' apply auto[1]
  using inv_VDMNat_def apply auto[1]
   apply (smt (verit, del_insts) atLeastAtMost_iff ex2'_dom_clearer l_map_dom_ran)
(*  by (smt (z3) Collect_cong atLeastAtMost_iff ex2'_dom_clearer ex2'_dom_finite finite.emptyI finite.insertI inv_SetElems_def inv_VDMNat_def l_invVDMSet_finite mem_Collect_eq singletonD) *)
  apply (erule impE)
  using ex2'_dom_clearer ex2'_dom_inv' apply force
  by (simp add: inv_VDMNat_def)
  
(* more direct binds even if with range expressions it's fine. UNIV isn't finite! DUH 
   = { x |-> x+5 | x in set {1,2,3,4} & x > 2 } *)
definition
  ex3 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "ex3 \<equiv> mapCompSetBound {1,2,3,4::VDMNat} UNIV inv_VDMNat inv_VDMNat domid (\<lambda> x . (\<lambda> y . x + 5)) (\<lambda> x . (\<lambda> y . x > 2))"

lemmas ex3_defs = ex3_def mapCompSetBound_defs inv_VDMNat_def 

lemma ex3_none: "x \<notin> dom ex3  \<Longrightarrow> ex3 x = None"
  by (simp add: domIff)

lemma ex3_dom: "dom ex3 = {5,6,7,8,9}"
  unfolding ex3_defs
  apply (simp split:if_splits, safe)
  (* Nice example of how it goes "wrong" with undefined! *)
  oops

lemma ex3_dom: "dom ex3 = {1,2,3,4}"
  unfolding ex3_defs
  apply (simp split:if_splits, safe) oops
  (* Nice example of how it goes "wrong" with undefined! *)

lemma ex3_dom: "dom ex3 = {3,4}"
  unfolding ex3_defs
  apply (simp split:if_splits, safe) oops
  (* Nice example of how it goes "wrong" with undefined! *)

(* more direct binds even if with range expressions it's fine. 
   = { x |-> x+5 | x in set {1,2,3,4} & x > 2 } *)
definition
  ex3' :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "ex3' \<equiv> mapCompSetBound {1,2,3,4::VDMNat} { x + 5 | x . x \<in> {1,2,3,4::VDMNat} } inv_VDMNat inv_VDMNat domid (\<lambda> x . (\<lambda> y . x + 5)) (\<lambda> x . (\<lambda> y . x > 2))"

lemmas ex3'_defs = ex3'_def mapCompSetBound_defs inv_VDMNat_def 

lemma ex3'_none: "x \<notin> dom ex3'  \<Longrightarrow> ex3' x = None"
  by (simp add: domIff)

lemma ex3'_dom: "dom ex3' = {3,4}"
  unfolding ex3'_def mapCompSetBound_defs inv_SetElems_def inv_VDMNat_def
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all add: dom_def split:if_splits)
  by fastforce+

lemma ex3'_dom': "dom ex3' = {3,4}"
  unfolding ex3'_defs
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all add: dom_def split:if_splits)
  using inv_SetElems_def by fastforce+
  
lemma ex3'_rng: "rng ex3' = {8,9}"
  unfolding ex3'_defs inv_SetElems_def
  apply (simp split:if_splits)
  apply (intro equalityI subsetI)
   apply (simp_all, safe, simp_all)
       apply (rule+, force, force, force, force, force, force, force) 
  apply (rule_tac x=3 in exI, force)
  by (rule_tac x=4 in exI, force)

lemma ex3'_map: "x \<in> dom ex3' \<Longrightarrow> ex3' x = Some (x+5)"
  unfolding ex3'_defs
  apply (simp split:if_splits, safe, force)
          apply (linarith, force)
  using inv_SetElems_def apply fastforce
  using inv_SetElems_def apply fastforce
  using inv_SetElems_def apply fastforce
  using inv_SetElems_def apply fastforce
  using inv_SetElems_def apply fastforce
  using inv_SetElems_def apply fastforce
  using inv_SetElems_def by fastforce

(* okay: dead simple ones
   = { x |-> 5 | x in set {1,2,3,4} } *)
definition
  ex4 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "ex4 \<equiv> mapCompSetBound {1,2,3,4::VDMNat} { 5::VDMNat } inv_VDMNat inv_VDMNat domid (rngcnst 5) truecnst"

lemmas ex4_defs = ex4_def mapCompSetBound_defs inv_VDMNat_def 

lemma ex4_none: "x \<notin> dom ex4  \<Longrightarrow> ex4 x = None"
  by (simp add: domIff)

lemma ex4_dom: "dom ex4 = {1,2,3,4}"
  unfolding ex4_def mapCompSetBound_defs inv_SetElems_def inv_VDMNat_def
  apply (simp split:if_splits)
  by (intro equalityI subsetI, simp_all add: dom_def split:if_splits)
    
lemma ex4_rng: "rng ex4 = {5}"
  unfolding ex4_defs inv_SetElems_def
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, force, simp)
  by (rule_tac x=1 in exI, fastforce)

lemma ex4_map: "x \<in> dom ex4  \<Longrightarrow> ex4 x = Some 5"
  unfolding ex4_defs
  apply (simp split:if_splits, safe, force+)
  by (meson option.distinct(1))
(* for simple domain binds, you get simple enough proofs *)

(* s1: set of real = {1,2,3}, is_(s1, set of int)? *)
lemma "isTest' {1,2,3::VDMReal} 
        (vdmset_of_t vdmint_of_real)
        (inv_VDMSet' inv_VDMInt)"
  unfolding isTest'_def vdmset_of_t_def total_coercion_def 
  apply simp
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_VDMInt_def inv_SetElems_def
  apply (simp, safe)
  unfolding vdmint_of_real_def is_VDMRealWhole_def
  by (simp_all add: vdm_narrow_real_def)

(* s1: set of real = {1,2,3}, is_(s1, set of nat)? *)
lemma "isTest' {1,2,3::VDMReal} 
        (vdmset_of_t vdmint_of_real)
        (inv_VDMSet' inv_VDMNat)"
  unfolding isTest'_def vdmset_of_t_def total_coercion_def 
  apply simp
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_VDMNat_def inv_SetElems_def
  apply (simp, safe)
  unfolding vdmint_of_real_def is_VDMRealWhole_def
  by (simp_all add: vdm_narrow_real_def)

lemma "\<not> isTest' (-10)
        (\<lambda> x . if inv_VDMNat x then Some x else None) 
        inv_VDMNat"
  unfolding isTest'_def inv_VDMNat_def by simp

lemma "isTest' [1,2,3::VDMNat] 
        (\<lambda> x . Some { x$i | i . i \<in> inds x }) 
        (inv_VDMSet' inv_VDMNat)"
  unfolding isTest'_def
  apply simp
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_VDMNat_def inv_SetElems_def
  apply (simp, safe)
  unfolding applyVDMSeq_def inv_VDMNat1_def len_def
  apply simp
  by (simp add: nth_Cons')

end