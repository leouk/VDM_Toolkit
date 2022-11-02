theory RecursiveVDMNat
  imports VDMToolkit
begin

text \<open>VDM expressions with basic-typed (nat, int) variables (e.g. @{term \<open>x-y\<close>}) 
  have specific type widening rules (e.g. if both variables are nat, the result might be int).
  Therefore, in Isabelle VDM nats become @{typ VDMNat}, which are just a synonym for @{typ \<int>}.

  Isabelle recursive functions requires a proof obligation that parameters represent a 
  constructive and compatible pattern, and that recursive calls terminate. Nevertheless,
  @{typ \<int>} in Isabelle is defined in terms of a pair of @{typ \<nat>}, hence recursion over @{typ \<int>}
  are involved. Given VDM needs to represent its nat variables as @{typ VDMNat} this will make
  VDM recursive functions in Isabelle involved as well.
 
  To give a concrete example, we define a recursive implementation of factorial in VDM 
  translated to Isabelle as:

  \begin{vdmsl}
    factorial: nat -> nat 
    factorial(n) == if n = 0 then 1 else n * factorial(n)
    measure n;
  \end{vdmsl}

  For translation, we firt encode the implicit precondition of factorial that 
  insists that the given parameter @{term n} is a @{typ VDMNat}
\<close>
definition 
  pre_vdm_factorial :: \<open>VDMNat \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_vdm_factorial n \<equiv> inv_VDMNat n\<close>

text \<open>Next, we define the factorial function through recursion, where 
      when the precondition fails, we return @{term undefined}, which is 
      a term that cannot be reasoned with in Isabelle (i.e. it's a dead end).
      Otherwise, we define factorial pretty much as in VDM.\<close>
function (domintros) vdm_factorial :: \<open>VDMNat \<Rightarrow> VDMNat\<close>
  where
  \<open>vdm_factorial n =
    (if pre_vdm_factorial n then
      (if n = 0 then 
        1
      else
        n * (vdm_factorial (n - 1))
      )
    else
      undefined)\<close>
  text \<open>Pattern compatibility and completeness is discharged with the usual proof strategy in this case.
        In the general (more complex recursive call cases, e.g., Ackerman's function for instance), the 
        user might have goals to discharge.\<close>
  by (pat_completeness, auto)

text \<open>Following the same strategy as before for sets, we define a relation representing 
  the recursive and original call, respectively. The relation contains only input values 
  that satisfy the precondition of factorial as well as the specific case which recursion occurs (e.g. @{term \<open>0 < n\<close>}).\<close>
abbreviation 
  vdm_factorial_wf :: \<open>(VDMNat \<times> VDMNat) set\<close>
  where
  "vdm_factorial_wf \<equiv> { (n - 1, n) | n . 0 < n \<and> pre_vdm_factorial n }"

text \<open>To make well foundedness proof easy, we reuse an already proved well founded 
  relation for the integers, with the relation 
  @{term int_ge_less_than}[display] which we start from @{term 0}. 
  This is quite similar to the strategy used for finite subsets with @{term finite_psubset}[display].\<close>
definition
  vdm_factorial_term :: \<open>(VDMNat \<times> VDMNat) set\<close>
  where
  \<open>vdm_factorial_term \<equiv> (int_ge_less_than 0) \<inter> vdm_factorial_wf\<close>

text \<open>Because @{term int_ge_less_than} is already well founded (e.g. @{thm wf_int_ge_less_than}[display]),
  the proof for our definition is trivial.\<close>
lemma l_vdm_factorial_term_wf: "wf vdm_factorial_term" 
  by (simp add: vdm_factorial_term_def wf_int_ge_less_than wf_Int1)

text \<open>To mak sure our choice is valid (e.g. doesn't lead to the empty relation), we ensure
  that indeed the termination relation is in fact the same as the well founded predicate.\<close>
lemma l_vdm_factorial_term_valid: "vdm_factorial_term = vdm_factorial_wf"
  apply (simp add: vdm_factorial_term_def pre_vdm_factorial_def inv_VDMNat_def)
  apply (intro equalityI subsetI)
   apply (simp_all add: int_ge_less_than_def case_prod_beta)
  by auto

text \<open>Finally, we prove termination using the previously proved lemmas using the @{method relation}.
  This simplifies the goal into well formedness of termination relation and that the precondition implies it,
  both of which are easily proved with simplification in this case.\<close>
termination 
  apply (relation \<open>vdm_factorial_term\<close>)
   apply (simp add: l_vdm_factorial_term_wf)
  by (simp add: inv_VDMNat_def pre_vdm_factorial_def vdm_factorial_term_def int_ge_less_than_def)
  
end