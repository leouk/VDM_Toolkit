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

definition pred_VDMNat :: "(VDMNat \<times> VDMNat) set"
  where "pred_VDMNat \<equiv> {(z, z+1) | z . inv_VDMNat z }"

text \<open>Project @{term pred_VDMNat} into @{typ \<nat>} for link to well foundedness\<close>
lemma l_pred_VDMNat_wf: \<open>wf pred_VDMNat\<close>
proof -
  have "pred_VDMNat \<subseteq> measure nat" 
     by (auto simp add: pred_VDMNat_def inv_VDMNat_def)
  then show ?thesis
     by (rule wf_subset [OF wf_measure])
qed

lemma l_pred_VDMNat_subset_int_ge_less_than: 
  \<open>pred_VDMNat \<subseteq> int_ge_less_than 0\<close>
  by (simp add: int_ge_less_than_def inv_VDMNat_def pred_VDMNat_def subset_iff)

definition less_than_VDMNat :: "(VDMNat \<times> VDMNat) set"
(*  where "less_than_VDMNat \<equiv> pred_VDMNat\<^sup>+"*)
  where \<open>less_than_VDMNat \<equiv> (int_ge_less_than 0)\<^sup>+\<close>

lemma l_less_than_VDMNat_wf [iff]: "wf less_than_VDMNat"
  by (simp add: less_than_VDMNat_def wf_int_ge_less_than wf_trancl)

lemma trans_less_than_VDMNat [iff]: "trans less_than_VDMNat"
  by (simp add: less_than_VDMNat_def)

lemma l_less_than_VDMNat_irrefl: "irrefl less_than_VDMNat"
  by (simp add: wf_imp_irrefl)

lemma l_less_than_VDMNat_asym: "asym less_than_VDMNat"
  by (meson asym_iff l_less_than_VDMNat_wf wf_not_sym)

lemma less_int_rel: "(<) = (\<lambda>m n. m < (n::int))\<^sup>+\<^sup>+"
proof (rule ext, rule ext, rule iffI)
  fix n m :: int
  show "(\<lambda>m n. m < (n::int))\<^sup>+\<^sup>+ m n" if "m < n"
    using that
  proof (induct n)
    case base
    then show ?case by auto
  next
    case (step i)
    then show ?case 
      by (auto intro: tranclp.trancl_into_trancl)
  qed
  show "m < n" if "(\<lambda>m n. m < (n::int))\<^sup>+\<^sup>+ m n"
    using that by (induct n) (simp_all)
qed

lemma l_less_than_VDMNat_subset_int_ge_less_than:
  "less_than_VDMNat \<subseteq> int_ge_less_than 0"
  apply (simp add: less_than_VDMNat_def int_ge_less_than_def inv_VDMNat_def  pred_VDMNat_def subset_iff)
  apply (intro allI impI conjI)
  using tranclD apply fastforce 
  by (smt (z3) case_prodD mem_Collect_eq trancl_trans_induct)

lemma l_less_than_VDMNat_iff [iff]: "inv_VDMNat x \<Longrightarrow> ((x,y) \<in> less_than_VDMNat) = (x<y)"
  apply (intro iffI)  
  using int_ge_less_than_def l_less_than_VDMNat_subset_int_ge_less_than apply fastforce
  unfolding less_than_VDMNat_def int_ge_less_than_def 
  by (rule r_into_trancl, simp add: inv_VDMNat_def)

lemma l_total_on_less_than_VDMNat [simp]: "total_on { x . inv_VDMNat x} less_than_VDMNat"
  unfolding total_on_def 
  using inv_VDMNat_def by fastforce

definition
  pair_less_VDMNat :: \<open>((VDMNat \<times> VDMNat) \<times> (VDMNat \<times> VDMNat)) VDMSet\<close>
  where
  "pair_less_VDMNat \<equiv> less_than_VDMNat <*lex*> less_than_VDMNat"

lemma wf_pair_less_VDMNat[simp]: "wf pair_less_VDMNat"
  by (auto simp: pair_less_VDMNat_def)

lemma l_trans_pair_less_VDMNat [iff]: "trans pair_less_VDMNat"
  by (simp add: pair_less_VDMNat_def)

lemma total_pair_less_VDMNat [iff]: "total_on less_than_VDMNat pair_less_VDMNat" 
  unfolding total_on_def pair_less_VDMNat_def lex_prod_def
  apply safe
  apply (metis (mono_tags, lifting) case_prodD int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq subsetD)
  apply (metis (no_types, lifting) Product_Type.Collect_case_prodD fst_conv insert_absorb insert_subset int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than not_less_iff_gr_or_eq)
  apply (metis (no_types, lifting) case_prodD in_mono int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq)
  apply (metis (no_types, lifting) case_prodD int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq subsetD)
  apply (metis (mono_tags, lifting) case_prodD in_mono int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq)
  apply (metis (no_types, lifting) case_prodD int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq subsetD)
  apply (metis (no_types, lifting) case_prodD in_mono int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq)
  by (smt (verit, best) Product_Type.Collect_case_prodD fst_conv int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than subset_iff)

lemma l_pair_less_VDMNat_iff1_case1: "inv_VDMNat x \<Longrightarrow> ((x, y), x, z) \<in> pair_less_VDMNat \<Longrightarrow> y < z"
  by (metis (no_types, lifting) CollectD case_prodD in_lex_prod int_ge_less_than_def l_less_than_VDMNat_subset_int_ge_less_than order_less_irrefl pair_less_VDMNat_def subset_iff)
  (* 
  proof -
    assume "((x, y), x, z) \<in> pair_less_VDMNat"
    then have "((x, y), x, z) \<in> less_than_VDMNat <*lex*> less_than_VDMNat"
      using pair_less_VDMNat_def by blast
    then show ?thesis
      using int_ge_less_than_def l_less_than_VDMNat_subset_int_ge_less_than by auto
  *)

lemma l_pair_less_VDMNat_iff1 [simp]: "inv_VDMNat x \<Longrightarrow> inv_VDMNat y \<Longrightarrow> ((x,y), (x,z)) \<in> pair_less_VDMNat \<longleftrightarrow> y<z"
  apply (intro iffI) 
   apply (simp add: l_pair_less_VDMNat_iff1_case1)
  by (simp add: pair_less_VDMNat_def)

lemma l_pair_less_VDMNat_I1: "inv_VDMNat a \<Longrightarrow> inv_VDMNat s \<Longrightarrow> a < b  \<Longrightarrow> ((a, s), (b, t)) \<in> pair_less_VDMNat"
  by (simp add: pair_less_VDMNat_def) 

lemma l_pair_less_VDMNat_I2: "inv_VDMNat a \<Longrightarrow> inv_VDMNat s \<Longrightarrow> a \<le> b \<Longrightarrow> s < t \<Longrightarrow> ((a, s), (b, t)) \<in> pair_less_VDMNat"
  using l_pair_less_VDMNat_I1 by force

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

termination
  apply (relation "tak_m1 <*mlex*> tak_m2 <*mlex*> tak_m3 <*mlex*> {}") 
      apply (simp add: wf_mlex)
     apply (simp add: l_call1)
     apply (simp add: l_call2)
     apply (simp add: l_call3)
  sledgehammer
(*
     apply
     (auto simp: mlex_iff wf_mlex tak_pcorrect tak_m1_def tak_m2_def tak_m3_def min_def max_def)
*)
theorem tak_correct: "tak x y z = (if x \<le> y then y else if y \<le> z then z else x)"
  by (induction x y z rule: tak.induct) auto

end