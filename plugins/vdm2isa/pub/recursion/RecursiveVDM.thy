(*<*)
(*:maxLineLen=78:*)
theory RecursiveVDM
imports VDMToolkit
begin
(*>*)

(*****************************************************************************)
section \<open>Introduction\label{sec:Intro}\<close>
text \<open>This paper describes a translation strategy for a variety of recursive
definitions from VDM to Isabelle/HOL. The strategy takes into account the
differences in how termination and well-foundedness are represented in both
formalisms.

Beyond overcoming technical practicalities, which we discuss, a major
objective is to create translation strategy templates. These templates must
cover a wide variety of VDM recursive definitions, as well as having their
proof obligations being highly automated. The result is an extension to the
VDM to Isabelle/HOL translation strategy and implementation as a plugin to
VDMJ~@{cite Battle09} and extension to VDM-VSCode @{cite AdvancedVSCodePaper}.

Isabelle uses literate programming, where formal specification, proofs and
documentation are all within the same environment. We omit proof scripts
below; the full VDM and Isabelle sources and proofs can be found at the VDM
toolkit repository at
\<^verbatim>\<open>./plugins/vdm2isa/src/main/resources/RecursiveVDM.*\<close>\<^footnote>\<open>in~\<^url>\<open>https://github.com/leouk/VDM_Toolkit\<close>\<close>.

In the next section, we present background on VDM and Isabelle recursion and
measure relations. Section~\ref{sec:VDMTypes} briefly discuss VDM basic
types translation and their consequence for recursion. Next,
Section~\ref{sec:Recursion} describes how both VDM and Isabelle recursive
definitions work and how they differ. Our translation strategy is then
presented in Section~\ref{sec:Strategy} for basic types, sets, maps, and
complex recursive patterns. Finally, we conclude in
Section~\ref{sec:Conclusion}. \<close>

(******************************************************************************)
section \<open>Background\label{sec:Background}\<close> 

text \<open>Our VDM to Isabelle/HOL translator caters for a wide range of the VDM-SL
AST. It copes with all kinds of expressions, a variety of patterns, almost all
types, imports and exports, functions and specifications, traces, and some of
state and operations @{cite NimFull and AdvancedVSCodePaper}. Although not
all VDM patterns are allowed, the translator copes with most, and
where it does not, there is a corresponding equivalent.

One particular area we want to extend translation is over recursively defined
functions. VDM requires the user to define a measure function to justify why
recursion terminates. It then generates proof obligations to ensure
totality and termination.

Finally, our translation strategy follows the size-change termination (SCT)
proof strategy described in @{cite SCT_POPL and SCNP_POPL}. In particular, its
SCP (polynomial) and SCNP (non-polynomial) subclasses of recursive definitions
within the SCT, which permits efficient termination checking. Effectively, if
every infinite computation would give rise to an infinitely decreasing value
sequence (according to the size-change principle), then no infinite
computation is possible. Termination problems in this class have a global
ranking function of a certain form, which can be found using SAT solving,
hence increasing automation.\<close>
(*\<^bold>\<open>ANYTHING ELSE? Related work?\<close>*)

(*****************************************************************************)
section \<open>VDM basic types in Isabelle\label{sec:VDMTypes}\<close>

text \<open>Isabelle represents natural numbers (\<^typ>\<open>\<nat>\<close>) as a (data) type with
two constructors (\<^term>\<open>0::\<nat>\<close> and \<^term>\<open>Suc n\<close>), where all numbers are
projections over such constructions (\<^emph>\<open>e.g.\<close>~@{lemma \<open>2 = (Suc (Suc 0))\<close> by
simp}). Isabelle integers (\<^typ>\<open>\<int>\<close>) are defined as a quotient type
involving two natural numbers. Isabelle quotient types are injections into a
constructively defined type. As with integers, other Isabelle numeric types
(\<^emph>\<open>e.g.,\<close>~rationals \<^typ>\<open>\<rat>\<close>, reals \<^typ>\<open>\<real>\<close>, \<^emph>\<open>etc\<close>.) are defined in
terms of some involved natural number construction. Type conversions (or
coercions) are then defined to allow users to jump between type spaces.
Nevertheless, Isabelle has no implicit type widening rule for \<^typ>\<open>\<nat>\<close>;
instead, it takes conventions like @{lemma[show_types] \<open>(0 - x::\<nat>) = 0\<close> by
simp}. For expressions involving a mixutre of \<^typ>\<open>\<int>\<close> and \<^typ>\<open>\<nat>\<close> typed
terms, explicit user-defined type coercions might be needed
(\<^emph>\<open>e.g.,\<close>~@{lemma[show_types] \<open>(2::\<nat>) - (3::\<int>) = -1\<close> by simp}).
 
VDM expressions with basic-typed (\<^bold>\<open>nat\<close>, \<^bold>\<open>int\<close>) variables have specific
type widening rules. For example, even if both variables are \<^bold>\<open>nat\<close>, the
result might be \<^bold>\<open>int\<close>. (\<^emph>\<open>e.g.,\<close>~in VDM, \<^verbatim>\<open>0 - x:nat = -x:int\<close>). Therefore,
our translation strategy considers VDM \<^bold>\<open>nat\<close> as the Isabelle type
\<^typ>\<open>VDMNat\<close>, which is just a type synonym for \<^typ>\<open>\<int>\<close>. This simplifies
the translation process to Isabelle, such that no type coercions are
necessary to encode all VDM type widenning rules. On the other hand, this
design decision means encoding of recursive functions over \<^bold>\<open>nat\<close> to be more
complicated than expected, given VDM's \<^bold>\<open>nat\<close> is represented as Isabelle's
\<^typ>\<open>\<int>\<close>.

  Despite this design decision over basic types and their consequences,
  recursion over VDM \<^bold>\<open>int\<close>, sets or maps will still be involved. That is
  because these types are not constructively defined in Isabelle.\<close>

(*****************************************************************************)
section \<open>Recursion in VDM and in Isabelle\label{sec:Recursion}\<close>

text \<open>An important aspect of every recursive definition is an argument that
justifies its termination. Otherwise, the recursion might go into an infinite
loop. In VDM, this is defined using a recursive measure:~it has the same input
type signature as the recursive definition, and returns a \<^bold>\<open>nat\<close>, which
\<^bold>\<open>must\<close> monotonically decrease at each recursive call, eventually reaching
zero. This is how termination of recursive definitions are justified in VDM. A
simple example of a VDM recursive definition is one for calculating the
factorial of a given natural number
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
   fact: nat -> nat 
   fact(n) == if n = 0 then 1 else n * fact(n - 1)   measure n;   
\end{vdmsl} 
%
%   -- For the measure below, VDMJ produces a measure function as: 
%   -- measure_fact: nat -> nat
%   -- measure_fact(n) == n
\noindent The \<^verbatim>\<open>fact\<close> recursive measure uses the \<^verbatim>\<open>n\<close> input itself as its
result. This works because the only recursive call is made with a decreasing
value of \<^verbatim>\<open>n\<close>, until it reaches the base case \<^verbatim>\<open>0\<close> and terminates. VDMJ generates three
proof obligations for the definition above. They are trivial to discharge in
Isabelle given the measure definition expanded is just 
@{lemma \<open>(\<forall> n::\<nat> . \<not> n = 0 \<longrightarrow> n - 1 \<ge> 0)\<close> by simp} and 
@{lemma \<open>(\<forall> n::\<nat> . \<not> n = 0 \<longrightarrow> n > n - 1)\<close> by simp}.
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
  Proof Obligation 1: (Unproved) fact; measure_fact: total function obligation 
  (forall n:nat & is_(measure_fact(n), nat))
  
  Proof Obligation 2: (Unproved) fact: subtype obligation 
  (forall n:nat & (not (n = 0) => (n - 1) >= 0))
  
  Proof Obligation 3: (Unproved) fact: recursive function obligation 
  (forall n:nat & (not (n=0) => measure_fact(n) > measure_fact((n-1))))
\end{vdmsl} 
%
%Remove?
Moreover, even though measures over recursive type structures are impossible
to define in VDM, they are easily described in Isabelle. For example, it is
not possible to write a measure in VDM over a recursive record defining a
linked list, such as \<^verbatim>\<open>R :: v: nat n: R\<close>. This is automatically generated for
our representation of VDM records in Isabelle as a datatype. Other complex
recursive patterns are hard/impossible to represent in VDM (see
Section~\ref{subsec:Complex}).
  
In Isabelle, recursive definitions can be provided through primitive recursion
over inputs that are constructively defined, or more general function
definitions that produce proof obligations. The former insists on definition
for each type constructor and only provides simplification rules; whereas the
latter allows for more sophisticated input patterns and provides
simplification, elimination and induction rules, as well as partial function
considerations. For the purposes of this paper, we only consider function
definitions. Readers can find more about these differences in~@{cite
IsaFunctionPackage}.

Isabelle's recursive functions require a proof obligation that its parameters
represent a constructive and compatible pattern, and that recursive calls
terminate. Constructive patterns covers all constructors in the data type
being used in the recursion inputs (\<^emph>\<open>i.e.,\<close>~one equation for each of the
constructors of \<^typ>\<open>\<nat>\<close>, hence one involving \<^term>\<open>0::\<nat>\<close> and another
involving \<^term>\<open>Suc n\<close>). Compatible patterns cover the multiple ways
patterns can be constructed will boil down to the pattern completeness cases
(\<^emph>\<open>e.g.,\<close>~\<^term>\<open>n + 2::\<nat>\<close> being simply multiple calls over defined
constructors like \<^term>\<open>Suc (Suc n)\<close>). This is important to ensure that
recursion is well structured (\<^emph>\<open>i.e.,\<close>~recursive calls will not get stuck
because some constructs are not available). For example, if you miss the
\<^term>\<open>0::\<nat>\<close> case, eventually the \<^term>\<open>Suc n\<close> case will reach zero and
fail, as no patterns for zero exist. The proof obligation for termination
establishes that the recursion is well-founded. This has to be proved whenever
properties of the defined function are meant to be total.

Isabelle's function definitions can be given with either \<^term>\<open>fun\<close> or
\<^term>\<open>function\<close> syntax. The former attempts to automatically prove the
pattern constructive and compatible proofs and finds a measure for the
termination proof obligation. The latter requires the user to do these proofs
manually by providing a measure relation. It is better suited for cases where
\<^term>\<open>fun\<close> declarations fail, which usually involve complex or ill-defined
recursion.

The termination relation must be well-founded, which means have a well-ordered
induction principle over a partially ordered relation defined as\<^footnote>\<open>Details on 
well-ordered induction are in Isabelle's \<^verbatim>\<open>Wellfounded.thy\<close> theory.\<close> 
@{thm[display,show_types] wf_def} A definition that
Isabelle discovers all three proofs is\<close>
(* find_theorems name:wellorder print_locale! wellorder *)
fun fact' :: \<open>\<nat> \<Rightarrow> \<nat>\<close> where \<open>fact' n = (if n = 0 then 1 else n * (fact' (n - 1)))\<close> 

text \<open>This definition is quite similar in VDM. Nevertheless, VDM basic types
widening rules necessitate we translate them to \<^typ>\<open>VDMNat\<close>. The same
version of \<^term>\<open>fact\<close> defined for \<^typ>\<open>\<int>\<close> will fail with the error that
``\<^emph>\<open>Could not find lexicographic termination order\<close>''. That is, Isabelle
manages to discharge the pattern proofs, but not the termination one. This is
because the user must provide a projection relation from the \<^typ>\<open>\<int>\<close>
quotient type back into the constructive type \<^typ>\<open>\<nat>\<close>.

Even if we could avoid this translation technicality, the same problem would
occur for recursion over non-constructive types, such as sets or maps. They
require recursion over finite sets, which are defined inductively. The only
easy recursive translations are those involving lists, given lists in Isabelle
are defined constructively and VDM sequences map directly.

Therefore, defining recursive functions over non-constructive types entail
compatibility and completeness proofs. They also lead to partial function
definitions, given Isabelle cannot tell whether termination is immediately
obvious. In VDM, however, recursive functions on sets (as well as map domains)
are common, hence the need for extending our translation strategy.\<close>

(******************************************************************************)
section \<open>VDM recursion translation strategy\label{sec:Strategy}\<close>

text \<open>We want to identify a translation strategy that will cater for 
issues described above not only for basic types, but also for sets, sequences,
maps, as well as mutual recursion.

The VDM-SL AST tags all recursive functions, even those without an explicit
measure. All such functions will be translated using Isabelle's \<^term>\<open>fun\<close>
syntax, which will attempt to discover proofs for compatibility and
termination. For our setup of the \<^verbatim>\<open>fact\<close> example, where Isabelle discovers the
termination proof.\<close>

(*<*)
definition pre_fact'' :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where [simp]:\<open>pre_fact'' n \<equiv> inv_VDMNat n\<close>
fun fact'' :: \<open>VDMNat \<Rightarrow> VDMNat\<close> where 
\<open>fact'' n = (if pre_fact'' n then (if n = 0 then 1 else n * (fact'' (n - 1))) else undefined)\<close>
(*>*)

text \<open> If that had failed, the user could define a VDM \<^verbatim>\<open>@IsaMeasure\<close>
annotation. VDM annotations are comments that will be processed according to
specific implementations @{cite VDMJAnnotations and AdvancedVSCodePaper}. If
the user does not provide an \<^verbatim>\<open>@IsaMeasure\<close> annotation and \<^term>\<open>fun\<close>
fails, then it is up to the user to figure out the necessary proof setup.

The \<^verbatim>\<open>@IsaMeasure\<close> annotation defines a well-founded measure relation that
will participate in the setup for Isabelle termination proof. For example, for
the \<^verbatim>\<open>fact\<close> example, the user would have to write an annotation before the VDM
measure.
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
  --@IsaMeasure( { (n -1, n) | n : nat & n <> 0 } )
\end{vdmsl}
\noindent This measure relation corresponds to the relationship between the
recursive call (\<^verbatim>\<open>fact(n-1)\<close>) and its defining equation (\<^verbatim>\<open>fact(n)\<close>), where
the filtering condition determines which values of \<^verbatim>\<open>n\<close> the relation should 
refer to. More interesting measure relations are defined in
Section~\ref{subsec:Complex}.

During translation, the \<^verbatim>\<open>vdm2isa\<close> plugin will typecheck the \<^verbatim>\<open>@IsaMeasure\<close> annotation
(\<^emph>\<open>i.e.,\<close>~it is a type correct relation over the function signature). Next, it
will translate the annotation and some automation lemmas as a series of
Isabelle definitions to be used during the proof of termination of translated
VDM recursive functions. If no annotation is provided, following similar
principles from Isabelle, then the plugin will try to automatically infer what
the measure relation should be based on the structure of the recursive
function definition. If this fails, then the user is informed. Still, even
if measure-relation synthesis succeeds, the user still has to appropriately
use it during Isabelle's termination proof.

In what follows, we will detail the translation strategy for each relevant VDM
type. For details of the overall translation strategy, see examples in the
distribution\<^footnote>\<open>\<^url>\<open>https://github.com/leouk/VDM_Toolkit\<close>\<close> and~@{cite NimFull}.
The translation strategy imposes various implicit VDM checks as explicit predicates. 
For example, VDM sets are always finite, and type invariants over set, sequence
and map elements must hold for every element.\<close>

(*----------------------------------------------------------------------------*)
subsection \<open>Recursion over VDM basic types (\<^bold>\<open>nat\<close>, \<^bold>\<open>int\<close>)\label{subsec:VDMNat}\<close>

text \<open>Following the general translation strategy~@{cite NimFull}, we first
encode the implicit precondition, which insists that
the given parameter \<^term>\<open>n\<close> is a \<^typ>\<open>VDMNat\<close>, alongside a list of
defining constants that are useful for proof strategy synthesis.\<close>
(* COMMENT: make pre_XXX a simplification rule for fun declarations! *)

definition pre_fact :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where \<open>pre_fact n \<equiv> inv_VDMNat n\<close>
lemmas pre_fact_defs = pre_fact_def  

text \<open>Next, we define factorial recursively. When the precondition fails, we
return \<^term>\<open>undefined\<close>, which is a term that cannot be reasoned with in
Isabelle The \<^term>\<open>domintros\<close> tag tells Isabelle to generate domain
predicates, in case this function is not total. Domain predicates are
important to our strategy because every VDM function will be undefined, when
applied outside its precondition. It also generates domain-predicate sensitive
proof rules listed below.\<close>
function (domintros) fact :: \<open>VDMNat \<Rightarrow> VDMNat\<close> where
\<open>fact n = (if pre_fact n then (if n = 0 then 1 else n * (fact (n - 1))) else undefined)\<close>

text \<open>The proof obligations for pattern compatibility and completeness are
discharged with the usual Isabelle proof strategy for simple recursive
patterns with the @{method pat_completeness} method. In the general case
discussed in Section~\ref{subsec:Complex}, the user might have goals to
discharge. Isabelle proves various theorems abou case analysis and
(partial) rules for elimination, induction and simplification.\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag invisible\<close>
  
text \<open>Partial rules require the domain predicate @{term fact_dom} as an assumption.
It represents a well-founded relation that ensures termination. That is, if
the user does not want (or knows how) to prove termination, such domain
predicates will follow every application of definitions,
hence documenting the requirement that such well-founded relation is still
missing.

If/when the termination proof is discharged, these p-rules can be simplified
into total rules that do not depend on a domain predicate, given a
well-founded relation has been provided. Domain predicates will complicate
user proofs, and also make proof strategy synthesis harder to automate.

Termination proof is discharged by establishing a well-founded relation
associated with the function recursive call(s) with respect to its
declaration. The \<^verbatim>\<open>@IsaMeasure\<close> annotation is translated as an
Isabelle abbreviation. The filter that the function
precondition holds:~this is important to ensure the termination proof never
reaches the \<^term>\<open>undefined\<close> case. The other filter comes from the negated
test from the if-statement. More complex definitions will have more
involved filters. We use abbreviation instead of definition to avoid needing
to expand the defined term in proofs.\<close>

abbreviation fact_wf :: \<open>(VDMNat \<times> VDMNat) set\<close> where
  \<open>fact_wf \<equiv> { (n - 1, n) | n . pre_fact n \<and> n \<noteq> 0 }\<close>

text \<open>Given \<^verbatim>\<open>fact\<close> definition is simple (non-mutual, single call-site, easy
measure relation choice) recursion, its setup is easy to
establish well-foundedness. For recursions of this nature, we can piggyback on
Isabelle machinery to prove well foundedness by using terms
@{term gen_VDMNat_term} and @{term int_ge_less_than}.

The first term is defined in terms of the second, which is a subset of our
well-founded relation \<^term>\<open>fact_wf\<close>. Isabelle has proofs about the 
well foundedness of \<^term>\<open>int_ge_less_than\<close>. Thus, making the proof our
term being well-founded trivial for @{command sledgehammer}. 
As part of the translation strategy, we define
(and attempt to discover the proof of) the following lemma. This follows
the strategy described in~@{cite KrausSCNP}.\<close>
lemma l_fact_term_wf: \<open>wf (gen_VDMNat_term fact_wf)\<close>
  by (simp add: wf_int_ge_less_than wf_Int1) \<^marker>\<open>tag invisible\<close>

text \<open>Finally, we prove termination using the previously proved lemma using
the @{method relation}. This simplifies the goal into well-foundedness of
termination relation and that the precondition implies it, both of which are
easily proved with simplification in this case.\<close>
termination \<^marker>\<open>tag invisible\<close>
  apply (relation \<open>(gen_VDMNat_term fact_wf)\<close>) \<^marker>\<open>tag invisible\<close>
text \<open>This transforms the abstract domain predicate into two new subgoals as
@{subgoals[display]}\<close>
  using l_fact_term_wf apply presburger \<^marker>\<open>tag invisible\<close>
  by (simp add: pre_fact_defs int_ge_less_than_def) \<^marker>\<open>tag invisible\<close>

text \<open>For this example, subgoals are proved with @{command
sledgehammer}. In general, the user will be have to either find the proof, or
deal with domain predicates involving the recursive call. After the
termination proof is discharged, Isabelle provides versions of rules for
elimination, induction and simplification that are total and do not depend on
the domain predicates. 

To make sure our choice does not lead to the empty relation, we ensure that
the termination relation is in fact the same as the well founded
predicate by proving the next goal. This is something users might want to do,
but is not part of the translation strategy. In case the measure relation is
empty, the recursive call simplification rules will not be useful anyhow.\<close>

lemma l_fact_term_valid: \<open>(gen_VDMNat_term fact_wf) = fact_wf\<close>
  apply (simp ) \<^marker>\<open>tag invisible\<close>
  apply (intro equalityI subsetI)\<^marker>\<open>tag invisible\<close>
   apply (simp_all add: pre_fact_defs int_ge_less_than_def case_prod_beta)\<^marker>\<open>tag invisible\<close>
  by auto\<^marker>\<open>tag invisible\<close>

(*---------------------------------------------------------------------------*)
subsection \<open>Recursion over VDM sets\label{subsec:VDMSet}\<close>

text \<open>Next, we extend the translation strategy for VDM sets.
For this, we use a function that sums the elements of a set.
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
  sumset: set of nat -> nat 
  sumset(s) == if s = {} then 0 else let e in set s in sumset(s - {e}) + e
  --@IsaMeasure({(x - { let e in set x in e }, x) | x : set of nat & x <> {}}) 
  --@Witness(sumset({ 1 }))
  measure card s;
\end{vdmsl}
%
\noindent Most common VDM recursion over sets, consume the
set by picking an arbitrary set element and then recurse without
the element picked, until the set is empty. The VDM measure states that the
recursion is based on the cardinality of the input parameter. VDM measures are
not suitable for Isabelle proofs, given Isabelle requires a relation;~hence,
VDM measures are mostly ignored. They might still be useful during
proofs as potential witnesses to existentially-quantified goals.

The implicit VDM checks are defined as the precondition, which
ensures that the given set only contains natural numbers and is finite, as
defined by \<^term>\<open>inv_VDMSet'\<close>.\<close>

definition pre_sumset :: \<open>VDMNat VDMSet \<Rightarrow> \<bool>\<close> where
  \<open>pre_sumset s \<equiv> inv_VDMSet' inv_VDMNat s\<close>
lemmas pre_sumset_defs = pre_sumset_def inv_VDMSet'_defs 

text \<open>We define the VDM recursive function in Isabelle next. It checks whether
the given set satisfy the function precondition, returning \<^term>\<open>undefined\<close>
if not. Each case is encoded pretty much 1-1 from VDM after that. The
translation strategy for VDM \<^verbatim>\<open>let-in-set\<close> patterns uses Isabelle's Hilbert's
choice operator (\<^term>\<open>\<some> x . x \<in> s\<close>). Note this naturally extends to VDM's
\<^verbatim>\<open>let-be-st\<close> patterns as well.\<close>
function (domintros) sumset :: \<open>VDMNat VDMSet \<Rightarrow> VDMNat\<close> where 
  \<open>sumset s = (if pre_sumset s then 
                       (if s = {} then 0 else let e = (\<some> x . x \<in> s) in sumset (s - {e}) + e) 
                    else undefined)\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag invisible\<close>

text \<open>The pattern completeness and compatibility goals are trivial.
The measure relation defined with  \<^verbatim>\<open>@IsaMeasure\<close> is next.
It is defined as the smaller set after picking \<^term>\<open>e\<close> and the set used 
at the entry call, leading to the pairs \<^term>\<open>(s - {(\<some> e . e \<in> s)}, s)\<close>. 
Finally, we ensure all the relation elements satisfy the function precondition
and that the if-test is negated. \<close>
abbreviation sumset_wf_rel :: \<open>(VDMNat VDMSet \<times> VDMNat VDMSet) set\<close> where
  \<open>sumset_wf_rel \<equiv> { (s - {(\<some> e . e \<in> s)}, s)| s . pre_sumset s \<and> s \<noteq> {}}\<close>

text \<open>Given this is a simple recursion, again we can piggyback on Isabelle 
machinery by using the terms @{term gen_set_term} and @{term finite_psubset}.
They establishes that a relation where the first element is strictly smaller
set than the second in the relation pair is well-founded. This makes
the proof of well-foundedness easy for @{command sledgehammer}.\<close>

lemma l_sumset_rel_wf: \<open>wf (gen_set_term sumset_wf_rel)\<close>
  using l_gen_set_term_wf \<^marker>\<open>tag invisible\<close>
  by blast \<^marker>\<open>tag invisible\<close>

text \<open>Next, we tackle the termination proof, with the same setup with @{method
relation} again.\<close>
termination\<^marker>\<open>tag invisible\<close>
  apply (relation \<open>(gen_set_term sumset_wf_rel)\<close>)\<^marker>\<open>tag invisible\<close>
  using l_sumset_rel_wf \<^marker>\<open>tag invisible\<close> 
  apply force\<^marker>\<open>tag invisible\<close>
  text \<open>Unfortunately, using @{command sledgehammer} fails to discharge the
  second subgoal @{subgoals[display]}\<close>
  oops\<^marker>\<open>tag invisible\<close>

text \<open>Fortunately, for most simple situations, this is easy to decompose in
general. The translation strategy takes the \<^verbatim>\<open>@IsaMeasure\<close> expression and
decomposes its parts, such that the filtering predicates are assumptions, and
the element in the relation belongs to the well-founded measure chosen. This 
is defined in the next lemma, which require some manual intervention until 
Isabelle's @{command sledgehammer} can finish the proof.\<close>
lemma l_pre_sumset_sumset_wf_rel: 
   \<open>pre_sumset s \<Longrightarrow> s \<noteq> {} \<Longrightarrow> (s - {(\<some> x. x \<in> s)}, s) \<in> (gen_set_term sumset_wf_rel)\<close>
  unfolding gen_set_term_def \<^marker>\<open>tag invisible\<close>
  apply (simp add: pre_sumset_defs)\<^marker>\<open>tag invisible\<close>
  by (metis Diff_subset member_remove psubsetI remove_def some_in_eq)\<^marker>\<open>tag invisible\<close>

text \<open>The intuition behind this lemma is that elements in the measure
relation satisfy well-foundedness under the function precondition and the
filtering case (\<^term>\<open>s \<noteq> {}\<close>) where the recursive call is made. That is,
the precondition and filtering condition help establish the terminating
relation. For this particular proof, the only aspect needed from the
precondition is that the set is finite.
With this, we try the termination proof and @{command
sledgehammer} find proofs for all subgoals.\<close>
termination\<^marker>\<open>tag invisible\<close>
  apply (relation \<open>(gen_set_term sumset_wf_rel)\<close>)\<^marker>\<open>tag invisible\<close>
  using l_sumset_rel_wf apply force\<^marker>\<open>tag invisible\<close>
  using l_pre_sumset_sumset_wf_rel by presburger\<^marker>\<open>tag invisible\<close>
(*<*)
lemma l_pre_fact_wf_rel': \<open>pre_fact n \<Longrightarrow> n \<noteq> 0 \<Longrightarrow> (n - 1, n) \<in> gen_VDMNat_term fact_wf\<close>
  unfolding gen_VDMNat_term_def gen_VDMInt_term_def
  using l_fact_term_valid by force
(*>*)

text \<open>Note we omit such lemma over termination and precondition for the
\<^typ>\<open>VDMNat\<close> case in Section~\ref{subsec:VDMNat}. The translation strategy
does define it following the same recipe, where @{command sledgehammer} 
find the proof once more.\<close>
lemma l_pre_fact_wf_rel: 
  \<open>\<lbrakk>pre_fact n; n \<noteq> 0\<rbrakk> \<Longrightarrow> (n - 1, n) \<in> gen_VDMNat_term fact_wf\<close>
  unfolding gen_VDMNat_term_def gen_VDMInt_term_def \<^marker>\<open>tag invisible\<close>
  using l_less_than_VDMNat_subset_int_ge_less_than pre_fact_def \<^marker>\<open>tag invisible\<close>
  by auto \<^marker>\<open>tag invisible\<close>

(*<*)
lemma l_sumset_wf_rel_valid: \<open>gen_set_term sumset_wf_rel = sumset_wf_rel\<close>
  apply (intro equalityI subsetI, simp) \<^marker>\<open>tag invisible\<close>
  using l_pre_sumset_sumset_wf_rel by blast \<^marker>\<open>tag invisible\<close>
(*>*)

text \<open>Finally, even though this was not necessary for this proof, we encourage
users to always provide a witness for the top recursive call. This is done by
using the \<^verbatim>\<open>@Witness\<close> annotation~@{cite AdvancedVSCodePaper}:~it provides a 
concrete example for the function input parameters. This witness is useful 
for existentially quantified predicates of involved termination 
proofs (see Section~\ref{subsec:Complex}).\<close>

(*---------------------------------------------------------------------------*)
subsection \<open>Recursion over VDM maps\label{subsec:VDMMap}\<close>

text \<open>Recursive functions over maps are a special case of sets, given
map recursion usually iterates over the map's domain. For example, the
function that sums the elements of the map's range is defined as
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
  sum_elems: map nat to nat -> nat
  sum_elems(m) == 
    if m = {|->} then 0 else let d in set dom m in m(d) + sum_elems({d}<-:m)
  --@IsaMeasure({({d} <-: m, m) | m : map nat to nat, d: nat & 
                      m <> {} and d in set dom m})
  --@Witness( sum_elems({ 1 |-> 1 }) )
  measure card dom m;
\end{vdmsl}
%
\noindent As with sets, it iterates over the map by picking a domain element,
performing the necessary computation, and then recursing on the map filtered by
removing the chosen element, until the map is empty and the function
terminates. The measure relation follows the same
pattern:~recursive call site related with defining site, where both the
if-test and the \<^verbatim>\<open>let-in-set\<close> choice is part of the filtering predicate.

Following the general translation strategy for maps~@{cite NimFull}, we define
the function precondition using \<^term>\<open>inv_Map\<close>. It insists that both the map
domain and range are finite, and that all domain and range elements satisfy
their corresponding type invariant. Note that, if the recursion was defined
over sets other than the domain and range, then Isabelle require the proof
such set is finite. Given both domain and range sets are finite,
this should be easy, if needed.\<close>

definition pre_sum_elems :: \<open>(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> \<bool>\<close> where
  \<open>pre_sum_elems m \<equiv> inv_VDMMap inv_VDMNat inv_VDMNat m\<close>
lemmas pre_sum_elems_defs = pre_sum_elems_def inv_VDMMap_defs  

text \<open>VDM maps in Isabelle (\<^typ>\<open>(VDMNat \<rightharpoonup> VDMNat)\<close>) are defined as a HOL
function which maps to an optional result. That is, if the element is in the
domain, then the map results in a non {\texttt{\<^bold>\<open>nil\<close>}} value; whereas, if the
element does not belong to the domain, then the map results in a {\texttt{\<^bold>\<open>nil\<close>}}
value. This makes all maps total, where values outside the domain
map to {\texttt{\<^bold>\<open>nil\<close>}}. The Isabelle translation and compatibility proof
follows patterns used before.\<close>
function (domintros) sum_elems :: \<open>(VDMNat \<rightharpoonup> VDMNat) \<Rightarrow> VDMNat\<close> where
  \<open>sum_elems m = 
    (if pre_sum_elems m then
         if m = Map.empty then 0 else
             let d = (\<some> e . e \<in> dom m) in the(m d) + (sum_elems ({d} -\<triangleleft> m))
     else undefined)\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag invisible\<close>

text \<open>Similarly, the well-founded relation is translated
next, where the precondition is included as part of the relation's
filter. The \<^term>\<open>{d}-\<triangleleft>m\<close> corresponds to the VDM domain anti-filtering operator
\<^verbatim>\<open>{d}<-:m\<close>.\<close>
abbreviation 
  sum_elems_wf :: \<open>((VDMNat \<rightharpoonup> VDMNat) \<times> (VDMNat \<rightharpoonup> VDMNat)) VDMSet\<close> 
  where \<open>sum_elems_wf \<equiv> 
  { (({d} -\<triangleleft> m), m) | m d . pre_sum_elems m \<and> m \<noteq> Map.empty \<and> d \<in> dom m }\<close>

text \<open>For the well-founded lemma over the recursive measure relation, there is
no available Isabelle help, and projecting the domain element of the maps
within the relation is awkward. Thus, we have to prove the well-founded lemma 
and this will not be automatic in general. This is one difference in terms of
translation of VDM recursive functions over sets and maps.

Fortunately, the proof strategy for such situations is somewhat known:~it
follows a similar strategy to the proof of well foundedness of the
\<^term>\<open>finite_psubset\<close>. It uses the provided VDM measure expression to extract 
the right projection of interest, then follows the proof for
 \<^term>\<open>finite_psubset\<close>, where @{command sledgehammer} can 
find the final steps.

The precondition subgoal and the termination proof follow the same
patterns as before. Their proof was discovered with @{command
sledgehammer}, yet this will not be the case in general.\<close>
lemma l_sum_elems_wf: \<open>wf sum_elems_wf\<close>
  apply (rule wf_measure[of \<open>\<lambda> m . card (dom m)\<close>, THEN wf_subset]) \<^marker>\<open>tag invisible\<close>
  apply (simp add: measure_def inv_image_def less_than_def less_eq)\<^marker>\<open>tag invisible\<close>
  apply (rule subsetI, simp add: case_prod_beta)\<^marker>\<open>tag invisible\<close>
  apply (elim exE conjE)\<^marker>\<open>tag invisible\<close>
  by (simp add: l_VDMMap_filtering_card pre_sum_elems_defs)\<^marker>\<open>tag invisible\<close>

lemma l_pre_sum_elems_sum_elems_wf: 
  \<open>\<lbrakk>pre_sum_elems m; m \<noteq> Map.empty\<rbrakk> \<Longrightarrow> 
   ({(\<some> e. e \<in> dom m)} -\<triangleleft> m, m) \<in> sum_elems_wf\<close>
  apply (simp add: pre_sum_elems_defs) \<^marker>\<open>tag invisible\<close>
  by (metis domIff empty_iff some_in_eq) \<^marker>\<open>tag invisible\<close>

termination  \<^marker>\<open>tag invisible\<close>
  apply (relation sum_elems_wf)\<^marker>\<open>tag invisible\<close>
(*  apply (rule \<open>termination\<close>[OF l_sum_elems_wf])\<^marker>\<open>tag invisible\<close> *)
  apply (simp add: l_sum_elems_wf)\<^marker>\<open>tag invisible\<close>
  using l_pre_sum_elems_sum_elems_wf by presburger\<^marker>\<open>tag invisible\<close>

lemma l_sum_elems_wf_valid: \<open>sum_elems_wf \<noteq> {}\<close>
  apply safe \<^marker>\<open>tag invisible\<close>
  apply (erule equalityE)\<^marker>\<open>tag invisible\<close>
  apply (simp add: subset_eq)\<^marker>\<open>tag invisible\<close>
  apply (erule_tac x=\<open>[1 \<mapsto> 1]\<close> in allE)\<^marker>\<open>tag invisible\<close>
  by (simp add: pre_sum_elems_defs) \<^marker>\<open>tag invisible\<close>

text \<open>Finally, we also prove that the well founded termination relation
is not empty, as we did for sets and \<^bold>\<open>nat\<close>
recursion. Note that here the \<^verbatim>\<open>@Witness\<close> annotation is useful in discharging
the actual value to use as the witness demonstrating the relation is not
empty.\<close>

(*---------------------------------------------------------------------------*)
subsection \<open>VDM recursion involving complex measures\label{subsec:Complex}\<close>

text \<open>The class of recursive examples shown so far have covered a wide range of
situations, and have a good level of automation. Nevertheless, the same
strategy can also be applied for more complex recursive definitions. The cost
for the VDM user is the need of involved \<^verbatim>\<open>@IsaMeasure\<close> definitions and
the highly likely need for extra user-defined lemmas. These lemmas can be
defined in VDM itself using the \<^verbatim>\<open>@Lemma\<close> annotation.
To illustrate this, we define in VDM the (in)famous Ackermann
function\<^footnote>\<open>\<^url>\<open>https://en.wikipedia.org/wiki/Ackermann_function\<close>\<close>, which is a
staple example of complex recursion.
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
    ack: nat * nat -> nat 
    ack(m,n) == if m = 0 then n+1
           else if n = 0 then ack(m-1, 1)
           else               ack(m-1, ack(m, (n-1)))
    --@IsaMeasure( pair_less_VDMNat )
    --@Witness( ack(2, 1) )
    measure is not yet specified;
\end{vdmsl}
%
\noindent Note that the VDM measure is not defined, and that the
\<^verbatim>\<open>@IsaMeasure\<close> uses a construct from Isabelle called \<^term>\<open>pair_less\<close>. It
is part of Isabelle's machinery of concrete orders for SCNP problems @{cite
KrausSCNP}. It considers recursions over multiple parameters, where some might
increase the number of calls (\<^emph>\<open>e.g.\<close>~size-change). We are not aware of a
mechanism to define such measures in VDM.

We instantiate \<^term>\<open>pair_less\<close> to \<^typ>\<open>VDMNat\<close> as the
lexicographic product over the transitive closure of a totally ordered
relation between inputs\<^footnote>\<open>Details of this definition are in the
\<^verbatim>\<open>VDMToolkit.thy\<close> within the distribution.\<close>.
If VDM measures were over relations, then the Ackermann measure could be defined
in VDM, assuming a standard definition of transitive closure\<^footnote>\<open>The
\<^verbatim>\<open>Relations.vdmsl\<close> provides such definition in the VDM toolkit distribution.\<close>.
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
pair_less_VDMNat: () -> set of ((nat*nat) * (nat*nat))
pair_less_VDMNat() == lex_prod[nat, nat](less_than_VDMNat(), less_than_VDMNat());

less_than_VDMNat: () -> set of (nat*nat)
less_than_VDMNat() == trans_closure[nat]({ mk_(z', z) | z', z : nat & z' < z });

lex_prod[@A,@B]: set of (@A*@A) * set of (@B*@B) -> set of ((@A*@B) * (@A*@B))
lex_prod(ra,rb) == { mk_(mk_(a, b), mk_(a', b')) | a, a': @A, b, b': @B & 
                      mk_(a,a') in set ra or a = a' and mk_(b, b') in set rb };
\end{vdmsl}
%
That represents the lexicographic product of possibilities that are ordered in 
its parameters. Translation then outputs:\<close>

definition pre_ack :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> \<bool>\<close> where
  \<open>pre_ack m n \<equiv> inv_VDMNat m \<and> inv_VDMNat n\<close>
lemmas pre_ack_defs = pre_ack_def 

function (domintros) ack :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> VDMNat\<close> where
  \<open>ack m n = (if pre_ack m n then
                       if m = 0 then n+1
                  else if n = 0 then ack (m-1) 1
                  else               ack (m-1) (ack m (n-1))
                  else               undefined)\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag invisible\<close>

abbreviation ack_wf :: \<open>((VDMNat \<times> VDMNat) \<times> (VDMNat \<times> VDMNat)) VDMSet\<close> 
  where \<open>ack_wf \<equiv> pair_less_VDMNat\<close>

termination \<^marker>\<open>tag invisible\<close>
  apply (relation ack_wf)\<^marker>\<open>tag invisible\<close>
  using wf_pair_less_VDMNat \<^marker>\<open>tag invisible\<close> apply blast \<^marker>\<open>tag invisible\<close>
    apply (simp add: l_pair_less_VDMNat_I1 pre_ack_def) \<^marker>\<open>tag invisible\<close>
   apply (simp add:  pre_ack_def) \<^marker>\<open>tag invisible\<close>
  by (simp add: pair_less_VDMNat_def pre_ack_def) \<^marker>\<open>tag invisible\<close>

text \<open>Compatibility and termination proofs are similar, despite the more 
complex measure, because of available Isabelle automation. We also show that 
this version of Ackermann with \<^typ>\<open>VDMNat\<close> is equivalent to the usual Isabelle 
definition using \<^typ>\<open>\<nat>\<close>. We omit details here, but have proved that they are 
equivalent by induction.\<close>
(*<*)
fun ack' :: \<open>\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<nat>\<close> where
  \<open>ack' 0 n             = Suc n\<close>
| \<open>ack' (Suc m) 0       = ack' m 1\<close>
| \<open>ack' (Suc m) (Suc n) = ack' m (ack' (Suc m) n)\<close>

fun ack'' :: \<open>\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<nat>\<close> where
  \<open>ack'' m n = (if m = 0 then Suc n else if n = 0 then 
                  ack'' (m - 1) 1 else ack'' (m-1) (ack'' m (n -1)))\<close>
lemma l_ack''_1[simp]: \<open>ack'' 0 n = Suc n\<close> by simp
lemma l_ack''_2[simp]: \<open>ack'' (Suc m) 0 = ack'' m 1\<close> by simp
lemma l_ack''_3[simp]: \<open>ack'' (Suc m) (Suc n) = ack'' m (ack'' (Suc m) n)\<close> by simp

function ack''' :: \<open>\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<nat>\<close> where
  \<open>ack''' 0 n             = Suc n\<close>
| \<open>ack''' (Suc m) 0       = ack''' m 1\<close>
| \<open>ack''' (Suc m) (Suc n) = ack''' m (ack''' (Suc m) n)\<close>
  by (pat_completeness, auto) 
termination 
  text \<open>Through the sledgehammer version, I unpicked the various bits and
  pieces needed.\<close>
(*
  using \<open>termination\<close> lessI pair_lessI1 pair_less_iff1 wf_pair_less by presburger
*)
  thm lessI pair_lessI1 pair_less_def pair_less_iff1 wf_pair_less
  apply (relation pair_less)
     apply (simp)
  using lessI pair_lessI1 apply presburger
  using lessI pair_less_iff1 apply presburger
  using lessI pair_lessI1 by presburger
(*>*)

theorem ack_correct: \<open>ack' m n = ack m n\<close>
  apply (induction \<open>m\<close> \<open>n\<close> rule: ack'.induct) by (simp add: pre_ack_defs)+

text \<open>In general, each complex recursive function will require such a setup.
Fortunately, Isabelle has a number of options available. Yet, in general, the
more complex the recursion, the more users will have to provide further
automation.\<close>

(*---------------------------------------------------------------------------*)
subsection \<open>Harder examples\label{subsec:Hard}\<close>

(*<*)

text \<open>Other examples from @{cite SCT_POPL}. Example 3 is Ackermann, example 4
is permutation. Example 5 are yet to be finished.\<close>

fun sct1_rev :: \<open>'a list \<Rightarrow> 'a list\<close>
and sct1_r1  :: \<open>'a list \<Rightarrow> 'a list \<Rightarrow> 'a list\<close> 
where
  \<open>sct1_rev ls = sct1_r1 ls []\<close>
| \<open>sct1_r1 ls a = (if ls = [] then a else sct1_r1 (tl ls) ((hd ls)#a))\<close>

fun sct2_f :: \<open>'a list \<Rightarrow> 'a list \<Rightarrow> 'a list\<close>
and sct2_g :: \<open>'a list \<Rightarrow> 'a list \<Rightarrow> 'a list \<Rightarrow> 'a list\<close>
  where
  \<open>sct2_f i x   = (if i = [] then x else (sct2_g (tl i) x i))\<close>
| \<open>sct2_g a b c = sct2_f a (b @ c)\<close>

function sct5_f :: \<open>'a list \<Rightarrow> 'a list \<Rightarrow> 'a list\<close> where
  \<open>sct5_f x y = (if y = [] then x else if x = [] then sct5_f y (tl y) else sct5_f y (tl x))\<close>
  by (pat_completeness, auto)

abbreviation sct5_f_wf_rel :: \<open>(('a list \<times> 'a list) \<times> 'a list \<times> 'a list) set\<close> where
  \<open>sct5_f_wf_rel \<equiv>
   { ((y, tl y), (x, y)) | x y . y \<noteq> [] \<and> x = [] } \<union> 
   { ((y, tl x), (x, y)) | x y . y \<noteq> [] \<and> x \<noteq> [] }\<close>

lemma l_sct5__wf_rel_VDM_measure: 
  \<open>sct5_f_wf_rel \<subseteq> measure (\<lambda> (x,y) . if y = [] then 0 else if x = [] then length y else length x + length y)\<close>
  apply (intro subsetI, case_tac x, case_tac a)
    apply (simp add: case_prod_beta)
  apply (elim disjE conjE, simp)  
  nitpick
  oops

(*lemma l_sct5_f_wf: \<open>wf sct5_f_wf_rel\<close> 
  using l_sct5__wf_rel_VDM_measure 
  by (rule wf_subset [OF wf_measure])

termination
  apply (relation sct5_f_wf_rel)
  using l_sct5_f_wf apply blast
  by simp+*)

fun sct6_f :: \<open>'a list \<Rightarrow> 'a list \<Rightarrow> 'a list\<close> 
and sct6_g :: \<open>'a list \<Rightarrow> 'a list \<Rightarrow> 'a list\<close>
where
  \<open>sct6_f a b = (if b = [] then sct6_g a [] else sct6_f ((hd b)#a) (tl b))\<close>
| \<open>sct6_g c d = (if c = [] then d else sct6_g (tl c) ((hd c)#d))\<close>

(*>*)

text \<open>We can handle all examples from~@{cite SCT_POPL}. We show here some that
require an elaborate setup. For example, the permutation function shows
permuting decreasing parameters with an involved measure. The precondition was
required for finishing the termination proof and shows an example why proofs
over \<^typ>\<open>\<int>\<close> can be harder. This illustrated how Isabelle (failed) proofs 
helped to improve the VDM specification. 
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
    perm: int * int * int -> int 
    perm(m,n,r) == if 0 < r then perm(m, r-1, n) 
              else if 0 < n then perm(r, n-1, m) else m
    --@IsaMeasure({mk_(mk_(m, r-1, n), mk_(m,n,r)) | ... & 0 < r} union 
    --            {mk_(mk_(r, n-1, m), mk_(m,n,r)) | ... & not 0 < r and 0 < n})
    pre ((0 < r or 0 < n) => m+n+r > 0)   measure maxs({m+n+r, 0});      

    tak: int * int * int -> int
    tak(x,y,z) == if x <= y then y  
                  else           tak(tak(x-1,y,z), tak(y-1,z,x), tak(z-1,x,y))
    measure is not yet specified;
\end{vdmsl}\<close>

definition pre_perm :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>\<close> where
  \<open>pre_perm m n r \<equiv> ((0 < r \<or> 0 < n) \<longrightarrow> m+n+r > 0)\<close>
lemmas pre_perm_defs = pre_perm_def inv_VDMInt_def inv_True_def

lemma l_pre_perm_trivial[simp]: \<open>(pre_perm m n r) = ((0 < r \<or> 0 < n) \<longrightarrow> m+n+r > 0)\<close> \<^marker>\<open>tag invisible\<close>
  unfolding pre_perm_def inv_VDMInt_def \<^marker>\<open>tag invisible\<close>
  by simp \<^marker>\<open>tag invisible\<close>

function (domintros) perm :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt\<close> where
  \<open>perm m n r = (if pre_perm m n r then
                                if 0 < r then perm m (r-1) n 
                           else if 0 < n then perm r (n-1) m else m
                        else undefined)\<close>
  by (pat_completeness, auto) \<^marker>\<open>tag invisible\<close>

(*perm_wf_rel :: \<open>((VDMInt \<times> VDMInt \<times> VDMInt) \<times> (VDMInt \<times> VDMInt \<times> VDMInt)) VDMSet\<close>
  where*)
definition \<open>perm_wf_rel \<equiv> 
   { ((m, r-1, n), (m, n, r)) | m r n . pre_perm m n r \<and> 0 < r } \<union> 
   { ((r, n-1, m), (m, n, r)) | m r n . pre_perm m n r \<and> \<not> 0 < r \<and> 0 < n }\<close>

text \<open>Its measure relation contains elements for each recursive call, filtered
for the corresponding if-then case. The proof of well-foundedness of such
measure relations involving multiple recursive calls require further proof
engineering, which is stated in the next lemma.\<close>

lemma l_perm_wf_rel_VDM_measure: 
  \<open>perm_wf_rel \<subseteq> measure (\<lambda> (m, r, n) . nat (max 0 (m+r+n)))\<close>
proof - \<^marker>\<open>tag invisible\<close>
   show ?thesis
  apply (intro subsetI, case_tac x)
    apply (simp add: perm_wf_rel_def case_prod_beta max_def)
    apply (elim disjE conjE, simp) 
     apply (intro impI conjI, simp_all)
    done
qed

lemma l_perm_wf_rel: \<open>wf perm_wf_rel\<close>
proof - \<^marker>\<open>tag invisible\<close>
  from l_perm_wf_rel_VDM_measure show ?thesis
  by (rule wf_subset [OF wf_measure])
qed

text \<open>The Isabelle \<^term>\<open>measure\<close> definition projects the less-than ordered
inverse image\<^footnote>\<open>That is, @{thm measure_def}. Inverse image is defined as @{thm
inv_image_def}.\<close> of a given function as the recursive measure relation. Here
the VDM-defined measure is given as such measure function projection. This
highlights to the VDM user the relationship (and differences) between VDM and
Isabelle recursive measures.

The setup works here if the @{term pre_perm} specifically curbs negative
sums of parameters. This was not immediately obvious. With the added
precondition the termination proof is discovered with @{command sledgehammer}.\<close>
termination \<^marker>\<open>tag invisible\<close>
  apply (relation \<open>perm_wf_rel\<close>) \<^marker>\<open>tag invisible\<close>
    apply (simp add: l_perm_wf_rel) \<^marker>\<open>tag invisible\<close>
  by (simp_all add: perm_wf_rel_def)  \<^marker>\<open>tag invisible\<close>

text \<open>Finally, the Takeuchi's
function\<^footnote>\<open>\<^url>\<open>https://isabelle.in.tum.de/library/HOL/HOL-Examples/Functions.html\<close>\<close>,
which contains both permutation and inner recursion is defined next, where the
important part is the SCNP setup using multi-sets @{cite KrausSCNP}. That is
needed because ordered lexicographic products are not strong enough to capture
this type of recursion. It has not implicit precondition. The translation
strategy works for these definitions, yet stands little chance of finding
proofs automatically.\<close>
function (domintros) tak :: \<open>VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt\<close> where
  \<open>tak x y z = (if x \<le> y then y else tak (tak (x-1) y z) (tak (y-1) z x) (tak (z-1) x y))\<close>
  by auto \<^marker>\<open>tag invisible\<close>

text \<open>Next is an example of how one has to keep domain predicates as 
assumptions prior to termination proofs.\<close>
lemma tak_pcorrect:
  \<open>tak_dom (x, y, z) \<Longrightarrow> tak x y z = (if x \<le> y then y else if y \<le> z then z else x)\<close>
  thm tak.pinduct tak.psimps \<^marker>\<open>tag invisible\<close>
  apply (induction x y z rule: tak.pinduct) \<^marker>\<open>tag invisible\<close>
  by (simp add: tak.psimps) \<^marker>\<open>tag invisible\<close>

text \<open>Each case (including the non-recursive call) is represented in the SCNP
setup, and then their measure-lexicographic\<^footnote>\<open>The measure-lexicographic product
\<^term>\<open>f <*mlex*> R\<close> is represented as the inverse image of the lexicographic product @{thm
mlex_prod_def}.\<close> composition is used as the measure relation for the
termination proof.\<close>
definition tak_m1 where \<open>tak_m1 = (\<lambda>(x,y,z). if x \<le> y then 0 else 1)\<close>
definition tak_m2 where \<open>tak_m2 = (\<lambda>(x,y,z). nat (Max {x, y, z} - Min {x, y, z}))\<close>
definition tak_m3 where \<open>tak_m3 = (\<lambda>(x,y,z). nat (x - Min {x, y, z}))\<close>

(*<*)
lemma \<open>(((x1,y1,z1),(x2,y2,z2)) \<in> tak_m3 <*mlex*> {}) \<longleftrightarrow> (nat (x1 - Min {x1, y1, z1}) < nat (x2 - Min {x2, y2, z2}))\<close>
  apply (simp add: mlex_iff)
  unfolding tak_m3_def
  (*apply (simp only: case_prod_beta fst_conv snd_conv) *)
  by simp

lemma \<open>((x1,y1,z1),(x2,y2,z2)) \<in> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close>
  apply (simp add: mlex_iff)
  unfolding tak_m3_def tak_m2_def
  apply (simp only: case_prod_beta fst_conv snd_conv, clarify)
  oops

lemma l_call1: 
  \<open>x > y \<Longrightarrow> ((x-1,y,z),(x,y,z)) \<in> tak_m1 <*mlex*> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close> 
  apply (simp add: mlex_iff)  \<^marker>\<open>tag invisible\<close>
  unfolding tak_m3_def tak_m2_def tak_m1_def \<^marker>\<open>tag invisible\<close>
  apply (simp add: case_prod_beta)\<^marker>\<open>tag invisible\<close>
  unfolding min_def max_def\<^marker>\<open>tag invisible\<close>
  by (simp_all split:if_splits)\<^marker>\<open>tag invisible\<close>

lemma l_call2:
  \<open>x > y \<Longrightarrow> ((y-1,z,x),(x,y,z)) \<in> tak_m1 <*mlex*> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close>
  apply (simp add: mlex_iff)
  unfolding tak_m3_def tak_m2_def tak_m1_def
  by (simp add: case_prod_beta)
  
lemma l_call3:
  \<open>x > y \<Longrightarrow> ((z-1,x,y),(x,y,z)) \<in> tak_m1 <*mlex*> (tak_m2 <*mlex*> (tak_m3 <*mlex*> {}))\<close>
  apply (simp add: mlex_iff)
  unfolding tak_m3_def tak_m2_def tak_m1_def
  by (simp add: case_prod_beta)
  
lemma l_call4:
  \<open>x >y \<Longrightarrow>  tak_dom (z - 1, x, y) \<Longrightarrow>
       tak_dom (y - 1, z, x) \<Longrightarrow>
       tak_dom (x - 1, y, z) \<Longrightarrow>
       ((tak (x - 1) y z, tak (y - 1) z x, tak (z - 1) x y), x, y, z)
       \<in> tak_m1 <*mlex*> tak_m2 <*mlex*> tak_m3 <*mlex*> {}\<close>
  apply (simp add: mlex_iff)
  apply (simp add: tak_pcorrect)
  unfolding tak_m3_def tak_m2_def tak_m1_def 
  by (simp add: case_prod_beta)
(*>*)

text \<open>The termination proof uses the measure relation @{term \<open>tak_m1 <*mlex*>
tak_m2 <*mlex*> tak_m3 <*mlex*> {}\<close>}. It requires user-defined lemmas for each
of the four cases.\<close>
termination \<^marker>\<open>tag invisible\<close>
  apply (relation \<open>tak_m1 <*mlex*> tak_m2 <*mlex*> tak_m3 <*mlex*> {}\<close>) \<^marker>\<open>tag invisible\<close>
      apply (simp add: wf_mlex) \<^marker>\<open>tag invisible\<close>
     apply (simp add: l_call1)\<^marker>\<open>tag invisible\<close>
     apply (simp add: l_call2)\<^marker>\<open>tag invisible\<close>
     apply (simp add: l_call3)\<^marker>\<open>tag invisible\<close>
  by (simp add: l_call4)\<^marker>\<open>tag invisible\<close>

text \<open>With the total version of induction and simplification rules are
available. Then, it is possible to prove its rather simpler equivalence.\<close>

theorem tak_correct: \<open>tak x y z = (if x \<le> y then y else if y \<le> z then z else x)\<close>
  by (induction x y z rule: tak.induct) auto

(*---------------------------------------------------------------------------*)
subsection \<open>Mutual recursion\label{subsec:MutualRec}\<close>

text \<open>Finally, we handle mutual recursion. VDM has few bounds on mutually
recursive definitions. We reuse the VDM type checker cyclic-measure discovery
algorithm in order to deduce related recursive calls. Note this is not
complete and may fail to discover involved recursive calls, such as those
under some lambda-term result, for example. If that recursive call graph
discovery fails, then users have to annotate at least one of the mutually
recursive definitions with an \<^verbatim>\<open>@IsaMutualRec\<close> annotation listing all expected
function names involved.

Mutually recursive definitions proof obligations refer to each others
measure functions. Isabelle requires all related functions to be given in a
single definition, where Isabelle's sum (or union) types are used in the proof
setup. Where needed, termination proof setup will be involved and with limited 
automation. Here is a simple example and its translation, which works with
 \<^term>\<open>fun\<close> syntax, hence has no further proof obligation needs. Note that in 
this case using \<^term>\<open>fun\<close> syntax, we declare implicit preconditions as 
simplification rules.
%
\begin{vdmsl}[frame=none,basicstyle=\ttfamily\scriptsize]
    --@IsaMutualRec({odd})
    even: nat -> bool
    even(n) == if n = 0 then true else odd(n-1) measure n;
    
    --@IsaMutualRec({even})
    odd: nat -> bool
    odd(n) == if n = 0 then false else even(n-1) measure n;
\end{vdmsl}
\<close>
definition pre_even :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where [termination_simp]: \<open>pre_even n \<equiv> inv_VDMNat n\<close> 
definition pre_odd  :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where [termination_simp]: \<open>pre_odd n \<equiv> inv_VDMNat n\<close> 
fun (domintros) even :: \<open>VDMNat \<Rightarrow> \<bool>\<close> and odd  :: \<open>VDMNat \<Rightarrow> \<bool>\<close> where 
  \<open>even n = (if pre_even n then (if n = 0 then True else odd (n-1)) else undefined)\<close>
| \<open>odd  n = (if pre_odd n then (if n = 0 then False else even (n-1)) else undefined)\<close>

(******************************************************************************)
section \<open>Discussion and conclusion\label{sec:Conclusion}\<close>

text \<open>This paper has presented a translation strategy from VDM to Isabelle for
recursive functions over basic types, sets and maps, as well as mutual
recursion. We present how the strategy works for complex recursion.

The complex recursion examples hint at possible VDM recursive measure
extensions to use a combination of measure relations and functions. The full
VDM and Isabelle sources and proofs can be found at the VDM toolkit repository
at \<^verbatim>\<open>RecursiveVDM*.thy\<close>\<^footnote>\<open>\<^url>\<open>https://github.com/leouk/VDM_Toolkit\<close>\<close>.

\<^bold>\<open>Future work.\<close>~We are implementing the translation strategy in the
\<^verbatim>\<open>vdm2isa\<close> plugin, which should be available soon.

\<^bold>\<open>Acknowledgements.\<close>~We appreciated discussions with Stephan Merz on pointers
for complex well-founded recursion proofs in Isabelle, and with Nick Battle on
limits for VDM recursive measures. Peter Gorm Larsen would also like to
acknowledge the Poul Due Jensen Foundation for funding the project Digital
Twins for Cyber-Physical Systems (DiT4CPS).\<close>

(*<*)
lemma l_sumset_rel_wf': \<open>wf sumset_wf_rel\<close>
  apply (rule wf_measure[of \<open>\<lambda> s . card s\<close>, THEN wf_subset])\<^marker>\<open>tag invisible\<close>
  apply (simp add: measure_def inv_image_def less_than_def less_eq)\<^marker>\<open>tag invisible\<close>
  apply (rule subsetI, simp add: case_prod_beta)\<^marker>\<open>tag invisible\<close>
  apply (elim exE conjE)\<^marker>\<open>tag invisible\<close>
  by (metis card_Diff1_less_iff fst_conv inv_VDMMap_defs(2) inv_VDMMap_defs(3) 
        pre_sumset_defs(1) snd_conv some_in_eq)\<^marker>\<open>tag invisible\<close>
(*>*)

(*<*)
end
(*>*)
