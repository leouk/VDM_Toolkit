theory RecursiveVDMMap
imports VDMToolkit
begin

text \<open>
  \begin{vdmsl}
    sum_elems: map nat to nat -> nat
    sum_elems(m) == 
      if m = {|->} then 0 else
        let d in set dom m in m(d) + sum_elems({d}<-:m)
	  --@IsaMeasure( { ({d} <-: m, m) | m : map nat to nat, d: nat & m <> {} and d in set dom m } )
    --@Witness({ 1 |-> 1 })
    measure card dom m;
  \end{vdmsl}\<close>

definition 
  pre_sum_elems :: \<open>(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_sum_elems m \<equiv> inv_Map inv_VDMNat inv_VDMNat m\<close>

lemmas pre_sum_elems_defs = pre_sum_elems_def inv_Map_defs inv_VDMNat_def 

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

abbreviation
  sum_elems_wf :: \<open>((VDMNat \<rightharpoonup> VDMNat) \<times> (VDMNat \<rightharpoonup> VDMNat)) VDMSet\<close>
  where
  \<open>sum_elems_wf \<equiv> { (({d} -\<triangleleft> m), m) | m d . m \<noteq> Map.empty \<and> d \<in> dom m \<and> pre_sum_elems m }\<close>

lemma l_sum_elems_wf: "wf sum_elems_wf"
  thm wf_measure[of \<open>\<lambda> m . card (dom m)\<close>, THEN wf_subset]
  apply (rule wf_measure[of \<open>\<lambda> m . card (dom m)\<close>, THEN wf_subset])
  apply (simp add: measure_def inv_image_def less_than_def less_eq)
  apply (rule subsetI, simp add: case_prod_beta)
  apply (elim exE conjE)
  by (simp add: l_VDMMap_filtering_card pre_sum_elems_defs)

lemma l_sum_elems_wf_valid: "sum_elems_wf \<noteq> {}" 
  apply safe
  apply (erule equalityE)
  apply (simp add: subset_eq)
  text \<open>This will require the user to define a @Witness in VDM.\<close>
  apply (erule_tac x=\<open>[1 \<mapsto> 1]\<close> in allE)
  by (simp add: pre_sum_elems_defs) 

lemma l_pre_sum_elems_sum_elems_wf: 
  "pre_sum_elems m \<Longrightarrow> m \<noteq> Map.empty \<Longrightarrow> ({(SOME e. e \<in> dom m)} -\<triangleleft> m, m) \<in> sum_elems_wf"
  apply (simp add: pre_sum_elems_defs)
  by (metis domIff empty_iff some_in_eq)

termination   
  apply (rule "termination"[OF l_sum_elems_wf])
  using l_pre_sum_elems_sum_elems_wf by presburger

end