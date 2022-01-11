(*<*)
theory HEAPProofsIsabelle
imports HEAP1ProofsIJW HEAP01ReifyProofsIJW
begin
(*>*)
(*chapter{*Proof Obligations in Isabelle*}*)

section{*Introduction*}

text{*

In this chapter, we describe the proof obligations and their proofs in Isabelle. For each of the
main proof obligations, we give a high-level overview of the proof in terms of informal proof 
strategies, including the `expert' 
motivations behind each proof step, corresponding to strategies and `whys' in Chapter~\ref{C-why}. 
 
%describing them with the help of the strategies discussed in Chapter~\ref{} and 
%Section~\ref{s:isa:proofs:summary}. We also include motivations for the proof steps taken. 

*}
section{*Feasibility  proofs \label{s:isa:po:fsb} *}
text{*
There are four feasibility proofs: one for each operation of each level. Level 0 POs
are trivial since there is no state invariant:~they involve basic set theory. Isabelle
can (almost) automatically discharge them. We just need to guide the necessary definition
unfoldings. Level 1 POs, on the other hand, are more interesting and we concentrate on them below. 
*}
subsection{*NEW 1 feasibility*}
text{*
The feasibility PO for the NEW operation states that (when all definitions have been unpacked):

@{term[display] "\<forall>f s. F1_inv f \<and> nat1 s \<and> (\<exists>l\<in>dom f. the (f l) \<ge> s) \<longrightarrow> 
   (\<exists>f' r. r \<in> dom f \<and>  ( ( the (f r) = s \<and> f' = {r} -\<triangleleft> f) \<or> 
   ( the (f r) > s \<and> f' = {r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s])) \<and> F1_inv f')"}

\noindent This is not dissimilar to expanding definitions from the general PO form given in Appendix~\ref{A-POs}.
The first thing to note is that the conclusion contains a disjunction and can be
rewritten to:

@{term[display] "\<forall>f s. F1_inv f \<and> nat1 s \<and> (\<exists>l\<in>dom f. the (f l) \<ge> s) \<longrightarrow> 
   (\<exists>f' r. r \<in> dom f \<and>  the (f r) = s \<and> f' = {r} -\<triangleleft> f \<and> F1_inv f') 
   \<or> 
   (\<exists>f' r. r \<in> dom f \<and>  the (f r) > s \<and> f' = {r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s] \<and> F1_inv f')
   "}

\noindent This can be seen as a semantics preserving transformation on the feasibility goal. It can be
proved as an identity to be applied. The reason (why) for performing this transformation, which we 
could call `distribute existentials over disjunctions' is because it is possible that each
part of the disjunction would need a slightly different witness. In fact, in this case, it is
pretty obvious that we might want to do this, since there are explicit single-point
instantiations for the existential on each part of the disjunction:
@{term "f' = {r} -\<triangleleft> f"}
and @{term "f' = {r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s]"}. In general, this is not the case
and the user may be required to provide a more subtle (non-deterministic) witness. 

In a larger example what usually happens is that some variables are one-point-ruled away, hence
constraining remaining existentialy quantified variables values to be given by the user in an 
explicit existential introduction step. Worse, depending on the layers of definitions used, the
disjunction might not be obvious. For instance, top-level feasibility POs in the Mondex case 
study~\cite{Freitas2008117} have over $1200$ existentially quantified variables too many predicates 
to count, of which $729$ explicit instantiation need to be provided by the user, if done naively. 
Careful consideration and attention to various layers of interest was
crucial to cope with the goal complexity. Identifying such proof intent (``why'' meta-data) would
guide our tools in the search for similar proof strategies for such goals.

Just choosing one side of the disjunction is going to lead us into 
difficulty, because of the @{term "the (f r) > s"} or @{term "the (f r) = s"} part of the goals. 
In the assumptions we have only @{term "the (f r) \<ge> s"}. This suggests a hidden case analysis 
on the $\leq$, leading to the revised goal (which is then split into two subgoals using 
disjunction elimination):

@{term[display] "\<forall>f s. F1_inv f \<and> nat1 s \<and> (\<exists>l\<in>dom f. the (f l) = s \<or> the (f l) > s) \<longrightarrow> 
   (\<exists>f' r. r \<in> dom f \<and>  the (f r) = s \<and> f' = {r} -\<triangleleft> f \<and> F1_inv f') 
   \<or> 
   (\<exists>f' r. r \<in> dom f \<and>  the (f r) > s \<and> f' = {r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s] \<and> F1_inv f')
   "}
which give us a natural choice of disjunct for introduction in each goal. 

We use the term ``hidden case distinction'' (another `why') here, because there is no explicit disjunction in the 
assumptions. Rather, we apply a lemma which states:

@{term[display] "(x\<ge>y) = (x=y \<or> x>y)"}

to make it clear. In general, we may need to apply some additional transformations or deeper
analysis to make clear the disjunction. Or, it may require a complicated theorem. 
In this case, we simply need to apply the intro tactic to deal with the universal quantifiers,
implication, and conjunctions to expose the new disjunction. The final step of the hidden case 
analysis is to apply disjunction elimination.
In the DISPOSE
operation there are two hidden case distinctions. We discuss this (reused) strategy further there.
We now have two subgoals:
\begin{enumerate}
\item The first goal we use disjunction introduction and choose to solve the equals case, 
instantiating $r$ as the $l$ in the assumptions and 
$f'$ as the appropriate one point witness i.e. @{term "f' = {r} -\<triangleleft> f"}
allows us to discharge the first two conjuncts of the goal trivially. The third --- the invariant 
--- is basically @{term "F1_inv({r} -\<triangleleft> f)"}, which unfolds as:

@{term[display] "Disjoint ({r} -\<triangleleft> f) \<and> sep ({r} -\<triangleleft> f) \<and> nat1_map ({r} -\<triangleleft> f) \<and> finite (dom ({r} -\<triangleleft> f))"}

under the assumption @{term "Disjoint f \<and> sep f \<and> nat1_map f \<and> finite (dom f)"}.

Attempting to solve one of these suggests the general structure of lemmas to solve them all:

@{thm[display] dom_ar_Disjoint[no_vars]}

where $s$ is a set of locations. The idea here is a strategy called invariant breakdown
\footnote{Could also be seen as a poor mans rippling} which conjectures lemmas about the 
invariant over the map operators. The idea being that it can be eventually broken down to
the extent where the assumption about the invariant on the original domain will hold.
The `why' for using this strategy is when the updated state is constructed from modifications
to the original (map operators in our case). This, of course, need not necessarily be the case, but
turns out to be true for all the operations in this case study, and is often the case in other
larger examples~\cite{Freitas2008117,Woodcock2008143,Butterfield2009219,FreitasW09}. 

Because we encoded the individual parts of our invariant as definitions, we can apply this strategy 
in a modular fashion for each of the four invariant parts. That is a key reason ``why'' having
zoom levels is useful:~the updated invariant without the zoom-layers of definitions would look like this:

@{term [display] "
    (\<forall>a\<in>dom ({r} -\<triangleleft> f). \<forall>b\<in>dom ({r} -\<triangleleft> f). a \<noteq> b \<longrightarrow> disjoint (Locs_of ({r} -\<triangleleft> f) a) (Locs_of ({r} -\<triangleleft> f) b)) \<and>
    (\<forall>l\<in>dom ({r} -\<triangleleft> f). l + the (({r} -\<triangleleft> f) l) \<notin> dom ({r} -\<triangleleft> f)) \<and>
    (\<forall>x. x \<in> dom ({r} -\<triangleleft> f) \<longrightarrow> nat1 (the (({r} -\<triangleleft> f) x))) \<and> finite (dom ({r} -\<triangleleft> f))"}

In a more complicated situation like the Mondex example, a naive full exapansion of the predicate goal
needs GB of memory loads of CPU time and 45 pages of A4! Creating this layers in examples like this is
vital. Here, it keeps proof repetition and drudgery to a minimum. It also aids our (still under
development) strategy matching algorithms with new goals given previously known/declared ``why''s.

The proofs of the lemmas for @{term "nat1_map ({r} -\<triangleleft> f)"} and
 @{term "finite (dom ({r} -\<triangleleft> f))"} are trivial; the other two are more complicated, but can still
be solved by Isabelle's automation and do not require any additional side conditions. In the 
development, these are represented as four lemmas @{thm[display] "dom_ar_nat1_map"[no_vars]} 
@{thm[display] "dom_ar_finite"[no_vars]}
@{thm[display] "dom_ar_Disjoint"[no_vars]} 
and @{thm "dom_ar_sep" [no_vars]}.

\noindent  For the map anti-restriction operation, we only require the @{term "P f"} assumption to 
show @{term "P (s -\<triangleleft> f)"}; in general,
subtle side-conditions may be required, which is where the work of this proof really lies.
Finally, we mention that Isabelle can prove these four lemmas automatically beased on the VDM Maps 
library that we have provided. More realistically, at first iteration, these goals served to shape
what kind of general map lemmas we needed!

\item For the second goal, we again use invariant breakdown. In this case, however, the updated state is
more complicated. As a result the invariant conditions are more complicated:

@{term[display] "Disjoint ({r} -\<triangleleft> f \<union>m [r + s \<mapsto> the (f r) - s])"}

Again, in this case, a single lemma suggests the approach for all the rest, 
under the assumption @{thm (prem 2) unionm_singleton_Disjoint [no_vars]}:

@{thm[display] (concl) unionm_singleton_Disjoint[no_vars]}

Now, this lemma is suggested in analogy with the previous sub-goal case. We can prove that
the assumption holds using the lemma from the first goal and our assumption. To prove this lemma,
we need extra conditions, however:

@{thm[display] (prem 1) unionm_singleton_Disjoint[no_vars]}

@{thm[display] (prem 3) unionm_singleton_Disjoint[no_vars]}

@{thm[display] (prem 4) unionm_singleton_Disjoint[no_vars]}

@{thm[display] (prem 5) unionm_singleton_Disjoint[no_vars]}

The first comes from the side condition that map union domains must be disjoint.
The second and third comes from the definition of @{term Disjoint}, which involves @{term "locs_of(x (the(f x)))"}
that requires the map is on @{text "\<nat>\<^sub>1"} range and the second argument being greater than zero.  
The final condition relates to the precondition of dispose, which is required in order
to make the state update under the invariant possible.

To show that these hold in the current proof obligation is relatively straightforward
and each can be solved by Isabelle's automation. To prove the lemma itself, on the other hand,
is not so straightforward. It needs case analysis and some detailed reasoning.

The \emph{sep} part of the invariant is similar to Disjoint and needs an analagous lemma 
albeit with different conditions, which are likewise mostly solved
by Isabelle's automation. Another part of the AI4FM project dealing with implicit strategies
hopes to develop techniques for learning analagous lemmas; we hope that we can utilise this approach
to suggest side-conditions. 
The invariant breakdown strategy provides a clear route through this
proof. Now, most of the work by an `expert' is in conjecturing the right conditions for the lemmas,
as well as any needed (VDM map) datatype general lemmas.
An alternative approach, though naive and cumbersome, would
be to include all global assumptions in the suggested lemma. Once the lemma has been proved (if it 
is valid) one can analyse for unused assumptions. Such a transformation has been suggested
by Whiteside as a proof refactoring~\cite{WhitesidePhD}. In this case study, we
attempted to gain an understanding of `why' the lemma was true to arrive at a natural set of 
assumptions (especially as we envisage it may be reused). Another important consideration in the 
specification of lemma conditions involves the `zoom-level' of the assumptions. For example, a 
lemma can be specified as\footnote{Isabelle represents chains of assumptions using @{text "\<lbrakk>A;B;C\<rbrakk> \<Longrightarrow> D"}
to mean $ A, B, C \vdash D$}:

@{term[display] "VDM_F1_inv f \<Longrightarrow> P({r} -\<triangleleft> f)"}

or 

@{term[display] "sep f \<Longrightarrow> Disjoint f \<Longrightarrow> P({r} -\<triangleleft> f)"}

\noindent which are equivalent, but the unfolding of @{text "VDM_F1_inv"} must occur at the 
top-level or in the proof of the lemma; similarly, we could decide to weaken the lemma by passing
a strong assumption (the full @{text "F1_inv"} for example) if we always expect it to be used in a
context where the invariant holds. 
\end{enumerate}
*}


subsection{* DISPOSE 1 feasibility*}
text{*

Far more complicated in appearance, but only requiring one new idea is the DISPOSE feasibility
proof.
The PO is as follows:

@{term[display] "(\<forall> f d s . F1_inv f \<and> nat1 s \<and> disjoint (locs_of d s) (locs f) \<longrightarrow> 
                  (\<exists> f' . f' = (dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) 
                 -\<triangleleft> f \<union>m [min_loc (dispose1_ext f d s) \<mapsto> HEAP1.sum_size (dispose1_ext f d s)] 
                \<and> F1_inv f'))"}

\noindent which, when the appropriate introduction rules and the one-point existential witness is 
supplied, is basically the following goal:

@{term[display] "F1_inv ( (dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) 
                 -\<triangleleft> f \<union>m [min_loc (dispose1_ext f d s) \<mapsto> HEAP1.sum_size (dispose1_ext f d s)] )"}

\noindent It is actually of the same shape as the second case for NEW feasibility (an anti-restricted map
extended with a singleton set). Pause to think how would this goal look like without the folded
definitions for @{term above} and @{term below}:

@{term[display] "F1_inv ((dom ({ x \<in> dom f . x + the(f x) = d } \<triangleleft> f) \<union> 
                          dom ({ x \<in> dom f . x = d + s } \<triangleleft> f)) -\<triangleleft> f \<union>m
                    [min_loc
                      (({ x \<in> dom f . x + the(f x) = d } \<triangleleft> f)
                          \<union>m 
                        ({ x \<in> dom f . x = d + s } \<triangleleft> f) 
                          \<union>m 
                         [d \<mapsto> s]) 
                     \<mapsto> 
                     HEAP1.sum_size
                        (({ x \<in> dom f . x + the(f x) = d } \<triangleleft> f) 
                            \<union>m 
                         ({ x \<in> dom f . x = d + s } \<triangleleft> f)
                            \<union>m
                         [d \<mapsto> s])])"}
*}
(*<*)
lemma "PO_dispose1_fsb" unfolding PO_dispose1_fsb_def dispose1_post_def --"apply auto"
apply (rule,rule,rule,rule,rule,rule,rule,rule,rule,rule,rule,rule,rule,rule,rule,rule) 
oops
(*>*)
text {*
\noindent It is clearly more difficult to spot such similarities with $NEW1$ without the
zoom layers around key concepts in formulae. Moreover, if we (naively) throw
Isabelle's heaviest tool (auto) at the goal, we would get 4 subgoals fitting a two page of A4!

Thus, the same invariant breakdown strategy \emph{could} be used here, using the lemmas that the 
expert conjectured for the $NEW1$ feasibility proof. However, we do not apply
this strategy just yet. The reason behind this is 
that there are two hidden case distinctions that significantly simplify
the proof obligations. These are on the shape of @{text "dispose1_below f d"} and 
@{text "dispose1_above f d s"}.
Recall the definitions:

@{thm[display] dispose1_below_def[no_vars]}

@{thm[display] dispose1_above_def[no_vars]}

\noindent The filtering equalities force @{term above} and @{term below} to 
either be empty or a singleton set. Thus, the top level strategy
here is to perform case analysis on these maps. For the case that both are empty, things simplify
out nicely (\textit{e.g.}~the 
anti restriction @{term[display] "(dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f"}
disappears because domain of empty is empty and subtracing empty is unit law for antirestriction).

We describe the technique for solving the case where @{text "dispose1_below f d = {}"} 
and @{text[display] "dispose1_above f d s \<noteq> {}"}. From the definition of @{text "dispose1_above"}
we know that it is a singleton with domain @{text "{d+s}"}. This also allows us to reason about
@{term "min_loc (dispose1_ext f d s)"} and @{term "sum_size (dispose1_ext f d s)"}. Recall the 
definition of @{text "dispose1_ext"}:

@{thm[display] dispose1_ext_def[no_vars]}

This means that we also know that the @{term "min_loc (dispose1_ext f d s) = d"}. 
We also know that @{term "sum_size (dispose1_ext f d s) = s + the (f (d+s))"}. Putting this 
information together, we get the proof obligation (for @{term sep}) as:

@{term[display] "sep ({d1 + s1} -\<triangleleft> f1 \<union>m [d1 \<mapsto> the (f1 (d1 + s1)) + s1])"}

\noindent which is considerably simpler. In order to expose this as the true proof obligation 
(under the case analysis), a strategy called we call \emph{shaping} (or directed substitution) is used. 
In a shaping strategy, subterms of the goal are proved to be equal to expert-supplied terms and 
substituted in to form the new (simpler) goal, under (locale) specific assumptions. 
In this case there are three shaping lemmas:

 @{term[display] "(dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) = {d+s}"}
@{term[display] "min_loc (dispose1_ext f d s) = d"}
and
@{term[display] "sum_size (dispose1_ext f d s) = s + the (f (d+s))"}

The same techniques apply to the other cases to get slightly different `shaped' lemmas.
At this point, with the shaped PO, we can begin the invariant breakdown strategy. As before, the
@{term nat1} and @{term finite} parts of the invariant are trivial. The difficulty is with 
@{text "sep"} and @{text "Disjoint"}.

For example, the side-conditions for @{thm[display] unionm_singleton_sep [no_vars]} are:
\begin{enumerate}
\item @{term "d1 \<notin> dom ({d1 + s1} -\<triangleleft> f1)"}, which is easy to solve by automation.
\item @{term "sep ({d1 + s1} -\<triangleleft> f1)"} is solved by further application of invariant breakdown
using the before-state invariant hypothesis (@{term "F1_inv f"}).
\item @{term "nat1 (the (f1 (d1 + s1)) + s1)"}, which is straightforward for automation to solve.
\item @{term "\<forall>l\<in>dom ({d1 + s1} -\<triangleleft> f1). 
        l + the (({d1 + s1} -\<triangleleft> f1) l) \<notin> dom [d1 \<mapsto> the (f1 (d1 + s1)) + s1]"},
   which requires some work.
\item @{term "d1 + (the (f1 (d1 + s1)) + s1) \<notin> dom ({d1 + s1} -\<triangleleft> f1)"}, which also requires effort.
\end{enumerate}

The last two generated subgoals correspond to showing that a) there is no chunk of memory in the
free store that touches the start (domain) of the singleton to be added; and, b) the last element
in the singleton does not touch any start locations in the free store (i.e. the following element
must not be in the domain). That is to say, adding this new element to the map
really does keep it separate: it does not touch anything on either end. 
It is at this point that Freitas introduced a new concept called
@{text "sep0"} that gave a uniform definition for reasoning about this concept. 
In Whiteside's development, however, these subgoals were solved manually. In retrospect, 
a definition to refer to the loction straight after a chunk of memory may have clarified these
conditions e.g. @{term "after s f = s + the (f s)"} would simplify the first tricky condition to:

@{term "\<forall>l\<in>dom ({d1 + s1} -\<triangleleft> f1). 
       after l ({d1 + s1} -\<triangleleft> f1) \<notin> dom [d1 \<mapsto> the (f1 (d1 + s1)) + s1]"}

For this condition, the goal comes down to showing that for any @{term "l \<in> dom f"} 
we have @{term "l + the (f1 l) \<noteq> d1"}\footnote{Or @{term "after l f1 \<noteq> d1"}.}. 
This is because we can rewrite membership of a singleton
domain as an equality and because if @{term "l + the (f1 l) \<noteq> d1"} then 
@{term "l + the (({d1 + s1} -\<triangleleft> f1) l) \<noteq> d1"} and we assume that @{term "l \<noteq> d1+s1"}.
Now, since we are under the assumption that @{text "dispose1_below f d = {}"} and
since @{thm dispose1_below_def[no_vars]}, the result follows easily.

For the final goal, the sep part of the invariant allows us to conclude that
@{term "(d1 + s1) + the (f1 (d1+s1)) \<notin> dom f1"}, which implies that  
@{term "(d1 + s1) + the (f1 (d1+s1)) \<notin> dom ({d1 + s1} -\<triangleleft> f1)"} since the antirestricted domain
is a subset of the full domain; we can conclude by simple associative/commutative-rewriting with plus.
For the other cases, where @{text "dispose1_above f d s \<noteq> {}"} etc, we follow exactly the same
strategies, with minor differences, but with loads of drudgery (e.g. about 3/4 of the proof script)
and fewer, if any, new ideas needed.
*}

section{*Level 0 and level 1 reification \label{s:isa:po:reification} *}
text{*
The next set of proof obligations are the reification proof obligations between levels 0 and 1.
There are three types of proof obligation:
\begin{itemize}
\item Adaquecy: shows that there is a level 1 state to match every level 0 state
(and such that the invariant holds). Because the retrieve is a function, it also
means such chosen link between types in this case is unique.
\item Widen-precondition:~concrete assumptions must be the same as or weaker than abstract assumptions.
\item Narrow-postcondition:~concrete commitments must be the same as or stronger than abstract commitments.
\end{itemize}

\noindent 
They justify the change in datatype representation by keeping models between levels compatible.

\subsection{Adequacy}
The proof obligation is 
@{term "\<exists>! f1. (f0 = retr0 f1 \<and> F1_inv f1)"}
(where the uniqueness isn't required, but we have it anyway as we can prove it). The goal states
that the retrieve function linking the two state representations is unique and satisfy the concrete invariant.
The top level strategy for this proof is a custom induction rule applied to @{term "f0"}
that operates on finite, contiguous, non-abutting sets. The rule looks like

@{thm[display] contig_nonabut_finite_set_induct [no_vars]}

\noindent and is provided and proved by the expert.
Then, the empty case is simple to prove: the required witness for @{term "f1"} is the
empty map. For the step case, we need to show, under the induction hypotheses:

@{term [display] "F = retr0 f1hook"}

@{term [display] "F1_inv f1hook"}

@{term [display]  "contiguous F'"}

@{term [display] "non_abut F F'"}

\noindent that

@{term [display] "\<exists>!f1. F \<union> F' = retr0 f1 \<and> F1_inv f1" }

\noindent The key observation is to apply the witnessing strategy
with the appropriate value of a witness. In this case, we do
not have a one-point rule that makes it clear. Instead, the
expert has to provide it:

@{term [display]  "f1 = (f1hook \<union>m [Min(F') \<mapsto> card F'])"}

\noindent As a justification for pulling this witness out of the air,
 recall the definition of the retrieve function:

@{thm [display]  retr0_def [no_vars]}

\noindent and note that it is a reasonable `intuition', perhaps, that this
conjecture is true:

@{term[display] "locs(f \<union>m g) = locs f \<union> locs g"}

\noindent therefore we just need to show that:

@{term [display]  "F = locs (f1hook)"}

\noindent and 

@{term [display]  "F' = locs ([Min(F') \<mapsto> card F'])"}

The first is precisely the induction hypothesis. For the second subgoal,
we conjecture that @{term "F' = locs_of (Min F') (card F')"}, which is 
intuitively true. Recall that the cardinality of a set is the number of elements
and the @{text "Min"} function in Isabelle returns the minimum element of a finite set.
Thus, @{term "locs_of (Min F') (card F')"} gives us a contiguous set of length @{term "card F'"}
starting from @{term "Min F'"}.

Recall the induction assumption states that @{text "F'"} is contiguous 
(as defined by @{thm contiguous_def}),
and allows us to solve the goal (since the @{text "locs"}
of a singleton is simply @{text "locs_of"}).
This leaves us with two lemmas to prove (with possible side-conditions):
\begin{enumerate}
\item @{term "locs (f \<union>m g) = locs f \<union> locs g"}. Actually, we proved a more specific lemma:

@{thm[display] (concl) locs_unionm_singleton[no_vars]}

\noindent which just requires the assumption @{thm[display] (prem 3) locs_unionm_singleton[no_vars]}
to ensure the map union is well-formed. The proof of this lemma is a straightforward piece of 
algebraic reasoning. Unfolding the definition of locs, we get a union of all @{text "locs_of"} over
the domain of the map:

@{term[display]  "locs(f \<union>m [x \<mapsto> y]) = (\<Union>s\<in>dom (f \<union>m [x \<mapsto> y]). locs_of s (the ((f \<union>m [x \<mapsto> y]) s)))"}

\noindent Now, we can easily show that the @{term "dom (f \<union>m [x \<mapsto> y]) =  insert x (dom f)"}, and then
that:

@{term[display] "(\<Union>s\<in> insert x (dom (f)). locs_of s (the ((f \<union>m [x \<mapsto> y]) s))) =
                   (locs_of x (the ((f \<union>m [x \<mapsto> y]) x))) 
                  \<union> (\<Union>s\<in>dom (f). locs_of s (the ((f \<union>m [x \<mapsto> y]) s)))"}
\noindent where the second union is simply @{term "locs f"} and we are done.

\item @{term "contiguous F' \<Longrightarrow>  locs_of (Min F') (card F') = F'"}  is solved with the help
of two lemmas: one showing that @{term "Min (locs_of m l) = m"} and the other that
@{term "card (locs_of m l) = l"}. Both these lemmas are proved by a simple induction on l.
\end{enumerate}

Both these lemmas allow us to conclude the first part of the proof. The overall idea of this part
of the proof was to translate the @{text "\<union>m"} operator to @{text "\<union>"} and show that both sides
were equal in:

@{term [display]  "F \<union> F' = locs(f1hook \<union>m [Min(F') \<mapsto> card F'])"}

The next step is then to show that the invariant holds. That is:

@{term[display] "F1_inv (f1hook \<union>m [Min F' \<mapsto> card F'])"}

To solve this goal, we break down the definition and solve each individual invariant part
separately. We take @{term "sep (f1hook \<union>m [Min F' \<mapsto> card F'])"} as an example, and we 
follow the same invariant breakdown strategy as both the feasibility proof 
obligations (a map union extending a map with a singleton map). 
The two difficult side conditions for this invariant breakdown require effort. For example,
one has to prove that:

@{term[display] "Min F' + card F' \<notin> dom f1hook"}

\noindent We show this by a contradiction. Why do we try proof by contradiction here? Because of
the @{text "\<notin>"}, certainly\footnote{One might reasonably question why we didn't try proof
by contradiction in the equivalent step in the feasibility POs?}. The contradiction constructed
uses the abuttedness property of the induction rule:

@{term [display] "non_abut F F'"}

where 

@{thm [display] non_abut_def[no_vars]}

First, we know that @{text "l1 = "}@{term "Min F' + card F' - 1 \<in> F'" } and that
@{text "l2 = "}@{term "Min F' + card F' \<in> dom f1hook"} and that @{term "dom f1hook \<subseteq> F"}
therefore @{term "Min F' + card F' \<in> F"}. Now, by non-abuttedness, we know that
@{term "l1 + (1::nat) < l2 \<or> l2 + 1 < l1"}, but this is a contradiction since @{term "l1 + (1::nat) = l2"}. 

\noindent 
To prove the (optional) uniqueness of the retrieve function, we 
use the theorem

@{thm[display] locs_unique[no_vars]}

\noindent which states that under the invariant equality of the locations implies equality of the
maps.
*}

subsection{* Widen-precondition \label{S-proofs-widen} *}
text{*
For the NEW operations, the widen precondition proof requires us to show
that if the NEW0 precondition holds then the NEW1 precondition holds:

@{thm[display] PO_l01_new_widen_pre_def}

\noindent which unfolds to saying (under additional preconditions) 
if @{term "\<exists> l. is_block l s1 (retro f1)"} then @{term "\<exists> l \<in> dom f1 . the(f1 l) \<ge> s1"}.
That is, if there is a block in the set of locations defined by the retrieve
function, then there is an element in the map that
has a size large enough. It is tempting to assume that the $l$ gained from existential elimination
on the assumption is the one required as the witness in the conclusion, but this is not the case
since there is no way to prove that @{term "l \<in> dom f"}. This was the first attempt at 
solving this proof and the incorrentess of the proof step showed itself immediately.
Rather, the approach is more subtle: one has to maneuvere the goal to find the
appropriate witness. The proof sketch used by Whiteside is as follows:

*}
(*<*)notepad begin
fix l s1 f1
(*>*)
have locs_subset: "locs_of l s1 \<subseteq> locs f1"
    sorry --"Show that the locations are indeed with the free space" 
then have "l \<in> locs f1" 
  sorry --"Specifically, the first element is in it" 
then have "l \<in>  (\<Union>s\<in>dom f1. locs_of s (the (f1 s)))"
  sorry --"Unfold the definition of locs"
then have "\<exists> m\<in> dom f1. locs_of l s1 \<subseteq> locs_of m (the (f1 m))"
  sorry --{* Show that @{text "locs_of l s1"} must be contained in \textbf{one} other @{text "locs_of"} *} 
then obtain m where mindom: "m\<in>dom f1" and (* First thing I need *)
              locssubm: "locs_of l s1 \<subseteq> locs_of m (the (f1 m))"
  sorry --"Then find an arbitrary m that contains the locations from l" 
then have mgrs1: "s1 \<le> the (f1 m)" 
  sorry --{* Show that s1 must be @{text "s1 \<le> m"} *}
(*<*)
end
(*>*)
text{*
Note that the two facts @{text "mindom"} and @{text "mgrs1"} defined in the sketch\footnote{Recall
the discussion about proof sketching in Section~\ref{s:isa:bg:sketches}.} are
exactly what is required to solve the goal. Most of the intermediate steps in this sketch are
easily solved by automation. The final step requires extra work, as does showing:

@{term[display] "\<exists> m\<in> dom f1. locs_of l s1 \<subseteq> locs_of m (the (f1 m))"} 

\noindent which is proved as a lemma that depends precisely on the invariant (requiring nested 
proof by contradictions). Before describing this final part of the proof, we consider the `why' behind the above sketch.
It is directly motivated by the original failed proof: we know that the locations are in the free 
store, and by the invariant, they must be within one other (possibly larger) set of locations. The
bad assumption initially was simply that they were taken from the front of a set (@{term "l\<in>dom f"}).
Thus, we really needed to find the domain element (\textit{i.e.}~witnessing), 
then show that its range is greater than or equal to $s1$.

To show this requires another hidden case analysis that is hinted at in the 
preconditions: either $l=m$ or $l<m$. In fact, our case analysis
simply is on equals or not equals. 
 For the equals 
case, we have a lemma

@{thm[display] locs_of_subset_range[no_vars]}

\noindent and that does the job for us.
For the not equals case, we first show that @{term "m < l"}
by contradiction, since if this is true then l would not be in the locations, 
but we have already shown that it is.
After we have established this fact, we use another lemma

@{thm[display]  locs_of_subset_range_gr[no_vars]}

\noindent which is similar (analagous) to the previous case, and this 
completes the proof.

The dispose case is trivial since the preconditions are identical (once
the retrieve function has been unfolded to @{term locs}.

*}

subsection{* Narrow postcondition *}
text{*

The narrow postcondition proof obligations state that if the post condition
holds at level 1 then it will also hold at level 0 under the retrieve 
function. That is, for $NEW1$ is states that if @{term "new1_post f1 s1 f1' r"} then

@{term[display]  "new0_post (retr0 f1) s1 (retr0 f1') r"}

\noindent We start by unfolding the $NEW1$ post condition, whcih
is a disjunction (the equals case or the greater than case). This gives us
an explicity case split. For each case we need to show the two
parts of the $NEW0$ postcondition holds as:

@{term[display] "is_block r s1 (locs f1)"}

\noindent and

@{term[display] "locs f1' = locs f1 - locs_of r s1"}

\noindent where the @{term "locs f1'"} corresponds to the updated free store.
The first subgoal is straightforward. For the second goal, we have
the assumption that @{term  "f1' = {r} -\<triangleleft> f1"} and so we use the 
@{text "dom_ar_locs"} lemma to rewrite the $locs(f1')$ as:

@{thm[display] dom_ar_locs[no_vars]}

\noindent The second case is more difficult but follows the same pattern:
@{term[display]  "f1' = {r} -\<triangleleft> f1 \<union>m [r + s1 \<mapsto> the (f1 r) - s1]"}

\noindent and we
rewrite the locs of this using two lemmas. To complete the proof simply requires some algebraic 
manipulation and discharging the side-conditions, \underline{which is mostly automatable???}.

For the dispose operation, the proof follows a similar technique.
Instead of the case distinction on the postcondition (using an explicit
disjunction) we have case analysis on @{term below} and @{term above} being the @{term empty} map. 
Then, for each of the case we apply the same locs distribution lemmas as for new,
perform algebraic manipulations, and discharge side-conditios. This is one of 
the longest proofs in the level 1, but requires the least thought!

%\plannote{LF: what's the thm below about? Also, this section and previous is very dry/hard to follow
%  I think more explanation on the Isabelle as well as the meaning of various parts is crucial to make
%  the point of resuability of strategies come across nicely. IJW? what would you say?}

%I see this is just a high-level description of the proofs that we can refer to in further papers
tht properly discuss the strategies and reusability. 
*}

section "Summary"

text{*
We have formalised level 0 and level 1 of the VDM model and their reification, including all
of the generated proof obligations. We further satisfied ourselves of the validity 
of the model by proving various indentities that we 
expected to exist in the model: so-called `sanity checks'.

Furthermore, we performed two parallel proof attempts. Freitas leveraged his experience
in the Z method and the Z/Eves theorem prover~\cite{Saaltink97,freitas2004proving},  % ?FreitasWoddc08}, 
and pursued a traditional, procedural tactic-based style of proof\footnote{In fact, Freitas has also 
formalised the heap store in Z. See Appendix~\ref{A-zeves} and model evolution discussion in
Chapter~\ref{C-model-evolution}.}.
%
Whiteside, who comes from the Isar school of Isabelle proof~\cite{Wenzel02}, took a declarative, 
forwards approach to the proof obligations that was centered around proof sketches: high-level
proof steps that solve the problem, but have \emph{gaps} that must gradually be filled in. 
%
Our goal in pursuing parallel, stylistically different proof attempts was to understand more
clearly how different experts would proceed and to gather additional data on the strategies 
employed. We wish to find if proof ideas (whys) transcend the details of a proof language 
and if particular patterns of proof have instantiations in different styles.

The result is an interesting story: broadly speaking, the proofs have the same \emph{idea}, or
\emph{why}, but often diverge in some critical places. This divergance is mostly due to 
the proof language's style itself. In one proof, for example, Whiteside has a case distinction over the
DISPOSE post-condition for proving the invariant holds on the updated state, resulting in an
easy to understand proof; Freitas, on the other hand, introduces a specific lemma which crunches 
the case distinction by having complex side-conditions, losing understandability but shortening
the proof considerably.
%
In other cases it is the expert taking a different approach. For example, one `expert' (Freitas) 
introduces a new concept that simplifies (and makes clearer)
the \emph{sep} part of the invariant proofs. In a final example, Whiteside uses expert knowledge of
the proof situation to eliminate a complicated case distinction.
%

The Isabelle formalisation of the heap store also provided a compelling example of the need for
formalisation, throwing up several issues with our original VDM model and requiring modifications
to the model to be made. In several cases, the changes were trivial (a `+ 1' removed, for example);~the
NEW post-condition required a fairly substantial change. This chapter will not dwell on our
failings, however, and we will only describe the final, correct 
model\footnote{Chapter~\ref{C-model-evolution} discusses the evolution of the model.}. 
We will, however, reiterate that we did not make any changes to the model to `ease' the proofs 
through: the levels of the model document design decisions only.  

Issues regarding VDM's logic of partial functions and handling of 3-valued logic (undefined) values
were handled with care, but informally. They should not be of concern for this problem, certainly not
for our goals (of finding general proof strategies). They would be of concern for a general translation
strategy from VDM to Isabelle.

%Comment about translation requiring invariants placed manually everywhere.
*}
(*<*)
end
(*>*)
