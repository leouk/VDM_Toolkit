theory NimFullProofs
imports NimFull
begin 

(*************************************************************************)
section {* Role of lemmas *}

text {* Some lemmas proved in the process of discovering the proofs, 
  a few turned out not to be necessary in the final proof, but helped in discovering 
  the problems with the precondition of @{term play_move}.
 *}

(*-----------------------------------------------------------------------*)
subsection {* Satisfiability PO of @{term play_move} *}

(*
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
*)  
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
           apply (simp add: l_inv_SeqElems_append)
          oops
    

definition
  PO_play_move_sat_obl0 :: "\<bool>"
where
  "PO_play_move_sat_obl0 \<equiv> \<forall> p m s . inv_Move m \<longrightarrow> inv_Moves s \<longrightarrow> 
      pre_play_move0 p m s \<longrightarrow> (\<exists> r . post_play_move p m s r)"

theorem PO_play_move_sat_obl0 
  using[[show_types=false]]
unfolding PO_play_move_sat_obl0_def
apply simp
unfolding
 pre_play_move0_def post_play_move_def 
  apply simp
  apply (intro allI impI conjI,elim conjE)
  apply (rule_tac x="s @ [m]" in exI)
  apply (simp)
  apply safe
(*
*)
txt {* @{subgoals[display,indent=0]} These goals will require various lemmas. *}
oops

lemma "inv_Move m \<Longrightarrow>
       inv_Moves s \<Longrightarrow> inv_Moves (s @ [m])"  
  unfolding inv_Moves_def
  apply safe oops
    
definition
  PO_play_move_sat_exp_obl0 :: "\<bool>"
where
  "PO_play_move_sat_exp_obl0 \<equiv> \<forall> p m s . inv_Move m \<longrightarrow> inv_Moves s \<longrightarrow> 
      pre_play_move0 p m s \<longrightarrow> post_play_move p m s (play_move p m s)"

(*-----------------------------------------------------------------------*)
subsection {* Lemmas about auxiliary function @{term sum_elems} *}

fun nconcat :: "\<int> list \<Rightarrow> \<int> list \<Rightarrow> \<int> list"
where
  "nconcat [] ys     = ys"
| "nconcat (x#xs) ys = x # (nconcat xs ys)"

lemma l_concat_append : "nconcat xs ys = xs @ ys"
apply (induct ys, simp_all) oops

lemma l_concat_append : "nconcat xs ys = xs @ ys"
by (induct xs, simp_all)

lemma l_sum_elems_nconcat: "sum_elems (nconcat ms [m]) = (m + sum_elems ms)" 
(*--"using [[rule_trace,simp_trace]]"*)
apply (induct ms, simp_all) done

text {* Some interesting lemmas about @{term sum_elems}

   @{thm[display,indent=0] l_sum_elems_nat l_sum_elems_nat1 l_pre_sum_elems }
  
*}
(*<*)find_theorems "sum_elems _" name:sum(*>*)

(*-----------------------------------------------------------------------*)
subsection {* Lemma discovery through failed proof attempts *}

text {*
  \begin{enumerate}
    \item[1] Naive attempt:~layered expansion followed by simplification.
  \end{enumerate}
*}

theorem PO_play_move_sat_exp_obl0
unfolding PO_play_move_sat_exp_obl0_def post_play_move_def play_move_def
apply (intro allI impI conjI)
txt {* @{subgoals[display,indent=0]}

  The subgoals come directly from the @{term post_play_move} for the given witness:

  @{thm[display] post_play_move_def[of p m ms "ms @ [m]"] }

  After simplifying the already parts of the input invariants, we get
*}
apply (simp_all)
txt {* @{subgoals[display,indent=0]}

  We will create a lemma for each expression that is not already part of the precondition.
  Moreover, it is interesting that @{term fair_play} does not appear in the post condition:~it ought to. 

  I will tackle the expressions from simplest to most complex. This is a useful tactic as simpler
  goals will be easier to prove. 

*}
oops
(*<*)thm pre_play_move_def[of p m ms] 
         post_play_move_def[of p m ms "ms @ [m]"]
(*
pre_play_move p m ms  \<equiv>
1 inv_Move m \<and>
2 inv_Moves ms \<and>
3 pre_moves_left ms \<and>
4 pre_fair_play p ms \<and>
5 post_fair_play p ms (fair_play p ms) \<and> 
6 (moves_left ms \<noteq> 1 \<longrightarrow> m < moves_left ms) \<and> 
7 (moves_left ms = 1 \<longrightarrow> m = 1) \<and> 
8 0 < moves_left ms \<and> 
9 fair_play p ms

post_play_move p m ms (ms @ [m]) \<equiv>
1 inv_Move m \<and>
2 inv_Moves ms \<and>
3 inv_Moves (ms @ [m]) \<and>
4 pre_sum_elems ms \<and>
5 pre_sum_elems (ms @ [m]) \<and>
6 post_sum_elems ms (sum_elems ms) \<and>
7 post_sum_elems (ms @ [m]) (sum_elems (ms @ [m])) \<and> 
8 sum_elems ms < sum_elems (ms @ [m]) \<and> 
9 sum_elems ms + m = sum_elems (ms @ [m])

goal (7 subgoals):
 1. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> inv_Moves (s @ [m])
 2. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> pre_sum_elems s
 3. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> pre_sum_elems (s @ [m])
 4. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> post_sum_elems s (sum_elems s)
 5. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> post_sum_elems (s @ [m]) (sum_elems (s @ [m]))
 6. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> sum_elems s < sum_elems (s @ [m])
 7. \<And>p m s. inv_Move m \<Longrightarrow> inv_Moves s \<Longrightarrow> pre_play_move0 p m s \<Longrightarrow> sum_elems s + m = sum_elems (s @ [m]) 
*)
(*>*)

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection {* Lemmas per subgoal*}

text {* The precondition knows about @{term pre_moves_left}, which knows about @{term pre_sum_elems}.
  The next lemma weakens the goal:~if you get a @{term pre_sum_elems} to handle, you can exchange it with
  a @{term pre_moves_left}. This fits with the necessary proof to do, but is not quite a general lemma.
*}

lemma l_moves_left_pre_sume: "pre_moves_left ms \<Longrightarrow> pre_sum_elems ms"
by (simp add: pre_moves_left_def) --"SH, subgoal 2~"

lemma l_pre_sume_seqelems_move: "inv_SeqElems inv_Move ms \<Longrightarrow> pre_sum_elems ms"
by (simp add: pre_sum_elems_def) --"SH, subgoal 2~"

text {* The next lemma helps Isabelle infer (forwardly) that, if @{term "inv_Moves ms"} holds, then
so would the smaller claim that all elements within the sequence respect @{term inv_Move}. As you will
see in proofs below, this lemma is useful in bridging the gap between what is needed for the lemma proof,
and what is available in the goal where the lemma is to be used (i.e. the simpler the lemma conditions the
better/most applicable the lemma will be). *}

lemma l_inv_Moves_inv_SeqElems: "inv_Moves ms \<Longrightarrow> inv_SeqElems inv_Move ms"
using inv_Moves_def by blast --"SH, useful for subgoal 2"

lemma l_sg2_pre_sume: "inv_Moves ms \<Longrightarrow> pre_sum_elems ms"(*
"z3": Try this: using inv_Moves_def by blast (0.5 ms). 
"spass": Try this: using inv_Moves_def by blast (1 ms). 
"cvc4": Try this: by (simp add: l_inv_Moves_inv_SeqElems l_pre_sume_seqelems_move) (0.6 ms). 
"remote_vampire": Try this: by (simp add: l_inv_Moves_inv_SeqElems l_pre_sume_seqelems_move) (1 ms). *)
using inv_Moves_def by blast  --"SH, subgoal 2"

text {* These synonyms for lemmas/definition groups is useful not only to avoid long 
unfolding chains but also to help sledgehammer know bout related concepts. *}

lemma l_sg3_pre_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> pre_sum_elems (ms @ [m])" 
oops

lemmas inv_Move_defs = inv_Move_def inv_VDMNat1_def max_def
lemmas inv_Moves_defs = inv_Moves_def inv_SeqElems_def pre_sum_elems_def post_sum_elems_def

lemma l_sg3_pre_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> pre_sum_elems (ms @ [m])" 
unfolding  inv_Moves_defs play_move_def Let_def by simp --"SH, subgoal 3"

lemma l_sg4_post_sume: "inv_SeqElems inv_Move ms \<Longrightarrow> post_sum_elems ms (sum_elems ms)" 
unfolding post_sum_elems_def
by (simp add: inv_VDMNat_def l_pre_sum_elems l_sum_elems_nat) --"SH, subgoal 4~"

lemma l_sg5_post_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> post_sum_elems (ms @ [m]) (sum_elems (ms @ [m]))"
unfolding post_sum_elems_def (*
"z3": Try this: by (metis l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sg4_post_sume_append post_sum_elems_def) (128 ms). 
"cvc4": Try this: by (metis l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sg4_post_sume_append post_sum_elems_def) (66 ms). 
"remote_vampire": Try this: using l_sg3_pre_sume_append l_sg4_post_sume_append post_sum_elems_def pre_sum_elems_def by auto (20 ms). 
"spass": Try this: using l_sg3_pre_sume_append l_sg4_post_sume_append post_sum_elems_def pre_sum_elems_def by auto (25 ms).
*)
by (metis l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sg4_post_sume post_sum_elems_def) --"SH, subgoal5"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection {* New needed general lemmas *}

text {* The actual VDM (declared) postcondition represents subgoals $6$ and $7$. Those are discharged 
  by the most general of lemmas here. It is a nice property of @{term sum_elems}:~it distributes over 
  concatenation and is exchanged for summation, on singleton lists as well as in general. It is often
  better to give general lemmas as they are more applicable, and surprisingly, easier to prove. 
*}
lemma l_sum_elems_append: "sum_elems (ms @ [m]) = (m + sum_elems ms)" 
by (induct ms, simp_all)

lemma l_sum_elems_append_gen: "sum_elems (s @ t) = (sum_elems s + sum_elems t)" 
by (induct s, simp_all)

(*<*)thm list.induct
         list.induct[of "(\<lambda> s . sum_elems(s @ [m]) = sum_elems s + m)" "ms"]
         list.induct[of "(\<lambda> s . sum_elems(s @ t) = sum_elems s + sum_elems t)" "ms"] (*>*)

text {* Similarly, this exercise suggested the introduction of various other lemmas for definitions
  in \texttt{VDMSeq.thy}, such as:

  @{thm[display] l_len_nat1 l_len_append l_len_cons}
  @{thm[display] l_elems_append l_elems_cons}
  @{thm[display] l_inv_SeqElems_append l_inv_SeqElems_Cons}
  @{thm[display] l_applyVDMSeq_defined l_applyVDMSeq_append_last l_applyVDMSeq_cons_last}
  @{thm[display] l_inds_append l_len_within_inds}
*}
(*<*)find_theorems name:VDMSeq(*>*)
(*-----------------------------------------------------------------------*)
subsection {* ``Sledgehammerable proofs'' *}

text {*
  \begin{enumerate}
    \item[2] Lemma-based attempt with \textsf{sledgehammer} support.
  \end{enumerate}

  Let us see if our lemmas are working:~will \textsf{sledgehammer} find the proofs? 
*}

theorem PO_play_move_sat_exp_obl0
(*<*) unfolding PO_play_move_sat_exp_obl0_def post_play_move_def play_move_def
apply (intro allI impI conjI,simp_all) (*>*) txt {* $\cdots$ @{subgoals[display,indent=0]} *}
defer
apply (simp add: l_sg2_pre_sume)                                  --"SH, sg2" 
      (*"z3": Try this: using inv_Moves_def apply blast (0.5 ms). 
      "spass": Try this: using inv_Moves_def apply blast (0.6 ms). 
      "cvc4": Try this: apply (simp add: l_sg2_pre_sume) (1 ms). 
      "remote_vampire": Try this: apply (simp add: l_sg2_pre_sume) (1 ms).*)

apply (simp add: l_sg3_pre_sume_append)                           --"SH, sg3"
apply (simp add: l_inv_Moves_inv_SeqElems l_sg4_post_sume)        --"SH, sg4"
apply (simp add: l_inv_Moves_inv_SeqElems l_sg5_post_sume_append) --"SH, sg5"
apply (simp add: l_inv_Move_nat1 l_sum_elems_append)              --"SH, sg6"
apply (simp add: l_sum_elems_append)                              --"SH, sg7"
txt {* @{subgoals[display,indent=0]} Yes! So, for the difficult case. *}
apply (simp (no_asm) add: inv_Moves_def Let_def, intro conjI impI)
txt {* @{subgoals[display,indent=0]}  
  As before, let us tackle each one of the sub parts in the definition @{thm[display] inv_Moves_def}
*} (*<*)thm inv_Moves_def[of "ms @ [m]"](*>*)
oops

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection {* Handling (last?) difficult case on @{term "inv_Moves (s @ [m])"} *}

lemma l_sg1_1_inv_Moves_seqelems_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> inv_SeqElems inv_Move (ms @ [m])"
by (simp add: l_inv_Moves_inv_SeqElems l_inv_SeqElems_append) --"SH, subgoal 1.1"

lemma l_sg1_2_inv_Moves_pre_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> pre_sum_elems (ms @ [m])" 
by (simp add: l_sg1_1_inv_Moves_seqelems_append l_pre_sume_seqelems_move) --"SH, subgoal 1.2"

lemma l_sg1_3_inv_Moves_post_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> post_sum_elems (ms @ [m]) (sum_elems (ms @ [m]))"
by (simp add: l_sg1_1_inv_Moves_seqelems_append l_sg5_post_sume_append) --"SH, subgoal 1.3"

lemma l_sg1_4_inv_Moves_maxpile_sume_append: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
--"nitpick quickcheck = none"
apply (simp add: l_sum_elems_append)
apply (induct ms)
apply (simp add: inv_Move_def)
find_theorems "inv_Moves (_ # _)"
apply (frule l_inv_Moves_Hd)
apply (frule l_inv_Moves_Tl)
apply simp
txt {* @{subgoals[display, indent=0]} We are stuck. Let us try the last subgoal. *}
(*
apply (simp add: l_inv_Moves_Hd l_inv_Moves_Tl)
apply (rule list.induct)
 1. inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> sum_elems [] \<le> MAX_PILE
 2. \<And>x1 x2. inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> sum_elems x2 \<le> MAX_PILE \<Longrightarrow> sum_elems (x1 # x2) \<le> MAX_PILE
 
apply (induct ms)
1. inv_Move m \<Longrightarrow> inv_Moves [] \<Longrightarrow> sum_elems ([] @ [m]) \<le> MAX_PILE
 2. \<And>a ms. (inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE) \<Longrightarrow>
            inv_Move m \<Longrightarrow> inv_Moves (a # ms) \<Longrightarrow> sum_elems ((a # ms) @ [m]) \<le> MAX_PILE *)
oops

lemma l_sg1_5_inv_Moves_last_move_append0: 
  "pre_play_move0 p m s \<Longrightarrow> (sum_elems (s @ [m])) = MAX_PILE \<longrightarrow> applyVDMSeq (s @ [m]) (len (s @ [m])) = 1"
using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def pre_play_move0_def by force --"SH, subgoal 1.5"

text {* We are really narrowing it down:~subgoal $1.4$ has two subgoals, one we can finish. Let us set them up. *}
lemma l_sg1_4_inv_Moves_moves_left_sume_append: "pre_play_move0 p m ms \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
unfolding pre_play_move0_def
apply (elim conjE impE)
txt {* @{subgoals[display,indent=0]} *}
defer
apply (simp add: l_sum_elems_append moves_left_def) --"SH, subgoal 1.4.2"
oops

lemma l_sg1_4_2_inv_Moves_moves_left_sume_append: 
  "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> m < moves_left ms \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
by (simp add: l_sum_elems_append moves_left_def) --"SH, subgoal 1.4.2"

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection {* Getting to the missing terms in @{term pre_play_move} *}

lemma l_sg1_4_1_inv_Moves_moves_left_sume_append: 
  "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> 0 < moves_left ms \<Longrightarrow> moves_left ms \<noteq> 1"
--"nitpick quickcheck = none"
unfolding moves_left_def inv_Move_def inv_VDMNat1_def apply (elim conjE, intro notI) oops

(*<*)
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
(*>*)

text {* To try and understand what is the problem, we generalise the expressions to simpler terms.
  And get to the following unprovable conjecture, and its improved version.
*}
(* 
   inv_Move m \<Longrightarrow> sum_elems ms \<le> MAX_PILE \<Longrightarrow> sum_elems(ms @ [m]) \<le> MAX_PILE
   = 
   m \<le> MAX_MOV \<Longrightarrow> sum_elems ms \<le> MAX_PILE \<Longrightarrow> m + sum_elems ms \<le> MAX_PILE
   = 
   x \<le> MAX_MOV \<Longrightarrow> y \<le> MAX_PILE \<Longrightarrow> x + y \<le> MAX_PILE
*)
lemma l_sg1_4_1_explore: "x \<le>  MAX_MOV \<Longrightarrow> y \<le>  MAX_PILE \<Longrightarrow> x + y \<le>  MAX_PILE"
nitpick[user_axioms]
oops

lemma l_sg1_4_1_inv_Moves_maxpile_moves_left_gen: 
  "x \<le> MAX_MOV \<Longrightarrow> y \<le> MAX_PILE \<Longrightarrow> x < MAX_PILE - y \<Longrightarrow> x + y \<le> MAX_PILE"
by auto

(*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*)
subsubsection {* Proving the @{term "inv_Moves (s @ [m])"} subgoal *}

text {* With the new @{term pre_play_move}, we can now collect all lemmas again for the top-level proof. 
  On all subgoals, only $1.4.1$ needed the new definition. Yet, @{term pre_play_move0} fetured in subgoal $1.5$.
  We need to redefine it with the new precondition. Also, if using the @{term pre_play_move} as an assumption
  it will not match with the goal after expansion. 
*}

lemma l_sg1_5_inv_Moves_last_move_append: 
  "pre_play_move p m s \<Longrightarrow> (sum_elems (s @ [m])) = MAX_PILE \<longrightarrow> applyVDMSeq (s @ [m]) (len (s @ [m])) = 1"
using l_applyVDMSeq_append_last l_sum_elems_append moves_left_def pre_play_move_def by force --"SH, subgoal 1.5"

text {* Given the change to @{term pre_play_move}, we also add a lemma that a previously state postcondition is
  now a direct consequence of the current post condition.  *}

lemma l_pre_play_moves_left_nat1: 
  "pre_play_move p m s \<Longrightarrow> moves_left s > 0"
using pre_play_move_def l_inv_Move_nat1 by fastforce --"SH"

lemma l_sg1_4_inv_Moves_moves_left_sume_append: 
  "pre_play_move p m ms \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
unfolding pre_play_move_def
apply (simp only: le_less)
apply (simp (no_asm) only: le_less[symmetric])
apply (elim conjE disjE)
txt {* @{subgoals[display,indent=0]} *}
apply (simp add: l_sg1_4_2_inv_Moves_moves_left_sume_append) --"SH, sg 1.4.2"
by (simp add: l_sum_elems_append moves_left_def)             --"SH, sg 1.4.1"

text {* Now we can prove the first subgoal *}

lemma l_sg1_inv_Moves_append:
  "pre_play_move p m s \<Longrightarrow> inv_Moves (s @ [m])"
unfolding inv_Moves_def pre_play_move_def Let_def
apply (elim conjE, intro conjI impI, simp_all)
apply (simp add: l_sg1_1_inv_Moves_seqelems_append pre_moves_left_def) --"SH, 1.1"
apply (simp add: l_sg1_2_inv_Moves_pre_sume_append pre_moves_left_def) --"SH, 1.2"
apply (simp add: l_sg1_3_inv_Moves_post_sume_append pre_moves_left_def)--"SH, 1.3"
apply (metis (full_types) l_sg1_4_inv_Moves_moves_left_sume_append pre_fair_play_def pre_play_move_def) --"SH, 1.4"
by (smt l_sg1_5_inv_Moves_last_move_append pre_fair_play_def pre_play_move_def) --"SH, 1.5"

(*-----------------------------------------------------------------------*)
subsection {* Putting it all together *}

text {*
  \begin{enumerate}
    \item[3] Lemma-based attempt with \textsf{sledgehammer} support.
  \end{enumerate}
*}

definition
  PO_play_move_sat_obl :: "\<bool>"
where
  "PO_play_move_sat_obl \<equiv> \<forall> p m s . inv_Move m \<longrightarrow> inv_Moves s \<longrightarrow> 
      pre_play_move p m s \<longrightarrow> (\<exists> r . post_play_move p m s r)"

definition
  PO_play_move_sat_exp_obl :: "\<bool>"
where
  "PO_play_move_sat_exp_obl \<equiv> \<forall> p m s . inv_Move m \<longrightarrow> inv_Moves s \<longrightarrow> 
      pre_play_move p m s \<longrightarrow> post_play_move p m s (play_move p m s)"

text {* And finally, we have all the lemmas we need to prove the satisfiability of @{term play_move}. *}

theorem PO_play_move_sat_exp_obl
(*<*) unfolding PO_play_move_sat_exp_obl_def post_play_move_def play_move_def
apply (intro allI impI conjI,simp_all) (*>*) txt {* $\cdots$ @{subgoals[display,indent=0]} *}
apply (simp add: l_sg1_inv_Moves_append)                          --"SH, sg1"
apply (simp add: l_sg2_pre_sume)                                  --"SH, sg2" 
apply (simp add: l_sg3_pre_sume_append)                           --"SH, sg3"
apply (simp add: l_inv_Moves_inv_SeqElems l_sg4_post_sume)        --"SH, sg4"
apply (simp add: l_inv_Moves_inv_SeqElems l_sg5_post_sume_append) --"SH, sg5"
apply (simp add: l_inv_Move_nat1 l_sum_elems_append)              --"SH, sg6"
by    (simp add: l_sum_elems_append)                              --"SH, sg7"

theorem PO_play_move_sat_obl
(*<*) unfolding PO_play_move_sat_obl_def post_play_move_def play_move_def 
apply (intro allI impI conjI,simp_all) (*>*) txt {* $\cdots$ @{subgoals[display,indent=0]} *}
apply (rule_tac x="m # s" in exI, intro conjI, simp_all)
defer
apply (simp add: l_sg2_pre_sume) --"SH, sg2"
apply (simp add: l_inv_Moves_inv_SeqElems l_inv_SeqElems_Cons l_pre_sume_seqelems_move) --"SH, sg3"
apply (simp add: l_inv_Moves_inv_SeqElems l_sg4_post_sume) --"SH, sg4"
apply (metis NimFull.sum_elemsI l_inv_Moves_inv_SeqElems l_inv_SeqElems_Cons l_sg4_post_sume) --"SH, sg5"
apply (simp add: l_inv_Move_nat1)
unfolding inv_Moves_def Let_def
apply (elim conjE, intro conjI impI)
apply (simp add: l_inv_SeqElems_Cons) --"SH, sg1.1"
apply (simp add: l_inv_SeqElems_Cons l_pre_sume_seqelems_move) --"SH, sg1.2"
apply (metis l_inv_SeqElems_Cons l_sg4_post_sume) --"SH, sg1.3"
apply (simp add: moves_left_def pre_play_move_def) --"SH, sg1.4"
apply (simp add: l_applyVDMSeq_cons_last)
apply (simp add: inv_Move_def)
apply (simp add: le_less)
apply (elim impE  disjE, simp_all)
oops

(*


lemma l_inv_Moves_append_front: "inv_Moves (ms @ [m]) \<Longrightarrow> inv_Moves ms"
unfolding inv_Moves_def Let_def
apply (elim conjE, intro conjI)
apply (simp add: l_inv_SeqElems_append)
apply (simp add: l_inv_SeqElems_append pre_sum_elems_def)
apply (simp add: l_inv_SeqElems_append l_sum_elems_post)
apply (simp add: inv_Move_def inv_Move_defs(2) l_inv_SeqElems_append l_sum_elems_append)
by (simp add: inv_Move_def inv_Move_defs(2) l_inv_SeqElems_append l_sum_elems_append)

lemma l_inv_Moves_append_last: "inv_Moves (ms @ [m]) \<Longrightarrow> inv_Move m"
unfolding inv_Moves_def Let_def
by (simp add: l_inv_SeqElems_append)

lemma l_inv_Moves_maxpile_sume_append2: "inv_Moves (ms @ [m])  \<Longrightarrow> sum_elems (ms @ [m]) \<le> MAX_PILE"
by (meson inv_Moves_def)


lemma l_inv_Moves_play_move: "pre_play_move0 p m s \<Longrightarrow> inv_Moves (play_move p m s)"
unfolding inv_Moves_def Let_def
apply (intro conjI impI)
using l_play_move_pre_sume pre_play_move0_def pre_sum_elems_def apply blast --"SH"
apply (simp add: l_play_move_pre_sume pre_play_move0_def) --"SH"
apply (simp add: l_post_sume_play_move pre_play_move0_def) --"SH"
defer
apply (simp add: l_inv_Moves_last_move_append) --"SH"
apply (simp add: pre_play_move0_def  play_move_def) --"expansion on local goal only"
apply (elim conjE impE)
defer
apply (simp add: l_inv_Moves_maxpile_sume_append)
unfolding moves_left_def apply simp
oops
(* TODO: STOPPED HERE *)


lemma l_inv_Moves_play_move: "pre_play_move0 p m s \<Longrightarrow> inv_Moves (play_move p m s)"
unfolding inv_Moves_def Let_def
apply (intro conjI impI)
using l_play_move_pre_sume pre_play_move0_def pre_sum_elems_def apply blast --"SH"
apply (simp add: l_play_move_pre_sume pre_play_move0_def) --"SH"
apply (simp add: l_post_sume_play_move pre_play_move0_def) --"SH"
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
apply (simp add: l_inv_Moves_play_move) --"SH"
apply (simp add: pre_play_move0_def l_moves_left_pre_sume) --"SH"
apply (simp add: pre_play_move0_def l_moves_left_pre_sume) --"SH"
apply (simp add: l_play_move_pre_sume) --"SH"
apply (meson inv_Moves_def) --"SH"
 (* why not apply (simp add: l_pre_sume_seqelems_move l_sum_elems_post l_moves_left_pre_sume)? *)
apply (simp add: l_post_sume_play_move) --"SH"
apply (simp add: l_sum_elems_append play_move_def l_inv_Move_nat1) --"SH"
apply (simp add: l_sum_elems_append play_move_def) --"SH"
oops

lemma "inv_Move x \<Longrightarrow> inv_Moves xs \<Longrightarrow> inv_Moves(x # xs)"
unfolding inv_Moves_def Let_def
apply simp
apply (elim conjE, intro conjI impI)
apply (simp add: l_inv_SeqElems_Cons) --"SH"
apply (simp add: l_inv_SeqElems_Cons l_pre_sume_seqelems_move) --"SH" 
apply (metis NimFull.sum_elemsI l_inv_SeqElems_Cons l_sum_elems_post) --"SH"
oops

lemma l_play_move_sat: "pre_play_move0 p m ms \<Longrightarrow> post_play_move p m ms (play_move p m ms)"
unfolding pre_play_move0_def post_play_move_def
apply (elim conjE, simp, intro conjI)
defer
apply (meson inv_Moves_def) --"SH"
apply (simp add: l_play_move_pre_sume) --"SH"
apply (meson inv_Moves_def)--"SH"
(*apply (simp add: l_sum_elems_post) --"SH" *)
apply (simp add: l_post_sume_play_move) --"SH"
apply (simp add: l_inv_Move_nat1 l_sum_elems_append play_move_def) --"SH"
apply (simp add: l_sum_elems_append play_move_def) --"SH"
oops

lemma l_play_move_inv_moves: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> inv_Moves (play_move p m ms) " 
unfolding inv_Moves_defs play_move_def Let_def 
apply (simp add: l_applyVDMSeq_append_last)
apply (simp add: l_sum_elems_append l_len_append)
apply (elim conjE, intro conjI impI)
using inv_VDMNat_def l_inv_Move_nat1 apply force --"SH"
using l_inv_Move_nat1 apply force --"SH"
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
apply (simp add: inv_Moves_def l_inv_SeqElems_append)--"SH"
apply (simp add: l_inv_Moves_inv_SeqElems l_inv_SeqElems_append pre_sum_elems_def)--"SH"
apply (simp add: inv_Moves_def l_inv_SeqElems_append)--"SH"
apply (metis l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sum_elems_post post_sum_elems_def)
apply (simp add: l_inv_Moves_inv_SeqElems l_inv_SeqElems_append l_sum_elems_nat1)
apply (simp_all add: l_sum_elems_append l_applyVDMSeq_append_last)
defer
apply (intro impI)
oops
(*apply (metis l_inv_SeqElems_append l_sum_elems_post post_sum_elems_def pre_sum_elems_def)--"SH"*)
(*apply (smt inv_VDMNat_def l_inv_SeqElems_append l_sum_elems_nat1 l_sum_elems_post post_sum_elems_def snoc_eq_iff_butlast)*)
(*apply (smt inv_VDMNat_def l_inv_SeqElems_append l_sum_elems_nat1 l_sum_elems_post post_sum_elems_def snoc_eq_iff_butlast) --"SH"*)

lemma l_inv_Moves_play_move: "pre_play_move p m s \<Longrightarrow> inv_Moves (play_move p m s)"
unfolding inv_Moves_def Let_def
apply (intro conjI impI)
using l_play_move_pre_sume pre_play_move_def pre_sum_elems_def apply blast --"SH"
apply (simp add: l_play_move_pre_sume pre_play_move_def) --"SH"
apply (simp add: l_post_sume_play_move pre_play_move_def) --"SH"
defer
apply (simp add: l_inv_Moves_last_move_append) --"SH"
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
apply (simp add: l_inv_Moves_play_move) --"SH"
apply (simp add: pre_play_move0_def l_moves_left_pre_sume) --"SH"
apply (simp add: pre_play_move0_def l_moves_left_pre_sume) --"SH"
apply (simp add: l_play_move_pre_sume) --"SH"
apply (meson inv_Moves_def) --"SH"
 (* why not apply (simp add: l_pre_sume_seqelems_move l_sum_elems_post l_moves_left_pre_sume)? *)
apply (simp add: l_post_sume_play_move) --"SH"
apply (simp add: l_sum_elems_append play_move_def l_inv_Move_nat1) --"SH"
by (simp add: l_sum_elems_append play_move_def) --"SH"

*)

(*************************************************************************)
section {* VDM Operations satisfiability POs *}

theorem PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_def
apply (intro allI impI)
unfolding pre_first_player_winning_choose_move_def
          post_first_player_winning_choose_move_def
apply (elim conjE)
unfolding post_fixed_choose_move_def
apply simp
apply (intro conjI)
unfolding inv_Move_def max_def Let_def
apply simp
(* too repetitive on the various appearances of inv_Move *)
oops
find_theorems "sum_elems (_ @ _)"

text {* Intermediate result needed for first subgoal. Also create the structured 
expansion as @{term lemmas} statements.  *}

lemma l_best_move_range: "best_move ms \<ge> 1 \<Longrightarrow> best_move ms \<le> MAX_MOV"
unfolding best_move_def moves_left_def by simp

lemma l_best_move_nat: "0 \<le> best_move ms"
unfolding best_move_def by simp

lemma l_best_move_nat1: "inv_Moves ms \<Longrightarrow> (0 < best_move ms) = will_first_player_win" oops

lemmas PO_first_player_winning_choose_move_sat_exp_obl_pre_post = 
    PO_first_player_winning_choose_move_sat_exp_obl_def
    pre_first_player_winning_choose_move_def
    post_first_player_winning_choose_move_def
    post_fixed_choose_move_def

lemma l_first_player_win_best_move: "inv_Move (max 1 (best_move ms))"
using inv_Move_def inv_Move_defs(2) l_best_move_range by force --"SH"

theorem PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post
apply (intro allI impI, elim conjE, intro conjI, simp_all)
apply (simp add: l_first_player_win_best_move)
unfolding inv_Move_def inv_VDMNat1_def max_def Let_def
apply (simp add: l_best_move_range)
apply (intro conjI impI)
(* similar to inv_Move, don't want to keep expanding inv_Nim *)
oops

text {* Deduce information from @{term inv_Nim} without the need to expand it *}
lemmas inv_Nim_defs = inv_Nim_def inv_Nim_flat_def
lemma f_Nim_inv_Moves: "inv_Nim st \<Longrightarrow> inv_Moves (moves st)" 
unfolding inv_Nim_defs by simp

lemma l_isFirst: "isFirst P1"
unfolding isFirst_def by simp

find_theorems name:split name:"if"
thm Let_def option.split split_ifs

lemma l_moves_left_sat: "pre_moves_left ms \<Longrightarrow> post_moves_left ms (moves_left ms)"
by (meson inv_Moves_def l_inv_VDMNat_moves_left post_moves_left_def pre_moves_left_def) --"SH"

lemma l_play_move_sat: "pre_play_move0 p m ms \<Longrightarrow> post_play_move p m ms (play_move p m ms)"
unfolding pre_play_move0_def post_play_move_def
apply (elim conjE, simp, intro conjI)
oops

lemma l_play_move_inv_moves: "inv_Move m \<Longrightarrow> inv_Moves ms \<Longrightarrow> pre_play_move0 p m ms \<Longrightarrow> inv_Moves (play_move p m ms) " 
unfolding inv_Moves_defs play_move_def pre_play_move0_def Let_def 
apply (simp add: l_applyVDMSeq_append_last)
apply (simp add: l_sum_elems_append l_len_append)
apply (elim conjE, intro conjI impI)
using inv_VDMNat_def l_inv_Move_nat1 apply force --"SH"
using l_inv_Move_nat1 apply force --"SH"
unfolding Let_def
oops





















theorem PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding inv_Move_def max_def
apply (simp add: l_best_move_range)
unfolding pre_who_plays_next_def Let_def
apply (simp add: inv_VDMNat1_def) 
unfolding pre_play_move_def 
apply (simp)
(* realise that l_best_move_range can be generalised for inv_Move! *)
oops

text {* Generalise @{term l_best_move_range} to avoid expanding @{term inv_Move}. Notice that the
  condition for the theorem needs to be as it appears in the goals. *} 
lemma l_best_move_range2: "1 \<le> best_move (moves st) \<Longrightarrow> inv_Move (best_move (moves st))"
unfolding inv_Move_defs best_move_def moves_left_def by (simp)

theorem PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding max_def
apply (simp add: l_best_move_range2)
(* Trivial case missing: add it as a lemma @{term "inv_Move (Suc 0)"} *)
oops


lemma PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding max_def
apply (smt l_first_player_win_best_move)
unfolding Let_def
apply (simp add: l_best_move_range2 l_inv_Move_nat1)
unfolding pre_who_plays_next_def 
apply (simp add: f_Nim_inv_Moves l_isFirst)
unfolding pre_play_move_def 
apply simp
  apply (intro impI conjI)
  apply (simp_all add: l_best_move_range2 l_inv_Move_nat1 f_Nim_inv_Moves)
(* Another interesting lemma opportunity *)
oops

text {* Property about @{term best_move} and @{term moves_left}. Is it true? Are there conditions? *}
lemma l_best_move_inv: "inv_Nim st \<Longrightarrow> best_move s < moves_left s"
find_theorems name:sum_elems
unfolding best_move_def moves_left_def
apply simp
find_theorems name:induct name:Nat
apply (induct "sum_elems s")
(* We still need it but, the side conditions are not right yet *)
oops

lemma PO_first_player_winning_choose_move_sat_obl
unfolding PO_first_player_winning_choose_move_sat_obl_def pre_first_player_winning_choose_move_def post_first_player_winning_choose_move_def
apply (intro allI impI, elim conjE)
unfolding max_def
apply (simp add: l_best_move_range2)
unfolding pre_who_plays_next_def 
apply (simp add: l_inv_Move_nat1 l_isFirst)
unfolding pre_moves_left_def
apply (simp add: l_isFirst)
(* Wahh! Complicated. We need more lemmas for this one *)
oops

text {* Let us try the lemma about @{term best_move} again, but generalise it this time. Say, 
take the expression: 
  
  \[
     @{term "best_move ms < moves_left ms"}[display=true]
     =
     @{term "((moves_left ms) - 1) mod (MAX_MOV + 1) < (moves_left ms)"}
     =
     @{term "(x - 1) mod (MAX_MOV + 1) < x"}
  \]
Now, let us investigate known facts about @{term "x mod y"} under @{typ \<nat>}.

*}
(*<*)find_theorems "(_::nat) mod _ = _"

thm Divides.mod_eq_0_iff Divides.mod_eq_0D Divides.mod_eqD
    Divides.mod_less Divides.mod_Suc_eq_Suc_mod Divides.mod_if
    Divides.le_mod_geq Divides.mod_Suc
(*>*)

text {* \textsf{quickcheck} immediately finds the useful counter examples, which if ruled out by
 suitable assumptions on involved values leads to the main result discovered by \textsf{sledgehammer}. *}

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
by (simp only: l_best_move_mov_limit_mod)

text {* To be continued... *}

(*
(* Let's try and reuse the lemmas everywhere, at once; plus expanding the easy case on @{term will_first_player_win}
   as well as Isabelle constructs for max and let. It works: makes for two sub goals.  *)
lemma PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding max_def Let_def 
          pre_who_plays_next_def pre_moves_left_def pre_play_move0_def will_first_player_win_def
apply (simp_all add: l_best_move_range2 l_inv_Move_nat1 l_isFirst l_best_move_inv)
(* Goal 1 seems false! :-( *)
defer
apply (intro impI conjI, elim conjE)
(* Argh... seems like we are back to where we strated. Perhaps the first goal to tackle should be the hard, last one *)
oops

lemma l_sg_1: "inv_Nim bst \<Longrightarrow>
           inv_Moves (moves bst) \<and> pre_sum_elems (moves bst) \<Longrightarrow>
           0 < moves_left (moves bst) \<Longrightarrow> 1 < moves_left (moves bst)"
unfolding inv_Nim_def inv_Nim_flat_def apply simp
(* Nim bst is irrelevant; abstract *)
oops



lemma PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post Let_def
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding max_def  
          pre_who_plays_next_def pre_moves_left_def pre_play_move0_def will_first_player_win_def
apply (simp_all add: l_best_move_range2 l_inv_Move_nat1 l_isFirst l_best_move_inv)
(* Don't know where the offending goal is coming from*)
oops


lemma PO_first_player_winning_choose_move_sat_exp_obl
unfolding PO_first_player_winning_choose_move_sat_exp_obl_pre_post Let_def
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding max_def --"post inv_Move best_move"
apply (simp add: l_best_move_range2 l_inv_Move_nat1)
unfolding pre_who_plays_next_def 
apply (simp add: l_isFirst f_Nim_inv_Moves)
unfolding pre_play_move0_def
apply (simp add: l_best_move_range2 l_inv_Move_nat1 l_isFirst l_best_move_inv f_Nim_inv_Moves)
apply (simp add: l_best_move_range2 l_inv_Move_nat1 l_isFirst l_best_move_inv f_Nim_inv_Moves)
  (* offending goal, postpone it *)
defer
unfolding will_first_player_win_def
apply simp
unfolding play_move_def 
  apply simp
  unfolding pre_best_move_def
  (* shows we need a lemma about inv_Moves and pre_moves_left over concatenation *)
defer
  unfolding post_best_move_def
  apply simp
oops

lemma l_inv_Moves_Append: "inv_Moves (s @ t) = (inv_Moves s \<and> inv_Moves t)"
apply (induct s)
apply simp
oops

lemma l_inv_Moves_Empty: "inv_Moves []"
unfolding inv_Moves_defs pre_sum_elems_def elems_def
by simp

lemma l_inv_Moves_Append: "inv_Moves (s @ t) = (inv_Moves s \<and> inv_Moves t)"
apply (induct s)
apply (simp add: l_inv_Moves_Empty)
oops

lemma l_inv_Moves_Cons: "inv_Moves (a#s) = (inv_Move a \<and> inv_Moves s)"
apply (rule iffI)
unfolding inv_Moves_def
apply auto
oops

lemma l_inv_Moves_Cons: "inv_Moves (a#s) = (inv_Move a \<and> inv_Moves s)"
apply (intro iffI conjI)
apply (simp add: inv_Moves_defs(1) l_inv_SeqElems_Cons)
unfolding inv_Moves_def pre_sum_elems_def
apply (elim conjE impE)
apply (simp_all add: l_inv_SeqElems_Cons)
apply (subst ssubst)
unfolding pre_sum_elems_def
unfolding inv_Moves_def
apply (simp add: l_inv_SeqElems_Cons)
oops

lemma l_inv_Moves_Cons: "a + sum_elems s \<le> MAX_PILE \<Longrightarrow> inv_Moves (a#s) = (inv_Move a \<and> inv_Moves s)"
oops

lemma l_inv_Moves_Append: "inv_Moves (s @ t) = (inv_Moves s \<and> inv_Moves t)"
apply (induct s)
apply (simp add: l_inv_Moves_Empty)
(* sorry apply (simp add: l_inv_Moves_Cons) *)
oops

lemma l_inv_Moves_Singleton: "inv_Moves [m] = inv_Move m"
unfolding inv_Moves_def inv_SeqElems_def
apply (rule iffI)
apply (elim conjE ballE)
apply simp+
unfolding elems_def
apply simp+
unfolding pre_sum_elems_def inv_SeqElems_def elems_def inv_Move_def
apply (intro ballI conjI impI)
by simp+

lemma l_inv_Moves_Append1: "inv_Moves (s @ [m]) = (inv_Moves s \<and> inv_Move m)"
find_theorems "_ @ [_]" name:List
apply (induct s)
apply (simp add: l_inv_Moves_Empty l_inv_Moves_Singleton)
unfolding inv_Moves_def
apply (simp)
oops

lemma l_inv_Moves_Append1: "inv_Moves (s @ [m]) \<Longrightarrow> inv_Moves s \<and> inv_Move m"
apply (induct s)
apply (simp add: l_inv_Moves_Empty l_inv_Moves_Singleton)
unfolding inv_Moves_def
apply (simp)
oops

lemma l_inv_Moves_Cons: "inv_Moves (a#s) \<Longrightarrow> (inv_Move a \<and> inv_Moves s)"
apply (intro conjI)
apply (simp add: inv_Moves_defs(1) l_inv_SeqElems_Cons)
unfolding inv_Moves_def pre_sum_elems_def
apply (elim conjE)
apply (simp_all add: l_inv_SeqElems_Cons)
apply (rule impI)
apply simp
oops

lemma l_not_inv_Move_zero: "\<not> inv_Move 0"
by (simp add: inv_Move_def inv_VDMNat1_def)

lemma l_inv_Moves_Cons: "inv_Moves (a#s) \<Longrightarrow> (inv_Move a \<and> inv_Moves s)"
apply (intro conjI)
apply (simp add: inv_Moves_defs(1) l_inv_SeqElems_Cons)
unfolding inv_Moves_def pre_sum_elems_def
apply (elim conjE)
apply (simp add: l_inv_SeqElems_Cons)
apply (rule impI)
by (simp add: l_not_inv_Move_zero)

lemma POXX_first_player_winning_choose_move_sat_simp_obl
unfolding POXX_first_player_winning_choose_move_sat_simp_obl_pre_post
apply (intro allI impI, elim conjE, intro conjI, simp_all)
unfolding max_def
apply (simp add: l_best_move_range2)
unfolding pre_who_plays_next_def 
apply (simp add: l_inv_Move_Suc0 l_isFirst)
unfolding pre_moves_left_def
apply (simp add: l_isFirst)
unfolding pre_play_move0_def 
apply (simp add: l_best_move_range2 l_inv_Move_Suc0 l_isFirst l_best_move_inv)
unfolding pre_moves_left_def
apply (simp)
apply (rule conjI)
defer
unfolding best_move_def 
apply simp
unfolding will_first_player_win_def
apply simp
unfolding Let_def
(* Expansion of various parts for this goal is unhelpful. make it the first goal *)
oops

lemma l_sg_ml: "inv_Nim bst \<Longrightarrow>
           inv_Moves (moves bst) \<and> pre_sum_elems (moves bst) \<Longrightarrow>
           0 < moves_left (moves bst) \<Longrightarrow> Suc 0 < moves_left (moves bst)"
sorry 

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

lemma l_inv_SeqElems_Singleton: "f m \<Longrightarrow> inv_SeqElems [m] f = f m"
sorry

lemma l_inv_SeqElems_Append: "inv_SeqElems s f \<Longrightarrow> inv_SeqElems t f \<Longrightarrow> inv_SeqElems (s @ t) f"
sorry

lemma l_inv_Moves_Append1: "inv_Moves s \<Longrightarrow> inv_Move m \<Longrightarrow> inv_Moves (s @ [m])"
unfolding inv_Moves_def pre_sum_elems_def
apply (simp,intro conjI)
thm l_inv_SeqElems_Append[of "s" "inv_Move" "[m]"]
apply (rule l_inv_SeqElems_Append, simp)
apply (simp add: l_inv_SeqElems_Singleton)
apply (induct s)
apply simp
oops

lemma f_inv_Move : "inv_Move m \<Longrightarrow> m \<le> MAX_MOV"
unfolding inv_Move_def by simp

lemma l_MAX_rel: "MAX_MOV < MAX_PILE"
by simp

lemma l_inv_Moves_Append1: "inv_Moves s \<Longrightarrow> inv_Move m \<Longrightarrow> inv_Moves (s @ [m])"
unfolding inv_Moves_def pre_sum_elems_def
apply (simp,intro conjI)
thm l_inv_SeqElems_Append[of "s" "inv_Move" "[m]"]
apply (rule l_inv_SeqElems_Append, simp)
apply (simp add: l_inv_SeqElems_Singleton)
apply (induct s)
apply simp
using dual_order.strict_trans2 f_inv_Move l_MAX_rel less_imp_le apply blast (* SH *)
apply (simp add: l_MAX_rel f_inv_Move)
apply (insert  f_inv_Move)
oops
 
lemma POXX_first_player_winning_choose_move_sat_simp_obl
unfolding POXX_first_player_winning_choose_move_sat_simp_obl_pre_post
apply (intro allI impI, elim conjE, intro conjI)
apply (simp_all add: l_sg_let) 
unfolding max_def
apply (simp add: l_best_move_range2)
unfolding pre_who_plays_next_def 
apply (simp add: l_inv_Move_Suc0 l_isFirst)
unfolding pre_moves_left_def
apply (simp add: l_isFirst)
unfolding pre_play_move0_def 
apply (simp add: l_best_move_range2 l_inv_Move_Suc0 l_isFirst l_best_move_inv)
unfolding pre_moves_left_def
apply (simp)
apply (rule conjI)
apply (simp add: l_sg_ml)
unfolding best_move_def 
apply simp
unfolding will_first_player_win_def
apply simp
done
*)
end