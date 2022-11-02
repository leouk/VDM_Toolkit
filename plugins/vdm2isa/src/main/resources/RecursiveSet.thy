theory RecursiveSet
  imports VDMToolkit
begin

section \<open>Recursive partial recursive functions\<close>

text \<open>In Isabelle, recursive functions must discharge proof obligations on:
  \begin{enumerate}
  \item pattern completeness: 

        This relates to all patterns in a constructive type
        being refered to (e.g., @{term 0} and @{term \<open>Suc n\<close>} for @{typ \<nat>})).
  
  \item pattern compatibility:
  
        This relates to multiple way patterns can be constructed that boils
        down to the pattern completeness cases (e.g., @{term \<open>n + 2\<close>} being 
        simply multiple successor calls over constructors @{term \<open>Suc (Suc 0)\<close>}). 
  \end{enumerate}

  That is important to ensure that recursion is well structured (i.e., recursive calls will not
  get stuck because call constructs are not available). For example, if you miss the @{term 0} 
  case, eventually the @{term \<open>Suc n\<close>} case will reach zero and fail. 

  A final proof obligation is on termination: the recursion is well-founded. This has to be
  proved whenever properties of defined function are meant to be total. 

  For example, a function that finds the zero of functions can be given as:
\<close>
function findzero :: "(nat \<Rightarrow> nat) \<Rightarrow> nat \<Rightarrow> nat"
where
"findzero f n = (if f n = 0 then n else findzero f (Suc n))"
  by pat_completeness auto

print_theorems 
text \<open>Various theorems are made available, such as:

  @{thm findzero.cases}[display]
  Cases analysis

  @{thm findzero.pelims}[display]
  Elimination rules 

  @{thm findzero.pinduct}[display]
  Induction rules

  @{thm findzero.psimps}[display]
  Simplificaiton rules

  Note the last two are partial, module a domain predicate @{term findzero_dom},
  which represents a well-founded relation that ensures termination. These p-rules
  can be simplified into total rules that do not depend on a domain predicate, which
  can compicate proofs.
\<close>

section \<open>Exampe of recursive functions with non-constructive types\<close>

text\<open>Recursing on non-constructive types (e.g., sets, integers, etc.) entail 
    more involved compatibility and completeness proofs. They also usually lead to 
    partial function definitions, given Isabelle can't tell whether termination is
    immediatelly obvious. 

    In VDM, however, recursive functions on sets (as well as map domains) are common. 
    
    In our vdm2isa translator, we impose various implicit VDM checks as explicit predicates
    in Isabelle. In VDM, sets are always finite, and structural invariants are declared for types.

    Our example recursive function is given a set of @{typ \<nat>} and return their sum. In VDM,
    because of various type widening rules (e.g., @{term \<open>0 - (x::nat)\<close>} returns an integer result, 
    whereas in Isabelle this remains a @{typ \<nat>}.). We encode VDM
    corresponding type as @{typ VDMNat}. This is represented in Isabelle as @{typ \<int>} in order 
    to allow for VDM type widening rules during translation.

    The function is defined in VDM as:

    \begin{vdmsl}
        sumset: set of nat -> nat 
        sumset(s) == if s = {} then 0 else let e in set s in sumset(s - {e}) + e;
    \end{vdmsl}

    It consumes the set by picking each set element and summing them to the recursive call until
    the set is empty.

    In Isabelle, the implicit VDM checks are defined as the precondition, which ensures 
    that the given set contains only natural numbers, and is finite.\<close>

definition 
  pre_sumset :: "VDMNat VDMSet \<Rightarrow> \<bool>" 
  where
  "pre_sumset s \<equiv> inv_SetElems inv_VDMNat s \<and> inv_VDMSet s"

text \<open>Termination proof is achieved by establishing a well-founded relation associated with 
      the function recursive call with respect to its declaration. 

    In our case, that is the smaller set after picking @{term e} (@{term \<open>s - {(SOME e . e \<in> s)}\<close>}) 
    and the set used at definition, leading to the pairs @{term \<open>(s - {(SOME e . e \<in> s)}, s)\<close>}. 
    We ensure all the @{term s} involved are not empty and satisfy the function precondition (@{term pre_sumset}).

    Given this is a simple (non-mutual, single call-site, easy set element choice) recursion, 
    thankfully the setup is not as complex to establish well-foundedness. We piggyback on some
    Isabelle machinery by using the term:

    @{term finite_psubset}[display]

    It establishes that a relation where the first element is strictly smaller set than the 
    second element in the relation pair. This makes the proof of well-foundedness easy for 
    @{command sledgehammer}, which is important in order for translated code be easier to prove. 
        \<close>
definition 
  sumset_term ::"(VDMNat VDMSet \<times> VDMNat VDMSet) set" where
  "sumset_term \<equiv> finite_psubset \<inter> { (s - {(SOME e . e \<in> s)}, s)| s . s \<noteq> {} \<and> pre_sumset s }"

text \<open>Termination requires well-founded relation, so we prove that function sumset termination 
      relation is well-founded using @{command sledgehammer}.\<close>
lemma l_sumset_term_wf: "wf sumset_term"
  by (simp add: sumset_term_def wf_Int1)

text \<open>Moreover, once we establish well-foundedness, we need to get to the termination relation
      from the filtering predicate defined through the precondition (i.e. the precondition helps
      establish the terminating relation). 

      In this case, the only needed term for Isabelle to establish termination is set finiteness, 
      however, we insist on the whole precondition to ensure that the intended VDM meaning is 
      maintained.\<close>
lemma l_pre_sumset_sumset_term: 
  "pre_sumset s \<Longrightarrow> s \<noteq> {} \<Longrightarrow> x = (SOME x. x \<in> s) \<Longrightarrow> (s - {x}, s) \<in> sumset_term"
  apply (simp add: pre_sumset_def sumset_term_def)
  by (metis Diff_subset l_invVDMSet_finite_f member_remove psubsetI remove_def some_in_eq)

text \<open>Finally, we can define our recursive function in Isabelle. It checks whether the given
      set satisfy the function precondition. If it doesn't, @{term undefined} is returned.
      If it does, then each case is encoded pretty much 1-1 from VDM using Hilbert's choice operator.\<close>
function (domintros)
  sumset :: "VDMNat VDMSet \<Rightarrow> VDMNat" 
  where 
  "sumset s = 
    (if pre_sumset s then 
        (if s = {} then 
            0 
         else 
            let e = (SOME x . x \<in> s) in 
              sumset (s - {e}) + e) 
     else 
        undefined
    )"
  text \<open>The pattern completeness and compatibility goals are given as 
        @{goals}[display]

        We follow the ``usual'' proof strategy for this using pat completeness tactic.
        For more general examples, if that fails, @{command sledgehammer} should be used.
       \<close>
  by (pat_completeness, auto)
termination
  text \<open>Next, we have to discharge the termination proof, which is given as
       @{goals}[display]\<close>
  apply (rule "termination"[of "sumset_term"])
  text \<open>We follow the strategy of using the termination relation and well formedness, which
       transforms the mysterious/abstract domain predicate into two new subgoals
       @{goals}[display]

       The first goal is direclty discharged with @{thm l_sumset_term_wf}.\<close>
   apply (simp add: l_sumset_term_wf)
  text \<open>Finally, we show that termination relation is entailed by function precondition.\<close>
  by (simp add: l_pre_sumset_sumset_term)

text \<open>Is the sumset termination relaiton non-trivial?\<close>
lemma l_sumset_term_not_empty: "sumset_term \<noteq> {}"
  apply safe
  find_theorems elim
  apply (erule equalityE)
  find_theorems "{} \<subseteq> _"
  find_theorems "_ \<subseteq> {}" elim
  find_theorems "(_ \<subseteq> _) = _" 
  thm subset_iff_psubset_eq subset_eq
  apply (simp add: subset_eq)
  unfolding sumset_term_def
  apply simp
  apply (erule_tac x="{1}" in allE)
  by (auto simp add: pre_sumset_def inv_VDMNat_def) 

end