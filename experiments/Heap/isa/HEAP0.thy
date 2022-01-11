(* $Id$ *)
(*<*)
theory HEAP0
imports HEAPPreamble
begin
(*>*)

section\<open> Introduction \<close>
text\<open>
This chapter and the next continue the exposition of the heap storage case study by describing the
formalisation and formal verification in the Isabelle proof assistant~\cite{NipkowPW02}
of the latest heap model presented in Chapter~\ref{C-model-heap}. 

In the next section (Section~\ref{s:isa:bg}), we briefly introduce the Isabelle proof assistant 
and its proof languages.
Then, in Section~\ref{s:isa:bg:vdmmaps} we give a general description of how VDM operations and functions 
are formalised in Isabelle, giving details of the important differences.
%
Section~\ref{s:isa:models} presents the Isabelle models for level 0 and level 1. The latex code
that presents these models is directly generated from the proof developement. This section is
paired with Appendix~\ref{A-nomenclature}, which details our naming and stylistic conventions 
in the formalisation.

Chapter~\ref{C-isaproofs} describes the proof obligations and provides a broad overview of the
formal verification. We pursued two parallel verification efforts in Isabelle: Freitas, using a
procedural style of proof, leveraging Isabelle's automation; Whiteside used the declarative Isar
language. We provide a broad comparison of the two proof efforts.  
%
The full proofs can be found on in Appendices~\ref{A-iainproofs} and~\ref{A-leoproofs}.
\<close>


section\<open> The Isabelle proof assistant \label{s:isa:bg} \<close>
text\<open>
Isabelle is a generic theorem prover or, rather, a logical framework with a meta-logic called 
Isabelle/Pure (minimal intuitionistic higher order logic)
in which object logics are encoded. We use the most popular, and best supported, object logic: 
classical higher order logic (referred to as Isabelle/HOL). 

%
In this section, we describe the 
elements of Isabelle required to understand the rest of this technical report. 
Section~\ref{s:isa:bg:languages} details the proof languages used by Freitas and Whiteside, 
providing a brief comparison of their features. 
%
Then Section~\ref{s:isa:bg:sledge} introduces
the Sledgehammer and Nitpick tools which are important in harnessing automation and checking for
counterexamples, respectively.
%
Section~\ref{s:isa:bg:vdmmaps} introduces our VDM library and highlights three key differences
between the Isabelle representations and the VDM logic that are important to understand the
formalisation that follows. Finally, we summarise in Section~\ref{s:isa:bg:sum}.
\<close>

subsection\<open> Isabelle proof languages \label{s:isa:bg:languages}\<close>
text\<open>
The core proof language for Isabelle is called Isar~\cite{Wenzel02}. Broadly speaking, it permits 
two styles of proof: declarative, where the state of the proof is encoded in the proof script; and, 
procedural, where the state of the proof can only be seen upon replay. As a simple illustration,
we give two proofs in Isabelle using each style. The proof shown is part of the proof of 
commutativity of addition for natural numbers.

\<close>
theorem natcom_procedural:
"(a::nat) + b = b+a"
apply (induct a)
apply (subst add_0)
apply (subst add_0_right) 
apply (rule refl)
by (metis add.commute)

theorem natcom_dec: "(a::nat) + b = b+a"
proof (induct a)
  show "0 + b = b + 0"
  proof -
    have "0+b=b" by (simp)
    also have "...=b+0" by (simp) 
    finally show ?thesis .
  qed
 next 
  fix a
  assume in_hyp: "a + b = b + a"
  show "Suc a + b = b + Suc a"
    by (metis add.commute)
qed

text\<open>

As can be seen, the prodedural style is more compact, but it is not clear without re-running the
proof what the goals being operated on are. Furthermore, it is difficult to see the branching 
structure of the proof because of the linear structure and the fact that some tactics apply to just
a single subgoal, while others apply to several.

The declarative style is longer, but can be read 
without needing to run the system; furthermore, it enables a natural forwards style of proof that
is closer to normal mathematical practice. For a more detailed comparison of both styles of proof,
Harrison's `Proof Style' is recommended~\cite{harrison-style}.

\<close>
subsection \<open> Sledgehammer and Nitpick \label{s:isa:bg:sledge} \<close>
text\<open>
Isabelle also has two important external tools that have been used extensively in this project: 
Sledgehammer~\cite{paulson2010three} and 
Nitpick~\cite{blanchette2009nitpick}. 
\<close>

subsubsection\<open> Sledgehammer \<close>
text\<open> 
Sledgehammer is a tool to find automatic proofs of goals. Invoking sledgehammer will send the 
current goal to multiple automated theorem provers, like Z3, Vampire, Spass, \textit{etc} along with a set
of lemmas from the library that sledgehammer ``thinks''\footnote{The selection process/criteria here
is itself interesting and worth further investigation. How does sledgehammer know what to use/filter?} 
will be useful. If one of the ATPs succeeds,
then it can be translated to an Isabelle proof, using a tactic called `metis'. As a simple example,
the following lemma (a lemma from the VDM maps library) has been proved automatically by sledgehammer,
and requires three lemmas (facts) to be passed to metis.
\<close>

lemma metis_example:
  assumes *: "x \<notin> dom f"
  shows  "x \<notin> dom (s -\<triangleleft> f)"
by (metis * domIff dom_antirestr_def)

text\<open>
Sledgehammer can be more powerful than Isabelle's automated tactics (such as simp and auto) on 
domain reasoning because it can automatically select the appropriate lemmas to use, rather than
performing time-consuming configuration of the simplifier. However, it can fail in domains where
Isabelle has been finely tuned, such as sets, since there are many potential lemmas that can be 
selected. 
\<close>
subsubsection\<open> Nitpick \<close>
text\<open>
Nitpick is a powerful counterexample checker for Isabelle and can be invoked to check the validity
of the lemma you are attempting to prove. For example, running nitpick on the lemma above without
the assumption @{text "*"}:
\<close>

lemma nitpick_example:
 shows  "x \<notin> dom (s -\<triangleleft> f)"
 nitpick
 (*<*) oops (*>*)

text\<open>
\noindent gives the following counterexample: @{term "f = [a1  \<mapsto> b1, a2 \<mapsto> b1]"},  @{term "s = {a2}"}, and
  @{term "x = a1"}, which makes clear the issue with the current conjecture.
 \<close>

subsection\<open> Proof styles \<close>
text\<open>
In this section, we elaborate a little on the top-level proof styles (patterns) used
by Whiteside and Freitas.
\<close>
subsubsection\<open> Proof sketches - Whiteside \label{s:isa:bg:sketches}\<close>
text\<open>
The general method for proof used by Whiteside is akin to Wiedjik's formal proof 
sketches~\cite{Wiedijk02formalproof}. The main idea is to write all the main proofs in a declarative
style and start with a rough sketch and gradually fill it in. To construct the proof sketch,
Whiteside has in mind how the proof should go (either from intuition or a pencil and paper version)
and writes out the main steps (using the @{text "sorry"} command to omit the proof) . 
Then, the main steps should be combined to solve the goal using the default automation of Isabelle.
For example, a proof of a subgoal (that occurs in a few places) could be sketched as follows:
\<close>
(*<*)
notepad begin
  fix disjoint :: "nat set \<Rightarrow> nat set \<Rightarrow> bool" 
  fix locs_of :: "nat \<Rightarrow> nat \<Rightarrow> nat set"
  fix locs :: "(nat \<rightharpoonup> nat) \<Rightarrow> nat set"
  assume lems: "disjoint  (locs_of (l + s) (the (f l) - s))   (locs ({l} -\<triangleleft> f))"
(*>*)
have "disjoint  (locs_of (l + s) (the (f l) - s))   (locs ({l} -\<triangleleft> f))"
proof -    
  have "(locs_of (l + s) (the (f l) - s)) \<subseteq> locs_of l (the (f l))" (* SKETCH G1 *)
   sorry
  moreover have "disjoint (locs_of l (the (f l)))  (locs ({l} -\<triangleleft> f))" (* SKETCH G2 *)
   sorry
  ultimately show ?thesis (* SKETCH Conclusion + automation (perhaps with other lemmas *)(*<*) using lems(*>*)
  by auto
qed
(*<*)
end
(*>*)
text\<open>
This type of sketch is called a combinatory sketch, because all the facts introduced are combined
to solve the goal using the isabelle auto tactic. From inspection, it is clear that the sketched 
facts are enough to give the gist of the proof: to show @{term "A \<inter> B = {}"}, we note that
@{term "A \<subseteq> A'"} and that @{term "A' \<inter> B = {}"} (recall that two sets are @{text "disjoint"} if 
their intersection is empty). 

It is important to note that the proofs of the sketched elements may be arbitrarily complicated
and will often be solved with further sketches, but they may also be solved by automation.
The advantages of the sketching pattern is that it provides a clear route through the proof from
the outset; a disadvantage is that the `clear route' may lead up a blind alley if the, e.g.,
nth step is not valid and a lot of wasted time is spent on the n-1 prior steps. In practice this
doesn't occur much and when it does, the n-1 are usually useful in a revised sketch.
\<close>
subsubsection\<open> Sledgabelle - Freitas \<close>
text \<open>
This is as discussed in Section~\ref{SS-TP-isabelle-v1}.
\<close>

subsection \<open> VDM library \label{s:isa:bg:vdmmaps} \<close>

text\<open>
Our model of the heap is built upon the core VDM datatypes and operators: 
natural numbers, positive natural numbers, sets, and (finite, partial) 
maps. The Isabelle/HOL library already supports most of these concepts, but
in some cases we needed to define further operators. We needed to define
domain subtraction (or antirestriction) on maps, for example: 

@{thm[display] dom_antirestr_def[no_vars]}

\noindent and proved associated lemmas that would be considered part of a VDM Library,
such as the domain of an anti-restricted map:

@{thm[display] l_dom_dom_ar [no_vars]}  

which links some map operators to set operators.
The table in Figure~\ref{fig:vdmmapsstats} gives an overview of the 
VDM library. Each operator is shown, alongside its syntax, with the 
number of lemmas about it (as the root of the term tree) and the
number of times that lemmas about this operator were used in both
proof developments\footnote{Approximately.}.

\begin{figure}[hbtp]

\begin{center}
    \begin{tabular}{ | l | c | c | c | c |}
    \hline
      \textbf{Operator} & \textbf{Symbol} & \textbf{Number Lemmas} 
      & \textbf{Freitas Total} & \textbf{Whiteside Total}  
    \\ \hline
      Domain restriction      &  @{text "\<triangleleft>"}        & 15 & 15 & 28  
    \\ \hline
      Domain anti-restriction &  @{text "-\<triangleleft>"}       & 23 & 80 & 61  
    \\ \hline
      Map override            &  @{text "\<dagger>"}        & 22 & 54 & 20 
    \\ \hline
      Map union               &  @{text "\<union>m"}       & 24 & 71 & 39  
    \\ \hline
%      Map update              &  @{text "f[x \<mapsto>y]"} & 8 & Y & Z  
%    \\ \hline \hline
      \textbf{Total}          &                     & 92 & 220 & 148 
    \\ \hline
    \end{tabular}
\end{center}
\caption{The VDM Library in Isabelle}
\label{fig:vdmmapsstats}
\end{figure}

We note three important differences between VDM and the representation
in Isabelle/HOL:

\begin{enumerate}
\item Isabelle support partial functions is involved/limited, and not a basic concept,
like Z's set of pairs of VDM's primitive (partial maps) type. Thus, the partiality of maps is achieved using 
the \emph{option} datatype. Thus, elements of the map are
accessed using the special \emph{the} operator, for example:

@{thm[display] (concl) l_dom_r_singleton [no_vars]}

describes the result of domain restriction on a singleton set 
(under the assumption @{thm (prem 1) l_dom_r_singleton [no_vars]}).
@{term the} operator is used for accessing an actual value within a map.
That is, the domain element is known and we have a value. When map 
application happens on an element outside the domain, Isabelle returns @{term None},
a bottom element that totalises VDM maps in Isabelle.

\item Secondly, maps (and sets) are not necessarily finite. Thus, lemmas
about finiteness of composite maps are required, for example:
@{thm[display] (concl) k_finite_munion [no_vars]}
if @{thm (prem 1) k_finite_munion [no_vars]} and 
   @{thm (prem 2) k_finite_munion [no_vars]}.

\item Finally, there is no @{text "\<nat>\<^sub>1"} datatype in Isabelle. To get
around this, we define a predicate \emph{nat1} and extend it to operate on sets and maps 
(see Section~\ref{s:isa:models:level1} for the definitions on
sets and maps). 
%\marginpar{FIXME: intersperse text in latex environments with isabelle defs. 
%Currently it will fail the latex process.} DONE?
\end{enumerate}
\<close>
    definition 
      nat1 :: "nat \<Rightarrow> bool"
    where
     (*<*) [iff]: (*>*) "nat1 n \<equiv> inv_VDMNat1 n"

text\<open>
To make @{text "\<nat>\<^sub>1"} a type with access to non-linear arithmetic operators and
automation, one needs to instantiate that new type to various type classes,
hence effectively create an algebra for @{text "\<nat>\<^sub>1"}!

There is an important difference between the finiteness requirement and
the @{text "\<nat>\<^sub>1"} requirement. The finiteness is not part of the heap
model, per se, but required as preconditions for many standard Isabelle
lemmas that we need (defining \emph{sum-size}, for instance)\footnote{In VDM 
all sets (and maps) are finite by definition.}. On the other
hand, @{text "\<nat>\<^sub>1"} is very much a part of the model; this means that we
need to keep track of the VDM @{text "\<nat>\<^sub>1"} type by introducing predicates
in many places, resulting in a slightly messy specification and 
conditional VDM functions, such as:

\<close>


(*<*)
type_synonym Loc = nat
type_synonym F0 = "Loc set" 
(*>*)
definition 
  locs_of :: "Loc \<Rightarrow> nat \<Rightarrow> (Loc set)"
where
  "locs_of l n \<equiv> (if nat1 n then { i. i \<ge> l \<and> i < (l + n) } else undefined)" 
(*<*)

(*>*)
text\<open> 
which would not be required if we could specify:
\<close>
(*<*)
type_synonym nat1 = nat
(*>*)
definition 
  locs_of_nat1 :: "Loc \<Rightarrow> nat1 \<Rightarrow> (Loc set)"
where
  "locs_of_nat1 l n \<equiv>  { i. i \<ge> l \<and> i < (l + n) }" 

text\<open>
Using this definition, we would need to instantiate @{text "nat1"} through various type classes in
Isabelle, which was beyond what we wanted to do. 

These conditions add to the complexity of the proof somewhat, but we use Isabelle's automation
to reduce the burden considerably. The remaining effort is managable (both in terms of proof effort
and effort ensuring the model is correct) in a project of comparable size to the heap. However,
we expect that proper support for the VDM datatypes would be required for any larger model verification.

\<close>

subsection \<open> Summary \label{s:isa:bg:sum} \<close>
text\<open>
This section has introduced Isabelle, its proof languages, and tools for improving automation
and counterexample checking. We also discussed the VDM library that we built as part of the heap
case study. This library represents a considerable chunk of our proof effort (about 20\%) 
and was used extensively throughout the heap verification. Fortunately, these results are 
transferable to any other VDM model verification\footnote{Though, we note that this library is
expected to grow slightly as lemmas that we missed the first time round suggest themselves, and
because we only cover a few of the available VDM map operators}.
We have not yet built in any automation support---simplifier sets for example---for the library
as of yet. In the heap case study, all lemmas were explicitly specified when used, leading to a
larger proof, but with explicit data-flow which allowed us to collect some statistics about the 
proofs. For a concrete framework for VDM verification, finely tuned automation would considerably
ease the burden of proof.

Finally, in this section, we detailed the three main differences between Isabelle and VDM and our 
(or Isabelle's) techniques for bridging the difference. Again, for proper support for VDM 
verification in Isabelle, more permanaent support for the VDM datatypes, such as @{text "\<nat>\<^sub>1"} and
partial maps would
be required, but that is beyond the scope of this project. 
\<close>


section\<open> The models in Isabelle \label{s:isa:models} \<close> 

text\<open>
We now turn to the actual model of the heap as specified in Isabelle. The next section details
Level 0 (Section~\ref{s:isa:models:level0}), and Section~\ref{s:isa:models:level1} details Level 1,
as presented in Chapter~\ref{C-model-heap}. The justifications for the formalisation
are given when they are first introduced, and Section~\ref{s:isa:models:summary} summarises the
general transformation strategy. A detailed account of our naming conventions is provided in 
Appendix~\ref{A-nomenclature}.
\<close>

subsection \<open> Heap level 0 \label{s:isa:models:level0}\<close>
text\<open>  
In analogy with the VDM specification (see Section~\ref{S-model-pp-l0}), we first define some type
synonyms to represent locations and the state:
\<close>

type_synonym Loc' = nat
type_synonym F0' = "Loc' set" 

text\<open>
The auxiliary definitions of \emph{locs-of} (shown above) and \emph{is-block}
can then be defined with appropriate guards on any instances of the
@{text "\<nat>\<^sub>1"} type in VDM.
\<close>

definition is_block :: "Loc \<Rightarrow> nat \<Rightarrow> (Loc set) \<Rightarrow> bool"
where
	"is_block l n ls \<equiv> nat1 n \<and> locs_of l n \<subseteq> ls"

text 
\<open> 
The next step in specifying the model is to create definitions for the invariant, preconditions,
and post-conditions for each operation. We encode the finiteness requirement in Isabelle as an 
invariant on level 0 (note that this doesn't exist and is not required, since all sets are finite
in VDM).
 \<close>

definition 
  F0_inv :: "F0 \<Rightarrow> bool" 
where
 (*<*) [intro!]: (*>*)"F0_inv f \<equiv> finite f"

definition 
  new0_pre :: "F0 \<Rightarrow> nat \<Rightarrow> bool"
where
  "new0_pre f s \<equiv> (\<exists> l. (is_block l s f))"

definition
   new0_post :: "F0 \<Rightarrow> nat \<Rightarrow> F0 \<Rightarrow> Loc \<Rightarrow> bool"
where
   "new0_post f s f' r \<equiv> (is_block r s f) \<and> f' = f - (locs_of r s)"

definition 
   dispose0_pre :: "F0 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> bool"
where
  "dispose0_pre f d s \<equiv> locs_of d s \<inter> f = {}"

definition 
   dispose0_post :: "F0 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F0 \<Rightarrow> bool"
where
   "dispose0_post f d s f' \<equiv> f' = f \<union> locs_of d s"

text \<open> 
%\plannote{LF: inv for Fx needs to be checked everywhere it appears as a type. That's what VDM does.
%  Given our ``carefull'' translation, we avoid that by only checking it at the end. Should we say/talk about this?}
% IJW: I have added material about this at the end.

  As can be seen, the definitions are identical to the VDM specification, except
  that these definitions require all parameters to be explicitly provided. We now encode
  variants of the pre and postconditions where the inputs and state are implicit using locales.
  They make for an Isabelle theory that is closer to the VDM model and is also less repetitive.
      \<close>
(*<*)
lemmas F0_inv_defs        = F0_inv_def
lemmas new0_pre_defs      = new0_pre_def is_block_def locs_of_def
lemmas new0_post_defs     = new0_post_def is_block_def locs_of_def
lemmas dispose0_pre_defs  = dispose0_pre_def locs_of_def
lemmas dispose0_post_defs = dispose0_post_def locs_of_def
(*>*)

text
\<open> 
   VDM operations are defined using locales to keep hold of the state
   and its invariant as part of the locale assumptions, and similarly
   for inputs. Locales provide a uniform technique for packagaing together
   a VDM `operation'. The encoding is not perfect, however, because 
   post-conditions need to be specified separately (though, within the
   locale context).

   We use layered locales to avoid repetition of the state invariant
   across each operation of interest and to provide a natural context
   for the adaquecy proof (which is independent of the individual 
   operations). 
 \<close>

locale level0_basic =
   fixes f0 :: F0
   and   s0 :: nat
  assumes l0_input_notempty_def: "nat1 s0"
   and    l0_invariant_def     : "F0_inv f0"

text\<open>
    In @{const level0_basic}, we introduce the state @{term "f0::F0"} and an input 
    @{term "s0::nat"}, which corresponds to the size of the heap memory required to be allocated
    or disposed. Then, we ensure that the size is non-zero with a locale assumption (corresponding
    to the type in VDM) and the invariant representing finiteness. 
    %
    We consider @{prop l0_input_notempty_def} as an assumption because it is a property of the 
    input; the finiteness is an invariant because it is defined over the state.
    
    The actual VDM operations are then defined by locale extension and a definition for the
    postcondition:
    
 \<close>

locale level0_new = level0_basic +
   assumes l0_new0_precondition_def: "new0_pre f0 s0"

definition (in level0_new)
  new0_postcondition :: "F0 \<Rightarrow> nat \<Rightarrow> bool"
where
  "new0_postcondition f' r \<equiv> new0_post f0 s0 f' r \<and> F0_inv f'"

text\<open> 
  The locale @{const level0_new} extends the locale @{const level0_basic} with the 
  precondition, where the parameters have been supplied by the fixed variables for this
  level. Note there is no need to check the invariant for @{term "f0::F0"} at the 
  @{term "new0_precondition"}, since it is already stated as a locale assumption at @{const level0_basic}.
  The postcondition @{term "new0_postcondition"} is then specified in the context of the 
   @{const level0_new} (meaning all the fixed variables are available) and is defined to
   take two parameters:
   \begin{enumerate}
   \item The updated state @{term "f'::F0"};
   \item and, the result  @{term "r::nat"} that represents the start location for the allocated
   block.
   \end{enumerate}
   These two parameters are the variables to be existentially quantified when proving
   satisfiability (a.k.a feasibility) proofs for $NEW$.
   The definition consists of a conjunction of the @{term "new0_post"} definition, with the 
   appropriate parameters instantiated, and the invariant predicate on the updated state.
   %
   Note that an updated invariant condition is necessary and is hidden in a VDM operation
   specification (and appears when POs are generated, by Overture\footnote{See \url{http://www.overturetool.org}}, 
   for example), but must be manually added in Isabelle. 

   The dispose operation is similarly defined, additionally requiring an extra input variable:
   the start location @{term "d0 :: Loc"} of the block the add back to the heap, as in Chapter~\ref{C-model-heap}.
\<close>

locale level0_dispose = level0_basic +
    fixes d0 :: Loc
   assumes l0_dispose0_precondition_def: "dispose0_pre f0 d0 s0"

definition (in level0_dispose)
  dispose0_postcondition :: "F0 \<Rightarrow> bool"
where
  "dispose0_postcondition f' \<equiv> dispose0_post f0 d0 s0 f' \<and> F0_inv f'"

text 
\<open>
  Given totalisation and definedness of the VDM model here, only feasibility
  proof obligations per level are needed. These are also given as 
  definitions within the locale (where the fixed variables can be
  seen as universally quantified, and assumptions can be seen as assumption
  of the theorem).
\<close>

definition (in level0_new)
  PO_new0_feasibility :: "bool"
where
  "PO_new0_feasibility \<equiv> (\<exists> f' r' . new0_postcondition f' r')"

definition (in level0_dispose)
  PO_dispose0_feasibility :: "bool"
where
  "PO_dispose0_feasibility \<equiv> (\<exists> f' . dispose0_postcondition f')"

text\<open> 
  These PO definitions are the top-level goals to be discharged using Isabelle.
  We provide more details of the proof obligations in Chapter~\ref{C-isaproofs}.

  Finally, it is worth explaining that within the locale structure, we are actually
  proving the usual proof obligation setup, which would be more familiar if given
  outside the locale as:
\<close>

definition 
  PO_new0_fsb :: "bool"
where
  "PO_new0_fsb \<equiv> (\<forall> f s . F0_inv f \<and> nat1 s \<and> new0_pre f s \<longrightarrow> 
                        (\<exists> f' r' . new0_post f s f' r' \<and> F0_inv f'))"

definition
  PO_dispose0_fsb :: "bool"
where
  "PO_dispose0_fsb \<equiv> (\<forall> f d s . F0_inv f \<and> nat1 s \<and> dispose0_pre f d s \<longrightarrow> 
                        (\<exists> f' . dispose0_post f d s f' \<and> F0_inv f'))"

text\<open> 
  The locale based definitions are implied by the generic version, which universally
  quantify what is localy assumed. 
  
  These locale-based PO definitions are the top-level goals to be discharged using Isabelle.
  We provide more details of the proof obligations in Chapter~\ref{C-isaproofs}.
\<close>

(*<*)
(*------------------------------------------------------------------------*)
subsection \<open> Sledgehammered proof relating PO shapes \<close>
(*------------------------------------------------------------------------*)

text
\<open> Next lemmas show the relationship between the POs shaped with and
   without locales. This is just to clarify what is it we are doing 
   with them for the VDM POs. 

   Incidentally, why is it we need SMT for NEW0 and METIS for DISPOSE0?
\<close>

lemma (in level0_new)
  locale0_new_FSB_stronger: "PO_new0_fsb \<longrightarrow> PO_new0_feasibility"
by (smt l0_input_notempty_def 
        l0_invariant_def
        PO_new0_feasibility_def 
        PO_new0_fsb_def 
        new0_postcondition_def 
        l0_new0_precondition_def)

lemma (in level0_dispose)
  locale0_new_FSB_stronger: "PO_dispose0_fsb \<longrightarrow> PO_dispose0_feasibility"
by (metis PO_dispose0_feasibility_def 
          PO_dispose0_fsb_def 
          dispose0_postcondition_def 
          l0_dispose0_precondition_def 
          l0_input_notempty_def 
          l0_invariant_def)

(*------------------------------------------------------------------------*)
subsection \<open> Alternative coded proofs \<close>
(*------------------------------------------------------------------------*)

lemma (in level0_new)
  locale0_new_FSB_stronger_coded: "PO_new0_fsb \<longrightarrow> PO_new0_feasibility"
unfolding PO_new0_feasibility_def new0_postcondition_def PO_new0_fsb_def
apply (insert l0_invariant_def)
apply (insert l0_input_notempty_def)
apply (insert l0_new0_precondition_def)
unfolding new0_pre_def
apply (rule impI)
apply (erule_tac x="f0" in allE)
apply (erule_tac x="s0" in allE)
apply (erule exE)
apply safe
apply (rule_tac x=l in exI)
apply assumption
done

lemma (in level0_dispose)
  locale0_dispose_FSB_stronger_coded: "PO_dispose0_fsb \<longrightarrow> PO_dispose0_feasibility"
unfolding PO_dispose0_feasibility_def dispose0_postcondition_def PO_dispose0_fsb_def
apply (insert l0_invariant_def)
apply (insert l0_input_notempty_def)
apply (rule impI)
apply (erule_tac x="f0" in allE)
apply (erule_tac x="d0" in allE)
apply (erule_tac x="s0" in allE)
apply (erule impE)
apply (insert l0_dispose0_precondition_def)
apply safe
done

unused_thms

(*
lemmX (in level0_dispose) "False"
nitpick [show_all]
oops
lemmX (in level0_new) "False"
nitpick [show_all]
oops
*)

end
(*>*)
