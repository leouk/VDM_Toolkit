theory NDBa
imports "../../../heap/HEAP/VDMMaps"
begin

(* Introduce the arbitrary types that have not been instantiated
   at the abstract level of NDB 
   
   Question: can these be introduced as parameters of some modeule structure?
   Like a locale or a class?
*)

typedecl ndba_status  (* determines whether or not entities can be added to 
                         or deleted from a set *)
typedecl ndba_picture (* details the format of the values of the member entities *)
typedecl ndba_width   (* used for outputting values *)
typedecl ndba_eid     (* entity identifier type *)
typedecl ndba_esetnm  (* entity set name type *)
typedecl ndba_relnm   (* relation name type *)
typedecl ndba_value   (* type of the values of entity members
                            Q: is 'nil' to be defined as a specific value of this 
                            type?
                      *) 

record ndba_pair =
  fv :: ndba_eid
  tv :: ndba_eid

(* Type for the maps *)
datatype ndba_maptype = OneOne | OneMany | ManyOne | ManyMany

(* The relation info record consists of... *)
record ndba_relinf =
  map :: "ndba_maptype"                (* The type of relation map *)
  conns :: "ndba_pair set" (* A set of entity identifier pairs 
                                          describing the connections 
                                        *)

definition ndba_inv_relinf :: "ndba_relinf \<Rightarrow> bool"
 where "ndba_inv_relinf relinf \<equiv> let prset = conns(relinf) in
         (case (map relinf) of 
            ManyMany \<Rightarrow> True |
            ManyOne  \<Rightarrow> \<not> (\<exists> pr1 \<in> prset . \<exists> pr2 \<in> prset . pr1 \<noteq> pr2 \<and> (fv pr1) = (fv pr2)) |
            OneMany  \<Rightarrow> \<not> (\<exists> pr1 \<in> prset . \<exists> pr2 \<in> prset . pr1 \<noteq> pr2 \<and> (tv pr1) = (tv pr2)) |
            OneOne   \<Rightarrow> \<not> (\<exists> pr1 \<in> prset . \<exists> pr2 \<in> prset . pr1 \<noteq> pr2 \<and> ((fv pr1) = (fv pr2) \<or> (tv pr1) = (tv pr2)))
         )"


(* The relationship type record consists of... *)
record ndba_reltype =
   fs :: ndba_esetnm  (* The from entity set *) 
   nm :: "ndba_relnm option"   (* An optional name for the relationship *)
   ts :: ndba_esetnm  (*The to entity set *)
(* NOTE: using isabelle optional type; though, perhaps need it more as a value? *)

(* The entity set information records consists of ... *)
record ndba_esetinf =
  status :: ndba_status     (* A status *)
  picture :: ndba_picture   (* The picture *)
  width :: ndba_width       (* The width *)
  membs :: "ndba_eid set"   (* A set of member entities *)


type_synonym ndba_esets =  "ndba_esetnm \<rightharpoonup> ndba_esetinf"
type_synonym ndba_reltypes =  "ndba_reltype \<rightharpoonup> ndba_relinf"
type_synonym ndba_ents =  "ndba_eid \<rightharpoonup> ndba_value option" (* option-option here! *)

definition ndba_inv_reltypes :: "ndba_reltypes \<Rightarrow> bool"
where "ndba_inv_reltypes reltypes \<equiv>
           \<forall> reltype \<in> dom reltypes. ndba_inv_relinf (the (reltypes(reltype)))"

(* The abstract (level 0) state of ndb consists ...*)
record ndba_state =
    esets_map :: ndba_esets (* an entity sets map *)
    rels_map  :: ndba_reltypes (* A relationships map *)
    ents_map  :: ndba_ents (* A eid-value map 
                                              (where value is optional) *)

(* Let's now define some auxilliary functions: *)

(* Checks if a set of entities are in an entityset *)
definition are_membs :: "ndba_eid set \<Rightarrow> ndba_esetinf \<Rightarrow> bool"
where "are_membs eset esetinf \<equiv> eset \<subset> membs(esetinf)"

definition froms :: "ndba_pair set \<Rightarrow> ndba_eid set"
  where "froms prset = {fv(pr)| pr . pr \<in> prset }"

definition tos :: "ndba_pair set \<Rightarrow> ndba_eid set"
  where "tos prset = {tv(pr)| pr . pr \<in> prset }"

(* Not defined in the specification! *)
primrec picturematch :: "(ndba_value option) \<Rightarrow> ndba_picture \<Rightarrow> bool"
where "picturematch None _ = False"
    | "picturematch (Some val) pic = True" (* This is kind of arbitrary 
                                              at the moment, since no 
                                              information about types exists. 
                                           *)


(* Question: perhaps create some further type synonyms? to simplify this? Yes! *)
definition ndba_inv_vals :: "ndba_esetinf \<Rightarrow> ndba_ents \<Rightarrow> bool"
  where "ndba_inv_vals esetinf em \<equiv> \<forall> eid \<in> membs(esetinf). 
                                       eid \<in> dom em \<and>  
                                      picturematch (the(em(eid))) (picture esetinf)"
(* the (em(eid)) required as the map presents an optional type.
  The question is which of the two possiblities was intended:
    a) the invarant should also check that the entity ids are included in the map
       directly
    b) or whether picturematch should take (ndba_value option) option as a type

For now, we take the former... 
 
 *)

(* Typo in inv-esets in book *)
definition ndba_inv_esets :: "ndba_esetnm set \<Rightarrow> ndba_reltype set \<Rightarrow> bool"
  where "ndba_inv_esets esetnms reltypes \<equiv> \<forall> reltype \<in> reltypes .
                              fs(reltype) \<in> esetnms \<and> ts(reltype) \<in> esetnms"



definition ndba_inv_pairs :: "ndba_esets \<Rightarrow> ndba_reltypes \<Rightarrow> bool"
where "ndba_inv_pairs esets reltypes \<equiv> 
          \<forall> reltype\<in>dom reltypes. 
            let prset = conns(the(reltypes(reltype)))
          in (fs reltype) \<in> dom esets \<and> (are_membs (froms prset) (the (esets (fs reltype)))
           \<and> are_membs (tos prset) (the (esets (fs reltype))))"
(* Was missing the explicit condition that fs(reltype) \<in> esets.
   This comes, however, from inv_esets in general...
   Temporary decision: stop adding too many extra conditions;
   modify above, as well.
 *)

definition ndba_inv_ents :: "ndba_esetinf set \<Rightarrow> ndba_eid set \<Rightarrow> bool"
where "ndba_inv_ents esetinfs eids \<equiv> 
   let ents = (\<Union> esetinf \<in> esetinfs. membs esetinf)
   in ents = eids"

definition ndba_inv_state :: "ndba_state \<Rightarrow> bool"
  where "ndba_inv_state s \<equiv> ndba_inv_reltypes (rels_map(s)) (* Type invariant *)
                       \<and> (\<forall> esetnm \<in> dom (esets_map s). 
                            ndba_inv_vals (the (esets_map(s) esetnm)) (ents_map(s))) \<and>
                            ndba_inv_esets (dom (esets_map s)) (dom (rels_map s)) \<and> 
                            ndba_inv_pairs (esets_map s) (rels_map s) \<and>
                            ndba_inv_ents (ran (esets_map s)) (dom (ents_map s))"

(* Now, let's state the feasibility proof obligation *)

definition
  ndba_add_pre :: "ndba_state \<Rightarrow> ndba_esetnm \<Rightarrow> ndba_status \<Rightarrow> ndba_picture \<Rightarrow> ndba_width \<Rightarrow> bool"
where
  "ndba_add_pre st eset _ _ _ \<equiv> eset \<notin> dom (esets_map st)"

locale ndba_basic =
    fixes st :: ndba_state
    (* Any more fixed variables? Or general assumptions? *)
    assumes ndba_invariant : "ndba_inv_state st" 

locale ndba_add = ndba_basic +
    fixes eset :: ndba_esetnm
      and s    :: ndba_status
      and p    :: ndba_picture
      and w    :: ndba_width
    assumes ndba_add_precondition: "ndba_add_pre st eset s p w"
    

definition
  ndba_add_post ::"ndba_state \<Rightarrow> ndba_esetnm \<Rightarrow> ndba_status \<Rightarrow> ndba_picture \<Rightarrow> ndba_width \<Rightarrow> ndba_state \<Rightarrow> bool"
where
  "ndba_add_post st eset s p w st' \<equiv> 
                                 (esets_map st') = (esets_map st) \<union>m 
                                 [ eset \<mapsto> \<lparr> status = s, picture = p, width = w, membs = {} \<rparr>]"

definition (in ndba_add) 
  ndba_add_postcondition :: "ndba_state \<Rightarrow> bool"
    where "ndba_add_postcondition st' \<equiv> ndba_add_post st eset s p w st'"

definition (in ndba_add)
  PO_ndba_add_feas :: "bool"
where
  "PO_ndba_add_feas \<equiv> (\<exists> st' . ndba_add_postcondition st' \<and> ndba_inv_state st')"


(* Auxilliary lemmas: Invariant *)


lemma ndba_inv_state_esets_weaken: "ndba_inv_state st \<Longrightarrow> ndba_inv_esets (dom (esets_map st)) (dom (rels_map st))"
  unfolding ndba_inv_state_def by simp

lemma ndba_inv_state_pairs_weaken: "ndba_inv_state st \<Longrightarrow> ndba_inv_pairs  (esets_map st) (rels_map st)"
  unfolding ndba_inv_state_def by simp

lemma ndba_inv_state_ents_weaken: "ndba_inv_state st \<Longrightarrow> ndba_inv_ents (ran (esets_map st)) (dom (ents_map st))"
  unfolding ndba_inv_state_def by simp

lemma ndba_inv_state_reltypes_weaken: "ndba_inv_state st \<Longrightarrow> ndba_inv_reltypes (rels_map st)"
  unfolding ndba_inv_state_def by simp

lemma ndba_inv_state_vals_weaken: "ndba_inv_state st \<Longrightarrow> (\<forall> esetnm \<in> dom (esets_map st). 
                            ndba_inv_vals (the (esets_map(st) esetnm)) (ents_map(st)))"
  unfolding ndba_inv_state_def by simp

lemma ndba_inv_state_vals_weaken_esets: "ndba_inv_state st \<Longrightarrow> esetnm \<in> dom (esets_map st) \<Longrightarrow> 
                ndba_inv_vals (the (esets_map(st) esetnm)) (ents_map(st))"
  unfolding ndba_inv_state_def by simp
              
lemma ndba_inv_stateE[elim!]: "ndba_inv_state st \<Longrightarrow> (ndba_inv_esets (dom (esets_map st)) (dom (rels_map st))
                                        \<Longrightarrow> ndba_inv_pairs  (esets_map st) (rels_map st)
                                        \<Longrightarrow> ndba_inv_ents (ran (esets_map st)) (dom (ents_map st))
                                        \<Longrightarrow> ndba_inv_reltypes (rels_map st)
                                        \<Longrightarrow> (\<forall> esetnm \<in> dom (esets_map st). 
                                          ndba_inv_vals (the (esets_map(st) esetnm)) (ents_map(st)))  
                                       \<Longrightarrow> R) \<Longrightarrow> R"
  unfolding ndba_inv_state_def by simp

lemma ndba_inv_stateI[intro!]: "ndba_inv_esets (dom (esets_map st)) (dom (rels_map st))
                                        \<Longrightarrow> ndba_inv_pairs  (esets_map st) (rels_map st)
                                        \<Longrightarrow> ndba_inv_ents (ran (esets_map st)) (dom (ents_map st))
                                        \<Longrightarrow> ndba_inv_reltypes (rels_map st)
                                        \<Longrightarrow> (\<forall> esetnm \<in> dom (esets_map st). 
                                          ndba_inv_vals (the (esets_map(st) esetnm)) (ents_map(st)))
                                       \<Longrightarrow> ndba_inv_state st"
unfolding ndba_inv_state_def by simp

(* Intro and elim rules for individual components of invariant *)
lemma ndba_inv_esetsI[intro!]: "(!!reltype. reltype \<in> rels  \<Longrightarrow> fs reltype \<in> esets \<and> ts reltype \<in> esets )
                          \<Longrightarrow> ndba_inv_esets esets rels"
 unfolding ndba_inv_esets_def by (simp) 

lemma ndba_inv_pairsI[intro!]: " (!!reltype. reltype \<in> (dom rels) \<Longrightarrow> fs reltype \<in> dom esets) \<Longrightarrow> (!!reltype. reltype \<in> (dom rels) \<Longrightarrow> 
                        are_membs (froms (conns (the (rels reltype)))) (the (esets (fs reltype)))) \<Longrightarrow> 
                      (!!reltype. reltype \<in> (dom rels) \<Longrightarrow> are_membs (tos (conns (the (rels reltype)))) (the (esets (fs reltype))) )
                    \<Longrightarrow>  ndba_inv_pairs esets rels"
  unfolding ndba_inv_pairs_def by simp

lemma ndba_inv_pairsE[elim!]: 
  "ndba_inv_pairs esets rels \<Longrightarrow> (reltype \<in> (dom rels) \<Longrightarrow> fs reltype \<in> dom esets \<Longrightarrow> are_membs (froms (conns (the (rels reltype)))) (the (esets (fs reltype)))
    \<Longrightarrow>  are_membs (tos (conns (the (rels reltype)))) (the (esets (fs reltype)))
    \<Longrightarrow> Q) \<Longrightarrow> (reltype \<notin> (dom rels) \<Longrightarrow> Q) \<Longrightarrow> Q"
    unfolding ndba_inv_pairs_def  by metis

lemma ndba_inv_entsI[intro!]: "(\<Union>esetinf\<in>esetinfs. membs esetinf) = eids \<Longrightarrow> ndba_inv_ents esetinfs eids"
  unfolding ndba_inv_ents_def by (simp add: Let_def)
 
lemma ndba_inv_entsE[elim!]: "ndba_inv_ents esetinfs eids \<Longrightarrow> 
            ((\<Union>esetinf\<in>esetinfs. membs esetinf) = eids \<Longrightarrow> Q) \<Longrightarrow> Q"
 unfolding ndba_inv_ents_def by (simp add: Let_def)

lemma ndba_inv_valsI[intro!]: "(\<And>eid. eid \<in> membs esetinf \<Longrightarrow> eid \<in> dom em) \<Longrightarrow> (\<And>eid. eid \<in> membs esetinf \<Longrightarrow> picturematch (the (em eid)) (picture esetinf)) \<Longrightarrow> ndba_inv_vals esetinf em"
  unfolding ndba_inv_vals_def by simp

lemma ndba_inv_valsE[elim!]: "ndba_inv_vals  esetinf em \<Longrightarrow> (eid \<in> membs(esetinf) 
                                      \<Longrightarrow> eid \<in> dom em \<Longrightarrow>  
                                      picturematch (the(em(eid))) (picture esetinf) \<Longrightarrow> Q) \<Longrightarrow> (eid \<notin> membs(esetinf) \<Longrightarrow> Q) \<Longrightarrow> Q" 
unfolding ndba_inv_vals_def by auto 
(* What's the right elimination rule? 
thm ballE
lemma ndba_inv_esetsE[elim!]: "ndba_inv_esets esets rels
                               \<Longrightarrow> (fs reltype \<in> esets \<and> ts reltype \<in> esets \<Longrightarrow> Q )
                               \<Longrightarrow> (reltype \<notin> esets \<Longrightarrow> Q)   \<Longrightarrow> Q"
*)

(* Invariant breakdown lemmas *)
lemma inv_esets_esets_union_singleton: 
  assumes inv: "ndba_inv_esets esets rels"
  shows "ndba_inv_esets (esets \<union> {x}) rels"
  proof
    fix reltype
    assume inrels: "reltype \<in> rels"
    from inv inrels have "fs reltype \<in> esets" by (simp add: ndba_inv_esets_def)
    moreover from inv inrels have "ts reltype \<in> esets" by (simp add: ndba_inv_esets_def)
    ultimately show "fs reltype \<in> esets \<union> {x} \<and> ts reltype \<in> esets \<union> {x}"
     by simp
  qed

(* TO ADD TO LIBRARY *)
lemma in_unionm_dom_left: "x\<in>dom f \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> x \<in> dom (f \<union>m g)" 
  by (metis (full_types) Un_iff l_munion_dom)


lemma inv_pairs_esets_unionm_singleton:
assumes inv: "ndba_inv_pairs esets rels"
and notindom: "eset \<notin> dom esets"
shows "ndba_inv_pairs (esets \<union>m [eset \<mapsto> \<lparr> status = s, picture = p, width = w, membs = M\<rparr>]) rels"
proof
  fix reltype
  assume indom: "reltype \<in> dom rels"
  from inv show "fs reltype \<in> dom (esets \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = M\<rparr>])"
  proof(erule_tac reltype=reltype in ndba_inv_pairsE)
    assume "fs reltype \<in> dom esets" then show ?thesis 
    by (simp add: notindom in_unionm_dom_left) 
   next
    assume notindom: "reltype \<notin> dom rels"
    then show ?thesis
    proof (contradiction)
      show "reltype \<in> dom rels" by (rule indom)
    qed
  qed
 next    
  fix reltype assume indom: "reltype \<in> dom rels"
  from inv show "are_membs (froms (conns (the (rels reltype)))) (the ((esets \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = M\<rparr>]) (fs reltype)))"
  proof(erule_tac reltype=reltype in ndba_inv_pairsE)
    assume " fs reltype \<in> dom esets" and  prefroms: "are_membs (froms (conns (the (rels reltype)))) (the (esets (fs reltype)))"
    then show ?thesis
      by (simp add: l_the_map_union_left notindom)
   next
    assume notindom: "reltype \<notin> dom rels"
    then show ?thesis
    proof (contradiction)
      show "reltype \<in> dom rels" by (rule indom)
    qed
  qed
 next
  fix reltype assume indom: "reltype \<in> dom rels"
  from inv show "are_membs (tos (conns (the (rels reltype)))) (the ((esets \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = M\<rparr>]) (fs reltype)))"
  proof(erule_tac reltype=reltype in ndba_inv_pairsE)
    assume " fs reltype \<in> dom esets" and  prefroms: "are_membs (tos (conns (the (rels reltype)))) (the (esets (fs reltype)))"
    then show ?thesis
      by (simp add: l_the_map_union_left notindom)
   next
    assume notindom: "reltype \<notin> dom rels"
    then show ?thesis
    proof (contradiction)
      show "reltype \<in> dom rels" by (rule indom)
    qed
  qed
qed

lemma ndba_ents_esets_unionm_singleton:   
  assumes preinv: "ndba_inv_ents  esetinfs eids"
  shows "ndba_inv_ents  (esetinfs \<union> {x})  (eids \<union> membs x)" 
  proof
    from preinv show "(\<Union>esetinf\<in>esetinfs \<union> {x}. membs esetinf) = eids \<union> membs x"
    proof
      assume "(\<Union>esetinf\<in>esetinfs. membs esetinf) = eids" then show ?thesis
        by (simp add: Un_commute)
  qed
qed

(* Ready to prove the feasibility PO now *)
lemma (in ndba_add) ndba_add_feasibility: "PO_ndba_add_feas"
 unfolding PO_ndba_add_feas_def ndba_add_postcondition_def ndba_add_post_def
proof -
 obtain st' where st'_shape: "st' =\<lparr> esets_map = (esets_map st 
                                    \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]),
                         rels_map = rels_map st,
                         ents_map = ents_map st \<rparr>"
             by simp
 show "\<exists>st'. (esets_map st' = esets_map st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>])
                 \<and> ndba_inv_state st'"
 proof(rule_tac x=st' in exI, intro conjI)
    show "esets_map st' = esets_map st \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]"
      using st'_shape by simp
   next
    from ndba_invariant show "ndba_inv_state st'"
    proof
      let ?esets = "dom (esets_map st)" and ?rels = "dom (rels_map st)" and ?ents = "dom (ents_map st)"
      and ?esets_ran = "ran (esets_map st)"
      assume esets_inv:    "ndba_inv_esets ?esets ?rels" 
         and pairs_inv:    "ndba_inv_pairs (esets_map st) (rels_map st)"
         and ents_inv:     "ndba_inv_ents ?esets_ran ?ents"
         and reltypes_inv: "ndba_inv_reltypes (rels_map st)"
         and vals_inv:     "\<forall>esetnm\<in>?esets. 
                                ndba_inv_vals (the (esets_map st esetnm)) (ents_map st)" 
    show ?thesis
    proof
      show "ndba_inv_esets (dom (esets_map st')) (dom (rels_map st'))"
      proof -
        from ndba_add_precondition have "eset \<notin> ?esets" 
          by (simp add: ndba_add_pre_def)
        then have "dom (esets_map st') = ?esets \<union> {eset}"
          by (simp add: st'_shape l_munion_dom)
        moreover have "ndba_inv_esets (?esets \<union> {eset}) ?rels"  
         using esets_inv by (rule inv_esets_esets_union_singleton)
        ultimately show ?thesis 
          using st'_shape by simp
      qed
     next
      show "ndba_inv_pairs (esets_map st') (rels_map st')" 
      proof - 
        from ndba_add_precondition have notindom: "eset \<notin> ?esets" 
          by (simp add: ndba_add_pre_def)
        moreover have "esets_map st' = esets_map st 
                                 \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]"
          by (simp add: st'_shape)
        moreover from pairs_inv notindom have "ndba_inv_pairs (esets_map st 
                                 \<union>m [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]) (rels_map st)"
          by (rule inv_pairs_esets_unionm_singleton pairs_inv)                       
        ultimately show ?thesis 
         using st'_shape by simp
      qed
     next
      show "ndba_inv_ents (ran (esets_map st')) (dom (ents_map st'))"
      proof -
       have "dom (ents_map st') = ?ents" by (simp add: st'_shape)
       moreover have esets_shape: "esets_map st' = esets_map st \<union>m  [eset \<mapsto> \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>]"
        by (simp add: st'_shape)
       moreover from ndba_add_precondition have notindom: "eset \<notin> ?esets" 
          by (simp add: ndba_add_pre_def)
       moreover have "ran (esets_map st') = ran (esets_map st) \<union> { \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>}"
        by (subst esets_shape, subst l_munion_ran, simp add: notindom,simp )
       moreover from ents_inv
       have  "ndba_inv_ents (ran (esets_map st) \<union> { \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>})
                            (?ents \<union> (membs  \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>))"
         by(rule ndba_ents_esets_unionm_singleton)
       ultimately show ?thesis
        by simp
     qed
    next
     show "ndba_inv_reltypes (rels_map st')" using reltypes_inv st'_shape by simp
    next
     show "\<forall>esetnm\<in>dom (esets_map st'). ndba_inv_vals (the (esets_map st' esetnm)) (ents_map st')"
     proof(rule ballI)
       fix esetnm assume "esetnm \<in> dom (esets_map st')"
      show "ndba_inv_vals (the (esets_map st' esetnm)) (ents_map st')"
      proof (cases "esetnm = eset")
        assume *: "esetnm = eset"  
        have "(ents_map st') = ents_map st" by (simp add: st'_shape)
        moreover have "(the (esets_map st' esetnm)) =  \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>"
          apply (simp add: st'_shape, subst *) by (smt "*" Int_insert_right_if0 `esetnm \<in> dom (esets_map st')` domI 
                                                            dom_fun_upd fun_upd_same l_munion_empty_rhs l_the_map_union_right munion_def 
                                                            ndba_add_pre_def ndba_add_precondition ndba_state.select_convs(1) st'_shape the.simps)
        moreover have "ndba_inv_vals  (\<lparr>status = s, picture = p, width = w, membs = {}\<rparr>) (ents_map st)"
          unfolding ndba_inv_vals_def
        proof(rule ballI)
          fix eid assume "eid \<in> membs \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>"
          then show " eid \<in> dom (ents_map st) \<and> picturematch (the (ents_map st eid)) (picture \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>)"
          proof(contradiction) 
            show " eid \<notin> membs \<lparr>status = s, picture = p, width = w, membs = {}\<rparr>" by auto
          qed
        qed
       ultimately show ?thesis by simp
      next
        assume *: "esetnm \<noteq> eset"
        from vals_inv have "(ents_map st') = ents_map st" by (simp add: st'_shape)
        moreover have "(the (esets_map st' esetnm)) = (the (esets_map st esetnm))"
          by (metis "*" domIff f_in_dom_ar_the_subsume l_in_dom_ar l_munion_dom_ar_singleton_subsume
            ndba_add_pre_def ndba_add_precondition ndba_state.select_convs(1) singletonE st'_shape)
        moreover from vals_inv have "ndba_inv_vals (the (esets_map st esetnm)) (ents_map st)"
          by (smt "*" Int_insert_right_if0 `esetnm \<in> dom (esets_map st')` domIff dom_fun_upd 
                      l_inmapupd_dom_iff l_munion_empty_rhs munion_def ndba_add_pre_def 
                          ndba_add_precondition ndba_state.select_convs(1) option.distinct(1) 
                              st'_shape unionm_in_dom_left)
          ultimately show "ndba_inv_vals (the (esets_map st' esetnm)) (ents_map st')"
          by metis
qed
qed
qed
qed
qed
qed

end
