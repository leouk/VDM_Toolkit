theory NDBA
imports "VDMToolkit"
begin

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

definition
  inv_Esetinf :: "Esetinf \<Rightarrow> \<bool>"
where
  "inv_Esetinf esetinf \<equiv> finite (membs esetinf)"  

record Reltype =
  fs :: Esetnm 
  nm :: "(Relnm option)"
  ts :: Esetnm

definition
  inv_Reltype :: "Reltype \<Rightarrow> \<bool>"
where
  "inv_Reltype rt \<equiv> inv_Option inv_True (nm rt)"  (* Notihng for now *)

datatype Maptype = OneOne | OneMany | ManyOne | ManyMany 

record Pair =
  fv :: Eid
  tv :: Eid

record Relinf0 =
  map   :: Maptype
  conns :: "Pair set"

definition
  inv_Relinf0 :: "Relinf0 \<Rightarrow> \<bool>"
where
  "inv_Relinf0 r \<equiv> finite (conns r)"

definition
  invMaps :: "Relinf0 \<Rightarrow> \<bool>"
where
  [intro!] : 
  "invMaps r \<equiv> (case (map r) of 
                    ManyMany \<Rightarrow> True |
                    ManyOne  \<Rightarrow> \<not> (\<exists> pr1 \<in> (conns r) . \<exists> pr2 \<in> (conns r) . pr1 \<noteq> pr2 \<and> (fv pr1) = (fv pr2)) |
                    OneMany  \<Rightarrow> \<not> (\<exists> pr1 \<in> (conns r) . \<exists> pr2 \<in> (conns r) . pr1 \<noteq> pr2 \<and> (tv pr1) = (tv pr2)) |
                    OneOne   \<Rightarrow> \<not> (\<exists> pr1 \<in> (conns r) . \<exists> pr2 \<in> (conns r) . pr1 \<noteq> pr2 \<and> ((fv pr1) = (fv pr2) \<or> (tv pr1) = (tv pr2)))
                   )"
                   (* Maybe this deserve a better formatting ? Make it an intro rule? *)

definition
  inv_Relinf :: "Relinf0 \<Rightarrow> \<bool>"
where
  "inv_Relinf r \<equiv> inv_Relinf0 r \<and> invMaps r"

(* Because of type invariant on Relinf*)
type_synonym Relmap  = "Reltype \<rightharpoonup> Relinf0"
type_synonym Esetmap = "Esetnm \<rightharpoonup> Esetinf"
type_synonym Eidmap  = "Eid \<rightharpoonup> Value option"

definition
  inv_Relmap :: "Relmap \<Rightarrow> \<bool>"
where
  "inv_Relmap rm \<equiv> inv_VDMMap inv_Reltype inv_Relinf rm"

definition
  inv_Esetmap :: "Esetmap \<Rightarrow> \<bool>"
where
  "inv_Esetmap esm \<equiv> inv_VDMMap inv_True inv_Esetinf esm"

definition
  inv_Eidmap :: "Eidmap \<Rightarrow> \<bool>"
where
  "inv_Eidmap eidm \<equiv> inv_VDMMap inv_True (inv_Option inv_True) eidm"

record State_a = 
  esets :: Esetmap
  rels  :: Relmap
  ents  :: Eidmap

definition
  inv_State_a_0 :: "State_a \<Rightarrow> \<bool>"
where
  "inv_State_a_0 s \<equiv> inv_Esetmap (esets s) \<and> inv_Relmap (rels s) \<and> inv_Eidmap (ents s)" 

definition
  pictureMatch :: "Value option \<Rightarrow> Picture \<Rightarrow> \<bool>"
where
  "pictureMatch ev p \<equiv> ev \<noteq> None"

definition
  invVals :: "Esetinf \<Rightarrow> Eidmap \<Rightarrow> \<bool>"
where
  "invVals esi em \<equiv> 
      inv_Esetinf esi \<and> inv_Eidmap em \<and>
      (membs esi) \<subseteq> dom em \<and>
      (\<forall> eid \<in> (membs esi) . pictureMatch (the(em eid)) (picture esi))"

definition
  invEsets :: "Esetnm set \<Rightarrow> Reltype set \<Rightarrow> \<bool>"
where
  "invEsets esetnms em \<equiv> 
      inv_VDMSet' inv_True esetnms \<and>
      inv_VDMSet' inv_Reltype em \<and>
      (\<forall> reltype \<in> em . (fs reltype) \<in> esetnms \<and> (ts reltype) \<in> esetnms)"

definition
  are_membs :: "Eid set \<Rightarrow> Esetinf \<Rightarrow> \<bool>"
where
  "are_membs eset esetinf \<equiv> 
      inv_VDMSet' inv_True eset \<and>
      inv_Esetinf esetinf \<and> 
      eset \<subset> (membs esetinf)"

definition 
  froms :: "Pair set \<Rightarrow> Eid set"
where
  "froms prset \<equiv> { (fv pr) | pr . pr \<in> prset \<and> finite prset }"
  (* Given Pair has no invariant, can aford to simplify here *)

definition 
  tos :: "Pair set \<Rightarrow> Eid set"
where
  "tos prset \<equiv> { (tv pr) | pr . pr \<in> prset \<and> finite prset }"

definition
  invPairs :: "Esetmap \<Rightarrow> Relmap \<Rightarrow> \<bool>"
where
  "invPairs esm rm \<equiv> 
      inv_Esetmap esm \<and>
      inv_Relmap rm \<and> 
      (\<forall> reltype \<in> dom rm . 
          (let f = (fs reltype); 
               t = (ts reltype); 
               prset = (conns (the(rm reltype))) 
           in 
              f \<in> dom esm \<and> t \<in> dom esm \<and> 
              are_membs (froms prset) (the(esm f)) \<and> 
              are_membs (tos prset)   (the(esm t)) 
           )
      )"

definition
  invEnts :: "Esetinf set \<Rightarrow> Eid set \<Rightarrow> \<bool>"
where
  "invEnts esetinfs eids \<equiv> 
      inv_VDMSet' inv_Esetinf esetinfs \<and> 
      inv_VDMSet' inv_True esetinfs \<and> 
      (\<Union> esetinf \<in> esetinfs . (membs esetinf)) = eids"

definition
  inv_State_a :: "State_a \<Rightarrow> \<bool>"
where
  "inv_State_a s \<equiv> 
      inv_State_a_0 s \<and> 
      (let esm = esets s; 
           rm  = rels s; 
           em  = ents s 
       in 
          (\<forall> esetnm \<in> dom esm .
            invEsets (dom esm) (dom rm) \<and>
            invPairs esm rm \<and>
            invEnts (ran esm) (dom em) \<and>
            invVals (the(esm esetnm)) em))"

thm atomize_ball

lemma narrow_ball: "(\<forall> x \<in> S . Q \<and> P x) = (S = {} \<or> ((\<forall> x \<in> S . P x) \<and> Q))"
by (metis (full_types) empty_iff equals0I)

lemma l_trivial_vdmset[simp]: "inv_VDMSet' invt {}" 
  by (simp add: inv_VDMSet'_def)

lemma l_trivial_vdmmap[simp]: "inv_VDMMap invd invr Map.empty"
  by (simp add: inv_VDMMap_def)

lemma l1: "(rels s) = Map.empty \<Longrightarrow> invEsets {} (dom (rels s))" 
  unfolding invEsets_def inv_Relmap_def inv_VDMMap_def
  by (clarsimp)

lemma l2: "(ents s) = Map.empty \<Longrightarrow> invEnts {} (dom (ents s))" 
  unfolding invEnts_def
  by (simp)
 
lemma l3: "(rels s) = Map.empty \<Longrightarrow> invPairs Map.empty (rels s)" 
  unfolding invPairs_def inv_Esetmap_def inv_Relmap_def
  by simp

(* NOTE: move invariants out of \<forall>, where possible *)
lemma inv_State_a_rule: 
  "inv_State_a s 
   = 
   (inv_State_a_0 s \<and> 
    invEsets (dom (esets s)) (dom (rels s)) \<and>
    invPairs (esets s) (rels s) \<and>
    invEnts (ran (esets s)) (dom (ents s)) \<and>
    (\<forall> esetnm \<in> dom (esets s) . invVals (the((esets s) esetnm)) (ents s)))"
  unfolding inv_State_a_def Let_def 
  apply (intro iffI, simp_all)
  apply (elim conjE)
  apply (cases "dom (esets s) \<noteq> {}")
   apply (simp add: l_map_non_empty_has_elem_conv, elim exE)
   apply (erule_tac x=x in ballE, simp_all)
  apply (cases "dom (rels s) \<noteq> {}")
  apply (cases "dom (ents s) \<noteq> {}")
   defer 
  apply simp_all
   apply (simp add: l_map_non_empty_has_elem_conv, elim exE)
  unfolding inv_State_a_0_def 
    apply (clarsimp, safe)
  oops
  

definition
  ADDA_pre :: "Esetnm \<Rightarrow> Status \<Rightarrow> Picture \<Rightarrow> Width \<Rightarrow> State_a \<Rightarrow> \<bool>"
where
  "ADDA_pre eset _ _ _ st \<equiv> inv_State_a st \<and> eset \<notin> dom (esets st)"

definition
  ADDA_post :: "Esetnm \<Rightarrow> Status \<Rightarrow> Picture \<Rightarrow> Width \<Rightarrow> State_a \<Rightarrow> State_a \<Rightarrow> \<bool>"
where
  "ADDA_post eset s p w st st' \<equiv> 
      inv_State_a st' \<and> 
      (esets st') = (esets st) \<union>m [ eset \<mapsto> \<lparr> status = s, picture = p, width = w, membs = {} \<rparr>]"

definition 
  PO_ADDA_fsb :: "\<bool>"
where
  "PO_ADDA_fsb \<equiv> (\<forall> st eset s p w . ADDA_pre eset s p w st \<longrightarrow> 
                        (\<exists> st' .  ADDA_post eset s p w st st'))"

definition 
  ADDA_explicit:: "Esetnm \<Rightarrow> Status \<Rightarrow> Picture \<Rightarrow> Width \<Rightarrow> State_a \<Rightarrow> State_a" 
where 
  "ADDA_explicit eset s p w st \<equiv> 
      st\<lparr> esets := (esets st) \<union>m [ eset \<mapsto> \<lparr> status = s, picture = p, width = w, membs = {} \<rparr>]\<rparr>"

lemma PO_ADDA_fsb_l1: 
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> inv_State_a (ADDA_explicit eset s p w st)" 
  unfolding ADDA_explicit_def inv_State_a_def Let_def 
  apply simp

theorem PO_ADDA_fsb
  unfolding PO_ADDA_fsb_def
  thm exI[of _ "ADDA_explicit eset s p w st"]
  apply (intro allI impI)
  apply (rule_tac x="ADDA_explicit eset s p w st" in exI)
  unfolding ADDA_post_def ADDA_pre_def
  apply (elim conjE, intro conjI)
   apply (simp add: PO_ADDA_fsb_l1)
  unfolding ADDA_explicit_def by simp

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
   (metis Esetinf.select_convs(4) State_a.select_convs(1) finite.emptyI fun_upd_same k_munion_map_upd_wd l_inmapupd_dom_iff l_munion_upd l_the_map_union option.sel)

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

lemma \<open>\<forall> r . inv_RelinfM r \<longrightarrow> inv_Relinf r\<close>
  apply (intro allI impI)
  unfolding inv_RelinfM_def inv_Relinf_def
  apply simp
  oops

end
