(* $Id$ *)
theory NDB0
imports "../VDMToolkit"
begin

type_notation bool  ("\<bool>") 
type_notation nat ("\<nat>")

typedecl Eid 
typedecl Esetnm
typedecl Relnm
typedecl Value

typedecl Status
typedecl Picture
typedecl Width

record Esetinf =
  status  :: Status
  picture :: Picture
  width   :: Width
  membs   :: "Eid set"

record Reltype =
  fs :: Esetnm 
  nm :: "(Relnm option)"
  ts :: Esetnm

datatype Maptype = OneOne | OneMany | ManyOne | ManyMany 

record Pair =
  fv :: Eid
  tv :: Eid

record Relinf =
  map   :: Maptype
  conns :: "Pair set"

(* Because of type invariant on Relinf*)
type_synonym Relmap  = "Reltype \<rightharpoonup> Relinf"
type_synonym Esetmap = "Esetnm \<rightharpoonup> Esetinf"
type_synonym Eidval  = "Value option"
type_synonym Eidmap  = "Eid \<rightharpoonup> Eidval"

record State_a = 
  esets :: Esetmap
  rels  :: Relmap
  ents  :: Eidmap
          (* The range type as VDM [Value] involves an optional type Value.
             This is not to be confused with Isabelle's VDM-map encoding,
             which relies on option range types. That is, we have two "None"
             values: None = value not in domain; (Some None) = user choose 
             nil for Eid domain element.
           *)

thm Let_def
thm State_a.defs

definition
  inv_Esetinf :: "Esetinf \<Rightarrow> \<bool>"
where
  "inv_Esetinf esetinf \<equiv> finite (membs esetinf)"  (* Notihng for now *)

definition
  inv_Reltype :: "Reltype \<Rightarrow> \<bool>"
where
  "inv_Reltype rt \<equiv> True"  (* Notihng for now *)

definition
  inv_Esetmap :: "Esetmap \<Rightarrow> \<bool>"
where
  "inv_Esetmap esm \<equiv> (\<forall> x \<in> dom esm . inv_Esetinf (the(esm x)))"

definition
  inv_Eidval :: "Eidval \<Rightarrow> \<bool>"
where
  "inv_Eidval eidval \<equiv> True"  (* Notihng for now *)

definition
  inv_Eidmap :: "Eidmap \<Rightarrow> \<bool>"
where
  "inv_Eidmap eidm \<equiv> (\<forall> x \<in> dom eidm . inv_Eidval (the(eidm x)))"

definition
  inv_Maps :: "Relinf \<Rightarrow> \<bool>"
where
  [intro!] : 
  "inv_Maps r \<equiv> (case (map r) of 
                    ManyMany \<Rightarrow> True |
                    ManyOne  \<Rightarrow> \<not> (\<exists> pr1 \<in> (conns r) . \<exists> pr2 \<in> (conns r) . pr1 \<noteq> pr2 \<and> (fv pr1) = (fv pr2)) |
                    OneMany  \<Rightarrow> \<not> (\<exists> pr1 \<in> (conns r) . \<exists> pr2 \<in> (conns r) . pr1 \<noteq> pr2 \<and> (tv pr1) = (tv pr2)) |
                    OneOne   \<Rightarrow> \<not> (\<exists> pr1 \<in> (conns r) . \<exists> pr2 \<in> (conns r) . pr1 \<noteq> pr2 \<and> ((fv pr1) = (fv pr2) \<or> (tv pr1) = (tv pr2)))
                   )"
                   (* Maybe this deserve a better formatting ? Make it an intro rule? *)

definition
  inv_Relinf :: "Relinf \<Rightarrow> \<bool>"
where
  "inv_Relinf r \<equiv> finite (conns r) \<and> inv_Maps r"
                  (* To keep track of checking Relinf invariant, we use a clearer (if redundant) name *)

definition
  inv_Relmap :: "Relmap \<Rightarrow> \<bool>"
where
  "inv_Relmap rm \<equiv> (\<forall> x \<in> dom rm . inv_Reltype x \<and> inv_Relinf (the(rm x)))"

definition
  pictureMatch :: "Eidval \<Rightarrow> Picture \<Rightarrow> \<bool>"
where
  "pictureMatch ev p \<equiv> ev \<noteq> None"

definition
  inv_Vals :: "Esetinf \<Rightarrow> Eidmap \<Rightarrow> \<bool>"
where
  "inv_Vals esi em \<equiv> inv_Esetinf esi \<and> inv_Eidmap em \<and>
                     (let pict = picture esi in
                      let mem  = membs esi in 
                         mem \<subseteq> dom em \<and>
                         (\<forall> eid \<in> mem . pictureMatch (the(em eid)) pict))"
                      (* TODO: duplicated inv_XXXmap test. Check whether it's better at inv_State_a or here *)

definition
  inv_Esets :: "Esetnm set \<Rightarrow> Reltype set \<Rightarrow> \<bool>"
where
  "inv_Esets esetnms em \<equiv> \<forall> reltype \<in> em . (fs reltype) \<in> esetnms \<and>
                                            (ts reltype) \<in> esetnms"

definition
  are_membs :: "Eid set \<Rightarrow> Esetinf \<Rightarrow> \<bool>"
where
  "are_membs eset esetinf \<equiv> inv_Esetinf esetinf \<and> eset \<subset> (membs esetinf)"

definition 
  froms :: "Pair set \<Rightarrow> Eid set"
where
  "froms prset \<equiv> { (fv pr) | pr . pr \<in> prset}"

definition 
  tos :: "Pair set \<Rightarrow> Eid set"
where
  "tos prset \<equiv> { (tv pr) | pr . pr \<in> prset}"

definition
  inv_Pairs :: "Esetmap \<Rightarrow> Relmap \<Rightarrow> \<bool>"
where
  "inv_Pairs esm rm \<equiv> inv_Esetmap esm \<and>
                      inv_Relmap rm \<and> 
                      (\<forall> reltype \<in> dom rm . 
                          (let f = (fs reltype) in 
                           let t = (ts reltype) in 
                           let prset = (conns (the(rm reltype))) in 
                              f \<in> dom esm \<and> t \<in> dom esm \<and> 
                              are_membs (froms prset) (the(esm f)) \<and> 
                              are_membs (tos prset)   (the(esm t)) 
                           )
                      )"
                      (* MISSING FROM ORIGINAL! f \<in> dom esm \<and> t \<in> dom esm \<and> *)
                      (* TODO: duplicated inv_XXXmap test. Check whether it's better at inv_State_a or here *)

definition
  inv_Ents :: "Esetinf set \<Rightarrow> Eid set \<Rightarrow> \<bool>"
where
  "inv_Ents esetinfs eids \<equiv> (\<Union> esetinf \<in> esetinfs . (membs esetinf)) = eids"

definition
  inv_State_a_OLD :: "State_a \<Rightarrow> \<bool>"
where
  "inv_State_a_OLD s \<equiv> (let esm = esets s in 
                        let rm = rels s in 
                        let em = ents s in 
                          inv_Esetmap esm \<and>
                          inv_Relmap rm \<and>
                          inv_Eidmap em \<and>
                          (\<forall> esetnm \<in> dom esm .
                          inv_Esets (dom esm) (dom rm) \<and>
                          inv_Pairs esm rm \<and>
                          inv_Ents (ran esm) (dom em) \<and>
                           inv_Vals (the(esm esetnm)) em))"
                          (* TODO: investigate whether to have inv_XXXmap here or in specific inv_XXX definitions
                           
                             NOTE: move invariants out of \<forall> where possible
                         *)
definition
  inv_State_a :: "State_a \<Rightarrow> \<bool>"
where
  "inv_State_a s \<equiv> (let esm = esets s in 
                    let rm = rels s in 
                    let em = ents s in 
                      inv_Esetmap esm \<and>
                      inv_Relmap rm \<and>
                      inv_Eidmap em \<and>
                      inv_Esets (dom esm) (dom rm) \<and>
                      inv_Pairs esm rm \<and>
                      inv_Ents (ran esm) (dom em) \<and>
                      (\<forall> esetnm \<in> dom esm . inv_Vals (the(esm esetnm)) em))"
                      (* TODO: investigate whether to have inv_XXXmap here or in specific inv_XXX definitions
                       
                         NOTE: move invariants out of \<forall> where possible
                       *)

lemma a0: "inv_State_a s = inv_State_a_OLD s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply (cases "dom (esets s) = {}")
apply (rule iffI)
  apply metis
  apply (elim conjE ballE, intro ballI conjI)
  apply simp_all
defer
(*find_theorems "_ \<noteq> empty"
apply (simp add: l_map_non_empty_has_elem_conv)
apply (erule exE)
*)
apply (rule iffI)
apply (elim conjE)
apply (intro conjI ballI)
apply assumption+
apply (erule_tac x=esetnm in ballE)
apply assumption
apply simp
apply (elim conjE, intro ballI conjI)
apply simp_all
apply (simp add: l_map_non_empty_has_elem_conv)
apply (erule exE)
oops

lemma a1: "inv_State_a s = inv_State_a_OLD s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply (cases "dom (esets s) = {}")
apply (rule iffI)
  apply metis
  apply (elim conjE ballE, intro ballI conjI)
  apply simp_all
defer
(*find_theorems "_ \<noteq> empty"
apply (simp add: l_map_non_empty_has_elem_conv)
apply (erule exE)
*)
apply (rule iffI)
apply (elim conjE)
apply (intro conjI ballI)
apply assumption+
apply (erule_tac x=esetnm in ballE)
apply assumption
apply simp
apply (simp add: l_map_non_empty_has_elem_conv)
apply (erule exE) (* do this earlier to save some steps *)
apply (elim conjE, intro ballI conjI)
apply simp_all
(* now back to the base case for empty *)
apply (intro conjI)
    unfolding inv_Esets_def
    apply simp
    defer
    unfolding inv_Pairs_def
    apply simp
    defer
    unfolding inv_Ents_def
    apply simp

unfolding inv_Esetmap_def inv_Relmap_def inv_Esetinf_def
           inv_Relinf_def inv_Eidmap_def inv_Eidval_def
apply simp_all
unfolding inv_Maps_def
apply (erule ballE)
apply auto
oops (*???*)

lemma "inv_State_a s = inv_State_a_OLD s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply (cases "dom (esets s) = {}")
apply simp
oops


(*
A \<sqsubseteq> B \<equiv> B \<Longrightarrow> A
OLD \<sqsubseteq> NEW \<equiv> NEW \<Longrightarrow> OLD
*)
lemma a2: "inv_State_a s = inv_State_a_OLD s"
apply (rule iffI)
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply simp (* it's a refinement at least; but not an equality ? *)
apply simp
apply (elim conjE ballE)
apply simp
oops

lemma a3_1_a1: "inv_State_a s \<Longrightarrow> inv_State_a_OLD s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
by simp

lemma "(\<forall> x \<in> S . Q \<and> P x) = (\<forall> x \<in> S . P x) \<and> Q"
nitpick
oops (* of course ! blah! *)

lemma "(\<forall> x \<in> S . Q \<and> P x) = ((\<forall> x \<in> S . P x) \<longrightarrow> Q)"
(*
  \<forall> x . P x \<longrightarrow> N
  =
  \<forall> x . x \<in> S \<longrightarrow> Q \<and> P x
  =
  \<forall> x . x \<in> S \<longrightarrow> P x \<and> Q
  =
  \<forall> x . \<not> (x \<in> S \<or> (P x \<and> Q))
  =
  \<forall> x . \<not> ((x \<in> S \<or> P x) \<and> (x \<in> S \<or> Q))
  =
  \<forall> x . \<not>(x \<in> S \<or> P x) \<or>  \<not>(x \<in> S \<or> Q)
  =
  \<forall> x . (x \<in> S \<or> P x) \<longrightarrow>  \<not>(x \<in> S \<or> Q)
  =
  bla...
*)
nitpick
oops
find_theorems (200) "(\<forall> _ \<in> _ . _)" -name:Interval -name:Relation -name:Quotient
        -name:Presburger -name:NDB -name:VDMM -name:List -name:Inductive
        -name:Hilbert -name:Product -name:Wellfounde -name:Finite
        -name:Enum -name:Complete -name:Option  -name:Big_Ope

lemma a3_2_a1: "inv_State_a_OLD s \<Longrightarrow> inv_State_a s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply simp
find_theorems "(\<forall> _ \<in> _. _)" (* avoid ballE *)
thm atomize_ball[of "dom(esets s)" "\<lambda> esetnm . inv_Esets (dom (esets s)) (dom (rels s)) \<and>
        inv_Pairs (esets s) (rels s) \<and>
        inv_Ents (ran (esets s)) (dom (ents s)) \<and>
        inv_Vals (the (esets s esetnm)) (ents s)"]
apply (cut_tac atomize_ball[of "dom(esets s)" "\<lambda> esetnm . inv_Esets (dom (esets s)) (dom (rels s)) \<and>
        inv_Pairs (esets s) (rels s) \<and>
        inv_Ents (ran (esets s)) (dom (ents s)) \<and>
        inv_Vals (the (esets s esetnm)) (ents s)"])
apply simp
oops

lemma reshape: "(\<forall> x \<in> S . Q \<and> P x) = (S = {} \<or> ((\<forall> x \<in> S . P x) \<and> Q))"
by (metis (full_types) empty_iff equals0I)

lemma a3_2_a2: "inv_State_a_OLD s \<Longrightarrow> inv_State_a s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply (simp add: reshape)
find_theorems simp:"_ \<or> _"
thm disj_left_absorb disj_conj_distribL
apply (simp add: disj_conj_distribL)
apply (elim conjE disjE)
apply simp_all
oops (* FAILURE: too many subgoals *)

lemma a3_2_a2: "inv_State_a_OLD s \<Longrightarrow> inv_State_a s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply (simp add: reshape)
find_theorems simp:"_ \<or> _"
thm disj_left_absorb disj_conj_distribL
apply (elim conjE disjE)
apply (intro conjI)
apply (simp_all)
oops

lemma a3_2_a2_0: "inv_State_a_OLD s \<Longrightarrow> inv_State_a s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply (simp add: reshape)
find_theorems simp:"_ \<or> _"
thm disj_left_absorb disj_conj_distribL
apply (elim conjE disjE)
apply (intro conjI)
apply (simp_all)
apply (subgoal_tac "rels s = Map.empty")
  apply (metis dom_eq_empty_conv empty_iff inv_Esets_def)
oops

lemma a3_2_a2_1: "inv_State_a_OLD s \<Longrightarrow> inv_State_a s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
thm reshape[of "dom (esets s)" "inv_Esetmap (esets s) \<and>
    inv_Relmap (rels s) \<and>
    inv_Eidmap (ents s) \<and>
    inv_Esets (dom (esets s)) (dom (rels s)) \<and>
    inv_Pairs (esets s) (rels s) \<and>
    inv_Ents (ran (esets s)) (dom (ents s))" "(\<lambda> x .  inv_Vals (the (esets s x)) (ents s))"]
apply (insert reshape[of "dom (esets s)" "inv_Esetmap (esets s) \<and>
    inv_Relmap (rels s) \<and>
    inv_Eidmap (ents s) \<and>
    inv_Esets (dom (esets s)) (dom (rels s)) \<and>
    inv_Pairs (esets s) (rels s) \<and>
    inv_Ents (ran (esets s)) (dom (ents s))" "(\<lambda> x .  inv_Vals (the (esets s x)) (ents s))"])
apply simp
oops (* FAILURE:try and decompose the common subgoals *)

lemma "inv_Esets {} (dom (rels s))"
unfolding inv_Esets_def
apply (intro ballI conjI)
apply simp_all
oops

lemma a3_2_a3_l1_a1: "inv_Esetmap Map.empty"
unfolding inv_Esetmap_def inv_Esetinf_def
by auto

lemma "inv_Relmap (rels s) \<Longrightarrow> inv_Pairs Map.empty (rels s)"
unfolding inv_Pairs_def Let_def
apply simp_all
apply (intro conjI, simp add: a3_2_a3_l1_a1)
oops

lemma "inv_Ents {} (dom (ents s))"
unfolding inv_Ents_def
apply simp 
oops

lemma a3_2_a3_l2_a2: "inv_Esets {} {}"
unfolding inv_Esets_def
by auto

lemma a3_2_a3_l3_a2: "inv_Esetmap Map.empty \<Longrightarrow> inv_Relmap Map.empty \<Longrightarrow> inv_Pairs Map.empty Map.empty"
unfolding inv_Pairs_def Let_def
by simp

lemma a3_2_a3_l4_a2: "inv_Ents {} {}"
unfolding inv_Ents_def
by simp
  
lemma a3_2_a3: "dom (esets s) = {} \<longrightarrow> dom (ents s)= {} \<and> dom (rels s) = {} \<Longrightarrow> inv_State_a_OLD s \<Longrightarrow> inv_State_a s"
unfolding inv_State_a_def inv_State_a_OLD_def Let_def
apply (simp add: reshape)
find_theorems simp:"_ \<or> _"
thm disj_left_absorb disj_conj_distribL
apply (elim conjE disjE)
apply (simp_all)
apply (intro conjI)
apply (metis a3_2_a3_l2_a2)
apply (metis a3_2_a3_l3_a2)
apply (metis a3_2_a3_l4_a2)
apply (metis a3_2_a3_l3_a2 a3_2_a3_l4_a2)
by (metis a3_2_a3_l4_a2)

definition
  add0_pre :: "State_a \<Rightarrow> Esetnm \<Rightarrow> Status \<Rightarrow> Picture \<Rightarrow> Width \<Rightarrow> \<bool>"
where
  "add0_pre st eset _ _ _ \<equiv> inv_State_a st \<and> eset \<notin> dom (esets st)"

definition
  add0_post :: "State_a \<Rightarrow> Esetnm \<Rightarrow> Status \<Rightarrow> Picture \<Rightarrow> Width \<Rightarrow> State_a \<Rightarrow> \<bool>"
where
  "add0_post st eset s p w st' \<equiv> inv_State_a st \<and> inv_State_a st' \<and> 
                                 (esets st') = (esets st) \<union>m 
                                              [ eset \<mapsto> \<lparr> status = s, picture = p, width = w, membs = {} \<rparr>]"

definition 
  PO_add0_fsb :: "\<bool>"
where
  "PO_add0_fsb \<equiv> (\<forall> st eset s p w . inv_State_a st \<and> add0_pre st eset s p w \<longrightarrow> 
                        (\<exists> st' .  inv_State_a st' \<and> add0_post st eset s p w st'))"


text \<open> We will use various delimiters to avoid confusion in finding the attempts/justifications.
        PP should give us that out of the box? (ATT/TODO: Andrius?)
     \<close>

(*================================================================================================*)
text \<open> some lemmas are needed prior to PO_add0_FEAS_a4 \<close>

(*------------------------------------------------------------------------------------------------*)
lemma PO_add0_FEAS_a4_invbd_state_esetmap_a1: 
  "eset \<notin> dom (esets st) \<Longrightarrow> 
   inv_Esetmap (esets st)  \<Longrightarrow>
    inv_Esetmap
     (esets \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
               ents = ents st\<rparr>)"
(* Strategy 1: invariant zoom *)
unfolding inv_Esetmap_def inv_Esetinf_def

(* Strategy 2: structural break down ; PS: tool automation would suffice here, but that's because inv_Esetinf_def is trivial! *)
  apply (intro ballI)
  by (metis Esetinf.select_convs(4) State_a.select_convs(1) finite.emptyI fun_upd_same k_munion_map_upd_wd l_inmapupd_dom_iff l_munion_upd l_the_map_union option.sel)

(*------------------------------------------------------------------------------------------------*)
text \<open> Trying sub lemmas for PO_add0_FEAS_a4_invbd_state_a3 \<close>

(*________________________________________________________________________________________________*)

lemma PO_add0_FEAS_a3_invbd_state_vals_a3: 
  (* added a supposed missing condition  esetnm \<in> dom (esets st); case analysis might be needed *)
  "eset \<notin> dom (esets st) \<Longrightarrow>
   esetnm \<in> dom (esets st) \<Longrightarrow>
   inv_Vals (the (esets st esetnm)) (ents st)
    \<Longrightarrow>
    inv_Vals (the ((esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) esetnm))
        (ents st)"
unfolding inv_Vals_def Let_def

  apply (elim conjE, intro conjI)
  apply (simp add: l_the_map_union)
apply assumption

apply (subst l_the_map_union_left)
  apply assumption
  apply simp
  apply assumption

apply (intro ballI, erule_tac x=eid in ballE)

apply (subst l_the_map_union_left)
  apply assumption
  apply simp
  apply assumption

apply (subst l_the_map_union_left)
  apply assumption
  apply simp

apply (simp add: l_the_map_union_left)
done

(*________________________________________________________________________________________________*)

lemma PO_add0_FEAS_a3_invbd_state_esets_a1:
"eset \<notin> dom (esets st) \<Longrightarrow> 
 esetnm \<in> dom (esets st) \<Longrightarrow>
 inv_Esets (dom (esets st)) (dom (rels st)) \<Longrightarrow>
       inv_Esets (dom (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]))
        (dom (rels st))"
unfolding inv_Esets_def 

apply (intro ballI, erule_tac x=reltype in ballE)

apply (elim conjE, intro conjI)

apply (metis l_dom_ar_not_in_dom l_munion_dom_ar_singleton_subsume)
apply (metis l_dom_ar_not_in_dom l_munion_dom_ar_singleton_subsume)

apply (intro conjI)

apply metis+
done

lemma PO_add0_FEAS_a3_invbd_state_esets_simplified_a1:
"eset \<notin> dom (esets st) \<Longrightarrow> 
 esetnm \<in> dom (esets st) \<Longrightarrow>
 inv_Esets (dom (esets st)) (dom (rels st)) \<Longrightarrow>
       inv_Esets (insert eset (dom (esets st))) (dom (rels st))"
unfolding inv_Esets_def 

apply (intro ballI, erule_tac x=reltype in ballE)

apply (elim conjE, intro conjI)

apply (metis insert_iff)
apply (metis insert_iff)
apply (metis)
done

(*________________________________________________________________________________________________*)

lemma  PO_add0_FEAS_a3_invbd_state_ents_a2:
"eset \<notin> dom (esets st) \<Longrightarrow>
inv_Ents (ran (esets st)) (dom (ents st)) \<Longrightarrow>
       inv_Ents (ran (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>])) (dom (ents st))"
unfolding inv_Ents_def 

(*sledgehammer fails*)
apply (simp add: l_munion_ran)
done

lemma PO_add0_FEAS_a3_invbd_state_pairs_a3:
"eset \<notin> dom (esets st) \<Longrightarrow> 
 esetnm \<in> dom (esets st) \<Longrightarrow>
  inv_Pairs (esets st) (rels st) \<Longrightarrow>
       inv_Pairs (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) (rels st)
"
unfolding inv_Pairs_def 
apply (simp add: l_munion_ran)

  apply (intro conjI)
  apply (metis PO_add0_FEAS_a4_invbd_state_esetmap_a1 State_a.select_convs(1))
(* apply (metis PO_add0_FEAS_a4_invbd_state_esetmap_a1 State_a.select_convs(1)) *)

apply (unfold Let_def, elim conjE, intro ballI)

apply (erule_tac x=reltype in ballE)
apply (elim conjE, intro conjI)

find_theorems "dom(_ \<union>m _)"
apply (subst l_munion_dom)
  apply simp
  apply simp

apply (subst l_munion_dom)
  apply simp
  apply simp

apply (subst l_the_map_union_left)
  apply assumption
  apply simp
  apply assumption

apply (subst l_the_map_union_left)
  apply assumption
  apply simp
  apply assumption

apply simp
done 

lemma PO_add0_FEAS_a3_invbd_state_pairs_general_a1:
"eset \<notin> dom (esets st) \<Longrightarrow> 
  inv_Pairs (esets st) (rels st) \<Longrightarrow>
       inv_Pairs (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) (rels st)
"
unfolding inv_Pairs_def 
apply (simp add: l_munion_ran)

apply (intro conjI)
sledgehammer
  apply (metis PO_add0_FEAS_a4_invbd_state_esetmap_a1 State_a.select_convs(1))
(* apply (metis PO_add0_FEAS_a4_invbd_state_esetmap_a1 State_a.select_convs(1)) *)

apply (unfold Let_def, elim conjE, intro ballI)

apply (erule_tac x=reltype in ballE)
apply (elim conjE, intro conjI)

find_theorems "dom(_ \<union>m _)"
apply (subst l_munion_dom)
  apply simp
  apply simp

apply (subst l_munion_dom)
  apply simp
  apply simp

apply (subst l_the_map_union_left)
  apply assumption
  apply simp
  apply assumption

apply (subst l_the_map_union_left)
  apply assumption
  apply simp
  apply assumption

apply simp
done 

(*________________________________________________________________________________________________*)

lemma 
PO_add0_FEAS_a4_invbd_state_munion_a1: 
  "esetnm \<in> dom (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) \<Longrightarrow>
   eset \<notin> dom (esets st) \<Longrightarrow> esetnm \<noteq> eset \<Longrightarrow> esetnm \<in> dom (esets st)"
find_theorems "dom(_ \<union>m _)"
thm unionm_in_dom_left[of "esetnm" "esets st" "[eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]",simplified]
  (* TODO: should generalise? *)
by (metis l_in_dom_ar l_munion_dom_ar_singleton_subsume singletonE)

(*________________________________________________________________________________________________*)

lemma PO_add0_FEAS_a4_invbd_state_a9: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
unfolding inv_State_a_def Let_def
apply (elim conjE)
apply simp
apply (intro conjI)
    apply (metis PO_add0_FEAS_a4_invbd_state_esetmap_a1 State_a.select_convs(1))
   apply (metis PO_add0_FEAS_a3_invbd_state_esets_a1 inv_Esets_def)
  apply (simp add: PO_add0_FEAS_a3_invbd_state_pairs_general_a1)
  apply (simp add: PO_add0_FEAS_a3_invbd_state_ents_a2)
  by (simp add: PO_add0_FEAS_a4_invbd_state_munion_a1 inv_Esetinf_def inv_Vals_def l_the_map_union)

(*________________________________________________________________________________________________*)

theorem 
  PO_add0_FEAS_a4: "PO_add0_fsb"

(* Strategy 1: structural breakdown *) 
unfolding PO_add0_fsb_def
apply (intro allI impI, elim conjE)


(* Strategy 2: unfold to appropriate layer *) 
unfolding add0_pre_def add0_post_def
  (* Strategy 3: structural breakdown *) 
  apply (elim conjE)
  (* wanted to remove duplicated assumption, please! *)
  apply simp

(* Strategy 4: existential witness single point - but only one record field! Argh *) 
apply (rule_tac x="\<lparr> esets = 
                     esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>],
                     rels = 
                     rels st,
                     ents = ents st\<rparr>" in exI) 

(* Strategy 5: apply invariant-breakdown lemma ; NOTE: why not rule PO_add0_FEAS_a3_invbd_state_a3? Iain help? *)
apply (simp add: PO_add0_FEAS_a4_invbd_state_a9)
done

(*print_syntax*)


end
