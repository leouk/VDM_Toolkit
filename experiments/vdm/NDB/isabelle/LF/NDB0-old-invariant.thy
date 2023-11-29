(* $Id: NDB0.thy 2207 2014-01-31 13:19:31Z nljsf $ *)
theory NDB0
imports "../../../heap/HEAP/VDMMaps"
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
  "inv_Esetinf esetinf \<equiv> True"  (* Notihng for now *)

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
  "inv_Relinf r \<equiv> inv_Maps r"
                  (* To keep track of checking Relinf invariant, we use a clearer (if redundant) name *)

definition
  inv_Relmap :: "Relmap \<Rightarrow> \<bool>"
where
  "inv_Relmap rm \<equiv> (\<forall> x \<in> dom rm . inv_Relinf (the(rm x)))"

definition
  pictureMatch :: "Eidval \<Rightarrow> Picture \<Rightarrow> \<bool>"
where
  "pictureMatch ev p \<equiv> ev \<noteq> None"

definition
  inv_Vals :: "Esetinf \<Rightarrow> Eidmap \<Rightarrow> \<bool>"
where
  "inv_Vals esi em \<equiv> inv_Eidmap em \<and>
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
                              f \<in> dom esm \<and> t \<in> dom esm \<and> (* MISSING FROM ORIGINAL! *)
                              are_membs (froms prset) (the(esm f)) \<and> 
                              are_membs (tos prset)   (the(esm t)) 
                           )
                      )"
                      (* TODO: duplicated inv_XXXmap test. Check whether it's better at inv_State_a or here *)

definition
  inv_Ents :: "Esetinf set \<Rightarrow> Eid set \<Rightarrow> \<bool>"
where
  "inv_Ents esetinfs eids \<equiv> (\<Union> esetinf \<in> esetinfs . (membs esetinf)) = eids"

definition
  inv_State_a :: "State_a \<Rightarrow> \<bool>"
where
  "inv_State_a s \<equiv> (let esm = esets s in 
                    let rm = rels s in 
                    let em = ents s in 
                      inv_Esetmap esm \<and>
                      inv_Relmap rm \<and>
                      inv_Eidmap em \<and>
                      (\<forall> esetnm \<in> dom esm . inv_Vals (the(esm esetnm)) em \<and>
                                           inv_Esets (dom esm) (dom rm) \<and>
                                           inv_Pairs esm rm \<and>
                                           inv_Ents (ran esm) (dom em)))" 
                      (* TODO: investigate whether to have inv_XXXmap here or in specific inv_XXX definitions
                       
                         NOTE: move invariants out of \<forall> where possible
                       *)

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


text {* We will use various delimiters to avoid confusion in finding the attempts/justifications.
        PP should give us that out of the box? (ATT/TODO: Andrius?)
      *}
(*================================================================================================*)
theorem 
  PO_add0_FEAS_a1: "PO_add0_fsb"

(* Strategy 1: structural breakdown *) 
unfolding PO_add0_fsb_def
apply (intro allI impI, elim conjE)

(* Strategy 2: unfold to appropriate layer *) 
unfolding add0_pre_def add0_post_def
  (* Strategy 3: structural breakdown *) 
  apply (elim conjE)

(* Strategy 4: existential witness single point *) 
(*apply (rule_tac x="esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]" in exI) failed?*)
apply (rule exI,simp)
(* Ah! witness is not sets st but st record updated!*)
oops (* Give up because of need for more appropriate witness - FAILURE: witness space exploration*)

(*================================================================================================*)
theorem 
  PO_add0_FEAS_a2: "PO_add0_fsb"

(* Strategy 1: structural breakdown *) 
unfolding PO_add0_fsb_def
apply (intro allI impI, elim conjE)

(* Strategy 2: unfold to appropriate layer *) 
unfolding add0_pre_def add0_post_def
  (* Strategy 3: structural breakdown *) 
  apply (elim conjE)

(* Strategy 4: existential witness single point - but only one record field! Argh *) 
apply (rule_tac x="\<lparr> esets = 
                     esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>],
                     rels = 
                     rels st,
                     ents = ents st\<rparr>" in exI) 

(* Strategy 5: Tool automation - to remove duplicated stuff? *)
apply simp
  (* Iain will say this is cheating :-)?*)
oops (* FAILURE: needs invariant breakdown *)

(*================================================================================================*)
theorem 
  PO_add0_FEAS_a3: "PO_add0_fsb"

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

(* Strategy 5: Split-Invariant-Post (real strategies would tag here too) *)
apply (intro conjI)

(* Strategy 6: Tool automation - to remove duplicated stuff? No simp though*)
defer
apply simp

(* Strategy 7: invariant-breakdown + Rippling *)
unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)

defer
defer
defer
(* Strategy 8: instantiate before state invariant witness prior to conjI to avoid repeated instatiations per goal *)
apply (intro ballI) (* instantiate invariant prior to conjI *)
apply (erule_tac x=esetnm in ballE) (* Iain doesn't like , simp_all, but it works well here. Perhaps use automation strategy? *)
apply (intro conjI)

(* avoid handling the other invariants as they might be removed when refactoring where to put invariants as pointed out above 
apply (unfold inv_Esetmap_def inv_Esetinf_def)
apply (intro ballI, simp)

defer
apply (unfold inv_Eidmap_def inv_Eidval_def)
apply (intro ballI, simp)

unfolding inv_Relmap_def inv_Relinf_def inv_Maps_def
apply (intro ballI)
defer
*)
oops (* FAILURE: needs invariant breakdown *)

(*================================================================================================*)
text {* some lemmas are needed prior to PO_add0_FEAS_a4 *}

(*------------------------------------------------------------------------------------------------*)
lemma PO_add0_FEAS_a4_invbd_state_vals_a1: 
  "eset \<notin> dom (esets st) \<Longrightarrow>
 inv_Vals (the (esets st esetnm)) (ents st)
\<Longrightarrow>
inv_Vals
        (the (esets \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>],
                       rels = rels st, ents = ents st\<rparr>
               esetnm))
        (ents \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
                 ents = ents st\<rparr>)"
oops (* FAILURE: gave up to deal with generalised inv_State_a instead *)
(* This lemmas generates all the others for the invariant subparts *)

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

(* Strategy 3: Tool automation*)
apply (rule TrueI)
done

(*------------------------------------------------------------------------------------------------*)
lemma PO_add0_FEAS_a4_invbd_state_a1: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
(* Strategy 1: invariant zoom *)
unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)

(* Strategy 2: Tool automation - to remove duplicated stuff? No simp though*)
defer
apply simp (* record selector equality --- much beter in Isabelle 2013! *)
apply simp
defer

(* Strategy 3: rippling lemma on inv_Esetmap ? *)
apply (rule PO_add0_FEAS_a4_invbd_state_esetmap_a1)

(* Strategy 4: tool automation? *)
apply (assumption)+

(* Strategy 5: instantiate before state invariant witness prior to conjI to avoid repeated instatiations per goal *)
apply (intro ballI) (* instantiate invariant prior to conjI *)
apply (erule_tac x=esetnm in ballE) (* Iain doesn't like , simp_all, but it works well here. Perhaps use automation strategy? *)

(* Strategy 6: structural breakdown *)
(* neither is satisfactory - to me - so I will try a more agressive one 
apply (intro conjI, elim conjE)
apply (elim conjE, intro conjI)
*)
oops (* FAILURE: user defined; Gave up to try more agressive breakdown *)

lemma PO_add0_FEAS_a4_invbd_state_a2: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
(* Strategy 1: invariant zoom *)
unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)

(* Strategy 2: Tool automation - to remove duplicated stuff? No simp though*)
defer
apply simp (* record selector equality --- much beter in Isabelle 2013! *)
apply simp
defer

(* Strategy 3: rippling lemma on inv_Esetmap ? *)
apply (rule PO_add0_FEAS_a4_invbd_state_esetmap_a1)

(* Strategy 4: tool automation? *)
apply (assumption)+

(* Strategy 5: instantiate before state invariant witness prior to conjI to avoid repeated instatiations per goal *)
apply (intro ballI) (* instantiate invariant prior to conjI *)
apply (erule_tac x=esetnm in ballE) (* Iain doesn't like , simp_all, but it works well here. Perhaps use automation strategy? *)

(* Strategy 6: structural breakdown *)
apply (elim conjE | intro conjI)+
    (* slightly more agressive, yet still suboptimal. The trigger is to avoid needing to
       go through the whole breaking down again. Perhaps this is overkill? But no, we cold
       detect this by the structure (i.e. presence of operators ---\<and>--- on assumption/goal).
     *)

(* Strategy 7: tool automation? FAILED - but simplified record? *)
apply simp
oops (* FAILURE: user defined / complicated record simplification needed?  
                 Gave up to try simplified record inv-breakdown sublemmas *)

(*------------------------------------------------------------------------------------------------*)
text {* Trying sub lemmas for PO_add0_FEAS_a4_invbd_state_a3 *}

(*________________________________________________________________________________________________*)
lemma PO_add0_FEAS_a3_invbd_state_vals_a2: 
  "eset \<notin> dom (esets st) \<Longrightarrow>
   inv_Vals (the (esets st esetnm)) (ents st)
    \<Longrightarrow>
    inv_Vals (the ((esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) esetnm))
        (ents st)"
unfolding inv_Vals_def Let_def

apply (elim conjE, intro conjI)
apply assumption

defer
apply (intro ballI, erule_tac x=eid in ballE)
oops (* FAILURE: need a lemma for the(_ \<union>m _) ; found missing condition on \<union>m *)
     (* TODO: is this a missing condition or a hidden case analsyis? *)

find_theorems "the((_ \<union>m _)_)"

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

lemma PO_add0_FEAS_a3_invbd_state_pairs_a1:
"eset \<notin> dom (esets st) \<Longrightarrow> 
 esetnm \<in> dom (esets st) \<Longrightarrow>
  inv_Pairs (esets st) (rels st) \<Longrightarrow>
       inv_Pairs (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) (rels st)
"
unfolding inv_Pairs_def 
find_theorems "ran(_ \<union>m_)" (* suggests a lemma! *)
oops

lemma l_diff_union: "(A - B) \<union> C = (A \<union> C) - (B - C)"
by (metis Compl_Diff_eq Diff_eq Un_Int_distrib2)

find_theorems "_ \<dagger> _"

lemma l_dagger_ran: "ran(f \<dagger> g) = ran f \<union> ran g"
find_theorems "(_::'a set) = _" -name:VDM name:Set -name:Interval
apply (intro set_eqI iffI)
unfolding ran_def dagger_def
apply simp_all
apply blast

apply (fold dagger_def)
apply (erule disjE)

apply safe
find_theorems "(_ ++ _) _" intro
apply (simp add: l_dagger_apply dom_def)
apply (rule exI)
defer
apply (rule_tac x=a in exI,unfold dagger_def)
apply (metis map_add_find_right)
oops (* Not true actually! *)

lemma l_munion_ran: "dom f \<inter> dom g = {} \<Longrightarrow> ran(f \<union>m g) = ran f \<union> ran g"
apply (unfold munion_def)
apply simp
find_theorems "(_ \<dagger> _) = _"
(*apply (simp add: b_dagger_munion)*)
apply (intro set_eqI iffI)
unfolding ran_def 
thm l_dagger_apply
apply (simp_all add: l_dagger_apply split_ifs)

apply metis
by (metis Int_iff all_not_in_conv domIff option.distinct(1))

lemma  PO_add0_FEAS_a3_invbd_state_ents_a2:
"eset \<notin> dom (esets st) \<Longrightarrow>
inv_Ents (ran (esets st)) (dom (ents st)) \<Longrightarrow>
       inv_Ents (ran (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>])) (dom (ents st))"
unfolding inv_Ents_def 

(*sledgehammer fails*)
apply (simp add: l_munion_ran)
done

(*
lemma PO_add0_FEAS_a3_invbd_state_pairs_a2:
"eset \<notin> dom (esets st) \<Longrightarrow> 
 esetnm \<in> dom (esets st) \<Longrightarrow>
  inv_Pairs (esets st) (rels st) \<Longrightarrow>
       inv_Pairs (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) (rels st)
"
unfolding inv_Pairs_def 
apply (simp add: l_munion_ran)

apply (intro conjI)

apply (metis inv_Esetinf_def inv_Esetmap_def)
(* apply (metis PO_add0_FEAS_a4_invbd_state_esetmap_a1 State_a.select_convs(1)) *)

apply (unfold Let_def, elim conjE, intro ballI)

apply (erule_tac x=reltype in ballE)
apply (elim conjE, intro conjI)

(* Strategy : hidden case analysis on map_union? *)
apply (subgoal_tac "fs reltype \<in> dom (esets st)")

find_theorems "(the((_ \<union>m _)_))"
apply (subst l_the_map_union_left)
  apply assumption
  apply simp
  apply assumption

defer

apply (subgoal_tac "ts reltype \<in> dom (esets st)")
apply (subst l_the_map_union_left)
  apply assumption
  apply simp
  apply assumption

defer

apply simp

FAILURE: The failure hightlighed the missing invariant that (fs reltype) \<in> dom esm!
*)

lemma PO_add0_FEAS_a3_invbd_state_pairs_a3:
"eset \<notin> dom (esets st) \<Longrightarrow> 
 esetnm \<in> dom (esets st) \<Longrightarrow>
  inv_Pairs (esets st) (rels st) \<Longrightarrow>
       inv_Pairs (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) (rels st)
"
unfolding inv_Pairs_def 
apply (simp add: l_munion_ran)

apply (intro conjI)

apply (metis inv_Esetinf_def inv_Esetmap_def)
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

apply (metis inv_Esetinf_def inv_Esetmap_def)
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
find_theorems "dom(_ \<union>m _)" --"NOTE: lovely lemma Iain! thanks"
thm unionm_in_dom_left[of "esetnm" "esets st" "[eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]",simplified]
  (* TODO: should generalise? *)
by (metis l_in_dom_ar l_munion_dom_ar_singleton_subsume singletonE)

(*________________________________________________________________________________________________*)

lemma PO_add0_FEAS_a4_invbd_state_a3: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
(* Strategy 1: invariant zoom *)
unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)

(* Strategy 1: rippling lemma on inv_Esetmap ? *)
apply (rule PO_add0_FEAS_a4_invbd_state_esetmap_a1)

(* Strategy 2: Tool automation - to remove duplicated stuff? No simp though*)
apply assumption
apply assumption
apply simp
apply simp

(* Strategy X: record simplification? TODO: Iain, discuss? *)
apply simp

(* Strategy 3: structural breakdown *)
apply (intro ballI) (* instantiate invariant prior to conjI *)

(* Strategy 4: USER: Here I've spotted the distribution over \<union>m; Will explore *)
find_theorems "dom(_ \<union>m _)" --"NOTE: lovely lemma Iain! thanks"
thm unionm_in_dom_left[of "esetnm" "esets st" "[eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]",simplified]
  (* discovered something: missing condition; generate lemma? 
   *)
  apply (drule PO_add0_FEAS_a4_invbd_state_munion_a1)
  apply assumption

  defer (* extra case missing? *)

(* Strategy 4: instantiate before state invariant witness prior to conjI to avoid repeated instatiations per goal *)
apply (erule_tac x=esetnm in ballE) 
  (* USER: gives the witness *)
  (* Iain doesn't like , simp_all, but it works well here. Perhaps use automation strategy? *)

(* Strategy 5: structural breakdown *)
apply (elim conjE)

(* Strategy 6: Tool automation *)
defer
apply simp
defer

(* Strategy 7: structural breakdown + rippling per goal? *)
apply (intro conjI)

apply (metis PO_add0_FEAS_a3_invbd_state_vals_a3)
apply (metis PO_add0_FEAS_a3_invbd_state_esets_a1)
apply (metis PO_add0_FEAS_a3_invbd_state_pairs_a3)
apply (metis PO_add0_FEAS_a3_invbd_state_ents_a2)

(* Strategy 8: back to munion subgoal? *)
apply (rule notI)
oops (* FAILURE: wrong case analysis on union_in_dom_left? *)

lemma PO_add0_FEAS_a4_invbd_state_a4: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
(* Strategy 1: invariant zoom *)
unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)

(* Strategy 1: rippling lemma on inv_Esetmap ? *)
apply (rule PO_add0_FEAS_a4_invbd_state_esetmap_a1)

(* Strategy 2: Tool automation - to remove duplicated stuff? No simp though*)
apply assumption
apply assumption
apply simp
apply simp

(* Strategy X: record simplification? *)
apply simp

(* Strategy 3: structural breakdown *)
apply (intro ballI) (* instantiate invariant prior to conjI *)

find_theorems simp:"dom(_ \<union>m_)"
apply (simp add: l_munion_dom)

apply (erule disjE)
defer

apply (erule_tac x=esetnm in ballE)
apply (elim conjE, intro conjI)
apply (metis PO_add0_FEAS_a3_invbd_state_vals_a3)

apply (insert PO_add0_FEAS_a3_invbd_state_esets_a1[of "eset" "st"])
apply (simp add: l_munion_dom)

apply (metis PO_add0_FEAS_a3_invbd_state_pairs_a3)
(*apply (metis PO_add0_FEAS_a3_invbd_state_ents_a1)*)

oops (* FAILURE:  (with l_munion_dom) is more complicated *)

lemma PO_add0_FEAS_a4_invbd_state_a5: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
(* Strategy 1: invariant zoom *)
unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)

(* Strategy 1: rippling lemma on inv_Esetmap ? *)
apply (rule PO_add0_FEAS_a4_invbd_state_esetmap_a1)

(* Strategy 2: Tool automation - to remove duplicated stuff? No simp though*)
apply assumption
apply assumption
apply simp
apply simp

(* Strategy X: record simplification? TODO: Iain, discuss? *)
apply simp

(* Strategy 3: structural breakdown *)
apply (intro ballI) (* instantiate invariant prior to conjI *)

(* Strategy 4: USER: Here I've spotted the distribution over \<union>m; Will explore *)
find_theorems "dom(_ \<union>m _)" --"NOTE: lovely lemma Iain! thanks"
thm unionm_in_dom_left[of "esetnm" "esets st" "[eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]",simplified]
  (* discovered something: missing condition; generate lemma? 
  apply (drule PO_add0_FEAS_a4_invbd_state_munion_a1)
  apply assumption
  *)
thm l_munion_dom[of "esets st"  "[eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]",simplified]
apply (simp add: l_munion_dom)

apply (erule disjE)

defer

(* Strategy 4: instantiate before state invariant witness prior to conjI to avoid repeated instatiations per goal *)
apply (erule_tac x=esetnm in ballE) 
  (* USER: gives the witness *)
  (* Iain doesn't like , simp_all, but it works well here. Perhaps use automation strategy? *)

(* Strategy 5: structural breakdown *)
apply (elim conjE)

(* Strategy 6: Tool automation *)
defer
apply simp
defer

(* Strategy 7: structural breakdown + rippling per goal? *)
apply (intro conjI)

apply (metis PO_add0_FEAS_a3_invbd_state_vals_a3)
apply (metis PO_add0_FEAS_a3_invbd_state_esets_simplified_a1)
apply (metis PO_add0_FEAS_a3_invbd_state_pairs_a3)
apply (metis PO_add0_FEAS_a3_invbd_state_ents_a2)

(* FAILURE: missing case where chosen witness is the new one - general lemma from PO_add0_FEAS_a3_invbd_state_vals_a3 *)

apply (intro conjI)

(* VALS is gone *)
unfolding inv_Vals_def Let_def
apply simp
apply (intro conjI)
find_theorems "(the((_ \<union>m_)_))"
apply (simp add: l_the_map_union)+

defer
unfolding inv_Pairs_def Let_def
apply (intro conjI)
apply (metis inv_Esetinf_def inv_Esetmap_def)
apply assumption
defer
apply (simp add: l_munion_ran)
unfolding inv_Ents_def

defer 

apply (subst PO_add0_FEAS_a3_invbd_state_pairs_general_a1)
  apply assumption
  defer
  apply metis

apply (subst PO_add0_FEAS_a3_invbd_state_ents_a2)
  apply assumption

apply (metis PO_add0_FEAS_a3_invbd_state_pairs_general_a1)

unfolding inv_Esets_def (* some stuff is missing here in the invariant for the new element I think? TODO: Leo/Iain ?*)
apply (intro ballI conjI)
unfolding inv_Relmap_def inv_Relinf_def inv_Maps_def (* case analysis on the type of map? *)
oops 

lemma ijw_magic: "dom x \<inter> dom y = {} \<Longrightarrow> a\<in>dom(x \<union>m y) = (a \<in> dom x \<or> a \<in> dom y)"
by (metis domIff l_munion_apply)


lemma PO_add0_FEAS_a4_invbd_state_a6: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
(* Strategy 1: invariant zoom *)
unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)

(* Strategy 1: rippling lemma on inv_Esetmap ? *)
apply (rule PO_add0_FEAS_a4_invbd_state_esetmap_a1)

(* Strategy 2: Tool automation - to remove duplicated stuff? No simp though*)
apply assumption
apply assumption
apply simp
apply simp

(* Strategy X: record simplification? TODO: Iain, discuss? *)
apply simp

(* Strategy 3: structural breakdown *)
apply (intro ballI) (* instantiate invariant prior to conjI *)

(* Strategy 4: USER: Here I've spotted the distribution over \<union>m; Will explore *)
find_theorems "dom(_ \<union>m _)" --"NOTE: lovely lemma Iain! thanks"
thm unionm_in_dom_left[of "esetnm" "esets st" "[eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]",simplified]
  (* discovered something: missing condition; generate lemma? 
  apply (drule PO_add0_FEAS_a4_invbd_state_munion_a1)
  apply assumption
  *)
thm l_munion_dom[of "esets st"  "[eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]",simplified]
apply (simp add: l_munion_dom)

apply (erule disjE)

defer

(* Strategy 4: instantiate before state invariant witness prior to conjI to avoid repeated instatiations per goal *)
apply (erule_tac x=esetnm in ballE) 
  (* USER: gives the witness *)
  (* Iain doesn't like , simp_all, but it works well here. Perhaps use automation strategy? *)

(* Strategy 5: structural breakdown *)
apply (elim conjE)

(* Strategy 6: Tool automation *)
defer
apply simp
defer

(* Strategy 7: structural breakdown + rippling per goal? *)
apply (intro conjI)

apply (metis PO_add0_FEAS_a3_invbd_state_vals_a3)
apply (metis PO_add0_FEAS_a3_invbd_state_esets_simplified_a1)
apply (metis PO_add0_FEAS_a3_invbd_state_pairs_a3)
apply (metis PO_add0_FEAS_a3_invbd_state_ents_a2)

(* FAILURE: missing case where chosen witness is the new one - general lemma from PO_add0_FEAS_a3_invbd_state_vals_a3 *)

apply (intro conjI)

defer
apply (unfold inv_Esets_def)
apply (intro ballI conjI)
apply (erule_tac x=reltype in ballE)
apply (elim conjE)
apply (metis insert_iff)

apply (rule ballI)
oops (* FAILURE: a hidden case analysis on dom esets (or esets being empty) to enable 
                 discharging the update case.

                 the lack of precondition information is the clue/hint to why you need
                 to think / suggest a hidden case analysis (or a bad / weak model).

                 Map union leads case split on dom(LHS \<union>m RHS)
                 this leads to the dom LHS \<or> dom RHS
                 this leads to two cases: LHS comes from the inv
                 the RHS is the update we need to finish
                 the precondition doesn't offer anything to help
                 the update with empty connections does not break the inv (almost trivially)
                 it's about explicitly expressing that within the original invariant
                 and that establishes a contradiction.

                 Perhaps we don't need the dom(_ \<union>m _) at all and just the contraction?
                 an over complication? Let's try
      *)


lemma PO_add0_FEAS_a4_invbd_state_a7: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
apply (cases "(esets st) = empty") 
  find_theorems "empty \<union>m _"
  apply (simp add: l_munion_empty_lhs)
  
  apply (unfold inv_State_a_def Let_def)
  apply simp_all

  apply (elim conjE, intro conjI)

  apply (metis inv_Esetinf_def inv_Esetmap_def)
  apply (metis Esetinf.select_convs(4) equals0D inv_Vals_def subsetI)


  defer
  unfolding inv_Pairs_def Let_def
  apply (intro conjI)
  apply (metis inv_Esetinf_def inv_Esetmap_def)
  apply assumption
  apply (intro ballI conjI)
  apply simp_all

  defer
  defer
  unfolding are_membs_def froms_def tos_def
  apply (intro impI conjI)
  apply (metis inv_Esetinf_def)
  apply simp (* AHA! What's going on? *)
  unfolding inv_Esets_def
  apply (intro ballI conjI, simp_all)
  unfolding inv_Relmap_def inv_Relinf_def inv_Maps_def
oops

lemma PO_add0_FEAS_a4_invbd_state_a8: 
  "inv_State_a st \<Longrightarrow>
       eset \<notin> dom (esets st) \<Longrightarrow>
       inv_State_a
        \<lparr>esets = esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>], rels = rels st,
           ents = ents st\<rparr>"
apply (cases "(esets st) = empty") 
apply (cases "(rels st) = empty") 
  find_theorems "empty \<union>m _"
  apply (simp add: l_munion_empty_lhs)
  
  apply (unfold inv_State_a_def Let_def)
  apply simp_all

  apply (elim conjE, intro conjI)

  apply (metis inv_Esetinf_def inv_Esetmap_def)
  apply (metis Esetinf.select_convs(4) equals0D inv_Vals_def subsetI)

  apply (unfold inv_Esets_def)
  apply blast

  apply (unfold inv_Pairs_def Let_def)
  apply (intro conjI)
  apply (metis inv_Esetinf_def inv_Esetmap_def)
  apply assumption
  apply blast

  apply (unfold inv_Ents_def)
  apply simp
oops

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
apply (simp add: PO_add0_FEAS_a4_invbd_state_a5)
done

(*print_syntax*)

end
