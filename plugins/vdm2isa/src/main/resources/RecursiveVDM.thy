(*<*)
theory RecursiveVDM
imports VDMToolkit
begin
(*>*)

(**************************************************************************************************)
section \<open>Introduction\<close>

text \<open>This paper describes a translation strategy for a variety of recursive definitions from 
VDM to Isabelle/HOL. The strategy takes into account the differences in how termination and well-foundedness 
are represented in both formalisms. 

It is an extension to a VDM to Isabelle/HOL translation strategy and 
implementation\footnote{\url{https://github.com/leouk/VDM_Toolkit}} as a plugin to 
VDMJ~\cite{Battle09} and extension to VDM-VSCode~\cite{AdvancedVSCodePaper}.\<close>

(**************************************************************************************************)
section \<open>Background\<close> 

text \<open>The VDM to Isabelle/HOL translator caters for a wide range of the VDM AST. It copes with all kinds 
of expressions, a variety VDM patterns, all VDM types, VDM imports and exports, VDM functions and specifications,
VDM traces, and some of VDM state and operations. Even though not all kinds of VDM patterns are allowed,
the translator copes with most, and where it does not, a corresponding equivalent is possible. Among the 
expressions, map comprehension is of note, given its (implicit) complexity.

One particular area we want to extend the translation into is the one over recursively defined functions. 
VDM requires the user to define a measure function to justify why recursion will terminate. It then generates
proof obligations to ensure totality and termination. 

ANYTHING ELSE? Relates work?
\<close>

(**************************************************************************************************)
section \<open>VDM basic types in Isabelle\<close>

text \<open>Isabelle represents natural numbers (\<^typ>\<open>\<nat>\<close>) as a (data) type with two constructors (\<^term>\<open>0\<close> and \<^term>\<open>Suc n\<close>), 
  where all numbers are projections over such constructions (\textit{e.g.}~@{lemma "3 = (Suc (Suc (Suc 0)))" by simp}.   
  Isabelle integers (\<^typ>\<open>\<int>\<close>) are defined as quotient type involving two natural numbers. Like with integers, other
  Isabelle numeric types (\textit{e.g.}~rationals\<^typ>\<open>\<rat>\<close>, reals \<^typ>\<open>\<real>\<close>, \textit{etc.}) are defined in terms of some
  involved natural number construction. Type conversions (or coercions) are then defined to allow users to jump
  between type spaces. Nevertheless, Isabelle has no implicit type widening rule for \<^typ>\<open>\<nat>\<close>; instead, it takes the
  following convention:~@{lemma \<open>(0 - x::\<nat>) = 0\<close> by simp}. For mixutre of\<^typ>\<open>\<int>\<close> and \<^typ>\<open>\<nat>\<close>, explicit user-defined
  type coercions are needed (\textit{e.g.}~@{lemma \<open>(2::\<nat>) - (3::\<int>) = -1\<close> by simp}).

  VDM expressions with basic-typed (\texttt{nat}, \texttt{int}) variables have specific type widening rules 
  (\textit{i.e.}~even if both variables are \texttt{nat}, the result might be \textit{int}). Therefore, our translation 
  strategy considers VDM \texttt{nat} as the Isabelle type \<^typ>\<open>VDMNat\<close>, which is just a type synonym for \<^typ>\<open>\<int>\<close>. This 
  simplifies the translation process to Isabelle, such that no type coercions are necessary to encode all VDM type widenning rules. 
\<close>

(**************************************************************************************************)
section \<open>Recursion in VDM and in Isabelle\<close>

text \<open>Recursive definitions are pervasive in most VDM models. For example, it can be used to perform 
iterations over numbers, lists, sets, \textit{etc}. An important aspect of every recursive definition
is an argument that justifies its termination (\textit{i.e.}~otherwise, the recursion might go on 
in an infinite loop).

In VDM, this is defined using a recursive measure:~it has the same input type signature as
the recursive definition, and returns a \texttt{nat}, which \textbf{must} monotonically decrease 
at each recursive call, eventually reaching zero. This is how termination of recursive definitions 
are justified in VDM. 

A simple example of VDM recursive definition is one for calculating the factorial of a given natural number
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
   factorial: nat -> nat 
   factorial(n) == if n = 0 then 1 else n * factorial(n - 1)
   -- For the measure below, VDMJ produces a measure function as: 
   -- measure_factorial: nat -> nat
   -- measure_factorial(n) == n
   measure n;   
\end{vdmsl} 
%
\noindent The VDM recursive measure simply uses \texttt{n} itself; this works because the only recursive 
call is made with a decreasing value of \texttt{n}, until it reaches \texttt{0} and terminates. VDMJ generates 
three proof obligations for the definition above.
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
  Proof Obligation 1: (Unproved)
  factorial; measure_factorial: total function obligation in 'RecursiveVDM' at line 10:12
  (forall n:nat & is_(measure_factorial(n), nat))
  
  Proof Obligation 2: (Unproved)
  factorial: subtype obligation in 'RecursiveVDM' at line 6:57
  (forall n:nat & (not (n = 0) => (n - 1) >= 0))
  
  Proof Obligation 3: (Unproved)
  factorial: recursive function obligation in 'RecursiveVDM' at line 5:4
  (forall n:nat & (not (n = 0) => measure_factorial(n) > measure_factorial((n - 1))))
\end{vdmsl} 
%
\noindent They are trivial to discharge in Isabelle given the definition of \texttt{measure\_factorial} is just \texttt{n} 
(\textit{e.g.}~@{lemma \<open>\<forall> n::\<nat> . \<not> n = 0 \<longrightarrow> n - 1 \<ge> 0\<close> by simp}, @{lemma \<open>\<forall> n::\<nat> . \<not> n = 0 \<longrightarrow> n > n - 1\<close> by simp}).
 
In Isabelle, recursive definitions can be provided through primitive recursion or function definitions. 
The former insists on definition for each type constructor and only provides simplification rules; whereas
the latter allow for more sophisticated input patterns and provides simplification, elimination and 
induction rules, as well as partial function considerations. For the purposes of this paper, we only 
consider function definitions. Readers can find more about these differences in~\cite{IsaFunctionPackage}. 

Isabelle recursive functions requires a proof obligation that parameters represent a constructive and 
compatible pattern, and that recursive calls terminate. Constructive patterns relates to all constructors 
in data type being defined in the recursion (\textit{e.g.,}~one equation for each of the constructors of \<^typ>\<open>\<nat>\<close>, 
hence one involving \<^term>\<open>0\<close> and another involving \<^term>\<open>Suc n\<close>). Compatible patterns relates to multiple ways 
patterns can be constructed will boil down to the pattern completeness cases (\textit{e.g.,}~\<^term>\<open>n + 2\<close> being 
simply multiple calls over defined constructors like \<^term>\<open>Suc (Suc n)\<close>). That is important to ensure that recursion 
is well structured (\textit{i.e.,}~recursive calls will not get stuck because some constructs are not available). 
For example, if you miss the \<^term>\<open>0\<close> case, eventually the \<^term>\<open>Suc n\<close> case will reach zero and fail as no patterns for zero exist. 
The proof obligation for termination establishes that the recursion is well-founded. This has to be proved whenever 
properties of defined function are meant to be total. 

Isabelle function definitions can be given with either \<^term>\<open>fun\<close> or \<^term>\<open>function\<close>. The
former attempts to automatically prove the pattern constructive and compatible proofs and finds a measure 
for other termination proof obligations. The latter allows the user to do the proof manually, as well as provide a measure relation.
This relation must be well-formed, which means have a well-ordered induction principle over a partially ordered relation\footnote{For 
details on what that means in Isabelle, see the \<^class>\<open>wellorder\<close> theorem @{thm wf} in theory \texttt{Wellfounded.thy}}. 
For example, an Isabelle definition of factorial that it automatically discovers all three proofs can be given as\<close>
(*
find_theorems name:wellorder
print_locale! wellorder *)
fun 
  factorial :: \<open>\<nat> \<Rightarrow> \<nat>\<close>
  where 
  "factorial n = (if n = 0 then 1 else n * (factorial (n - 1)))" 
(*
fun 
  factorial' :: \<open>\<int> \<Rightarrow> \<int>\<close>
  where 
  "factorial' n = (if n = 0 then 1 else n * (factorial' (n - 1)))" 

function 
  factorial' :: \<open>\<int> \<Rightarrow> \<int>\<close>
  where 
  "factorial' n = (if n = 0 then 1 else n * (factorial' (n - 1)))" 
  by (pat_completeness, auto)
termination 
  sledgehammer
*)

text \<open>This Isabelle definition is pretty much 1-1 with the VDM definition. Nevertheless, as mentioned above, VDM basic types widening rules 
necessitated we translate them to \<^typ>\<open>VDMNat\<close>, which is just \<^typ>\<open>\<int>\<close>. Moreover, \<^typ>\<open>\<int>\<close> is defined in terms of a pair of \<^typ>\<open>\<nat>\<close>, 
hence recursion over \<^typ>\<open>\<int>\<close> will be involved. Thus, VDM recursive functions translation to Isabelle will be involved as well. 
For example, the same version of \<^term>\<open>factorial\<close> defined for \<^typ>\<open>\<int>\<close> will fail with the error that \textit{Could not find 
lexicographic termination order}. That is, Isabelle manages to discharge the pattern proofs \<^typ>\<open>\<int>\<close>, but not the termination one. 

Even if we could avoid this VDM basic types translation technicality, the same problem would occur for VDM recursion over
non constructive types, such as sets or maps. That is, Isabelle only allow recursion over finite sets, which are not defined 
constructively but inductively (\textit{e.g.}~@{term finite}[display]. Similarly, Isabelle maps are defined with specialised HOL functions, 
again with domains that are not constructively defined. The only easy recursive definition translation from VDM to Isabelle are those
involving lists, given lists in Isabelle are defined constructively and VDM sequences maps directly to them.      

Therefore, defining recursive functions over non-constructive types entail more involved compatibility and completeness proofs.
They also usually lead to partial function definitions, given Isabelle cannot tell whether termination is immediately obvious. 
In VDM, however, recursive functions on sets (as well as map domains) are common, hence the need for the extending the translation strategy.\<close>

(**************************************************************************************************)
section \<open>VDM recursion translation strategy\<close>

text \<open>We want to identify a translation strategy that will cater for such issues described above not only 
for basic types, but also for sets, sequences, maps, \textit{etc}. This is important to ensure that the
translator will cater for most commonly used VDM recursion definition patterns.   

As mentioned in~\cite{VDMJAnnotations,AdvancedVSCodePaper}, it is possible to define formal annotations 
(as comments), which VDMJ will process and make available for its plugins. For our general translation
strategy, we create a new annotation called \verb'@IsaMeasure'. It defines a user-provided well-founded 
measure relation that will participate in the Isabelle proofs of termination. For example, for the 
factorial function above, the user would have to write
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
  factorial: nat -> nat 
  factorial(n) == if n = 0 then 1 else n * factorial(n-1)
  --@IsaMeasure( { (n -1, n) | n : nat & n <> 0 } )
  measure n;
\end{vdmsl}
%
\noindent This measure relation corresponds to the relationship between the recursive call (\texttt{factorial(n-1)})
and its defining equation (\texttt{factorial(n)}), where the filtering condition determines for which values of \texttt{n}
should the relation refer to (\textit{e.g.}~non-zero values). More interesting measure relation examples are defined in Section~\ref{subsec:Complex}.  

During translation, the plugin will typecheck the \verb'@IsaMeasure' annotation (\textit{i.e.,}~it is a type correct relation over the function signature).
Next, it will translate the annotation and some automation lemmas as series of Isabelle definitions to be used during the proof
of termination of translated VDM recursive functions. If no annotation is provided, following similar principles from Isabelle, 
the plugin will try to automatically infer what the measure relation should based on the structure of the recursive function definition.
When this fails, the user is informed. Still, even if measure relation synthesis succeeds, the user still have to appropriately use it 
during Isabelle's termination proof. 

In what follows, we will detail the translation strategy for each relevant VDM type. For details over the overall translation 
strategy, see examples in the distribution\footnote{\url{https://github.com/leouk/VDM_Toolkit}} and~\cite{NimFull}. That is we impose 
various implicit VDM checks as explicit predicates. For example, VDM sets are always finite, and type invariants over set elements must
hold for every element.
%TODO: or the paper on the translation! 
\<close>

(*-------------------------------------------------------------------------------------------------*)
subsection \<open>Recursion over VDM basic types (\texttt{nat}, \texttt{int})\label{subsec:VDMNat}\<close>

text \<open>Following the general translation strategy~\cite{NimFull}, we first encode the implicit precondition of 
factorial that insists that the given parameter \<^term>\<open>n\<close> is a \<^typ>\<open>VDMNat\<close>, alongside a list of defining constants 
that are useful for proof strategy synthesis.\<close>

definition 
  pre_vdm_factorial :: \<open>VDMNat \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_vdm_factorial n \<equiv> inv_VDMNat n\<close>

lemmas pre_vdm_factorial_defs = pre_vdm_factorial_def inv_VDMNat_def 

text \<open>Next, we define the factorial function through recursion. When the precondition fails, 
  we return \<^term>\<open>undefined\<close>, which is a term that cannot be reasoned with in Isabelle (\textit{i.e.}~it is a dead end).
   Otherwise, we define factorial pretty much as in the VDM definition.

The \<^term>\<open>domintros\<close> tag tells Isabelle to generate domain predicates, in case this function is not total. 
Domain predicates are important to our strategy because of course every VDM function will be undefined, when
applied outside its precondition. It also generates domain-predicate sensitive proof rules listed below.\<close>
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
  text \<open>The proof obligations for pattern compatibility and completeness are next @{goals}[display]\<close>
  
  text \<open>
  They are discharged with the usual Isabelle proof strategy for simple recursive patterns with the @{method pat_completeness} method.
  In the general (see more complex recursive call cases below in Section~\ref{subsec:Complex}), 
  the user might have goals to discharge.\<close>
  by (pat_completeness, auto)

text \<open>Various theorems are made available, such as:
  \<^item> Case analysis @{thm vdm_factorial.cases}[display]
  \<^item> Elimination rules (partial) @{thm vdm_factorial.pelims}[display]
  \<^item> Induction rules (partial) @{thm vdm_factorial.pinduct}[display]
  \<^item> Simplification rules (partial) @{thm vdm_factorial.psimps}[display]

  Note the last two are partial, module a domain predicate @{term vdm_factorial_dom},
  which represents a well-founded relation that ensures termination. That is, if the user does not want
  (or know how to) to prove termination, such domain predicates will follow every application of the 
  factorial definition, hence imposing users the requirement that such well-founded relation is still missing.
 
  If/when the termination proof is discharged, these p-rules can be simplified into total rules that 
  do not depend on a domain predicate, given a well-founded relation has been provided. Domain predicates
  will complicate user proofs, and also make proof strategy synthesis harder to figure out.

  Termination proof is discharged by establishing a well-founded relation associated with 
  the function recursive call(s) with respect to its declaration. In our case, the \verb'@IsaMeasure'
  annotation is translated as the Isabelle abbreviation. We also implicitly add the filter that the 
  function precondition holds:~this is important to ensure the termination proof never reaches the \<^term>\<open>undefined\<close> case.  
  The other filter comes from the negated test in the definition if-statement. More complex definitions will
  have more involved filters (see Section~\ref{subsec:Complex}. 
  We use abbreviation instead of definition to avoid needing to expand the defined term.\<close>

abbreviation 
  vdm_factorial_wf :: \<open>(VDMNat \<times> VDMNat) set\<close>
  where
  "vdm_factorial_wf \<equiv> { (n - 1, n) | n . pre_vdm_factorial n \<and> n \<noteq> 0 }"

text \<open>Given \<^term>\<open>vdm_factorial\<close> is a simple (non-mutual, single call-site, easy measure relation choice) recursion, 
  thankfully the setup is not as complex to establish well-foundedness. For recursions of this nature, we can 
  piggyback on some Isabelle machinery to help prove well foundedness by using the terms:

    \<^enum> @{term gen_VDMNat_term}[display]
    \<^enum> @{term int_ge_less_than}[display]

  The first term is defined in terms of the second, which is a subset of our well-formed relation \<^term>\<open>vdm_factorial_wf\<close>. 
  Isabelle has proofs about the term's well formedness \<^term>\<open>int_ge_less_than\<close> 

  @{thm wf_int_ge_less_than}[display]

  Thus, making the proof our term being well founded trivial, and easily discovered with proof tools like
  @{command sledgehammer}. As part of the translation strategy, we then define (and automatically discover the proof of)
  the following lemma. This follows the strategy described in~\cite{KrausSCNP}. 
    %\url{https://www21.in.tum.de/~krauss/papers/scnp-wst.pdf}.\<close>
lemma l_vdm_factorial_term_wf: "wf (gen_VDMNat_term vdm_factorial_wf)" 
  by (simp add: wf_int_ge_less_than wf_Int1)

termination 
  text \<open>Finally, we prove termination using the previously proved lemma using the @{method relation} for @{goals}[display]
  This simplifies the goal into well formedness of termination relation and that the precondition implies it,
  both of which are easily proved with simplification in this case.\<close>
  apply (relation \<open>(gen_VDMNat_term vdm_factorial_wf)\<close>)
  text \<open>This transforms the mysterious/abstract domain predicate into two new subgoals @{subgoals}[display]\<close>
  using l_vdm_factorial_term_wf apply presburger
  by (simp add: pre_vdm_factorial_defs int_ge_less_than_def)

text \<open>For this simple example, these goals are proved with @{command sledgehammer}. In general, the user will be
  have to either find the proof, or deal with domain predicates in proofs involving the recursive call.

  After the termination proof is discharged, Isabelle provides total versions of useful rules as:
  \<^item> Elimination rules (total) @{thm vdm_factorial.elims}[display]   
  \<^item> Induction rules (total)  @{thm vdm_factorial.induct}[display]
  \<^item> Simplification rules (total) @{thm vdm_factorial.simps}[display]
\<close>

text \<open>To make sure our choice is valid (\textit{e.g.}~doesn't lead to the empty relation), we ensure
  that indeed the termination relation is in fact the same as the well founded predicate by proving the next goal.
  This is something users might want to do, but is not part of the translation strategy. In case the measure relation 
  is empty, the recursive call simplification rules will not be useful anyhow.\<close>
lemma l_vdm_factorial_term_valid: "(gen_VDMNat_term vdm_factorial_wf) = vdm_factorial_wf"
  apply (simp add: pre_vdm_factorial_defs)
  apply (intro equalityI subsetI)
   apply (simp_all add: int_ge_less_than_def case_prod_beta)
  by auto

(*-------------------------------------------------------------------------------------------------*)
subsection \<open>Recursion over VDM sets\label{subsec:VDMSet}\<close>

text \<open>Next, we extend the translation strategy for basic types for VDM sets. For this, we will use a 
 recursively defined VDM function over sets that sums the set elements as
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
    sumset: set of nat -> nat 
    sumset(s) == if s = {} then 0 else let e in set s in sumset(s - {e}) + e
    --@IsaMeasure( { (x - { let e in set x in e }, x) | x : set of nat & x <> {} } ) 
    --@Witness(sumset({ 1 }))
    measure card s;
\end{vdmsl}
%
\noindent Like most common VDM recursion over sets, the function consumes the set by picking each 
set element and them calling the recursive call without the element picked, until the set is empty. 
The VDM measure states that the recursion is based on the cardinality of the input parameter;~this is 
not useful for Isabelle's recursive definition proofs and is ignored during translation.

    In Isabelle, the implicit VDM checks are defined as the precondition, which ensures 
    that the given set contains only natural numbers, and is finite, as defined by \<^term>\<open>inv_VDMSet'\<close>[display]\<close>

definition 
  pre_sumset :: "VDMNat VDMSet \<Rightarrow> \<bool>" 
  where
  "pre_sumset s \<equiv> inv_VDMSet' inv_VDMNat s"

lemmas pre_sumset_defs = pre_sumset_def inv_VDMSet'_defs inv_VDMNat_def

text \<open>We define the VDM recursive function in Isabelle next. It checks whether the given
      set satisfy the function precondition, returning \<^term>\<open>undefined\<close> if not.
      If it does, then each case is encoded pretty much 1-1 from VDM. The translation strategy for
      VDM \verb'let-in-set' patterns uses Isabelle's Hilbert's choice operator (\<^term>\<open>\<some> x . x \<in> s\<close>).
    Note this naturally extends to VDM's \verb'let-be-st' patterns as well.\<close>
function (domintros)
  sumset :: "VDMNat VDMSet \<Rightarrow> VDMNat" 
  where 
  "sumset s = 
    (if pre_sumset s then 
        (if s = {} then 
            0 
         else 
            let e = (\<some> x . x \<in> s) in 
              sumset (s - {e}) + e) 
     else 
        undefined
    )"
  text \<open>The pattern completeness and compatibility goals are given as 
        @{goals}[display]

        We follow the usual proof strategy for this using @{method pat_completeness}.
        For more general examples, if that fails, @{command sledgehammer} should be used.
       \<close>
  by (pat_completeness, auto)

text \<open>The measure relation for termination is defined with the \verb'@IsaMeasure' annotation above as 
   the smaller set after picking \<^term>\<open>e\<close> (\textit{e.g.}~\<^term>\<open>s - {(\<some> e . e \<in> s)}\<close>), 
    and the set used at the entry call, leading to the pairs \<^term>\<open>(s - {(\<some> e . e \<in> s)}, s)\<close>. 
    Finally, we ensure all the relation elements satisfy the function precondition (\<^term>\<open>pre_sumset\<close>),
   and that the if-test is negated.
\<close>
abbreviation 
  sumset_wf_rel :: "(VDMNat VDMSet \<times> VDMNat VDMSet) set"
  where
  "sumset_wf_rel \<equiv> { (s - {(\<some> e . e \<in> s)}, s)| s . pre_sumset s \<and> s \<noteq> {}}"

text \<open>Given this is a simple (non-mutual, single call-site, easy set element choice) recursion, again
   we can piggyback on Isabelle machinery by using the terms:

    \<^enum> @{term gen_set_term}[display]
    \<^enum> @{term finite_psubset}[display]

    They establishes that a relation where the first element is strictly smaller set than the 
    second element in the relation pair is well-formed. This makes the proof of well-foundedness easy 
    for \<^term>\<open>sumset_wf_rel\<close> through @{command sledgehammer}. \<close>
lemma l_sumset_rel_wf: "wf (gen_set_term sumset_wf_rel)"
  using l_gen_set_term_wf by blast

termination
  text \<open>Next, we tackle the termination proof, with the same setup with @{method relation} again.\<close>
  apply (rule "termination"[of "(gen_set_term sumset_wf_rel)"])
  using l_sumset_rel_wf apply force
  text \<open>Unfortunately, using @{command sledgehammer} fails to discharge the second subgoal @{subgoals}[display]\<close>
  oops

  text \<open>Fortunately, for most simple situations, this is easy to decompose in general. The translation strategy takes the 
    \verb'@IsaMeasure' expression and decompose its parts, such that the filtering predicates are assumptions, and
    the element in the relation belong to the well-formed measure chosen. For the concrete set example, this is defined 
  in the next lemma, which require some manual intervention to tell Isabelle what definitions to unfold and simplify with. 
  Then, Isabelle's @{command sledgehammer} can finish the proof.\<close>

lemma l_pre_sumset_sumset_wf_rel: 
  "pre_sumset s \<Longrightarrow> s \<noteq> {} \<Longrightarrow> (s - {(\<some> x. x \<in> s)}, s) \<in> (gen_set_term sumset_wf_rel)"
  unfolding gen_set_term_def
  apply (simp add: pre_sumset_defs)
  by (metis Diff_subset member_remove psubsetI remove_def some_in_eq)

text \<open>The intuition behind this lemma is that, elements in the measure relation satisfy well-formedness under the function 
  precondition and the filtering case (\<^term>\<open>s \<noteq> {}\<close>) where the recursive call is made. That is, the precondition and 
  filtering condition help establish the terminating relation. For this particular proof, the only aspect needed from the 
  precondition (\<^term>\<open>pre_sumset\<close>) is that the set is finite. 

  With this, we can try the termination proof again, which now @{command sledgehammer} find proofs for all subgoals.\<close>
termination
  apply (rule "termination"[of "(gen_set_term sumset_wf_rel)"])
  using l_sumset_rel_wf apply force
  using l_pre_sumset_sumset_wf_rel by presburger

(*<*)
lemma l_pre_vdm_factorial_wf_rel': "pre_vdm_factorial n \<Longrightarrow> n \<noteq> 0 \<Longrightarrow> (n - 1, n) \<in> gen_VDMNat_term vdm_factorial_wf"
  unfolding gen_VDMNat_term_def gen_VDMInt_term_def
  using l_vdm_factorial_term_valid by force
(*>*)

text \<open>Note we omit such lemma over termination and precondition for the \<^typ>\<open>VDMNat\<close> case in Section~\ref{subsec:VDMNat}. 
  The translation strategy does define it following the same recipe:~recursive function precondition and filtering predicate 
  as assumptions, and chosen termination relation element containment, where @{command sledgehammer} find the proof once more.\<close>
lemma l_pre_vdm_factorial_wf_rel: "pre_vdm_factorial n \<Longrightarrow> n \<noteq> 0 \<Longrightarrow> (n - 1, n) \<in> gen_VDMNat_term vdm_factorial_wf"
  unfolding gen_VDMNat_term_def gen_VDMInt_term_def
  using inv_VDMNat_def l_less_than_VDMNat_subset_int_ge_less_than pre_vdm_factorial_def by auto

text \<open>We also choose to show the relation finite subset trick to
make well-founded induction proofs easier does not compromise the well founded relation itself.\<close>
lemma l_sumset_wf_rel_valid: "gen_set_term sumset_wf_rel = sumset_wf_rel"
  apply (intro equalityI subsetI)
   apply (simp)
  using l_pre_sumset_sumset_wf_rel by blast

text \<open>Finally, even though this was not necessary for this proof, we encourage users to always provide a witness for the top recursive call.
  This is done by using the \verb'@Witness' annotation~\cite{EdwardWitness,AdvancedVSCodePaper}:~it provides a concrete example for the function 
  input parameters. This witness is useful for existentially quantified predicates present in more involved termination proofs (see Section~\ref{subsec:Complex}).\<close>

(*-------------------------------------------------------------------------------------------------*)
subsection \<open>Recursion over VDM maps\label{subsec:VDMMap}\<close>

text \<open>Recursive functions over VDM maps are a special case of VDM sets, given map recursion usually 
iterates over the map's domain. For example, the function that sums the elements of the map range 
can be defined as  
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
  sum_elems: map nat to nat -> nat
  sum_elems(m) == 
    if m = {|->} then 0 else
      let d in set dom m in m(d) + sum_elems({d}<-:m)
  --@IsaMeasure( { ({d} <-: m, m) | m : map nat to nat, d: nat & m <> {} and d in set dom m } )
  --@Witness( sum_elems({ 1 |-> 1 }) )
  measure card dom m;
\end{vdmsl}
%
\noindent As with sets, it iterates over the map by picking a domain element, performing the necessary 
computation, and then recurse on the map filtered by removing the chosen element, until the map is 
empty and the function terminates. As before, the measure relation follows the same pattern:~recursive call 
site related with defining site, where both the if-test and the \verb'let-in' choice is part of the filtering predicate.

Following the general translation strategy for maps~\cite{NimFull}, we define the function precondition using \<^term>\<open>inv_Map\<close>[display]
It insists that both the map domain and range are finite, and that all domain and range elements satisfy their corresponding type invariant. 
Note that if the recursion was defined over sets other than the domain and range, Isabelle might require you to prove such set is finite. 
Given both domain and range sets are themselves finite, this should be easy enough to do, if needed. 
\<close>
definition 
  pre_sum_elems :: \<open>(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_sum_elems m \<equiv> inv_Map inv_VDMNat inv_VDMNat m\<close>

lemmas pre_sum_elems_defs = pre_sum_elems_def inv_Map_defs inv_VDMNat_def 

text \<open>VDM maps in Isabelle (\<^typ>\<open>(VDMNat \<rightharpoonup> VDMNat)\<close>) are defined as a HOL function which maps to an optional result. 
That is, if the element is in the domain, the map results in a non \texttt{\textbf{nil}} value, whereas if the element
does not belong to the domain, the map results in a \texttt{\textbf{nil}} value. This effectively makes all maps total,
where values outside the domain map to \texttt{\textbf{nil}}. The Isabelle translation and compatibility proof follows 
patterns used before and are given as\<close>
function (domintros) 
  sum_elems :: \<open>(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> VDMNat\<close>
  where
  \<open>sum_elems m = 
      (if pre_sum_elems m then
          (if m = Map.empty then
            0
          else
            let d = (\<some> e . e \<in> dom m) in the(m d) + (sum_elems ({d} -\<triangleleft> m))
          )
       else
          undefined
      )
  \<close>
  by (pat_completeness, auto)

text \<open>Similarly, the well-formed relation from \verb'@IsaMeasure' is translated next, where the precondition is also included 
as part of the relation's filter. The \<^term>\<open>{d}-\<triangleleft>m\<close> corresponds to VDM domain anti-filtering operator \verb'<-:'.\<close>
abbreviation
  sum_elems_wf :: \<open>((VDMNat \<rightharpoonup> VDMNat) \<times> (VDMNat \<rightharpoonup> VDMNat)) VDMSet\<close>
  where
  \<open>sum_elems_wf \<equiv> { (({d} -\<triangleleft> m), m) | m d . pre_sum_elems m \<and> m \<noteq> Map.empty \<and> d \<in> dom m }\<close>

text \<open>For the well-formed lemma over the recursive measure relation, there are no available Isabelle help, 
and projecting the domain element of the maps within the relation is awkward. Thus, we have to prove the 
lemma directly. This will not be automatic in general. This is one difference in terms of translation of VDM 
recursive functions over sets and maps.

Fortunately, the proof strategy for such situations is somewhat known:~it follows a similar strategy to
the proof of well formedness of the \<^term>\<open>finite_psubset\<close> as @{thm wf_finite_psubset}[display]. The proof uses
the VDM measure expression to extract the right projection of interest, then follows the proof for \<^term>\<open>finite_psubset\<close>. 
Finally, @{command sledgehammer} can figure out the final steps.   
\<close>
lemma l_sum_elems_wf: "wf sum_elems_wf"
  apply (rule wf_measure[of \<open>\<lambda> m . card (dom m)\<close>, THEN wf_subset])
  apply (simp add: measure_def inv_image_def less_than_def less_eq)
  apply (rule subsetI, simp add: case_prod_beta)
  apply (elim exE conjE)
  by (simp add: l_VDMMap_filtering_card pre_sum_elems_defs)

text \<open>The precondition subgoal and the termination proof follow the same patterns as before. Again,
their proof was discovered with @{command sledgehammer}, yet this will not be the case in general.\<close>
lemma l_pre_sum_elems_sum_elems_wf: 
  "pre_sum_elems m \<Longrightarrow> m \<noteq> Map.empty \<Longrightarrow> ({(\<some> e. e \<in> dom m)} -\<triangleleft> m, m) \<in> sum_elems_wf"
  apply (simp add: pre_sum_elems_defs)
  by (metis domIff empty_iff some_in_eq)

termination   
  apply (rule "termination"[OF l_sum_elems_wf])
  using l_pre_sum_elems_sum_elems_wf by presburger

text \<open>Finally, we also prove that the well founded termination relation (\<^term>\<open>sum_elems_wf\<close>) is not 
empty, as we did for sets and \texttt{nat} recursion. Note that here the \verb'@Witness' annotation is 
useful in discharging the actual value to use as the witness demonstrating the relation is not empty.\<close>
lemma l_sum_elems_wf_valid: "sum_elems_wf \<noteq> {}" 
  apply safe
  apply (erule equalityE)
  apply (simp add: subset_eq)
  apply (erule_tac x=\<open>[1 \<mapsto> 1]\<close> in allE)
  by (simp add: pre_sum_elems_defs) 

(*-------------------------------------------------------------------------------------------------*)
subsection \<open>VDM recursion involving complex measures\label{subsec:Complex}\<close>

text \<open>
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
    ack: nat * nat -> nat 
    ack(m,n) ==
             if m = 0 then n+1
        else if n = 0 then ack(m-1, 1)
        else               ack(m-1, ack(m, (n-1)))
    --@IsaMeasure( pair_less_VDMNat )
    --@Witness( ack(2, 1) )
    measure is not yet specified;
\end{vdmsl}\<close>

text \<open>The plugin has examples of a couple other more complicated recursion. These are Nipkow's 
permutation function~\cite{TermRewriting} and Takeuchi's 
function\footnote{\url{https://isabelle.in.tum.de/library/HOL/HOL-Examples/Functions.html}}.
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
    perm: int * int * int -> int --nat
    perm(m,n,r) == 
             if 0 < r then perm(m, r-1, n) 
        else if 0 < n then perm(r, n-1, m) else m
    pre ((0 < r or 0 < n) => m+n+r > 0)
    measure maxs({m+n+r, 0});      

    tak: int * int * int -> int
    tak(x,y,z) == 
        if x <= y then y  
        else           tak(tak(x-1,y,z), tak(y-1,z,x), tak(z-1,x,y))
    measure is not yet specified;
\end{vdmsl}
%
\noindent The Takeuchi's function is particularly challenging in proofs and the translation strategy 
stands no chance of finding proofs for such definitions automatically.\<close>

(**************************************************************************************************)
section \<open>Limitations\<close>

(**************************************************************************************************)
section \<open>Discussion and conclusion\<close>

paragraph \<open>Future work.~\<close>


lemma l_sumset_rel_wf': "wf sumset_wf_rel"
  apply (rule wf_measure[of \<open>\<lambda> s . card s\<close>, THEN wf_subset])
  apply (simp add: measure_def inv_image_def less_than_def less_eq)
  apply (rule subsetI, simp add: case_prod_beta)
  apply (elim exE conjE)
  by (metis card_Diff1_less_iff fst_conv inv_Map_defs(2) inv_Map_defs(3) pre_sumset_defs(1) snd_conv some_in_eq)

paragraph \<open>Acknowledgements.~\<close>

(*<*)
end
(*>*)
