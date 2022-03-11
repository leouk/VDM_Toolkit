(*<*)theory NimFull 
imports VDMToolkit
        "~~/src/HOL/Library/While_Combinator"
Smart_Isabelle.Smart_Isabelle "~~/src/HOL/Eisbach/Eisbach"
begin(*>*)
section \<open> Introduction \<close>

text\<open> 
  This theory file is a manual translation of the corresponding Overture VDM model. 
  You are expected to read this document whilst playing with the theory file
  in Isabelle and Overture. 
\<close>
(*************************************************************************)
section \<open> Imports \<close>

text \<open>
  \begin{vdmsl}[breaklines=true]
  module NimFull
  imports from IO		 functions  println	renamed println;
                                --printf  renamed printf;
                                print		renamed print
  exports all
  definitions 
  \end{vdmsl}

   We use \texttt{VDMSeq.thy}, which
  contains various auxiliary functions translating VDM sequences into Isabelle lists. The 
  \texttt{While\_Combinator.thy} theory provides a while-like operator for the main game play. 
  Moreover, we are not translating the auxiliary IO functions, which are just for Overture model debugging.
\<close>

(*************************************************************************)
section \<open> VDM values \<close>

text \<open> Values are trivial: we add them as @{term abbreviation}s. Notice that we would need
  to add invariants here about @{typ \<nat>}.  \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
values

MAX_PILE: nat1 = 20;
MAX_MOV: nat1 = 3;
\end{vdmsl}
\<close>

abbreviation 
  MAX_PILE :: VDMNat1 where "MAX_PILE \<equiv> 20"
abbreviation
  MAX_MOV  :: VDMNat1 where "MAX_MOV \<equiv> 3"

definition
  inv_MAX_PILE :: "\<bool>"
where
  "inv_MAX_PILE \<equiv> inv_VDMNat1 MAX_PILE"
  
definition
  inv_MAX_MOV :: "\<bool>"
where
  "inv_MAX_MOV \<equiv> inv_VDMNat1 MAX_MOV \<and> MAX_MOV < MAX_PILE"

text \<open> Remember the implicit invariant, from requirements, that @{term "MAX_MOV < MAX_PILE"},
  otherwise a player could play to loose from the beginning. This was not in the Overture Module
  because we gave explicit values, which implied this invariant. \<close>
(*
consts
  G_MAX_PILE :: VDMNat
  G_MAX_MOV :: VDMNat

definition
  inv_G_MAX_PILE :: \<bool>
where
  "inv_G_MAX_PILE \<equiv> nat1 G_MAX_PILE"
*)

text \<open>
  The fixing of values was just for the benefit of animating the model in overture. All that
  we really cared about was the axiom (given) that these constants should be @{typ \<nat>}$_1$, and that 
  move limit cannot be the whole pile. 
\<close>

axiomatization 
      G_MAX_PILE :: "VDMNat" 
  and G_MAX_MOV :: "VDMNat"
where
      (*<*) n1_MP [simp]: (*>*) "G_MAX_PILE > 0"
  and (*<*) n1_MM [simp]: (*>*) "G_MAX_MOV > 0"
  and (*<*) n1_MPMM[simp]: (*>*)"G_MAX_MOV < G_MAX_PILE"

text \<open> Another important observation is the colour code Isabelle uses for \textbf{known}, 
  \textcolor{blue}{\textbf{free}} and \textcolor{green}{\textbf{bound}} variables. For example,
  in the predicate
  
  @{term[display] "\<forall> e \<in> elems s . e > 0"}
  
  the (\textbf{black}) name @{term elems} is known (i.e. previously defined), @{term s} 
  (\textcolor{blue}{\textbf{blue}}) is free (i.e. externally given),
  and @{term e} (\textcolor{green}{\textbf{green}}) is bound 
  (i.e. defined locally in the context of the universal quantifier).
  \<close>
  
(*************************************************************************)
section \<open> VDM types \<close>

(*-----------------------------------------------------------------------*)
subsection \<open> Player \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
types 

-- leave fair play out of game types for simplicity; 
-- include it in the game play algorithm instead
Player = <P1> | <P2> ;
\end{vdmsl}
\<close>

text \<open> VDM enumerated types can be declared as Isabelle data type constants. All that matters 
  is that @{term "P1 \<noteq>  P2"} and that those are the only values of type @{term Player}. \<close>

datatype Player = P1 | P2

definition
  inv_Player :: "Player \<Rightarrow> \<bool>"
  where
  "inv_Player p \<equiv> True"

(*-----------------------------------------------------------------------*)
subsection \<open> Move \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
Move = nat1
inv m == m <= MAX_MOV;
\end{vdmsl}
\<close>

text \<open> We use @{term type_synonym} for VDM types, where type invariants must be explicitly 
  declared as boolean-valued functions. Note in this case, we also add the invariant about @{typ \<nat>}$_1$,
  which says that @{term "m > (0::nat)"} and is defined in theory \texttt{VDMBasic.thy} 
  imported through \texttt{VDMSeq.thy}. \<close>

type_synonym Move = "VDMNat1"

definition
  inv_Move :: "VDMNat1 \<Rightarrow> \<bool>"
where
  "inv_Move m \<equiv> inv_VDMNat1 m \<and> m \<le> MAX_MOV"  

value "inv_Move 3"
value "inv_Move 5"

text \<open> I label initial versions of specification later found to be problematic
  through failed proof with a trailing $0$. I keep versions here for the sake of
  exposition of how mistakes can happen and what to do about them. The difference
  is that the first version uses a quantifier instead of @{term inv_SeqElems}.

  Unfortunately, that necessarily complicates the underlying explanation. Remember
  that you are expected to read this document whilst playing with the theory file
  in Isabelle and Overture. 
\<close>

type_synonym Moves0 = "Move VDMSeq"

(* nth s i = s ! i (Isabellem, zero based)
   s $ i = s(i)    (VDM in Isabelle, one based *)

value "([10,11,12,20]::Moves0) ! 1"

value "([10,11,12,20]::Moves0) $ 1"

value "[1,1,2,10]::Moves0"

definition
  inv_Moves0 :: "Moves0 \<Rightarrow> \<bool>"
  where
  "inv_Moves0 m \<equiv> \<forall> i \<in> inds m . inv_Move (m $ i)"

value "inv_Moves0 [1,1,2,1,2,3]"

definition
  inv_Moves0_new :: "Moves0 \<Rightarrow> \<bool>"
  where
  "inv_Moves0_new m \<equiv> inv_SeqElems inv_Move m"
   (* [1,2,3] \<longrightarrow> inv_Move 1 \<and> inv_Move 2 \<and> inv_Move 3 *)

lemma "inv_Moves0_new s = inv_Moves0 s"
  unfolding inv_Moves0_new_def inv_Moves0_def 
  apply (induct s, simp_all)
  apply (simp add: inv_SeqElems_def)
  oops

find_theorems "inv_SeqElems _ _" 

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Useful lemmas about $Move$ invariant: \<close>

text \<open> 
  Proof steps noted with ``\textsf{--SH}'' were discovered with the automated
 proof tool called \textsf{sledgehammer}. If Isabelle knows ``enough'' information
 about newly defined concepts, it often discovers proofs. Identifying what
 ``enough'' means in context is part of the challenge. 
\<close>

lemma l_inv_Move_nat1 : 
  "inv_Move m \<Longrightarrow> 0 < m"
unfolding inv_Move_def inv_VDMNat1_def by simp 

text \<open>
  \begin{enumerate}
    \item every move $m$ is @{typ \<nat>}$_1$: 

    @{thm[display] l_inv_Move_nat1}
  \end{enumerate}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> @{term sum_elems} function \<close>

text\<open>
Isabelle requires declaration before use, hence to define the @{term inv_Moves} we must have
previously defined @{term sum_elems}. 

\begin{vdmsl}[breaklines=true]
functions 

sum_elems: seq of Move -> nat
sum_elems(s) == 
	cases s:
		[]     -> 0,
		[x]^xs -> x + sum_elems(xs)
	end
post
 	-- if someone played, then sum is not zero
	s <> [] <=> RESULT > 0
measure sum_elems_measure;

sum_elems_measure: seq of Move -> nat
sum_elems_measure(s) == len s;

\end{vdmsl}
\<close>

text\<open> The sum of moves is defined recursively on the length of the list. 
Like in VDM, pattern matching is used. In Isabelle you must define a pattern
for every @{term datatype} constructor. For lists they are empty and cons as in VDM. 
We also need to explicitly add the precondition about its type invariant implicitly
checked by Overture. 
Isabelle infers a measure function automatically in most cases.

Notice that @{term sum_elems} operate over sequence of $Move$ rather than
the type @{term Moves}. That is important because the invariant of $Moves$
is defined using @{term sum_elems}. If @{term sum_elems} signature involved
$Moves$, its type invariant would have been called, hence leading to a loop.
Overture sadly falls short of a good  error message. 

Isabelle does not does not check type invariants and requires declaration before use. 
 When pre/post are not declared in Overture, we need to define them in order to ensure
types are properly checked. 

\<close>

declare [[show_types]]
fun
  sum_elems :: "(Move VDMSeq) \<Rightarrow> VDMNat"
where
  (*<*) sum_elems0 [intro!]: (*>*) "sum_elems [] = 0"
| (*<*) sum_elemsI [intro!]: (*>*) "sum_elems (x # xs) = x + (sum_elems xs)"
(* The funny annotations give explicit names for each equation, and instructs Isabelle tools. 
   The commented bracket tells LaTeX not to typeset this in final PDF. *)
(* using list.exhaust apply blast+ done *)

(*<*)
theorem " \<forall> s . inv_SeqElems inv_Move s \<longrightarrow> 
       (\<exists> r . inv_SeqElems inv_Move s \<and> inv_VDMNat r \<and> (s \<noteq> [] \<longleftrightarrow> 0 < r))" 
by (meson inv_VDMNat_def linear not_less not_numeral_le_zero)
(*>*)

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Useful lemmas  \<close>

(*
lemma l_sum_elems_nat: "inv_SeqElems0 inv_Move s \<Longrightarrow> 0 \<le> sum_elems s"
apply (induct s)
apply simp_all
unfolding inv_SeqElems0_def
apply (subgoal_tac "\<forall>e\<in>elems s. inv_Move e")
prefer 2
apply (simp add: elems_def)
apply simp
apply (erule_tac x=a in ballE)
unfolding elems_def apply simp_all (* SH *)
unfolding inv_Move_def inv_VDMNat1_def apply simp_all (* SH *)
(* let's simplify the proof *)
oops
*)

lemma l_sum_elems_nat: 
  "inv_SeqElems inv_Move s \<Longrightarrow> 0 \<le> sum_elems s"
unfolding inv_SeqElems_def
apply (induct s, simp_all)
using l_inv_Move_nat1 by fastforce (* SH *)

lemma l_sum_elems_nat1: 
  "inv_SeqElems inv_Move s \<Longrightarrow> s \<noteq> [] \<Longrightarrow> 0 < sum_elems s"
  apply (induct s)
  apply simp_all                        (* need a lemma about inv_SeqElems inv_Move (x # xs) *)
   (*apply (simp add: l_inv_SeqElems_Cons) need a lemma about inv_Move x *)
  apply (frule l_sum_elems_nat) 
  apply simp                            
txt \<open> @{subgoals[display,indent=0]} This finishes the proof but I want 
  to have it discovered by \textsf{sledgehammer}.
\<close>
oops

lemma l_sum_elems_nat1: 
  "inv_SeqElems inv_Move s \<Longrightarrow> s \<noteq> [] \<Longrightarrow> 0 < sum_elems s"
unfolding inv_SeqElems_def 
apply (induct s)
apply simp
proof -
  fix a :: "\<int>" and s :: "\<int> list"
  assume a1: "list_all inv_Move (a # s)"
  assume a2: "\<lbrakk>list_all inv_Move s; s \<noteq> []\<rbrakk> \<Longrightarrow> 0 < sum_elems s"
  have f3: "\<And>x1 e_x. sum_elems x1 + e_x = sum_elems (e_x # x1)" by (simp add: add.commute)
  have "\<And>x1. sum_elems [x1] = x1" by simp
  thus "0 < sum_elems (a # s)" using a1 a2 f3 by (metis (no_types) add_mono_thms_linordered_field(5) l_inv_Move_nat1 list.pred_inject(2) monoid_add_class.add.right_neutral)
qed 
(*by (metis NimFull.sum_elems0 NimFull.sum_elemsI add_mono_thms_linordered_field(5) l_inv_Move_nat1 list.pred_inject(2) monoid_add_class.add.right_neutral)*)
(*by (smt inv_SeqElems_def l_inv_Move_nat1 l_sum_elems_nat list.pred_inject(2) sum_elems.elims)*)
(*by (metis add.right_neutral add_le_cancel_left inv_SeqElems_def 
    l_sum_elems_nat le_less list.pred_inject(2) 
    not_less sum_elems.elims) (* SH *) 
  by (smt inv_SeqElems_def l_inv_Move_nat1 l_sum_elems_nat list.pred_inject(2) sum_elems.elims) SLOW *)

lemma l_sum_elems_notempty: 
  "inv_SeqElems inv_Move s \<Longrightarrow> 0 < sum_elems s \<Longrightarrow> s \<noteq> []" by auto (* SH *)

text \<open>
  \begin{enumerate}
    \item sum of elements for a sequence of $Move$ is @{typ \<nat>}: @{thm[display] l_sum_elems_nat}
    \item sum of elements for a non empty sequence of $Move$ is @{typ \<nat>}$_1$: @{thm[display] l_sum_elems_nat1}
    \item non-empty sequence when sum of elements is @{typ \<nat>}$_1$: @{thm[display] l_sum_elems_notempty}
  \end{enumerate}
\<close>
(*<*)thm l_sum_elems_nat l_sum_elems_nat1 l_sum_elems_notempty(*>*)

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_sum_elems :: "Move VDMSeq \<Rightarrow> \<bool>"
where
  "pre_sum_elems s \<equiv> inv_SeqElems inv_Move s" 
  (*"\<forall> e \<in> elems s . inv_Move e" --"inv_SeqElems inv_Move s"*)

definition
  post_sum_elems :: "Move VDMSeq \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
  "post_sum_elems s RESULT \<equiv> 
      pre_sum_elems s \<longrightarrow> 
      (inv_VDMNat RESULT \<and>
       (s \<noteq> [] \<longleftrightarrow> RESULT > 0))"

lemma "\<forall> s . pre_sum_elems s \<longrightarrow> (\<exists> r . post_sum_elems s r)" 
by (metis inv_VDMNat_def le_cases n1_MP not_le post_sum_elems_def)

lemma PO_sum_elems_obl: "\<forall> s . pre_sum_elems s \<longrightarrow> (post_sum_elems s (sum_elems s))"
by (metis NimFull.sum_elems0 inv_VDMNat_def l_sum_elems_nat1 le_less less_irrefl post_sum_elems_def pre_sum_elems_def) 

text \<open> Useful properties about @{term sum_elems} specification. \<close>

lemma l_pre_sum_elems: 
  "inv_SeqElems inv_Move s \<Longrightarrow> 0 < sum_elems s \<longleftrightarrow> s \<noteq> []"
using l_sum_elems_nat1 by auto (* SH *)
  
lemma l_pre_sum_elems_sat: 
  "pre_sum_elems s \<Longrightarrow> 0 < sum_elems s \<longleftrightarrow> s \<noteq> []"
unfolding l_sum_elems_nat1 pre_sum_elems_def by (simp add: l_pre_sum_elems) (* SH *)

text \<open> These (trivial) intermediate results help us ensure that @{term sum_elems} 
  specification is satisfiable by helping Isabelle \textsf{sledgehammer} find proofs \<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Example PO: auxiliary function satisfiability \<close>

text \<open>
  Next, we illustrate the general PO setup for @{term sum_elems}. For instance, 
  the theorem  for the explicitly defined @{term sum_elems} function is:
  
  @{term[display] "\<forall> s . inv_SeqElems inv_Move s \<longrightarrow> pre_sum_elems s \<longrightarrow> post_sum_elems s (sum_elems s)"}

  That is, given any valid input value (@{term "inv_SeqElems inv_Move ms"}), if the pre condition holds,
  so ought to hold the post condition. We use a definition to declare such statements as conjectures 
  and then try to prove them as theorems.

 \textcolor{red}{\textbf{Notice that if explicit definitions are given, there is no choice for
 witness for the proof obligation!}} That is, the commitment in the model presented by the 
 explicit definition (\textit{e.g.}~@{term expr}) must feature in the proof. This will be
 particularly interesting in the proof below about @{term best_move}, where the general case is provable, whereas
 the one with the initial explicit definition of @{term best_move} is not. 
 \textcolor{red}{\textbf{That is, the specification is feasible for some implementation but not
 the one given by the explicit definition!}}  
\<close>      

definition
  PO_sum_elems_sat_obl :: "\<bool>"
where
  "PO_sum_elems_sat_obl \<equiv> \<forall> s . inv_SeqElems inv_Move s \<longrightarrow> 
      pre_sum_elems s \<longrightarrow> (\<exists> r . post_sum_elems s r)"

definition
  PO_sum_elems_sat_exp_obl :: "\<bool>"
where
  "PO_sum_elems_sat_exp_obl \<equiv> \<forall> s . inv_SeqElems inv_Move s \<longrightarrow> 
      pre_sum_elems s \<longrightarrow> post_sum_elems s (sum_elems s)"

lemma PO_sum_elems_sat_exp_obl
by (metis NimFull.sum_elems0 PO_sum_elems_sat_exp_obl_def inv_VDMNat_def l_pre_sum_elems_sat le_less post_sum_elems_def)

text \<open> We first prove the goal manually, followed by \textsf{sledgehammer} discovered proofs,
  given the lemmas created below. \<close>

theorem PO_sum_elems_sat_obl
  unfolding PO_sum_elems_sat_obl_def post_sum_elems_def pre_sum_elems_def
  apply safe
  apply (rule_tac x="sum_elems s" in exI)
  apply safe
    apply (simp add: l_sum_elems_nat inv_VDMNat_def)
by (simp add: l_pre_sum_elems)+

theorem PO_sum_elems_sat_obl
by (metis PO_sum_elems_sat_obl_def inv_VDMNat_def 
    l_pre_sum_elems_sat leD linear post_sum_elems_def) (* SH *)

theorem PO_sum_elems_sat_exp_obl
by (simp add: PO_sum_elems_sat_exp_obl_def inv_VDMNat_def 
              l_pre_sum_elems l_sum_elems_nat post_sum_elems_def) (* SH *)

(*-----------------------------------------------------------------------*)
subsection \<open> Moves \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
Moves = seq of Move
inv s == 
	-- you can never move beyond what's in the pile
	sum_elems(s) <= MAX_PILE
	and
	-- last move is always 1, when moves are present, at the end of the game
	(sum_elems(s) = MAX_PILE => s(len s) = 1)
\end{vdmsl}
\<close>

text \<open>
  Because @{term Moves} depends on @{term sum_elems}, it must be declared after it. Moreover,
  its invariant uses sequence application ($s(len s)$), which will need adjustment (see values example below).
  \textsf{value} and \textsf{lemma} commands can be used to explore the space of options
  and whether the expression you type does what you want.

  In Isabelle, list application is defined as @{term "s ! i"}. But remember that Isabelle's 
  lists are indexed from $0$, whereas VDM sequences are indexed from $1$. 
  Check  our version of sequence application operator (e.g. in VDM $s(x)$, in 
  Isabelle @{term "applyVDMSeq s x"}), particularly when called outside the bounds of the sequence.
\<close>

value "[a,b] ! 0"                       
value "[a,b] ! 1"
value "[a,b] ! 2"
value "[a,b] ! nat (len [a,b])"
value "[a,b] ! nat (len [a,b] - 1)"
value "[a,b] $ (len [a,b])"

type_synonym Moves = "Move VDMSeq"

definition
  inv_Moves :: "Moves \<Rightarrow> \<bool>"
where
  "inv_Moves s \<equiv> 
      inv_SeqElems inv_Move s \<and> 
      pre_sum_elems s \<and>
      (let r = sum_elems s in 
        post_sum_elems s r \<and>
        r \<le> MAX_PILE \<and> 
        (r = MAX_PILE \<longrightarrow> s $ (len s) = 1))"  

text \<open> 
   Finally, as the type invariant depends on another function, we need to ensure its dependent function(s) (e.g. @{term sum_elems}) 
  precondition(s) features in it. Sometimes \textsf{value} does not
  work\footnote{Like in Overture, in some circumstances Isabelle does not know how to evaluate expressions}. 
  Then, \textsf{lemma} can be used.  
\<close>

value "inv_Move 2"
value "inv_Moves [2,20]"
value "sum_elems [2,3,4]"
value "inv_SeqElems inv_Move [2,3,2,1]"
value "inv_SeqElems inv_Move [2,3,4,1]"

(*************************************************************************)
section \<open> VDM auxiliary functions \<close>

(*-----------------------------------------------------------------------*)
subsection \<open> @{term who_plays_next} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
-- isabelle requires declaration before use!
isFirst: Player -> bool
isFirst(p) == p = <P1>;

-- assumes <P1> is the first player
who_plays_next: Moves -> Player
who_plays_next(ms) == 
	if len ms mod 2 = 0 then <P1> else <P2>
pre isFirst(<P1>);
\end{vdmsl}
\<close>

definition
  who_plays_next :: "Moves \<Rightarrow> Player"
where 
  "who_plays_next ms \<equiv> (if (len ms) vdmmod 2 = 0 then P1 else P2)"

definition 
  isFirst :: "Player \<Rightarrow> \<bool>"
where
  "isFirst p \<equiv> p = P1"

text \<open> Given there is no pre/post for @{term isFirst}, and no type invariants to check, 
   modelling pre/post is optional. \textcolor{red}{\textbf{Make sure you know when this is okay!}}\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_who_plays_next :: "Moves \<Rightarrow> \<bool>"
where
  "pre_who_plays_next ms \<equiv> inv_Moves ms \<and> isFirst P1"

definition
  post_who_plays_next :: "Moves \<Rightarrow> Player \<Rightarrow> \<bool>"
where
  "post_who_plays_next ms RESULT \<equiv> 
      pre_who_plays_next ms \<longrightarrow> inv_Player RESULT "

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_who_plays_next_sat_obl :: "\<bool>"
where
  "PO_who_plays_next_sat_obl \<equiv> \<forall> s . inv_Moves s \<longrightarrow> 
      pre_who_plays_next s \<longrightarrow> (\<exists> r . post_who_plays_next s r)"

theorem PO_who_plays_next_sat_obl 
by (simp add: PO_who_plays_next_sat_obl_def post_who_plays_next_def inv_Player_def) (* SH *)

definition
  PO_who_plays_next_sat_exp_obl :: "\<bool>"
where
  "PO_who_plays_next_sat_exp_obl \<equiv> \<forall> s . inv_Moves s \<longrightarrow> 
      pre_who_plays_next s \<longrightarrow> post_who_plays_next s (who_plays_next s)"

theorem PO_who_plays_next_sat_exp_obl 
by (simp add: PO_who_plays_next_sat_exp_obl_def post_who_plays_next_def inv_Player_def) (* SH *)

(*-----------------------------------------------------------------------*)
subsection \<open> @{term fair_play} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fair_play: Player * Moves -> bool
fair_play(p, ms) == p = who_plays_next(ms);
\end{vdmsl}
\<close>

text\<open> Notice that in Isabelle, we get curried definitions 
  (e.g.~@{term "fair_play"} is called as 
  @{term "fair_play p ms"}) for VDM functions with multiple 
  parameters. 
\<close>

definition
  fair_play :: "Player \<Rightarrow> Moves \<Rightarrow> \<bool>"
where 
  "fair_play p ms \<equiv> p = who_plays_next ms"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_fair_play :: "Player \<Rightarrow> Moves \<Rightarrow> \<bool>"
where
  "pre_fair_play p ms \<equiv> inv_Moves ms \<and> pre_who_plays_next ms"

definition
  post_fair_play :: "Player \<Rightarrow> Moves \<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
  "post_fair_play p ms RESULT \<equiv> 
     pre_fair_play p ms \<longrightarrow>  post_who_plays_next ms p"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_fair_play_sat_obl :: "\<bool>"
where
  "PO_fair_play_sat_obl \<equiv> \<forall> s p . inv_Moves s \<longrightarrow> 
      pre_fair_play p s \<longrightarrow> (\<exists> r . post_fair_play p s r)"

theorem PO_fair_play_sat_obl 
  by (simp add: PO_fair_play_sat_obl_def inv_Player_def post_fair_play_def post_who_plays_next_def)
(* SH *)

definition
  PO_fair_play_sat_exp_obl :: "\<bool>"
where
  "PO_fair_play_sat_exp_obl \<equiv> \<forall> s p . inv_Moves s \<longrightarrow> 
      pre_fair_play p s \<longrightarrow> post_fair_play p s (fair_play p s)"

theorem PO_fair_play_sat_exp_obl 
  by (simp add: PO_fair_play_sat_exp_obl_def inv_Player_def post_fair_play_def post_who_plays_next_def)
(* SH *)

(*-----------------------------------------------------------------------*)
subsection \<open> @{term moves_left} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
moves_left: Moves -> nat
moves_left(ms) == MAX_PILE - sum_elems(ms);
\end{vdmsl}
\<close>

definition
  moves_left :: "Moves \<Rightarrow> VDMNat"
where 
  "moves_left ms \<equiv> (MAX_PILE - sum_elems ms)"

(* Warning...: remember nat subtraction is tricky *)(*<*)
value "int ((20::nat) - 10)"
value "int ((20::nat) - 20)"
value "int ((20::nat) - 30)"
value "MAX_PILE - 30" (*>*)

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_moves_left :: "Moves \<Rightarrow> \<bool>"
where
  "pre_moves_left ms \<equiv> inv_Moves ms \<and> pre_sum_elems ms"
  
definition
  post_moves_left :: "Moves \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
  "post_moves_left ms RESULT \<equiv> 
    pre_moves_left ms \<longrightarrow> 
      inv_VDMNat RESULT \<and> 
      post_sum_elems ms (sum_elems ms)"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_moves_left_sat_obl :: "\<bool>"
where
  "PO_moves_left_sat_obl \<equiv> \<forall> s . inv_Moves s \<longrightarrow> 
      pre_moves_left s \<longrightarrow> (\<exists> r . post_moves_left  s r)"

theorem PO_moves_left_sat_obl 
by (meson PO_moves_left_sat_obl_def inv_Moves_def 
          post_moves_left_def post_sum_elems_def) (* SH *)

definition
  PO_moves_left_sat_exp_obl :: "\<bool>"
where
  "PO_moves_left_sat_exp_obl \<equiv> \<forall> s . inv_Moves s \<longrightarrow> 
      pre_moves_left s \<longrightarrow> post_moves_left s (moves_left s)"

theorem PO_moves_left_sat_exp_obl 
  unfolding PO_moves_left_sat_exp_obl_def inv_Moves_def inv_VDMNat_def 
      moves_left_def post_moves_left_def Let_def
  by simp 

(*-----------------------------------------------------------------------*)
subsection \<open> @{term vdmtake} \<close>

text \<open>The function @{term take} has been defined for lists in Isabelle. We use the VDMToolkit vdmtake instead.\<close>

value "vdmtake 2 [A,B]"
value "take 2 [A,B]"

(*-----------------------------------------------------------------------*)
subsection \<open> @{term seq_prefix} \<close>

text \<open>The function @{term seq_prefix} has been defined inside VDMToolkit.\<close>

value "[(1::nat),2] \<sqsubseteq> [1,2,3]"
value "[(1::nat),2] \<sqsubseteq> [1,3,2]"

(*-----------------------------------------------------------------------*)
subsection \<open> @{term play_move} \<close>
   
text\<open>
\begin{vdmsl}[breaklines=true]
play_move: Player * Move * Moves -> Moves
play_move(p, m, s) == s ^ [m]
pre 
	-- x cannot play to loose, but at the end
	-- x cannot play to loose before the end
	(moves_left(s) <> 1 => m < moves_left(s))
	and
  -- must play to loose at the end
	(moves_left(s) = m => m = 1)
	and
  --there must be something to be played
	--moves_left(s) > m
	--and
	-- encodes fairness: if even no moves, then it must be <P1>'s turn
	fair_play(p, s)
post 
	-- you play something = implicitly true by the inv of Move
	sum_elems(s) < sum_elems(RESULT)
	and
	sum_elems(s) + m = sum_elems(RESULT)
	and 
	not fair_play(p, RESULT)
	and
	seq_prefix[Move](s, RESULT)
\end{vdmsl}
\<close>

definition
  play_move :: "Player \<Rightarrow> Move \<Rightarrow> Moves \<Rightarrow> Moves"
where 
  "play_move p m s \<equiv> s @ [m]"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_play_move0 :: "Player \<Rightarrow> Move \<Rightarrow> Moves \<Rightarrow> \<bool>"
where
  "pre_play_move0 p m s \<equiv> 
      inv_Move m \<and> inv_Moves s \<and> pre_moves_left s \<and> pre_fair_play p s \<and>
      post_fair_play p s (fair_play p s) \<and>
      (moves_left s \<noteq> 1 \<longrightarrow> m < moves_left s) \<and>
      0 < moves_left s \<and> fair_play p s"

definition
  pre_play_move :: "Player \<Rightarrow> Move \<Rightarrow> Moves \<Rightarrow> \<bool>"
where
  "pre_play_move p m s \<equiv> 
      inv_Player p \<and> inv_Move m \<and> inv_Moves s \<and> pre_moves_left s \<and> pre_fair_play p s \<and>
      post_fair_play p s (fair_play p s) \<and>
      (moves_left s \<noteq> 1 \<longrightarrow> m < moves_left s) \<and>
      (moves_left s = m \<longrightarrow> m = 1) \<and>
      fair_play p s"
      (* m \<le> moves_left s \<and>*)

definition
  post_play_move :: "Player \<Rightarrow> Move \<Rightarrow> Moves \<Rightarrow> Moves \<Rightarrow> \<bool>"
where
  "post_play_move p m s RESULT \<equiv> 
      pre_play_move p m s \<longrightarrow> 
        inv_Moves RESULT \<and> 
        pre_sum_elems s \<and> pre_sum_elems RESULT \<and>
        post_sum_elems s (sum_elems s) \<and> post_sum_elems RESULT (sum_elems RESULT) \<and> 
        sum_elems s < sum_elems RESULT \<and>
        sum_elems s + m = sum_elems RESULT \<and>
        \<not> (fair_play p RESULT) \<and>
        s \<sqsubseteq> RESULT"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

text \<open> This PO is rather involved and will be discussed later in the text. \<close>

(*-----------------------------------------------------------------------*)
subsection \<open> @{term will_first_player_win} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
will_first_player_win: () -> bool
will_first_player_win() == (MAX_PILE - 1) mod (MAX_MOV + 1) <> 0;
\end{vdmsl}
\<close>

text\<open> VDM parameterless functions are just like constants of the result type. Be careful with
  expressions like @{term "x (-1::int)"} and @{term "x - (1::int)"}:~the former applies the function $x$ to 
  the parameter $-1$, whereas the second applies the subtraction function to two parameters $x$ and $1$.
  Think of negative numbers as a unary function.
\<close>

definition 
  will_first_player_win :: "Move \<Rightarrow> \<bool>"
where
  "will_first_player_win limit \<equiv> (MAX_PILE - 1) vdmmod (limit + 1) \<noteq> 0"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition 
  pre_will_first_player_win :: "Move \<Rightarrow> \<bool>"
where
  "pre_will_first_player_win limit \<equiv> inv_MAX_PILE \<and> inv_Move limit \<and> pre_vdm_mod (MAX_PILE - 1) (limit + 1)"

text \<open> The precondition is needed to avoid applying the modulo operator to negative numbers \<close>
  
(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_will_first_player_win_sat_obl :: "\<bool>"
where
  "PO_will_first_player_win_sat_obl \<equiv> 
      \<forall> limit . pre_will_first_player_win limit \<longrightarrow> (\<exists> r . r)"

theorem PO_will_first_player_win_sat_obl 
using PO_will_first_player_win_sat_obl_def by auto (* SH *)

definition
  PO_will_first_player_win_sat_exp_obl :: "\<bool>"
where
  "PO_will_first_player_win_sat_exp_obl \<equiv> 
      \<forall> limit . pre_will_first_player_win limit \<longrightarrow> will_first_player_win limit"

theorem PO_will_first_player_win_sat_exp_obl 
  unfolding  PO_will_first_player_win_sat_exp_obl_def 
      will_first_player_win_def pre_will_first_player_win_def  will_first_player_win_def 
      pre_vdm_mod_def inv_Move_def inv_VDMNat1_def inv_MAX_PILE_def
  apply simp
  apply (intro allI impI, elim conjE)
  txt \<open>proof of specific/individual cases is more difficult, paradoxically\<close>
  apply (case_tac limit, simp_all)
  apply (case_tac "n=1", simp_all)
  apply (case_tac "n=2", simp_all)
  by (case_tac "n=3", simp_all)

(*-----------------------------------------------------------------------*)
subsection \<open> @{term who_won_invariant} \<close>

text \<open>
\begin{vdmsl}[breaklines=true]
-- invariant for whoever won: last player looses by taking 1
-- even seq means second player; odd seq means firs player 
who_won_invariant: Player * Moves -> bool 
who_won_invariant(winner, moves) ==
	-- all moves played, including last
	moves_left(moves) = 0
	and
	-- if the winner plays next, then the last guy lost, given there are no more moves left
	winner = who_plays_next(moves)
	-- assuming perfect play?
	and
	will_first_player_win() => isFirst(winner) 
\end{vdmsl}
\<close>

definition
  who_won_invariant :: "Player \<Rightarrow> Moves \<Rightarrow> Move \<Rightarrow> \<bool>"
where
  "who_won_invariant winner moves limit \<equiv> 
      moves_left moves = 0
      \<and>
      winner = who_plays_next moves
      \<and>
      will_first_player_win limit \<longrightarrow> isFirst winner"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_who_won_invariant :: "Player \<Rightarrow> Moves \<Rightarrow> Move \<Rightarrow> \<bool>"
where
  "pre_who_won_invariant winner moves limit \<equiv> 
      inv_Moves moves \<and> pre_moves_left moves \<and> 
      pre_will_first_player_win limit \<and> pre_who_plays_next moves" 

definition
  post_who_won_invariant :: "Player \<Rightarrow> Moves \<Rightarrow> Move \<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
  "post_who_won_invariant winner moves limit RESULT \<equiv> 
      pre_who_won_invariant winner moves limit \<longrightarrow>
      post_moves_left moves (moves_left moves) \<and>
      post_who_plays_next moves winner" 

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_who_won_invariant_sat_obl :: "\<bool>"
where
  "PO_who_won_invariant_sat_obl \<equiv> \<forall> s p l . 
      pre_who_won_invariant p s l \<longrightarrow> (\<exists> r . post_who_won_invariant p s l r)"

theorem PO_who_won_invariant_sat_obl 
unfolding PO_who_won_invariant_sat_obl_def post_who_won_invariant_def 
     pre_who_won_invariant_def
using inv_Moves_def inv_VDMNat_def moves_left_def 
      post_moves_left_def post_who_plays_next_def oops (*by fastforce (* SH *)*)

definition
  PO_who_won_invariant_sat_exp_obl :: "\<bool>"
where
  "PO_who_won_invariant_sat_exp_obl \<equiv> \<forall> s p l . 
      pre_who_won_invariant p s l \<longrightarrow> post_who_won_invariant p s l (who_won_invariant p s l)"

theorem PO_who_won_invariant_sat_exp_obl 
unfolding PO_who_won_invariant_sat_exp_obl_def post_who_won_invariant_def 
     pre_who_won_invariant_def
using inv_Moves_def inv_VDMNat_def moves_left_def 
      post_moves_left_def post_who_plays_next_def 
  apply simp 
  oops
      
(*-----------------------------------------------------------------------*)
subsection \<open>  @{term first_player} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_player: () -> Player
first_player() == if isFirst(<P1>) then <P1> else <P2>
post isFirst(RESULT);
\end{vdmsl}
\<close>

definition
  first_player :: "Player"
where
  "first_player \<equiv> (if isFirst P1 then P1 else P2)"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  post_first_player :: "Player \<Rightarrow> \<bool>"
where
  "post_first_player RESULT \<equiv> isFirst RESULT" 

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_first_player_sat_obl :: "\<bool>"
where
  "PO_first_player_sat_obl \<equiv> (\<exists> r . post_first_player r)"

theorem PO_first_player_sat_obl 
unfolding PO_first_player_sat_obl_def post_first_player_def 
by (simp add: isFirst_def) (* SH *)

definition
  PO_first_player_sat_exp_obl :: "\<bool>"
where
  "PO_first_player_sat_exp_obl \<equiv>  post_first_player first_player"

theorem PO_first_player_sat_exp_obl 
unfolding PO_first_player_sat_exp_obl_def post_first_player_def 
     first_player_def
by (simp add: isFirst_def) (* SH *)
  
(*-----------------------------------------------------------------------*)
subsection \<open> @{term first_player_inds} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_player_inds: Moves -> set of nat1
first_player_inds(ms) == { i | i in set inds ms & i mod 2 <> 0 }
post RESULT subset inds ms;
\end{vdmsl}
\<close>

definition
  first_player_inds :: "Moves \<Rightarrow> VDMNat1 VDMSet"
where
  "first_player_inds ms \<equiv> { i | i . i \<in> inds ms \<and> i mod 2 \<noteq> 0 }"
 (* TODO: explain why we need @{term inds_as_nat} here. *)

text \<open> 
  Again, \textsf{value} and \textsf{lemma} commands can be used to explore the space of 
  options desired. Whenever \textsf{value} fails (see commented expression in theory file), 
  that is because Isabelle does not know
  how to enumerate the expression, like in certain circumstances Overture cannot execute models. 
  For that, we can use lemmas and simple proofs. The ``proof'' here is really debugging as 
  we do not know whether the expected expression means what we want/intend, hence the @{term oops} command.
\<close>
value "{i . i\<in> {(0::int),1,2,3}}"
value "{(i,i)| i . i\<in> {(0::int),1,2,3} }"
(*value "{i . i\<in> {(0::int),1,2,3} | i < 2}"*)
lemma "A = {i . i\<in> {(0::int),1,2,3} | i < 2}" apply simp oops
lemma "A = {i | i . i\<in> {(0::int),1,2,3} \<and> i < 2}" apply simp oops
lemma "{0,1} = {i | i . i\<in> {(0::int),1,2,3} \<and> i < 2}" apply auto done

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_first_player_inds :: "Moves \<Rightarrow> \<bool>"
where
  "pre_first_player_inds ms \<equiv> inv_Moves ms" 

definition
  post_first_player_inds :: "Moves \<Rightarrow> VDMNat1 VDMSet \<Rightarrow> \<bool>"
where
  "post_first_player_inds ms RESULT \<equiv> inv_Moves ms \<and> 
      inv_SetElems inv_VDMNat1 RESULT \<and> RESULT \<subseteq> inds ms" 

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_first_player_inds_sat_obl :: "\<bool>"
where
  "PO_first_player_inds_sat_obl \<equiv> \<forall> s  . inv_Moves s \<longrightarrow> 
      pre_first_player_inds s \<longrightarrow> (\<exists> r . post_first_player_inds s r)"

theorem PO_first_player_inds_sat_obl 
using PO_first_player_inds_sat_obl_def inv_SetElems_def post_first_player_inds_def by auto (* SH *)

definition
  PO_first_player_inds_sat_exp_obl :: "\<bool>"
where
  "PO_first_player_inds_sat_exp_obl \<equiv> \<forall> s . inv_Moves s \<longrightarrow> 
      pre_first_player_inds s \<longrightarrow> post_first_player_inds s (first_player_inds s)"

lemma l_first_player_inds_nat1: 
  "inv_Moves s \<Longrightarrow> inv_SetElems inv_VDMNat1 (first_player_inds s)"
  unfolding first_player_inds_def inds_as_nat_def len_def inv_SetElems_def inv_VDMNat1_def
  unfolding  inds_def
  by (simp)

lemma l_first_player_inds_within_inds: 
  "first_player_inds s \<subseteq> inds s"
unfolding first_player_inds_def inds_as_nat_def len_def inv_SetElems_def inv_VDMNat1_def
find_theorems "_ \<subseteq> _" intro
apply (rule subsetI)
by simp

theorem PO_first_player_inds_sat_exp_obl 
unfolding PO_first_player_inds_sat_exp_obl_def post_first_player_inds_def pre_first_player_inds_def
apply simp
apply (intro allI impI conjI)
apply (simp add: l_first_player_inds_nat1)
by (simp add: l_first_player_inds_within_inds)

(*-----------------------------------------------------------------------*)
subsection \<open> @{term moves_of} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
moves_of: Moves * bool -> seq of Move
moves_of(ms, first) == 
	let idxs = first_player_inds(ms) in
			[ ms(i) | i in set  if (first) then idxs else inds ms \ idxs ]
\end{vdmsl}
\<close>

text \<open>
  Isabelle does not allow for sets to bound variables used in list comprehension generators. 
  That means either you need to use a sequence as a generator, or transform a set into a 
  sorted list (by the ordering of the underlying elements). If the set of elements does not 
  have a defined order sorting will fail. Also, @{term sorted_list_of_set} can lead to 
  complicated proofs. Avoid if possible. I show it here in case you are keen on using it.
\<close>

(*value "[ [a,b,c] ! i . i \<leftarrow> inds [a,b,c]]" = doesn't like sets for generators *)
value "[ [a,b,c] ! i . i \<leftarrow> [2,1,0]]"
(* value "[ [a,b,c] ! i . i \<leftarrow> sorted_list_of_set ( (inds [a,b,c]))]" = expects set of nat, not int *)
value "[ [a,b,c] ! i . i \<leftarrow> sorted_list_of_set ({a,b,c})]"

definition
  moves_of :: "Moves \<Rightarrow> \<bool> \<Rightarrow> Move VDMSeq"
where
  "moves_of ms first \<equiv> 
      (let idxs = first_player_inds ms in  
        [ ms ! (nat i) . i \<leftarrow> sorted_list_of_set (if first then idxs else (inds ms - idxs)) ])"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_moves_of :: "Moves \<Rightarrow> \<bool> \<Rightarrow> \<bool>"
where
  "pre_moves_of ms first \<equiv> inv_Moves ms \<and> pre_first_player_inds ms"

definition
  post_moves_of :: "Moves \<Rightarrow> \<bool> \<Rightarrow> Move VDMSeq \<Rightarrow> \<bool>"
where
  "post_moves_of ms first RESULT \<equiv> 
      inv_Moves ms \<and> inv_SeqElems inv_Move RESULT \<and>
      pre_first_player_inds ms \<and> post_first_player_inds ms (first_player_inds ms)"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_moves_of_sat_obl :: "\<bool>"
where
  "PO_moves_of_sat_obl \<equiv> 
      \<forall> s f . pre_moves_of s f \<longrightarrow> (\<exists> r . post_moves_of s f r)"

theorem PO_moves_of_sat_obl 
unfolding PO_moves_of_sat_obl_def post_moves_of_def  pre_moves_of_def 
apply (intro allI impI conjI, elim conjE)
apply (rule_tac x="moves_of s True" in exI)
apply simp oops

definition
  PO_moves_of_sat_exp_obl :: "\<bool>"
where
  "PO_moves_of_sat_exp_obl \<equiv> \<forall> s f . inv_Moves s \<longrightarrow> 
      pre_moves_of s f \<longrightarrow> post_moves_of s f (moves_of s f)"

lemma l_moves_of_move: 
  "inv_Moves ms \<Longrightarrow> inv_SeqElems inv_Move (moves_of ms f)"
unfolding moves_of_def Let_def
apply simp
apply (intro conjI impI)
unfolding inv_SeqElems_def
oops

theorem PO_moves_of_sat_exp_obl 
unfolding PO_moves_of_sat_exp_obl_def post_moves_of_def  pre_moves_of_def 
apply simp
unfolding post_first_player_inds_def pre_first_player_inds_def
apply simp
apply (intro allI impI conjI)
(*apply (simp add: l_moves_of_move) (* SH *)*)
defer
apply (simp add: l_first_player_inds_nat1) (* SH *)
apply (simp add: l_first_player_inds_within_inds) (* SH *)
oops

(*-----------------------------------------------------------------------*)
subsection \<open> @{term best_move} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
best_move: Moves -> nat
best_move(moves) == (moves_left(moves) - 1) mod (MAX_MOV + 1);
post RESULT <= moves_left(moves);
\end{vdmsl}
\<close>

definition
  best_move :: "Moves \<Rightarrow> VDMNat"
where
  "best_move moves \<equiv> ((moves_left moves) - 1) vdmmod (MAX_MOV + 1)"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

text \<open> Here I explore a few versions of the specification, first the 
 original one, which was shown to be mistaken after proofs below.
  The first precondition misses the fact @{term "moves_left ms > 0"},
  which prevents modulo arithmetic over negative numbers, whereas the
  first post condition used the wrong specification of @{term post_moves_left0}. \<close>

definition
  pre_best_move0 :: "Moves \<Rightarrow> \<bool>"
where
  "pre_best_move0 ms \<equiv> inv_Moves ms \<and> pre_moves_left ms" 

definition
  post_best_move0 :: "Moves \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
  "post_best_move0 ms RESULT \<equiv> 
      inv_Moves ms \<and> inv_VDMNat RESULT \<and>
      pre_moves_left ms \<and> post_moves_left ms (moves_left ms) \<and>
      RESULT \<le> moves_left ms" 

definition
  pre_best_move :: "Moves \<Rightarrow> \<bool>"
where
  "pre_best_move ms \<equiv> inv_Moves ms \<and> pre_moves_left ms \<and> 0 < moves_left ms" 

definition
  post_best_move :: "Moves \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
  "post_best_move ms RESULT \<equiv> 
      inv_Moves ms \<and> inv_VDMNat RESULT \<and>
      pre_moves_left ms \<and> post_moves_left ms (moves_left ms) \<and>
      RESULT \<le> moves_left ms" 

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

text \<open>
  After the translation is complete, one needs to create proof obligations to ensure
  pre/post are satisfiable. For instance, the theorem layout for @{term best_move} is:
  
  @{term[display] "\<forall> ms . inv_Moves ms \<longrightarrow> pre_best_move ms \<longrightarrow> (\<exists> r . post_best_move ms r)"}
  
  We use a definition to declare the theorem and then prove it. Again, I show the versions 
  I went through, and the process of discovery of the correct one. \textbf{This is very important},
  and is very likely to happen to your model/translation to Isabelle.
  The objective is that the proof is @{term True} meaning the operation is satisfiable with 
  respect to its specification. 
Next we show the various proof attempts for the PO conjecture. 

\begin{enumerate}
  \item[1] Naive attempt:~layered expansion followed by simplification.
\end{enumerate}
\<close>      

definition
  PO_best_move_sat_obl0 :: "\<bool>"
where
  "PO_best_move_sat_obl0 \<equiv> \<forall> ms . inv_Moves ms \<longrightarrow> 
      pre_best_move0 ms \<longrightarrow> (\<exists> r . post_best_move0 ms r)"

value "3 +(5::int)"

lemma l_moves_left_nat: 
  "inv_Moves ms \<Longrightarrow> 0 \<le> moves_left ms"
unfolding moves_left_def inv_Moves_def Let_def by simp

theorem PO_best_move_sat_obl0
unfolding PO_best_move_sat_obl0_def 
           pre_best_move0_def post_best_move0_def
find_theorems "\<forall> _ . (_ \<longrightarrow> _)"
apply simp
unfolding pre_moves_left_def post_moves_left_def
apply simp
unfolding pre_sum_elems_def post_sum_elems_def
apply simp
unfolding  inv_VDMNat_def 
apply auto 
apply (rule_tac x=0 in exI, intro conjI, simp_all)
txt \<open> @{subgoals[display,indent=0]} 

  Missing cases where we cannot make progress suggest we need lemmas on @{term "0 \<le> moves_left ms"}.
  There is also an error: @{term "moves_left ms = 0"} and yet @{term "ms \<noteq> []"}! 
  We will need to change to @{term "post_moves_left"} from @{term post_moves_left0}.
\<close>
  prefer 2 
   apply (simp add: l_sum_elems_nat)
  prefer 2
  using l_sum_elems_nat1 apply auto[1]
   apply (simp add: l_moves_left_nat)+
oops

text \<open>
  The simplistic strategy of expanding and simplifying does not work here. We need intermediate 
  results to help Isabelle finish the proof. That means, being creative about adequate auxiliary lemmas.
\<close>

lemma l_moves_left_nat1: 
  "inv_Moves ms \<Longrightarrow> 0 < moves_left ms"
apply (induct ms)
unfolding moves_left_def
apply simp_all
txt \<open> @{subgoals[display,indent=0]}
  Missing lemma about @{term "inv_Moves (x # xs)"} distributing over list append.
\<close>
oops

lemma l_inv_Moves_Cons: 
  "inv_Moves (x # xs) = (inv_Move x \<and> inv_Moves xs)"
apply (intro iffI conjI)
txt \<open> @{subgoals[display,indent=0]}
  Let us split the work again into lemmas for each subgoal to help \textsf{sledgehammer}!
\<close>
oops

declare[[show_types=false]]
lemma l_inv_Moves_Hd: 
  "inv_Moves (x # xs) \<Longrightarrow> inv_Move x"
  unfolding inv_Moves_def 
    by (simp add: l_inv_SeqElems_Cons)

lemma l_inv_Moves_Tl: 
  "inv_Moves (x # xs) \<Longrightarrow> inv_Moves xs"
unfolding inv_Moves_def
apply (intro conjI) 
apply (simp) (* SH *)
apply (simp add: pre_sum_elems_def) (* SH *)
unfolding Let_def
apply (elim conjE)
apply (simp add: post_sum_elems_def inv_SeqElems_def 
                  inv_VDMNat_def l_pre_sum_elems l_sum_elems_nat 
                  pre_sum_elems_def) (* SH *)
  apply (simp, elim conjE)
  unfolding pre_sum_elems_def
   apply (simp add: l_inv_SeqElems_Cons)
  apply (elim conjE, intro conjI impI, simp_all)
  unfolding post_sum_elems_def
    apply (simp add: l_inv_Moves_Hd)
    apply (simp add: inv_VDMNat_def l_inv_SeqElems_Cons l_pre_sum_elems l_sum_elems_nat)
  using l_inv_Move_nat1 l_inv_SeqElems_Cons apply fastforce
  using l_inv_Move_nat1 l_inv_SeqElems_Cons by fastforce

lemma l_inv_Moves_Cons: 
  "inv_Moves (x # xs) = (inv_Move x \<and> inv_Moves xs)"
apply (rule iffI)
using l_inv_Moves_Hd l_inv_Moves_Tl apply blast (* SH *)
apply (elim conjE)
unfolding inv_Moves_def post_sum_elems_def Let_def
apply (elim conjE, intro conjI, simp_all)
      apply (simp add:  pre_sum_elems_def) (* SH *)
      apply (simp add: l_inv_SeqElems_Cons)
   apply (simp add: l_inv_SeqElems_Cons pre_sum_elems_def)
  using inv_VDMNat_def l_inv_Move_nat1 apply force
  nitpick[user_axioms=true]
txt\<open> Goals not provable when @{term "sum_elems xs = MAX_PILE"}, 
because @{term "inv_Move x"} enforce @{term "x > (0::int)"} \<close>
oops

(*<*) thm l_moves_left_nat l_inv_Moves_Hd l_inv_Moves_Tl (*>*)
text \<open> Lemmas proved as a result of first attempt:

\begin{enumerate}
  \item[1.a] @{term "moves_left s"} is @{typ \<nat>} for valid moves @{thm[display] l_moves_left_nat}
  \item[1.b] @{term "inv_Moves s"} distributes to head of $s$ for valid moves @{thm[display] l_inv_Moves_Hd}
  \item[1.c] @{term "inv_Moves s"} distributes to tail of $s$ for valid moves @{thm[display] l_inv_Moves_Tl}
\end{enumerate}

Proof failures are useful to understand what is wrong:

\begin{enumerate}
  \item[1.d] @{term "moves_left s"} is \textbf{not} @{typ \<nat>}$_1$, why? 
  @{term[display] "inv_Moves ms \<Longrightarrow> 0 < moves_left ms"}

  \item[1.e] it might \textbf{not} be possible to append to a valid move sequence, why? 

  @{term[display] "inv_Moves (x # xs) = (inv_Move x \<and> inv_Moves xs)"}

\end{enumerate}

Let's see if the lemma shape is working (i.e. it will be used by Isabelle).

\begin{enumerate}
  \item[2] Using lemmas:~layered expansion followed by simplification with lemmas.
\end{enumerate}
\<close>

theorem PO_best_move_sat_obl0
txt \<open> $\cdots$ \<close>(*<*)
unfolding PO_best_move_sat_obl0_def pre_best_move0_def post_best_move0_def 
apply simp
unfolding pre_moves_left_def post_moves_left_def
apply simp
unfolding pre_sum_elems_def post_sum_elems_def
apply simp
unfolding  inv_VDMNat_def 
apply (intro allI impI conjI) (*or apply auto*)
apply (rule_tac x=0 in exI)
apply simp
apply (intro conjI)
find_theorems "_ \<noteq> []" name:Nim (*>*)
apply (simp add: l_moves_left_nat) (* SH *)
txt \<open> Yes! The lemma discharged the first suggoal, and \textsf{sledgehammer} found it.
 \<close>
oops

(* TODO: explain? Tried an unprovable goal to finish the proof... ?

lemma l_moves_left_ms_not_empty: "inv_Moves ms \<Longrightarrow> ms \<noteq> [] \<longleftrightarrow> 0 < moves_left ms"
sorry 

theorem PO_best_move_sat_obl0
txt \<open> $\cdots$ \<close> (*<*)
unfolding PO_best_move_sat_obl0_def pre_best_move0_def post_best_move0_def 
apply simp
unfolding pre_moves_left_def post_moves_left0_def
apply simp
unfolding pre_sum_elems_def post_sum_elems_def
apply simp
unfolding  inv_VDMNat_def 
apply (intro allI impI conjI) (* or apply auto *)
apply (rule_tac x=0 in exI)
apply simp
apply (intro conjI)
find_theorems "_ \<noteq> []" name:Nim (*>*)
apply (simp add: l_moves_left_nat) (* SH *)
apply (simp add: l_moves_left_ms_not_empty) (* SH *)
by (simp add: l_moves_left_nat) (* SH *) 
*)

text \<open> Next we define the PO of @{term best_move} with new post condition @{term post_best_move}, 
yet with the old precondition @{term pre_best_move0}. 
\begin{enumerate}
  \item[3] revised definition of @{term post_best_move} + using lemmas: \textcolor{red}{\textbf{success?!}}
\end{enumerate}
\<close>

definition
  PO_best_move_sat_obl1 :: "\<bool>"
where
  "PO_best_move_sat_obl1 \<equiv> \<forall> ms . inv_Moves ms \<longrightarrow> pre_best_move0 ms \<longrightarrow> (\<exists> r . post_best_move ms r)"

theorem PO_best_move_sat_obl1
txt \<open> $\cdots$ \<close> (*<*)
unfolding PO_best_move_sat_obl1_def pre_best_move0_def post_best_move_def 
apply simp
unfolding pre_moves_left_def post_moves_left_def
apply simp
unfolding pre_sum_elems_def post_sum_elems_def
apply simp
unfolding inv_VDMNat_def 
apply (intro allI impI conjI) (* or apply auto *)
apply (rule_tac x=0 in exI)
apply simp
apply (intro conjI) (*>*)
txt \<open> @{subgoals[display,indent=0]}
  With the updated definition, and proved lemmas, we get different subgoals, all dischargeble
  by \textsf{sledgehammer}.  
\<close>
apply (simp add: l_moves_left_nat) (* SH *)
apply (simp add: l_sum_elems_nat) (* SH *)
using l_sum_elems_nat1 apply auto[1] (* SH *)
by (simp add: l_moves_left_nat) (* SH *)

text\<open>  
  What is going on? We proved this, shouldn't it mean that @{term pre_best_move0} is okay?
  No because we have an explicit definition as @{thm[display] best_move_def}
  We need to account for that fact and be specific about the witness, which is to 
  blame because when @{term "moves_left ms = 0"}, then @{term "best_move ms"} does not work as expected. 
 \textcolor{red}{\textbf{That is, if an explicit definition is given, there is no choice for witness for the proof obligation!}}
 Thus, the commitment in the model presented by the explicit definition must feature in the proof.
 From Overture, the PO has a fixed witnesses according to what the explicit definition was, and we state it in Isabelle 

\begin{vdmsl}[breaklines=true]
best_move: function establishes postcondition obligation @ in 'NimFull' (./NimFull.vdmsl) at line 119:1
(forall moves:Moves & post_best_move(moves, ((moves_left(moves) - 1) mod (MAX_MOV + 1))))
Proof Obligation 15: (Unproved)
\end{vdmsl}

To avoid mixing problems from different sources, we first try to prove the original post condition
with the explicit witness in the next attempt.

\begin{enumerate}
  \item[4] Lemmas + explicit witness + no revision of @{term post_best_move} 
\end{enumerate}

\<close>

definition
  PO_best_move_sat_obl2 :: "\<bool>"
where
  "PO_best_move_sat_obl2 \<equiv> \<forall> ms . pre_best_move0 ms \<longrightarrow> 
      post_best_move0 ms (((moves_left ms) - 1) mod (MAX_MOV + 1))"

theorem PO_best_move_sat_obl2
unfolding PO_best_move_sat_obl2_def pre_best_move0_def post_best_move0_def
apply (intro allI impI conjI, elim conjE, simp_all)
unfolding post_moves_left_def pre_moves_left_def post_sum_elems_def
apply (simp_all)
txt\<open> @{subgoals[display,indent=0]}
   This suggests a trivial lemma about @{term inv_VDMNat} to avoid multiple goals \<close>
unfolding inv_VDMNat_def
apply (simp add: l_moves_left_nat) (* SH *)
apply (intro conjI)
apply (simp add: l_moves_left_nat) (* SH *)
  apply (simp add: pre_sum_elems_def)(* SH *)
  apply (simp add: l_sum_elems_nat)
  apply (simp add: l_pre_sum_elems_sat)
txt\<open> @{subgoals[display,indent=0]}
   The first subgoal is not provable because @{term "moves_left ms"} can be $0$!
   We can create another lemma for the final subgoal using facts about remainder
   using theorem search to find @{thm zmod_le_nonneg_dividend}. \<close>
find_theorems "_ mod _ \<le> _"
oops

text \<open> Let us create the lemmas suggested by the previous proof. \<close>

lemma l_inv_VDMNat_moves_left: 
  "inv_Moves ms \<Longrightarrow> inv_VDMNat (moves_left ms)" 
unfolding inv_VDMNat_def by (simp add: l_moves_left_nat)  (* SH *)

lemma l_nim_mod_prop: 
  "x \<ge> 0 \<Longrightarrow> (x - (1::int)) mod y \<le> x" (*nitpick[user_axioms]*)
quickcheck
txt \<open> This is not provable with $x=0, y=2$. What we want is 
  to use it for @{thm[display] zmod_le_nonneg_dividend[of "moves_left s" "MAX_MOV"]}
  We need to tighten our assumptions.
\<close> (*<*)thm zmod_le_nonneg_dividend[of "moves_left s" "MAX_MOV"](*>*)
oops

lemma l_nim_mod_prop: 
  "x > 0 \<Longrightarrow> (x - (1::int)) mod y \<le> x" 
by (smt zmod_le_nonneg_dividend) (* SH *)

lemma l_moves_left_prop: 
  "inv_Moves ms \<Longrightarrow> pre_sum_elems ms \<Longrightarrow> (ms \<noteq> []) = (0 < moves_left ms)"
unfolding inv_Moves_def Let_def moves_left_def
apply (rule iffI)
find_theorems "_ \<noteq> _" name:Nim
thm l_sum_elems_nat1[of "ms"] (*apply (frule l_pre_sum_elems_sat,simp)*)
apply (cut_tac l_sum_elems_nat1,simp_all)
defer
apply (cut_tac l_sum_elems_notempty,simp_all+)
(* MISTAKE: second goal is not provable. There is a problem with moves_left ms > 0, fixed post_moves_left above *)
oops

text \<open> Proved lemmas:
\begin{enumerate}
  \item[4.a] No need to expand @{term inv_VDMNat} for @{term "moves_left ms"} result; @{thm[display] l_inv_VDMNat_moves_left}
  \item[4.b] Remainder property of Nim game. @{thm[display] l_nim_mod_prop}
\end{enumerate}

Failed lemmas:
\begin{enumerate}
  \item[4.c] Moves left might be zero, yet $ms$ is not empty. @{term[display] "(ms \<noteq> []) = (0 < moves_left ms)"}
\end{enumerate}

Let us try again with the new lemmas.
\<close>

theorem PO_best_move_sat_obl2
unfolding PO_best_move_sat_obl2_def pre_best_move0_def post_best_move0_def
apply (intro allI impI conjI, elim conjE, simp_all)
unfolding post_moves_left_def pre_moves_left_def post_sum_elems_def
apply (simp_all add: l_inv_VDMNat_moves_left)
unfolding inv_VDMNat_def
apply (simp, intro conjI)
  apply (simp add: pre_sum_elems_def)(* SH *)
  apply (simp add: l_sum_elems_nat)
defer
apply (rule l_nim_mod_prop)
txt\<open> @{subgoals[display,indent=0]} 
  Unprovable part boils down to @{term "moves_left ms"} not being @{typ \<nat>}$_1$. \<close>
oops

text \<open>
With the new lemmas for the explicit witness proved, let us now change the post condition.

\begin{enumerate}
  \item[5] Revised definition @{term post_best_move} + lemmas + explicit witness
\end{enumerate}
\<close>

definition
  PO_best_move_sat_obl3 :: "\<bool>"
where
  "PO_best_move_sat_obl3 \<equiv> \<forall> ms . pre_best_move0 ms \<longrightarrow> 
      post_best_move ms (((moves_left ms) - 1) mod (MAX_MOV + 1))"

theorem PO_best_move_sat_obl3
unfolding PO_best_move_sat_obl3_def pre_best_move0_def post_best_move_def
apply (intro allI impI conjI, elim conjE, simp_all)
unfolding post_moves_left_def pre_moves_left_def post_sum_elems_def
apply (simp_all add: l_inv_VDMNat_moves_left)
unfolding inv_VDMNat_def
apply simp
apply (simp add: inv_VDMNat_def l_pre_sum_elems l_sum_elems_nat pre_sum_elems_def) (* SH *)
apply (rule l_nim_mod_prop)
txt\<open> @{subgoals[display,indent=0]} 
  From the failure, let us try and prove the missing lemma.
\<close>
oops

(*<*)
lemma l_moves_left_nat1: 
  "inv_Moves ms \<and> pre_sum_elems ms \<Longrightarrow> 0 < moves_left ms"
apply (erule conjE)
apply (induct ms)
unfolding moves_left_def
apply simp_all
find_theorems "inv_Moves (_ # _)"
apply (simp add: l_inv_Moves_Tl)
find_theorems "pre_sum_elems (_ # _)"
unfolding pre_sum_elems_def
find_theorems "inv_SeqElems _ (_ # _)"
find_theorems "inv_Move _ \<Longrightarrow> _"
find_theorems "0 \<le> sum_elems _"
apply (frule l_sum_elems_nat)
  apply (case_tac ms)
  apply (simp add: inv_Move_def l_inv_SeqElems_Cons)
oops
(*>*)

lemma l_moves_left_nat1: 
  "inv_Moves ms \<and> pre_sum_elems ms \<Longrightarrow> 0 < moves_left ms"
unfolding  pre_sum_elems_def moves_left_def
apply (induct ms, simp_all, elim conjE)
apply (simp add: l_inv_Moves_Tl)
  apply (frule l_sum_elems_nat)
  apply simp
txt \<open> Goal is @{term False}, yet easier to see with generalised aruments \<close>
oops

lemma "0 \<le> x \<Longrightarrow> 0 < a \<Longrightarrow> 0 < y - (x::int) \<Longrightarrow> 0 < y - (a + x)"
(*qc: x=0,y=1,a=1*)
oops

text \<open>
  Now we see what the problem is:~@{term best_move} is missing the precondition about
  @{term moves_left} being non-zero for the explicit witness, and leads to our final attempt.

\begin{enumerate}
  \item[6] Revised definitions @{term pre_best_move} and @{term post_best_move} + lemmas + explicit witness
\end{enumerate}
\<close>

definition
  PO_best_move_sat_obl :: "\<bool>"
where
  "PO_best_move_sat_obl \<equiv> \<forall> ms . pre_best_move ms \<longrightarrow> 
      post_best_move ms (((moves_left ms) - 1) mod (MAX_MOV + 1))"

(*<*)thm PO_best_move_sat_obl0_def 
         PO_best_move_sat_obl1_def 
         PO_best_move_sat_obl2_def 
         PO_best_move_sat_obl3_def 
         PO_best_move_sat_obl_def (*>*)

theorem PO_best_move_sat_obl
unfolding PO_best_move_sat_obl_def pre_best_move_def  post_best_move_def
apply (intro allI impI conjI, elim conjE, simp_all)
unfolding inv_VDMNat_def
apply simp
unfolding post_moves_left_def pre_moves_left_def post_sum_elems_def
apply (intro conjI impI, elim conjE,simp_all)
apply (simp add: l_inv_VDMNat_moves_left) (* SH *)
apply (simp add: pre_sum_elems_def) (* SH *)
apply (meson inv_Moves_def post_sum_elems_def) (* SH *)
  (* Various options to take, some using our lemmas:
      "z3": Try this: apply (simp add: inv_VDMNat_def l_sum_elems_nat pre_sum_elems_def) (0.7 ms). 
      "cvc4": Try this: apply (simp add: inv_VDMNat_def l_sum_elems_nat pre_sum_elems_def) (0.8 ms). 
      "spass": Try this: apply (meson inv_Moves_def post_sum_elems_def) (22 ms).*)
apply (simp add: l_pre_sum_elems_sat) (* SH *)
by (simp add: l_nim_mod_prop) (* SH *)

text \<open>
  Finally we managed to prove that the adjusted/corrected definition of @{term best_move} pre and
  post conditions are now appropriate and make sense with the chosen specification, as well
  as the explicit definition. Auxiliary lemmas help \textsf{sledgehammer} find proofs.
  This illustrates how proof ensures models are fit for purpose. 
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> @{term max} and @{term min} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
min: int * int -> int
min(x,y) == if (x < y) then x else y;

max: int * int -> int
max(x,y) == if (x > y) then x else y;
\end{vdmsl}
\<close>

text\<open> Isabelle already defines these functions and we omit them here. \<close>

(*-----------------------------------------------------------------------*)
subsection \<open> @{term flip_current_player} \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
flip_current_player: Player -> Player
flip_current_player(p) == if (p = <P1>) then <P2> else <P1>
post p <> RESULT;
\end{vdmsl}
\<close>

definition
  flip_current_player :: "Player \<Rightarrow> Player "
where
  "flip_current_player p \<equiv> (if (p = P1) then P2 else P1)"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  post_flip_current_player :: "Player \<Rightarrow> Player \<Rightarrow> \<bool>"
where
  "post_flip_current_player p RESULT \<equiv> p \<noteq> RESULT" 


(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Satisfiability PO \<close>

definition
  PO_flip_current_player_sat_obl :: "\<bool>"
where
  "PO_flip_current_player_sat_obl \<equiv> 
       \<forall> p . (\<exists> r . post_flip_current_player p r)"

theorem PO_flip_current_player_sat_obl 
unfolding PO_flip_current_player_sat_obl_def post_flip_current_player_def 
by (metis Player.distinct(1))(* SH *)

definition
  PO_flip_current_player_sat_exp_obl :: "\<bool>"
where
  "PO_flip_current_player_sat_exp_obl \<equiv> 
      \<forall> p . post_flip_current_player p (flip_current_player p)"

theorem PO_flip_current_player_sat_exp_obl 
unfolding PO_flip_current_player_sat_exp_obl_def post_flip_current_player_def 
        flip_current_player_def
by simp (* SH *)

(*************************************************************************)
section \<open> VDM state \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
state Nim of
	limit: Move
	current: Player
	moves: Moves
inv mk_Nim(limit, current, moves) ==
	-- cannot move all at once
	limit < MAX_PILE
	and
	-- fair play
	fair_play(current, moves)
	and
	isFirst(<P1>)
--init nim == nim = mk_Nim(MAX_MOV, first_player(), FIXED_PLAY_GAME)
init nim == nim = mk_Nim(MAX_MOV, first_player(), [])
end 
\end{vdmsl}
\<close>

text \<open>
  We use records to represent the VDM state. You can also use cartesian product or tuples.
  You need to represent the state invariant, its initialisation, and the result of the
  invariant on the given initial values.  
\<close>

record NimSt =
  limit :: Move
  current :: Player
  moves :: Moves

text \<open>
  VDM records field access ($x.moves$) is defined in Isabelle through functions (@{term "moves x"}),
  whereas record constants ($mkNimSt(l, c, m)$) are defined in Isabelle as @{term "\<lparr> limit = l, current = c, moves = m \<rparr>"}.
  So, for instance, the result of

  @{term[display] "moves \<lparr> limit = MAX_MOV, current = P1, moves = [(1::int),2] \<rparr>"}

  is the sequence @{value "[1,(2::int)]"}. 
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> State invariant \<close>

text \<open>
  For the state invariant we define a curried function with its components, checking
  the appropriate types first, and next the state invariant itself. Note that if the
  invariant makes use of auxiliary function definitions, it is implicitly adhering to
  those functions specifications as well (e.g.~pre/post for @{term isFirst} and 
  @{term fair_play}).
  Finally, we also define a version of the invariant on the state record itself. 
\<close>

definition 
  inv_Nim_flat :: "Move \<Rightarrow> Player \<Rightarrow> Moves \<Rightarrow> \<bool>"
where
  "inv_Nim_flat l c ms \<equiv> 
      inv_Move l \<and> inv_Moves ms \<and> pre_fair_play c ms \<and>
      post_fair_play c ms (fair_play c ms) \<and>
      l < MAX_PILE \<and> fair_play c ms \<and> isFirst P1"

definition 
  inv_Nim :: "NimSt \<Rightarrow> \<bool>"
where
  "inv_Nim st \<equiv> inv_Nim_flat (limit st) (current st) (moves st)"
                      
(*-----------------------------------------------------------------------*)
subsection \<open> State initialisation \<close>

text \<open>
  Initialisation is defined with an Isabelle record value.
  This of course must enforce the invariant as its postcondition.
\<close>

definition 
  init_Nim :: "NimSt"
where
  "init_Nim \<equiv> \<lparr> limit = MAX_MOV, current = P1, moves = [] \<rparr>"
   
(*-----------------------------------------------------------------------*)
subsection \<open> State satisfiability PO \<close>
  
definition 
  PO_Nim_initialise_sat_obl :: "\<bool>"
where
  "PO_Nim_initialise_sat_obl \<equiv> inv_Nim init_Nim"

theorem PO_Nim_initialise_sat_obl
  unfolding  PO_Nim_initialise_sat_obl_def inv_Nim_def init_Nim_def inv_Nim_flat_def
  apply simp
  unfolding inv_Move_def inv_Moves_def
  apply auto
  unfolding pre_fair_play_def post_fair_play_def pre_who_plays_next_def post_who_plays_next_def
  unfolding pre_sum_elems_def post_sum_elems_def inv_Move_def inv_VDMNat_def inv_VDMNat1_def
        apply auto
  unfolding inv_Moves_def isFirst_def inv_Player_def
  apply auto
  unfolding pre_sum_elems_def post_sum_elems_def inv_Move_def inv_VDMNat_def inv_VDMNat1_def
    apply auto
  unfolding fair_play_def who_plays_next_def len_def
  by auto

(*************************************************************************)
section \<open> VDM operations \<close>

text \<open>
  VDM operations, in so far as Isabelle is concerned, only require pre/post. That is because
  these are the parts that appear in the the proof obligations to be discharged. You might also
  want to define the explicit definition (e.g. the how), but is not strictly necessary. 
  Explicit definitions are helpful. On the other hand, explicit witnesses for existential
  quantifiers, as discussed above for @{term best_move}, could lead to unprovable goals.

  Preconditions depend on inputs and before state, whereas postconditions depend on inputs, outputs,
  before and after states in that order. Thus the boolean-valued function signature needs to be defined
  accordingly. Note that you need to check type invariants, as well as auxiliary function pre/post 
  conditions on the appropriate arguments. For instance, @{term post_naive_choose_move} below references
  to @{term "moves_left ms"} is referring to the VDM after state (@{text "moves ast"}) of @{term Moves}.
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> @{term who_won} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
-- who won is determined by who played more moves? 
who_won() w: Player ==
	return current -- who_plays_next(moves)
ext rd current, moves
pre isFirst(first_player())
post (who_won_invariant(w, moves) 
			and 
			-- last save flipped loser and put winner as current
			w = current)
\end{vdmsl}
\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_who_won :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_who_won bst \<equiv> inv_Nim bst \<and> isFirst P1"

definition
  post_who_won :: "Player \<Rightarrow> NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_who_won w bst ast \<equiv>
     pre_who_won bst \<longrightarrow> 
     inv_Player w \<and> inv_Nim ast \<and>
     (current bst) = (current ast) \<and>
     (limit bst) = (limit ast) \<and>
     (moves bst) = (moves ast) \<and>
     pre_who_won_invariant w (moves ast) (limit ast) \<and>
     post_who_won_invariant w (moves ast) (limit ast) (who_won_invariant w (moves ast) (limit ast)) \<and>
     (who_won_invariant w (moves ast) (limit ast)) \<and>
     w = current ast"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

definition
  who_won :: "NimSt \<Rightarrow> Player"
where
  "who_won bst \<equiv> (current bst)"

definition
  who_won_complete :: "NimSt \<Rightarrow> (NimSt \<times> Player)"
where
  "who_won_complete bst \<equiv> (bst, (current bst))"


(*-----------------------------------------------------------------------*)
subsection \<open> @{term tally} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
tally() ==
	 (print("\nPlayer ");print(who_won());println(" won! Play finished with:");
	  print("\tP1 moves = ");println(moves_of(moves, isFirst(<P1>)));
	  print("\tP2 moves = ");println(moves_of(moves, isFirst(<P2>)));
	 )
ext rd current, moves;	
\end{vdmsl}
\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_tally :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_tally bst \<equiv> inv_Nim bst \<and> pre_who_won bst"

definition
  post_tally :: "NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_tally bst ast \<equiv>
     pre_tally bst \<longrightarrow>  
     inv_Nim ast  \<and>  post_who_won (current ast) bst ast"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

text \<open> 
  We define tally in VDM to illustrate the use of sequential composition. 
  We will not show I/O in Isabelle.  
\<close>

definition
  tally :: "NimSt \<Rightarrow> NimSt"
where
  "tally bst \<equiv> (let p = who_won bst in bst)"

(*-----------------------------------------------------------------------*)
subsection \<open> @{term naive_choose_move} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
naive_choose_move() r: Move == 
	-- naive choice: from 1 up to MAX_MOV or else amount left, presuming there are at least the last
	let m in set {1,...,min(MAX_MOV, moves_left(moves))} in return m
ext rd moves
pre moves_left(moves) > 0
post 
	-- might be = in the case of the loosing play
	r <= moves_left(moves);
\end{vdmsl}
\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

text \<open> Notice that @{term moves_left} in the postcondition is applied to the 
after state  (e.g. @{term "moves ast"}). \<close>

definition
  pre_naive_choose_move :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_naive_choose_move bst \<equiv> 
      inv_Nim bst \<and> 
      (let ms = (moves bst) in
        pre_moves_left ms \<and> 
        moves_left ms > 0)"

definition
  post_naive_choose_move :: "Move \<Rightarrow> NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_naive_choose_move r bst ast \<equiv>
      pre_naive_choose_move bst \<longrightarrow>
      inv_Move r \<and> inv_Nim ast \<and> 
      (let bms = (moves bst) in
        post_moves_left bms (moves_left bms) \<and>
        r \<le> moves_left bms)"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

text \<open> 
  The implementation uses VDM's non deterministic (Hilbert's-)choice over a set. 
  It can be encoded with Isabelle's Hilbert's choice operator\footnote{See~\url{https://en.wikipedia.org/wiki/Choice_function}}. 
  Like in VDM, this has the precondition that the underlying set/sequence are not empty.
  Proofs involving Hilbert's choice are tricky/difficult.
\<close>

lemma "(SOME m . m \<in> {1 .. MAX_MOV}) > 0"
  find_theorems "SOME _ . _ \<in> _" name:Hilbert
  apply (simp add: some_in_eq)
  (*thm Quotient.quot_type.some_collect
  apply (simp add: Quotient.quot_type.some_collect)*)
  find_theorems "SOME _ . _"
  oops
lemma "(SOME m . m \<in> {1 .. MAX_MOV}) > 0"
  apply (rule someI2)
  by auto

lemma "(SOME m . m \<in> {1 .. (3::int)}) > 0"
  apply (rule someI2)
  by auto

text \<open>
  Operations should always return the sate and its result type. You could 
  choose to avoid returning the state if there are no \texttt{ext wr} clauses declared
  (\textit{i.e.}~the operation is read-only and doesn't change the sate). This simplification
  is useful to avoid needing to handle tuples in proofs. I provide both versions for illustrative purposes.
\<close>

definition
  naive_choose_move0 :: "NimSt \<Rightarrow> NimSt \<times> Move"
where
  "naive_choose_move0 st \<equiv> 
    (st, (SOME m . m \<in> {1 .. (min MAX_MOV (moves_left (moves st)))}))"

definition
  naive_choose_move :: "NimSt \<Rightarrow> Move"
where
  "naive_choose_move st \<equiv>  
    (SOME m . m \<in> {1 .. (min MAX_MOV (moves_left (moves st)))})"

(*-----------------------------------------------------------------------*)
subsection \<open> @{term fixed_choose_move} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fixed_choose_move() r: Move == 
	return FIXED_PLAY(len moves + 1)
ext rd moves, current
pre moves_left(moves) > 0
post 
	-- can never be = moves_left(moves) or it would entail loosing?
	r < moves_left(moves)
	and
	-- after playing the chosen move r, the next player has no good move choice
	(will_first_player_win() 
	and
	isFirst(who_plays_next(moves))) 
	=> best_move(play_move(current, r, moves)) = 0
	;

values
									-- 1 2 1 2 1 2 1 2 1 2
FIXED_PLAY: Moves = [3,2,2,1,3,2,2,1,3,1];
\end{vdmsl}
\<close>

text \<open>
  The @{term FIXED_PLAY} value needs to be declared first as it is used in the coming definition. 
  Also, it needs to satisfy the invariant of @{term Moves} in the precondition of where it appears. 
  We use @{term definition} instead of @{term abbreviation} to avoid expansion in proofs.
\<close>

definition
  FIXED_PLAY :: "Moves"
where
  "FIXED_PLAY \<equiv> [3,2,2,1,3,2,2,1,3,1]"

definition
  inv_FIXED_PLAY :: "\<bool>"
where
  "inv_FIXED_PLAY \<equiv> inv_Moves FIXED_PLAY"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_fixed_choose_move :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_fixed_choose_move bst \<equiv> 
      pre_naive_choose_move bst"

definition
  post_fixed_choose_move :: "Move \<Rightarrow> NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_fixed_choose_move RESULT bst ast \<equiv>
      post_naive_choose_move RESULT bst ast"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

definition
  fixed_choose_move :: "NimSt \<Rightarrow> Move"
where
  "fixed_choose_move st \<equiv> FIXED_PLAY $ (len (moves st) + 1)"

(*-----------------------------------------------------------------------*)
subsection \<open> @{term first_player_winning_choose_move} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_player_winning_choose_move() r: Move == 
	-- winning choice: get the best move, unless it's zero, so choose the least worst (1) play
	return max(1, best_move(moves))
ext rd moves, current
pre moves_left(moves) > 0
post 
	-- can never be = moves_left(moves) or it would entail loosing?
	r < moves_left(moves)
	and
	-- after playing the chosen move r, the next player has no good move choice
	will_first_player_win() => best_move(play_move(current, r, moves)) = 0
	;
\end{vdmsl}
\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_first_player_winning_choose_move0 :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_first_player_winning_choose_move0 bst \<equiv> 
      inv_Nim bst \<and> pre_moves_left (moves bst) \<and> moves_left (moves bst) > 0"

definition
  pre_first_player_winning_choose_move :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_first_player_winning_choose_move bst \<equiv> 
      inv_Nim bst \<and> 
      pre_moves_left (moves bst) \<and> 
      pre_best_move (moves bst) \<and> 
      moves_left (moves bst) > 0 \<and> 
      best_move (moves bst) > 0"

definition
  post_first_player_winning_choose_move0 :: "Move \<Rightarrow> NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_first_player_winning_choose_move0 RESULT bst ast \<equiv>
      pre_first_player_winning_choose_move0 bst \<longrightarrow>
      inv_Move RESULT \<and> inv_Nim ast \<and>
      (let bms = (moves bst);
           ams = (moves ast);
           alim= (limit ast);
            ac = (current ast);
           pm = play_move ac RESULT ams;
          bm = best_move pm
        in
        pre_moves_left ams \<and> post_moves_left ams (moves_left ams) \<and>
        pre_who_plays_next ams \<and> post_who_plays_next ams (who_plays_next ams) \<and>
        pre_will_first_player_win alim \<and>
         pre_play_move ac RESULT ams \<and>
          post_play_move ac RESULT ams pm \<and>
          pre_best_move pm \<and> post_best_move pm (best_move pm) \<and>
          
          (limit bst) = (limit ast) \<and> (current bst) = (current ast) \<and> (moves bst) = (moves ast) \<and> 
          RESULT < moves_left ams \<and>
          (will_first_player_win alim \<longrightarrow> best_move pm = 0)
        )"
            (* TODO: add limit parameter to best_move ! *)

definition
  post_first_player_winning_choose_move :: "Move \<Rightarrow> NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_first_player_winning_choose_move RESULT bst ast \<equiv>
      pre_first_player_winning_choose_move bst \<longrightarrow>
      inv_Move RESULT \<and> inv_Nim ast \<and>
      (let bms = (moves bst);
           ams = (moves ast);
           alim= (limit ast);
            ac = (current ast);
           pm = play_move ac RESULT ams;
          bm = best_move pm
        in
        pre_moves_left ams \<and> post_moves_left ams (moves_left ams) \<and>
        pre_who_plays_next ams \<and> post_who_plays_next ams (who_plays_next ams) \<and>
        pre_will_first_player_win alim \<and>
         pre_play_move ac RESULT ams \<and>
          post_play_move ac RESULT ams pm \<and>
          pre_best_move pm \<and> post_best_move pm (best_move pm) \<and>
          (limit bst) = (limit ast) \<and> (current bst) = (current ast) \<and> (moves bst) = (moves ast) \<and> 
          RESULT < moves_left ams \<and>
          (will_first_player_win alim \<longrightarrow> best_move pm = 0)
        )"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

definition
  first_player_winning_choose_move :: "NimSt \<Rightarrow> Move"
where
  "first_player_winning_choose_move st \<equiv> best_move (moves st)"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Example PO: operation satisfiability \<close>

text \<open>
	The satisfiability proof obligation of an operation $Op$ under state $St$ is:
	
	@{term[display] "\<forall> input \<in> Type . \<forall> bst \<in> State . pre_Op input bst \<longrightarrow> 
	      (\<exists> output \<in> Type . \<exists> ast \<in> State .  post_Op input output bst ast)"}
	
	That is, given any input and before state satisfying their invariants, if the precondition holds, then 
	find witnesses for the output and after state, such that the postcondition holds. 
	Operations without inputs or outputs can be declared similarly without the parameters.
	Operations with explicit definition have the witness choice fixed for the existential quantifiers.
	
	Overture PO generator (POG) produces different versions of the satisfiability PO, 
	depending on the kind of VDM declaration used (\textit{e.g.}~implicit, explicit, extended). 
	In essence, the POG expand/simplifies definitions, as well as take advantage of explicit 
	specification statements as witnesses to existential quantifiers. In doubt, use the 
	general template above.
\<close>

definition
  PO_first_player_winning_choose_move_sat_obl :: \<bool>
where
  "PO_first_player_winning_choose_move_sat_obl \<equiv> 
      \<forall> bst . pre_first_player_winning_choose_move bst \<longrightarrow> 
            (\<exists> RESULT ast . post_first_player_winning_choose_move RESULT bst ast)"

definition
  PO_first_player_winning_choose_move_sat_exp_obl0 :: \<bool>
where
  "PO_first_player_winning_choose_move_sat_exp_obl0 \<equiv> 
      \<forall> bst . pre_first_player_winning_choose_move0 bst \<longrightarrow> 
        post_first_player_winning_choose_move0 (first_player_winning_choose_move  bst) bst bst"

definition
  PO_first_player_winning_choose_move_sat_exp_obl :: \<bool>
where
  "PO_first_player_winning_choose_move_sat_exp_obl \<equiv> 
      \<forall> bst . pre_first_player_winning_choose_move bst \<longrightarrow> 
        post_first_player_winning_choose_move (first_player_winning_choose_move  bst) bst bst"

text\<open> As an illustration, a naive attempt at these kind of proofs by simply expanding
definitions and doing layered simplification will only work if appropriate lemmas
are in place. Previous proofs of satisfiability of involved functions will also be 
important in these POs about top-level operations. \<close>

theorem PO_first_player_winning_choose_move_sat_exp_obl
  unfolding PO_first_player_winning_choose_move_sat_exp_obl_def
unfolding pre_first_player_winning_choose_move_def
          post_first_player_winning_choose_move_def Let_def
apply simp
unfolding inv_Nim_def inv_Nim_flat_def
          inv_Moves_def inv_SeqElems_def
          inv_Move_def max_def
  apply simp
  unfolding
          pre_moves_left_def
          pre_best_move_def
          pre_best_move0_def
          post_best_move_def
          pre_who_plays_next_def
          pre_fair_play_def
          pre_play_move_def
          pre_sum_elems_def
  apply simp
  unfolding  moves_left_def
          best_move_def
          who_plays_next_def
          fair_play_def
          play_move_def
  apply simp
  unfolding  isFirst_def
          will_first_player_win_def
  apply safe
oops

(*-----------------------------------------------------------------------*)
subsection \<open> @{term save} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
save(choice : Move) == 
	(dcl ms  : Moves  := play_move(current, choice, moves),
			 next: Player := flip_current_player(current);
		--flip_player();, see flip_current_player(current) instead
		-- to keep the fair_play_invariant, we need to change both atomically
		atomic(
			moves := ms;
			current := next;
		);
		-- we want to debug who played last, so flip back
		debug(flip_current_player(current), choice);	  
	)	
ext wr current, moves
pre pre_play_move(current, choice, moves) 
post 
	post_play_move(current~, choice, moves~, moves)
	and
	current~ <> current
\end{vdmsl}
\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_save :: "Move \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "pre_save choice bst \<equiv> 
      inv_Nim bst \<and> inv_Move choice \<and>
      (let bc = (current bst);
           bms= (moves bst) 
       in
           pre_play_move bc choice bms)"

definition
  post_save :: "Move \<Rightarrow> NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_save choice bst ast \<equiv> 
      inv_Nim bst \<and> inv_Nim ast \<and> inv_Move choice \<and> 
      (let bc = (current bst);
           ac = (current ast);
           bms= (moves bst);
           ams= (moves ast) in
         ams = (play_move bc choice bms) \<and>
         post_play_move bc choice bms ams \<and>
         post_flip_current_player bc (flip_current_player bc) \<and>
         bc \<noteq> ac
       )"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

text \<open>
  For read-write operations, the after state must be returned together with any result value
  as a tupple or extended record. Like with read-only operations, if result is void, then just 
  the state is enough as a result type to avoid needing to handle tuples unnecessarily.

  Local variable declarations can be translated using @{term Let} expressions. Because Isabelle
  is always functional (\textit{i.e.}~referencially transparent), there is no need for atomic
  statements (\textit{i.e.}~there aren't any state updates as such:~a new state is built and
  returned as a result). You can either rebuild the whole state as a new record (@{term save}) 
  or use record update syntax (@{term save2}). 
\<close>

definition
  save :: "Move \<Rightarrow> NimSt \<Rightarrow> NimSt"
where
  "save choice bst \<equiv>  
    (let ms = play_move (current bst) choice (moves bst);
         next = flip_current_player (current bst) in 
         \<lparr> limit = (limit bst), current = next, moves = ms \<rparr>)"

definition
  save0 :: "NimSt \<Rightarrow> Move \<Rightarrow> NimSt"
where
  "save0 bst choice \<equiv>  
    (let ms = play_move (current bst) choice (moves bst);
         next = flip_current_player (current bst) in 
         bst \<lparr> current := next, moves := ms \<rparr>)"

(*-----------------------------------------------------------------------*)
subsection \<open> VDM while statement in Isabelle \<close>

(*
text \<open>
  While and for loops are imperative statements that are tricky to implement in Isabelle. 
  A simple alternative (in most cases) version uses tail-recursive functions.

  Like what happened with \texttt{sum\_elems} recursively-defined function, a tail-recursive 
  require a measure. In Isabelle, measure are created (mostly) automatically. To enjoy this
  automatic-measure creation for free, you must declare patterns that complete the recursive
  call options on the type given. This way Isabelle will know if the call-depth is decreasing
  with every new call. 

  Functions and pattern matching with records can be tricky. Instead, I will unpack the record
  as parameters. A version with the packaged state can be easily created on top.
\<close>

fun naive_play_game0 :: "Move \<Rightarrow> Player \<Rightarrow> Moves \<Rightarrow> NimSt"
where
  "naive_play_game0 l p []   = \<lparr> limit = l, current = p, moves = [] \<rparr>"
| "naive_play_game0 l p (x#xs) = (naive_play_game0 l p xs)"
*) (*<*) thm while_def (*>*)
text \<open> 
  The VDM while statement

\begin{vdmsl}[breaklines=true]
  (while b do c) s
\end{vdmsl}

  where $s$ is the before state that both the loop condition $b$ and 
  the loop body $c$ can talk about, can be translated to
  Isabelle using the @{term while} combinator as
  
  @{text[display] "while (\<lambda> st . b) 
                (\<lambda> st . c) 
                bst"} 
                
  @{term while} is defined in terms of a boolean-valued function from the  state 
  for the loop condition, a homogeneous function from the state for the loop body, 
  and the initial state itself. Sequential composition can be achieved with functional 
  composition. For example the VDM statement

\begin{vdmsl}[breaklines=true]
  (f(in) ; g(in)) 
\end{vdmsl}

  where $(in,st)$ are the inputs and (implicit) before state, can be translated to Isabelle 
  as @{text "(g in (f in s))"}. That is, the before state of $g$ is the after 
  state of $f$ executing on the given input and before state.

  As loops operate on intermediate values, they have different specification conditions as 
  the pre/post of operation's at entry/exit points. To ensure that type invariant consistency,
  as well as auxiliary functions and operations pre/post conditions are enforced, we create
  auxiliary Isabelle definitions to enable us to call the appropriate pre/post at the right 
  place. Moreover, loops should contain an invariant and variant statement (\textbf{TODO}!).
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> @{term naive_play_game} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
naive_play_game() ==
	((while moves_left(moves) > 0 do
			save(naive_choose_move())
		);
	 tally()
	)
ext wr current, moves
pre moves_left(moves) = MAX_PILE
post moves_left(moves) = 0;
\end{vdmsl}
\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_naive_play_game :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_naive_play_game bst \<equiv> 
      inv_Nim bst \<and> 
      (let bms = (moves bst) in
        pre_moves_left bms \<and> 
        post_moves_left bms (moves_left bms) \<and>
        moves_left bms = MAX_PILE)"

definition
  post_naive_play_game :: "NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_naive_play_game bst ast \<equiv> 
      pre_naive_play_game bst \<longrightarrow>  
      inv_Nim ast \<and>
      (let ams = (moves ast) in moves_left ams = 0)"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

definition 
  naive_play_game_inner_play :: "NimSt \<Rightarrow> NimSt"
where
  "naive_play_game_inner_play bst \<equiv> 
     save (naive_choose_move bst) bst"

term while
definition
  naive_play_game_loop :: "NimSt \<Rightarrow> NimSt"
where
  "naive_play_game_loop bst \<equiv> 
      while (\<lambda> param_st . moves_left (moves param_st) > 0) 
            (\<lambda> param_st . save (naive_choose_move param_st) param_st)
            bst"

definition
  naive_play_game0 :: "NimSt \<Rightarrow> NimSt"
where
  "naive_play_game0 bst \<equiv> 
      tally(naive_play_game_loop bst)"

definition
  naive_play_game :: "NimSt \<Rightarrow> NimSt"
where
  "naive_play_game bst \<equiv> 
      (naive_play_game_loop ;; tally, bst)" 

(*<*)
(* TODO: loop invariant? / post *)

definition
  pre_naive_play_game_loop :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_naive_play_game_loop blst \<equiv> 
      inv_Nim blst \<and>
      pre_moves_left (moves blst) \<and>
      pre_naive_choose_move blst \<and>
      pre_save (naive_choose_move blst) blst
      "
(*>*)

(*-----------------------------------------------------------------------*)
subsection \<open> @{term fixed_play_game} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fixed_play_game() ==
	((while moves_left(moves) > 0 do
			save(fixed_choose_move())
		);
	 tally()
	)
ext wr current, moves
pre moves_left(moves) = MAX_PILE
post moves_left(moves) = 0;
\end{vdmsl}
\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_fixed_play_game :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_fixed_play_game bst \<equiv> pre_naive_play_game bst"

definition
  post_fixed_play_game :: "NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_fixed_play_game bst ast \<equiv> post_naive_play_game bst ast"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

definition
  fixed_play_game_loop :: "NimSt \<Rightarrow> NimSt"
where
  "fixed_play_game_loop bst \<equiv> 
      while (\<lambda> bst . moves_left (moves bst) > 0) 
            (\<lambda> bst . save (fixed_choose_move bst) bst)
            bst"

definition
  fixed_play_game :: "NimSt \<Rightarrow> NimSt"
where
  "fixed_play_game bst \<equiv> (naive_play_game_loop ;; tally, bst)"

(*-----------------------------------------------------------------------*)
subsection \<open> @{term first_win_game} operation \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_win_game() ==
	((while moves_left(moves) > 0 do
		(dcl choice : Move := (if (isFirst(current)) then 
														first_player_winning_choose_move() 
													else
														naive_choose_move());  
			save(choice)
		)
	 );
	 tally()
	)
ext wr current, moves
pre moves_left(moves) = MAX_PILE
post moves_left(moves) = 0;
\end{vdmsl}
\<close>

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Specification \<close>

definition
  pre_first_win_game :: "NimSt \<Rightarrow> \<bool>"
where
  "pre_first_win_game bst \<equiv> pre_naive_play_game bst"

definition
  post_first_win_game :: "NimSt \<Rightarrow> NimSt \<Rightarrow> \<bool>"
where
  "post_first_win_game bst ast \<equiv> post_naive_play_game bst ast"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Implementation \<close>

definition
  first_win_game_loop :: "NimSt \<Rightarrow> NimSt"
where
  "first_win_game_loop bst \<equiv> 
      while (\<lambda> bst . moves_left (moves bst) > 0) 
            (\<lambda> bst . (let choice = (if (isFirst (current bst)) then 
                                      first_player_winning_choose_move bst
                                    else 
                                      naive_choose_move bst
                                   ) 
                       in (save choice bst)
                     ) 
            ) bst"

definition
  first_win_game :: "NimSt \<Rightarrow> NimSt"
where
  "first_win_game bst \<equiv> (first_win_game_loop ;; tally, bst)" 

(*************************************************************************)
section \<open> VDM proof obligations \<close>

text \<open>
  The Overture proof obligation generator (POG) can be executed either from the
  context menu of the corresponding project, via the command line, or via the console. 
  The context menu fills in the PO explorer view, whereas the console prints POs in 
  Overture/VDM syntax. If you run the console, it is easier to copy-and-paste the POs' text 
  for translation to Isabelle. The console POG will generate POs for all modules in the
  project. You should be careful to only consider the POs from modules of interest only. 
  To avoid confusion, PO names should be like their corresponding description prefixed with PO, 
  and be declared as a @{typ \<bool>} definition to be proved. Note that Isabelle will not declare
  implicitly enforced/expected type invariants. So just like for other definitions, type invariants
  need to be explicit added for quantified variables. Isabelle on the other hand, will do base type inference.
  For \texttt{NimFull.vdmsl}, POG generated $40$ POs, some of which I discuss below.
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> PO1 \<close>

text\<open>
Move: type invariant satisfiable obligation @ in 'NimFull' (./NimFull.vdmsl) at line 23:1
\begin{vdmsl}[breaklines=true]
(exists m:Move & (m <= MAX_MOV))
Proof Obligation 01: (Unproved)
\end{vdmsl}
\<close>

definition 
  PO01_move_type_inv_sat_obl :: \<bool>
where
  "PO01_move_type_inv_sat_obl \<equiv> \<exists> m . inv_Move m \<and>  m \<le> MAX_MOV"

theorem PO01_move_type_inv_sat_obl
unfolding PO01_move_type_inv_sat_obl_def inv_Move_def 
using inv_VDMNat1_def by force (* SH *)

definition 
  PO01_move_type_inv_sat_obl_gen :: \<bool>
where
  "PO01_move_type_inv_sat_obl_gen \<equiv> \<exists> m . inv_VDMNat1 m \<and> m \<le> G_MAX_MOV \<and>  m \<le> G_MAX_MOV"

theorem PO01_move_type_inv_sat_obl_gen
  unfolding PO01_move_type_inv_sat_obl_gen_def  
using inv_VDMNat1_def n1_MM by blast (* SH *)

(*-----------------------------------------------------------------------*)
subsection \<open> PO2 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
Moves: legal sequence application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 32:30
(forall s:seq of (Move) & ((sum_elems(s) <= MAX_PILE) => ((sum_elems(s) = MAX_PILE) => ((len s) in set (inds s)))))
Proof Obligation 02: (Unproved)
\end{vdmsl}
\<close>

text \<open>
  For universally quantified proofs, type invariants are to be considered as a guard. 
  That is, if the invariant hold, then the PO must follow;~otherwise, we do not care. 
  That is an accurate representation for what Isabelle type inference does to the bound 
  variables. For instance

  \[
  @{term "\<forall> x \<in> \<nat> . f x > (0::nat)"}
  =
  @{term "\<forall> x . x \<in> \<nat> \<longrightarrow> f x > (0::nat)"}
  \]

  So, whenever @{term "x \<notin> \<nat>"}, then we do not care about the value of the expression.
\<close>

value "len [a,b]"
value "inds [a,b]"

definition 
  PO02_moves_legal_seq_app_obl :: \<bool>
where
  "PO02_moves_legal_seq_app_obl \<equiv> \<forall> s . (inv_SeqElems inv_Move s) \<longrightarrow> 
      (sum_elems s \<le> MAX_PILE \<longrightarrow> (sum_elems s = MAX_PILE) \<longrightarrow> (len s \<in> inds s))"

theorem PO02_moves_legal_seq_app_obl
  unfolding PO02_moves_legal_seq_app_obl_def inv_Moves_def
apply (intro allI impI)
apply simp
apply (erule sum_elems.elims)
   apply simp+
  unfolding len_def 
  apply simp
done

(*-----------------------------------------------------------------------*)
subsection \<open> PO3 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
Moves: type invariant satisfiable obligation @ in 'NimFull' (./NimFull.vdmsl) at line 26:1
(exists s:Moves & ((sum_elems(s) <= MAX_PILE) and ((sum_elems(s) = MAX_PILE) => (s((len s)) = 1))))
Proof Obligation 03: (Unproved)
\end{vdmsl}
\<close>

text \<open> For commonly used combinations of definitions to be unfolded, you can use a 
  @{term lemmas} command to give a synonym for a group of definitions. \<close>
  
definition 
  PO03_moves_type_inv_sat_obl :: \<bool>
where
  "PO03_moves_type_inv_sat_obl \<equiv> \<exists> s . inv_Moves s \<and> 
      (sum_elems s \<le> MAX_PILE \<longrightarrow> (sum_elems s = MAX_PILE) \<longrightarrow> applyVDMSeq s (len s) = 1)"

theorem PO03_moves_type_inv_sat_obl
  unfolding PO03_moves_type_inv_sat_obl_def applyVDMSeq_def  oops 

text \<open> Postcondition of @{term sum_elems} is just @{term True}, hence this  \<close>

(*-----------------------------------------------------------------------*)
subsection \<open> PO4 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
sum_elems: function establishes postcondition obligation @ in 'NimFull' (./NimFull.vdmsl) at line 37:1
(forall s:seq of (Move) & post_sum_elems(s, (cases s :
[] -> 0,
[x] ^ xs -> (x + sum_elems(xs))
 end)))
Proof Obligation 04: (Unproved)
\end{vdmsl}
\<close>

definition
  PO04_sum_elems_post_obl :: "\<bool>"
where
  "PO04_sum_elems_post_obl \<equiv> \<forall> ms . inv_SeqElems inv_Move ms \<longrightarrow> 
      post_sum_elems ms (case ms of [] \<Rightarrow> 0 | (x#xs) \<Rightarrow> x + sum_elems xs)"

theorem PO04_sum_elems_post_obl
unfolding PO04_sum_elems_post_obl_def inv_Move_def inv_VDMNat1_def inv_VDMNat_def pre_sum_elems_def post_sum_elems_def
apply (rule allI)
apply (case_tac ms)
  apply (intro impI conjI iffI, simp_all)
apply (subgoal_tac "inv_SeqElems inv_Move ms")
apply (frule l_sum_elems_nat)
  apply (simp add: l_sum_elems_nat)
  using l_pre_sum_elems apply force
nitpick[user_axioms]
find_theorems "sum_elems _"
oops

text \<open> Because @{term sum_elems} is recursively defined in Isabelle,
  its proof obligations from Overure related to recursive definitions are irrelevant. 
  That is because Isabelle automatically proves such POs implicitly. For example,
  
  @{thm[display] sum_elems.induct sum_elems.cases}
\<close>

(*<*)
find_theorems name:sum_elems
(*-----------------------------------------------------------------------*)
subsection \<open> PO5 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
sum_elems: recursive function obligation @ in 'NimFull' (./NimFull.vdmsl) at line 41:17
(forall s:seq of (Move) & ((not ([] = s)) => (exists [x] ^ xs:seq of (Move) & ((([x] ^ xs) = s) => let [x] ^ xs = s in (sum_elems_measure(s) > sum_elems_measure(xs))))))
Proof Obligation 05: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> PO6 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
sum_elems: cases exhaustive obligation @ in 'NimFull' (./NimFull.vdmsl) at line 39:2
(forall s:seq of (Move) & ((s = []) or (exists [x] ^ xs:seq of (Move) & (s = ([x] ^ xs)))))
Proof Obligation 06: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> PO7 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fair_play: legal function application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 59:25
(forall p:Player, ms:Moves & pre_who_plays_next(ms))
Proof Obligation 07: (Unproved)
\end{vdmsl}
\<close>
(*-----------------------------------------------------------------------*)
subsection \<open> PO8 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
moves_left: type compatibility obligation @ in 'NimFull' (./NimFull.vdmsl) at line 61:1
(forall ms:Moves & ((MAX_PILE - sum_elems(ms)) >= 0))
Proof Obligation 08: (Unproved)
\end{vdmsl}
\<close>
(*-----------------------------------------------------------------------*)
subsection \<open> PO9\<close>

text\<open>
\begin{vdmsl}[breaklines=true]
play_move: function establishes postcondition obligation @ in 'NimFull' (./NimFull.vdmsl) at line 64:1
(forall p:Player, m:Move, s:Moves & (pre_play_move(p, m, s) => post_play_move(p, m, s, (s ^ [m]))))
Proof Obligation 09: (Unproved)
\end{vdmsl}
\<close>
(*-----------------------------------------------------------------------*)
subsection \<open> PO10 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
play_move: type compatibility obligation @ in 'NimFull' (./NimFull.vdmsl) at line 64:1
(forall p:Player, m:Move, s:Moves & (((moves_left(s) <> 1) => ((m < moves_left(s)) and ((moves_left(s) > 0) and fair_play(p, s)))) => inv_Moves((s ^ [m]))))
Proof Obligation 10: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> PO11 \<close>
text\<open>
\begin{vdmsl}[breaklines=true]
who_won_invariant: legal function application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 93:11
(forall winner:Player, moves:Moves & ((moves_left(moves) = 0) => pre_who_plays_next(moves)))
Proof Obligation 11: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P12 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_player: function establishes postcondition obligation @ in 'NimFull' (./NimFull.vdmsl) at line 102:1
post_first_player((if isFirst(<P1>)
then <P1>
else <P2>))
Proof Obligation 12: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P13 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_player_inds: function establishes postcondition obligation @ in 'NimFull' (./NimFull.vdmsl) at line 106:1
(forall ms:Moves & post_first_player_inds(ms, {i | i in set (inds ms) & ((i mod 2) <> 0)}))
Proof Obligation 13: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P14 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
moves_of: legal sequence application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 113:6
(forall ms:Moves, first:bool & let idxs:set of (nat1) = first_player_inds(ms) in (forall i in set (if first
then idxs
else ((inds ms) \ idxs)) & (i in set (inds ms))))
Proof Obligation 14: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P15 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
best_move: function establishes postcondition obligation @ in 'NimFull' (./NimFull.vdmsl) at line 119:1
(forall moves:Moves & post_best_move(moves, ((moves_left(moves) - 1) mod (MAX_MOV + 1))))
Proof Obligation 15: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P16 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
best_move: type compatibility obligation @ in 'NimFull' (./NimFull.vdmsl) at line 119:1
(forall moves:Moves & (((moves_left(moves) - 1) mod (MAX_MOV + 1)) >= 0))
Proof Obligation 16: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P17 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
flip_current_player: function establishes postcondition obligation @ in 'NimFull' (./NimFull.vdmsl) at line 129:1
(forall p:Player & post_flip_current_player(p, (if (p = <P1>)
then <P2>
else <P1>)))
Proof Obligation 17: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P18 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
limit, limit~, current, current~, moves, moves~, Nim, Nim~: state invariant satisfiable obligation @ in 'NimFull' (./NimFull.vdmsl) at line 133:7
(exists limit:Move, current:Player, moves:Moves & ((limit < MAX_PILE) and (fair_play(current, moves) and isFirst(<P1>))))
Proof Obligation 18: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P19 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
flip_player: state invariant holds obligation @ in 'NimFull' (./NimFull.vdmsl) at line 170:2
let mk_Nim(limit, current, moves) = Nim in ((limit < MAX_PILE) and (fair_play(current, moves) and isFirst(<P1>)))
Proof Obligation 19: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P20 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
naive_choose_move: let be st existence obligation @ in 'NimFull' (./NimFull.vdmsl) at line 189:6
(exists m in set {1, ... ,min(MAX_MOV, moves_left(moves))} & true)
Proof Obligation 20: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P21 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
naive_choose_move: type compatibility obligation @ in 'NimFull' (./NimFull.vdmsl) at line 187:1
(inv_Move(r) and is_(r, nat1))
Proof Obligation 21: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P22 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
io_choose_move: type compatibility obligation @ in 'NimFull' (./NimFull.vdmsl) at line 196:1
(inv_Move(r) and is_(r, nat1))
Proof Obligation 22: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P23 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fixed_choose_move: legal function application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 214:10
((moves_left(moves) > 0) => ((r < moves_left(moves)) => (will_first_player_win() => pre_who_plays_next(moves))))
Proof Obligation 23: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P24 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fixed_choose_move: legal function application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 215:15
((moves_left(moves) > 0) => (((r < moves_left(moves)) and (will_first_player_win() and isFirst(who_plays_next(moves)))) => pre_play_move((if (current = <P1>)
then <P2>
else <P1>), r, moves)))
Proof Obligation 24: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P25 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fixed_choose_move: legal sequence application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 204:9
(((len moves) + 1) in set (inds FIXED_PLAY))
Proof Obligation 25: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P26 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_player_winning_choose_move: legal function application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 228:39
((moves_left(moves) > 0) => (((r < moves_left(moves)) and will_first_player_win()) => pre_play_move((if (current = <P1>)
then <P2>
else <P1>), r, moves)))
Proof Obligation 26: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P27 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_player_winning_choose_move: type compatibility obligation @ in 'NimFull' (./NimFull.vdmsl) at line 218:1
(inv_Move(r) and is_(r, nat1))
Proof Obligation 27: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P28 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
save, ms: legal function application obligation @ in 'NimFull' (./NimFull.vdmsl) at line 232:22
pre_play_move((if (current = <P1>)
then <P2>
else <P1>), choice, moves)
Proof Obligation 28: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P29 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
save: state invariant holds obligation @ in 'NimFull' (./NimFull.vdmsl) at line 236:3
(inv_Nim(mk_Nim(limit, current, moves)) => inv_Nim(mk_Nim(limit, next, ms)))
Proof Obligation 29: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P30 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
naive_play_game: while loop termination obligation @ in 'NimFull' (./NimFull.vdmsl) at line 252:4
...
Proof Obligation 30: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P31 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
naive_play_game: operation call obligation @ in 'NimFull' (./NimFull.vdmsl) at line 253:4
pre_play_move((if (current = <P1>)
then <P2>
else <P1>), naive_choose_move(), moves)
Proof Obligation 31: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P32 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fixed_play_game: while loop termination obligation @ in 'NimFull' (./NimFull.vdmsl) at line 262:4
...
Proof Obligation 32: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P33 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
fixed_play_game: operation call obligation @ in 'NimFull' (./NimFull.vdmsl) at line 263:4
pre_play_move((if (current = <P1>)
then <P2>
else <P1>), fixed_choose_move(), moves)
Proof Obligation 33: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P34 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_win_game: while loop termination obligation @ in 'NimFull' (./NimFull.vdmsl) at line 272:4
...
Proof Obligation 34: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P35 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
first_win_game: operation call obligation @ in 'NimFull' (./NimFull.vdmsl) at line 277:4
pre_play_move((if (current = <P1>)
then <P2>
else <P1>), choice, moves)
Proof Obligation 35: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P36 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
reset: state invariant holds obligation @ in 'NimFull' (./NimFull.vdmsl) at line 288:3
(inv_Nim(mk_Nim(limit, current, moves)) => inv_Nim(mk_Nim(limit, first_player(), [])))
Proof Obligation 36: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P37 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
all_play_game: operation call obligation @ in 'NimFull' (./NimFull.vdmsl) at line 301:3
(moves_left(moves) = MAX_PILE)
Proof Obligation 37: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P38 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
all_play_game: operation call obligation @ in 'NimFull' (./NimFull.vdmsl) at line 306:3
((moves_left(moves) = 0) => (true => (moves_left(moves) = MAX_PILE)))
Proof Obligation 38: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P39 \<close>


text\<open>
\begin{vdmsl}[breaklines=true]
all_play_game: operation call obligation @ in 'NimFull' (./NimFull.vdmsl) at line 311:3
((moves_left(moves) = 0) => (true => ((moves_left(moves) = 0) => (true => (moves_left(moves) = MAX_PILE)))))
Proof Obligation 39: (Unproved)
\end{vdmsl}
\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> P40 \<close>

text\<open>
\begin{vdmsl}[breaklines=true]
FIXED_PLAY: type compatibility obligation @ in 'NimFull' (./NimFull.vdmsl) at line 316:21
(inv_Moves([3, 2, 2, 1, 3, 2, 2, 1, 3, 1]) and (((((((((inv_Move(3) and inv_Move(2)) and inv_Move(2)) and inv_Move(1)) and inv_Move(3)) and inv_Move(2)) and inv_Move(2)) and inv_Move(1)) and inv_Move(3)) and inv_Move(1)))
Proof Obligation 40: (Unproved)
\end{vdmsl}
\<close>
find_theorems name:play_move  
end
(*>*)