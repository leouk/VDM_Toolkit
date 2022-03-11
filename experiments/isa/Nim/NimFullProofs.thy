theory NimFullProofs
imports NimFull
begin 

(*************************************************************************)
subsection \<open> Proving function and operation satisfiability POs \<close>

text \<open>
  Next, we illustrate the general PO setup for all auxiliary functions. 
  After the translation is complete, one needs to translate proof obligations to ensure
  pre/post are satisfiable. The theorem layout depends on whether there is an explicit definition 
 for the auxiliary function, given explicit definitions will determine the existential witness(es). 
 For instance, for an implicitly defined VDM function

 \begin{vdmsl}[breaklines=true]
 f(i: T1) r: T2
 pre pre_f(i)
 post post_f(i, r)
 \end{vdmsl}

 we need to prove this satisfiability theorem in Isabelle:

 @{term[display] "\<forall> i . inv_T1 i \<longrightarrow> pre_f i \<longrightarrow> (\<exists> r . inv_T2 r \<and> post_f i r)"}

  whereas, for an explicitly defined VDM function

 \begin{vdmsl}[breaklines=true]
 f: T1 -> T2
 f(i) == expr
 pre pre_f(i)
 post post_f(i, RESULT)
 \end{vdmsl}

 we need to prove this satisfiability theorem in Isabelle:
 
 @{term[display] "\<forall> i . pre_f i \<longrightarrow> post_f i expr"}

  That is, if the pre condition holds (\textit{i.e.},~@{term "pre_f i"}), then 
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

(*------------------------------------------------------------------------*)
subsection \<open> Role of lemmas \<close>

text \<open> Some lemmas proved in the process of discovering the proofs, 
  a few turned out not to be necessary in the final proof, but helped in discovering 
  the problems with the precondition of @{term play_move}.
 \<close>

(*************************************************************************)
section \<open> Satisfiability PO @{term play_move} \<close>

(*------------------------------------------------------------------------*)
subsection \<open> Simpler variant of @{term play_move} \<close>

text \<open>A simpler (earlier) version of @{term play_move} was defined in VDM as:
%
\begin{vdmsl}[breaklines=true]
play: Move * Moves -> Moves
play(m, s) == s ^ [m]
pre 
	m <= moves_left(s)
	and
	moves_left(s) > 0
post 
	sum_elems(s) < sum_elems(RESULT)
	and
	sum_elems(s) + m = sum_elems(RESULT) 
\end{vdmsl}

It is useful here as it is simpler than the current version, which we will prove below.
Also, we define the version of @{term inv_Moves} that doesn't take the specification (pre/post)
of @{term sum_elems} below. 
\<close>
definition
  inv_MovesNim0 :: "Moves \<Rightarrow> \<bool>"
where
  "inv_MovesNim0 s \<equiv> 
      inv_SeqElems inv_Move s \<and> 
      (sum_elems s) \<le> MAX_PILE \<and> 
      ((sum_elems s) = MAX_PILE \<longrightarrow> s $ (len s) = 1)"  

definition
  pre_play_moveNim0 :: "Move \<Rightarrow> Moves \<Rightarrow> \<bool>"
where
  "pre_play_moveNim0 m s \<equiv> 
      inv_Move m \<and> inv_MovesNim0 s \<and>
      m \<le> (moves_left s) \<and> (moves_left s) > 0"

definition
  post_play_moveNim0 :: "Move \<Rightarrow> Moves \<Rightarrow> Moves \<Rightarrow> \<bool>"
where
  "post_play_moveNim0 m s RESULT \<equiv> 
      inv_Move m \<and> inv_MovesNim0 s \<and> inv_MovesNim0 RESULT \<and> 
      sum_elems s < sum_elems RESULT \<and>
      sum_elems s + m = sum_elems RESULT"

definition
  PO_play_moveNim0_sat_obl0 :: "\<bool>"
where
  "PO_play_moveNim0_sat_obl0 \<equiv> \<forall> m s . inv_Move m \<longrightarrow> inv_MovesNim0 s \<longrightarrow> 
      pre_play_moveNim0 m s \<longrightarrow> post_play_moveNim0 m s (s @ [m])"
  
theorem PO_play_moveNim0_sat_obl0 
  using[[show_types=false]]
unfolding PO_play_moveNim0_sat_obl0_def
apply simp
unfolding
 pre_play_moveNim0_def post_play_moveNim0_def 
  apply simp
  unfolding inv_Moves_def inv_MovesNim0_def
  apply simp
  apply safe
  txt \<open>too many similar goals. expanding won't work.\<close>
  oops

(*------------------------------------------------------------------------*)
subsection \<open> PO for the current version of @{term play_move} \<close>

definition
  PO_play_move_sat_obl :: "\<bool>"
where
  "PO_play_move_sat_obl \<equiv> \<forall> p m s . inv_Move m \<longrightarrow> inv_Moves s \<longrightarrow> 
      pre_play_move p m s \<longrightarrow> (\<exists> r . post_play_move p m s r)"

theorem PO_play_move_sat_obl 
  using[[show_types=false]]
unfolding PO_play_move_sat_obl_def
apply simp
unfolding
 pre_play_move_def post_play_move_def 
  apply simp
  apply (intro allI impI conjI,elim conjE)
  apply (rule_tac x="s @ [m]" in exI)
  apply (simp)
  apply safe
txt \<open> @{subgoals[display,indent=0]} These goals will require various lemmas. \<close>
oops

lemma "inv_Move m \<Longrightarrow>
       inv_Moves s \<Longrightarrow> inv_Moves (s @ [m])"  
  unfolding inv_Moves_def
  apply safe 
  txt \<open> important one that will be difficult to finish \<close>
  oops
    
definition
  PO_play_move_sat_exp_obl :: "\<bool>"
where
  "PO_play_move_sat_exp_obl \<equiv> \<forall> p m s . 
      pre_play_move p m s \<longrightarrow> post_play_move p m s (play_move p m s)"

(*-----------------------------------------------------------------------*)
subsection \<open> Naive attempt with split lemmas \<close>

declare [[show_types=false]]
theorem PO_play_move_sat_exp_obl
  unfolding PO_play_move_sat_exp_obl_def
  apply safe
  unfolding post_play_move_def 
  apply safe
  unfolding post_sum_elems_def
  unfolding pre_play_move_def pre_sum_elems_def 
                      apply simp_all
  txt \<open> too many subgoals if you apply safe\<close>
  apply safe
  oops

  text \<open>Lemmas based  on the goals before applying safe above.\<close>

lemma l1: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> inv_Moves (play_move p m s)"
  unfolding play_move_def pre_play_move0_def
  apply (safe, simp_all) 
  txt \<open> sledgehammer failed \<close>  
  oops

lemma l1: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> inv_Moves (play_move p m s)"
  unfolding play_move_def pre_play_move0_def
  apply (safe, simp_all)
  unfolding moves_left_def inv_Moves_def Let_def
   apply (simp, safe, simp_all)
  unfolding post_sum_elems_def pre_sum_elems_def 
  txt \<open> naive strategy doesn't work. You can use sorry to discover the 
        splitting lemmas to be proved next: that is, will they help the larger proof? \<close>
    (*sorry*)  oops

lemma l2: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> pre_sum_elems s"
    using inv_Moves_def by blast

lemma l3: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> pre_sum_elems (play_move p m s)"
  (*using inv_Moves_def l1 apply blast sorry *) oops 

text \<open> The fact this proof is the same as l2, might mean they are the same goal? \<close>
lemma l4: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> inv_SeqElems inv_Move s"
  using inv_Moves_def by blast

lemma l2_same_l4: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> pre_sum_elems s"
  unfolding pre_sum_elems_def by (simp add: l4)

text \<open>Study @{term "l_sum_elems_nat x"}: the meson proof \<close>
lemma l5: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> inv_VDMNat (sum_elems s)"
  (*
    "cvc4": Try this: by (simp add: inv_VDMNat_def l4 l_sum_elems_nat) (3 ms) 
 "vampire": Try this: by (meson inv_Moves_def post_sum_elems_def) (12 ms)
   *)
by (meson inv_Moves_def post_sum_elems_def)

text \<open> @{term l5} seems the same as @{term l6} \<close>
lemma l6: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> s \<noteq> [] \<Longrightarrow> 0 < sum_elems s"
  by (meson inv_Moves_def post_sum_elems_def)

text \<open> @{term l7} seems similar / more general to @{term l3} \<close>
lemma l7: "inv_Move m \<Longrightarrow>
       inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> inv_SeqElems inv_Move (play_move p m s)"
(*  "cvc4": Try this: using inv_Moves_def l1 apply blast (4 ms) 
"vampire": Try this: apply (simp add: inv_Moves_def play_move_def) (4 ms)
*)    
  (* using inv_Moves_def l1 apply blast sorry *) oops

lemma l8: "inv_Move m \<Longrightarrow>
       inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> inv_VDMNat (sum_elems (play_move p m s))"
(*"cvc4": Try this: using inv_Moves_def inv_VDMNat_def l1 l_sum_elems_nat apply blast (8 ms) 
"vampire": Try this: apply (meson inv_Moves_def l1 post_sum_elems_def) (6 ms) *)
  (* apply (meson inv_Moves_def l1 post_sum_elems_def) 
  sorry*) oops

text \<open> @{term l9} seems similar to @{term l5} \<close>
lemma l9: " inv_Move m \<Longrightarrow>
       inv_Moves s \<Longrightarrow>
       pre_play_move0 p m s \<Longrightarrow> play_move p m s \<noteq> [] \<Longrightarrow> 0 < sum_elems (play_move p m s)"
 (* "cvc4": Try this: by (simp add: l7 l_sum_elems_nat1) (3 ms) 
"vampire": Try this: using l3 l_pre_sum_elems_sat by blast (1 ms)*)
  (*using l3 l_pre_sum_elems_sat apply blast 
   sorry *) oops

lemma l10: " inv_Move m \<Longrightarrow>
       inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> sum_elems s < sum_elems (play_move p m s)"
  unfolding pre_play_move0_def play_move_def (*sum_elems_def *)
  apply (simp)
  apply (safe,simp_all) 
   apply (induct s)
  apply simp_all
  (*sorry*) oops

lemma l11: " inv_Move m \<Longrightarrow>
       inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> sum_elems s + m = sum_elems (play_move p m s)"
  unfolding pre_play_move0_def play_move_def (*sum_elems_def *)
  apply (simp)
  apply (safe,simp_all) (*sorry*) oops

lemma l12: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> fair_play p s \<Longrightarrow> \<not> fair_play p (play_move p m s)"
  unfolding fair_play_def who_plays_next_def play_move_def
  apply (simp split: if_splits)
  apply auto[1]
  by (simp add: mod_add_cong)   

text \<open> 12 lemmas, 5 lemmas (42%~) proofs found through sledgehammer, 2 lemmas (l1, l10) seems similar, 
      l11 is close to l10, other unproved lemmas very much depend on those.

Lemmas with ``sorry'' are dangerous: if you don't prove them, you haven't finished. I left the above
lemmas in place to enable you to see how they play in the proof below (i.e. change oops for sorry to see). 
 \<close>

theorem PO_play_move_sat_exp_obl
  unfolding PO_play_move_sat_exp_obl_def
  unfolding post_play_move_def 
  unfolding post_sum_elems_def
  apply (safe, simp_all)+
  txt \<open> All goals below are discovered with sledgehammer.\<close>
  (*using l1 l_inv_Move_nat1 pre_play_move0_def pre_play_move_def apply fastforce*) defer
  apply (simp add: pre_moves_left_def pre_play_move_def)
          apply (simp add: inv_Moves_def l_inv_SeqElems_append play_move_def pre_sum_elems_def)
  apply (simp add: inv_Moves_def pre_play_move_def)
  using inv_VDMNat_def l_sum_elems_nat pre_sum_elems_def apply blast
        apply (simp add: l_pre_sum_elems_sat)
       apply (simp add: inv_VDMNat_def l_sum_elems_nat pre_sum_elems_def)
  (*using l_pre_sum_elems_sat apply blast*) defer
  (*using l10 l_inv_Move_nat1 pre_play_move0_def pre_play_move_def apply fastforce*) defer
  (*using l11 l_inv_Move_nat1 pre_play_move0_def pre_play_move_def apply fastforce*) defer
  using l12 pre_play_move_def (*apply blast*)
  apply (simp add: play_move_def)
  oops

  text \<open>Only l1 l10 l11 l12 are needed, but first three have ``sorried'' proofs. 
We need to finish their proofs for this proof
 to be valid:~at least we established that they are the lemmas that will help with this proof.

I leave their proof as an exercise --- some of it will be redone/reorganised below anyhow.\<close>

(*-----------------------------------------------------------------------*)
subsection \<open> Lemmas about auxiliary function @{term sum_elems} \<close>

fun nconcat :: "\<int> list \<Rightarrow> \<int> list \<Rightarrow> \<int> list"
where
  "nconcat [] ys     = ys"
| "nconcat (x#xs) ys = x # (nconcat xs ys)"

lemma l_concat_append : "nconcat xs ys = xs @ ys"
apply (induct ys, simp_all) oops

lemma l_concat_append : "nconcat xs ys = xs @ ys"
by (induct xs, simp_all)

text \<open>Definitions using sequence cons (@{term "x # xs"}) will need lemmas about 
sequence append (@{term "s @ t"}).\<close>

lemma l_sum_elems_nconcat: "sum_elems (nconcat ms [m]) = (m + sum_elems ms)" 
(*--"using [[rule_trace,simp_trace]]"*)
apply (induct ms, simp_all) done

text \<open> Some interesting lemmas about @{term sum_elems}

   @{thm[display,indent=0] l_sum_elems_nat l_sum_elems_nat1 l_pre_sum_elems }
  
\<close>
(*<*)find_theorems "sum_elems _" name:sum(*>*)

(*-----------------------------------------------------------------------*)
subsection \<open> Lemma discovery through failed proof attempts \<close>

text \<open>
The proof attempt above for succeeded but there were lemmas missing their proofs. Let's try again,
 this time with the current version of @{term play_move} and without any ``sorry'' theorems.

  \begin{enumerate}
    \item[1] Naive attempt:~layered expansion followed by simplification.
  \end{enumerate}
\<close>

theorem PO_play_move_sat_exp_obl
  unfolding PO_play_move_sat_exp_obl_def post_play_move_def play_move_def
apply (safe)
txt \<open> @{subgoals[display,indent=0]}

  The subgoals come directly from the @{term post_play_move} for the given witness:

  @{thm[display] post_play_move_def[of p m ms "ms @ [m]"] }

  After simplifying the already parts of the input invariants, we get
\<close>
apply (simp_all)
txt \<open> @{subgoals[display,indent=0]}

  We will create a lemma for each expression that is not already part of the precondition.
  Moreover, it is interesting that @{term fair_play} does not appear in the post condition:~it ought to. 

  I will tackle the expressions from simplest to most complex. This is a useful tactic as simpler
  goals will be easier to prove. 

  What each say:

  \begin{enumerate}
    \item @{term inv_Moves} is preserved on @{term "s @ [m]"}
    \item @{term "pre_sum_elems s"} is trivial from @{term pre_play_move}
    \item 
    \item @{term "post_sum_elems s"} is trivial from @{term pre_play_move}
    \item 
  \end{enumerate}
\<close>
oops
(*<*)thm pre_moves_left_def[of ms]
         pre_play_move_def[of p m ms] 
         post_play_move_def[of p m ms "ms @ [m]"]
(*
pre_play_move p m ms \<equiv>
  inv_Player p \<and>
  inv_Move m \<and>
  inv_Moves ms \<and>
  pre_moves_left ms \<and>
  pre_fair_play p ms \<and>
  post_fair_play p ms (fair_play p ms) \<and>
  (moves_left ms \<noteq> 1 \<longrightarrow> m < moves_left ms) \<and> (moves_left ms = m \<longrightarrow> m = 1) \<and> fair_play p ms

post_play_move p m ms (ms @ [m]) \<equiv>
  pre_play_move p m ms \<longrightarrow>
  inv_Moves (ms @ [m]) \<and>
  pre_sum_elems ms \<and>
  pre_sum_elems (ms @ [m]) \<and>
  post_sum_elems ms (sum_elems ms) \<and>
  post_sum_elems (ms @ [m]) (sum_elems (ms @ [m])) \<and>
  sum_elems ms < sum_elems (ms @ [m]) \<and>
  sum_elems ms + m = sum_elems (ms @ [m]) \<and> \<not> fair_play p (ms @ [m]) \<and> ms \<sqsubseteq> ms @ [m]

proof (prove)
goal (8 subgoals):
 1. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> inv_Moves (s @ [m])
 2. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> pre_sum_elems s
 3. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> pre_sum_elems (s @ [m])
 4. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> post_sum_elems s (sum_elems s)
 5. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> post_sum_elems (s @ [m]) (sum_elems (s @ [m]))
 6. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> sum_elems s < sum_elems (s @ [m])
 7. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> sum_elems s + m = sum_elems (s @ [m])
 8. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> fair_play p (s @ [m]) \<Longrightarrow> False
*)
(*>*)

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Lemmas per subgoal\<close>

text \<open> 
For each subgoal above, let's try and create lemmas (and their generalisations). The first subgoal
is difficult:~it relies on @{term inv_Moves}, which contains various predicates, so we start the next goal.

  The precondition knows about @{term pre_moves_left}, which knows about @{term pre_sum_elems}.
  The next lemma weakens the goal:~if you get a @{term pre_sum_elems} to handle, you can exchange it with
  a @{term pre_moves_left}. This fits with the necessary proof to do, but is not quite a general lemma.
\<close>

lemma l_moves_left_pre_sume: "pre_moves_left ms \<Longrightarrow> pre_sum_elems ms"
by (simp add: pre_moves_left_def) (*SH, subgoal 2~*)

lemma l_pre_sume_seqelems_move: "inv_SeqElems inv_Move ms \<Longrightarrow> pre_sum_elems ms"
by (simp add: pre_sum_elems_def) (*SH, subgoal 2~*)

text \<open> The next lemma helps Isabelle infer (forwardly) that, if @{term "inv_Moves ms"} holds, then
so would the smaller claim that all elements within the sequence respect @{term inv_Move}. As you will
see in proofs below, this lemma is useful in bridging the gap between what is needed for the lemma proof,
and what is available in the goal where the lemma is to be used (i.e. the simpler the lemma conditions the
better/most applicable the lemma will be). \<close>

lemma l_inv_Moves_inv_SeqElems: "inv_Moves ms \<Longrightarrow> inv_SeqElems inv_Move ms"
using inv_Moves_def by blast (*SH, useful for subgoal 2*)

lemma l_sg2_pre_sume: "inv_Moves ms \<Longrightarrow> pre_sum_elems ms"(*
"z3": Try this: using inv_Moves_def by blast (0.5 ms). 
"spass": Try this: using inv_Moves_def by blast (1 ms). 
"cvc4": Try this: by (simp add: l_inv_Moves_inv_SeqElems l_pre_sume_seqelems_move) (0.6 ms). 
"remote_vampire": Try this: by (simp add: l_inv_Moves_inv_SeqElems l_pre_sume_seqelems_move) (1 ms). *)
using inv_Moves_def by blast  (*SH, subgoal 2*)

text \<open> These synonyms for lemmas/definition groups is useful not only to avoid long 
unfolding chains but also to help sledgehammer know bout related concepts. \<close>

lemma l_sg3_pre_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> pre_sum_elems (ms @ [m])" 
oops

text \<open>Groups of definitions can be named to make their unfolding in one go.\<close>
lemmas inv_Move_defs = inv_Move_def inv_VDMNat1_def max_def
lemmas inv_Moves_defs = inv_Moves_def inv_SeqElems_def pre_sum_elems_def post_sum_elems_def

lemma l_sg3_pre_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> pre_sum_elems (ms @ [m])" 
unfolding  inv_Moves_defs play_move_def Let_def by simp (*SH, subgoal 3*)

lemma l_sg4_post_sume: "inv_SeqElems inv_Move ms \<Longrightarrow> post_sum_elems ms (sum_elems ms)" 
unfolding post_sum_elems_def
by (simp add: inv_VDMNat_def l_pre_sum_elems l_sum_elems_nat) (*SH, subgoal 4~*)

lemma l_sg5_post_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> post_sum_elems (ms @ [m]) (sum_elems (ms @ [m]))"
unfolding post_sum_elems_def (*
"z3": Try this: by (metis l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sg4_post_sume_append post_sum_elems_def) (128 ms). 
"cvc4": Try this: by (metis l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sg4_post_sume_append post_sum_elems_def) (66 ms). 
"remote_vampire": Try this: using l_sg3_pre_sume_append l_sg4_post_sume_append post_sum_elems_def pre_sum_elems_def by auto (20 ms). 
"spass": Try this: using l_sg3_pre_sume_append l_sg4_post_sume_append post_sum_elems_def pre_sum_elems_def by auto (25 ms).
*)
by (metis l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sg4_post_sume post_sum_elems_def) (*SH, subgoal5*)

text \<open> This is a variation over @{thm l12}. \<close>
lemma l_sg6_2_fair_play: 
  "fair_play p s \<Longrightarrow> \<not> fair_play p (s @ [m])"
  unfolding fair_play_def who_plays_next_def
  apply (safe,simp split: if_splits)
  unfolding len_def
  by presburger+

lemma l_sg6_not_fair_play_play_move: 
  "inv_Move m \<Longrightarrow>
       inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> \<not> fair_play p (s @ [m])"
  unfolding pre_play_move_def 
  by (simp add: l_sg6_2_fair_play)

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> General lemmas are easier \<close>

text \<open> The actual VDM (declared) postcondition represents some of the subgoals above. Those are discharged 
  by the most general of lemmas here. It is a nice property of @{term sum_elems}:~it distributes over 
  concatenation and is exchanged for summation, on singleton lists as well as in general. It is often
  better to give general lemmas as they are more applicable, and surprisingly, easier to prove. 
\<close>
lemma l_sum_elems_append: "sum_elems (ms @ [m]) = (m + sum_elems ms)" 
by (induct ms, simp_all)

lemma l_sum_elems_append_gen: "sum_elems (s @ t) = (sum_elems s + sum_elems t)" 
by (induct s, simp_all)

(*<*)thm list.induct
         list.induct[of "(\<lambda> s . sum_elems(s @ [m]) = sum_elems s + m)" "ms"]
         list.induct[of "(\<lambda> s . sum_elems(s @ t) = sum_elems s + sum_elems t)" "ms"] (*>*)

text \<open> Similarly, this exercise suggested the introduction of various other lemmas for definitions
  in \texttt{VDMToolkit.thy}, such as:

  @{thm[display] l_len_nat1 l_len_append l_len_cons}
  @{thm[display] l_elems_append l_elems_cons}
  @{thm[display] l_inv_SeqElems_append l_inv_SeqElems_Cons}
  @{thm[display] l_applyVDMSeq_defined l_applyVDMSeq_append_last l_applyVDMSeq_cons_last}
  @{thm[display] l_inds_append l_len_within_inds}
\<close>
(*<*)find_theorems name:VDMSeq(*>*)

(*-----------------------------------------------------------------------*)
subsection \<open> ``Sledgehammerable proofs'' \<close>

text \<open>
  \begin{enumerate}
    \item[2] Lemma-based attempt with \textsf{sledgehammer} support.
  \end{enumerate}

  Let us see if our lemmas are working:~will \textsf{sledgehammer} find the proofs? 
\<close>

theorem PO_play_move_sat_exp_obl
(*<*) unfolding PO_play_move_sat_exp_obl_def post_play_move_def play_move_def
  apply (safe,simp_all) (*>*) 
  txt \<open> $\cdots$ @{subgoals[display,indent=0]} \<close>
  txt \<open> Goal about @{term "inv_Moves (s @ [m])"} is missing above; postpone it for now.\<close>
         defer
         apply (simp add: l_sg2_pre_sume pre_play_move_def)
        apply (simp add: l_sg3_pre_sume_append pre_play_move_def)
       apply (meson inv_Moves_def pre_play_move_def)
      apply (simp add: l_sg5_post_sume_append pre_play_move_def)
     apply (simp add: l_inv_Move_nat1 l_sum_elems_append pre_play_move_def)
    apply (simp add: l_sum_elems_append)
  apply (simp add: l_sg6_2_fair_play pre_play_move_def)
  txt \<open> @{subgoals[display,indent=0]} Yes! So, for the difficult case: it generates more subgoals :-(. 
  Will avoid safe here, but otherwise would have to deal with the many it generates. \<close>
  (*unfolding inv_Moves_def Let_def apply (simp, safe)*)
apply (simp (no_asm) add: inv_Moves_def Let_def, intro conjI impI)
txt \<open> @{subgoals[display,indent=0]}  
  As before, let us tackle each one of the sub parts in the definition @{thm[display] inv_Moves_def}
\<close> (*<*)thm inv_Moves_def[of "ms @ [m]"](*>*)
(*
goal (5 subgoals):
 1. \<And>p m s. pre_play_move p m s \<Longrightarrow> inv_SeqElems inv_Move (s @ [m])
 2. \<And>p m s. pre_play_move p m s \<Longrightarrow> pre_sum_elems (s @ [m])
 3. \<And>p m s. pre_play_move p m s \<Longrightarrow> post_sum_elems (s @ [m]) (sum_elems (s @ [m]))
 4. \<And>p m s. pre_play_move p m s \<Longrightarrow> sum_elems (s @ [m]) \<le> MAX_PILE
 5. \<And>p m s. pre_play_move p m s \<Longrightarrow> sum_elems (s @ [m]) = MAX_PILE \<Longrightarrow> (s @ [m]) ! nat (len s) = 1
*)
oops

lemma "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> inv_Moves (s @ [m])"
  unfolding inv_Moves_defs Let_def
  apply (simp,safe)
  using inv_VDMNat_def l_inv_Move_nat1 l_sum_elems_append apply force
  using l_inv_Move_nat1 l_sum_elems_append apply fastforce
               defer defer
               apply (simp add: inv_VDMNat_def l_inv_Move_nat1 le_less)
              apply (simp add: l_inv_Move_nat1)
             apply (simp add: inv_Move_def)
            apply (simp add: inv_Move_def)
  using inv_VDMNat_def l_inv_Move_nat1 l_sum_elems_append apply force
  using l_inv_Move_nat1 l_sum_elems_append apply fastforce defer defer
         apply (simp add: inv_VDMNat_def l_inv_Move_nat1 le_less)
        apply (simp add: l_inv_Move_nat1)
       apply (simp add: inv_Move_def)
      apply (simp add: inv_Move_def)
  oops

text \<open> Alternative variant proof slightly simpler to the same outcome of goal on @{term inv_Moves} missing.\<close>
theorem PO_play_move_sat_exp_obl
 unfolding PO_play_move_sat_exp_obl_def post_play_move_def play_move_def
  apply (simp,safe)
  (*using l1 play_move_def apply auto[1]*)
        defer
        apply (simp add: l_sg2_pre_sume pre_play_move_def)
       apply (simp add: l_sg3_pre_sume_append pre_play_move_def)
      apply (meson inv_Moves_def pre_play_move_def)
     apply (simp add: l_sg5_post_sume_append pre_play_move_def)
    apply (simp add: l_inv_Move_nat1 l_sum_elems_append pre_play_move_def)
   apply (simp add: l_sum_elems_append)
  apply (simp add: l_sg6_2_fair_play pre_play_move_def)
  oops

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Handling (last?) difficult case on @{term "inv_Moves (s @ [m])"} \<close>

text \<open>For the final case, we start with the naive attempt from remaining goal as \<close>
lemma l_sg1_inv_Moves_append: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> inv_Moves (s @ [m])"
  unfolding inv_Moves_def Let_def
  apply (simp,safe)
  txt \<open>This generates (10) new subgoals (some somewhat repeated), which some Sledgehammer already finds proofs for\<close>
  apply (simp add: l_inv_SeqElems_append)
          apply (simp add: l_inv_SeqElems_append pre_sum_elems_def)
         apply (metis l_inv_SeqElems_append l_sg4_post_sume l_sum_elems_append)
        defer
  using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def pre_play_move_def apply force
       apply (simp add: l_inv_SeqElems_append)
      apply (simp add: l_inv_SeqElems_append pre_sum_elems_def)
     apply (simp add: inv_Moves_def l_sg5_post_sume_append)
    defer
  using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def pre_play_move_def apply force
  txt \<open> Remaining (2) subgoals are about @{term "sum_elems (s @ [m])"} being within @{term "MAX_PILE"} 
@{subgoals[display,indent=0]}  
These cases have to do with normal and final play.  
\<close>
(*
proof (prove)
goal (2 subgoals):
 1. inv_Move m \<Longrightarrow>
    pre_play_move p m s \<Longrightarrow>
    inv_SeqElems inv_Move s \<Longrightarrow>
    pre_sum_elems s \<Longrightarrow>
    post_sum_elems s (sum_elems s) \<Longrightarrow>
    sum_elems s \<le> MAX_PILE \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> sum_elems (s @ [m]) \<le> MAX_PILE
 2. inv_Move m \<Longrightarrow>
    pre_play_move p m s \<Longrightarrow>
    inv_SeqElems inv_Move s \<Longrightarrow>
    pre_sum_elems s \<Longrightarrow>
    post_sum_elems s (sum_elems s) \<Longrightarrow>
    sum_elems s \<le> MAX_PILE \<Longrightarrow> s $ len s = 1 \<Longrightarrow> sum_elems (s @ [m]) \<le> MAX_PILE
*)
  oops

lemma l_sg1_inv_Moves_append: "pre_play_move p m s \<Longrightarrow> inv_Moves (s @ [m])"
  unfolding inv_Moves_def Let_def
  apply (simp,safe)
  apply (simp add: l_inv_Moves_inv_SeqElems l_inv_SeqElems_append pre_play_move_def)
     apply (simp add: l_sg3_pre_sume_append pre_play_move_def)
  using l_sg5_post_sume_append pre_play_move_def apply blast
   defer
   apply (simp add: VDMSeq_defs(5) l_sum_elems_append moves_left_def pre_play_move_def)
  txt \<open> Last goal of interest, but when you open @{term pre_play_move}\<close>
  unfolding pre_play_move_def
  apply (safe,simp_all)
  oops

text \<open> The remaining goals show how we are getting close. They also reveal that conditionals (through
if-then-else or implication lead to case analysis (i.e. more subgoals). 

The choice among the sledgehammer-discovered proofs was on the minimal number of lemmas to use. This is
useful to remove any cluttering lemmas at the end, something important to help sledgehammer in finding 
proofs later on. \<close>

lemma l_sg1_4_inv_Moves_maxpile_sume_append: 
  "inv_Move m \<Longrightarrow> inv_SeqElems inv_Move s \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
(*nitpick quickcheck = none*)
apply (simp add: l_sum_elems_append)
apply (induct ms)
   apply (simp add: inv_Move_def)
  apply simp
  nitpick
  txt \<open> @{subgoals[display, indent=0]} We are stuck. Sledgehammer finds nothing, and nitpick finds 
  a potential (but not certain) counterexample. Seems like we need more assumptions. Let us try the last subgoal. \<close>
oops

text \<open> We are really narrowing it down. Let us set them up with extra assumptions from @{term pre_play_move}. \<close>
lemma l_sg1_4_inv_Moves_moves_left_sume_append: "pre_play_move p m ms \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
unfolding pre_play_move_def
apply (elim conjE impE)
txt \<open> @{subgoals[display,indent=0]} \<close>
defer
   apply (simp add: l_sum_elems_append moves_left_def) (*SH, subgoal 1.4.2*)
   defer 
   defer
   apply (simp add: l_sum_elems_append moves_left_def)
txt \<open> Still subgoals we can't easily discover. Try again each as a sub lemma (for third iteration time!) 
  @{subgoals[display, indent=0]} \<close> 
(*
proof (prove)
goal (3 subgoals):
 1. inv_Player p \<Longrightarrow>
    inv_Move m \<Longrightarrow>
    inv_Moves ms \<Longrightarrow>
    pre_moves_left ms \<Longrightarrow>
    pre_fair_play p ms \<Longrightarrow> post_fair_play p ms (fair_play p ms) \<Longrightarrow> fair_play p ms \<Longrightarrow> moves_left ms = m
 2. inv_Player p \<Longrightarrow>
    inv_Move 1 \<Longrightarrow>
    inv_Moves ms \<Longrightarrow>
    pre_moves_left ms \<Longrightarrow>
    pre_fair_play p ms \<Longrightarrow> post_fair_play p ms True \<Longrightarrow> fair_play p ms \<Longrightarrow> m = 1 \<Longrightarrow> sum_elems ms \<noteq> 19
 3. inv_Player p \<Longrightarrow>
    inv_Move m \<Longrightarrow>
    inv_Moves ms \<Longrightarrow>
    pre_moves_left ms \<Longrightarrow>
    pre_fair_play p ms \<Longrightarrow>
    post_fair_play p ms (fair_play p ms) \<Longrightarrow> fair_play p ms \<Longrightarrow> m < moves_left ms \<Longrightarrow> moves_left ms = m
*)
oops

text \<open>Example lemmas that turn out to be superfluous are commented out in the code. \<close>
(* 
lemma l_sg1_1_inv_Moves_seqelems_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> inv_SeqElems inv_Move (ms @ [m])"
  by (simp add: l_inv_Moves_inv_SeqElems l_inv_SeqElems_append)

lemma l_sg1_2_inv_Moves_pre_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> pre_sum_elems (ms @ [m])" 
  by (simp add: l_sg3_pre_sume_append) (*SH, subgoal 1.2*)

lemma l_sg1_3_inv_Moves_post_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> post_sum_elems (ms @ [m]) (sum_elems (ms @ [m]))"
by (simp add: l_sg1_1_inv_Moves_seqelems_append l_sg5_post_sume_append) (*SH, subgoal 1.3*)

lemma l_sg1_5_inv_Moves_last_move_append0: 
  "pre_play_move0 p m s \<Longrightarrow> (sum_elems (s @ [m])) = MAX_PILE \<longrightarrow> (s @ [m]) $ (len (s @ [m])) = 1"
using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def pre_play_move0_def by force (*SH, subgoal 1.5*)

lemma l_sg1_4_2_inv_Moves_moves_left_sume_append: 
  "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> m < moves_left ms \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
by (simp add: l_sum_elems_append moves_left_def) (*SH, subgoal 1.4.2*)

lemma l_sg1_4_1_inv_Moves_moves_left_sume_append: 
  "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> 0 < moves_left ms \<Longrightarrow> moves_left ms \<noteq> 1"
(*nitpick quickcheck = none*)
unfolding moves_left_def inv_Move_def inv_VDMNat1_def apply (elim conjE, intro notI) oops
*)

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Generalisation of terms \<close>

text \<open> Understanding more general principle independent of given terms is an important step in proof. 
We have to prove that @{term "sum_elems (s @ [m]) \<le> MAX_PILE"} when @{term "sum_elems s \<le> MAX_PILE"}
for two cases: 1) normal play (@{term "sum_elems s \<noteq> MAX_PILE"}) and 2) final play (@{term "s $ len s = 1"}).\<close>

text \<open> Below we try to generalise it away\<close>

lemma "0 < m \<Longrightarrow> m \<le> G_MAX_MOV \<Longrightarrow> inv_Moves ms \<Longrightarrow> 0 < G_MAX_PILE - sum_elems ms \<Longrightarrow> G_MAX_PILE - sum_elems ms \<noteq> 1"
apply (rule notI,simp) oops

lemma "x \<ge> (0::nat) \<Longrightarrow> x \<le> nat MAX_MOV \<Longrightarrow> list_all (\<lambda> e . e \<ge> (0::nat)) xs \<Longrightarrow> 
          listsum xs \<ge> 0 \<Longrightarrow> listsum xs \<le> nat MAX_PILE \<Longrightarrow> x + listsum xs \<le> nat MAX_PILE"
apply (induct x rule:nat_induct)
apply simp_all
apply (induct xs rule:list.induct)
   apply simp_all
    defer
apply (subgoal_tac "(\<And>n. n + listsum x2 \<le> 20 \<Longrightarrow> n \<le> 2 )", simp)
apply (subgoal_tac "(\<forall> m . m + listsum x2 \<le> 19)")
apply (erule_tac x="n+x1" in allE, simp)
apply (subgoal_tac "(\<forall> n . n + listsum x2 \<le> 20)")
apply simp_all
apply (subgoal_tac " n + listsum x2 \<le> 19")
apply simp_all
apply auto
oops

lemma "x \<ge> (0::nat) \<Longrightarrow> x \<le> nat MAX_MOV \<Longrightarrow> list_all (\<lambda> e . e \<ge> (0::nat)) xs \<Longrightarrow> 
  listsum xs \<ge> 0 \<Longrightarrow> listsum xs \<le> nat MAX_PILE \<Longrightarrow> x + listsum xs \<le> nat MAX_PILE"
apply (induct x rule:nat_induct)
apply simp_all
apply (simp only: le_less)
apply (erule disjE)
apply (rule disjI1)
nitpick[user_axioms]
oops

lemma "x \<le> nat MAX_MOV \<Longrightarrow> y \<le> nat MAX_PILE \<Longrightarrow> x + y \<le> nat MAX_PILE"
nitpick[user_axioms]
apply (induct x rule:nat_induct)
apply simp_all
apply (simp only: le_less)
apply (erule disjE)
apply (rule disjI1)
nitpick[user_axioms]
oops

text \<open> To try and understand what is the problem, we generalise the expressions to simpler terms.
 It is useful to discover what we know about the operators involved (e.g. @{term "sum_elems (s @ t)"}).
\<close>
find_theorems "sum_elems _" name:Nim
find_theorems "sum_elems (_ @ _)"
(* 
  inv_Move m \<Longrightarrow> sum_elems s \<le> MAX_PILE \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> sum_elems (s @ [m]) \<le> MAX_PILE"
  = [via inv_Move_def and l_sum_elems_append_gen]
  m \<le> MAX_MOV \<Longrightarrow> sum_elems ms \<le> MAX_PILE \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> m + sum_elems ms \<le> MAX_PILE
  = [generalise terms]
  x \<le> MAX_MOV \<Longrightarrow> y \<le> MAX_PILE \<Longrightarrow> y \<noteq> MAX_PILE \<Longrightarrow> x + y \<le> MAX_PILE
*)

text \<open>  And get to the following unprovable conjecture, which gives the hint to the missing condition
  of interest, and its improved (provable) version.
\<close>
lemma l_sg1_4_1_explore: "x \<le>  MAX_MOV \<Longrightarrow> y \<le>  MAX_PILE \<Longrightarrow> y \<noteq> MAX_PILE \<Longrightarrow> x + y \<le>  MAX_PILE"
nitpick
oops

text \<open> This shows the missing relationship that @{term x} (or @{term m}) has to have with @{term y}
(or @{term "sum_elems s"}) in order to prove the goal. This needs to come as an assumption from somewhere.\<close>
lemma l_sg1_4_1_inv_Moves_maxpile_moves_left_gen: 
  "x \<le> MAX_MOV \<Longrightarrow> y \<le> MAX_PILE \<Longrightarrow> x + y < MAX_PILE \<Longrightarrow> x + y \<le> MAX_PILE"
by auto

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection \<open> Proving the missing cases for @{term "inv_Moves (s @ [m])"} subgoal \<close>

text \<open>More lemmas that turn out to be superfluous are commented out in the code. \<close>
(*
lemma l_sg1_5_inv_Moves_last_move_append: 
  "pre_play_move p m s \<Longrightarrow> (sum_elems (s @ [m])) = MAX_PILE \<longrightarrow> (s @ [m]) $ (len (s @ [m])) = 1"
using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def pre_play_move_def by force (*SH, subgoal 1.5*)

text \<open> Given the change to @{term pre_play_move}, we also add a lemma that a previously state postcondition is
  now a direct consequence of the current post condition.  \<close>

lemma l_pre_play_moves_left_nat1: 
  "pre_play_move p m s \<Longrightarrow> moves_left s > 0"
using pre_play_move_def l_inv_Move_nat1 by fastforce (*SH*)

lemma l_sg1_4_inv_Moves_moves_left_sume_append: 
  "pre_play_move p m ms \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
unfolding pre_play_move_def
apply (simp only: le_less)
apply (simp (no_asm) only: le_less[symmetric])
apply (elim conjE disjE)
txt \<open> @{subgoals[display,indent=0]} \<close>
  apply (simp add: l_sg1_4_2_inv_Moves_moves_left_sume_append) (*SH, sg 1.4.2*)
  by (metis (full_types) inv_Moves_def l1 l_sg1_4_2_inv_Moves_moves_left_sume_append play_move_def pre_play_move0_def zero_less_one)
             (*SH, sg 1.4.1*)
*)

text \<open> The proof commented below shows the dangers of sorried lemmas: it used l1, which wasn't prooved.  \<close>

(*
lemma l_sg1_inv_Moves_append:
  "pre_play_move p m s \<Longrightarrow> inv_Moves (s @ [m])"
unfolding inv_Moves_def pre_play_move_def Let_def
  apply (elim conjE, intro conjI impI, simp_all)
    apply (simp add: l_inv_SeqElems_append)
apply (simp add: l_sg1_1_inv_Moves_seqelems_append pre_moves_left_def) (*SH, 1.1*)
apply (simp add: l_sg1_2_inv_Moves_pre_sume_append pre_moves_left_def) (*SH, 1.2*)
apply (simp add: l_sg1_3_inv_Moves_post_sume_append pre_moves_left_def)(*SH, 1.3*)
  apply (metis (full_types) l_sg1_4_inv_Moves_moves_left_sume_append pre_fair_play_def pre_play_move_def) (*SH, 1.4*)
  using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def by force
 (*SH, 1.5*)
*)

lemma l_sg1_1_missing_assumption: 
  "pre_play_move p m s \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> m + (sum_elems s) < MAX_PILE"
  unfolding pre_play_move_def
  apply (safe,simp_all)
  txt \<open> Oh man, it generates yet four more subgoals. Let's try avoiding safe 
    @{subgoals[display,indent=0]}\<close>
  oops

lemma l_sg1_1_missing_assumption: 
  "pre_play_move p m s \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> m + (sum_elems s) < MAX_PILE"
  unfolding pre_play_move_def pre_moves_left_def moves_left_def
  apply (simp)
  unfolding pre_fair_play_def post_fair_play_def pre_who_plays_next_def post_who_plays_next_def
  apply simp
  unfolding pre_sum_elems_def inv_Moves_def post_sum_elems_def
  apply simp
  unfolding isFirst_def inv_Player_def inv_Move_def  inv_SeqElems_def inv_VDMNat1_def Let_def inv_VDMNat_def
  apply (elim conjE, simp)
  apply safe
  txt \<open> Oh man, it generates yet four more subgoals. Let's try avoiding safe \<close>
  oops

lemma l_sg1_1_missing_assumption: 
  "pre_play_move p m s \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> m + (sum_elems s) < MAX_PILE"
  unfolding pre_play_move_def   moves_left_def pre_moves_left_def
  apply (simp)
  unfolding inv_Moves_def Let_def
  apply simp
  apply (case_tac "sum_elems s \<noteq> 19")
  apply (simp_all)
  unfolding post_sum_elems_def
  unfolding inv_Move_def inv_VDMNat1_def
  apply simp
  apply (elim conjE, simp, elim conjE)
  txt \<open> Oh man, it generates funny subgoals. Let's try generalising and simplifying pre. Where is the contradiction? \<close>
  unfolding pre_sum_elems_def
  oops

lemma l_sg1_1_missing_assumption: 
  "pre_play_move p m s \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> m + (sum_elems s) < MAX_PILE"
  unfolding pre_play_move_def
  unfolding moves_left_def pre_moves_left_def
  apply (simp)
  apply (cases "m=1", simp_all)
  unfolding inv_Moves_def Let_def
  apply simp_all
  apply (case_tac "sum_elems s \<noteq> 19", simp_all)
   apply (elim conjE, simp)
  defer
   apply (elim conjE impE, simp_all)
  txt \<open> different strategy on m case analysis didn't work. Generalise \<close>
  oops

  find_theorems "sum_elems (_ @ _)"
lemma l_sg1_1_missing_assumption_simplified: 
  " 0 < m \<Longrightarrow> m \<le> MAX_MOV \<Longrightarrow> 
  (MAX_PILE - sum_elems s \<noteq> 1 \<longrightarrow> m < MAX_PILE - sum_elems s) \<Longrightarrow>
  (MAX_PILE - sum_elems s = m \<longrightarrow> m = 1) \<Longrightarrow>
    sum_elems s \<noteq> MAX_PILE \<Longrightarrow> m + sum_elems s < MAX_PILE"
  apply safe
  nitpick[user_axioms]
  txt \<open> Now nicpick found a counter exmple :-(. 
        We were too aggresive in the assumption simplification.
        If we play in VDM the counter example we see why (assuming in NimFull.vdmsl):
     \begin{vdmsl}[breaklines=true]
> p let s = [3,3,3,3,3,3,1], s'=play_move(<P2>, 1, s) in moves_left(s')
= 0
Executed in 0.007 secs. 
> p let s = [3,3,3,3,3,3,1], s'=play_move(<P2>, 3, s) in moves_left(s')
Error 4060: Type invariant violated for Moves in 'NimFull' (console) at line 1:29
MainThread> 
     \end{vdmsl}
  @{subgoals[display,indent=0]}\<close>
  oops

lemma l_sg1_1_missing_assumption_strengthened: 
  "pre_play_move p m s \<Longrightarrow> m \<le> moves_left s \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> m + (sum_elems s) < MAX_PILE"
  unfolding pre_play_move_def  
  unfolding moves_left_def pre_moves_left_def
  apply (safe,simp_all)
  unfolding post_fair_play_def pre_fair_play_def pre_who_plays_next_def post_who_plays_next_def 
      isFirst_def fair_play_def who_plays_next_def
  apply simp
  unfolding inv_Moves_def inv_Move_def post_sum_elems_def pre_sum_elems_def inv_Player_def inv_VDMNat1_def inv_VDMNat_def 
  apply (safe, simp)
  txt \<open> Another term is missing when  m = 1? What could it be? 
  @{subgoals[display, indent=0]}\<close>
  oops

text \<open> \textbf{AHA!!!}: to play there must be more moves left? This means the final play 
  specification isn't quite right: the precondition of @{term play_move} is wrong: it needs to be when = 1 not m!\<close>

  text \<open> Part of the difficulty in @{term play_move} is that its precondition has too many 
(assymetric) cases. Let's try with a simpler, more uniform scenario.\<close>

  thm pre_play_move_def
definition
  pre_play_move_NEW :: "Player \<Rightarrow> Move \<Rightarrow> Moves \<Rightarrow> \<bool>"
  where 
  "pre_play_move_NEW p m s \<equiv> 
      inv_Player p \<and> 
      inv_Move m \<and> 
      inv_Moves s \<and> 
      pre_moves_left s \<and> 
      pre_fair_play p s \<and>
      post_fair_play p s (fair_play p s) \<and>
      0 < moves_left s \<and> 
      m \<le> moves_left s \<and>
      (moves_left s = m \<longrightarrow> m = 1) \<and>
      fair_play p s"

lemma l_sg1_1_missing_assumption_strengthened: 
  "pre_play_move_NEW p m s \<Longrightarrow> m + (sum_elems s) \<le> MAX_PILE"
  unfolding pre_play_move_NEW_def  
  unfolding moves_left_def pre_moves_left_def
  apply (elim conjE)
  apply (simp only: le_less)
  apply (elim disjE)
   apply simp_all
  done

lemma l_sg1_1_inv_Moves_sum_elems_append:
 "inv_Move m \<Longrightarrow>
    pre_play_move_NEW p m s \<Longrightarrow>
    inv_SeqElems inv_Move s \<Longrightarrow>
    pre_sum_elems s \<Longrightarrow>
    post_sum_elems s (sum_elems s) \<Longrightarrow>
    moves_left s \<noteq> 1 \<Longrightarrow> sum_elems s \<noteq> MAX_PILE \<Longrightarrow> sum_elems (s @ [m]) \<le> MAX_PILE"
  apply (simp add: l_sum_elems_append_gen)
  unfolding pre_play_move_NEW_def
  by (simp add: moves_left_def)

text \<open> The last lemma @{thm l_sg1_1_inv_Moves_sum_elems_append} is also useful to prove a few others
  associated with the original @{term pre_play_move} definition.\<close>
lemma l_sg1_2_inv_Moves_sum_elems_append:
  "pre_play_move p m s \<Longrightarrow> moves_left s \<ge> m \<Longrightarrow> sum_elems s \<le> MAX_PILE \<Longrightarrow> s $ len s = 1 \<Longrightarrow> sum_elems (s @ [m]) \<le> MAX_PILE"
  using l_sg1_1_inv_Moves_sum_elems_append l_sum_elems_append moves_left_def pre_play_move_def 
  apply simp   
  done

text \<open>For the final case, we start with the naive attempt from remaining goal as \<close>
lemma l_sg1_inv_Moves_append: "inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move p m s \<Longrightarrow> inv_Moves (s @ [m])"
  unfolding inv_Moves_def Let_def
  apply (simp,safe)
  txt \<open>This generates (10) new subgoals (some somewhat repeated), which some Sledgehammer already finds proofs for\<close>
  apply (simp add: l_inv_SeqElems_append)
          apply (simp add: l_inv_SeqElems_append pre_sum_elems_def)
         apply (metis l_inv_SeqElems_append l_sg4_post_sume l_sum_elems_append)
  defer
  using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def pre_play_move_def apply force
       apply (simp add: l_inv_SeqElems_append)
      apply (simp add: l_inv_SeqElems_append pre_sum_elems_def)
     apply (simp add: inv_Moves_def l_sg5_post_sume_append)
  defer
  using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def pre_play_move_def apply force
   apply (subgoal_tac "moves_left s \<ge> m")
  defer
   apply (subgoal_tac "moves_left s \<ge> m")
  using l_sg1_2_inv_Moves_sum_elems_append apply blast
  unfolding moves_left_def pre_play_move_def inv_Moves_def
  apply simp_all
  txt \<open> missing condition on precondition of @{term play_move}\<close>
  oops
text \<open> With the sorry proof for case above, we know that there is something wrong with precondition of 
   @{term play_move} that needs fixing. I will leave this as an exercise.\<close>

lemma "pre_play_move p m s = pre_play_move_NEW p m s"
  apply safe
  unfolding pre_play_move_def pre_play_move_NEW_def
   apply simp_all
  unfolding moves_left_def
   apply simp_all
   apply (safe, simp_all)
   defer
  using l_inv_Move_nat1 apply force
  apply (insert l_inv_Move_nat1[of m], simp)
  oops

text \<open> Older has a missing case: when at end of play but m is 2 or 3! \<close>
lemma "pre_play_move p m s \<Longrightarrow> pre_play_move_NEW p m s"
  unfolding pre_play_move_def pre_play_move_NEW_def
   apply simp_all
  unfolding moves_left_def
   apply simp_all
  apply (safe, simp_all)
   defer
  using l_inv_Move_nat1 apply fastforce
  txt \<open> The missing case: when @{term "moves_left s"} is 1, yet nothing is said about @{term m} 
when it could have been 2 or 3. 
    @{subgoals[display, indent=0]}\<close>
  unfolding inv_Move_def inv_VDMNat1_def
  apply safe
  apply (cases "m=1", simp_all)
  oops

  text \<open> New version is stronger than older, hence covers the case \<close>
lemma "pre_play_move_NEW p m s \<Longrightarrow> pre_play_move p m s"
  unfolding pre_play_move_def pre_play_move_NEW_def
   apply simp_all
  unfolding moves_left_def
   apply simp_all
  by (safe, simp_all)

lemma "inv_Moves s \<Longrightarrow> sum_elems s = MAX_PILE - 1 \<Longrightarrow> pre_play_move p 2 s"
  unfolding pre_play_move_def
  apply simp
  unfolding pre_fair_play_def pre_who_plays_next_def isFirst_def post_fair_play_def post_who_plays_next_def inv_Player_def
  apply simp
  unfolding pre_moves_left_def pre_sum_elems_def
  apply simp
  apply safe
      apply (simp add: inv_Move_def inv_VDMNat1_def)
     apply (simp add: l_inv_Moves_inv_SeqElems)
    apply (simp add: moves_left_def)+
  unfolding fair_play_def who_plays_next_def
  txt \<open> The statement works for @{term P2} not @{term P1}. 
  @{subgoals[display, indent=0]}\<close>
  oops

lemma "inv_Moves s \<Longrightarrow> sum_elems s = MAX_PILE - 1 \<Longrightarrow> pre_play_move P2 2 s"
  unfolding pre_play_move_def
  apply simp
  unfolding pre_fair_play_def pre_who_plays_next_def isFirst_def post_fair_play_def post_who_plays_next_def inv_Player_def
  apply simp
  unfolding pre_moves_left_def pre_sum_elems_def
  apply simp
  apply safe
      apply (simp add: inv_Move_def inv_VDMNat1_def)
     apply (simp add: l_inv_Moves_inv_SeqElems)
    apply (simp add: moves_left_def)+
  unfolding fair_play_def who_plays_next_def
  apply simp
  unfolding inv_Moves_def post_sum_elems_def pre_sum_elems_def Let_def inv_VDMNat_def
  apply simp
  apply safe
  txt \<open>@{subgoals[display, indent=0]} 
  To prove this will be involved: we would have to show that any sequence we get that has @{term "sum_elems s = 19"}
  has an odd length. Perhaps restate the goal again with an extra assumption. \<close>
  oops

lemma l_pre_play_move_OFFENDING_CASE:
  "fair_play p s \<Longrightarrow> inv_Moves s \<Longrightarrow> sum_elems s = MAX_PILE - 1 \<Longrightarrow> pre_play_move p 2 s"
  unfolding pre_play_move_def
  apply simp
  unfolding pre_fair_play_def pre_who_plays_next_def isFirst_def post_fair_play_def post_who_plays_next_def inv_Player_def  
            pre_moves_left_def pre_sum_elems_def
  apply simp
  by (simp add: inv_Move_def inv_VDMNat1_def l_inv_Moves_inv_SeqElems moves_left_def)

lemma l_pre_play_move_NEW_OFFENDING_CASE_SOLUTION:
  "fair_play p s \<Longrightarrow> inv_Moves s \<Longrightarrow> sum_elems s = MAX_PILE - 1 \<Longrightarrow> pre_play_move_NEW p 2 s"
  unfolding pre_play_move_NEW_def
  apply simp
  unfolding pre_fair_play_def pre_who_plays_next_def isFirst_def post_fair_play_def post_who_plays_next_def inv_Player_def  
            pre_moves_left_def pre_sum_elems_def
  apply simp
  apply safe
      apply (simp add: inv_Move_def inv_VDMNat1_def)
  using l_inv_Moves_inv_SeqElems apply blast
    apply (simp add: moves_left_def)
   defer
  using moves_left_def apply auto[1]
  unfolding moves_left_def
  apply simp
  txt \<open> Finally we see that @{term pre_play_move_NEW} fixes the offending case. \<close>
  oops

  text \<open> The general case missing by the original prcondition is when we are at the end of the game
  but the call comes with @{term m} different from @{term 1}.\<close>

lemma l_pre_play_move_NEW_OFFENDING_CASE_SOLUTION_GENERAL:
  "fair_play p s \<Longrightarrow> inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> sum_elems s = MAX_PILE - 1 \<Longrightarrow> m \<noteq> 1 \<Longrightarrow> \<not> pre_play_move_NEW p m s"
  unfolding pre_play_move_NEW_def
  apply simp
  unfolding pre_fair_play_def pre_who_plays_next_def isFirst_def post_fair_play_def post_who_plays_next_def inv_Player_def  
            pre_moves_left_def pre_sum_elems_def
  apply simp
  using l_inv_Move_nat1 moves_left_def by force

(*-----------------------------------------------------------------------*)
subsection \<open> Putting it all together for satisfiability PO for @{term play_move}\<close>

text \<open>
  \begin{enumerate}
    \item[3] Lemma-based attempt with \textsf{sledgehammer} support.
  \end{enumerate}
\<close>

text \<open>Other example lemmas deleted are commented in the code below. It was assuming that 
the lemma about append over invariant of Moves worked. \<close>
(*
thm PO_play_move_sat_exp_obl_def

theorem PO_play_move_sat_exp_obl
  unfolding PO_play_move_sat_exp_obl_def 
  unfolding post_play_move_def play_move_def 
  apply (simp, safe) 
  txt \<open> 8 instead of 12 subgoals from the first attempt \<close>
  using l_sg1_inv_Moves_append pre_play_move_def apply blast
        apply (simp add: l_sg2_pre_sume pre_play_move_def)
       apply (simp add: l_sg3_pre_sume_append pre_play_move_def)
      apply (meson inv_Moves_def pre_play_move_def)
     apply (simp add: l_sg5_post_sume_append pre_play_move_def)
    apply (simp add: l_inv_Move_nat1 l_sum_elems_append pre_play_move_def)
   apply (simp add: l_sum_elems_append)
  by (simp add: l_sg6_2_fair_play pre_play_move_def)


text \<open> Finally, the lemmas that were useful are displayed below. \<close>
thm
l_sum_elems_append
l_inv_Move_nat1
l_sg1_inv_Moves_append
l_sg2_pre_sume
l_sg3_pre_sume_append
l_sg5_post_sume_append
l_sg6_not_fair_play_play_move

text \<open> Also here, an alternative (albeit similar) proof of the same goal. \<close>

theorem PO_play_move_sat_exp_obl
(*<*) unfolding PO_play_move_sat_exp_obl_def post_play_move_def play_move_def
apply (intro allI impI conjI,simp_all) (*>*) txt \<open> $\cdots$ @{subgoals[display,indent=0]} \<close>
apply (simp add: l_sg1_inv_Moves_append)                          (*SH, sg1*)
apply (simp add: l_sg2_pre_sume)                                  (*SH, sg2*)
apply (simp add: l_sg3_pre_sume_append)                           (*SH, sg3*)
apply (simp add: l_inv_Moves_inv_SeqElems l_sg4_post_sume)        (*SH, sg4*)
apply (simp add: l_inv_Moves_inv_SeqElems l_sg5_post_sume_append) (*SH, sg5*)
apply (simp add: l_inv_Move_nat1 l_sum_elems_append)              (*SH, sg6*)
apply (simp add: l_sum_elems_append)                              (*SH, sg7*)
  by (simp add: l_sg6_not_fair_play_play_move)

lemma l_sg6_3_fair_play: 
  "fair_play p s \<Longrightarrow> \<not> fair_play p (m # s)"
  unfolding fair_play_def who_plays_next_def
  apply (safe,simp split: if_splits)
  unfolding len_def
  by presburger+

theorem PO_play_move_sat_obl
(*<*) unfolding PO_play_move_sat_obl_def post_play_move_def play_move_def 
apply (intro allI impI conjI,simp_all) (*>*) txt \<open> $\cdots$ @{subgoals[display,indent=0]} \<close>
  apply (rule_tac x="s @ [m]" in exI, intro conjI, simp_all)
  using l_sg1_inv_Moves_append apply blast
         apply (simp add: l_sg2_pre_sume) (*SH, sg2*)
        apply (simp add: l_sg1_2_inv_Moves_pre_sume_append)
       apply (simp add: l_inv_Moves_inv_SeqElems l_sg4_post_sume)
  using l_sg1_3_inv_Moves_post_sume_append apply auto[1]
     apply (simp add: l_inv_Move_nat1 l_sum_elems_append)
    apply (simp add: l_sum_elems_append)
  using l_sg6_not_fair_play_play_move apply blast
  done

lemma l_inv_Moves_play_move: "pre_play_move0 p m s \<Longrightarrow> inv_Moves (play_move p m s)"
unfolding inv_Moves_def Let_def
apply (intro conjI impI)
using l_play_move_pre_sume pre_play_move0_def pre_sum_elems_def apply blast (*SH*)
apply (simp add: l_play_move_pre_sume pre_play_move0_def) (*SH*)
apply (simp add: l_post_sume_play_move pre_play_move0_def) (*SH*)
defer
apply (simp add: l_inv_Moves_last_move_append) (*SH*)
apply (simp add: pre_play_move0_def  play_move_def) --"expansion on local goal only"
apply (elim conjE impE)
defer
apply (simp add: l_inv_Moves_maxpile_sume_append)
unfolding moves_left_def apply simp
oops

lemma l_inv_Moves_play_move: "pre_play_move0 p m s \<Longrightarrow> inv_Moves (play_move p m s)"
unfolding inv_Moves_def Let_def
apply (intro conjI impI)
using l_play_move_pre_sume pre_play_move0_def pre_sum_elems_def apply blast (*SH*)
apply (simp add: l_play_move_pre_sume pre_play_move0_def) (*SH*)
apply (simp add: l_post_sume_play_move pre_play_move0_def) (*SH*)
apply (simp add: pre_play_move0_def  play_move_def) --"expansion on local goal only"
apply (elim conjE impE)
defer
apply (simp add: l_inv_Moves_maxpile_sume_append)
find_theorems "applyVDMSeq _ _"
apply (simp add: l_applyVDMSeq_append_last play_move_def l_sum_elems_append)
unfolding pre_play_move0_def inv_Moves_def Let_def
apply simp
oops

theorem PO_play_move_sat_exp_obl0
unfolding PO_play_move_sat_exp_obl0_def  post_play_move_def 
apply simp
apply (intro allI impI conjI)
apply (simp add: l_inv_Moves_play_move) (*SH*)
apply (simp add: pre_play_move0_def l_moves_left_pre_sume) (*SH*)
apply (simp add: pre_play_move0_def l_moves_left_pre_sume) (*SH*)
apply (simp add: l_play_move_pre_sume) (*SH*)
apply (meson inv_Moves_def) (*SH*)
 (* why not apply (simp add: l_pre_sume_seqelems_move l_sum_elems_post l_moves_left_pre_sume)? *)
apply (simp add: l_post_sume_play_move) (*SH*)
apply (simp add: l_sum_elems_append play_move_def l_inv_Move_nat1) (*SH*)
apply (simp add: l_sum_elems_append play_move_def) (*SH*)
oops

lemma "inv_Move x \<Longrightarrow> inv_Moves xs \<Longrightarrow> inv_Moves(x # xs)"
unfolding inv_Moves_def Let_def
apply simp
apply (elim conjE, intro conjI impI)
apply (simp add: l_inv_SeqElems_Cons) (*SH*)
apply (simp add: l_inv_SeqElems_Cons l_pre_sume_seqelems_move) (*SH*) 
apply (metis NimFull.sum_elemsI l_inv_SeqElems_Cons l_sum_elems_post) (*SH*)
oops

lemma l_play_move_sat: "pre_play_move0 p m ms \<Longrightarrow> post_play_move p m ms (play_move p m ms)"
unfolding pre_play_move0_def post_play_move_def
apply (elim conjE, simp, intro conjI)
defer
apply (meson inv_Moves_def) (*SH*)
apply (simp add: l_play_move_pre_sume) (*SH*)
apply (meson inv_Moves_def)(*SH*)
(*apply (simp add: l_sum_elems_post) (*SH*) *)
apply (simp add: l_post_sume_play_move) (*SH*)
apply (simp add: l_inv_Move_nat1 l_sum_elems_append play_move_def) (*SH*)
apply (simp add: l_sum_elems_append play_move_def) (*SH*)
oops

lemma l_play_move_inv_moves: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> inv_Moves (play_move p m ms) " 
unfolding inv_Moves_defs play_move_def Let_def 
apply (simp add: l_applyVDMSeq_append_last)
apply (simp add: l_sum_elems_append l_len_append)
apply (elim conjE, intro conjI impI)
using inv_VDMNat_def l_inv_Move_nat1 apply force (*SH*)
using l_inv_Move_nat1 apply force (*SH*)
find_theorems "_ \<le> _" name:le -name:Nat -name:Set 
thm le_less
apply (simp only: le_less)
apply (simp (no_asm) only: le_less[symmetric])
apply (erule disjE)
apply simp_all
(* ERROR! It's \<longleftrightarrow> for applyVDMSeq in the last ? No. but something else*)
oops

lemma l_inv_Moves_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> inv_Moves (ms @ [m])"
apply (simp (no_asm) add: inv_Moves_def Let_def)
unfolding post_sum_elems_def
apply (intro conjI)
apply (simp add: inv_Moves_def l_inv_SeqElems_append)(*SH*)
apply (simp add: l_inv_Moves_inv_SeqElems l_inv_SeqElems_append pre_sum_elems_def)(*SH*)
apply (simp add: inv_Moves_def l_inv_SeqElems_append)(*SH*)
apply (metis l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sum_elems_post post_sum_elems_def)
apply (simp add: l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sum_elems_nat1)
apply (simp_all add: l_sum_elems_append l_applyVDMSeq_append_last)
defer
apply (intro impI)
oops
(*apply (metis l_inv_SeqElems_append l_sum_elems_post post_sum_elems_def pre_sum_elems_def)(*SH*)*)
(*apply (smt inv_VDMNat_def l_inv_SeqElems_append l_sum_elems_nat1 l_sum_elems_post post_sum_elems_def snoc_eq_iff_butlast)*)
(*apply (smt inv_VDMNat_def l_inv_SeqElems_append l_sum_elems_nat1 l_sum_elems_post post_sum_elems_def snoc_eq_iff_butlast) (*SH*)*)

lemma l_inv_Moves_play_move: "pre_play_move p m s \<Longrightarrow> inv_Moves (play_move p m s)"
unfolding inv_Moves_def Let_def
apply (intro conjI impI)
using l_play_move_pre_sume pre_play_move_def pre_sum_elems_def apply blast (*SH*)
apply (simp add: l_play_move_pre_sume pre_play_move_def) (*SH*)
apply (simp add: l_post_sume_play_move pre_play_move_def) (*SH*)
defer
apply (simp add: l_inv_Moves_last_move_append) (*SH*)
apply (simp add: pre_play_move_def  play_move_def) --"expansion on local goal only"
apply (elim conjE, erule impE)
defer
apply (simp add: l_inv_Moves_maxpile_sume_append)
apply (erule impE)
unfolding moves_left_def apply simp
oops

theorem PO_play_move_sat_exp_obl
unfolding PO_play_move_sat_exp_obl_def  post_play_move_def 
apply simp
apply (intro allI impI conjI)
apply (simp add: l_inv_Moves_play_move) (*SH*)
apply (simp add: pre_play_move0_def l_moves_left_pre_sume) (*SH*)
apply (simp add: pre_play_move0_def l_moves_left_pre_sume) (*SH*)
apply (simp add: l_play_move_pre_sume) (*SH*)
apply (meson inv_Moves_def) (*SH*)
 (* why not apply (simp add: l_pre_sume_seqelems_move l_sum_elems_post l_moves_left_pre_sume)? *)
apply (simp add: l_post_sume_play_move) (*SH*)
apply (simp add: l_sum_elems_append play_move_def l_inv_Move_nat1) (*SH*)
by (simp add: l_sum_elems_append play_move_def) (*SH*)

*)

text \<open> And finally, we have all the lemmas we need to prove the satisfiability of @{term play_move}. \<close>

definition
  post_play_move_NEW :: "Player \<Rightarrow> Move \<Rightarrow> Moves \<Rightarrow> Moves \<Rightarrow> \<bool>"
where
  "post_play_move_NEW p m s RESULT \<equiv> 
      pre_play_move_NEW p m s \<longrightarrow> 
        inv_Moves RESULT \<and> 
        pre_sum_elems s \<and> pre_sum_elems RESULT \<and>
        post_sum_elems s (sum_elems s) \<and> post_sum_elems RESULT (sum_elems RESULT) \<and> 
        sum_elems s < sum_elems RESULT \<and>
        sum_elems s + m = sum_elems RESULT \<and>
        \<not> (fair_play p RESULT) \<and>
        s \<sqsubseteq> RESULT"

definition
  PO_play_move_sat_exp_NEW_obl :: "\<bool>"
where
  "PO_play_move_sat_exp_NEW_obl \<equiv> \<forall> p m s . 
      pre_play_move_NEW p m s \<longrightarrow> post_play_move_NEW p m s (play_move p m s)"

lemma l_sg1_inv_Moves_end: "(s @ [m]) ! nat (len s) = m"
  unfolding len_def
  by simp

lemma "0 < moves_left s \<and> m \<le> moves_left s \<Longrightarrow> inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> inv_Moves(s @ [m])"
  unfolding inv_Moves_def Let_def
  apply simp
  apply (intro conjI impI)
      apply (simp add: l_inv_SeqElems_append)
     apply (simp add: l_inv_SeqElems_append pre_sum_elems_def)
    apply (simp add: inv_Moves_def l_sg5_post_sume_append)
   apply (simp add: l_sum_elems_append moves_left_def)
  apply (simp add: l_sg1_inv_Moves_end)
  unfolding moves_left_def 
  apply (elim conjE)
  apply (induct s)
   apply (simp add: inv_Move_def) 
  apply simp
  txt \<open> Looks like a similar dead end as seen before \<close>
  oops

lemma l_sg1_1_inv_Moves_append_NEW:"
    inv_Move m \<Longrightarrow>
    inv_Moves s \<Longrightarrow>
    0 < moves_left s \<Longrightarrow> m \<le> moves_left s \<Longrightarrow> moves_left s \<noteq> m \<Longrightarrow> inv_Moves (s @ [m])"
  unfolding moves_left_def
  apply simp
  unfolding inv_Moves_def Let_def
  apply simp
  by (metis l_inv_SeqElems_append l_sg4_post_sume l_sum_elems_append le_diff_eq less_diff_eq less_irrefl less_le pre_sum_elems_def)

lemma l_sg1_2_inv_Moves_append_NEW:"
    inv_Moves s \<Longrightarrow>
    0 < moves_left s \<Longrightarrow> 1 \<le> moves_left s \<Longrightarrow> inv_Moves (s @ [1])"
  unfolding inv_Moves_def Let_def
  apply simp
  txt \<open> Sledgehammer finds these lemmas, which are not used/useful \<close>
  thm dbl_inc_simps(5) dbl_simps(3) dbl_simps(5) 
  txt \<open> Lemma we came up with was caught here; i.e. useful to generalise for later \<close>
  thm l_concat_append
  by (metis inv_Move_def inv_VDMNat1_def l_inv_SeqElems_append l_sg1_inv_Moves_end l_sg4_post_sume l_sum_elems_append le_diff_eq moves_left_def one_le_numeral pre_sum_elems_def zero_less_one)

lemma l_sg1_inv_Moves_append_NEW: "pre_play_move_NEW p m s \<Longrightarrow> inv_Moves (s @ [m])" 
  unfolding pre_play_move_NEW_def
  apply safe
  using l_sg1_1_inv_Moves_append_NEW apply blast
  using l_sg1_2_inv_Moves_append_NEW by blast

theorem PO_play_move_sat_exp_NEW_obl
  unfolding PO_play_move_sat_exp_NEW_obl_def 
  unfolding post_play_move_NEW_def play_move_def 
  apply (simp, safe) 
  txt \<open> 8 instead of 12 subgoals from the first attempt \<close>
         apply (simp add: l_sg1_inv_Moves_append_NEW)
        apply (simp add: pre_moves_left_def pre_play_move_NEW_def)
       apply (simp add: l_sg1_inv_Moves_append_NEW l_sg2_pre_sume)
      apply (meson inv_Moves_def pre_play_move_NEW_def)
     apply (meson inv_Moves_def l_sg1_inv_Moves_append_NEW)
    apply (simp add: l_inv_Move_nat1 l_sum_elems_append pre_play_move_NEW_def)
   apply (simp add: l_sum_elems_append)
  by (simp add: l_sg6_2_fair_play pre_play_move_NEW_def)

text \<open> Finally, the lemmas that were useful are displayed below. \<close>
thm
l_sg1_inv_Moves_append_NEW
l_sg2_pre_sume
l_inv_Move_nat1
l_sum_elems_append
l_sg6_2_fair_play

text \<open> Also here, an alternative (albeit similar) proof of the same goal. \<close>

theorem PO_play_move_sat_exp_NEW_obl
(*<*) unfolding PO_play_move_sat_exp_NEW_obl_def post_play_move_NEW_def play_move_def
apply (intro allI impI conjI,simp_all) (*>*) txt \<open> $\cdots$ @{subgoals[display,indent=0]} \<close>
apply (simp add: l_sg1_inv_Moves_append_NEW)                                (*SH, sg1*)
using l_sg2_pre_sume pre_play_move_NEW_def apply blast                      (*SH, sg2*)
using l_sg3_pre_sume_append pre_play_move_NEW_def apply blast               (*SH, sg3*)
apply (meson inv_Moves_def pre_play_move_NEW_def)                           (*SH, sg4*)
apply (simp add: l_sg5_post_sume_append pre_play_move_NEW_def)              (*SH, sg5*)
apply (simp add: l_inv_Move_nat1 l_sum_elems_append pre_play_move_NEW_def)  (*SH, sg6*)
apply (simp add: l_sum_elems_append)                                        (*SH, sg7*)
by (simp add: l_sg6_2_fair_play pre_play_move_NEW_def)                      (*SH, sg8*)

(*************************************************************************)
section \<open> VDM Operations satisfiability POs \<close>

theorem PO_first_player_winning_choose_move_sat_exp_obl0
unfolding PO_first_player_winning_choose_move_sat_exp_obl0_def
apply (intro allI impI)
unfolding pre_first_player_winning_choose_move0_def
          post_first_player_winning_choose_move0_def
apply (elim conjE)
unfolding post_fixed_choose_move_def first_player_winning_choose_move_def
apply simp
apply (intro conjI)
unfolding inv_Move_def max_def Let_def
txt \<open> too repetitive on the various appearances of @{term inv_Move} \<close>
oops
find_theorems "sum_elems (_ @ _)"

text \<open> Intermediate result needed for first subgoal. Also create the structured 
expansion as @{term lemmas} statements.  \<close>

lemma l_best_move_range: "best_move ms \<ge> 1 \<Longrightarrow> best_move ms \<le> MAX_MOV"
unfolding best_move_def moves_left_def by simp

lemma l_best_move_nat: "0 \<le> best_move ms"
unfolding best_move_def by simp

lemma l_best_move_nat1: "inv_Moves ms \<Longrightarrow> (0 < best_move ms) = will_first_player_win l" 
  txt \<open>doesn't work every time;\<close>
  oops

text \<open>You can name group of lemmas\<close>
lemmas PO_first_player_winning_choose_move_sat_exp_obl0_pre_post = 
    PO_first_player_winning_choose_move_sat_exp_obl0_def
    pre_first_player_winning_choose_move0_def
    post_first_player_winning_choose_move0_def
    post_fixed_choose_move_def

lemmas PO_first_player_winning_choose_move_sat_exp_obl_pre_post =
    PO_first_player_winning_choose_move_sat_exp_obl_def
    pre_first_player_winning_choose_move_def
    post_first_player_winning_choose_move_def
    post_fixed_choose_move_def

lemma l_first_player_win_best_move: "0 < best_move ms \<Longrightarrow> inv_Move (best_move ms)"
  unfolding best_move_def moves_left_def inv_Move_def inv_VDMNat1_def
  by simp

theorem PO_first_player_winning_choose_move_sat_exp_obl0
  unfolding PO_first_player_winning_choose_move_sat_exp_obl0_pre_post first_player_winning_choose_move_def
  apply (safe,simp)
  
  txt \<open>first goal saying that resut must be @{term inv_Move}, but that's only the case if @{term best_move} isn't zero!
       Given lemma above @{thm l_first_player_win_best_move}, it's a missing PRECONDITION!\<close>
  defer
apply (simp add: l_best_move_range)
txt \<open> similar to @{term inv_Move}, don't want to keep expanding @{term inv_Nim} \<close>
oops

text \<open> Deduce information from @{term inv_Nim} without the need to expand it \<close>
lemmas inv_Nim_defs = inv_Nim_def inv_Nim_flat_def
lemma f_Nim_inv_Moves: "inv_Nim st \<Longrightarrow> inv_Moves (moves st)" 
unfolding inv_Nim_defs by simp

lemma l_isFirst: "isFirst P1"
unfolding isFirst_def by simp

find_theorems name:split name:"if"
thm Let_def option.split split_ifs

theorem PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post first_player_winning_choose_move_def
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding inv_Move_def max_def
apply (simp add: l_best_move_range)
unfolding pre_who_plays_next_def Let_def
apply (simp add: inv_VDMNat1_def) 
unfolding pre_play_move_def 
apply (simp)
txt \<open> realise that @{thm l_best_move_range} can be generalised for @{term inv_Move}! \<close>
oops

lemma l_best_move_inv_Move: "inv_Moves s \<Longrightarrow> inv_Move (best_move s)"
  unfolding best_move_def moves_left_def
  apply simp
  unfolding inv_Move_def inv_VDMNat1_def
  unfolding inv_Moves_def Let_def
  thm le_less[of "sum_elems s" MAX_PILE]  
  apply (simp add: le_less)
  apply (elim conjE disjE, simp_all)
  find_theorems "sum_elems _ > 0"
  apply (cases "s = []", simp)
  apply (frule l_sum_elems_nat1, simp)
  apply (intro conjI)
  find_theorems (1000) name:int -name:Real -name:Code -name:Quickcheck -name:Ring -name:Topo -name:Prod -name:Rat
  -name:String -name:BNF -name:Set name:Int name:induct
   apply (cases "sum_elems s", simp_all)
   apply (induct_tac n rule:int_less_induct, simp_all)
    apply simp
  txt \<open> Still not entirely obvious. Let's go back to prove @{term best_move}, like we did for @{term play_move}\<close>
  oops

definition
  PO_best_move_obl :: "\<bool>"
  where
  "PO_best_move_obl \<equiv> \<forall> s . pre_best_move s \<longrightarrow> post_best_move s (best_move s)"

theorem PO_best_move_obl
  unfolding PO_best_move_obl_def 
  apply safe
  unfolding pre_best_move_def post_best_move_def
  apply simp
  txt \<open> suggests to do the same with @{term moves_left} \<close>
  oops

definition
  PO_moves_left_obl :: "\<bool>"
  where
  "PO_moves_left_obl \<equiv> \<forall> s . pre_moves_left s \<longrightarrow> post_moves_left s (moves_left s)"

theorem PO_moves_left_obl
  unfolding PO_moves_left_obl_def
  apply safe
  unfolding pre_moves_left_def post_moves_left_def
  apply safe
  apply (simp add: l_inv_VDMNat_moves_left)
  txt \<open> this suggests the same for @{term sum_elems}, which we already proved before \<close>
  thm PO_sum_elems_obl
  using PO_sum_elems_obl apply blast
  done

text \<open> For it to be reusable in middle of proofs, important to set it up in a way Isabelle prefers \<close>
lemma l_moves_left_sat: "pre_moves_left ms \<Longrightarrow> post_moves_left ms (moves_left ms)"
by (meson inv_Moves_def l_inv_VDMNat_moves_left post_moves_left_def pre_moves_left_def) (*SH*)

theorem PO_best_move_obl
  unfolding PO_best_move_obl_def 
  apply safe
  unfolding pre_best_move_def post_best_move_def
  apply safe
  apply (simp add: inv_VDMNat_def l_best_move_nat)
   apply (simp add: l_moves_left_sat)
  unfolding pre_moves_left_def pre_sum_elems_def
  txt \<open> Last goal suggests a couple of lemmas \<close>
  oops

  text \<open> The first lemma is that @{term "inv_Moves s"} is subsumes (is stronger) than @{term pre_moves_left} \<close>
lemma l_inv_Moves_pre_moves_left: "inv_Moves s \<Longrightarrow> pre_moves_left s"
  by (simp add: l_sg2_pre_sume pre_moves_left_def)

text \<open> Second lemma is the goal itself, but with smaller set of assumptions, given lemma 1\<close>
lemma "inv_Moves s \<Longrightarrow> 0 < moves_left s \<Longrightarrow> best_move s \<le> moves_left s"
  unfolding best_move_def
  apply simp
  apply (cases "moves_left s", simp_all)
  thm l_nim_mod_prop
  by (simp add: l_nim_mod_prop)

theorem PO_best_move_obl
  unfolding PO_best_move_obl_def 
  apply safe
  unfolding pre_best_move_def post_best_move_def
  apply safe
  apply (simp add: inv_VDMNat_def l_best_move_nat)
   apply (simp add: l_moves_left_sat)
  using best_move_def l_nim_mod_prop by auto

lemma l_fpwcm_lemma1: "inv_Nim bst \<Longrightarrow> pre_will_first_player_win (limit bst)"
  unfolding  pre_will_first_player_win_def inv_MAX_PILE_def inv_VDMNat1_def pre_vdm_mod_def
  apply simp
  by (simp add: inv_Move_def inv_Nim_def inv_Nim_defs(2) inv_VDMNat1_def)

theorem PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post first_player_winning_choose_move_def
  apply (intro allI impI, elim conjE, intro conjI, simp_all)
  apply (simp add: l_first_player_win_best_move)
unfolding Let_def
unfolding pre_who_plays_next_def 
apply (simp add: f_Nim_inv_Moves l_isFirst)
unfolding pre_play_move_def 
apply simp
  apply (intro impI conjI)
txt \<open> Example of reuse of previous PO proofs in the right format for Isabelle \<close>
               apply (simp add: l_moves_left_sat)
              apply (simp add: inv_Player_def post_who_plays_next_def)
  apply (simp add: l_fpwcm_lemma1)
  using inv_Player_def apply blast
              apply (simp add: l_first_player_win_best_move)
  using pre_best_move_def apply blast
            apply (simp add: inv_Nim_def inv_Nim_defs(2))
          apply (simp add: inv_Player_def post_fair_play_def post_who_plays_next_def)
  txt \<open>Missed opportunity for lemma; smt solution is non-ideal\<close>
         apply (smt best_move_def vdmmod_mod_ge0 zmod_le_nonneg_dividend)+
  using inv_Nim_def inv_Nim_defs(2) apply blast
      apply (smt best_move_def inv_Nim_def inv_Nim_defs(2) l12 l_first_player_win_best_move l_moves_left_pre_sume l_moves_left_sat l_seq_prefix_append l_sg1_1_inv_Moves_append_NEW l_sg3_pre_sume_append l_sg5_post_sume_append l_sum_elems_append play_move_def post_moves_left_def post_play_move_def vdmmod_mod_ge0 zmod_le_nonneg_dividend)
     apply (smt best_move_def l_first_player_win_best_move l_inv_Moves_pre_moves_left l_sg1_1_inv_Moves_append_NEW l_sum_elems_append moves_left_def play_move_def pre_best_move_def unique_euclidean_semiring_numeral_class.mod_less_eq_dividend vdmmod_mod_ge0)
    apply (smt best_move_def inv_Moves_def inv_VDMNat_def l_best_move_nat l_first_player_win_best_move l_inv_SeqElems_append l_moves_left_sat l_sg3_pre_sume_append l_sg5_post_sume_append l_sum_elems_append moves_left_def play_move_def post_best_move_def pre_moves_left_def vdmmod_mod_ge0 zmod_le_nonneg_dividend)
  apply (smt best_move_def vdmmod_mod_ge0 zmod_le_nonneg_dividend)
  txt \<open> Last goal is not discovered by sledegehammer. Let's try a lemma instead. 
    The SMT proofs above might break over time; better to make them lemmas as well. \<close>
  oops

lemma l_best_play_move_failed:
  "        pre_best_move s \<Longrightarrow> 0 < moves_left s \<Longrightarrow>
           0 < best_move s \<Longrightarrow> best_move (play_move m (best_move s) s) = 0"
  unfolding play_move_def best_move_def moves_left_def  pre_best_move_def
  find_theorems "sum_elems (_ @ _)"
  apply (simp add: l_sum_elems_append_gen, safe)
  by (simp add: add_diff_eq)
thm add_diff_eq

theorem PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post first_player_winning_choose_move_def
  apply (intro allI impI, elim conjE, intro conjI, simp_all)
  apply (simp add: l_first_player_win_best_move)
unfolding Let_def
unfolding pre_who_plays_next_def 
apply (simp add: f_Nim_inv_Moves l_isFirst)
unfolding pre_play_move_def 
apply simp
  apply (intro impI conjI)
               apply (simp add: l_moves_left_sat)
              apply (simp add: inv_Player_def post_who_plays_next_def)
  apply (simp add: l_fpwcm_lemma1)
  using inv_Player_def apply blast
              apply (simp add: l_first_player_win_best_move)
  using pre_best_move_def apply blast
            apply (simp add: inv_Nim_def inv_Nim_defs(2))
          apply (simp add: inv_Player_def post_fair_play_def post_who_plays_next_def)
         apply (smt best_move_def vdmmod_mod_ge0 zmod_le_nonneg_dividend)+
  using inv_Nim_def inv_Nim_defs(2) apply blast
      apply (smt best_move_def inv_Nim_def inv_Nim_defs(2) l12 l_first_player_win_best_move l_moves_left_pre_sume l_moves_left_sat l_seq_prefix_append l_sg1_1_inv_Moves_append_NEW l_sg3_pre_sume_append l_sg5_post_sume_append l_sum_elems_append play_move_def post_moves_left_def post_play_move_def vdmmod_mod_ge0 zmod_le_nonneg_dividend)
     apply (smt best_move_def l_first_player_win_best_move l_inv_Moves_pre_moves_left l_sg1_1_inv_Moves_append_NEW l_sum_elems_append moves_left_def play_move_def pre_best_move_def unique_euclidean_semiring_numeral_class.mod_less_eq_dividend vdmmod_mod_ge0)
    apply (smt best_move_def inv_Moves_def inv_VDMNat_def l_best_move_nat l_first_player_win_best_move l_inv_SeqElems_append l_moves_left_sat l_sg3_pre_sume_append l_sg5_post_sume_append l_sum_elems_append moves_left_def play_move_def post_best_move_def pre_moves_left_def vdmmod_mod_ge0 zmod_le_nonneg_dividend)
  apply (smt best_move_def vdmmod_mod_ge0 zmod_le_nonneg_dividend)
  using l_best_play_move_failed by blast


lemma PO_first_player_winning_choose_move_sat_obl
unfolding PO_first_player_winning_choose_move_sat_obl_def pre_first_player_winning_choose_move_def post_first_player_winning_choose_move_def
apply (intro allI impI, elim conjE)
unfolding max_def
apply (simp add: l_first_player_win_best_move)
unfolding pre_who_plays_next_def 
apply (simp add: l_inv_Move_nat1 l_isFirst)
unfolding pre_moves_left_def
apply (simp add: l_isFirst)
txt \<open> Wahh! Complicated. We need more lemmas for this one \<close>
oops

text \<open> Let us try the lemma about @{term best_move} again, but generalise it this time. Say, 
take the expression: 
  
  \[
     @{term "best_move ms < moves_left ms"}[display=true]
     =
     @{term "((moves_left ms) - 1) mod (MAX_MOV + 1) < (moves_left ms)"}
     =
     @{term "(x - 1) mod (MAX_MOV + 1) < x"}
  \]
Now, let us investigate known facts about @{term "x mod y"} under @{typ \<nat>}.

\<close>
(*<*)find_theorems "(_::nat) mod _ = _"

thm Divides.zmod_eq_0_iff Divides.mod_eq_0D Divides.mod_eq_0D
    Divides.mod_less Divides.Suc_0_mod_numeral    
(*>*)

text \<open> \textsf{quickcheck} immediately finds the useful counter examples, which if ruled out by
 suitable assumptions on involved values leads to the main result discovered by \textsf{sledgehammer}. \<close>

lemma l_best_move_mov_limit_mod: "n > 0 \<Longrightarrow> m > 0 \<Longrightarrow> ((m::int) - 1) mod n < m"
(*
"cvc4": Try this: by (smt zmod_le_nonneg_dividend) (351 ms). 
"z3": Try this: by (smt semiring_numeral_div_class.mod_less_eq_dividend) (174 ms). 
Isar proof (70 ms):
proof -
  assume a1: "0 < m"
  have f2: "(0 \<le> - 1 + m + - 1 * ((- 1 + m) mod n)) = (1 \<le> m + - 1 * ((- 1 + m) mod n))"
    by linarith
  have f3: "(0 \<le> - 1 + m) = (1 \<le> m)"
    by auto
  have f4: "\<forall>x0 x1. ((x1\<Colon>\<int>) mod x0 \<le> x1) = (0 \<le> x1 + - 1 * (x1 mod x0))"
    by fastforce
  have f5: "1 \<le> m"
    using a1 by force
  have f6: "(\<not> (m - 1) mod n < m) = (m + - 1 * ((- 1 + m) mod n) \<le> 0)"
    by fastforce
  have "1 \<le> m + - 1 * ((- 1 + m) mod n)"
    using f5 f4 f3 f2 semiring_numeral_div_class.mod_less_eq_dividend by blast
  thus ?thesis
    using f6 by linarith
qed 
"spass": Try this: using zle_diff1_eq zmod_le_nonneg_dividend by blast (17 ms).
*)
using zle_diff1_eq zmod_le_nonneg_dividend by blast

lemma l_best_move_inv: "moves_left s > 0 \<Longrightarrow> best_move s < moves_left s"
unfolding best_move_def
using [[rule_trace,simp_trace]]
  by (simp only: vdmmod_mod_ge0 l_best_move_mov_limit_mod)

text \<open> Let's try and reuse the lemmas everywhere, at once; plus expanding the easy case on @{term will_first_player_win}
   as well as Isabelle constructs for max and let. It works: makes for two sub goals. \<close> 

lemma PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding max_def Let_def 
          pre_who_plays_next_def pre_moves_left_def pre_play_move0_def will_first_player_win_def
  first_player_winning_choose_move_def 
apply (simp_all add: l_first_player_win_best_move l_inv_Move_nat1 l_isFirst l_best_move_inv)
apply (safe)
txt \<open> Argh...! seems like we are back to where we strated. Perhaps the first goal to tackle should be the hard, last one \<close>
oops

lemma l_sg_1: "inv_Nim bst \<Longrightarrow>
           inv_Moves (moves bst) \<and> pre_sum_elems (moves bst) \<Longrightarrow>
           0 < moves_left (moves bst) \<Longrightarrow> 1 < moves_left (moves bst)"
unfolding inv_Nim_def inv_Nim_flat_def apply simp
txt \<open> Nim bst is irrelevant; abstract \<close>
oops


lemma PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post Let_def
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding max_def  
          pre_who_plays_next_def pre_moves_left_def pre_play_move0_def will_first_player_win_def
  first_player_winning_choose_move_def
  apply (simp add: l_first_player_win_best_move)
txt \<open> Don't know where the offending goal is coming from yet \<close>
oops


lemma PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post Let_def
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding first_player_winning_choose_move_def 
apply (simp add: l_first_player_win_best_move l_inv_Move_nat1)
unfolding pre_who_plays_next_def best_move_def inv_Move_def
           apply (simp add: l_isFirst f_Nim_inv_Moves inv_VDMNat1_def)
          apply (simp add: l_moves_left_sat)
         apply (simp add: l_isFirst pre_moves_left_def)
        apply (simp add: inv_Player_def post_who_plays_next_def)
  using pre_will_first_player_win_def inv_MAX_PILE_def inv_VDMNat1_def apply simp
txt \<open> not via sledgehammer; try simplifying all \<close>
  apply simp_all
  unfolding play_move_def pre_play_move_def pre_best_move_def
  apply simp_all
  txt \<open> goals 2,3, 4 show we need lemmas about @{term inv_Moves} and @{term pre_moves_left} over concatenation \<close>
oops

lemma l_inv_Moves_Append: "inv_Moves (s @ t) = (inv_Moves s \<and> inv_Moves t)"
apply (induct s)
   apply simp
  txt \<open>two cases as empty and non-empty \<close>
oops

lemma l_inv_Moves_Empty: "inv_Moves []"
unfolding inv_Moves_defs pre_sum_elems_def elems_def inv_VDMNat_def
by simp

lemma l_inv_Moves_Append: "inv_Moves (s @ t) = (inv_Moves s \<and> inv_Moves t)"
apply (induct s)
   apply (simp add: l_inv_Moves_Empty)
  txt \<open>for append, need lemma about cons\<close>
oops

lemma l_inv_Moves_Cons: "inv_Moves (a#s) = (inv_Move a \<and> inv_Moves s)"
apply (rule iffI)
unfolding inv_Moves_def
  apply auto
txt \<open>needs to go slowly\<close>
oops

lemma l_inv_Moves_Cons: "inv_Moves (a#s) = (inv_Move a \<and> inv_Moves s)"
apply (safe)
apply (simp add: inv_Moves_defs(1) l_inv_SeqElems_Cons)
unfolding inv_Moves_def pre_sum_elems_def Let_def
apply (safe)
                   apply (simp_all add: l_inv_SeqElems_Cons)
  unfolding post_sum_elems_def
             apply simp_all
  txt \<open>needs slower pace\<close>
oops

text \<open> Singleton version of @{term inv_Moves} equal @{term inv_Move} \<close>
lemma l_inv_Moves_Singleton: "inv_Moves [m] = inv_Move m"
  unfolding inv_Moves_def inv_SeqElems_def 
  apply simp
  unfolding pre_sum_elems_def Let_def post_sum_elems_def
  apply simp
  using inv_Move_def inv_VDMNat_def l_inv_Move_nat1 l_inv_SeqElems_Cons by fastforce

text \<open> Singleton version of @{term inv_Moves} append. See also @{thm l_sg1_inv_Moves_append_NEW} \<close>
lemma l_inv_Moves_Append1: "inv_Moves (s @ [m]) = (inv_Moves s \<and> inv_Move m)"
find_theorems "_ @ [_]" name:List
apply (induct s)
apply (simp add: l_inv_Moves_Empty l_inv_Moves_Singleton)
unfolding inv_Moves_def
apply (simp)
oops

lemma l_not_inv_Move_zero: "\<not> inv_Move 0"
by (simp add: inv_Move_def inv_VDMNat1_def)

lemma l_inv_Moves_Cons: "inv_Moves (a#s) \<Longrightarrow> (inv_Move a \<and> inv_Moves s)"
  unfolding inv_Moves_def post_sum_elems_def pre_sum_elems_def Let_def
  apply (simp add: l_inv_SeqElems_Cons)
  using inv_VDMNat_def l_inv_Move_nat1 l_pre_sum_elems by fastforce

theorem PO_first_player_winning_choose_move_sat_exp_obl
  unfolding PO_first_player_winning_choose_move_sat_exp_obl_def 
            post_first_player_winning_choose_move_def Let_def first_player_winning_choose_move_def
  apply simp 
  txt \<open> safe will be unhelpful here as it will generate manye (13) small goals \<close>
  apply safe
  apply (simp add: l_first_player_win_best_move pre_first_player_winning_choose_move_def)
  unfolding pre_who_plays_next_def 
             apply (simp add: pre_first_player_winning_choose_move_def)+
unfolding pre_moves_left_def
         apply (simp add: l_isFirst)
         apply (simp add: l_moves_left_sat pre_moves_left_def)
        apply (simp add: f_Nim_inv_Moves isFirst_def pre_first_player_winning_choose_move_def)
       apply (simp add: inv_Player_def post_who_plays_next_def)
txt \<open> Sledgehammer seems to have stopped being useful. 
      Expansion of various parts for this goal is unhelpful. make it the first goal\<close>
oops

lemma l_sg_ml: "inv_Nim bst \<Longrightarrow>
           inv_Moves (moves bst) \<and> pre_sum_elems (moves bst) \<Longrightarrow>
           0 < moves_left (moves bst) \<Longrightarrow> Suc 0 < moves_left (moves bst)"
  oops 

lemma l_sg_let: "inv_Nim bst \<Longrightarrow>
           pre_moves_left (moves bst) \<Longrightarrow>
           0 < moves_left (moves bst) \<Longrightarrow>
           let pm = play_move (current bst) (max (Suc 0) (best_move (moves bst))) (moves bst)
           in pre_best_move pm \<and>
              post_best_move pm (best_move pm) \<and> (isFirst (who_plays_next (moves bst)) \<longrightarrow> best_move pm = 0)"
find_theorems name:"let" -name:Complete_ -name:Induc -name:Set -name:List -name:Lat -name:Nim -name:Map -name:BNF
  -name:Predicate 
find_theorems name:"let" name:cong
unfolding Let_def
apply (intro conjI impI)
unfolding pre_best_move_def 
apply (intro conjI)
unfolding play_move_def
oops

lemma l_inv_Moves_Append1: "inv_Moves (s @ [m])"
unfolding inv_Moves_def
apply (intro conjI)
find_theorems "inv_SeqElems _ _"
oops

lemma f_inv_Move : "inv_Move m \<Longrightarrow> m \<le> MAX_MOV"
unfolding inv_Move_def by simp

lemma l_MAX_rel: "MAX_MOV < MAX_PILE"
by simp

end