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
\<comment> \<open>Notice the unfolding is staggered and deep into the AST term\<close>
lemmas pre_sumset_defs = pre_sumset_def inv_VDMSet'_defs inv_VDMNat_def 

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

  \<comment> \<open>VDM measures are not expressive enough for non-functional measures?\<close>

(********************************************************)
section \<open>Complex recursion example with automation support\<close>

\<comment> \<open>ack: nat * nat -> nat 
    ack(m,n) == if m = 0 then n+1
           else if n = 0 then ack(m-1, 1)
           else               ack(m-1, ack(m, (n-1)))
    --@IsaMeasure( pair_less_VDMNat )
    measure is not yet specified;
  \<close>

definition pre_ack :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> \<bool>\<close> where
  \<open>pre_ack m n \<equiv> inv_VDMNat m \<and> inv_VDMNat n\<close>
lemmas pre_ack_defs = pre_ack_def 

function (domintros) ack :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat\<close> where
  \<open>ack m n = (if pre_ack m n then
                       if m = 0 then n+1
                  else if n = 0 then ack (m-1) 1
                  else               ack (m-1) (ack m (n-1))
                  else               undefined)\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag sledgehammer\<close>

  \<comment> \<open>User defined well formed relation, yet as part of Isabelle's high levels of automation armoury \<close>
  abbreviation ack_wf :: \<open>((VDMNat \<times> VDMNat) \<times> (VDMNat \<times> VDMNat)) VDMSet\<close> 
    where \<open>ack_wf \<equiv> pair_less_VDMNat\<close>

  \<comment> \<open>Proof is manual, but mostly discovered by sledgehammer\<close>
  termination 
    apply (relation ack_wf)\<^marker>\<open>tag manual\<close>
    using wf_pair_less_VDMNat apply blast \<^marker>\<open>tag sledgehammer\<close>
    apply (simp add: l_pair_less_VDMNat_I1 pre_ack_def) \<^marker>\<open>tag sledgehammer\<close>
    apply (simp add:  pre_ack_defs) \<^marker>\<open>tag sledgehammer\<close>
    by (simp add: pair_less_VDMNat_def pre_ack_def) \<^marker>\<open>tag sledgehammer\<close>

(********************************************************)
section \<open>Complex recursion where Isabelle proof discovers missing VDM specification!\<close>

\<comment> \<open>perm: int * int * int -> int 
    perm(m,n,r) == if 0 < r then perm(m, r-1, n) 
              else if 0 < n then perm(r, n-1, m) else m
    measure is not yet specified;\<close>

definition pre_perm :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>\<close> where
  \<open>pre_perm m n r \<equiv> inv_VDMInt m \<and> inv_VDMInt n \<and> inv_VDMInt r\<close>
lemmas pre_perm_defs = pre_perm_def inv_VDMInt_def inv_True_def

function (domintros) perm :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt\<close> where
  \<open>perm m n r = (if pre_perm m n r then
                         if 0 < r then perm m (r-1) n 
                    else if 0 < n then perm r (n-1) m else m
                 else undefined)\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag sledgehammer\<close>

  \<comment> \<open>Inferred recursive relation based on recursive call patterns and VDM AST\<close>
  definition perm_wf_rel :: \<open>((VDMInt \<times> VDMInt \<times> VDMInt) \<times> 
                              (VDMInt \<times> VDMInt \<times> VDMInt)) VDMSet\<close>
    where \<open>perm_wf_rel \<equiv> 
     { ((m, r-1, n), (m, n, r)) | m r n . pre_perm m n r \<and> 0 < r } \<union> 
     { ((r, n-1, m), (m, n, r)) | m r n . pre_perm m n r \<and> \<not> 0 < r \<and> 0 < n }\<close>

  \<comment> \<open>Automatically generated lemma left for the user to discharge\<close>
  \<comment> \<open>This will force the user to think of a VDM measure to use, which can be
      expressed in this case using the measure method\<close>
  lemma l_perm_wf_rel: \<open>wf perm_wf_rel\<close>
    sorry

  termination 
    apply (relation \<open>perm_wf_rel\<close>) 
      apply (simp add: l_perm_wf_rel) \<^marker>\<open>tag sledgehammer\<close>
    \<comment> \<open>Sledgehammer fails here, yet the proof is "easy" \<close>
    by (simp_all add: perm_wf_rel_def)  \<^marker>\<open>tag manual\<close>

  (*----------------------------------------------------------------*)
  subsection \<open>Distilling missing proof: take 1\<close>

  \<comment> \<open>Suggests a VDM measure as max(m+n+r, 0)\<close>
  lemma l_perm_wf_rel_VDM_measure: 
    \<open>perm_wf_rel \<subseteq> measure (\<lambda> (m, r, n) . nat (max 0 (m+r+n)))\<close>
    apply (intro subsetI, case_tac x)
      apply (simp add: pre_perm_defs perm_wf_rel_def case_prod_beta max_def)
       apply (elim disjE conjE, simp_all) 
       nitpick
       \<comment> \<open>Counter example shows the recursion would fail for certain inputs!\<close>
       \<comment> \<open>It suggests a precondition is needed.\<close>
       \<comment> \<open>@NB would quickcheck find it?\<close>
       sorry

  \<comment> \<open>If measure lemma is proved, sledgehammer can find the missing proof\<close>
  lemma l_perm_wf_rel': \<open>wf perm_wf_rel\<close>
    using l_perm_wf_rel_VDM_measure wf_subset by blast

  (*----------------------------------------------------------------*)
  subsection \<open>Distilling missing proof: take 2\<close>

  \<comment> \<open>Reviewed VDM specification must include:
      * pre ((0 < r or 0 < n) => m+n+r > 0)   
      * measure maxs({m+n+r, 0});    
     \<close>
  definition pre_perm' :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>\<close> where
    \<open>pre_perm' m n r \<equiv> pre_perm m n r \<and> ((0 < r \<or> 0 < n) \<longrightarrow> m+n+r > 0)\<close>
  lemmas pre_perm'_defs = pre_perm'_def pre_perm_defs

  definition perm_wf_rel' :: \<open>((VDMInt \<times> VDMInt \<times> VDMInt) \<times> 
                              (VDMInt \<times> VDMInt \<times> VDMInt)) VDMSet\<close>
    where \<open>perm_wf_rel' \<equiv> 
     { ((m, r-1, n), (m, n, r)) | m r n . pre_perm' m n r \<and> 0 < r } \<union> 
     { ((r, n-1, m), (m, n, r)) | m r n . pre_perm' m n r \<and> \<not> 0 < r \<and> 0 < n }\<close>

function (domintros) perm' :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt\<close> where
  \<open>perm' m n r = (if pre_perm' m n r then
                         if 0 < r then perm' m (r-1) n 
                    else if 0 < n then perm' r (n-1) m else m
                 else undefined)\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag sledgehammer\<close>

  lemma l_perm_wf_rel_VDM_measure':
    \<open>perm_wf_rel' \<subseteq> measure (\<lambda> (m, r, n) . nat (max 0 (m+r+n)))\<close>
    apply (intro subsetI, case_tac x)
      apply (simp add: pre_perm'_defs perm_wf_rel'_def case_prod_beta max_def)
       apply (elim disjE conjE, simp_all) 
  done

  \<comment> \<open>With the lemma proved, sledgehammer can find the missing proof on updated spec\<close>
  lemma l_perm_wf_rel'': \<open>wf perm_wf_rel'\<close>
    using l_perm_wf_rel_VDM_measure' wf_subset by blast

  termination 
    apply (relation \<open>perm_wf_rel'\<close>) 
      apply (simp add: l_perm_wf_rel'') \<^marker>\<open>tag sledgehammer\<close>
    \<comment> \<open>Sledgehammer fails here, yet the proof is "easy" \<close>
    by (simp_all add: perm_wf_rel'_def)  \<^marker>\<open>tag manual\<close>

end
(*>*)