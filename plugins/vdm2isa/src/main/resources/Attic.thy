theory Attic
imports VDMToolkit
begin

section \<open>Well foundedness study on bounded @{text nat_term}\<close>

abbreviation \<open>NAT_MAX \<equiv> 2\<close>

definition 
  nat_term :: \<open>(\<nat> \<times> \<nat>) VDMSet\<close>
  where
  \<open>nat_term \<equiv> { (m, n) . n = Suc m \<and> n < NAT_MAX }\<close>

lemma l_nat_term_eq: \<open>nat_term = { (0, 1) }\<close> (*, (1, 2) }\<close> , (2, 3), (3, 4) }\<close>*)
  apply (simp add: nat_term_def, safe)
  by (simp_all) 

definition 
  nat_fin_psub :: \<open>(((\<nat> \<times> \<nat>) VDMSet) \<times> ((\<nat> \<times> \<nat>) VDMSet)) VDMSet\<close>
  where
(*\<open>nat_fin_psub \<equiv> finite_psubset :: ((\<nat> \<times> \<nat>) VDMSet \<times> (\<nat> \<times> \<nat>) VDMSet) VDMSet\<close> *)
  \<open>nat_fin_psub \<equiv> {(A, B). A \<subset> B \<and> finite B \<and> B \<subseteq> nat_term }\<close>

(*
lemma l_nat_fin_psub_eq1: \<open>{({(0, 1)}, {(0, 1), (1, 2)}), ({(1, 2)}, {(0, 1), (1, 2)}), ({}, {(0, 1), (1, 2)}), ({}, {(0, 1)}), ({}, {(1, 2)})} \<subseteq> nat_fin_psub\<close>  
  apply (intro subsetI)
  unfolding nat_fin_psub_def
  apply (simp add: case_prod_beta)
  apply (elim disjE, simp_all add: l_nat_term_eq)
  by blast+

lemma l_nat_fin_psub_eq2:\<open>nat_fin_psub \<subseteq> {({(0, 1)}, {(0, 1), (1, 2)}), ({(1, 2)}, {(0, 1), (1, 2)}), ({}, {(0, 1), (1, 2)}), ({}, {(0, 1)}), ({}, {(1, 2)})}\<close>
  apply (intro subsetI, simp_all add: nat_fin_psub_def case_prod_beta)
  apply (elim conjE)
  apply clarsimp
  apply (simp add: subset_eq[of _ \<open>nat_term\<close>])
  apply (erule_tac x=\<open>(aa,ba)\<close> in ballE)
   apply (simp add: l_nat_term_eq)
   apply (elim disjE conjE, simp)
  thm impCE impE
  apply (rule prod_eqI, simp_all)
  apply (simp add: l_nat_term_eq)
   apply (metis (no_types, lifting) l_nat_term_eq leD order_less_imp_le singletonD subset_empty subset_iff)
  by (metis One_nat_def l_nat_term_eq leD order_less_imp_le subset_empty subset_singletonD)

  apply (simp add: subset_eq[of _ \<open>nat_term\<close>])
  nitpick  
  sorry 

lemma \<open>nat_fin_psub = {({(0, 1)}, {(0, 1), (1, 2)}), ({(1, 2)}, {(0, 1), (1, 2)}), ({}, {(0, 1), (1, 2)}), ({}, {(0, 1)}), ({}, {(1, 2)})}\<close>
  apply (rule equalityI)
   apply (rule l_nat_fin_psub_eq2)
  apply (rule l_nat_fin_psub_eq1)
  done

*)

lemma \<open>nat_fin_psub = {({}, {(0, 1)})}\<close> 
  apply (intro equalityI subsetI, simp_all add: nat_fin_psub_def case_prod_beta)
   defer
   apply (simp add: l_nat_term_eq l_psubset_insert)
  apply (rule prod_eqI, simp_all)
   apply (metis (no_types, lifting) l_nat_term_eq leD order_less_imp_le singletonD subset_empty subset_iff)
  by (metis One_nat_def l_nat_term_eq leD order_less_imp_le subset_empty subset_singletonD)

definition 
  nat_lex_nat :: \<open>(((\<nat> \<times> \<nat>) set \<times> \<nat>) \<times> (((\<nat> \<times> \<nat>) set) \<times> \<nat>)) set\<close>
  where
  \<open>nat_lex_nat \<equiv> nat_fin_psub <*lex*> nat_term\<close>

lemma \<open>x \<in> nat_lex_nat\<close>
  using[[show_types]]
  oops
lemma \<open>((a, b), (a', b')) \<in> nat_lex_nat\<close>
  using[[show_types]]
  oops

lemma \<open>nat_lex_nat = 
      {(({}, 0), 
        ({(0, 1)}, 0)
       ), 
       (({}, 0), 
        ({(0, 1)}, 1)
       ), 
       (({}, 1), 
        ({(0, 1)}, 0)
       ), 
       (({}, 1), 
        ({(0, 1)}, 1)
       )}\<close>
  apply (intro equalityI subsetI, simp_all)
   defer
   apply (simp add: nat_lex_nat_def)
   apply (elim disjE, simp_all add: nat_fin_psub_def nat_term_def, blast+)
   apply (simp add: nat_lex_nat_def)
  unfolding lex_prod_def 
  apply (simp add: case_prod_beta)
  apply (elim disjE conjE, simp add: nat_fin_psub_def)
   apply clarsimp 
  oops

lemma "x < y \<Longrightarrow> (x, y) \<in> less_than"
  using less_than_def less_than_iff pred_nat_def by presburger


definition lex_prod' :: "('a \<times>'a) set \<Rightarrow> ('b \<times> 'b) set \<Rightarrow> (('a \<times> 'b) \<times> ('a \<times> 'b)) set"
    (infixr "<*lexi*>" 80)
    where "ra <*lexi*> rb = {((a, b), (a', b')). (a, a') \<in> ra } \<union> 
                            {((a, b), (a', b')). a = a' \<and> (b, b') \<in> rb}"

lemma lex_prod_equiv: "(ra <*lex*> rb) = (ra <*lexi*>rb)"
  by (safe, simp_all add: lex_prod_def lex_prod'_def)

subsection \<open>General version for all VDM set-recursive functions\<close>

definition 
  gen_fin_psub :: \<open>(('a \<times> 'a) VDMSet \<times> ('a \<times> 'a) VDMSet) VDMSet\<close>
  where
  \<open>gen_fin_psub \<equiv> finite_psubset\<close>

definition 
  gen_lex_nat :: \<open>((('a \<times> 'a) VDMSet \<times> \<nat>) \<times> ('a \<times> 'a) VDMSet \<times> \<nat>) VDMSet\<close>
  where
  \<open>gen_lex_nat \<equiv> gen_fin_psub <*lex*> pred_nat\<close>

lemma "wf gen_lex_nat"  
  by (simp add: gen_fin_psub_def gen_lex_nat_def wf_lex_prod wf_pred_nat)


    
lemma l_pre_sumset_empty[simp]: "pre_sumset {}" 
  by (simp add: pre_sumset_def)

lemma "pre_sumset {} \<Longrightarrow> sumset_dom {}" 
  by (meson empty_iff sumset.domintros)

definition 
  sumset_term' ::"(VDMNat VDMSet \<times> VDMNat VDMSet) set" where
  "sumset_term' \<equiv> finite_psubset \<inter> { (s1, s2) . pre_sumset s1 \<and> pre_sumset s2 }"


definition 
  sumset_term'' ::"(VDMNat VDMSet \<times> VDMNat VDMSet) set" where
  "sumset_term'' \<equiv> finite_psubset \<inter> { (s, s - {(SOME e . e \<in> s)})| s . s \<noteq> {} \<and> pre_sumset s }"

lemma l_sumset_term_not_empty: "sumset_term = {}"
   unfolding sumset_term_def
   apply (intro equalityI subsetI)
    apply simp_all
   unfolding finite_psubset_def
   apply (simp add: case_prod_beta) 
   apply (elim conjE exE)
   apply safe
   apply simp
   oops



lemma l_sumset_term'_wf: "wf sumset_term'"
  by (metis inf_le1 sumset_term'_def wf_finite_psubset wf_subset)


lemma l_sumset_term''_wf: "wf sumset_term''" 
  by (simp add: sumset_term''_def wf_Int1)

lemma l_pre_sumset_some: "pre_sumset x \<Longrightarrow> x \<noteq> {} \<Longrightarrow> pre_sumset (x - {SOME e. e \<in> x})"
  unfolding pre_sumset_def inv_VDMSet_def
  by (metis Diff_empty Diff_insert0 finite_Diff insert_Diff l_inv_SetElems_Cons)

lemma l_sumset_term'_iff[iff]: "(y, x) \<in> sumset_term' \<longleftrightarrow> (pre_sumset y \<and> pre_sumset x \<and> y \<subset> x)"
  apply (rule iffI)
   apply (simp add: sumset_term'_def)
  by (simp add: l_pre_sumset_finite sumset_term'_def)

lemma l_sumset_term_iff[iff]: "((x - {SOME e . e \<in> x}), x) \<in> sumset_term \<longleftrightarrow> (pre_sumset (x - {SOME e . e \<in> x}) \<and> pre_sumset x \<and> x \<noteq> {})"
  apply (rule iffI)
   apply (simp add: sumset_term_def l_pre_sumset_some)
  apply (simp add: sumset_term_def pre_sumset_def inv_VDMSet_def)
  apply (intro psubsetI)
   apply fastforce
  by (metis Diff_iff singletonI some_in_eq)
  
lemma "s \<noteq> {} \<Longrightarrow> pre_sumset s \<Longrightarrow> ({}, s) \<in> sumset_term" 
  apply (simp add: sumset_term_def l_pre_sumset_finite )
  oops
  

(*
lemma "pre_sumset (insert e s) \<Longrightarrow> sumset_dom (insert e s)"
  thm wf_induct 
      wf_induct[OF l_sumset_term_wf]
      wf_induct[OF l_sumset_term_wf, of "\<lambda> x . sumset_dom (insert e x)"] 
  apply (rule      wf_induct[OF l_sumset_term_wf, of "\<lambda> x . sumset_dom (insert e x)"] 
  )
  apply (simp add: l_sumset_term_iff)
  apply (erule_tac x=y in allE
  apply (rule sumset.domintros)
  apply (erule notE)
  oops
*)

  find_theorems name:"_dom" -name:VDMToolkit -name:Transfer -name:Map


  thm sumset.domintros
  thm sumset_rel.intros
  find_theorems name: accp
  find_theorems name: accp name:Wellfounded
  find_theorems "_Collect"
  find_consts name:sumset_rel

lemma "(sumset_dom s) \<longleftrightarrow> (s \<in> Wellfounded.acc { (x, y). (sumset_rel x y) })"
  by (simp add: accp_eq_acc)

lemma "s \<in> Wellfounded.acc { (x, y). (sumset_rel x y) }"
  apply (rule accI, simp)
  find_theorems "sumset_rel" 
  thm sumset_rel.intros

lemma "sumset_rel = lfp (\<lambda>p x1 x2. \<exists>s x. x1 = s - {x} \<and> x2 = s \<and> s \<noteq> {} \<and> x = (SOME x. x \<in> s))"
  apply (intro ext, simp add: lfp_def)
  apply (intro iffI allI impI)
   defer
  


(*     (lfp (\<lambda>(p (x1 x2)). ((x1 = (x2 - {(SOME x. (x \<in> x2))})) \<and> (x2 \<noteq> {}))) x xa) *)

(* (\<forall> e \<in> s . e \<ge> 0) \<Longrightarrow> ...(s - {SOME e \<in> s}, s) \<in> ?R.... \<Longrightarrow> sumset_dom s*)
lemma "pre_sumset s \<Longrightarrow> sumset_dom s"
    (*
  apply (rule wf_induct)
   1. pre_sumset s \<Longrightarrow> wf ?r
 2. \<And>x. pre_sumset s \<Longrightarrow> \<forall>y. (y, x) \<in> ?r \<longrightarrow> y \<Longrightarrow> x
    *)
(*
  apply (rule wf_induct[of _ \<open>\<lambda> x . sumset_dom x\<close> s])
  goal (2 subgoals):
   1. pre_sumset s \<Longrightarrow> wf ?r
   2. \<And>x. pre_sumset s \<Longrightarrow> \<forall>y. (y, x) \<in> ?r \<longrightarrow> sumset_dom y \<Longrightarrow> sumset_dom x
*)
  thm wf_induct 
      wf_induct[of _ \<open>\<lambda> x . sumset_dom x\<close> s]
      l_sumset_term''_wf 
      wf_subset
      wf_induct[OF l_sumset_term''_wf, of \<open>\<lambda> x . sumset_dom (x - {SOME e . e \<in> x})\<close> s]
  apply (rule wf_induct[OF l_sumset_term''_wf, of \<open>\<lambda> x . sumset_dom (x - {SOME e . e \<in> x})\<close> s])
  apply (erule_tac x=x in allE)
  apply (elim impE)
   apply (simp add: sumset_term_def)
  find_theorems name:induc name:fin name:set
  oops

lemma "pre_sumset s \<Longrightarrow> sumset_dom s"
  apply (rule wf_induct[OF l_sumset_term_wf, of \<open>\<lambda> x . sumset_dom x\<close> s])
  apply (erule_tac x=x in allE)
  apply (elim impE)
   apply (simp add: sumset_term_def)

   
definition 
  sumset_call :: \<open>(VDMNat VDMSet) \<Rightarrow> (VDMNat VDMSet)\<close>
  where
  \<open>sumset_call s \<equiv> if s = {} then {} else s - {(SOME e . e \<in> s)}\<close>

(* r = result of (f(s), f(s-{e})) for all s, or the computation of sumset with its <lex> for pred_nat?
   f = the result of the parameter decrease for f, or the decreasing measure for sumset? 
definition inv_image :: "'b rel \<Rightarrow> ('a \<Rightarrow> 'b) \<Rightarrow> 'a rel"
  where "inv_image r f = {(x, y). (f x, f y) \<in> r}"
*)
definition 
  sumset_lex_nat :: \<open>(((VDMNat \<times> VDMNat) VDMSet \<times> \<nat>) \<times> (VDMNat \<times> VDMNat) VDMSet \<times> \<nat>) VDMSet\<close>
  where
  \<open>sumset_lex_nat \<equiv> gen_fin_psub <*lex*> pred_nat\<close>

declare [[show_brackets]]
definition 
(*  sumset_lex_nat :: \<open>(((VDMNat \<times> VDMNat) VDMSet \<times> \<nat>) \<times> (VDMNat \<times> VDMNat) VDMSet \<times> \<nat>) VDMSet\<close>
  where
*)  
  sumset_lex_nat' :: \<open>(((VDMNat \<times> VDMNat) set \<times> ((VDMNat \<times> VDMNat) set \<times> \<nat>)) \<times> ((VDMNat \<times> VDMNat) set \<times> ((VDMNat \<times> VDMNat) set \<times> \<nat>))) set\<close>
  where
  \<open>sumset_lex_nat' \<equiv> gen_fin_psub <*lex*> gen_fin_psub <*lex*> pred_nat\<close>

lemma l_sumset_lex_nat_wf: "wf sumset_lex_nat"
  by (simp add: gen_fin_psub_def sumset_lex_nat_def wf_lex_prod wf_pred_nat)

lemma l_sumset_lex_nat'_wf: "wf sumset_lex_nat'"
  by (metis gen_fin_psub_def l_sumset_lex_nat_wf sumset_lex_nat'_def sumset_lex_nat_def wf_finite_psubset wf_lex_prod)

term "sumset_lex_nat"
term "inv_image sumset_lex_nat"
term "inv_image sumset_lex_nat'"

(*lemma "sumset_term \<subseteq> inv_image sumset_lex_nat sumset_call"
 *)

thm sumset.domintros
thm sumset.pinduct

lemma "pre_sumset s \<Longrightarrow> sumset_dom s" 
  thm sumset.domintros
  apply (rule sumset.domintros)
  apply (elim notE)
  find_theorems name:induc name:fin name:set

lemma "pre_sumset s \<Longrightarrow> sumset_dom s" 
proof - 
  { fix s :: "VDMNat VDMSet"
    have "pre_sumset s \<longrightarrow> sumset_dom s" (is "?P s \<longrightarrow> ?Q s")
      term "?P" 
      term "?Q"
    proof (rule wf_induct[OF l_sumset_term_wf])
      fix x :: "VDMNat VDMSet"
      assume ih: "(\<forall>y. (((y, x) \<in> sumset_term) \<longrightarrow> (?P y \<longrightarrow> ?Q y)))"
      show "?P x \<longrightarrow> ?Q x"
      proof
        assume P: "?P x" 
        show "?Q x" 
        thm sumset.domintros
        proof (rule sumset.domintros)
          thm sumset.cases
          using sumset.cases  
definition
  sumset_lex :: "((\<nat> set \<times> (\<nat> \<times> \<nat>) set \<times> \<nat>) \<times> \<nat> set \<times> (\<nat> \<times> \<nat>) set \<times> \<nat>) set"
  where
  "sumset_lex \<equiv> (finite_psubset :: (nat VDMSet \<times> nat VDMSet) VDMSet)
                 <*lex*> (finite_psubset :: ((nat \<times> nat) VDMSet \<times> (nat \<times> nat) VDMSet) VDMSet)
                 <*lex*> pred_nat"

lemma l1: "wf (finite_psubset :: (VDMNat VDMSet \<times> VDMNat VDMSet) VDMSet)" 
  using wf_finite_psubset by blast

lemma l2: "wf (finite_psubset :: ((VDMNat \<times> VDMNat) VDMSet \<times> (VDMNat \<times> VDMNat) VDMSet) VDMSet)"
  using wf_finite_psubset by blast

lemma l3: "wf ((finite_psubset :: (VDMNat VDMSet \<times> VDMNat VDMSet) VDMSet)
               <*lex*> (finite_psubset :: ((VDMNat \<times> VDMNat) VDMSet \<times> (VDMNat \<times> VDMNat) VDMSet) VDMSet)
               <*lex*> pred_nat)"
  by (simp add: wf_lex_prod wf_pred_nat)
  


theorem sumset_termination:  
  \<open>\<lbrakk>pre_sumset s\<rbrakk> \<Longrightarrow> sumset_dom s\<close>
  thm wf_induct wf
lemma lsum_set_domain_empty[simp]: "pre_sumset {}"
  unfolding pre_sumset_def 
  by simp

lemma lsum_empty_set_zero: "sumset {} = 0"
  thm ex_in_conv empty_iff all_not_in_conv equals0D
  find_theorems name:sumset
  apply (subst sumset.psimps)
   apply (meson empty_iff sumset.domintros)
  by simp
  
lemma lsum_set_dom_inv: "sumset_dom s \<Longrightarrow> pre_sumset s" 
  find_theorems name:sumset
  apply (frule sumset.psimps)
  apply (simp split: if_splits)
  oops
  
 (* 
  unfolding pre_sumset_def inv_VDMNat_def inv_SetElems_def   
  apply (induct rule: sumset.pinduct)
  apply (case_tac "s = {}", simp_all)
  apply (simp add: ex_in_conv[symmetric])
  apply (safe)
  apply (erule_tac x=x in ballE)
   apply simp+
  nitpick
   apply (meson empty_iff sumset.domintros)
  apply (cut_tac accI[of _ "sumset_rel"])
*)

lemma lsum_set_inv_dom: "pre_sumset s \<Longrightarrow> sumset_dom s" 
  apply (insert accp_wfPD[of sumset_rel s])
  unfolding wfP_def wf_def
  apply simp
  apply (cases "s = {}")
   apply (meson empty_iff sumset.domintros)
  apply (intro sumset.domintros)  
  apply (simp add: sumset.psimps)
  oops

lemma "finite (SIGMA a:A. B a)" 
  using [[show_types]]
  thm finite_set_choice
  thm finite_set_choice[of "{0,1,2,3::nat}"  "(\<lambda> x y . x < y)"]
  oops


  find_consts "'a set \<Rightarrow> 'a list"
  find_consts name:sorted_key_list_of_set
(*Set_Idioms, Mapping, Countable_Set*)
lemma lsum_set_result_is_nat:  
  "inv_SetElems inv_VDMNat s \<Longrightarrow> inv_VDMNat (sumset s)"
  unfolding inv_VDMNat_def inv_SetElems_def 
  apply (induct s rule: sumset.pinduct)
  
end