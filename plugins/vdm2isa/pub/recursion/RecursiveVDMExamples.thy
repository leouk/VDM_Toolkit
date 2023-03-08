(*<*)
(*:maxLineLen=78:*)
theory RecursiveVDMExamples
imports VDMToolkit
begin

(********************************************************)
section \<open>Constructive type (\<^typ>\<open>\<nat>\<close>) recursion primitive and function\<close>

\<comment> \<open>Automatic with pattern matching only, if-then-else fails\<close>
primrec factN :: \<open>\<nat> \<Rightarrow> \<nat>\<close> where 
\<open>factN n = (if n = 0 then 1 else n * (factN (n - 1)))\<close>

\<comment> \<open>Automatic but forces \<^typ>\<open>\<nat>\<close> constructors\<close>
primrec factN :: \<open>\<nat> \<Rightarrow> \<nat>\<close> where
  \<open>factN       0 = 1\<close> 
| \<open>factN (Suc n) = (n * (factN n))\<close>

\<comment> \<open>Pattern completeness missed is allowed as a warning\<close>
primrec factNmissingConstructors :: \<open>\<nat> \<Rightarrow> \<nat>\<close> where
  \<open>factNmissingConstructors 0 = 1\<close> 

\<comment> \<open>Automatic termination with pattern matching\<close>
fun factN' :: \<open>\<nat> \<Rightarrow> \<nat>\<close> where 
\<open>factN' n = (if n = 0 then 1 else n * (factN' (n - 1)))\<close> 

\<comment> \<open>Pattern completeness missed is provided as undefined\<close>
fun factNincmplete' :: \<open>\<nat> \<Rightarrow> \<nat>\<close> where 
\<open>factNincmplete' (Suc n) = (factNincmplete' n)\<close> 

(********************************************************)
section \<open>Algebraic type  (\<^typ>\<open>\<int>\<close>) recursion primitive and function\<close>

\<comment> \<open>Primitive recursion doesn't work for non-constructive types\<close>
primrec factZ :: \<open>VDMNat \<Rightarrow> VDMNat\<close> where 
  \<open>factZ 0 = 1\<close>

\<comment> \<open>Function works but can't find termination proof automatically\<close>
fun factZ :: \<open>VDMNat \<Rightarrow> VDMNat\<close> where 
\<open>factZ n = (if n = 0 then 1 else n * (factZ (n - 1)))\<close> 

\<comment> \<open>User must provide termination argument\<close>
function (domintros) factZ :: \<open>VDMNat \<Rightarrow> VDMNat\<close> where 
\<open>factZ n = (if n = 0 then 1 else n * (factZ (n - 1)))\<close> 
  \<comment> \<open>pattern consistency goal\<close>
   apply simp
  \<comment> \<open>pattern completeness goal\<close>
  by simp

  \<comment> \<open>Recursive termination goal\<close>
  termination
    oops

  \<comment> \<open>Various theorems about recursion\<close>
    find_theorems name:"factZ"
    
(********************************************************)
section \<open>Simple recursion catering for VDM specification\<close>

\<comment> \<open>Automatically generated: implicitly inferred input type invariant check\<close>
definition pre_factV :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where 
\<open>pre_factV n \<equiv> inv_VDMNat n\<close>

\<comment> \<open>VDM only operates if precondition is satisfied\<close>
function (domintros) factV :: \<open>VDMNat \<Rightarrow> VDMNat\<close> where
\<open>factV n = (if pre_factV n then (if n = 0 then 1 else n * (factV (n - 1))) else undefined)\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag sledgehammer\<close>

  \<comment> \<open>Well formedness expression relating conditions for every recursive and original calls\<close>
  abbreviation factV_wf :: \<open>(VDMNat \<times> VDMNat) set\<close> where
    \<open>factV_wf \<equiv> { (n - 1, n) | n . pre_factV n \<and> n \<noteq> 0 }\<close>
  
  \<comment> \<open>Notice the psimps (partial function) simplification rules and guarding domain predicates\<close>
  find_theorems name:"factV"

  \<comment> \<open>For VDM nat and int, we have proved general well formedness relations theorem\<close>
  termination
    apply (relation \<open>(gen_VDMNat_term factV_wf)\<close>) 
    \<comment> \<open>This enables sledgehammer to find the well-formedness part of the proof\<close>
    using l_gen_VDMNat_term_wf apply blast \<^marker>\<open>tag sledgehammer\<close>
    \<comment> \<open>Remains to be shown that the local recursive relation is within the general relation space\<close>
    (*Sledgehammering... No proof found *)
    oops

  termination 
    apply (relation \<open>(gen_VDMNat_term factV_wf)\<close>) 
    using l_gen_VDMNat_term_wf apply blast \<^marker>\<open>tag sledgehammer\<close>
    \<comment> \<open>Even though sledgehammer struggles, the proof is in fact trivial\<close>
    by (simp add: pre_factV_def int_ge_less_than_def)

  \<comment> \<open>Notice the psimps (partial function) simplification rules are gone, and simps (total function) are in place instead\<close>
  find_theorems name:factV

definition largest_wf_int_rel :: "\<int> \<Rightarrow> (\<int> \<times> \<int>) set" where
"largest_wf_int_rel d = {(z', z). d \<le> z' \<and> z' < z}"

\<comment> \<open>Flag can also generate this lemma (and proof sketch) to ensure the recursive relation is a fix-point\<close>
\<comment> \<open>This is useful when recursive relation is not within largest upper bound to discover how to prove it well formed\<close>
lemma l_fact_term_valid: \<open>(gen_VDMNat_term factV_wf) = factV_wf\<close>
  apply (simp )
  apply (intro equalityI subsetI)
  apply (simp_all add: pre_factV_def int_ge_less_than_def case_prod_beta)
  by auto

(********************************************************)
section \<open>VDM recursion over sets\<close>

\<comment> \<open>  
  sumset: set of nat -> nat 
  sumset(s) == if s = {} then 0 else let e in set s in sumset(s - {e}) + e
  pre (forall n in set s & n > 5)
  --@IsaMeasure({(x - { let e in set x in e }, x) | x : set of nat & x <> {}}) 
  --@Witness(sumset({ 1 }))
  measure card s;
\<close>

\<comment> \<open>Automatically generated: implicitly inferred type invariant check + user defined pre\<close>
definition pre_sumset :: \<open>VDMNat VDMSet \<Rightarrow> \<bool>\<close> where
  \<open>pre_sumset s \<equiv> inv_VDMSet' inv_VDMNat s \<and> (\<forall> n \<in> s . n > 5)\<close>

\<comment> \<open>Automatically generated def set: inferred from function AST + signature\<close>
lemmas pre_sumset_defs = pre_sumset_def inv_VDMSet'_defs 

\<comment> \<open>Mostly verbatim translation from VDM; let-in-set becomes Isabelle's Hilbert Choice binder (\<some>)\<close>
function (domintros) sumset :: \<open>VDMNat VDMSet \<Rightarrow> VDMNat\<close> where 
  \<open>sumset s = (if pre_sumset s then 
                  (if s = {} then 0 else 
                      let e = (\<some> x . x \<in> s) in sumset (s - {e}) + e) 
                   else undefined)\<close>
  \<comment> \<open>Automatically generated proof for pattern compatibility and completeness\<close>
  \<comment> \<open>Users will have to finish this before proceeding if proof suggestion fails!\<close>
  by (pat_completeness, auto)

  \<comment> \<open>Recursive definitions available, yet as partial functions (psimps + dom predicate)\<close>
  find_theorems name:"sumset"

  \<comment> \<open>Well founded recursive relation translated from user defined @IsaMeasure\<close>
  \<comment> \<open>We automatically infer recursive relations for this specific (commonly used) kind of set recursion\<close>
  \<comment> \<open>It is crucial for termination proof that pre condition is included, which translator does automatically\<close>
  abbreviation sumset_wf_rel :: \<open>(VDMNat VDMSet \<times> VDMNat VDMSet) set\<close> where
    \<open>sumset_wf_rel \<equiv> { (s - {(\<some> e . e \<in> s)}, s)| s . pre_sumset s \<and> s \<noteq> {}}\<close>

  \<comment> \<open>Translator infers recursive relation well formedness lemma being about sets\<close>
  lemma l_sumset_rel_wf: \<open>wf (gen_set_term sumset_wf_rel)\<close>
    \<comment> \<open>Proof in this case is discovered by sledgehammer\<close>
    using l_gen_set_term_wf by blast \<^marker>\<open>tag sledgehammer\<close>

  \<comment> \<open>Termination proof setup is automatically generated\<close>
  termination
    apply (relation \<open>(gen_set_term sumset_wf_rel)\<close>)
    using l_sumset_rel_wf apply blast \<^marker>\<open>tag sledgehammer\<close>
    oops

  \<comment> \<open>Verbatim copy of failed goal. Perhaps could be auto generated? (Problem it might be spurious)\<close>
  lemma l_pre_sumset_sumset_wf_rel: 
     \<open>pre_sumset s \<Longrightarrow> s \<noteq> {} \<Longrightarrow> (s - {(\<some> x. x \<in> s)}, s) \<in> (gen_set_term sumset_wf_rel)\<close>
    unfolding gen_set_term_def apply (simp add: pre_sumset_defs)\<^marker>\<open>tag manual\<close>
    by (metis Diff_subset member_remove psubsetI remove_def some_in_eq)\<^marker>\<open>tag sledgehammer\<close>

  \<comment> \<open>Lemma enables sledgehammer to find the termination proof\<close>
  termination
    apply (relation \<open>(gen_set_term sumset_wf_rel)\<close>)
    using l_sumset_rel_wf apply blast \<^marker>\<open>tag sledgehammer\<close>
    using l_pre_sumset_sumset_wf_rel by presburger \<^marker>\<open>tag sledgehammer\<close>

  \<comment> \<open>Recursive definitions available as total functions (simps)\<close>
  find_theorems name:"sumset"

  \<comment> \<open>Recursion over maps is similar, if more involved; see paper source\<close>

  \<comment> \<open>VDM measures are not expressive enough for relational measures\<close>

(********************************************************)
section \<open>Complex recursion examples\<close>


end
(*>*)