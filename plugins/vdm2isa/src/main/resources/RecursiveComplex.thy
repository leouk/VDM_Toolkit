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
      { ((m, r-1, n), (m, r, n)) | m r n . 0 < r } 
      \<union>
      { ((r, n-1, m), (m, r, n)) | m r n . \<not> 0 < r \<and> 0 < n } 
  \<close>

termination 
  sorry 

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

definition 
  ack_wf_rel :: \<open>((VDMNat \<times> VDMNat) \<times> (VDMNat \<times> VDMNat)) VDMSet\<close>
  where
  \<open>ack_wf_rel \<equiv> 
      { ((m-1, n+1), (m, n)) | m n . m \<noteq> 0 \<and> n = 0 \<and> pre_ack m n }
      \<union>
      { ((m, n-1), (m, n)) | m n . m \<noteq> 0 \<and> n \<noteq> 0 \<and> pre_ack m n }
      \<union>
      { ((m-1, n), (m, n)) | m n . m \<noteq> 0 \<and> n \<noteq> 0 \<and> pre_ack m n } 
  \<close>   (* how to represent the last call site? Is this okay? *)

lemma l_ack_wf_rel[simp]: "wf ack_wf_rel" sorry
termination
  apply (rule "termination"[of \<open>ack_wf_rel\<close>])
     apply simp
    apply (simp add: ack_wf_rel_def)
   apply (simp add: ack_wf_rel_def)
   apply (simp add: ack_wf_rel_def pre_ack_defs)
  
  sorry


function ack' :: "nat \<Rightarrow> nat \<Rightarrow> nat" where
  "ack' 0 n             = Suc n"
| "ack' (Suc m) 0       = ack' m 1"
| "ack' (Suc m) (Suc n) = ack' m (ack' (Suc m) n)"
        apply (pat_completeness, auto) done
termination 
  find_theorems "wf (_ \<union> _)"
  thm lessI pair_lessI1 pair_less_def pair_less_iff1 wf_pair_less
  using "termination" lessI pair_lessI1 pair_less_iff1 wf_pair_less by presburger

function 
  tak :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt" 
  where
  "tak x y z = (if x \<le> y then y else tak (tak (x-1) y z) (tak (y-1) z x) (tak (z-1) x y))"
  by auto

lemma tak_pcorrect:
  "tak_dom (x, y, z) \<Longrightarrow> tak x y z = (if x \<le> y then y else if y \<le> z then z else x)"
  by (induction x y z rule: tak.pinduct) (auto simp: tak.psimps)

definition tak_m1 where "tak_m1 = (\<lambda>(x,y,z). if x \<le> y then 0 else 1)"
definition tak_m2 where "tak_m2 = (\<lambda>(x,y,z). nat (Max {x, y, z} - Min {x, y, z}))"
definition tak_m3 where "tak_m3 = (\<lambda>(x,y,z). nat (x - Min {x, y, z}))"

lemma "tak_m1 <*mlex*> tak_m2 <*mlex*> tak_m3 <*mlex*> {} 
      = 
      tak_m1 <*mlex*> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))" by simp

lemma "((x1,y1,z1),(x2,y2,z2)) \<in> tak_m3 <*mlex*> R"
   apply (simp add: mlex_iff) oops

lemma "(((x1,y1,z1),(x2,y2,z2)) \<in> tak_m3 <*mlex*> {}) \<longleftrightarrow> (nat (x1 - Min {x1, y1, z1}) < nat (x2 - Min {x2, y2, z2}))"
  apply (simp add: mlex_iff)
  unfolding tak_m3_def
  (*apply (simp only: case_prod_beta fst_conv snd_conv) *)
  by simp

lemma \<open>\<lbrakk>x1 > y1; x2 > y2; x1 \<noteq> x2; y1 \<noteq> y2; z1 \<noteq> z2\<rbrakk> 
       \<Longrightarrow> 
       ((x1,y1,z1),(x2,y2,z2)) \<in> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close>
  apply (simp add: mlex_iff)
  unfolding tak_m3_def tak_m2_def
  apply (simp, clarify)
  apply (simp only: case_prod_beta fst_conv snd_conv)
  nitpick
  apply (clarify, safe) 
  by simp

lemma "tak_m1 <*mlex*> tak_m2 <*mlex*> tak_m3 <*mlex*> {} = A"
  apply (intro equalityI subsetI)
   defer using [[]]
   apply (case_tac x, simp)
   apply (case_tac a, simp)
  apply (simp add: mlex_iff)
(*   apply (simp add: tak_m1_def tak_m2_def tak_m3_def case_prod_beta)
  apply safe
  thm mlex_iff wf_mlex
  unfolding mlex_prod_def lex_prod_def tak_m1_def tak_m2_def tak_m3_def 
  apply (simp add: case_prod_beta)*)
  sorry
termination
  by (relation "tak_m1 <*mlex*> tak_m2 <*mlex*> tak_m3 <*mlex*> {}")
     (auto simp: mlex_iff wf_mlex tak_pcorrect tak_m1_def tak_m2_def tak_m3_def min_def max_def)

theorem tak_correct: "tak x y z = (if x \<le> y then y else if y \<le> z then z else x)"
  by (induction x y z rule: tak.induct) auto

end