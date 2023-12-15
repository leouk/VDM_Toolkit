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
  (* hidden case analysis on empty esets! *)
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

lemma PO_ADDA_fsb_l1_1: 
   "inv_State_a_0 st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> inv_State_a_0 (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)" 
  unfolding inv_State_a_0_def
  apply simp
  unfolding inv_Esetmap_def
  find_theorems "inv_VDMMap _ _ (_ \<union>m _)"
  apply (simp add: l_vdmmap_inv_munion_dist)
  apply (rule l_vdmmap_inv_singleton, simp)
  unfolding inv_Esetinf_def 
  by simp

lemma PO_ADDA_fsb_1_sta_upd_invEsets:
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> 
     invEsets
        (dom (esets (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)))
        (dom (rels (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)))
"   
    unfolding inv_State_a_def invEsets_def Let_def
  apply (simp add: l_vdmmap_dom_munion_dist)
    apply (elim conjE, intro conjI ballI)  
    using inv_Esetmap_def inv_State_a_0_def inv_VDMMap_def apply blast
    using inv_Relmap_def inv_State_a_0_def inv_VDMMap_def apply blast
     apply (rule l_indom_munion_in_map)
      defer 
        apply assumption
     apply (rule l_indom_munion_in_map)
      defer 
      apply assumption
     apply (erule ballE, elim conjE)
    (* Here we get the annoying bit of quantifiers in the way *)
      apply (erule_tac x=reltype in ballE, simp+)
    oops

lemma l_nonempty_dom_conv:
  "dom m \<noteq> {} \<longleftrightarrow> (\<exists> x . x \<in> dom m)"
  by blast

lemma PO_ADDA_fsb_1_sta_upd_invEsets:
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> 
     invEsets
        (dom (esets (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)))
        (dom (rels (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)))
"   
    unfolding inv_State_a_def invEsets_def Let_def
  apply (simp add: l_vdmmap_dom_munion_dist)
    apply (elim conjE, intro conjI ballI)  
    using inv_Esetmap_def inv_State_a_0_def inv_VDMMap_def apply blast
    using inv_Relmap_def inv_State_a_0_def inv_VDMMap_def apply blast
    (* Here we get the annoying bit of quantifiers in the way *)
    apply (cases "dom (esets st) = {}", simp)
      defer
    apply (simp add: l_map_non_empty_has_elem_conv l_map_non_empty_dom_conv)
      apply (erule exE)
      apply(rule l_indom_munion_in_map)
     apply (erule_tac x=x in ballE, elim conjE)
       apply (erule_tac x=reltype in ballE, simp+)

         apply (cases "dom (esets st) = {}", simp)
      defer
    apply (simp add: l_map_non_empty_has_elem_conv l_map_non_empty_dom_conv)
      apply (erule exE)
      apply(rule l_indom_munion_in_map)
     apply (erule_tac x=x in ballE, elim conjE)
        apply (erule_tac x=reltype in ballE, simp+)
    (* UNPROVABLE! Needs to change the invariant! Nice one *)
    sorry

lemma PO_ADDA_fsb_1_sta_upd_invPairs:
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> 
    invPairs (esets (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>))
        (rels (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>))"
  sorry 

lemma PO_ADDA_fsb_1_sta_upd_invEnts: 
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> 
        invEnts (ran (esets (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)))
        (dom (ents (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)))
 "
  sorry

lemma PO_ADDA_fsb_1_sta_upd_invVals:
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> 
    invVals
        (the (esets (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>) esetnm))
        (ents (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>))"
  sorry 

lemma PO_ADDA_fsb_1_sta_upd: 
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> inv_State_a (ADDA_explicit eset s p w st)" 
  unfolding ADDA_explicit_def inv_State_a_def Let_def 
  apply (elim conjE, intro conjI)
      apply (simp add: PO_ADDA_fsb_l1_1)
  apply (intro ballI conjI)
  using PO_ADDA_fsb_1_sta_upd_invEsets inv_State_a_def apply presburger
  using PO_ADDA_fsb_1_sta_upd_invPairs inv_State_a_def apply presburger
  using PO_ADDA_fsb_1_sta_upd_invEnts inv_State_a_def apply presburger
  using PO_ADDA_fsb_1_sta_upd_invVals inv_State_a_def apply presburger
  done

theorem PO_ADDA_fsb
  unfolding PO_ADDA_fsb_def
  thm exI[of _ "ADDA_explicit eset s p w st"]
  apply (intro allI impI)
  apply (rule_tac x="ADDA_explicit eset s p w st" in exI)
  unfolding ADDA_post_def ADDA_pre_def
  apply (elim conjE, intro conjI)
   apply (simp add: PO_ADDA_fsb_1_sta_upd)
  unfolding ADDA_explicit_def by simp

end
