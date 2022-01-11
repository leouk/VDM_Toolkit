theory GC2
imports GC1
begin

record Sigma2 =
  roots2 :: "Addr VDMSet"
  hp2    :: "Heap"
  free2  :: "Addr VDMSet"
  marked2:: "Addr VDMSet"

definition
  garbage2 :: "Addr VDMSet \<Rightarrow> Heap \<Rightarrow> Addr VDMSet \<Rightarrow> Addr VDMSet \<Rightarrow> Addr VDMSet"
where
  "garbage2 r hp f m \<equiv> ALL_ADDR - (f \<union> (reach r hp) \<union> m)"
  
definition
  inv_Sigma2 :: "Addr VDMSet \<Rightarrow> Heap \<Rightarrow> Addr VDMSet \<Rightarrow> Addr VDMSet \<Rightarrow> \<bool>"
where
  "inv_Sigma2 roots heap free marked \<equiv> 
      dom heap = ALL_ADDR \<and>
      free \<inter> (reach roots heap) = {} \<and>
      ran (free \<triangleleft> heap) \<subseteq> {[]} \<and>
      (roots \<union> free) \<subseteq> marked"  
\<comment> \<open>free \<union> (reach roots heap) \<union> (garbage2 roots heap free marked) = ALL_ADDR \<and>\<close>

definition
  inv_Sigma2_R :: "Sigma2 \<Rightarrow> \<bool>"
where
  "inv_Sigma2_R s \<equiv> inv_Sigma2 (roots2 s) (hp2 s) (free2 s) (marked2 s)"

lemmas inv_Sigma2_defs = inv_Sigma2_R_def inv_Sigma2_def inv_Sigma1_defs 
  
typedef Sigma2Type = "{ s . inv_Sigma2_R s }"
  morphisms s2t_t (* st: Sigma2Type \<Rightarrow> Sigma2 *) 
            s2t_r (* rc: Sigma2 \<Rightarrow> Sigma2Type *)
  unfolding inv_Sigma2_defs 
  apply simp
  apply (rule exI[of _ "\<lparr>roots2={}, hp2 = empty_heap, free2 = ALL_ADDR, marked2 = ALL_ADDR\<rparr>"])
  apply (safe)
  apply (simp_all add: l_empty_heap_apply)
  unfolding empty_heap_def
  by (simp_all split:if_splits)
 
definition
  inv_Sigma2_T :: "Sigma2Type \<Rightarrow> \<bool>"
where
  "inv_Sigma2_T s \<equiv> inv_Sigma2_R (s2t_t s)"

definition
  retr1 :: "Sigma2 \<Rightarrow> Sigma1"
  where
 "retr1 s2 \<equiv> \<lparr>roots1 = (roots2 s2), hp1 = (hp2 s2), free1 = (free2 s2)\<rparr>"

theorem l_sigma1_sigma2_adequacy0: "inv_Sigma1_R s1 \<Longrightarrow> \<exists> s2 . inv_Sigma2_R s2 \<and> retr1 s2 = s1"
  unfolding retr1_def 
  apply (rule_tac x="\<lparr>roots2 = (roots1 s1), 
                      hp2    = (hp1 s1), 
                      free2  = (free1 s1), 
                     marked2 = (roots1 s1) \<union> (free1 s1)\<rparr>" in exI)
  apply (safe, simp_all)
  unfolding inv_Sigma2_defs
  apply (cases s1, simp)
  done
  
definition
  retr1T :: "Sigma2Type \<Rightarrow> Sigma1Type"
  where
 "retr1T s2 \<equiv>  (s1t_r (retr1 (s2t_t s2)))"
 
text \<open> Cliff's Theorem 2.1 (missing) \<close>
theorem l_sigma1_sigma2_adequacy: "\<forall> s1 . \<exists> s2 . retr1T s2 = s1"
  by (metis Sigma1Type.st_valid inv_Sigma1_T_def l_sigma1_sigma2_adequacy0 mem_Collect_eq retr1T_def s1t_t_inverse s2t_t_cases)
    (* TODO: interesting that st_valid appears here! *)
    
instantiation Sigma2Type :: VDM
begin

definition 
  "st_inv_Sigma2Type s \<longleftrightarrow> inv_Sigma2_T s"

lemma l_Sigma2_valid: "inv_Sigma2_T s"
using inv_Sigma2_T_def s2t_t by auto
  
instance 
  using inv_Sigma2_T_def st_inv_Sigma2Type_def s2t_t 
  by (intro_classes, auto)
    
end

lemma l1_s2t_inv: "inv_Sigma2_T s"
  by (simp add: l_Sigma2_valid)

interpretation Sigma2Type : VDM inv_Sigma2_T
  apply (unfold_locales)
  apply (simp add: l1_s2t_inv)
  done
  
definition
  roots2_constant :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
  where
  "roots2_constant s s' \<equiv> (roots2 (s2t_t s')) = (roots2 (s2t_t s))"  

(*
Unmark
ext   wr marked
      rd free, roots, hp
pre   True
rely  marked' = marked \<and> free' = free \<and> hp' = hp \<and> roots' = roots (missing roots=)
guar  True
post  marked' = (roots \<union> free)
*)  
  
definition
  unmark2_frame :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
 "unmark2_frame s s' \<equiv> 
    (let free2'=(free2 (s2t_t s')); free2 =(free2 (s2t_t s));
         hp2'=(hp2 (s2t_t s')); hp2 =(hp2 (s2t_t s))
     in
      roots2_constant s s' \<and> hp2' = hp2 \<and> free2' = free2)"   

definition 
  unmark2_pre :: "Sigma2Type \<Rightarrow> \<bool>"
where
  "unmark2_pre s \<equiv> True"
  
definition 
  unmark2_post :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "unmark2_post s s' \<equiv> 
    (let free2 =(free2 (s2t_t s)); 
         roots2=(roots2 (s2t_t s));
         marked2'=(marked2 (s2t_t s'))
      in 
      marked2' = (roots2 \<union> free2))"
  
definition 
  unmark2_rely :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "unmark2_rely s s' \<equiv>
    (let free2'=(free2 (s2t_t s')); free2 =(free2 (s2t_t s));  
         marked2' =(marked2 (s2t_t s')); marked2 =(marked2 (s2t_t s))       
      in unmark2_frame s s' \<and> marked2' = marked2)"
  \<comment> \<open>unmark rely keeps everyone constant\<close>

definition 
  unmark2_guar :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "unmark2_guar s s' \<equiv> unmark2_frame s s'"

lemmas unmark2_defs = Let_def unmark2_pre_def hat_def unmark2_frame_def roots2_constant_def
                         unmark2_post_def unmark2_rely_def unmark2_guar_def
    
(* TODO: there must be a simpler way of doing this. Setup lifting? *)                         
lemma l2_unmark2_sigma_update_eq: "inv_Sigma2_R y \<Longrightarrow> 
      (s2t_t (s2t_r (y\<lparr>marked2 := roots2 y \<union> free2 y \<rparr>))) 
      = 
      y\<lparr>marked2 := roots2 y \<union> free2 y\<rparr>"    
  apply (cut_tac s2t_r_inverse[of "(y \<lparr> marked2 := roots2 y \<union> free2 y \<rparr>)"])
  apply simp_all
  unfolding inv_Sigma2_defs
  by simp
  (*
  apply (simp, elim conjE, rotate_tac 3, erule subst)
  apply (rule equalityI) defer 
  
  apply (simp add: inv_Sigma2_R_def inv_Sigma2_def s2t_r_inverse)
  apply safe
sorry*)
    
lemma l2_unmark2_fsb: "unmark2_pre s \<Longrightarrow> \<exists>s'. unmark2_post s s'" 
  unfolding unmark2_defs 
  apply (simp)
  find_theorems "s2t_t (s2t_r _)"
  apply (cases s, simp add: s2t_r_inverse)
  using [[show_types=false]]
  apply (rule_tac x="s2t_r (y \<lparr> marked2 := roots2 y \<union> free2 y \<rparr>)" in exI)
  by (cut_tac l2_unmark2_sigma_update_eq, simp_all) 
    
lemma l3_unmark2_rely_refl: "unmark2_rely s s"
  unfolding unmark2_defs
  by simp
    
lemma l4_unmark2_guar_refl: "unmark2_guar s s"
  unfolding unmark2_defs
  by simp
    
lemma l5_unmark2_rely_trans: "unmark2_rely s t \<Longrightarrow> unmark2_rely t u \<Longrightarrow> unmark2_rely s u"
  unfolding unmark2_defs
  by (safe,simp_all)
 
lemma l6_unmark2_guar_trans: "unmark2_guar s t \<Longrightarrow> unmark2_guar t u \<Longrightarrow> unmark2_guar s u"
  unfolding unmark2_defs
  by (safe,simp_all)
 
lemma l7_unmark2_post_guar: "unmark2_pre s \<Longrightarrow> (\<exists>s'. unmark2_post s s' \<and> unmark2_guar s s')"
  unfolding unmark2_defs
  apply (cases s, simp add: s2t_r_inverse)
  apply (rule_tac x="s2t_r (y \<lparr> marked2 := roots2 y \<union> free2 y \<rparr>)" in exI)
  by (cut_tac l2_unmark2_sigma_update_eq, simp_all) 
   
lemma l8_unmark2_pre_rely: "unmark2_pre s \<Longrightarrow> unmark2_rely s s' \<Longrightarrow> unmark2_pre s'"
  unfolding unmark2_defs by blast

lemma "inv_Sigma2_R \<lparr>roots2 = {}, hp2 = empty_heap, free2 = ALL_ADDR, marked2 = ALL_ADDR\<rparr>"
  unfolding inv_Sigma2_defs apply simp_all done
   
lemma l9_unmark2_rely_comp_post: 
  "unmark2_pre s \<Longrightarrow> (unmark2_rely ;; unmark2_post) s s' \<Longrightarrow> unmark2_post s s'"
  apply (erule spec_compE)
  apply (cases s, cases s', case_tac s0, simp)
  unfolding unmark2_defs
  by (simp_all add: s2t_r_inverse)
 
lemma l11_unmark2_post_comp_rely: 
  "(unmark2_post ;; unmark2_rely) s s' \<Longrightarrow> unmark2_post s s'"
  apply (erule spec_compE)
  unfolding unmark2_defs by blast
    
interpretation unmark2: RG_VCG
  inv_Sigma2_T unmark2_pre unmark2_post unmark2_rely unmark2_guar
  apply (unfold_locales, safe)
  apply (simp add: l2_unmark2_fsb)
  apply (simp add: l3_unmark2_rely_refl)
  apply (simp add: l4_unmark2_guar_refl)
  apply (rule l5_unmark2_rely_trans, simp_all)
  apply (rule l6_unmark2_guar_trans, simp_all)
  apply (simp add: l7_unmark2_post_guar)
  apply (simp add: l8_unmark2_pre_rely)
  apply (simp add: l9_unmark2_rely_comp_post)
  apply (simp add: l11_unmark2_post_comp_rely)
  done

(*
Mark
ext   wr marked
      rd hp, roots, free
pre   True
rely  marked' = marked \<and> free' = free \<and> hp' = hp \<and> roots' = roots (missing roots=)
guar  True
post  marked' = (free \<union> (reach roots hp))
*)  
  
definition
  mark2_frame :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
 "mark2_frame s s' \<equiv> 
    (let hp2'=(hp2 (s2t_t s')); hp2 =(hp2 (s2t_t s));
         free2'=(free2 (s2t_t s')); free2 =(free2 (s2t_t s))
     in
      roots2_constant s s' \<and> hp2' = hp2 \<and> free2' = free2)"   

lemma l_mark_unmark_frame_eq: "mark2_frame = unmark2_frame" 
unfolding mark2_frame_def unmark2_frame_def by simp
    
definition 
  mark2_pre :: "Sigma2Type \<Rightarrow> \<bool>"
where
  "mark2_pre s \<equiv> True"
  
definition 
  mark2_post :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "mark2_post s s' \<equiv> 
    (let roots2=(roots2 (s2t_t s));
         free2 =(free2 (s2t_t s)); 
         hp2 = (hp2 (s2t_t s));
         marked2'=(marked2 (s2t_t s'))
      in 
      marked2' = (free2 \<union> (reach roots2 hp2)))"
  
definition 
  mark2_rely :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "mark2_rely s s' \<equiv>
    (let marked2' =(marked2 (s2t_t s')); marked2 =(marked2 (s2t_t s))       
      in mark2_frame s s' \<and> marked2' = marked2)"

lemma l_mark_unmark_rely_eq: "mark2_rely = unmark2_rely" 
unfolding mark2_rely_def unmark2_rely_def by (simp add: l_mark_unmark_frame_eq)

definition 
  mark2_guar :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "mark2_guar s s' \<equiv> mark2_frame s s'"

lemmas mark2_defs = Let_def mark2_pre_def hat_def mark2_frame_def roots2_constant_def
                         mark2_post_def mark2_rely_def mark2_guar_def
    

(* TODO: there must be a simpler way of doing this. Setup lifting? *)                         
lemma l2_mark2_sigma_update_eq: "inv_Sigma2_R y \<Longrightarrow> 
      (s2t_t (s2t_r (y\<lparr>marked2 := free2 y \<union> reach (roots2 y) (hp2 y)\<rparr>))) 
      = 
      y\<lparr>marked2 := free2 y \<union> reach (roots2 y) (hp2 y)\<rparr>"    
  apply (cut_tac s2t_r_inverse[of "(y \<lparr> marked2 := free2 y \<union> reach (roots2 y) (hp2 y) \<rparr>)"])
  apply simp_all
  unfolding inv_Sigma2_defs
  apply (safe, simp_all)
      apply auto[1]
     apply blast
    apply blast
   apply blast thm mk_disjoint_insert (* neat theorem *)
(*
  apply blast
  apply blast 
    apply blast
    apply blast*)
      by (meson contra_subsetD l_filter_within_reach)
    
lemma l2_mark2_fsb: "mark2_pre s \<Longrightarrow> \<exists>s'. mark2_post s s'" 
  unfolding mark2_defs 
  apply (simp)
  find_theorems "s2t_t (s2t_r _)"
  apply (cases s, simp add: s2t_r_inverse)
  using [[show_types=false]]
  apply (rule_tac x="s2t_r (y \<lparr> marked2 := free2 y \<union> reach (roots2 y) (hp2 y) \<rparr>)" in exI)
  by (simp add: l2_mark2_sigma_update_eq)
  (* This solves the goal, but want to avoid smt 
  thm l_filter_within_reach mem_Collect_eq s2t_r_inverse[simplified] Sigma2.surjective[symmetric]
          sup.cobounded2 sup.order_iff sup_commute sup_left_commute
  by (smt Sigma2.select_convs(1) Sigma2.select_convs(2) 
          Sigma2.select_convs(3) Sigma2.select_convs(4) 
          Sigma2.surjective Sigma2.update_convs(4) 
          inv_Sigma2_R_def inv_Sigma2_def 
          l_filter_within_reach mem_Collect_eq s2t_r_inverse 
          sup.cobounded2 sup.order_iff sup_commute sup_left_commute)
    *)
    
lemma l3_mark2_rely_refl: "mark2_rely s s"
  unfolding mark2_defs
  by simp
    
lemma l4_mark2_guar_refl: "mark2_guar s s"
  unfolding mark2_defs
  by simp
    
lemma l5_mark2_rely_trans: "mark2_rely s t \<Longrightarrow> mark2_rely t u \<Longrightarrow> mark2_rely s u"
  unfolding mark2_defs
  by (safe,simp_all)
 
lemma l6_mark2_guar_trans: "mark2_guar s t \<Longrightarrow> mark2_guar t u \<Longrightarrow> mark2_guar s u"
  unfolding mark2_defs
  by (safe,simp_all)
 
lemma l7_mark2_post_guar: "mark2_pre s \<Longrightarrow> (\<exists>s'. mark2_post s s' \<and> mark2_guar s s')"
  unfolding mark2_defs
  apply (cases s, simp add: s2t_r_inverse)
  apply (rule_tac x="s2t_r (y \<lparr> marked2 := free2 y \<union> reach (roots2 y) (hp2 y) \<rparr>)" in exI)
  by (simp add: l2_mark2_sigma_update_eq)
  (*
  apply (smt Sigma2.select_convs(1) Sigma2.select_convs(2) 
             Sigma2.select_convs(3) Sigma2.select_convs(4) 
             Sigma2.surjective Sigma2.update_convs(4) 
             inf_sup_ord(3) inf_sup_ord(4) inv_Sigma2_R_def 
             inv_Sigma2_def l_filter_within_reach le_sup_iff 
             mem_Collect_eq s2t_r_inverse subset_trans)  
  *)
   
lemma l8_mark2_pre_rely: "mark2_pre s \<Longrightarrow> mark2_rely s s' \<Longrightarrow> mark2_pre s'"
  unfolding mark2_defs by blast
   
lemma l9_mark2_rely_comp_post: 
  "mark2_pre s \<Longrightarrow> (mark2_rely ;; mark2_post) s s' \<Longrightarrow> mark2_post s s'"
  apply (erule spec_compE)
  apply (cases s, cases s', case_tac s0, simp)
  unfolding mark2_defs
  by (simp_all add: s2t_r_inverse)
 
lemma l11_mark2_post_comp_rely: 
  "(mark2_post ;; mark2_rely) s s' \<Longrightarrow> mark2_post s s'"
  apply (erule spec_compE)
  unfolding mark2_defs by blast
    
interpretation mark2: RG_VCG
  inv_Sigma2_T mark2_pre mark2_post mark2_rely mark2_guar
  apply (unfold_locales, safe)
  apply (simp add: l2_mark2_fsb)
  apply (simp add: l3_mark2_rely_refl)
  apply (simp add: l4_mark2_guar_refl)
  apply (rule l5_mark2_rely_trans, simp_all)
  apply (rule l6_mark2_guar_trans, simp_all)
  apply (simp add: l7_mark2_post_guar)
  apply (simp add: l8_mark2_pre_rely)
  apply (simp add: l9_mark2_rely_comp_post)
  apply (simp add: l11_mark2_post_comp_rely)
  done    

(*
Sweep
ext   wr hp, free, marked
      rd roots
pre   True
rely  marked' = marked \<and> free' = free \<and> hp' = hp \<and> roots' = roots (missing roots=)
guar  True
post  free' = free \<union> (ALL_ADDR - marked) \<and> hp' = hp \<dagger> [ a \<mapsto> Some [] | a \<in> marked ]
*)  
  
definition
  sweep2_frame :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
 "sweep2_frame s s' \<equiv> 
    (let hp2'=(hp2 (s2t_t s')); hp2 =(hp2 (s2t_t s))
     in
      roots2_constant s s')"   

definition 
  sweep2_pre :: "Sigma2Type \<Rightarrow> \<bool>"
where
  "sweep2_pre s \<equiv> True"
  
definition 
  sweep2_post :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "sweep2_post s s' \<equiv> 
    (let free2'=(free2 (s2t_t s')); free2 =(free2 (s2t_t s));
         hp2'=(hp2 (s2t_t s')); hp2 =(hp2 (s2t_t s)); 
         marked2=(marked2 (s2t_t s))
      in 
      free2' = (free2 \<union> (ALL_ADDR - marked2)) \<and>
      hp2' = hp2 \<dagger> (marked2 \<triangleleft> empty_heap))"
  
definition 
  sweep2_rely :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "sweep2_rely s s' \<equiv>
    (let marked2' =(marked2 (s2t_t s')); marked2 =(marked2 (s2t_t s));
         free2' =(free2 (s2t_t s')); free2 =(free2 (s2t_t s))      ;  
         hp2' =(hp2 (s2t_t s')); hp2 =(hp2 (s2t_t s))        
      in roots2_constant s s' \<and> marked2' = marked2 \<and> free2' = free2 \<and> hp2' = hp2)"

definition 
  sweep2_guar :: "Sigma2Type \<Rightarrow> Sigma2Type \<Rightarrow> \<bool>"
where
  "sweep2_guar s s' \<equiv> sweep2_frame s s'"

lemmas sweep2_defs = Let_def sweep2_pre_def hat_def sweep2_frame_def roots2_constant_def
                         sweep2_post_def sweep2_rely_def sweep2_guar_def

lemma l_empty_heap_override: "dom m = ALL_ADDR \<Longrightarrow> m \<dagger> empty_heap = empty_heap"
  unfolding dagger_def empty_heap_def 
  apply (rule ext, simp)
  by blast

lemma l_empty_marked_heap: "marked \<subseteq> ALL_ADDR \<Longrightarrow> (marked \<triangleleft> empty_heap) = (\<lambda> x . if x \<in> marked then Some [] else None)"
  unfolding empty_heap_def apply (rule ext, simp, safe)
   apply (metis (mono_tags, lifting) contra_subsetD f_in_dom_r_apply_elem)
  by (simp add: dom_restr_def)
    
lemma l_empty_marked_heap_apply: "x \<in> marked \<Longrightarrow> marked \<subseteq> ALL_ADDR \<Longrightarrow> (marked \<triangleleft> empty_heap) x = Some []" 
  by (simp add: l_empty_marked_heap)
    
lemma l_within_roots_reach: "x \<in> r \<Longrightarrow> x \<in> (reach r hp)"
  using l_filter_within_reach by blast
  
experiment
begin
lemma   "inv_Sigma2 r hp free m \<Longrightarrow> inv_Sigma2 r (hp \<dagger> (m \<triangleleft> empty_heap)) (free  \<union> (ALL_ADDR - m)) m" 
  unfolding inv_Sigma2_def
  apply (simp, safe)
    unfolding inv_Sigma1_def apply safe
  oops
end

lemma l2_sweep2_sigma_update_inv:
      "inv_Sigma2 r hp free m \<Longrightarrow> 
       inv_Sigma2 r (hp \<dagger> (m \<triangleleft> empty_heap)) (free  \<union> (ALL_ADDR - m)) m"
  unfolding inv_Sigma2_defs
  apply (simp, elim conjE, intro conjI)
  apply (metis l_dagger_dom l_dom_r_dom_subseteq l_empty_heap_dom sup.order_iff)
  (* This is to avoid apply safe getting to contradictory hypothesis *)  
  apply (rotate_tac 1, erule subst, rotate_tac 3, erule subst)
  apply (intro equalityI subsetI)
  apply simp_all
  apply (elim conjE disjE, intro conjI, assumption)
  (*apply (simp add: l_within_roots_reach)*) defer
  apply (intro conjI, erule notE) defer defer defer
  apply (simp add: l_within_roots_reach)
     apply (erule conjE)
    defer
    apply (intro l_empty_heap_image_subset)
    apply simp
    apply (intro conjI) defer 
      apply simp
     defer defer defer 
     apply simp
    defer 
    apply (erule ssubst)
    defer defer
    
  sorry 
    
(* TODO: there must be a simpler way of doing this. Setup lifting? *)                         
lemma l2_sweep2_sigma_update_eq: "inv_Sigma2_R y \<Longrightarrow> 
      (s2t_t (s2t_r (y\<lparr>free2 := free2 y \<union> (ALL_ADDR - marked2 y)\<rparr>\<lparr> hp2 := (hp2 y) \<dagger> (marked2 y) \<triangleleft> empty_heap\<rparr>))) 
      = 
      y\<lparr>free2 := free2 y \<union> (ALL_ADDR - marked2 y)\<rparr>\<lparr> hp2 := (hp2 y) \<dagger> ((marked2 y) \<triangleleft> empty_heap)\<rparr>"    
  apply (cut_tac s2t_r_inverse[of 
     "y\<lparr>free2 := free2 y \<union> (ALL_ADDR - marked2 y)\<rparr>\<lparr> hp2 := (hp2 y) \<dagger> ((marked2 y) \<triangleleft> empty_heap)\<rparr>"])
   apply simp_all
  unfolding inv_Sigma2_R_def
   by (cut_tac l2_sweep2_sigma_update_inv, simp_all)
 
lemma l2_sweep2_fsb: "sweep2_pre s \<Longrightarrow> \<exists>s'. sweep2_post s s'" 
  unfolding sweep2_defs 
  apply (cases s, simp add: s2t_r_inverse)
  apply (rule_tac x="s2t_r (y \<lparr> free2 := free2 y \<union> (ALL_ADDR - marked2 y) \<rparr>
                              \<lparr> hp2 := (hp2 y) \<dagger> ((marked2 y) \<triangleleft> empty_heap)\<rparr>)" in exI)
  by (cut_tac l2_sweep2_sigma_update_eq, simp_all)
  (*by (metis (no_types, lifting) Sigma2.ext_inject Sigma2.surjective Sigma2.update_convs(2) Sigma2.update_convs(3) s2t_t_inverse)*)
    
lemma l3_sweep2_rely_refl: "sweep2_rely s s"
  unfolding sweep2_defs
  by simp
    
lemma l4_sweep2_guar_refl: "sweep2_guar s s"
  unfolding sweep2_defs
  by simp
    
lemma l5_sweep2_rely_trans: "sweep2_rely s t \<Longrightarrow> sweep2_rely t u \<Longrightarrow> sweep2_rely s u"
  unfolding sweep2_defs
  by (safe,simp_all)
 
lemma l6_sweep2_guar_trans: "sweep2_guar s t \<Longrightarrow> sweep2_guar t u \<Longrightarrow> sweep2_guar s u"
  unfolding sweep2_defs
  by (safe,simp_all)

lemma l7_sweep2_post_guar: "sweep2_pre s \<Longrightarrow> (\<exists>s'. sweep2_post s s' \<and> sweep2_guar s s')"
  unfolding sweep2_defs 
  apply (cases s, simp add: s2t_r_inverse)
  apply (rule_tac x="s2t_r (y \<lparr> free2 := free2 y \<union> (ALL_ADDR - marked2 y) \<rparr>\<lparr> hp2 := (marked2 y) \<triangleleft> empty_heap\<rparr>)" in exI)
  apply (cut_tac l2_sweep2_sigma_update_eq, simp_all)
  (*by (smt Diff_cancel Int_commute Sigma2.select_convs(1) Sigma2.select_convs(2) Sigma2.select_convs(3) Sigma2.surjective Sigma2.update_convs(2) Sigma2.update_convs(3) Un_Diff_Int Un_Diff_cancel2 Un_assoc inv_Sigma2_R_def inv_Sigma2_defs(2) l2_sweep2_sigma_update_inv l_diff_union l_dom_r_accum l_empty_heap_ALL_ADDR_absorb l_empty_heap_override sup.commute sup.order_iff sup_bot.right_neutral)*)
  (*by (metis inv_Sigma1_def inv_Sigma2_R_def inv_Sigma2_def l2_sweep2_sigma_update_inv l_dagger_lhs_absorb_ALT_PROOF l_dom_r_dom_subseteq l_empty_heap_dom)*)
  sorry
    
lemma l8_sweep2_pre_rely: "sweep2_pre s \<Longrightarrow> sweep2_rely s s' \<Longrightarrow> sweep2_pre s'"
  unfolding sweep2_defs by blast

lemma l9_sweep2_rely_comp_post: 
  "sweep2_pre s \<Longrightarrow> (sweep2_rely ;; sweep2_post) s s' \<Longrightarrow> sweep2_post s s'"
  apply (erule spec_compE)
  apply (cases s, cases s', case_tac s0, simp)
  unfolding sweep2_defs
  by (simp_all add: s2t_r_inverse)
 
lemma l11_sweep2_post_comp_rely: 
  "(sweep2_post ;; sweep2_rely) s s' \<Longrightarrow> sweep2_post s s'"
  apply (erule spec_compE)
  unfolding sweep2_defs by simp
    
interpretation sweep2: RG_VCG
  inv_Sigma2_T sweep2_pre sweep2_post sweep2_rely sweep2_guar
  apply (unfold_locales, safe)
  apply (simp add: l2_sweep2_fsb)
  apply (simp add: l3_sweep2_rely_refl)
  apply (simp add: l4_sweep2_guar_refl)
  apply (rule l5_sweep2_rely_trans, simp_all)
  apply (rule l6_sweep2_guar_trans, simp_all)
  apply (simp add: l7_sweep2_post_guar)
  apply (simp add: l8_sweep2_pre_rely)
  apply (simp add: l9_sweep2_rely_comp_post)
  apply (simp add: l11_sweep2_post_comp_rely)
  done  

lemma l_unmark2_coherence: "\<lbrakk> mark2_guar s s'; sweep2_guar s s'\<rbrakk> \<Longrightarrow> unmark2_rely s s'"
  unfolding mark2_defs sweep2_defs unmark2_defs
  apply simp nitpick oops

lemma l_mark2_coherence: "\<lbrakk> unmark2_guar s s'; sweep2_guar s s'\<rbrakk> \<Longrightarrow> mark2_rely s s'"
  unfolding mark2_defs sweep2_defs unmark2_defs
  apply simp nitpick oops

lemma l_sweep2_coherence: "\<lbrakk> unmark2_guar s s'; mark2_guar s s'\<rbrakk> \<Longrightarrow> sweep2_rely s s'"
  unfolding mark2_defs sweep2_defs unmark2_defs
  apply simp nitpick oops

    (* Figuring out the types exchanges *)
lemma "unmark2_post s s \<Longrightarrow> retr1 (s2t_t s) = s2 \<Longrightarrow> (s1t_r s2) = s3 \<Longrightarrow> collector1_post s3 s3"
  using [[show_types]] 
  oops
    
text \<open> Cliff's Theorem 4 \<close>
theorem "unmark2_post s s' \<Longrightarrow> mark2_post s' s'' \<Longrightarrow> sweep2_post s'' s''' \<Longrightarrow> collector1_post (s1t_r (retr1 (s2t_t s))) (s1t_r (retr1 (s2t_t s''')))"                         
  unfolding unmark2_defs mark2_defs sweep2_defs collector1_post_def
  apply simp
  done
    
consts
    p :: "\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<bool>"
    relyA :: "\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<bool>"
    guarB :: "\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<bool>"
    
lemma "(p v st) \<and> 
       (guarB st st') \<and>
       (\<forall> s  s'  x . (p x s) \<and> guarB s s' \<longrightarrow> (p x s')) \<Longrightarrow>
       (\<forall> s  s' . (p v s) \<and> (p v s') \<longrightarrow> relyA s s') \<Longrightarrow> relyA st st'"   
  apply (elim conjE)
  apply (erule allE[of _ "st"])
  apply (erule allE [of _ "st"])
  apply (erule allE[of _ "st'"])
  apply (erule allE [of _ "st'"])
  apply (erule allE [of _ "v"])
  by simp
    
    
    
    
  lemma "A\<^sub>1 \<in> reach {A\<^sub>2}
            (\<lambda>a. if a = A\<^sub>2 then Some [Some A\<^sub>1]
                 else if a = A\<^sub>1 then Some [Some A\<^sub>1] else None)"
  unfolding reach_defs
  apply (simp)
  find_theorems intro
  apply (rule r_into_rtrancl, simp)
  apply (simp add: domIff)
  done 
 


lemma l2_aux2: "dom hp = ALL_ADDR \<Longrightarrow>
  free \<inter> reach r hp = {} \<Longrightarrow>
  ran (free \<triangleleft> hp) \<subseteq> {[]} \<Longrightarrow> r \<subseteq> m \<Longrightarrow> free \<subseteq> m \<Longrightarrow> (free \<union> (ALL_ADDR - m)) \<inter> reach r hp = {}" 
  oops
    
thm inv_Sigma2_def[of "{A\<^sub>1}" "[A\<^sub>1 \<mapsto> [Some A\<^sub>2], A\<^sub>2 \<mapsto> [Some A\<^sub>2]]" "{}" "{A\<^sub>1}"]
  
lemma "(S \<inter> R) \<subseteq> (S \<union> T) \<inter> R" by safe
lemma "S \<inter> T ={}  \<Longrightarrow> (S \<union> T) \<inter> R \<subseteq> (S \<inter> R)" oops
lemma "(S \<union> T) \<inter> R = (S \<inter> R)" 
  apply (intro equalityI subsetI) apply simp_all apply (elim conjE disjE, simp) oops
    
lemma "(free \<union> (ALL_ADDR - m)) \<inter> R = free \<inter> R"  
                   oops      

lemma l2_aux:"reach {A\<^sub>1} [A\<^sub>1 \<mapsto> [Some A\<^sub>2], A\<^sub>2 \<mapsto> [Some A\<^sub>2]] = {A\<^sub>1,A\<^sub>2}"
unfolding reach_defs apply simp apply safe defer 
apply (rule r_into_rtrancl, simp)
  apply (simp add: domIff)
 find_theorems elim 
  apply (erule rtranclE)
  apply simp
  apply (safe, simp split: if_splits, simp)
  apply (simp split:if_splits)
  done

lemma l2_aux2:"reach {A\<^sub>2} [A\<^sub>1 \<mapsto> [Some A\<^sub>1], A\<^sub>2 \<mapsto> [Some A\<^sub>1]] = {A\<^sub>1,A\<^sub>2}"
unfolding reach_defs apply simp apply safe defer 
apply (rule r_into_rtrancl, simp)
  apply (simp add: domIff)
 find_theorems elim 
  apply (erule rtranclE)
  apply simp
  apply (safe, simp split: if_splits, simp)
  apply (simp split:if_splits)
   done

lemma "{A\<^sub>2, A\<^sub>1} = ALL_ADDR \<Longrightarrow>
    ran ({} \<triangleleft> [A\<^sub>1 \<mapsto> [Some A\<^sub>2], A\<^sub>2 \<mapsto> [Some A\<^sub>2]]) \<subseteq> {[]} \<Longrightarrow>
    (ALL_ADDR - {A\<^sub>1}) \<inter> reach {A\<^sub>1} [A\<^sub>1 \<mapsto> [Some A\<^sub>2], A\<^sub>2 \<mapsto> [Some A\<^sub>2]] = {}"
apply (simp add: l2_aux)
  apply (erule subst, safe) unfolding dom_restr_def apply simp oops

lemma "inv_Sigma1 {A\<^sub>1} [A\<^sub>1 \<mapsto> [Some A\<^sub>2], A\<^sub>2 \<mapsto> [Some A\<^sub>2]] {} \<and> {A\<^sub>1} \<subseteq> {A\<^sub>1}"    
  apply simp
  unfolding inv_Sigma1_defs
  apply (simp add: l2_aux l_dom_r_nothing) 
  oops
lemma "r \<union> (f \<union> (ALL_ADDR - m)) \<subseteq> m'" apply simp apply rule defer apply rule defer
  find_theorems "_ - _ \<subseteq> _"
    apply (simp add: Diff_subset_conv) oops
lemma "S \<subseteq> f \<union> (ALL_ADDR - (f \<union> (reach r hp)))"
  apply (rule, simp) oops
    

end