(*<*)
theory IsarCliffLemma
imports HEAP1LemmasIJW
begin
(*>*)
lemma L1:
  assumes "disjoint s1 s2"
  and "s3 \<subseteq> s2"
  shows "disjoint s1 s3"
  using assms unfolding disjoint_def
  by blast

lemma L1pt5:
  shows "disjoint s2 (s1 - s2)"
    unfolding disjoint_def by simp

lemma L2:
    assumes "disjoint s1 s3"
    and "disjoint s2 s3"
    shows "disjoint (s1 \<union> s2) s3"
    using assms unfolding disjoint_def
    by blast

lemma L3:
  assumes *: "nat1_map f"
  shows "locs (S -\<triangleleft> f) \<subseteq> locs f"
proof
  fix x assume xin_domar: "x \<in> locs (S -\<triangleleft> f)"
  then have "x \<in>  (\<Union>s\<in>dom (S -\<triangleleft> f). locs_of s (the ((S -\<triangleleft> f) s)))"
    by (simp add: locs_def * dom_ar_nat1_map)
  then have "x \<in> ( \<Union>s\<in>dom f. locs_of s (the (f s)))"
    by (smt UN_iff f_in_dom_ar_apply_not_elem l_dom_ar_notin_dom_or)
  thus "x \<in> locs f" by (simp add: locs_def *)
qed

lemma L3pt5:
 assumes "s\<in> dom f"
 and "Disjoint f"
 and "nat1_map f"
 shows "locs ({s}-\<triangleleft> f) = locs f - locs_of s (the (f s))"    
using assms by (simp add: l_locs_of_dom_ar)

lemma L4: "nat1 n \<Longrightarrow> nat1 m \<Longrightarrow> locs_of d (n+m) = (locs_of d n) \<union> (locs_of (d+n) m)"
unfolding locs_of_def
by auto

lemma that_lemma:
  assumes a1: "F1_inv f"
  and a2: "disjoint (locs_of d s) (locs f)"
  and a3: "d+s \<in> dom f"
  and a4: "nat1 s"
  shows "disjoint (locs_of d (s + (the (f (d+s)))))
                  (locs ({d+s} -\<triangleleft> f))"
proof -
  from a1 show ?thesis
  proof
  assume Disj: "Disjoint f"
  and n1map: "nat1_map f"
  show ?thesis --"Standard set-up of the problem complete"
  proof(subst L4) --" Step 1: backwards application of L4"
    show "nat1 s" by (rule a4) --"Direct from assm"
   next
    show "nat1 (the (f (d + s)))" -- "Step 2: solved (almost) directly from our hyp"
     using n1map nat1_map_def a3 by simp
   next --"Resulting goal"
    show "disjoint (locs_of d s \<union> locs_of (d + s) (the (f (d + s))))
                   (locs ({d + s} -\<triangleleft> f))"
    proof(rule L2) --"Step 3: backward application of L2"
      from a2 show "disjoint (locs_of d s) (locs ({d+s} -\<triangleleft>f))" --"Step 4"
      proof (rule L1) 
        from n1map show "locs ({d + s} -\<triangleleft> f) \<subseteq> locs f" -- "Step 5"
         by(rule L3)
      qed
     next 
      show "disjoint (locs_of (d + s) (the (f (d + s))))
                              (locs  ({d + s} -\<triangleleft> f))"
      proof (subst L3pt5) -- "Step 6: Substition of L3.5"                     
        from a3 Disj n1map show "d + s \<in> dom f" "Disjoint f" "nat1_map f" 
         by simp_all
       next
        show "disjoint (locs_of (d + s) (the (f (d + s)))) 
            (locs f - locs_of (d + s) (the (f (d + s))))"
         by (rule L1pt5) --"Step 7"
      qed
    qed
  qed              
qed
qed
(*<*)
end
(*>*)