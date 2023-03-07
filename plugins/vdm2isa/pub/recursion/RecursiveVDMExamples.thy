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

\<comment> \<open>Automatic termination with pattern matching\<close>
fun factN' :: \<open>\<nat> \<Rightarrow> \<nat>\<close> where 
\<open>factN' n = (if n = 0 then 1 else n * (factN' (n - 1)))\<close> 

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

definition pre_factV :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where 
\<open>pre_factV n \<equiv> inv_VDMNat n\<close>

\<comment> \<open>VDM only operates if precondition is satisfied\<close>
function (domintros) factV :: \<open>VDMNat \<Rightarrow> VDMNat\<close> where
\<open>factV n = (if pre_factV n then (if n = 0 then 1 else n * (factV (n - 1))) else undefined)\<close>
  by (pat_completeness, auto) 

  \<comment> \<open>Well formedness expression relating conditions for every recursive and original calls\<close>
  abbreviation factV_wf :: \<open>(VDMNat \<times> VDMNat) set\<close> where
    \<open>factV_wf \<equiv> { (n - 1, n) | n . pre_factV n \<and> n \<noteq> 0 }\<close>
  
  \<comment> \<open>Notice the psimps (partial function) simplification rules and guarding domain predicates\<close>
  find_theorems name:"factV"

  \<comment> \<open>For VDM nat and int, we have proved general well formedness relations theorem\<close>
  termination
    apply (relation \<open>(gen_VDMNat_term factV_wf)\<close>) 
    \<comment> \<open>This enables sledgehammer to find the well-formedness part of the proof\<close>
    using l_gen_VDMNat_term_wf apply blast
    \<comment> \<open>Remains to be shown that the local recursive relation is within the general relation space\<close>
    (*Sledgehammering... No proof found *)
    oops

  termination 
    apply (relation \<open>(gen_VDMNat_term factV_wf)\<close>) 
    using l_gen_VDMNat_term_wf apply blast
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

end
(*>*)