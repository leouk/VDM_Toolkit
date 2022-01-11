(* $Id$ *)
(*<*)
theory GC0
imports RGToolkit
begin
(*>*)
   
(* TODO: add it as finite? *)  
typedecl Addr
  
typedef Addrs = "{ (a::Addr set) . finite a }" 
  morphisms Rep_Addrs Abs_Addrs by auto
  
print_theorems
setup_lifting type_definition_Addrs
  
lift_definition
  Addr_as_Set :: "Addrs \<Rightarrow> Addr set" ("(_`)" [103] 102) is "\<lambda> S . S" . 

definition 
  ALL_ADDR0 :: "Addrs" 
where
  "ALL_ADDR0 \<equiv> (Abs_Addrs UNIV)"

consts
  an_addr  :: Addr
  ALL_ADDR :: "Addr set" 
  
specification (all_addr: ALL_ADDR adr: an_addr)
   l_ALL_ADDR_finite[simp]: "finite (ALL_ADDR)"
   l_ALL_ADDR_not_empty[simp]: "an_addr \<in> ALL_ADDR"
   by blast

lemma "ALL_ADDR0` = ALL_ADDR"
  unfolding ALL_ADDR0_def Addr_as_Set_def
  apply (simp_all)
  oops   
(*
definition
   ALL_ADDR :: "Addr set"
where
   "ALL_ADDR \<equiv> (SOME x . finite x \<and> x \<noteq> {})" = BAD! 
*)     
     
lemma l_Addrs_finite[simp]: "finite (ALL_ADDR0`)" 
  using Addr_as_Set.rep_eq Rep_Addrs by auto
      
(*
instance Addrs :: finite
  apply (intro_classes)
  find_theorems name:Addrs name:Abs
  apply (rule Abs_Addrs_induct)
  apply simp oops *) 
(*    
definition
  hat0 :: "Addrs \<Rightarrow> Addrs VDMSet"
where
  "hat0 s \<equiv> { (x``) | x . x \<subseteq> s` }"
  *)
(* TODO: propagage Addrs everywhere Addr VDMSet is used *)
  
definition
  hat :: "Addr VDMSet \<Rightarrow> Addr VDMSet VDMSet"
where
  "hat s \<equiv> { ALL_ADDR }"

record Sigma0 =
  busy0 :: "Addr VDMSet"
  free0 :: "Addr VDMSet"

definition
  garbage0 :: "Addr VDMSet \<Rightarrow> Addr VDMSet \<Rightarrow> Addr VDMSet"
where
  "garbage0 busy free \<equiv> ALL_ADDR - (busy \<union> free)"

definition
  inv_Sigma0 :: "Addr VDMSet \<Rightarrow> Addr VDMSet \<Rightarrow> \<bool>"
where
  "inv_Sigma0 busy free \<equiv> 
       free \<inter> busy = {} \<and> 
       free \<union> busy \<union> (garbage0 busy free) = ALL_ADDR"
  \<comment> \<open>TODO: here if we had used Addrs for the type these considerations wouldn't be needed\<close>

lemma f_garbage0_disjoint: "inv_Sigma0 busy free \<Longrightarrow> 
    garbage0 busy free \<inter> busy ={} \<and>
    garbage0 busy free \<inter> free = {}"
  unfolding inv_Sigma0_def garbage0_def
    by blast
  
definition
  inv_Sigma0_R :: "Sigma0 \<Rightarrow> \<bool>"
where
  "inv_Sigma0_R s \<equiv> inv_Sigma0 (busy0 s) (free0 s)"

lemmas inv_Sigma0_defs = inv_Sigma0_R_def inv_Sigma0_def garbage0_def
  
(* { expr | var . filter }, { var \<in> type . filter }, { var . filter } *)
typedef Sigma0Type = "{ s . inv_Sigma0_R s }"
  morphisms s0t_t (* st: Sigma0Type \<Rightarrow> Sigma0 *) 
            s0t_r (* rc: Sigma0 \<Rightarrow> Sigma0Type *)
  unfolding inv_Sigma0_defs inv_SetElems_def 
  apply simp
  apply (rule exI[of _ "\<lparr>busy0 = {}, free0 = ALL_ADDR\<rparr>"])
  by (simp add: inv_VDMNat_def)

definition
  inv_Sigma0_T :: "Sigma0Type \<Rightarrow> \<bool>"
where
  "inv_Sigma0_T s \<equiv> inv_Sigma0_R (s0t_t s)" 

(*================================================================*)
  
instantiation Sigma0Type :: VDM
begin

definition 
  "st_inv_Sigma0Type s \<longleftrightarrow> inv_Sigma0_T s"

lemma l_Sigma0_valid: "inv_Sigma0_T s"
using inv_Sigma0_T_def s0t_t by auto
  
instance 
  using inv_Sigma0_T_def st_inv_Sigma0Type_def s0t_t 
  by (intro_classes, auto)
    
end

(*
Collector
ext   wr free
      rd busy
pre   True
rely  (busy' - busy) \<subseteq> free \<and> 
      free' \<subseteq> free
guar  free \<subseteq> free'
post  (ALL_ADDR - busy) \<subseteq> \<Union> (hat free)
*)  
  
definition
  collector0_frame :: "Sigma0Type \<Rightarrow> Sigma0Type \<Rightarrow> \<bool>"
where
 "collector0_frame s s' \<equiv> 
    (let busy0'=(busy0 (s0t_t s')); busy0 =(busy0 (s0t_t s)) in
      busy0' = busy0)"   
  
definition 
  collector0_pre :: "Sigma0Type \<Rightarrow> \<bool>"
where
  "collector0_pre s \<equiv> True"
  
definition 
  collector0_post :: "Sigma0Type \<Rightarrow> Sigma0Type \<Rightarrow> \<bool>"
where
  "collector0_post s s' \<equiv> 
    (let busy0'=(busy0 (s0t_t s')); busy0 =(busy0 (s0t_t s));  
         free0 =(free0 (s0t_t s)) in
          ALL_ADDR - busy0 \<subseteq> \<Union> (hat free0))"

definition 
  collector0_rely :: "Sigma0Type \<Rightarrow> Sigma0Type \<Rightarrow> \<bool>"
where
  "collector0_rely s s' \<equiv>
    (let busy0'=(busy0 (s0t_t s')); free0'=(free0 (s0t_t s'));
         busy0 =(busy0 (s0t_t s));  free0 =(free0 (s0t_t s))          
      in busy0' - busy0 \<subseteq> free0 \<and> free0' \<subseteq> free0)"

definition 
  collector0_guar :: "Sigma0Type \<Rightarrow> Sigma0Type \<Rightarrow> \<bool>"
where
  "collector0_guar s s' \<equiv> 
    (let free0'=(free0 (s0t_t s')); free0 =(free0 (s0t_t s)) in 
        collector0_frame s s' \<and>
        free0 \<subseteq> free0')"

lemmas collector0_guar_defs = 
                         collector0_frame_def
                         collector0_guar_def
lemmas collector0_defs = Let_def hat_def 
                         collector0_pre_def 
                         collector0_post_def 
                         collector0_rely_def 
                         collector0_guar_defs 

(*
Mutator
ext   wr bury, free
pre   True
rely  busy' = busy \<and> 
      free \<subseteq> free'
guar  (busy' - busy) \<subseteq> free \<and> 
      free' \<subseteq> free
post  True
*)  
                         
definition 
  mutator0_frame :: "Sigma0Type \<Rightarrow> Sigma0Type \<Rightarrow> \<bool>"
where
  "mutator0_frame s s' \<equiv> True"

definition 
  mutator0_pre :: "Sigma0Type \<Rightarrow> \<bool>"
where
  "mutator0_pre s \<equiv> True"
  
definition 
  mutator0_post :: "Sigma0Type \<Rightarrow> Sigma0Type \<Rightarrow> \<bool>"
where
  "mutator0_post s s' \<equiv> True"

definition 
  mutator0_rely :: "Sigma0Type \<Rightarrow> Sigma0Type \<Rightarrow> \<bool>"
where
  "mutator0_rely s s' \<equiv>
    (let busy0'=(busy0 (s0t_t s')); free0'=(free0 (s0t_t s'));
         busy0 =(busy0 (s0t_t s));  free0 =(free0 (s0t_t s))          
      in busy0' = busy0 \<and> free0 \<subseteq> free0')"

definition 
  mutator0_guar :: "Sigma0Type \<Rightarrow> Sigma0Type \<Rightarrow> \<bool>"
where
  "mutator0_guar s s' \<equiv> 
    (let busy0'=(busy0 (s0t_t s')); free0'=(free0 (s0t_t s'));
         busy0 =(busy0 (s0t_t s));  free0 =(free0 (s0t_t s))          
      in 
         mutator0_frame s s' \<and>
         busy0' - busy0 \<subseteq> free0 \<and> free0' \<subseteq> free0)"

lemmas mutator0_defs = Let_def mutator0_pre_def mutator0_frame_def
                       mutator0_post_def mutator0_rely_def mutator0_guar_def

(*context RG_VCG
begin*)

lemma l1_s0t_inv: "inv_Sigma0_T s"
  by (simp add: l_Sigma0_valid)

lemma l2_collector0_fsb: "collector0_pre s \<Longrightarrow> \<exists>s'. collector0_post s s'" 
  unfolding collector0_defs 
    by blast
    
lemma l3_collector0_rely_refl: "collector0_rely s s"
  unfolding collector0_defs
  by simp
    
lemma l4_collector0_guar_refl: "collector0_guar s s"
  unfolding collector0_defs
  by simp
    
lemma l5_collector0_rely_trans: "collector0_rely s t \<Longrightarrow> collector0_rely t u \<Longrightarrow> collector0_rely s u"
  unfolding collector0_defs
  apply safe
  apply blast
  by blast  

lemma l6_collector0_guar_trans: "collector0_guar s t \<Longrightarrow> collector0_guar t u \<Longrightarrow> collector0_guar s u"
  unfolding collector0_defs
  apply safe
  apply blast
  apply blast
  by blast

lemma l7_collector0_post_guar: "collector0_pre s \<Longrightarrow> (\<exists>s'. collector0_post s s' \<and> collector0_guar s s')"
  unfolding collector0_defs by blast
    
lemma l8_collector0_pre_rely: "collector0_pre s \<Longrightarrow> collector0_rely s s' \<Longrightarrow> collector0_pre s'"
  unfolding collector0_defs by blast
    
lemma l9_collector0_rely_comp_post: 
  "collector0_pre s \<Longrightarrow> (collector0_rely ;; collector0_post) s s' \<Longrightarrow> collector0_post s s'"
  apply (erule spec_compE)
  unfolding collector0_defs
  apply (elim conjE ssubst)
  by blast
  
lemma l10_collector0_post_comp_rely: 
  "(collector0_post ;; collector0_rely) s s' \<Longrightarrow> collector0_post s s'"
  apply (elim spec_compE)
  unfolding collector0_defs
  apply (elim conjE ssubst)
  by simp
    
lemma l2_mutator0_fsb: "mutator0_pre s \<Longrightarrow> \<exists>s'. mutator0_post s s'" 
  unfolding mutator0_defs by simp
    
lemma l3_mutator0_rely_refl: "mutator0_rely s s"
  unfolding mutator0_defs
  by simp
    
lemma l4_mutator0_guar_refl: "mutator0_guar s s"
  unfolding mutator0_defs
  by simp
    
lemma l5_mutator0_rely_trans: "mutator0_rely s t \<Longrightarrow> mutator0_rely t u \<Longrightarrow> mutator0_rely s u"
  unfolding mutator0_defs
  apply safe
  by blast+
    
lemma l6_mutator0_guar_trans: "mutator0_guar s t \<Longrightarrow> mutator0_guar t u \<Longrightarrow> mutator0_guar s u"
  unfolding mutator0_defs
  apply safe
  apply (meson DiffI collector0_rely_def contra_subsetD l5_collector0_rely_trans)
  by blast

lemma l7_mutator0_post_guar: "mutator0_pre s \<Longrightarrow> (\<exists>s'. mutator0_post s s' \<and> mutator0_guar s s')"
  unfolding mutator0_defs by blast
    
lemma l8_mutator0_pre_rely: "mutator0_pre s \<Longrightarrow> mutator0_rely s s' \<Longrightarrow> mutator0_pre s'"
  unfolding mutator0_defs by blast
    
lemma l9_mutator0_rely_comp_post: 
  "mutator0_pre s \<Longrightarrow> (mutator0_rely ;; mutator0_post) s s' \<Longrightarrow> mutator0_post s s'"
  apply (erule spec_compE)
  unfolding mutator0_defs by blast
    
lemma l10_mutator0_post_comp_rely: 
  "(mutator0_post ;; mutator0_rely) s s' \<Longrightarrow> mutator0_post s s'"
  apply (erule spec_compE)
  unfolding mutator0_defs by blast

interpretation Sigma0Type : VDM inv_Sigma0_T
  apply (unfold_locales)
  apply (simp add: l1_s0t_inv)
  done
    
interpretation collector0: RG_VCG  
  inv_Sigma0_T collector0_pre collector0_post collector0_rely collector0_guar
  apply (unfold_locales)
  apply (simp add: l2_collector0_fsb)
  apply (simp add: l3_collector0_rely_refl)
  apply (simp add: l4_collector0_guar_refl)
  using l5_collector0_rely_trans apply blast
  using l6_collector0_guar_trans apply blast
  apply (simp add: l7_collector0_post_guar) 
  using l8_collector0_pre_rely apply blast
  using l9_collector0_rely_comp_post apply blast
  apply (simp add: l10_collector0_post_comp_rely)
    done
  (*
  using l8_collector0_pre_rely apply blast
  apply (simp add: l9_collector0_rely_comp_post)
  apply (simp add: l10_collector0_post_comp_rely)
  apply (simp add: l7_collector0_post_guar)
  done*)

interpretation mutator0: RG_VCG
  inv_Sigma0_T mutator0_pre mutator0_post mutator0_rely mutator0_guar
  apply (unfold_locales)
  apply (simp add: l2_mutator0_fsb)
  apply (simp add: l3_mutator0_rely_refl)
  apply (simp add: l4_mutator0_guar_refl)
  using l5_mutator0_rely_trans apply blast
  using l6_mutator0_guar_trans apply blast
  apply (simp add: l7_mutator0_post_guar)
  using l8_mutator0_pre_rely apply blast
  apply (simp add: l9_mutator0_rely_comp_post)
  apply (simp add: l10_mutator0_post_comp_rely)
  done
    
(* We also need coherence between guarantee/relies of each operation *)
    
(*

lemma l7_mutator0_guar_rely: "mutator0_guar s s' \<Longrightarrow> mutator0_rely s s'"
  unfolding mutator0_defs
  apply (elim conjE ssubst)
  apply simp
  oops
    
lemma l7_collector0_guar_rely: "collector0_guar s s' \<Longrightarrow> collector0_rely s s'"
  unfolding collector0_defs
  apply (elim conjE ssubst)
  apply safe
  oops (* this is meant to be between operations not the same *)
locale RG_Coherence = st: RG_VCG + op2: RG_VCG for op1 and op2 
*)

text \<open> Cliff's Theorem 1 \<close>
lemma l_mutator0_coherence: "collector0_guar s s' \<longleftrightarrow> mutator0_rely s s'"
  unfolding Let_def mutator0_rely_def collector0_guar_defs by safe
lemma l_collector0_coherence: "mutator0_guar s s' \<longleftrightarrow>  collector0_rely s s'"
  unfolding Let_def mutator0_guar_def collector0_rely_def 
  by (simp add: mutator0_frame_def)
    
end
