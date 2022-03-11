(*<*)
theory IsarCliffLemmaApply
imports HEAP1LemmasIJW
begin
(*>*)

(*
An attempt to redo Cliff's "that lemma" as specified in IsarCliffLemma.thy, but in apply-style
proof. Also added apply-style proofs of "that lemma siblings", i.e. the remaining cases of
the original proof that gave rise to "that lemma".

The conjectures are taken from file Heap1ProofsIJW.thy:

- that_lemma: line 1189, the case when above is non-empty; below is empty.
- that_lemma_below: line 1342, below non empty, above empty.
- that_lemma_both: line 1445, both non-empty.

The cousins are from the reification proofs...

*)

lemma L1: "disjoint s1 s2 \<Longrightarrow> s3 \<subseteq> s2 \<Longrightarrow> disjoint s1 s3"
  apply (unfold disjoint_def)
  by blast

lemma L1pt5: "disjoint s2 (s1 - s2)"
  apply (unfold disjoint_def)
  by simp

lemma L2: "disjoint s1 s3 \<Longrightarrow> disjoint s2 s3 \<Longrightarrow> disjoint (s1 \<union> s2) s3"
  apply (unfold disjoint_def)
  by blast

lemma L3: "nat1_map f \<Longrightarrow> locs (S -\<triangleleft> f) \<subseteq> locs f"
  apply (intro subsetI)
  apply (unfold locs_def)
  apply (simp add: dom_ar_nat1_map)
  apply (elim bexE)
  apply (rule_tac x = "s" in bexI)
  apply (subst (asm) f_in_dom_ar_apply_subsume)
  apply assumption
  apply assumption
  apply (erule f_in_dom_ar_subsume)
  done

lemma L3pt5:
    "\<lbrakk> s\<in> dom f; Disjoint f; nat1_map f \<rbrakk> \<Longrightarrow> locs ({s}-\<triangleleft> f) = locs f - locs_of s (the (f s))"    
  by (simp add: l_locs_of_dom_ar)

lemma L4: "nat1 n \<Longrightarrow> nat1 m \<Longrightarrow> locs_of d (n+m) = (locs_of d n) \<union> (locs_of (d+n) m)"
  apply (unfold locs_of_def)
  by auto

lemma that_lemma:
    "\<lbrakk> F1_inv f; disjoint (locs_of d s) (locs f); d+s \<in> dom f; nat1 s \<rbrakk> \<Longrightarrow>
        disjoint (locs_of d (s + (the (f (d+s)))))
                 (locs ({d+s} -\<triangleleft> f))"
  apply (unfold F1_inv_def)
  apply (elim conjE)
  apply (subst L4)
  apply assumption
  apply (simp add: nat1_map_def)
  apply (rule L2)
  apply (erule L1)
  apply (erule L3)
  apply (subst L3pt5)
  apply assumption+
  apply (rule L1pt5)
  done

lemma that_lemma_below:
    "\<lbrakk> F1_inv f; disjoint (locs_of d s) (locs f); below \<in> dom f; nat1 s; 
        below + the (f below) = d \<rbrakk> \<Longrightarrow>
          disjoint (locs_of below (the (f below) + s))
                   (locs ({below} -\<triangleleft> f))"
  apply (unfold F1_inv_def)
  apply (elim conjE)
  apply (subst L4)
  apply (simp add: nat1_map_def)
  apply assumption
  apply (rule L2)
  apply (subst L3pt5)
  apply assumption
  apply assumption
  apply assumption
  apply (rule L1pt5)
  apply (erule ssubst)
  apply (erule L1)
  apply (erule L3)
  done

lemma disjoint_locs_widen1:
    "nat1_map f \<Longrightarrow> disjoint s (locs ({p} -\<triangleleft> f)) \<Longrightarrow> disjoint s (locs ({p, q} -\<triangleleft> f))"
  apply (erule L1)
  by (metis L3 dom_ar_nat1_map l_dom_ar_insert l_dom_ar_singletons_comm)

lemma disjoint_locs_widen2:
    "nat1_map f \<Longrightarrow> disjoint s (locs ({q} -\<triangleleft> f)) \<Longrightarrow> disjoint s (locs ({p, q} -\<triangleleft> f))"
  by (metis disjoint_locs_widen1 insert_commute)

lemma that_lemma_both:
    "\<lbrakk> F1_inv f; disjoint (locs_of d s) (locs f); below \<in> dom f; d+s \<in> dom f; nat1 s;
        below + the (f below) = d \<rbrakk> \<Longrightarrow>
          disjoint (locs_of below (the (f below) + s + the (f (d + s))))
                   (locs ( {below, d + s} -\<triangleleft> f))"
  apply (unfold F1_inv_def)
  apply (elim conjE)
  apply (subst L4)
  apply (simp add: nat1_map_def)
  apply (simp add: nat1_map_def)
  apply (rule L2)
  apply (subst L4)
  apply (simp add: nat1_map_def)
  apply assumption
  apply (rule L2)
  apply (rule disjoint_locs_widen1)
  apply assumption
  apply (subst L3pt5)
  apply assumption
  apply assumption
  apply assumption
  apply (rule L1pt5)
  apply (elim ssubst)
  apply (erule L1)
  apply (erule L3)
  apply (subst add.assoc[symmetric])
  apply (erule ssubst)
  apply (rule disjoint_locs_widen2)
  apply assumption
  apply (subst L3pt5)
  apply assumption
  apply assumption
  apply assumption
  apply (rule L1pt5)
  done

(*
The version below utilises a more general approach via Lemma L5 but requires a subgoal command.
The version above uses lemmas disjoint_locs_widen* that are more tailored to the current proof.
However, the version above lends as a good example of a "similar lemma is needed"
*)

lemma L5: "\<lbrakk> nat1_map f; s2 \<subseteq> s1 \<rbrakk> \<Longrightarrow> locs (s1 -\<triangleleft> f) \<subseteq> locs (s2 -\<triangleleft> f)"
  apply (unfold locs_def)
  apply (simp add: dom_ar_nat1_map)
  apply (intro subsetI)
  apply simp
  apply (elim bexE)
  apply (rule_tac x = "s" in bexI)
  apply (metis Diff_iff f_in_dom_ar_apply_subsume l_dom_dom_ar set_mp)
  by (metis l_dom_ar_not_in_dom l_dom_ar_not_in_dom2 l_in_dom_ar set_mp)

lemma that_lemma_both0:
    "\<lbrakk> F1_inv f; disjoint (locs_of d s) (locs f); below \<in> dom f; d+s \<in> dom f; nat1 s;
        below + the (f below) = d \<rbrakk> \<Longrightarrow>
          disjoint (locs_of below (the (f below) + s + the (f (d + s))))
                   (locs ( {below, d + s} -\<triangleleft> f))"
  apply (unfold F1_inv_def)
  apply (elim conjE)
  apply (subst L4)
  apply (simp add: nat1_map_def)
  apply (simp add: nat1_map_def)
  apply (rule L2)
  apply (subst L4)
  apply (simp add: nat1_map_def)
  apply assumption
  apply (rule L2)
  apply (subgoal_tac "disjoint (locs_of below (the (f below))) (locs ({below} -\<triangleleft> f))")
  apply (erule L1)
  apply (erule L5)
  apply (metis empty_subsetI insert_mono)
  apply (subst L3pt5)
  apply assumption
  apply assumption
  apply assumption
  apply (rule L1pt5)
  apply (erule ssubst)
  apply (erule L1)
  apply (erule L3)
  apply (subst add.assoc[symmetric])
  apply (erule ssubst)
  apply (subgoal_tac "disjoint (locs_of (d + s) (the (f (d + s)))) (locs ({d + s} -\<triangleleft> f))")
  apply (erule L1)
  apply (erule L5)
  apply (metis subset_insertI)
  apply (subst L3pt5)
  apply assumption
  apply assumption
  apply assumption
  apply (rule L1pt5)
  done


lemma that_lemma_bean: "F1_inv f1
                  \<Longrightarrow> d1+s1 \<in> dom f1
                  \<Longrightarrow> nat1 s1
                  (*FROM ORIGINAL file, clearly a refactoring needed! \<Longrightarrow> dispose1_above f1 d1 s1 \<noteq> Map.empty *)
                   \<Longrightarrow> locs ({d1 + s1} -\<triangleleft> f1) \<union> locs_of d1 (the (f1 (d1 + s1)) + s1) = locs f1 \<union> locs_of d1 s1"
oops

(* The new lemma! *)
lemma L6:
  "nat1_map f \<Longrightarrow> x \<in> dom f \<Longrightarrow> locs_of x (the(f x)) \<subseteq> locs f"
by (metis k_in_locs_iff subsetI)

(* My 'crafted' lemma from reify *)
lemma g2_subset: " B \<subseteq> A \<Longrightarrow> (A - B) \<union> (C \<union> B) = A \<union> C" by auto



(* declarative style *)
lemma that_lemma_bean:
assumes inv: "F1_inv f1"
  and   d1s1: "d1+s1 \<in> dom f1"
  and   nat1s1: "nat1 s1"
  shows "locs ({d1 + s1} -\<triangleleft> f1) \<union> locs_of d1 (the (f1 (d1 + s1)) + s1) = locs f1 \<union> locs_of d1 s1"
proof-
  from inv show ?thesis
  proof 
    assume Disjf1: "Disjoint f1" and nat1mapf1: "nat1_map f1" and finitef1: "finite (dom f1)"
    have ar_split: "locs ({d1 + s1} -\<triangleleft> f1) = locs f1 - locs_of (d1+s1) (the (f1(d1+s1)))"
      by(subst L3pt5,rule d1s1, rule Disjf1, rule nat1mapf1,simp)
    have locs_of_plus_split: "locs_of d1 (the (f1 (d1 + s1)) + s1) = locs_of d1 s1 \<union> locs_of (d1 + s1) (the (f1 (d1 + s1)))"
    proof - 
      have "locs_of d1 (the (f1 (d1 + s1)) + s1)  = locs_of d1 (s1 + (the (f1 (d1 + s1))))" by (simp add: add.commute)
      also from nat1s1 have "...= locs_of d1 s1   \<union> locs_of (d1 + s1) (the (f1 (d1 + s1)))"  
        by (rule L4,metis d1s1 nat1_map_def nat1mapf1)
      finally show ?thesis .
    qed
    thm ar_split
        locs_of_plus_split
    (* I've dropped these two lines in the proof *)
    show ?thesis (* And now subsititute... Bad Isabelle style... *)
    apply (subst ar_split)
    apply (subst locs_of_plus_split)
    (* It's very easy to think this an easy proof now.
       BUT: set minus lacks nice properties for commutativity and distributivity
    *)
    apply (subst g2_subset)
    apply (rule L6, rule nat1mapf1, rule d1s1)
    apply (rule refl)
done
qed
qed

(* apply style, going from the RHS... *)
lemma that_lemma_bean_apply: "F1_inv f1
                  \<Longrightarrow> d1+s1 \<in> dom f1
                  \<Longrightarrow> nat1 s1
                  \<Longrightarrow> locs ({d1 + s1} -\<triangleleft> f1) \<union> locs_of d1 (the (f1 (d1 + s1)) + s1) = locs f1 \<union> locs_of d1 s1"
apply (subgoal_tac "locs f1 =  locs ({d1 + s1} -\<triangleleft> f1) \<union> locs_of (d1+s1) (the (f1(d1+s1)))")
defer
  apply (subst L3pt5)
  apply simp
  apply (simp add: F1_inv_def) 
  apply (simp add: F1_inv_def)
  apply (simp)
  apply (subst Un_absorb2)
  apply (rule L6, simp_all add: F1_inv_def)
apply (subgoal_tac "locs_of (d1 + s1) (the (f1 (d1 + s1))) \<union> locs_of d1 s1 = locs_of d1 (the (f1 (d1 + s1)) + s1)")
defer
  apply (subst add.commute [of "(the (f1 (d1 + s1)))"])
  apply (subst L4)
    apply simp
    apply (metis nat1_map_def)
    apply (metis Un_commute)
by auto

(*<*)
end
(*>*)
