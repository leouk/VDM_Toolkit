theory RecursiveComplex
imports VDMToolkit
begin

definition 
  pre_perm :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_perm m n r \<equiv> inv_VDMInt m \<and> inv_VDMInt n \<and> inv_VDMInt r\<close>

lemma l_pre_perm_trivial[simp]: "pre_perm m n r"
  unfolding pre_perm_def inv_VDMInt_def by simp

function (domintros)
  perm :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt\<close>
  where
  \<open>perm m n r =
    (     if 0 < r then perm m (r-1) n 
     else if 0 < n then perm r (n-1) m
     else m) 
  \<close>
  by (pat_completeness, auto)

definition 
  perm_wf_rel :: \<open>((VDMInt \<times> VDMInt \<times> VDMInt) \<times> (VDMInt \<times> VDMInt \<times> VDMInt)) VDMSet\<close>
  where
  \<open>perm_wf_rel \<equiv> 
      { ((m, r-1, n), (m, n, r)) | m r n . 0 < r } 
      \<union>
      { ((r, n-1, m), (m, n, r)) | m r n . \<not> 0 < r \<and> 0 < n } 
  \<close>
                                 
lemma l_perm_wf_rel: "wf perm_wf_rel" 
  thm wf_induct wf_induct_rule id_def Id_def perm_wf_rel_def
  thm wf_induct[of _ \<open>\<lambda> p . p \<in> perm_wf_rel\<close>]
  apply (induct perm_wf_rel rule: wf_induct)
   defer
   apply (erule_tac x=perm_wf_rel in allE)
   apply simp
   apply (erule impE, simp_all)
  sledgehammer
  find_theorems \<open>wf (_ \<union> _)\<close>
  thm wf_induct
  unfolding perm_wf_rel_def
  apply (intro wf_Un)
  apply (intro wfI, simp)
  apply (simp add: wf_Un)

termination 
  apply (relation perm_wf_rel)
    apply (simp add: l_perm_wf_rel)
  by (simp add: perm_wf_rel_def)+

definition
  pre_ack :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_ack m n \<equiv> inv_VDMNat m \<and> inv_VDMNat n\<close>

lemmas pre_ack_defs = pre_ack_def inv_VDMNat_def

function (domintros) 
  ack :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat\<close>
  where
  \<open>ack m n = 
    (if pre_ack m n then
      (if m = 0 then
          n+1
       else
          (if n = 0 then
              ack (m-1) 1
           else
              ack (m-1) (ack m (n-1))
          )   
      )
    else
      undefined
    )
  \<close>
  by (pat_completeness, auto)

termination 
  apply (relation pair_less_VDMNat)
  using wf_pair_less_VDMNat apply blast
    apply (simp add: inv_VDMNat_def l_pair_less_VDMNat_I1 pre_ack_def)
   apply (simp add: inv_VDMNat_def pre_ack_def)
  by (simp add: inv_VDMNat_def pair_less_VDMNat_def pre_ack_def)

function ack' :: "nat \<Rightarrow> nat \<Rightarrow> nat" where
  "ack' 0 n             = Suc n"
| "ack' (Suc m) 0       = ack' m 1"
| "ack' (Suc m) (Suc n) = ack' m (ack' (Suc m) n)"
        apply (pat_completeness, auto) done
termination 
(*
  find_theorems "wf (_ \<union> _)"
  using "termination" lessI pair_lessI1 pair_less_iff1 wf_pair_less by presburger
*)
  thm lessI pair_lessI1 pair_less_def pair_less_iff1 wf_pair_less
  apply (relation pair_less)
     apply (simp)
  using lessI pair_lessI1 apply presburger
  using lessI pair_less_iff1 apply presburger
  using lessI pair_lessI1 by presburger

theorem ack_correct: \<open>ack' m n = ack m n\<close>
  apply (induction m n rule: ack'.induct)
  by (simp add: pre_ack_defs)+

function 
  tak :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt" 
  where
  "tak x y z = (if x \<le> y then y else tak (tak (x-1) y z) (tak (y-1) z x) (tak (z-1) x y))"
  by auto

lemma tak_pcorrect:
  "tak_dom (x, y, z) \<Longrightarrow> tak x y z = (if x \<le> y then y else if y \<le> z then z else x)"
  thm tak.pinduct tak.psimps
  apply (induction x y z rule: tak.pinduct) 
  by (simp add: tak.psimps)

definition tak_m1 where "tak_m1 = (\<lambda>(x,y,z). if x \<le> y then 0 else 1)"
definition tak_m2 where "tak_m2 = (\<lambda>(x,y,z). nat (Max {x, y, z} - Min {x, y, z}))"
definition tak_m3 where "tak_m3 = (\<lambda>(x,y,z). nat (x - Min {x, y, z}))"

lemma "(((x1,y1,z1),(x2,y2,z2)) \<in> tak_m3 <*mlex*> {}) \<longleftrightarrow> (nat (x1 - Min {x1, y1, z1}) < nat (x2 - Min {x2, y2, z2}))"
  apply (simp add: mlex_iff)
  unfolding tak_m3_def
  (*apply (simp only: case_prod_beta fst_conv snd_conv) *)
  by simp

lemma \<open>((x1,y1,z1),(x2,y2,z2)) \<in> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close>
  apply (simp add: mlex_iff)
  unfolding tak_m3_def tak_m2_def
  apply (simp only: case_prod_beta fst_conv snd_conv, clarify)
  oops

lemma l_call1: 
  \<open>x > y \<Longrightarrow> ((x-1,y,z),(x,y,z)) \<in> tak_m1 <*mlex*> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close> 
  apply (simp add: mlex_iff)
  unfolding tak_m3_def tak_m2_def tak_m1_def
  apply (simp add: case_prod_beta)
  unfolding min_def max_def
  by (simp_all split:if_splits)

lemma l_call2:
  \<open>x > y \<Longrightarrow> ((y-1,z,x),(x,y,z)) \<in> tak_m1 <*mlex*> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close>
  apply (simp add: mlex_iff)
  unfolding tak_m3_def tak_m2_def tak_m1_def
  by (simp add: case_prod_beta)

lemma l_call3:
  \<open>x > y \<Longrightarrow> ((z-1,x,y),(x,y,z)) \<in> tak_m1 <*mlex*> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close>
  apply (simp add: mlex_iff)
  unfolding tak_m3_def tak_m2_def tak_m1_def
  by (simp add: case_prod_beta)

lemma l_call4:
  \<open>x >y \<Longrightarrow>  tak_dom (z - 1, x, y) \<Longrightarrow>
       tak_dom (y - 1, z, x) \<Longrightarrow>
       tak_dom (x - 1, y, z) \<Longrightarrow>
       ((tak (x - 1) y z, tak (y - 1) z x, tak (z - 1) x y), x, y, z)
       \<in> tak_m1 <*mlex*> tak_m2 <*mlex*> tak_m3 <*mlex*> {}\<close>
  apply (simp add: mlex_iff)
  apply (simp add: tak_pcorrect)
  unfolding tak_m3_def tak_m2_def tak_m1_def min_def max_def
  by simp

termination
  apply (relation "tak_m1 <*mlex*> tak_m2 <*mlex*> tak_m3 <*mlex*> {}") 
      apply (simp add: wf_mlex)
     apply (simp add: l_call1)
     apply (simp add: l_call2)
     apply (simp add: l_call3)
  by (simp add: l_call4)
(*
     apply (auto simp: mlex_iff wf_mlex tak_pcorrect tak_m1_def tak_m2_def tak_m3_def min_def max_def)
*)

theorem tak_correct: "tak x y z = (if x \<le> y then y else if y \<le> z then z else x)"
  by (induction x y z rule: tak.induct) auto

end