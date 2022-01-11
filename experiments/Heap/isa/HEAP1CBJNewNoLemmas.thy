theory HEAP1CBJNewNoLemmas
imports HEAP1
begin

lemma lnew1: "disjoint s1 s2 \<Longrightarrow> disjoint (s1 - s3) (s2 \<union> s3)"
 by (metis Diff_disjoint Diff_triv Un_Diff_Int bot_eq_sup_iff disjoint_def inf_sup_distrib1)
(*by (metis Diff_Int2 Diff_Int_distrib2 Diff_cancel Int_Diff Int_Un_distrib disjoint_def sup_bot.left_neutral)*)

thm Diff_disjoint Diff_triv Un_Diff_Int bot_eq_sup_iff  inf_sup_distrib1
thm Diff_Int2 Diff_Int_distrib2 Diff_cancel Int_Diff Int_Un_distrib  sup_bot.left_neutral

theorem try1new: "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
apply (simp add: lnew1)
thm lnew1[of "locs f" "locs_of d s" "locs_of d s"] 
  --"fails because of commutativity is missing; we also need lemmas about locs and locs_of"
oops

lemma lnew2: "disjoint s1 s2 \<Longrightarrow> disjoint s2 s1"
by (metis disjoint_def inf_commute)

theorem try2new: "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
apply (rule lnew2)
--"need to make -\<triangleleft> into - and + into union"
oops

lemma l_locs_dom_ar_iff:
  "nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> locs({r} -\<triangleleft> f) = locs f - locs_of r (the(f r))"
sorry

lemma l4: "nat1 n \<Longrightarrow> nat1 m \<Longrightarrow> locs_of d (n+m) = (locs_of d n) \<union> (locs_of (d+n) m)"
unfolding locs_of_def
by auto

theorem try3new: "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
apply (rule lnew2)
apply (simp add: l_locs_dom_ar_iff)
apply (simp add: l4)
thm l4[of s "the(f(d+s))" d]
 --"fails because ISabelle doesn't know nat1'ness of the(f(d+s))"
oops

lemma f_nat1_map_nat1_elem:
	"nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> 0 < (the(f x))"
by (metis nat1_def nat1_map_def)

theorem try4new: "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
apply (rule lnew2)
apply (simp add: l_locs_dom_ar_iff)
apply (simp add: l4 f_nat1_map_nat1_elem)
apply (rule lnew1)
apply (rule lnew2)
apply assumption
done

end
