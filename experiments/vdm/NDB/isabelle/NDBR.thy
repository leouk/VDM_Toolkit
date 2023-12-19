theory NDBR
imports NDBA_sta_fix
begin

typedecl Rid

record Triple =
  fv  :: Eid
  rnm :: Rid
  tv  :: Eid
  
record State_r =
  status  :: "Esetnm \<rightharpoonup> Status"
  picture :: "Esetnm \<rightharpoonup> Picture"
  width   :: "Esetnm \<rightharpoonup> Width"
  membs   :: "Esetnm \<rightharpoonup> Eid set"
  fs      :: "Rid \<rightharpoonup> Esetnm"
  nm      :: "Rid \<rightharpoonup> Relnm option"
  ts      :: "Rid \<rightharpoonup> Esetnm"
  map     :: "Rid \<rightharpoonup> Maptype"
  valof   :: "Eid \<rightharpoonup> Value option"
  conns   :: "Triple set"

definition 
  inv_State_r_0 :: "State_r \<Rightarrow> \<bool>"
  where 
  "inv_State_r_0 sr \<equiv> 
    inv_VDMMap inv_True inv_True (status sr) \<and>
    inv_VDMMap inv_True inv_True (picture sr) \<and>
    inv_VDMMap inv_True inv_True (width sr) \<and>
    inv_VDMMap inv_True (inv_VDMSet' inv_True) (membs sr) \<and>
    inv_VDMMap inv_True inv_True (fs sr) \<and>
    inv_VDMMap inv_True (inv_Option inv_True) (nm sr) \<and>
    inv_VDMMap inv_True inv_True (ts sr) \<and>
    inv_VDMMap inv_True inv_True (map sr) \<and>
    inv_VDMMap inv_True (inv_Option inv_True) (valof sr) \<and>
    inv_VDMSet' inv_True (conns sr)
"
definition
  invDomains :: "State_r \<Rightarrow> \<bool>"
where
  "invDomains sr \<equiv> (let statusr = dom (status sr); 
                            fsr = dom (fs sr) in 
                              dom (width sr) = statusr \<and>
                              dom (picture sr) = statusr \<and>
                              dom (membs sr) = statusr \<and>
                              dom (nm sr) = fsr \<and>
                              dom (ts sr) = fsr \<and>
                              dom (map sr) = fsr) "

definition
  invRids :: "Triple set \<Rightarrow> Rid set \<Rightarrow> \<bool>"
where
  "invRids tconns nms \<equiv> 
      inv_VDMSet' inv_True tconns \<and>
      inv_VDMSet' inv_True nms \<and>
      (\<forall> t \<in> tconns . (rnm t) \<in> nms)"

definition
  invRels :: "(Rid \<rightharpoonup> Esetnm) \<Rightarrow> (Rid \<rightharpoonup> Relnm option) \<Rightarrow> (Rid \<rightharpoonup> Esetnm)\<Rightarrow> \<bool>"
where
  "invRels fsr nmr tsr \<equiv> 
      inv_VDMMap inv_True inv_True (fsr) \<and>
      inv_VDMMap inv_True (inv_Option inv_True) (nmr) \<and>
      inv_VDMMap inv_True inv_True (tsr) \<and>
      dom fsr = dom tsr \<and> dom fsr = dom nmr \<and>
      \<not>(\<exists> rid1 \<in> (dom fsr) . \<exists> rid2 \<in> dom fsr . 
                rid1 \<noteq> rid2 \<and>
                (fsr rid1) = (fsr rid2) \<and>
                (nmr rid1) = (nmr rid2) \<and>
                (tsr rid1) = (tsr rid2))" (* TODO: rephrase that? *)

definition
  esetinfo_r :: "Esetnm \<Rightarrow> State_r \<Rightarrow> Esetinf"
where
  "esetinfo_r esetnm sr \<equiv> (let a_status = the ((status sr) esetnm);
                             a_picture = the ((picture sr) esetnm);
                             a_width = the ((width sr) esetnm); 
                             a_membs = the ((membs sr) esetnm) in 
                            Esetinf.make a_status a_picture a_width a_membs)"

definition
  reltype_r :: "Rid \<Rightarrow> State_r \<Rightarrow> Reltype"
where
  "reltype_r rid sr \<equiv> (let a_fs = the ((fs sr) rid);
                           a_nm = the ((nm sr) rid);
                           a_ts = the ((ts sr) rid) in 
                          Reltype.make a_fs a_nm a_ts)"

definition
  relinfo_r :: "Rid \<Rightarrow> State_r \<Rightarrow> Relinf0"
where
  "relinfo_r rid sr \<equiv> (let a_map = the ((map sr) rid);
                           a_conns = { Pair.make (fv t) (tv t) | t . t \<in> (conns sr) \<and> (rnm t) = rid} in 
                          Relinf0.make a_map a_conns)"

text \<open> Defining VDM map comprehension is difficult, mostly because comprehension is defined 
        over sets and lists, but not maps. Maps can be created from lists, but transforming 
        sets (i.e. other map domains) into lists to create new maps is innefective and complex. 

        The way to do map comprehension in Isabelle is to first identify what kind of result you need.
        For instance, if might be possible to use available operators like in

        @{term[display] "{ x \<in> dom f . x + the(f x) = d } \<triangleleft> f"}

        using domain filtering instead of a general (VDM-like) map comprehension as in

        @{text[display] "{ x \<mapsto> f(x) | x \<in> dom f . x + the(f x) = d }"}

        When using available operators is not possible, one can try using @{text "\<lambda>"}-abstractions
        directly, as in 

        @{term[display] "(\<lambda> x . let result = (g (f x)) in
                                  (if inv_Type result \<and> 
                                      x \<in> dom f \<and> P x then 
                                      Some result
                                   else 
                                      None))"}

        for what in VDM would look like this

        @{text[display] "{ x \<mapsto> g(f(x)) | x \<in> dom f . P x }"}

        Note this is only possible when the domain element of the resulting map 
        is the same as the original map we are doing comprehension from. 
        Finally, when both the domain and range values need computing during the comprehension,
        we need the most general solution for the case 

        @{text[display] "{ h(x) \<mapsto> g(x) | x \<in> dom f . P x }"}

        in Isabelle, which is then defined as 

        @{term[display] "(\<lambda> dt . (let x = (SOME v . v \<in> dom f) in 
                                    (if dt = (h x) \<and> P x then 
                                        Some (g x)
                                     else
                                        None)))"}

        Note that we couldn't just build a set of pairs for @{term "(x, (h x))"} using
        set comprehension because we need access to the first element to calculate @{term "g x"}.

        Moreover, given complex type invariants attached to the range types of either h/g,
        one also needs to check the invariant for h/g's result.

        Simpler alternative representations would be welcome! 
        \<close>

definition 
   r_esets0 :: "State_r \<Rightarrow> (Esetnm \<rightharpoonup> Esetinf)"
where
  "r_esets0 sr \<equiv> (\<lambda> esetnm . (if esetnm \<in> dom (status sr) then
                               (let esetinfo = (esetinfo_r esetnm sr) in
                                 (if inv_Esetinf esetinfo 
                                  then 
                                     Some esetinfo
                                  else None)) 
                             else None))" 

(* { esetnm |-> esetinfo(esetnm, sr) | esetnm in set dom sr.status } *)
definition
   r_esets :: "State_r \<Rightarrow> (Esetnm \<rightharpoonup> Esetinf)"
where
  "r_esets sr \<equiv> mapCompSetBound (dom (status sr)) UNIV inv_True inv_Esetinf domid (\<lambda> esetnm . (\<lambda> y . esetinfo_r esetnm sr)) truecnst" 

(* { reltype(rid, sr) |-> relinfo(rid, sr) | rid in set dom sr.fs } *)
(*definition
   r_rels :: "State_r \<Rightarrow> (Reltype \<rightharpoonup> Relinf0)"
   where
  "r_rels sr \<equiv> mapCompSetBound 
      { (reltype_r rid sr) | rid . rid \<in> (dom (fs sr)) } 
      (UNIV::Relinf0 set) 
      inv_Reltype inv_Relinf 
      (\<lambda> rid . (\<lambda> y . (reltype_r rid sr))) 
      (\<lambda> rid . (\<lambda> y . (relinfo_r rid sr))) 
      truecnst" 
*)
definition 
   r_rels :: "State_r \<Rightarrow> (Reltype \<rightharpoonup> Relinf0)"
where
  "r_rels sr \<equiv> (\<lambda> rt .  (if (\<exists> x . x \<in> (dom (fs sr))) then
                           (let rid = (SOME x . x \<in> (dom (fs sr)));
                                relinf = (relinfo_r rid sr) in 
                              (if (reltype_r rid sr) = rt 
                                   \<and> inv_Reltype rt \<and> inv_Relinf relinf
                               then 
                                 Some relinf
                               else
                                 None))
                          else None))"


find_theorems name:Collect name:Set
find_theorems name:cong name:HOL

definition
  retra :: "State_r \<Rightarrow> State_a"
where
  "retra sr \<equiv> \<lparr> esets = (r_esets sr), rels = (r_rels sr), ents = (valof sr)\<rparr>"

definition
  inv_State_r :: "State_r \<Rightarrow> \<bool>"
where
  "inv_State_r sr \<equiv> 
      inv_State_r_0 sr \<and>
      inv_State_a (retra sr) \<and>
                    invDomains sr \<and> 
                    invRids (conns sr) (dom (nm sr)) \<and>
                    invRels (fs sr) (nm sr) (ts sr)"

definition
  add1_pre :: "State_r \<Rightarrow> Esetnm \<Rightarrow> Status \<Rightarrow> Picture \<Rightarrow> Width \<Rightarrow> \<bool>"
where
  "add1_pre st eset _ _ _ \<equiv> inv_State_r st \<and> eset \<notin> dom (status st)"

definition
  add1_post :: "State_r \<Rightarrow> Esetnm \<Rightarrow> Status \<Rightarrow> Picture \<Rightarrow> Width \<Rightarrow> State_r \<Rightarrow> \<bool>"
where
  "add1_post st eset s p w st' \<equiv> inv_State_r st \<and> inv_State_r st' \<and> 
                                 (status st')  = (status st) \<union>m [ eset \<mapsto> s ] \<and>
                                 (picture st') = (picture st) \<union>m [ eset \<mapsto> p ] \<and>
                                 (width st')   = (width st) \<union>m [ eset \<mapsto> w ] \<and>
                                 (membs st')   = (membs st) \<union>m [ eset \<mapsto> {} ]"

definition 
  PO_add1_fsb :: "\<bool>"
where
  "PO_add1_fsb \<equiv> (\<forall> st eset s p w . inv_State_r st \<and> add1_pre st eset s p w \<longrightarrow> 
                        (\<exists> st' .  inv_State_r st' \<and> add1_post st eset s p w st'))"

definition 
  PO_state_a_r_adequacy :: \<bool>
where
  "PO_state_a_r_adequacy \<equiv> \<forall> sa . inv_State_a sa \<longrightarrow> (\<exists> sr . inv_State_r sr \<and> retra sr = sa)"

thm State_r.fields_def

lemma PO_add1_FEAS_a0_invbd_state_a0:
  "inv_State_r st \<Longrightarrow>
       eset \<notin> dom (State_r.status st) \<Longrightarrow>
       inv_State_r
        \<lparr>State_r.status = State_r.status st \<union>m [eset \<mapsto> s], picture = State_r.picture st \<union>m [eset \<mapsto> p],
           width = State_r.width st \<union>m [eset \<mapsto> w], membs = State_r.membs st \<union>m [eset \<mapsto> {}],
           fs = State_r.fs st, nm = State_r.nm st, ts = State_r.ts st, map = State_r.map st, valof = valof st,
           conns = State_r.conns st\<rparr>"
unfolding inv_State_r_def 
apply (elim conjE)
apply simp
apply (intro conjI)

defer
(*
  apply (smt DiffD2 State_r.select_convs(1)
                  State_r.select_convs(2) 
                  State_r.select_convs(3) 
                  State_r.select_convs(4) 
                  State_r.select_convs(5) 
                  State_r.select_convs(6) 
                  State_r.select_convs(7) 
                  State_r.select_convs(8) 
           disjoint_iff_not_equal 
           domIff dom_empty dom_fun_upd 
           fun_upd_triv invDomains_def 
           l_munion_upd option.distinct(1))*)

unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)
oops

lemma PO_add1_FEAS_a0_invbd_state_a1_retra_r_esets_esetinfo_a0:
  "esetinfo_r esetnm
                   \<lparr>State_r.status = State_r.status st \<union>m [eset \<mapsto> s],
                      picture = State_r.picture st \<union>m [eset \<mapsto> p], width = State_r.width st \<union>m [eset \<mapsto> w],
                      membs = State_r.membs st \<union>m [eset \<mapsto> {}], fs = State_r.fs st, nm = State_r.nm st,
                      ts = State_r.ts st, map = State_r.map st, valof = valof st, conns = State_r.conns st\<rparr> = SA_esets_esetinfo"
unfolding esetinfo_r_def Let_def
apply simp
oops

lemma PO_add1_FEAS_a0_invbd_state_a1_retra_r_esets_a0:
  "(r_esets
       \<lparr>State_r.status = State_r.status st \<union>m [eset \<mapsto> s], picture = State_r.picture st \<union>m [eset \<mapsto> p],
          width = State_r.width st \<union>m [eset \<mapsto> w], membs = State_r.membs st \<union>m [eset \<mapsto> {}],
          fs = State_r.fs st, nm = State_r.nm st, ts = State_r.ts st, map = State_r.map st, valof = valof st,
          conns = State_r.conns st\<rparr>) = SA_esets"
unfolding r_esets_def Let_def
apply (simp add: split_ifs)
oops

lemma PO_add1_FEAS_a0_invbd_state_a1_retra_a0:
    "retra \<lparr>State_r.status = State_r.status st \<union>m [eset \<mapsto> s],
                      picture = State_r.picture st \<union>m [eset \<mapsto> p], width = State_r.width st \<union>m [eset \<mapsto> w],
                      membs = State_r.membs st \<union>m [eset \<mapsto> {}], fs = State_r.fs st, nm = State_r.nm st,
                      ts = State_r.ts st, map = State_r.map st, valof = valof st, conns = State_r.conns st\<rparr> = SA"
apply (unfold retra_def)
apply simp
oops

lemma PO_add1_FEAS_a0_invbd_state_a1_retra_a1:
    "retra \<lparr>State_r.status = State_r.status st \<union>m [eset \<mapsto> s],
                      picture = State_r.picture st \<union>m [eset \<mapsto> p], width = State_r.width st \<union>m [eset \<mapsto> w],
                      membs = State_r.membs st \<union>m [eset \<mapsto> {}], fs = State_r.fs st, nm = State_r.nm st,
                      ts = State_r.ts st, map = State_r.map st, valof = valof st, conns = State_r.conns st\<rparr> = SA"
unfolding retra_def r_rels_def r_esets_def Let_def 
apply simp
oops

lemma PO_add1_FEAS_a0_invbd_state_a1_state_a_retr_a0:
  "eset \<notin> dom (State_r.status st) \<Longrightarrow>
    inv_State_a (retra st) \<Longrightarrow>
    invDomains st \<Longrightarrow>
    invRids (State_r.conns st) (dom (State_r.nm st)) \<Longrightarrow>
    invRels (State_r.fs st) (State_r.nm st) (State_r.ts st) \<Longrightarrow>
    inv_State_a
     (retra \<lparr>State_r.status = State_r.status st \<union>m [eset \<mapsto> s], picture = State_r.picture st \<union>m [eset \<mapsto> p],
               width = State_r.width st \<union>m [eset \<mapsto> w], membs = State_r.membs st \<union>m [eset \<mapsto> {}],
               fs = State_r.fs st, nm = State_r.nm st, ts = State_r.ts st, map = State_r.map st,
               valof = valof st, conns = State_r.conns st\<rparr>)"
unfolding inv_State_a_def Let_def
apply (elim conjE, intro conjI)
sorry

lemma PO_add1_FEAS_a0_invbd_state_a1: 
  " inv_State_r st \<Longrightarrow>
       eset \<notin> dom (State_r.status st) \<Longrightarrow>
       inv_State_r
        \<lparr>State_r.status = State_r.status st \<union>m [eset \<mapsto> s], picture = State_r.picture st \<union>m [eset \<mapsto> p],
           width = State_r.width st \<union>m [eset \<mapsto> w], membs = State_r.membs st \<union>m [eset \<mapsto> {}],
           fs = State_r.fs st, nm = State_r.nm st, ts = State_r.ts st, map = State_r.map st, valof = valof st,
           conns = State_r.conns st\<rparr>" 
unfolding inv_State_r_def 
apply (elim conjE)
apply simp
apply (intro conjI)
(*
apply (metis PO_add1_FEAS_a0_invbd_state_a1_state_a_retr_a0)
apply (smt DiffD2 State_r.select_convs(1) 
                  State_r.select_convs(2) 
                  State_r.select_convs(3) 
                  State_r.select_convs(4) 
                  State_r.select_convs(5) 
                  State_r.select_convs(6) 
                  State_r.select_convs(7) 
                  State_r.select_convs(8) 
           disjoint_iff_not_equal 
           domIff dom_empty dom_fun_upd 
           fun_upd_triv invDomains_def 
           l_munion_upd option.distinct(1))*)
  sorry

theorem l_PO_add1_fsb_a0:
  "PO_add1_fsb"
unfolding PO_add1_fsb_def
apply (intro allI impI, elim conjE)

unfolding add1_pre_def add1_post_def
  apply (elim conjE)
  apply simp

apply (rule_tac x="\<lparr> status = status st \<union>m [eset \<mapsto> s],
                     picture = picture st \<union>m [eset \<mapsto> p], 
                     width = width st \<union>m [eset \<mapsto> w],
                     membs = membs st \<union>m [eset \<mapsto> {}],
                     fs = fs st,
                     nm = nm st,
                     ts = ts st,
                     map = map st,
                     valof = valof st,
                     conns = conns st\<rparr>" in exI) 
apply (simp add: PO_add1_FEAS_a0_invbd_state_a1)
done

theorem l_adequacy_a0:
   "PO_state_a_r_adequacy"
unfolding PO_state_a_r_adequacy_def retra_def inv_State_r_def
  apply (intro allI impI conjI)
  apply (rule_tac x="retra sr"))
oops

theorem l_adequacy_a1:
   "PO_state_a_r_adequacy"
unfolding PO_state_a_r_adequacy_def retra_def inv_State_r_def
apply (intro allI impI)
unfolding inv_State_a_def Let_def
apply simp
oops

end
