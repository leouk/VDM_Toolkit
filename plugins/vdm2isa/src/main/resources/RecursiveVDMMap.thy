theory RecursiveVDMMap
imports VDMToolkit
begin

definition
  gen_set_term ::"('a VDMSet \<times> 'a VDMSet) VDMSet \<Rightarrow> ('a VDMSet \<times> 'a VDMSet) VDMSet" 
  where
  [simp]: "gen_set_term rel \<equiv> finite_psubset \<inter> rel"

lemma l_gen_set_term_wf[simp]: "wf (gen_set_term rel)" 
  by (simp add: wf_Int1)

text \<open>
  \begin{vdmsl}
    sum_elems: map nat to nat -> nat
    sum_elems(m) == 
      if m = {|->} then 0 else
        let d in set dom m in m(d) + sum_elems({d}<-:m)
  \end{vdmsl}\<close>

definition 
  pre_sum_elems :: \<open>(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_sum_elems m \<equiv> inv_Map inv_VDMNat inv_VDMNat m\<close>

function (domintros) 
  sum_elems :: \<open>(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> VDMNat\<close>
  where
  \<open>sum_elems m = 
      (if pre_sum_elems m then
          (if m = Map.empty then
            0
          else
            let d = (SOME e . e \<in> dom m) in the(m d) + (sum_elems ({d} -\<triangleleft> m))
          )
       else
          undefined
      )
  \<close>
  by (pat_completeness, auto)

definition
  sum_elems_wf :: \<open>(VDMNat VDMSet \<times> VDMNat VDMSet) VDMSet\<close>
  where
  [simp]: \<open>sum_elems_wf \<equiv> { (dom m - {(SOME e . e \<in> dom m)}, dom m) | m . m \<noteq> Map.empty \<and> pre_sum_elems m }\<close>

definition
  sum_elems_wf' :: \<open>(VDMNat VDMSet \<times> VDMNat VDMSet) VDMSet\<close>
  where
  [simp]: \<open>sum_elems_wf' \<equiv> { (dom m - {(SOME e . e \<in> dom m)}, dom m) | m . dom m \<noteq> {} \<and> pre_sum_elems m }\<close>

lemma l_sum_elems_wf_valid: "gen_set_term sum_elems_wf = sum_elems_wf"
  apply (simp add: pre_sum_elems_def)
  apply (intro equalityI subsetI)
   apply fastforce
  apply (simp add: finite_psubset_def case_prod_beta)
  apply (elim exE conjE, simp)
  apply (rule psubsetI, simp)
  by (metis Diff_disjoint Int_commute disjoint_insert(2) domIff someI)
  
lemma l_sum_elems_wf_valid': "gen_set_term sum_elems_wf' = sum_elems_wf'"
  apply (simp add: pre_sum_elems_def)
  apply (intro equalityI subsetI)
   apply fastforce
  apply (simp add: finite_psubset_def case_prod_beta)
  apply (elim exE conjE, simp)
  apply (rule psubsetI, simp)
  text \<open>Choice between @{term \<open>dom m \<noteq> {}\<close>} and @{term \<open>m \<noteq> Map.empty\<close>} doesn't matter\<close>
  by (metis Diff_disjoint Int_commute disjoint_insert(2) domIff someI)

lemma l_sum_elems_term_wf: "wf (gen_set_term sum_elems_wf)"
  using l_gen_set_term_wf by blast

(* Has to do on the map type!! *)
termination 
  term \<open>gen_set_term sum_elems_wf\<close>
  
  apply (rule "termination"[OF l_sum_elems_term_wf])
  apply (rule "termination"[of \<open>gen_set_term sum_elems_wf\<close>])
  apply (relation )
end