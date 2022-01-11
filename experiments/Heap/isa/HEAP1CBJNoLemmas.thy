theory HEAP1CBJNoLemmas
imports HEAP1
begin

lemma l1: "disjoint s1 s2 \<Longrightarrow> s3 \<subseteq> s2 \<Longrightarrow> disjoint s1 s3"
by (metis Int_absorb2 Int_assoc Int_empty_right disjoint_def le_infI1 order_refl)

lemma l2v0: "disjoint s1 s2 \<Longrightarrow> disjoint s2 s3 \<Longrightarrow> disjoint (s1 \<union> s2) s3"
nitpick
oops
lemma l2v1: "s2 \<noteq> {} \<Longrightarrow> disjoint s1 s2 \<Longrightarrow> disjoint s2 s3 \<Longrightarrow> disjoint (s1 \<union> s2) s3"
nitpick
oops

lemma l2v2: "s2 \<subseteq> s1 \<Longrightarrow> disjoint s1 s3 \<Longrightarrow> disjoint (s1 \<union> s2) s3"
oops

lemma l2: "disjoint s1 s2 \<Longrightarrow> disjoint s1 s3 \<Longrightarrow> disjoint s2 s3 \<Longrightarrow> disjoint (s1 \<union> s2) s3"
by (metis Un_empty_left disjoint_def inf_sup_distrib2)

lemma l2o: "disjoint s1 s3 \<Longrightarrow> disjoint s2 s3 \<Longrightarrow> disjoint (s1 \<union> s2) s3"
apply (metis Int_commute Un_empty_left disjoint_def inf_sup_distrib1)
done

lemma l3_1: "nat1_map f \<Longrightarrow> nat1_map(S -\<triangleleft> f)"
by (metis Diff_iff f_in_dom_ar_apply_subsume l_dom_dom_ar nat1_map_def)

lemma l3_2: "l \<in> dom (S -\<triangleleft> f) \<Longrightarrow>  l \<in> dom f"
unfolding dom_antirestr_def
by (cases "l\<in>S", auto)

lemma l3_3: "l \<in> dom (S -\<triangleleft> f) \<Longrightarrow> the ((S -\<triangleleft> f) l) = the (f l)"
unfolding dom_antirestr_def
by (cases "l\<in>S", auto)

lemma l3: "nat1_map f \<Longrightarrow> locs(S -\<triangleleft> f) \<subseteq> locs f"
apply (rule subsetI)
unfolding locs_def
apply (simp add: l3_1)
apply (erule bexE)
apply (frule l3_2)
apply (frule l3_3,simp)
apply (rule_tac x=s in bexI)
sledgehammer

lemma l4: "nat1 n \<Longrightarrow> nat1 m \<Longrightarrow> locs_of d (n+m) = (locs_of d n) \<union> (locs_of (d+n) m)"
unfolding locs_of_def
by auto

\<comment> \<open> New lemmas (relatively trivial)\<close>
lemma l5: "nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> nat1 (the(f x))"
by (metis nat1_map_def)

lemma l6: "nat1 y \<Longrightarrow> y < s \<Longrightarrow> locs_of (d+s) y \<subseteq> locs_of d s"
unfolding locs_of_def
apply simp
apply (rule subsetI)
find_theorems "_ \<in> {_ . _}"
apply (elim conjE CollectE)
apply (intro conjI CollectI)
apply (simp)
oops

lemma l6_1: "x \<in> dom f \<Longrightarrow> nat1_map f \<Longrightarrow> x \<in> locs_of x (the(f x))"
unfolding locs_of_def
apply (frule l5)
by auto

lemma l6: "x \<in> dom f \<Longrightarrow> nat1_map f \<Longrightarrow> x \<in> locs f"
unfolding locs_def
by (metis UN_iff l6_1)  
\<comment> \<open> UNUSED, but discovered through the failure to prove l6 above, which led to change in l2v2 \<close>

lemma l7v0: "d \<in> dom f \<Longrightarrow> x \<in> locs_of d s \<Longrightarrow> nat1_map f \<Longrightarrow> x \<in> locs f"
unfolding locs_def
apply simp
oops

lemma l7: "d \<in> dom f \<Longrightarrow> x \<in> locs_of d (the(f d)) \<Longrightarrow> nat1_map f \<Longrightarrow> x \<in> locs f"
unfolding locs_def
by (simp,rule bexI,simp_all)

\<comment> \<open> Going directly top bottom of proof - used wrong l2 lemma! \<close>
theorem try1: "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
          apply (elim conjE)
apply (frule l3[of f "{d+s}"])                                          \<comment> \<open> S4 : L3      \<close>
apply (frule l1[of "locs_of d s" "locs f" "(locs ({d+s} -\<triangleleft> f))"],simp)  \<comment> \<open> S5 : L1(S4,h)\<close>
\<comment> \<open> step 6 is strange: it is already what you want to conclude, yet it comes from h? \<close>
  \<comment> \<open> here S6 comes from Disjoint f \<close>
oops

\<comment> \<open> Going in the order of steps \<close>
theorem try2: 
       \<comment> \<open> h1         h2          h3             h4  \<close>
      "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
          apply (elim conjE)
apply (frule l4[of s "the(f(d+s))" d])  \<comment> \<open> S1    : L4(S2)       \<close>
apply (rule l5,simp,simp)               \<comment> \<open> S2    : L5(h1[3],h3) \<close>
apply (erule ssubst)                    \<comment> \<open> infer : subs(S1)     ; Nothing about S6 \<close>
    thm  l2[of "locs_of d s" 
                  "locs_of (d+s) 
                    (s+(the(f(d+s))))" 
                  "locs ({d+s} -\<triangleleft> f)"]
apply (rule l2)                         \<comment> \<open> S3    : L2(S5, S6)   \<close>
defer
    thm l1[of "locs_of d s"
              "locs f"
              "locs ({d+s} -\<triangleleft> f)"]
        l3[of f "{d+s}"]
    
apply (frule l3[of f "{d+s}"])          \<comment> \<open> S4    : L3           \<close>
apply (frule l1[of "locs_of d s" 
                   "locs f" 
               "(locs ({d+s} -\<triangleleft> f))"],
               simp)                    \<comment> \<open> S5 : L1(S4,h)        \<close>
\<comment> \<open> To me the backward steps towards the goal are harder to follow? How about S6? Will try backward \<close>
oops

\<comment> \<open>Just like try2 but going underneath disjoint definition\<close>
theorem try3: 
       \<comment> \<open> h1         h2          h3             h4  \<close>
      "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
          apply (elim conjE)
apply (frule l4[of s "the(f(d+s))" d])  \<comment> \<open> S1    : L4(S2)       \<close>
apply (rule l5,simp,simp)               \<comment> \<open> S2    : L5(h1[3],h3) \<close>
apply (erule ssubst)                    \<comment> \<open> infer : subs(S1)     ; Nothing about S6 \<close>
apply (rule l2)                         \<comment> \<open> S3    : L2(S5, S6)   \<close>
defer
apply (rule l1[of _ "locs f" _],simp)   \<comment> \<open> S5   : L1(S4,h4)     \<close>
apply (rule l3,simp)                    \<comment> \<open> S4   : L3(h1[3])     \<close>
defer
  \<comment> \<open> If I had a lemma (should create? no general enough?); \<close>
unfolding disjoint_def
  apply (simp add: disjoint_iff_not_equal)
  apply (intro ballI)
  apply (erule_tac x=x in ballE,simp_all)
  apply (erule_tac x=y in ballE,simp)
  apply (erule notE)
  apply (rule l7[of "d+s" f _],simp_all)

  apply (fold disjoint_def)
  apply (unfold disjoint_def)
  apply (simp add: disjoint_iff_not_equal)
  apply (frule l6,simp)
  apply (intro ballI)
  apply (frule l3_1[of f "{d+s}"])
  unfolding locs_def
  apply simp
  apply (elim bexE)
 thm l3 l3_1 l3_2 l5
  apply (frule l3_2)
  apply (simp add: l3_3)
  apply (frule l5[of _ "d+s"],simp)
  apply (frule l5,simp) back
  apply (frule l5,simp) back back
  apply (erule ballE)+
  (*
  apply (erule_tac x=saa in ballE)
  apply (erule_tac x=y in ballE)
  *)
  apply simp 
  prefer 3
  apply (erule notE)
  unfolding locs_of_def
  apply simp
  nitpick
oops

\<comment> \<open> Version shown to Cliff - in step order and using l2 new \<close>
theorem try4: 
       \<comment> \<open> h1         h2          h3             h4  \<close>
      "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
          apply (elim conjE)
apply (frule l4[of s "the(f(d+s))" d])  \<comment> \<open> S1    : L4(S2)       \<close>
apply (rule l5,simp,simp)               \<comment> \<open> S2    : L5(h1[3],h3) \<close>
apply (erule ssubst)                    \<comment> \<open> infer : subs(S1)     ; Nothing about S6 \<close>
apply (rule l2)                         \<comment> \<open> S3    : L2(S5, S6)   \<close>
defer
apply (rule l1[of _ "locs f" _],simp)   \<comment> \<open> S5   : L1(S4,h4)     \<close>
apply (rule l3,simp)                    \<comment> \<open> S4   : L3(h1[3])     \<close>
defer
unfolding disjoint_def
  apply (simp add: disjoint_iff_not_equal)
  apply (intro ballI)
  apply (erule_tac x=x in ballE,simp_all)
  apply (erule_tac x=y in ballE,simp)
  apply (erule notE)
  apply (rule l7[of "d+s" f _],simp_all)
oops

lemma l3half_1: "nat1_map f \<Longrightarrow> (x \<in> locs f) = (\<exists>y \<in> dom f . x \<in> locs_of y (the(f y)))"
unfolding locs_def
by (metis (mono_tags) UN_iff)

\<comment> \<open> Version shown to Cliff - in step order and using l2original + new lemma\<close>
lemma l3half: 
\<comment> \<open>see lemma l_locs_dom_ar_iff:\<close>
  "nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> r \<in> dom f \<Longrightarrow> locs({r} -\<triangleleft> f) = locs f - locs_of r (the(f r))"
apply (rule equalityI)
apply (rule_tac [1-] subsetI)
apply (frule_tac [1-] l3_1[of _ "{r}"])
apply (simp_all add: l3half_1)
defer 
apply (elim conjE)
defer 
apply (intro conjI)
apply (metis f_in_dom_ar_subsume f_in_dom_ar_the_subsume)
apply (erule_tac [1-] bexE)
defer 
apply (rule_tac x=y in bexI)
apply (metis f_in_dom_ar_apply_not_elem singleton_iff)
apply (metis l_dom_dom_ar member_remove remove_def)
apply (frule f_in_dom_ar_subsume)
apply (frule f_in_dom_ar_the_subsume)
unfolding Disjoint_def disjoint_def Locs_of_def
apply (simp)
by (metis disjoint_iff_not_equal f_in_dom_ar_notelem)

thm f_in_dom_ar_subsume
    f_in_dom_ar_the_subsume
    f_in_dom_ar_notelem
    f_in_dom_ar_apply_not_elem
    l_dom_dom_ar

lemma l8: "disjoint A (B - A)"
unfolding disjoint_def
by (metis Diff_disjoint)

\<comment> \<open> LATEST version from Cliff that avoids expanding locs def through lemmas (caveat: 3.5 is hard to prove \<close>
theorem try7: 
       \<comment> \<open> h1         h2          h3             h4  \<close>
      "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
          apply (elim conjE)
apply (frule l4[of s "the(f(d+s))" d])  \<comment> \<open> S1    : L4(S2)       \<close>
apply (rule l5,simp,simp)               \<comment> \<open> S2    : L5(h1[3],h3) \<close>
apply (erule ssubst)                    \<comment> \<open> infer : subs(S1)     ; Nothing about S6 \<close>
apply (rule l2o)                        \<comment> \<open> S3    : L2(S4, S6)   \<close>
apply (metis (full_types) l1 l3)
by (metis l3half l8)

\<comment> \<open> trial lemma extracted from the last part of the next try proofs (try5/6 below)\<close>
lemma trial: "nat1_map f \<Longrightarrow> Disjoint f \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of (d + s) (the (f (d + s)))) (locs ({d+s} -\<triangleleft> f))"
unfolding Disjoint_def Locs_of_def                 
  apply (erule_tac x="d+s" in ballE)    \<comment> \<open> S6    : S8 \<close>
    apply (simp_all)
  unfolding disjoint_def
  apply (simp add: disjoint_iff_not_equal)
  apply (intro ballI)
  unfolding locs_def
  apply (frule l3_1[of _ "{d+s}"])
  apply simp
  apply (erule bexE)
  apply (frule l3_2)
  apply (frule f_in_dom_ar_notelem)
  apply (erule_tac x=sa in ballE,simp_all)
  apply (metis f_in_dom_ar_apply_subsume)
done

theorem try5: 
       \<comment> \<open> h1         h2          h3             h4  \<close>
      "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
          apply (elim conjE)
apply (frule l4[of s "the(f(d+s))" d])  \<comment> \<open> S1    : L4(S2)       \<close>
apply (rule l5,simp,simp)               \<comment> \<open> S2    : L5(h1[3],h3) \<close>
apply (erule ssubst)                    \<comment> \<open> infer : subs(S1)     ; Nothing about S6 \<close>
apply (rule l2o)                        \<comment> \<open> S3    : L2(S4, S6)   \<close>
apply (rule l1[of _ "locs f" _],simp)   \<comment> \<open> S4    : L1(S5,h4)     \<close>
apply (rule l3,simp)                    \<comment> \<open> S5    : L3(h1[3])     \<close>

apply (frule l3half,simp,simp,simp)     \<comment> \<open> S8   : L3.5(h1[1])   \<close>
(*
apply (rule l1[of _ "locs f"])          \<comment> \<open> S8_1 : L1(h4)        \<close>
  defer thm Diff_subset l3 \<comment> \<open> either work \<close>
  apply (metis Diff_subset)             \<comment> \<open> S8_2 : L3 or set-thy \<close>
apply (rule trial,simp,simp,simp)       \<comment> \<open> S9   : ? S6 ? \<close>
      \<comment> \<open> cannot loose anti-restriction \<close>
*)
oops

theorem try6: 
       \<comment> \<open> h1         h2          h3             h4  \<close>
      "F1_inv f \<Longrightarrow> nat1 s \<Longrightarrow> d+s \<in> dom f \<Longrightarrow> disjoint (locs_of d s) (locs f) \<Longrightarrow>
          disjoint (locs_of d (s+ (the(f(d+s))))) (locs ({d+s} -\<triangleleft> f))"
          unfolding F1_inv_def
          apply (elim conjE)
          thm l4[of s "the(f(d+s))" d] 
          thm l5 
          thm l1[of _ "locs f" _]
          thm trial
apply (frule l4[of s "the(f(d+s))" d])  \<comment> \<open> S1    : L4(S2)       \<close>
apply (rule l5,simp,simp)               \<comment> \<open> S2    : L5(h1[3],h3) \<close>
apply (erule ssubst)                    \<comment> \<open> infer : subs(S1)     ; Nothing about S6 \<close>
apply (rule l2o)                        \<comment> \<open> S3    : L2(S4, S6)   \<close>
apply (rule l1[of _ "locs f" _],simp)   \<comment> \<open> S4    : L1(S5,h4)     \<close>
apply (rule l3,simp)                    \<comment> \<open> S5    : L3(h1[3])     \<close>
apply (rule trial,simp,simp,simp)
done

end
