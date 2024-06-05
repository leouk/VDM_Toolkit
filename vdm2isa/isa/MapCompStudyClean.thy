theory MapCompStudyClean
imports VDMToolkit
begin

(* { d |-> r | d in set {1,2,3::nat}, r in set {2,4,6::nat} & r = d*2 } *)
lemma mapComp1: "(\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r = d*2) then 
              Some (THE r . (\<exists> d \<in> {1,2,3::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r \<in> {2,4,6::VDMNat} \<and> r = d*2)) 
          else None) = 
  [1 \<mapsto> 2, 2 \<mapsto> 4, 3 \<mapsto> 6]"
  unfolding inv_VDMNat_def
  apply rule
  apply (simp split:if_splits) 
  apply (rule+, simp_all) 
  apply (rule+, simp_all)
  by auto 
  
definition 
  mapComp1 :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "mapComp1 \<equiv> (\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> dummy = d \<and> r = d*2) then
              Some (THE r . (\<exists> d \<in> {1,2::VDMNat} . inv_VDMNat d \<and> inv_VDMNat r \<and> r \<in> {2,4,6::VDMNat} \<and> dummy = d \<and> r = d*2)) 
          else None)"

lemma "x \<notin> {1,2,3::VDMNat} \<Longrightarrow>  mapComp1 x = None"
  by (simp add: mapComp1_def inv_VDMNat_def)

lemma "\<not> inv_VDMNat x  \<Longrightarrow> mapComp1  x = None"
  by (simp add: mapComp1_def inv_VDMNat_def)

definition 
  mapComp2 :: "VDMNat \<rightharpoonup> VDMNat1"
  where
  "mapComp2 \<equiv> (\<lambda> dummy::VDMNat . if (\<exists> d \<in> {1,2,3::VDMNat} . \<exists> r \<in> {2,4,6::VDMNat} . inv_VDMNat d \<and> inv_VDMNat1 r \<and> dummy = d \<and> r = d*2) then
              Some (THE r . (\<exists> d \<in> {1,2, 3::VDMNat} . inv_VDMNat d \<and> inv_VDMNat1 r \<and> r \<in> {2,4,6::VDMNat} \<and> dummy = d \<and> r = d*2)) 
          else None)"

lemma "x \<notin> dom mapComp2  \<Longrightarrow>  mapComp2 x = None"
  by (simp add: domIff mapComp2_def)

lemma "dom mapComp2 = {1,2,3::VDMNat}"
  unfolding dom_def mapComp2_def inv_VDMNat1_def inv_VDMNat_def
  by (simp split:if_splits, safe)

lemma "rng mapComp2 = {2,4,6::VDMNat}"
  unfolding ran_def rng_def mapComp2_def inv_VDMNat1_def inv_VDMNat_def
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all)
   apply (elim exE conjE disjE, simp_all)
     apply fastforce
  apply fastforce
   apply fastforce
  by (smt (z3) semiring_norm(83) the_equality verit_eq_simplify(14) zero_le_numeral)

text \<open>Isabelle maps are similar to VDMs, but with some significant differences worth observing. 
 
      If the filtering is not unique (i.e. result is not a function), then the @{term "THE x . P x"} expression
      might lead to (undefined) unexpected results. In Isabelle maps, repetitions is equivalent to overriding,
      so that @{lemma "[1::nat \<mapsto> 2, 1 \<mapsto> 3] 1 = Some 3" by simp}. 

      In various VDMToolkit definitions, we default to @{term undefined} in case where the situation is out of hand,
      hence, proofs will fail, and users will know that @{term undefined} being reached means some earlier problem has
      occurred.  
    \<close>

text \<open>Type bound map comprehension cannot filter for type invariants, hence won't have @{term undefined} results.
      This corresponds to the VDMSL expression
      %
      \begin{vdmssl}
        { domexpr(d) |-> rngexpr(d, r) | d:S, r: T & P(d, r) }
      \end{vdmsl}
      % 
      where the maplet expression can be just variables or functions over the domain/range input(s). 

      VDM also issues a proof obligation for type bound maps (i.e. avoid it please!) to ensure the resulting map is finite.
      Concretely, the example below generates the corresponding proof obligation:
      %
      \begin{vdmsl}
      	ex: () -> map nat to nat
	      ex() == { x+y |-> 10 | x: nat, y in set {4,5,6} & x < 10 };

        exists finmap1: map nat to (map (nat1) to (nat1)) & 
            forall x:nat, y in set {4, 5, 6} & (x < 10) => 
              exists findex2 in set dom finmap1 & 
                finmap1(findex2) = {(x + y) |-> 10}
      \end{vdmsl}
     \<close>
definition 
  mapCompTypeBound :: "('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "mapCompTypeBound inv_S inv_T domexpr rngexpr pred \<equiv> 
        (\<lambda> dummy::'a . 
            if (\<exists> d r . inv_S d \<and> inv_T r \<and> dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r) then
                Some (THE r . inv_T r \<and> (\<exists> d . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r)) 
              else 
                None
        )"

value "[1::nat \<mapsto> 2::nat, 3 \<mapsto> 3] 10"
text \<open>Set bound map comprehension can filter bound set for their elements invariants.
      This corresponds to the VDMSL expression
      % TODO use x and y instead of d and r?  
      \begin{vdmssl}
        { domexpr(d, r) |-> rngexpr(d, r) | d in set S, r in set T & pred(d, r) }
        domexpr: S * T -> S
        rngexpr: S * T -> T
        pred   : S * T -> bool 
      \end{vdmsl}
      % 
      If the types of domexpr or rngexpr are different from S or T then this will not work! 
      %
      If the filtering is not unique (i.e. result is not a function), then the @{term "THE x . P x"} expression
      might lead to (undefined) unexpected results. In Isabelle maps, repetitions is equivalent to overriding,
      so that @{lemma "[1::nat \<mapsto> 2::nat, 1 \<mapsto> 3] 1 = Some 3" by simp}. 
     \<close>
value "((1::real) / (0::real)) + 5"
value "(3 - (5::nat))"
definition 
  mapCompSetBound :: "'a set \<Rightarrow> 'b set \<Rightarrow> ('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "mapCompSetBound S T inv_S inv_T domexpr rngexpr pred \<equiv> 
        (\<lambda> dummy::'a . 
            \<comment> \<open>In fact you have to check the inv_Type of domexpr and rngexpr!!!\<close>
            if inv_VDMSet' inv_S S \<and> inv_VDMSet' inv_T T then
              if (\<exists> r \<in> T . \<exists> d \<in> S . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r) then
                Some (THE r . r \<in> T \<and> inv_T r \<and> (\<exists> d \<in> S . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r)) 
              else 
                \<comment> \<open>This is for map application outside its domain error, VDMJ 4061 \<close>
                None
            else
              \<comment> \<open>This is for type invariant violation errors, VDMJ ???? @NB?\<close>
              undefined
        )"

text \<open>Identity functions to be used for the dom/rng expression functions for the case they are variables.\<close>
definition 
  domid :: "'a \<Rightarrow> 'b \<Rightarrow> 'a"
  where
  "domid \<equiv> (\<lambda> d . (\<lambda> r . d))"

definition
  rngid :: "'a \<Rightarrow> 'b \<Rightarrow> 'b"
  where
  "rngid \<equiv> (\<lambda> d . id)"

text \<open>Constant function to be used for the rng expression function for the case they are constants.\<close>
definition
  rngcnst :: "'b \<Rightarrow> 'a \<Rightarrow> 'b \<Rightarrow> 'b"
  where
  "rngcnst v \<equiv> (\<lambda> d . (\<lambda> r . v))"

definition
  truecnst :: "'a \<Rightarrow> 'b \<Rightarrow> \<bool>"
  where
  "truecnst \<equiv> (\<lambda> d . inv_True)"

lemma domidI[simp]: "domid d r = d"
  by (simp add: domid_def)

lemma rngidI[simp]: "rngid d r = r"
  by (simp add: rngid_def)

lemma rngcnstI[simp]: "rngcnst v d r = v"
  by (simp add: rngcnst_def)

lemmas maplet_defs = domid_def rngid_def rngcnst_def id_def truecnst_def inv_True_def
lemmas rng_defs = rng_def ran_def
lemmas mapCompSetBound_defs = mapCompSetBound_def inv_VDMSet'_def inv_VDMSet_def maplet_defs rng_defs
lemmas mapCompTypeBound_defs = mapCompTypeBound_def maplet_defs rng_defs

(*On the explicit (narrower/declared) type, add inv_VDMNat1 
  v98: map nat to nat1 = { d \<mapsto> r | d in set {1,2,3}, r in set {2,4,6} & r = d*2 } *)
definition
  ex1 :: "VDMNat \<rightharpoonup> VDMNat1"
  where
  "ex1 \<equiv> mapCompSetBound {1,2,3::VDMNat} {2,4,6::VDMNat} inv_VDMNat inv_VDMNat1 domid rngid (\<lambda> d r . r = d*2)"

lemmas ex1_defs = ex1_def mapCompSetBound_defs inv_VDMNat1_def inv_VDMNat_def 

\<comment> \<open>making sure the encoding is indeed correct wrt to the example\<close>
lemma "mapComp2 = ex1"
  unfolding ex1_defs mapComp2_def domid_def rngid_def rngcnst_def
  apply (simp)
  apply (rule, simp, safe)
  by meson+

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

lemmas ex2'_defs = ex2'_def mapCompSetBound_defs inv_VDMNat_def 

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
(*   apply (smt (verit, del_insts) atLeastAtMost_iff ex2'_dom_clearer l_map_dom_ran)*)
(*  by (smt (z3) Collect_cong atLeastAtMost_iff ex2'_dom_clearer ex2'_dom_finite finite.emptyI finite.insertI inv_SetElems_def inv_VDMNat_def l_invVDMSet_finite mem_Collect_eq singletonD) *)
  apply (erule impE)
  using ex2'_dom_clearer ex2'_dom_inv' apply simp
  using inv_VDMNat_def apply auto
  sorry

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

lemma "inv_VDMSet' inv_S S \<Longrightarrow>
      dom (mapCompSetBound S T inv_S inv_T domexpr rngexpr pred) 
      =
      { x . inv_S x \<and> x \<in> S \<and> (\<exists> r . x = domexpr d r \<and> pred d r) }"
  unfolding mapCompSetBound_def
  apply safe
     apply (simp_all split:if_splits)
        apply safe
  nitpick
  oops

end