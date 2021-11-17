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

text \<open>Set bound map comprehension can filter bound set for their elements invariants.
      This corresponds to the VDMSL expression
      %
      \begin{vdmssl}
        { domexpr(d) |-> rngexpr(d, r) | d in set S, r in set T & P(d, r) }
      \end{vdmsl}
      % 
      If the filtering is not unique (i.e. result is not a function), then the @{term "THE x . P x"} expression
      might lead to (undefined) unexpected results. In Isabelle maps, repetitions is equivalent to overriding,
      so that @{lemma "[1::nat \<mapsto> 2, 1 \<mapsto> 3] 1 = Some 3" by simp}. 
     \<close>
definition 
  mapCompSetBound :: "'a set \<Rightarrow> 'b set \<Rightarrow> ('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "mapCompSetBound S T inv_S inv_T domexpr rngexpr pred \<equiv> 
        (\<lambda> dummy::'a . 
            if inv_VDMSet' inv_S S \<and> inv_VDMSet' inv_T T then
              if (\<exists> d \<in> S . \<exists> r \<in> T . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r) then
                Some (THE r . r \<in> T \<and> inv_T r \<and> (\<exists> d \<in> S . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r)) 
              else 
                None
            else
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

lemma domidI[simp]: "domid d r = d"
  by (simp add: domid_def)

lemma rngidI[simp]: "rngid d r = r"
  by (simp add: rngid_def)

text \<open>Constant function to be used for the rng expression function for the case they are constants.\<close>
definition
  rngcnst :: "'b \<Rightarrow> 'a \<Rightarrow> 'b \<Rightarrow> 'b"
  where
  "rngcnst v \<equiv> (\<lambda> d . (\<lambda> r . v))"

definition
  truecnst :: "'a \<Rightarrow> 'b \<Rightarrow> \<bool>"
  where
  "truecnst \<equiv> (\<lambda> d . inv_True)"

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
  apply (simp split:if_splits) oops

definition
  ex2' :: "VDMNat \<rightharpoonup> VDMNat"
  where
  "ex2' \<equiv> mapCompSetBound { x + y | x y . x \<in> {1,2,3::VDMNat} \<and> y \<in> {4,5,6::VDMNat} } {10::VDMNat} 
                inv_VDMNat inv_VDMNat domid (rngcnst 10) truecnst"

lemmas ex2'_defs = ex2'_def mapCompSetBound_defs inv_VDMNat_def 

lemma ex2'_none: "x \<notin> dom ex2'  \<Longrightarrow> ex2' x = None"
  by (simp add: domIff)

lemma ex2'_dom: "dom ex2' = {5,6,7,8,9}"
  unfolding ex2'_defs
  apply (simp split:if_splits, safe) oops

lemma ex2'_dom_finite: "finite { x + y | x y . x \<in> {1,2,3::VDMNat} \<and> y \<in> {4,5,6::VDMNat} }"
  by (simp add: finite_image_set2) 

lemma ex2'_dom_clearer: "{ x + y | x y . x \<in> {1,2,3::VDMNat} \<and> y \<in> {4,5,6::VDMNat} } = {5..9}"
  apply (safe, simp_all) 
  by presburger
  
lemma ex2'_dom: "dom ex2' = {5,6,7,8,9}"
  unfolding ex2'_defs
  apply (simp only: ex2'_dom_finite ex2'_dom_clearer, simp split:if_splits)
  find_theorems "_ \<in> dom _ \<Longrightarrow> _" 
  apply (intro equalityI subsetI, drule domD, elim exE, simp split:if_splits)


lemma ex1_rng:"rng ex1 = {2,4,6}"
  unfolding rng_defs ex1_defs
  apply (simp split:if_splits)
  apply (intro equalityI subsetI, simp_all)
  (* apply (elim exE conjE impE)*) (* this will be fiddly! *)
  apply (elim exE conjE disjE, simp_all)
     apply (fastforce, fastforce, fastforce)
  by (smt (z3) semiring_norm(83) the_equality verit_eq_simplify(14) zero_le_numeral)

end