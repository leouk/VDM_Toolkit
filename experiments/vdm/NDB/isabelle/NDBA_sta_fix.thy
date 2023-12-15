theory NDBA_sta_fix
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
            invVals (the(esm esetnm)) em) \<and>
          invEsets (dom esm) (dom rm) \<and>
            invPairs esm rm \<and>
            invEnts (ran esm) (dom em))"

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

lemma PO_ADDA_fsb_st_maxtyp: 
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
      apply(rule l_indom_munion_in_map)
       apply (erule_tac x=reltype in ballE, simp+)
      apply(rule l_indom_munion_in_map)
       apply (erule_tac x=reltype in ballE, simp+)
    done

lemma PO_ADDA_fsb_1_sta_upd_invPairs:
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> 
    invPairs (esets (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>))
        (rels (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>))"
    unfolding inv_State_a_def invPairs_def Let_def
  apply (simp )
    apply (elim conjE, intro conjI ballI) 
    unfolding inv_Esetmap_def
        apply (simp add: l_vdmmap_inv_munion_dist)
        apply (rule l_vdmmap_inv_singleton)
         apply simp
    apply (simp add: inv_Esetinf_def)
      apply(rule l_indom_munion_in_map)
       apply (erule_tac x=reltype in ballE, simp+)
      apply(rule l_indom_munion_in_map)
  (* This one surprised me *)
    apply (simp add: l_the_map_union)+
    done

lemma l_vdm_dunion_bigunion_eq: "(\<Union> x \<in> S. P x) = \<Union> {P x | x . x \<in> S}"
  apply (intro equalityI subsetI)
   apply (simp, safe)
  apply (rule_tac x="P xa" in exI, simp)
  apply (rule_tac x="xa" in exI, simp)
   apply (simp)
  apply (rule_tac x="xa" in bexI, simp_all)
  done

lemma PO_ADDA_fsb_1_sta_upd_invEnts: 
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> 
        invEnts (ran (esets (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)))
        (dom (ents (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>)))
 "
 unfolding inv_State_a_def invEnts_def  Let_def
  apply (simp )
  apply (elim conjE, intro conjI ballI) 
   apply (simp add: l_vdmmap_ran_munion_dist inv_Esetinf_def)+
  apply (erule subst)
  apply (intro equalityI subsetI)
  apply (simp, elim bexE)
  apply (rule_tac x="xa" in bexI, simp)
  apply (smt (verit) Esetinf.select_convs(4) Int_emptyI emptyE l_map_dom_ran l_munion_apply l_ranE_frule option.sel ranI)
  by (metis Sup_insert Un_iff domIff image_insert k_munion_map_upd_wd l_munion_upd ran_map_upd)

lemma PO_ADDA_fsb_1_sta_upd_invVals:
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> esetnm\<in>dom (esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) \<Longrightarrow>
    invVals
        (the (esets (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>) esetnm))
        (ents (st\<lparr>esets := esets st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]\<rparr>))"
  unfolding inv_State_a_def invVals_def Let_def
  apply simp
  apply (elim conjE)
  apply (simp add: l_munion_apply l_munion_dom)
   apply (elim disjE, intro conjI impI ballI)
        apply (simp add: inv_Esetinf_def)
  using inv_State_a_0_def by blast+

lemma PO_ADDA_fsb_1_sta_upd: 
  "inv_State_a st \<Longrightarrow> eset \<notin> dom (esets st) \<Longrightarrow> inv_State_a (ADDA_explicit eset s p w st)" 
  unfolding ADDA_explicit_def inv_State_a_def Let_def 
  apply (elim conjE, intro conjI)
      apply (simp add: PO_ADDA_fsb_st_maxtyp)
     apply (intro ballI conjI)
  using PO_ADDA_fsb_1_sta_upd_invVals inv_State_a_def apply auto[1]
  using PO_ADDA_fsb_1_sta_upd_invEsets inv_State_a_def apply presburger
  using PO_ADDA_fsb_1_sta_upd_invPairs inv_State_a_def apply presburger
  using PO_ADDA_fsb_1_sta_upd_invEnts inv_State_a_def apply presburger
  done

theorem PO_ADDA_fsb
  unfolding PO_ADDA_fsb_def
  apply (intro allI impI)
  apply (rule_tac x="ADDA_explicit eset s p w st" in exI)
  unfolding ADDA_post_def ADDA_pre_def
  apply (elim conjE, intro conjI)
   apply (simp add: PO_ADDA_fsb_1_sta_upd)
  unfolding ADDA_explicit_def by simp

end
