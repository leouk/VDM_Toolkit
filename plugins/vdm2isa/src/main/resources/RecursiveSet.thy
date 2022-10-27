theory RecursiveSet
  imports VDMToolkit
begin

section \<open>Partial recursive functions\<close>

function findzero :: "(nat \<Rightarrow> nat) \<Rightarrow> nat \<Rightarrow> nat"
where
"findzero f n = (if f n = 0 then n else findzero f (Suc n))"
  by pat_completeness auto

find_theorems name:findzero
term findzero_dom

function (domintros) findzero' :: "(nat \<Rightarrow> nat) \<Rightarrow> nat \<Rightarrow> nat"
where
"findzero' f n = (if f n = 0 then n else findzero' f (Suc n))"
  by pat_completeness auto

section \<open>Well foundedness study on bounded @{text nat_term}\<close>

abbreviation \<open>NAT_MAX \<equiv> 3\<close>

definition 
  nat_term :: \<open>(\<nat> \<times> \<nat>) VDMSet\<close>
  where
  \<open>nat_term \<equiv> { (m, n) . n = Suc m \<and> n < NAT_MAX }\<close>

lemma l_nat_term_eq: \<open>nat_term = { (0, 1), (1, 2) }\<close> (*, (2, 3), (3, 4) }\<close>*)
  apply (simp add: nat_term_def, safe)
  by (simp_all) 

definition 
  nat_fin_psub :: \<open>((\<nat> \<times> \<nat>) VDMSet \<times> (\<nat> \<times> \<nat>) VDMSet) VDMSet\<close>
  where
(*\<open>nat_fin_psub \<equiv> finite_psubset :: ((\<nat> \<times> \<nat>) VDMSet \<times> (\<nat> \<times> \<nat>) VDMSet) VDMSet\<close> *)
  \<open>nat_fin_psub \<equiv> {(A, B). A \<subset> B \<and> finite B \<and> B \<subseteq> nat_term }\<close>

lemma l_nat_fin_psub_eq1: \<open>{({(0, 1)}, {(0, 1), (1, 2)}), ({(1, 2)}, {(0, 1), (1, 2)}), ({}, {(0, 1), (1, 2)}), ({}, {(0, 1)}), ({}, {(1, 2)})} \<subseteq> nat_fin_psub\<close>  
  apply (intro subsetI)
  unfolding nat_fin_psub_def
  apply (simp add: case_prod_beta)
  apply (elim disjE, simp_all add: l_nat_term_eq)
  by blast+

lemma l_nat_fin_psub_eq2:\<open>nat_fin_psub \<subseteq> {({(0, 1)}, {(0, 1), (1, 2)}), ({(1, 2)}, {(0, 1), (1, 2)}), ({}, {(0, 1), (1, 2)}), ({}, {(0, 1)}), ({}, {(1, 2)})}\<close>
  apply (intro subsetI)
  unfolding nat_fin_psub_def
  apply (simp add: case_prod_beta)
  apply (elim conjE)
  apply (simp add: subset_eq[of _ \<open>nat_term\<close>])
  apply (rule disjI2)+
  nitpick  
  sorry 

lemma \<open>nat_fin_psub = {({(0, 1)}, {(0, 1), (1, 2)}), ({(1, 2)}, {(0, 1), (1, 2)}), ({}, {(0, 1), (1, 2)}), ({}, {(0, 1)}), ({}, {(1, 2)})}\<close>
  apply (rule equalityI)
   apply (rule l_nat_fin_psub_eq2)
  apply (rule l_nat_fin_psub_eq1)
  done

definition 
  nat_lex_nat :: \<open>(((\<nat> \<times> \<nat>) set \<times> \<nat>) \<times> ((\<nat> \<times> \<nat>) set \<times> \<nat>)) set\<close>
  where
  \<open>nat_lex_nat \<equiv> nat_fin_psub <*lex*> nat_term\<close>

definition lex_prod' :: "('a \<times>'a) set \<Rightarrow> ('b \<times> 'b) set \<Rightarrow> (('a \<times> 'b) \<times> ('a \<times> 'b)) set"
    (infixr "<*lexi*>" 80)
    where "ra <*lexi*> rb = {((a, b), (a', b')). (a, a') \<in> ra } \<union> 
                            {((a, b), (a', b')). a = a' \<and> (b, b') \<in> rb}"

lemma lex_prod_equiv: "(ra <*lex*> rb) = (ra <*lexi*>rb)"
  by (safe, simp_all add: lex_prod_def lex_prod'_def)

datatype T = A | B | C | D

definition 
  t_term :: \<open>(T \<times> T) VDMSet\<close>
  where
  \<open>t_term \<equiv> { (A, B), (B, C), (C, D) }\<close>

definition 
  t_fin_psub :: \<open>((T \<times> T) VDMSet \<times> (T \<times> T) VDMSet) VDMSet\<close>
  where
  \<open>t_fin_psub \<equiv> {(A, B). A \<subset> B \<and> finite B \<and> B \<subseteq> t_term }\<close>


definition 
  gen_lex_nat :: \<open>(('a VDMSet \<times> \<nat>) \<times> 'a VDMSet \<times> \<nat>) set\<close>
  where
  \<open>gen_lex_nat \<equiv> finite_psubset <*lex*> nat_term\<close>



lemma \<open>nat_lex_nat = A\<close>
  apply (simp add: nat_lex_nat_def nat_fin_psub_def nat_term_def lex_prod_def)
  
section \<open>Sum-set function\<close>

definition 
  sumset_domain :: "VDMNat VDMSet \<Rightarrow> \<bool>" 
  where
  "sumset_domain s \<equiv> inv_SetElems inv_VDMNat s \<and> inv_VDMSet s"

function (domintros)
  sumset :: "VDMNat VDMSet \<Rightarrow> VDMNat" 
  where 
  "sumset s = 
    (if s = {} then 0 else let e = (SOME x . x \<in> s) in sumset (s - {e}) + e)"
  by (blast, force)

thm sumset.domintros
thm sumset.pinduct

lemma "x < y \<Longrightarrow> (x, y) \<in> less_than"
  using less_than_def less_than_iff pred_nat_def by presburger

definition 
  sumset_term ::"(VDMNat VDMSet \<times> VDMNat VDMSet) set" where
  "sumset_term \<equiv> { (s1, s2) . s1 \<subseteq> s2 \<and> finite s2 }"

definition
  sumset_lex :: "((\<nat> set \<times> (\<nat> \<times> \<nat>) set \<times> \<nat>) \<times> \<nat> set \<times> (\<nat> \<times> \<nat>) set \<times> \<nat>) set"
  where
  "sumset_lex \<equiv> (finite_psubset :: (nat VDMSet \<times> nat VDMSet) VDMSet)
                 <*lex*> (finite_psubset :: ((nat \<times> nat) VDMSet \<times> (nat \<times> nat) VDMSet) VDMSet)
                 <*lex*> pred_nat"

lemma l1: "wf (finite_psubset :: (VDMNat VDMSet \<times> VDMNat VDMSet) VDMSet)" 
  using wf_finite_psubset by blast

lemma l2: "wf (finite_psubset :: ((VDMNat \<times> VDMNat) VDMSet \<times> (VDMNat \<times> VDMNat) VDMSet) VDMSet)"
  using wf_finite_psubset by blast

lemma l3: "wf ((finite_psubset :: (VDMNat VDMSet \<times> VDMNat VDMSet) VDMSet)
               <*lex*> (finite_psubset :: ((VDMNat \<times> VDMNat) VDMSet \<times> (VDMNat \<times> VDMNat) VDMSet) VDMSet)
               <*lex*> pred_nat)"
  by (simp add: wf_lex_prod wf_pred_nat)
  


theorem sumset_termination:  
  \<open>\<lbrakk>sumset_domain s\<rbrakk> \<Longrightarrow> sumset_dom s\<close>
  thm wf_induct wf
lemma lsum_set_domain_empty[simp]: "sumset_domain {}"
  unfolding sumset_domain_def 
  by simp

lemma lsum_empty_set_zero: "sumset {} = 0"
  thm ex_in_conv empty_iff all_not_in_conv equals0D
  find_theorems name:sumset
  apply (subst sumset.psimps)
   apply (meson empty_iff sumset.domintros)
  by simp
  
lemma lsum_set_dom_inv: "sumset_dom s \<Longrightarrow> sumset_domain s" 
  find_theorems name:sumset
  apply (frule sumset.psimps)
  apply (simp split: if_splits)
  oops
  
 (* 
  unfolding sumset_domain_def inv_VDMNat_def inv_SetElems_def   
  apply (induct rule: sumset.pinduct)
  apply (case_tac "s = {}", simp_all)
  apply (simp add: ex_in_conv[symmetric])
  apply (safe)
  apply (erule_tac x=x in ballE)
   apply simp+
  nitpick
   apply (meson empty_iff sumset.domintros)
  apply (cut_tac accI[of _ "sumset_rel"])
*)

lemma lsum_set_inv_dom: "sumset_domain s \<Longrightarrow> sumset_dom s" 
  apply (insert accp_wfPD[of sumset_rel s])
  unfolding wfP_def wf_def
  apply simp
  apply (cases "s = {}")
   apply (meson empty_iff sumset.domintros)
  apply (intro sumset.domintros)  
  apply (simp add: sumset.psimps)
  oops

lemma "finite (SIGMA a:A. B a)" 
  using [[show_types]]
  thm finite_set_choice
  thm finite_set_choice[of "{0,1,2,3::nat}"  "(\<lambda> x y . x < y)"]
  oops


  find_consts "'a set \<Rightarrow> 'a list"
  find_consts name:sorted_key_list_of_set
(*Set_Idioms, Mapping, Countable_Set*)
lemma lsum_set_result_is_nat:  
  "inv_SetElems inv_VDMNat s \<Longrightarrow> inv_VDMNat (sumset s)"
  unfolding inv_VDMNat_def inv_SetElems_def 
  apply (induct s rule: sumset.pinduct)
  

end