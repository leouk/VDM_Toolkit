theory RecursiveSet
  imports VDMToolkit
begin

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


function (domintros)
  sumset :: "VDMNat VDMSet \<Rightarrow> VDMNat" 
  where 
  "sumset s = 
    (if s = {} then 0 else let e = (SOME x . x \<in> s) in sumset (s - {e}) + e)"
  by (blast, force)

thm sumset.domintros
thm sumset.pinduct

lemma lsum_empty_set_zero: "sumset {} = 0"
  thm ex_in_conv empty_iff all_not_in_conv equals0D
  by (meson empty_iff sumset.domintros sumset.pelims)

lemma lsum_set_dom_inv: "sumset_dom s \<Longrightarrow> inv_SetElems inv_VDMNat s" 
  unfolding inv_VDMNat_def inv_SetElems_def   
  apply (induct rule: sumset.pinduct)
  apply (case_tac "s = {}", simp_all)
  apply (simp add: ex_in_conv[symmetric])
  apply (safe)
  apply (erule_tac x=x in ballE)
   apply simp+
  nitpick
   apply (meson empty_iff sumset.domintros)
  apply (cut_tac accI[of _ "sumset_rel"])
  
lemma lsum_set_inv_dom: "inv_SetElems inv_VDMNat s \<Longrightarrow> sumset_dom s" 
  unfolding inv_VDMNat_def inv_SetElems_def
  apply (cases "s = {}")
   apply (meson empty_iff sumset.domintros)
  apply (intro sumset.domintros)
  
  apply (simp add: sumset.psimps)
  apply (subgoal_tac "s = {}")
  apply (cut_tac accI)
  apply (induct "sumset_rel s" rule: accp_induct_rule)
  

lemma lsum_set_result_is_nat:  
  "inv_SetElems inv_VDMNat s \<Longrightarrow> inv_VDMNat (sumset s)"
  unfolding inv_VDMNat_def inv_SetElems_def 
  apply (induct s rule: sumset.pinduct)
  

end