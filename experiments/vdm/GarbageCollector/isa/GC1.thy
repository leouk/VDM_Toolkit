theory GC1
imports GC0
begin

(*============================================================*)
section \<open> Level 1 definitions \<close>  
  
(* TODO: make Heap use Addrs? At the moment, achieving the same through ALL_ADDR` invariant *)  
  
(* Heap maps addresses to nodes, which are sequences of optional addresses*)
type_synonym AddrO= "Addr option"
type_synonym Node = "AddrO VDMSeq" \<comment> \<open>Node = seq of [Addr]\<close>
type_synonym Heap = "Addr \<rightharpoonup> Node"

term "{ x | x . Some x \<in> elems (the ((Map.empty::Heap) x)) }"

lemma "{ x | x . (x::nat) < 3 } = { y . y < 3}" by simp  
  
term "the (those (filter (\<lambda> x . (case x of None \<Rightarrow> False | Some y \<Rightarrow> True)) xs))"

value "those [Some (0::nat), Some 1, Some 2]"
find_theorems name:filter name:List
    
abbreviation 
  ALL_RADDR :: "Addrs rel" 
where
  "ALL_RADDR \<equiv> UNIV \<times> UNIV" (* TODO: this isn't quite right *)

(* Isabelle is picky about option types, thus the encoding below - thanks to Andrius Velikys *)
definition
  child_rel :: "Heap \<Rightarrow> Addr rel"  
  where
    "child_rel hp \<equiv> {(a,b) | a b . a \<in> dom hp \<and> Some b \<in> elems (the (hp a)) }"

lemmas child_rel_defs = child_rel_def elems_def
  
(* ran(s \<triangleleft> (child_rel hp)) has the wrong type given child_rel does not return a map 
   but a relation. But we know that ran of \<triangleleft> is just relational image, which is ``. *)    
definition
  reach :: "Addr VDMSet \<Rightarrow> Heap \<Rightarrow> Addr VDMSet"
where
  "reach s hp \<equiv> (child_rel hp)\<^sup>* `` s"

lemmas reach_defs = reach_def child_rel_defs

(*lemma "the ((hp::Heap) b) = A \<Longrightarrow> the (A $ j) = B" using[[show_types]]*)
    
text \<open> Cliff's Lemma 1 \<close>
lemma l_reach_hp_lemma1: 
  "(\<exists> a . a \<in> (reach s hp) \<and> a \<notin> s \<longrightarrow> (\<exists> b j . b \<in> dom hp \<and> the ((the (hp b)) $ j) \<notin> s))"
  \<comment> \<open>using [[rule_trace,simp_trace]]\<close>
  find_theorems "\<exists> _ . _ \<longrightarrow> _"
  (*apply (intro exI impI, safe, auto, intro exI) *)
  apply simp
    oops

lemma l_reach_hp_lemma1: 
  "(\<exists> a . a \<in> (reach s hp) \<and> a \<notin> s) \<longrightarrow> (\<exists> b j . b \<in> dom hp \<and> the ((the (hp b)) $ j) \<notin> s)"
  apply (safe, simp)
  unfolding reach_def
  find_theorems "_ \<in> _ `` _" elim
  apply (erule ImageE)
  find_theorems "_ \<in> _\<^sup>*" elim
  apply (erule rtranclE)
    apply simp (* base case is ruled out by condition a \<notin> s *)
  unfolding child_rel_def
    apply simp
  apply (erule conjE)
  apply (rule_tac x=y in exI)
  apply simp
  unfolding elems_def
  oops

lemma l_reach_hp_lemma1: 
  "(\<exists> a . a \<in> (reach s hp) \<and> a \<notin> s) \<longrightarrow> (\<exists> b . b \<in> dom hp \<and> (\<exists> j . j \<in> inds (the (hp b)) \<and> the ((the (hp b)) $ j) \<notin> s))"
  apply (safe)
  unfolding reach_def
  find_theorems "_ \<in> _ `` _" elim
  apply (erule ImageE)
  find_theorems "_ \<in> _\<^sup>*" elim
  apply (erule rtranclE)
    apply simp (* base case is ruled out by condition a \<notin> s *)
  unfolding child_rel_def
    apply simp
  apply (erule conjE)
  apply (rule_tac x=y in exI)
  unfolding inds_def
  apply simp
  (* needs a lemma linking elems + inds *)
  unfolding elems_def
  oops
    
lemma l_reach_hp_lemma1: 
  "(\<exists> a . a \<in> (reach s hp) \<and> a \<notin> s) \<longrightarrow> (\<exists> b . b \<in> dom hp \<and> (\<exists> j . j \<in> inds (the (hp b)) \<and> the ((the (hp b)) $ j) \<notin> s))"
  apply (safe)
  unfolding reach_def
  find_theorems "_ \<in> _ `` _" elim
  apply (erule ImageE)
  find_theorems "_ \<in> _\<^sup>*" elim
  apply (erule rtranclE)
    apply simp (* base case is ruled out by condition a \<notin> s *)
  unfolding child_rel_def
    apply simp
  apply (erule conjE)
  apply (rule_tac x=y in exI)
  apply (simp add: l_elems_of_inds)
    by auto

text \<open> Cliff's Lemma 2 \<close>    
lemma l_subset_reach: "s1 \<subseteq> s2 \<Longrightarrow> reach s1 hp \<subseteq> reach s2 hp"
  unfolding reach_def apply safe 
  unfolding Image_def apply safe
  apply (rule_tac x=xa in bexI)
  apply simp
  by blast
    
lemma l_filter_within_reach: "s \<subseteq> reach s hp"
  unfolding reach_def
  apply safe
  unfolding Image_def
  apply safe
  apply (rule_tac x=x in bexI)
  by simp+   

lemma l_reach_empty[simp]: "reach {} hp = {}"
  unfolding reach_def 
  by simp
    
definition
  empty_heap :: "Heap"
  where
 "empty_heap \<equiv> (\<lambda> x . if x \<in> ALL_ADDR then Some [] else None)" 
 \<comment> \<open>type ([]::(Addr option) list)\<close>

lemma l_empty_heap_last_child_rel_E: 
  "(y, z) \<in> child_rel empty_heap \<Longrightarrow> y \<in> s \<Longrightarrow> z \<in> s" 
  unfolding child_rel_def empty_heap_def
  apply safe
  by (simp split:if_splits)
    
lemma l_empty_heap_reach[simp]: "reach s empty_heap = s"
  unfolding reach_def 
  apply (safe)
   defer
  find_theorems "_ `` _" intro
  apply (rule rev_ImageI)
  apply simp
  find_theorems "_\<^sup>*" intro  
  apply (rule rtrancl_refl)
  (* find_theorems "(_,_) \<in> _\<^sup>* \<Longrightarrow> _"
  apply (induct "(child_rel empty_heap)")*)
  (*find_theorems "_\<^sup>*" elim
  apply (erule rtranclE)
  apply simp *)
  (*find_theorems "_\<^sup>*" name:induc
    apply (induct rule:rtrancl_induct)  *)
  apply (erule rtrancl_induct)
  by (simp_all add: l_empty_heap_last_child_rel_E)
    
lemma l_empty_heap_image_eq: "s \<noteq> {} \<Longrightarrow> s \<subseteq> dom empty_heap \<Longrightarrow> ran (s \<triangleleft> empty_heap) = {[]}"
  apply safe
  unfolding dom_restr_def ran_def restrict_map_def
   apply safe
  unfolding empty_heap_def
   apply (simp_all split: if_splits)
  apply (rule_tac x=x in exI)
  apply safe
  using domIff by fastforce

lemma l_empty_heap_image_subset: "s \<subseteq> dom empty_heap \<Longrightarrow> ran (s \<triangleleft> empty_heap) \<subseteq> {[]}"
  apply safe
  unfolding dom_restr_def ran_def restrict_map_def
   apply safe
  unfolding empty_heap_def
  by (simp_all split: if_splits)
    
lemma l_in_ALL_ADDR: "\<exists> x . x \<in> ALL_ADDR"
  using l_ALL_ADDR_not_empty by blast
    
lemma l_empty_heap_image_x: "x \<in> dom empty_heap \<Longrightarrow> ran ({x} \<triangleleft> empty_heap) = {[]}" 
  apply (rule l_empty_heap_image_eq)
  apply simp
  unfolding empty_heap_def
  by safe
    
lemma l_empty_heap_ALL_ADDR_absorb[simp]: "ALL_ADDR \<triangleleft> empty_heap = empty_heap"
  apply (rule ext)
  unfolding dom_restr_def empty_heap_def
  by (simp)
    
(*------------------------------------------------------------*)
subsection \<open> Sigma level 1 \<close>  

record Sigma1 =
  roots1 :: "Addr VDMSet"
  hp1    :: "Heap"
  free1  :: "Addr VDMSet"
  
definition
  garbage1 :: "Addr VDMSet \<Rightarrow> Heap \<Rightarrow> Addr VDMSet \<Rightarrow> Addr VDMSet"
where
  "garbage1 r hp f \<equiv> ALL_ADDR - (f \<union> (reach r hp))"

definition
  inv_Sigma1 :: "Addr VDMSet \<Rightarrow> Heap \<Rightarrow> Addr VDMSet \<Rightarrow> \<bool>"
where
  "inv_Sigma1 roots heap free \<equiv> 
      dom heap = ALL_ADDR \<and>
      ran (free \<triangleleft> heap) \<subseteq> {[]} \<and>
      free \<inter> (reach roots heap) = {}" 
\<comment> \<open>\<and>  free \<union> (reach roots heap) \<union> (garbage1 roots heap free) = ALL_ADDR\<close>

lemma f_Sigma1_no_free_reach: 
  "inv_Sigma1 roots heap free \<Longrightarrow> free \<inter> (reach roots heap) = {}"
  unfolding inv_Sigma1_def by simp
    
lemma f_Sigma1_no_free_roots: 
  "inv_Sigma1 roots heap free \<Longrightarrow> free \<inter> roots = {}"
  unfolding reach_def 
  apply (frule f_Sigma1_no_free_reach)
  apply safe 
  find_theorems "_ = {} \<Longrightarrow> _" 
  apply (drule_tac a=x in equals0D, erule notE) 
  apply simp
  unfolding inv_Sigma1_def
  by (meson contra_subsetD l_filter_within_reach)

lemma f_Sigma1_no_free_garbage: 
  "inv_Sigma1 roots heap free \<Longrightarrow> free \<inter> garbage1 roots heap free = {}"
  apply (frule f_Sigma1_no_free_reach)
  apply (frule f_Sigma1_no_free_roots)
  apply safe 
  apply (drule_tac a=x in equals0D, erule notE, simp)
  unfolding garbage1_def
  by safe
      
lemma f_Sigma1_no_reach_garbage: 
  "inv_Sigma1 roots heap free \<Longrightarrow> 
    (reach roots heap) \<inter> garbage1 roots heap free = {}"
  apply (frule f_Sigma1_no_free_garbage)
  unfolding inv_Sigma1_def garbage1_def
  apply (elim conjE, rotate_tac 3, erule subst)
  using [[show_brackets]]
  nitpick
  oops
lemma l_Sigma1_cliff_identify:
    "(ran (free \<triangleleft> (heap::Heap)) \<subseteq> {([])}) = (\<forall> a \<in> free \<inter> dom heap . (the(heap a)) = [])"
  using [[show_types]]
  apply safe
  find_theorems "_ \<subseteq> _" elim
  apply (erule subsetCE, simp_all)
  unfolding ran_def 
   apply safe
   apply (rule_tac x=a in exI)
   apply (simp add: dom_restr_def)
  apply (erule_tac x=a in ballE)
   apply (metis dom_restr_def not_None_eq option.sel restrict_map_def)
    by (metis domI l_dom_r_iff)
    
definition
  inv_Sigma1_R :: "Sigma1 \<Rightarrow> \<bool>"
where
  "inv_Sigma1_R s \<equiv> inv_Sigma1 (roots1 s) (hp1 s) (free1 s)"

lemmas inv_Sigma1_defs = inv_Sigma1_R_def inv_Sigma1_def 

lemma l_empty_heap_dom[simp]: "dom empty_heap = ALL_ADDR"
  unfolding empty_heap_def 
  apply safe
  by (simp_all split:if_splits)

lemma l_empty_heap_apply: "x \<in> ALL_ADDR \<Longrightarrow> empty_heap x = Some []"
  unfolding empty_heap_def by simp 

lemma l_empty_heap_ran[simp]: "ran empty_heap = {[]}"
  unfolding empty_heap_def ran_def
  apply safe
  apply (simp_all split:if_splits)
  apply (rule exI[of _ an_addr])
  by (simp)
    
typedef Sigma1Type = "{ s . inv_Sigma1_R s }"
  morphisms s1t_t (* st: Sigma1Type \<Rightarrow> Sigma1 *) 
            s1t_r (* rc: Sigma1 \<Rightarrow> Sigma1Type *)
  unfolding inv_Sigma1_defs 
  apply simp
  apply (rule exI[of _ "\<lparr>roots1={}, hp1 = empty_heap, free1 = ALL_ADDR\<rparr>"])
  apply (safe)
  apply (simp_all add: l_empty_heap_apply)
  unfolding empty_heap_def garbage1_def
  by (simp_all split:if_splits)
  
definition
  inv_Sigma1_T :: "Sigma1Type \<Rightarrow> \<bool>"
where
  "inv_Sigma1_T s \<equiv> inv_Sigma1_R (s1t_t s)"

definition
  retr0 :: "Sigma1 \<Rightarrow> Sigma0"
  where
 "retr0 s1 \<equiv>  \<lparr>busy0 = reach (roots1 s1) (hp1  s1), free0 = (free1  s1)\<rparr>"

 theorem l_sigma0_sigma1_adequacy0: "inv_Sigma0_R s0 \<Longrightarrow> \<exists> s1 . inv_Sigma1_R s1 \<and> retr0 s1 = s0"
  unfolding retr0_def 
  apply (rule_tac x="\<lparr>roots1 = (busy0 s0), hp1 = empty_heap, free1 = (free0 s0)\<rparr>" in exI)
  apply (safe, simp_all)
  unfolding inv_Sigma0_defs inv_Sigma1_defs
  apply (cases s0, simp)
  apply (elim conjE)
  find_theorems "ran(_ \<triangleleft> _)"
  apply (intro conjI l_empty_heap_image_subset)
  using l_empty_heap_dom apply blast
  done
  \<comment> \<open>by (simp add: garbage1_def sup_commute)\<close>

definition
  retr0T :: "Sigma1Type \<Rightarrow> Sigma0Type"
  where
 "retr0T s1 \<equiv>  (s0t_r (retr0 (s1t_t s1)))"

text \<open> Cliff's Theorem 2 \<close>
theorem l_sigma0_sigma1_adequacy: "\<forall> s0 . \<exists> s1 . retr0T s1 = s0"
  by (metis (full_types) s0t_r_cases s1t_t_cases l_sigma0_sigma1_adequacy0 mem_Collect_eq retr0T_def)

(*================================================================*)
  
instantiation Sigma1Type :: VDM
begin

definition 
  "st_inv_Sigma1Type s \<longleftrightarrow> inv_Sigma1_T s"

lemma l_Sigma1_valid: "inv_Sigma1_T s"
using inv_Sigma1_T_def s1t_t by auto
  
instance 
  using inv_Sigma1_T_def st_inv_Sigma1Type_def s1t_t 
  by (intro_classes, auto)
    
end

lemma l1_s1t_inv: "inv_Sigma1_T s"
  by (simp add: l_Sigma1_valid)

(*
rely missing garbage \<subseteq> garbage'?
Collector
ext   wr free
      rd roots, hp
pre   True
rely  free' \<subseteq> free
guar  free \<subseteq> free'
post  (ALL_ADDR - (reach roots hp)) \<subseteq> \<Union> (hat free)
*)  
    
definition
  roots1_constant :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"  
  where
  "roots1_constant s s' \<equiv> (roots1 (s1t_t s)) = (roots1 (s1t_t s'))"
  
definition
  collector1_frame :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"
where
 "collector1_frame s s' \<equiv> 
    (let hp1'=(hp1 (s1t_t s')); hp1 =(hp1 (s1t_t s))
     in
      roots1_constant s s' \<and>  hp1' = hp1)"   

definition 
  collector1_pre :: "Sigma1Type \<Rightarrow> \<bool>"
where
  "collector1_pre s \<equiv> True"
  
definition 
  collector1_post :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"
where
  "collector1_post s s' \<equiv> 
    (let free1 =(free1 (s1t_t s)); 
         roots1=(roots1 (s1t_t s));
         hp1=(hp1 (s1t_t s))
      in 
      (ALL_ADDR - (reach roots1 hp1)) \<subseteq> \<Union> (hat free1))"
  
definition 
  collector1_rely :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"
where
  "collector1_rely s s' \<equiv>
    (let free1'=(free1 (s1t_t s')); free1 =(free1 (s1t_t s));  
         roots1 =(roots1 (s1t_t s)); hp1 =(hp1 (s1t_t s))       
      in roots1_constant s s' \<and>
        
         free1' \<subseteq> free1)"
\<comment> \<open> (garbage1 roots1 free1 hp1) \<subseteq> (garbage1 roots1 free1' hp1) \<and> \<close>

definition 
  collector1_guar :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"
where
  "collector1_guar s s' \<equiv> 
    (let free1'=(free1 (s1t_t s')); free1 =(free1 (s1t_t s))
      in collector1_frame s s' \<and> free1 \<subseteq> free1')"

lemmas collector1_defs = Let_def collector1_pre_def hat_def collector1_frame_def roots1_constant_def
                         collector1_post_def collector1_rely_def collector1_guar_def

(*context RG_VCG
begin*)

lemma l2_collector1_fsb: "collector1_pre s \<Longrightarrow> \<exists>s'. collector1_post s s'" 
  unfolding collector1_defs reach_def
  by simp
    
lemma l3_collector1_rely_refl: "collector1_rely s s"
  unfolding collector1_defs
  by simp
    
lemma l4_collector1_guar_refl: "collector1_guar s s"
  unfolding collector1_defs
  by simp
    
lemma l5_collector1_rely_trans: "collector1_rely s t \<Longrightarrow> collector1_rely t u \<Longrightarrow> collector1_rely s u"
  unfolding collector1_defs
  apply safe
  apply (simp add: garbage1_def)+
  by blast  

lemma l6_collector1_guar_trans: "collector1_guar s t \<Longrightarrow> collector1_guar t u \<Longrightarrow> collector1_guar s u"
  unfolding collector1_defs
  apply safe
  apply simp_all
  by blast

lemma l7_collector1_post_guar: "collector1_pre s \<Longrightarrow> (\<exists>s'. collector1_post s s' \<and> collector1_guar s s')"
  unfolding collector1_defs by blast
    
lemma l8_collector1_pre_rely: "collector1_pre s \<Longrightarrow> collector1_rely s s' \<Longrightarrow> collector1_pre s'"
  unfolding collector1_defs by blast
    
lemma l9_collector1_rely_comp_post: 
  "collector1_pre s \<Longrightarrow> (collector1_rely ;; collector1_post) s s' \<Longrightarrow> collector1_post s s'"
  apply (erule spec_compE)
  unfolding collector1_defs by blast
    
lemma l11_collector1_post_comp_rely: 
  "(collector1_post ;; collector1_rely) s s' \<Longrightarrow> collector1_post s s'"
  apply (erule spec_compE)
  unfolding collector1_defs by blast
    
interpretation Sigma1Type : VDM inv_Sigma1_T
  apply (unfold_locales)
  apply (simp add: l1_s1t_inv)
  done

interpretation collector1: RG_VCG
  inv_Sigma1_T collector1_pre collector1_post collector1_rely collector1_guar
  apply (unfold_locales, safe)
  apply (simp add: l2_collector1_fsb)
  apply (simp add: l3_collector1_rely_refl)
  apply (simp add: l4_collector1_guar_refl)
  apply (rule l5_collector1_rely_trans, simp_all)
  apply (rule l6_collector1_guar_trans, simp_all)
  apply (simp add: l7_collector1_post_guar)
  apply (simp add: l8_collector1_pre_rely)
  apply (simp add: l9_collector1_rely_comp_post)
  apply (simp add: l11_collector1_post_comp_rely)
  done
    
(*
Mutator
ext   wr hp, free
      rd roots
pre   True
rely  free' -\<triangleleft> hp' = free' -\<triangleleft> hp \<and>
      free \<subseteq> free'
guar  free' \<subseteq> free
post  True
*)  

definition
  mutator1_frame :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"
where
 "mutator1_frame s s' \<equiv> roots1_constant s s'"   

definition 
  mutator1_pre :: "Sigma1Type \<Rightarrow> \<bool>"
where
  "mutator1_pre s \<equiv> True"
  
definition 
  mutator1_post :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"
where
  "mutator1_post s s' \<equiv> True"

definition 
  mutator1_rely :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"
where
  "mutator1_rely s s' \<equiv>
    (let free1'=(free1 (s1t_t s')); free1 =(free1 (s1t_t s));  
         roots1'=(roots1 (s1t_t s')); roots1 =(roots1 (s1t_t s));         
         hp1'=(hp1 (s1t_t s')); hp1 =(hp1 (s1t_t s))         
      in roots1_constant s s' \<and>
         (free1' -\<triangleleft> hp1') = (free1' -\<triangleleft> hp1) \<and> 
         free1 \<subseteq> free1')"

definition 
  mutator1_guar :: "Sigma1Type \<Rightarrow> Sigma1Type \<Rightarrow> \<bool>"
where
  "mutator1_guar s s' \<equiv> 
    (let free1'=(free1 (s1t_t s')); free1 =(free1 (s1t_t s));  
         roots1 =(roots1 (s1t_t s));         
         hp1'=(hp1 (s1t_t s')); hp1 =(hp1 (s1t_t s))              
      in mutator1_frame s s' \<and>
         free1' \<subseteq> free1 )"
\<comment> \<open>(garbage1 roots1 free1 hp1) \<subseteq> (garbage1 roots1 free1' hp1') \<and> \<close>

lemmas mutator1_defs = Let_def mutator1_pre_def mutator1_frame_def roots1_constant_def
                         mutator1_post_def mutator1_rely_def mutator1_guar_def


lemma l2_mutator1_fsb: "mutator1_pre s \<Longrightarrow> \<exists>s'. mutator1_post s s'" 
  unfolding mutator1_defs by simp
    
lemma l3_mutator1_rely_refl: "mutator1_rely s s"
  unfolding mutator1_defs
  by simp
    
lemma l4_mutator1_guar_refl: "mutator1_guar s s"
  unfolding mutator1_defs
  by simp

lemma l_dom_antires_apply: "(S -\<triangleleft> f) l = (if l \<in> S then None else f l)"
by (metis dom_antirestr_def)

lemma l5_mutator1_rely_trans_aux: "\<lbrakk>a1 \<subseteq> a2 ; a2 \<subseteq> a3; a2 -\<triangleleft> f2 = a2 -\<triangleleft> f1; a3 -\<triangleleft> f3 = a3 -\<triangleleft> f2\<rbrakk> \<Longrightarrow> a3 -\<triangleleft> f2 = a3 -\<triangleleft> f1"
  apply (rule ext) 
  apply (simp add: l_dom_antires_apply, safe)
  by (metis (full_types) contra_subsetD dom_antirestr_def)  
    thm contra_subsetD set_mp
  (*
  "e": Try this: by (metis (full_types) contra_subsetD dom_antirestr_def) (17 ms) 
  "spass": Try this: by (metis dom_antirestr_def set_mp) (10 ms) 
  "cvc4": Try this: by (metis domIff f_in_dom_ar_apply_subsume l_in_dom_ar set_mp) (740 ms)
  *)
     
lemma l5_mutator1_rely_trans: "mutator1_rely s t \<Longrightarrow> mutator1_rely t u \<Longrightarrow> mutator1_rely s u"
  unfolding mutator1_defs
  apply (safe,simp_all)
  apply (rule l5_mutator1_rely_trans_aux, simp+)
  by blast

lemma l6_mutator1_guar_trans: "mutator1_guar s t \<Longrightarrow> mutator1_guar t u \<Longrightarrow> mutator1_guar s u"
  unfolding mutator1_defs
  apply safe
  apply (simp add: garbage1_def)+
  by blast+
  
lemma l7_mutator1_post_guar: "mutator1_pre s \<Longrightarrow> (\<exists>s'. mutator1_post s s' \<and> mutator1_guar s s')"
  unfolding mutator1_defs by blast
    
lemma l8_mutator1_pre_rely: "mutator1_pre s \<Longrightarrow> mutator1_rely s s' \<Longrightarrow> mutator1_pre s'"
  unfolding mutator1_defs by blast
    
lemma l9_mutator1_rely_comp_post: 
  "mutator1_pre s \<Longrightarrow> (mutator1_rely ;; mutator1_post) s s' \<Longrightarrow> mutator1_post s s'"
  apply (erule spec_compE)
  unfolding mutator1_defs by blast
    
lemma l11_mutator1_post_comp_rely: 
  "(mutator1_post ;; mutator1_rely) s s' \<Longrightarrow> mutator1_post s s'"
  apply (erule spec_compE)
  unfolding mutator1_defs by blast

interpretation mutator1: RG_VCG
  inv_Sigma1_T mutator1_pre mutator1_post mutator1_rely mutator1_guar
  apply (unfold_locales, safe)
  apply (simp add: l2_mutator1_fsb)
  apply (simp add: l3_mutator1_rely_refl)
  apply (simp add: l4_mutator1_guar_refl)
  apply (rule l5_mutator1_rely_trans, simp_all)
  apply (rule l6_mutator1_guar_trans, simp_all)
  apply (simp add: l7_mutator1_post_guar)
  apply (simp add: l8_mutator1_pre_rely)
  apply (simp add: l9_mutator1_rely_comp_post)
  apply (simp add: l11_mutator1_post_comp_rely)
  done

text \<open> Cliff's Theorem 3 ? \<close>
lemma l_collector1_coherence: "mutator1_guar s s' \<longleftrightarrow> collector1_rely s s'"
  unfolding mutator1_defs collector1_defs garbage1_def
  by (safe)
    
lemma l_mutator1_coherence: "collector1_guar s s' \<Longrightarrow> mutator1_rely s s'"
  unfolding Let_def mutator1_rely_def collector1_guar_def collector1_frame_def 
            roots1_constant_def garbage1_def 
  by (safe,simp)

lemma l_mutator1_coherence_not: "mutator1_rely s s' \<Longrightarrow> collector1_guar s s'"
  unfolding Let_def mutator1_rely_def collector1_guar_def collector1_frame_def 
            roots1_constant_def garbage1_def 
  apply (safe) oops
    
end