theory RecursiveVDMNat
  imports VDMToolkit
begin

definition pred_VDMNat :: "(VDMNat \<times> VDMNat) set"
  where "pred_VDMNat = {(m, m+1) | m . m \<ge> 0 }"

definition less_than_VDMNat :: "(VDMNat \<times> VDMNat) set"
  where "less_than_VDMNat = pred_VDMNat\<^sup>+"

lemma "wf pred_nat" 
  apply (unfold wf_def pred_nat_def)
  apply clarsimp
  apply (induct_tac x)
  by blast+
  
lemma l_wf_pred_VDMNat: "wf pred_VDMNat" 
  apply (unfold wf_def pred_VDMNat_def)
  apply clarsimp
  apply (induct_tac x rule: int_of_nat_induct)
   apply (erule_tac x=\<open>int n\<close> in allE, erule impE)
  defer 
  apply assumption
   apply (erule_tac x=\<open>- int (Suc n)\<close> in allE)
   apply (erule impE, intro allI impI, elim conjE)
  defer
    apply assumption
  apply (intro allI impI, elim conjE)
  apply simp
   apply blast
  done


lemma l_wf_less_than_VDMNat[iff]: "wf less_than_VDMNat"
  by (simp add: less_than_VDMNat_def l_wf_pred_VDMNat [THEN wf_trancl])

definition 
  pre_vdm_factorial :: \<open>VDMNat \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_vdm_factorial n \<equiv> inv_VDMNat n\<close>


definition 
  vdm_factorial_term :: \<open>(VDMNat \<times> VDMNat) set\<close>
  where
  \<open>vdm_factorial_term \<equiv> { (n - 1, n) | n . pre_vdm_factorial n }\<close>

lemma "wf vdm_factorial_term" 
  find_theorems "wf _"
    thm wf_subset[of vdm_factorial_term]
  apply (rule wf_subset)
  unfolding vdm_factorial_term_def pre_vdm_factorial_def inv_VDMNat_def
  oops

function (domintros) vdm_factorial :: \<open>VDMNat \<Rightarrow> VDMNat\<close>
  where
  \<open>vdm_factorial n =
    (if pre_vdm_factorial n then
      (if n = 0 then 
        1
      else
        n * (vdm_factorial (n - 1))
      )
    else
      undefined)\<close>
  by (pat_completeness, auto)
  
lemma l_wf_predVDMNat: "wf less_than_VDMNat"
    apply (unfold wf_def less_than_VDMNat_def pred_VDMNat_def)
  apply clarsimp term less_than
  apply (induct_tac x rule: int_of_nat_induct)
   apply (erule_tac x=\<open>(int n)\<close> in allE, clarsimp)
  apply (erule_tac x=\<open>(int n)\<close> in allE)
   apply (elim impE, intro allI impI)
  
  apply (induct_tac y rule: int_of_nat_induct)
  sorry

termination 
  apply (relation \<open>less_than_VDMNat\<close>)
   defer
  apply (simp add: pred_VDMNat_def pre_vdm_factorial_def inv_VDMNat_def)
  term "inv_image less_than" 
  apply (simp add: inv_VDMNat_def pre_vdm_factorial_def)
  
end