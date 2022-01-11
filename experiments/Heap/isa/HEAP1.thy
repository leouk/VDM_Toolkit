(* $Id$ *)
(*<*)
theory HEAP1
imports HEAP0 
begin
(*>*)
subsection \<open> Heap level 1 \label{s:isa:models:level1}\<close>

text\<open> 

 Firstly, we define a type type synonym for the state of the free store
 at level 1 to be a map from locations to sizes:
\<close>

type_synonym F1 = "Loc \<rightharpoonup> nat"

subsubsection\<open> Auxillary functions \label{s:isa:models:level1:aux} \<close>

text\<open>
Note that the size is only @{type nat} here so, as mentioned earlier, we must extend the 
@{const nat1} predicate to operate on maps and sets to ensure that the model is consistent
with VDM:
\<close>

definition 
  nat1_map :: "F1 \<Rightarrow> bool"
where
  "nat1_map f \<equiv> (\<forall> x. x \<in> dom f \<longrightarrow> nat1 (the (f x)))"

definition
  nat1_set :: "(nat set) \<Rightarrow> bool"
where
  "nat1_set S \<equiv> (\<forall> x. x \<in> S \<longrightarrow> nat1 x)"

text\<open> 
The level 1 model introduces a new auxiliary function, \emph{locs}
that returns the set of all free locations withing a given map. We define the \emph{locs} 
function using a union over the elements in the domain of the VDM map. 
It is wrapped inside a conditional expression, however,
in order to ensure that the map is appropriately a @{text nat1_map}:
\<close>

definition 
  locs :: "(Loc \<rightharpoonup> nat) \<Rightarrow> Loc set "
where
  "locs sm \<equiv> (if nat1_map sm then 
                \<Union> s \<in> dom sm. locs_of s (the (sm s)) 
               else 
                 undefined)" (* TODO: or {}?*)

text\<open> 
  It is otherwise @{term undefined}, which is a polymorphic constant in Isabelle.
  That is, the VDM model uses a total map to @{text "\<nat>\<^sub>1"}, whereas here we can only
  use a map to @{text "\<nat>"} as a parameter. Thus, we totalise the definition of @{term locs}
  by giving it a bottom element (as Isabelle's @{term undefined}) when the expected type fails. 
  
  It is important to emphasise this is not VDM's notion of undefinedness. For instance, it is
  possible to prove that @{lemma "undefined=undefined" by simp} in Isabelle, which is not true 
  in VDM's three-valued logic. Thus, @{term undefined} should never feature in our proofs. If it
  does, it means we made some mistake somewhere by applying a function to the wrong type. For 
  further discussion on the subtleties of handling partial functions, see 
 \cite{Jones95e,SchmalzPhD}.
\<close>

subsubsection\<open> Invariant \<close>
text\<open>
\noindent Recall the level 1 invariant in Section~\ref{S-model-pp-l1}:


\begin{vdm}
\rtype{Free1}{\mapof{Loc}{\Nati}}{
      (f) \DeF \\
\forall*{l, l' \in \dom{f}}{l \neq l' \Implies is-disj(locs-of(l, f(l)), locs-of(l', f(l'))) \And} \\
\forall{l \in \dom{f}}{(l + f(l) ) \notin \dom{f}}
}
\end{vdm}

It contains two components (a conjunction):
\begin{itemize}
\item \emph{Disjoint}: that the locations defined by each element in the 
map are disjoint;
\item and, \emph{sep}: that the locations defined by elements do not
abut on any end.
\end{itemize}

\noindent We encode these as individual definitions in Isabelle: \<close>
(*<*)
definition
  Locs_of :: "F1 \<Rightarrow> Loc \<Rightarrow> (Loc set)"
where
  "Locs_of f l \<equiv> (if (l \<in> dom f) then 
                    locs_of l (the (f l))
                  else
                    undefined)"  (* TODO: or {}? *)

definition 
  disjoint :: "'a set \<Rightarrow> 'a set \<Rightarrow> bool"
where
 "disjoint A B \<equiv> A \<inter> B = {}"
(*>*)

definition 
  Disjoint :: "F1 \<Rightarrow> bool"
where
 "Disjoint f \<equiv> 
      (\<forall> a \<in> dom f. \<forall> b \<in> dom f . a \<noteq> b \<longrightarrow> disjoint (Locs_of f a) (Locs_of f b))"

definition 
  sep :: "F1 \<Rightarrow> bool" 
where
  "sep f \<equiv> (\<forall> l \<in> dom f . l + the(f l) \<notin> dom f)"

text\<open>
\noindent where @{term "disjoint A B"} is the same as @{term "A \<inter> B = \<emptyset>"}, and 
@{term "Locs_of f a"} is the same as @{term "locs_of a (the(f a))"}.

Albeit trivial, this decomposition into separate concepts is invaluable in taming
the goal complexity during proofs (see discussion in Section~\ref{S-TP-exp}). They
create what we call ``zoom'' levels of interest/discourse. For instance, we create
various lemmas about these definitions and their relationship with, say @{term locs_of}
and @{term locs} or set theory and map operators. So, in actual POs, these issues
of mechanisation are already distilled and resolved.  

We must also, however, have additional components to the invariant.
They are the implicit VDM notion of finiteness of maps and sets, and the
subtype checking on map range type for @{text "\<nat>\<^sub>1"}.

\begin{itemize}
\item \emph{nat1\_map}: that the state doesn't contain any 
locations that map to size 0.
\item \emph{finite domain}: that the domain of the map is finite, similarly to level 0 state.
\end{itemize}

\noindent Thus, the invariant definition is as follows:
 \<close>

definition 
  F1_inv :: "F1 \<Rightarrow> bool" 
where
(*<*)  [intro!]:  (*>*) "F1_inv f \<equiv> Disjoint f \<and> sep f \<and> nat1_map f \<and> finite(dom f)"

definition 
  VDM_F1_inv :: "F1 \<Rightarrow> bool" 
where
  "VDM_F1_inv f \<equiv> Disjoint f \<and> sep f "
 
text\<open>
\noindent We also define the VDM invariant, as we may wish to discharge the
Isabelle parts the invariant first (finiteness etc), as they are often
simpler. We provide a lemma to `shape' the goal as such:

%\plannote{LF: IJW, didn't follow underline above. Isn't it the other way roung? I.e. VDM_F1_inv 
%is harder to prove than the other trivial bits?}
%IJW: I've reworded this. I agree: I was trying to say the conditions that arise from the translation
%is simpler.
\<close>
lemma invF1_shape: "nat1_map f \<Longrightarrow> finite (dom f) \<Longrightarrow> VDM_F1_inv f\<Longrightarrow> F1_inv f"
unfolding F1_inv_def VDM_F1_inv_def by simp

text\<open>
\noindent Such proof decomposition is again essential for automation and proof strategy reuse,
as it informs (meta-)data collection (see Chapter~\ref{C-why} on meta-data and 
Chapter~\ref{C-isaproofs} on Isabelle proofs).

Furthermore, we define introduction and elimination rules
to help unfold the invariant; we also provide weakening rules 
for the case that only one part of the invariant is required
(we only show the @{term sep} version here):
\<close>
(*<*)
lemma invVDMF1[intro!]: "sep f \<Longrightarrow> Disjoint f \<Longrightarrow> VDM_F1_inv f"
 unfolding VDM_F1_inv_def by simp
(*>*)
lemma invF1E[elim!]: "F1_inv f \<Longrightarrow> (sep f \<Longrightarrow> Disjoint f \<Longrightarrow> nat1_map f \<Longrightarrow> finite (dom f) \<Longrightarrow> R) \<Longrightarrow> R"
 unfolding F1_inv_def by simp

lemma invF1I[intro!]: "sep f \<Longrightarrow> Disjoint f \<Longrightarrow> nat1_map f \<Longrightarrow> finite (dom f) \<Longrightarrow> F1_inv f"
 unfolding F1_inv_def by simp

lemma invF1_sep_weaken: "F1_inv f \<Longrightarrow> sep f"
  unfolding F1_inv_def by simp
(*<*)
lemma invF1_Disjoint_weaken: "F1_inv f \<Longrightarrow> Disjoint f"
  unfolding F1_inv_def by simp

lemma invF1_nat1_map_weaken: "F1_inv f \<Longrightarrow> nat1_map f"
  unfolding F1_inv_def by simp

lemma invF1_finite_weaken: "F1_inv f \<Longrightarrow> finite (dom  f)"
  unfolding F1_inv_def by simp
(*>*)
(*
text\<open> 
  Weakening rules are for both forward and backward reasoning and is part of our armory
  of proof patterns. 

%  \plannote{LF: I am seeing these comments on proof patterns scattered around various parts of text.
%  This is okay, yet I am worried reader won't get a cohesive understanding of what they are about.
%  Perhaps at least a section somewhere summarising them, and a pointer to the other TR/paper? Comments?}
\<close>
*)
(* More unnecessary stuff *)
(*<*)
(*------------------------------------------------------------------------*)
subsection \<open> Alternative definitions \<close>
(*------------------------------------------------------------------------*)

definition
  Locs_of2 :: "F1 \<Rightarrow> Loc \<Rightarrow> (Loc set)"
where
  "l \<in> dom f \<Longrightarrow> nat1 (the(f l)) \<Longrightarrow> Locs_of2 f l \<equiv> locs_of l (the (f l))"

definition 
  Disjoint2 :: "F1 \<Rightarrow> bool"
where
 "Disjoint2 f \<equiv> 
      (\<forall> a \<in> dom f. \<forall> b \<in> dom f . a \<noteq> b \<longrightarrow> 
        disjoint (locs_of a (the(f a))) (locs_of b (the(f b))))"

(*code_type F1(Scala)*)

(*========================================================================*)
section \<open> VDM function definitions \<close>
(*========================================================================*)
(*>*)

subsubsection\<open> NEW operation\<close> 
 
text\<open> 
Following the style of level 0 in Section~\ref{s:isa:models:level0}, we create definitions
for the pre and post-conditions for the operations. We split 
the NEW post-condition into two separate definitions, corresponding to each disjunct 
in the VDM operation. Again, this is useful for proof decomposition within POs and also
to help identify hidden case analysis, another of our proof patterns.
\<close>

definition 
  new1_pre :: "F1 \<Rightarrow> nat \<Rightarrow> bool"
where
  "new1_pre f s \<equiv> (\<exists> l \<in> dom f . the(f l) \<ge> s)"

definition
   new1_post_eq :: "F1 \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> Loc \<Rightarrow> bool"
where
   "new1_post_eq f s f' r \<equiv> r \<in> dom f \<and> the(f r) = s \<and> f' = {r} -\<triangleleft> f"

definition
   new1_post_gr :: "F1 \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> Loc \<Rightarrow> bool"
where
   "new1_post_gr f s f' r \<equiv> r \<in> dom f \<and> the(f r) > s \<and> 
                            f' = ({r} -\<triangleleft> f) \<union>m [r + s \<mapsto> the(f r) - s]"

definition
   new1_post :: "F1 \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> Loc \<Rightarrow> bool"
where
   "new1_post f s f' r \<equiv> new1_post_eq f s f' r \<or> new1_post_gr f s f' r"


subsubsection\<open> DISPOSE operation \<close>
text\<open>
Before showing the locale definitions corresponding to the $DISPOSE1$
operation, we create auxiliary definitions for dispose. The way these came
about is discussed in Section~\ref{S-TP-exp}. First are the
two auxilliary functions called \emph{sum\_size} and \emph{min\_loc}
which are used in the postcondition are defined using Isabelle's operators
for set minimal and summation, respectively.
\<close>
definition
   min_loc :: "(Loc \<rightharpoonup> nat) \<Rightarrow> nat"
where
   "min_loc sm = (if sm \<noteq> Map.empty then 
                      Min (dom sm) 
                  else 
                      undefined)" 

definition 
  sum_size :: "(Loc \<rightharpoonup> nat) \<Rightarrow> nat"
where
  "sum_size sm = (if sm \<noteq> Map.empty then 
                      (\<Sum> x\<in>(dom sm) . the (sm x)) 
                  else 
                      undefined)" (*TODO: or 0? *)
text\<open>
Once again, we used Isabelle's @{term undefined} to enable a total function over a subtype,
as we did for @{term locs}.

We have two versions of the postconditions: the exact translation from 
the VDM specification and a version where \emph{above}, \emph{below}, and \emph{ext}
are given as definitions. The latter definition makes proof more straightforward
since we can refer to the maps by name and unfold where necessary. We do, of course,
prove both definitions equivalent. This is another example of zooming:~the use of
different levels of interest in involved operators, that is based on the problem at hand,
and is useful in helping proof decomposition and lemma discovery for higher automation.
\<close>
definition 
   dispose1_pre :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> bool"
where
  "dispose1_pre f d s \<equiv> disjoint (locs_of d s) (locs f)"

definition 
   dispose1_post :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> bool"
where
   "dispose1_post f d s f' \<equiv> 
      (\<exists> below above ext . 
        below = { x \<in> dom f . x + the(f x) = d } \<triangleleft> f \<and>
        above = { x \<in> dom f . x = d + s } \<triangleleft> f \<and>
        ext   = (above \<union>m below) \<union>m [d \<mapsto> s] \<and>
        f' = ((dom below \<union> dom above) -\<triangleleft> f) \<union>m ([min_loc(ext) \<mapsto> sum_size(ext)]))
      "

  
(*
text\<open> 
As explained in Section~\ref{S-TP-exp}, we modelled $DISPOSE1$ postcondition in various ways.
When we came to the Isabelle representation we encountered a few problems because of the VDM
model use of map comprehension for the definition of $DISPOSE1$. In Isabelle, map comprehension
isn't directly available. Thus, to model @{text below} as in the VDM

\begin{vdm} 
\begin{formula}
    below= \map{ l \mapsto f(l) | l \in \dom{f} \And l + ~{f}(l) = d}  
\end{formula}
\end{vdm}

\noindent we would need map comprehension in Isabelle. At first we tried something like this

@{term "map_of [ (x, the(f x)) . x \<leftarrow> sorted_list_of_set (dom f), l + (the(fhook x)) = d]"}

Although it does represent the map comprehension we need, it is rather protracted, 
unecessarily complates proof, as well as automation. That is because of the many type jumps
between generator as a set (@{term "dom f"}) that gets transformed into a list for the list
comprehension term that is given to a recursive function (@{term "map_of"}), which translates
a given list to an Isabelle map. 

This\footnote{And also discussion/suggestions within/from the Isabelle users mailing list} led
us to rethink the definition using available operators and avoiding map comprehension leading to
the current VDM as 

\begin{vdm} 
\begin{formula}
    below= \set{ l | l \in \dom{f} \And l + ~{f}(l) = d} \dsub f  
\end{formula}
\end{vdm}

\noindent It avoid map comprehension and uses domain filtering (or restriction), 
which was easier to encode in Isabelle as: 
\<close>     
*)
text\<open>
In our alternative formulation, the three existential variables are given as definitions, for example:
\<close>
definition 
  dispose1_below :: "F1 \<Rightarrow> Loc \<Rightarrow> F1"
where
  "dispose1_below f d \<equiv>  { x \<in> dom f . x + the(f x) = d } \<triangleleft> f" 

text\<open>
 \noindent These encoding considerations are crucial to ensure proofs are not complicated by
 technicalities unrelated to the problem. One must not, however, fall for the temptation to 
 chisel the model into whatever the theorem prover would be happier with. Our modification 
 is clearly equivalent, and can be proved as such if that's the case, we we have done for the
 layered definition of dispose with respect to the original one.

% \plannote{LF: Should we prove the map comprehension version equals the one with domain restriction?}
% Shouldn't mention it.

The other two definitions are:
\<close>

definition 
  dispose1_above :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F1"
where
  "dispose1_above f d s \<equiv>  { x \<in> dom f . x = d + s } \<triangleleft> f" 

definition 
  dispose1_ext :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F1"
where
  "dispose1_ext f d s \<equiv>  (dispose1_above f d s  \<union>m dispose1_below f d) \<union>m [d \<mapsto> s] "

text\<open>
\noindent which allows us to write and prove:
\<close>
definition 
   dispose1_post2 :: "F1 \<Rightarrow> Loc \<Rightarrow> nat \<Rightarrow> F1 \<Rightarrow> bool"
where
   "dispose1_post2 f d s f' \<equiv> 
        (f' = ((dom (dispose1_below f d) \<union> dom (dispose1_above f d s)) -\<triangleleft> f) 
        \<union>m ([min_loc(dispose1_ext f d s) \<mapsto> sum_size(dispose1_ext f d s)]))"
                  
(*<*)
lemmas F1_inv_defs = F1_inv_def Disjoint_def nat1_def
                     Locs_of_def sep_def nat1_map_def
                        disjoint_def locs_of_def

lemmas new1_pre_defs      = new1_pre_def 
lemmas new1_post_defs     = new1_post_def new1_post_eq_def new1_post_gr_def
lemmas dispose1_pre_defs  = dispose1_pre_def disjoint_def nat1_def
                            locs_def nat1_map_def locs_of_def
lemmas dispose1_post_defs = dispose1_post_def 

lemmas dispose1_post2_defs = dispose1_post2_def dispose1_below_def 
							 dispose1_above_def dispose1_ext_def
(*>*)

lemma dispose1_equiv:
	"dispose1_post f d s f' = dispose1_post2 f d s f'"
unfolding dispose1_post_defs dispose1_post2_defs
by auto


(*========================================================================*)
subsubsection \<open> VDM operation definitions and feasibility goals \<close>
(*========================================================================*)

text\<open>
Finally, we put everything together in locales and construct definitions
relating to the feasibility proofs. As with level 1, we encode the shared inputs,
state, assumptions and invariant in a separate locale:
\<close>
locale level1_basic =
   fixes f1 :: F1 (* State  0 \<mapsto> 12, 12 \<mapsto> 4 *)
   and   s1 :: nat (* Size!!! *)
  assumes l1_input_notempty_def: "nat1 s1" (* Type info *)
   and    l1_invariant_def     : "F1_inv f1" (* Invariant on initial state *)

text\<open>
The individual operations are then specified as localte extensions and the post-conditions
are given as definitions within the locale:

\<close>

locale level1_new = level1_basic +
   assumes l1_new1_precondition_def: "new1_pre f1 s1"

locale level1_dispose = level1_basic +
    fixes d1 :: Loc
   assumes l1_dispose1_precondition_def: "dispose1_pre f1 d1 s1"

definition (in level1_new)
  new1_postcondition :: "F1 \<Rightarrow> nat \<Rightarrow> bool"
where
  "new1_postcondition f' r \<equiv> new1_post f1 s1 f' r \<and> F1_inv f'"

definition (in level1_dispose)
  dispose1_postcondition :: "F1 \<Rightarrow> bool"
where
  "dispose1_postcondition f' \<equiv> dispose1_post f1 d1 s1 f' \<and> F1_inv f'"

definition (in level1_dispose)
  dispose1_postconditionpsg :: "F1 \<Rightarrow> bool"
where
  "dispose1_postconditionpsg f' \<equiv> dispose1_post2 f1 d1 s1 f' \<and> F1_inv f'"

(*<*)
locale level1_complete = level1_new + level1_dispose

(*========================================================================*)
section \<open> VDM proof obligations for level 1 \<close>
(*========================================================================*)
(*>*)

text\<open>
As in level 0, the feasibility proof operations are encoded as definitions as follows:
\<close>
definition (in level1_new)
  PO_new1_feasibility :: "bool"
where
  "PO_new1_feasibility \<equiv> (\<exists> f' r' . new1_postcondition f' r')"

definition (in level1_dispose)
  PO_dispose1_feasibility :: "bool"
where
  "PO_dispose1_feasibility \<equiv> (\<exists> f' . dispose1_postcondition f')"

definition (in level1_dispose)
  PO_dispose1_feasibilitypsg :: "bool"
where
  "PO_dispose1_feasibilitypsg \<equiv> (\<exists> f' . dispose1_postconditionpsg f')"



subsection\<open> Summary \label{s:isa:models:summary} \<close>

text\<open>
The translation from VDM to Isabelle is relatively straightforward and faithful to the 
original model. Operations in VDM have a fairly natural translation to Isabelle's locale
module system, where definitions can be used for the post-condition. It is future work to build
a VDM package on top of Isabelle that would enable a syntactic emulation of VDM operations, thus
reducing the chance of a human error in the translation (we, for example, forgot the invariant 
on our first iteration). 
%
While our strategy of packaging up preconditions, postconditions, and the invariants in 
definitions makes for additional proof steps, it ensures a comparmentalised proof and constructs
explicit `zoom' levels to have a clear domain of discourse.
%
Additionally, our naming scheme makes it relatively straightforward to pick a definition `from the
air' and have it be the right one, an oft overlooked but crucial requirement when models become 
large.
%
%
The next section details the Isabelle proofs of the proof obligations for the above model, 
including:
\begin{itemize}
\item Feasibility proofs for both operations for both levels;
\item Adaquecy proof for the reification;
\item Widen-precondition for both operations;
\item Narrow-postcondition for both operations;
\item Sanity proofs that state that, for example, $\mathit{DISPOSE(NEW) = Id}$.
\end{itemize}
\<close>


(*<*)
(* EXAMPLE HERE!!! *)

definition 
  PO_new1_fsb :: "bool"
where
  "PO_new1_fsb \<equiv> (\<forall> f s . F1_inv f \<and> nat1 s \<and> new1_pre f s \<longrightarrow> 
                        (\<exists> f' r' . new1_post f s f' r' \<and> F1_inv f'))"

definition
  PO_dispose1_fsb :: "bool"
where
  "PO_dispose1_fsb \<equiv> (\<forall> f d s . F1_inv f \<and> nat1 s \<and> dispose1_pre f d s \<longrightarrow> 
                        (\<exists> f' . dispose1_post f d s f' \<and> F1_inv f'))"

unused_thms

(*
lemmX (in level1_dispose) "False"
nitpick [show_all]
oops
lemmX (in level1_new) "False"
nitpick [show_all]
oops
*)
(* NOTE: Nitpick trick to see if any axiom involved in the locales is inconsistent.
         i.e. if axioms are inconsistent, then we shouldn't be able to find a mode
         for False. If we do, then the axioms are conistent (i.e. it's unprovable 
         as it should be).
 *)

end
(*>*)