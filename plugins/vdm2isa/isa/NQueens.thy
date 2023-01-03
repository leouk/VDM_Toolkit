theory NQueens
imports VDMToolkit "HOL-Library.Multiset_Order"
begin

abbreviation
  BOARD_SIZE :: \<open>VDMNat1\<close>
  where
  "BOARD_SIZE \<equiv> 8"

abbreviation
  MAX_QUEENS :: \<open>VDMNat1\<close>
  where
  "MAX_QUEENS \<equiv> BOARD_SIZE"

type_synonym Queens = "VDMNat1" 

definition 
  inv_Queens :: \<open>VDMNat1 \<Rightarrow> \<bool>\<close>
  where
  \<open>inv_Queens q \<equiv> inv_VDMNat1 q \<and> q \<le> MAX_QUEENS + 1\<close>

lemmas inv_Queens_defs = inv_Queens_def inv_VDMNat1_def

type_synonym Pos = "VDMNat" 

definition 
  inv_Pos :: \<open>VDMNat \<Rightarrow> \<bool>\<close>
  where
  "inv_Pos p \<equiv> inv_VDMNat p \<and> p < BOARD_SIZE"

lemmas inv_Pos_defs = inv_Pos_def inv_VDMNat_def

type_synonym Coord = "Pos \<times> Pos" 

definition 
  inv_Coord :: "Coord \<Rightarrow> \<bool>"
  where
  "inv_Coord p \<equiv> let (r,c) = p in inv_Pos r \<and> inv_Pos c"

lemmas inv_Coord_defs = inv_Coord_def inv_Pos_defs 

type_synonym Board = "Coord VDMSet"

definition 
  inv_Board :: "Board \<Rightarrow> \<bool>"
  where
  "inv_Board b \<equiv> inv_VDMSet' inv_Coord b \<and> vdm_card b \<le> BOARD_SIZE * BOARD_SIZE"

lemmas inv_Board_defs = inv_Board_def inv_VDMSet'_defs inv_Coord_defs vdm_card_defs

definition
  pre_allowed :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> Board \<Rightarrow> \<bool>\<close>
  where 
  \<open>pre_allowed r c b \<equiv> inv_VDMNat r \<and> inv_VDMNat c \<and> inv_Board b\<close>

lemmas pre_allowed_defs = inv_VDMNat_def inv_Board_defs
(*
definition 
  post_allowed :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> Board \<Rightarrow> \<bool> \<Rightarrow> \<bool>\<close>
  where 
 \<open>post_allowed r c b RESULT \<equiv> 
    pre_allowed r c b \<longrightarrow> RESULT \<longrightarrow> post_vdm_abs (r - r') (vdm_abs (r - r')) \<close>
*)

definition 
  allowed :: \<open>Pos \<Rightarrow> Pos \<Rightarrow> Board \<Rightarrow> \<bool>\<close>
  where
  \<open>allowed r c board \<equiv> 
      (r, c) \<in> board \<and>
      \<not> (\<exists> b \<in> board . let (r',c') = b in r = r' \<or> c = c' \<or> vdm_abs (r - r') = vdm_abs (c - c'))
  \<close>

lemmas allowed_defs = allowed_def vdm_abs_def

definition 
  pre_possible :: \<open>Board \<Rightarrow> \<bool>\<close>
  where
  \<open>pre_possible board \<equiv> inv_Board board \<close>
  (*\<and> (\<forall> (r, c) \<in> board . pre_allowed r c board) *)

definition 
  post_possible :: \<open>Board \<Rightarrow> Board \<Rightarrow> \<bool>\<close>
  where 
  \<open>post_possible board RESULT \<equiv> inv_Board RESULT \<and> RESULT \<inter> board = {}\<close>

definition 
  possible :: \<open>Board \<Rightarrow> Board\<close>
  where 
  \<open>possible board \<equiv> { (r, c) | r c . r \<in> {(0::VDMNat)..BOARD_SIZE-1} \<and> c \<in> {0..BOARD_SIZE-1} \<and> (allowed r c board) }\<close>

definition 
  pre_solve :: \<open>Board \<Rightarrow> Queens \<Rightarrow> \<bool>\<close>
  where
\<open>pre_solve board Q \<equiv> inv_Board board \<and> inv_Queens Q \<and> pre_possible board \<and> post_possible board (possible board) \<and>
    (Q < MAX_QUEENS \<and> possible board \<noteq> {} \<longrightarrow> vdm_card board < BOARD_SIZE * BOARD_SIZE)\<close>

text \<open>Interestingly, what would happen if we had a mutually recursive dependency between 
both functions' preconditions?\<close>
definition 
  pre_trys :: \<open>Coord VDMSet \<Rightarrow> Board \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>\<close>
  where
\<open>pre_trys possible' board Q \<equiv> 
    inv_VDMSet' inv_Coord possible' \<and> inv_Board board \<and> inv_Queens Q \<and>  
    Q \<le> MAX_QUEENS \<and> (\<forall> p \<in> possible' . pre_solve (board \<union> {p}) (Q+1))\<close>

lemmas pre_solve_defs = pre_solve_def inv_Board_defs inv_Queens_defs 
lemmas pre_trys_defs  = pre_trys_def inv_VDMSet'_def inv_Coord_defs inv_Board_defs inv_VDMNat1_def
declare pre_solve_defs []
declare pre_trys_defs []
declare allowed_defs []
function (domintros)
  solve :: \<open>Board \<Rightarrow> Queens \<Rightarrow> Board option\<close> and
  trys  :: \<open>Coord VDMSet \<Rightarrow> Board \<Rightarrow> Queens \<Rightarrow> Board option\<close>
  where 
  \<open>solve board Q = 
      (if pre_solve board Q then 
          (if Q = MAX_QUEENS + 1 then 
            Some board 
          else 
            (let possible' = possible board in
                (trys possible' board Q))
          )
       else 
          undefined)
  \<close>
| \<open>trys possible' board Q = 
    (if pre_trys possible' board Q then 
       if possible' = {} then
          None 
       else 
          let p = (\<some> x . x \<in> possible') in
              let solution = solve (board \<union> {p}) (Q+1) in 
                if solution = None then 
                  (trys (possible' - {p}) board Q)
                else
                  solution 
     else
      undefined
    )
  \<close>
  by (pat_completeness, auto)

text \<open>We have to create a termination term for each of the recursive calls, where Isabelle sum-type
is used to represent each of the calls. The term is a relation from the sum-types, where the domain 
represents the recursive calls, whereas the range represents the original call. 

So, for the first recursive call, we have the call site for \<^term>\<open>trys\<close>, hence the \<^term>\<open>Inr\<close> projection 
on the domain, whereas the entry site for \<^term>\<open>solve\<close> is on the right hand side with \<^term>\<open>Inl\<close>. 
The other two sets represents the other corresponding two call sites. Each call site also have 
their corresponding filtering conditions for the call to work. \<close>
definition   
  solve_try_wf ::"(((Board \<times> Queens) + ((Coord VDMSet) \<times> Board \<times> Queens)) \<times> ((Board \<times> Queens) + ((Coord VDMSet) \<times> Board \<times> Queens))) set" where
  "solve_try_wf \<equiv>
  { (Inr(possible', board, q),Inl(board, q)) | possible' board q . 
      pre_solve board q \<and> 
      pre_trys possible' board q \<and> 
      q \<noteq> MAX_QUEENS + 1 \<and>
      possible' = (possible board)    
  }
\<union> { (Inl(board', q'), Inr(possible', board, q)) | possible' board q board' q' .
     pre_trys possible' board q \<and> 
     possible' \<noteq> {} \<and>
     pre_solve board' q' \<and>
     board' = (board \<union> {(\<some> x . x \<in> possible')}) \<and> 
     q' = q+1 
  } 
\<union> { (Inr(possibleCall, board, q), Inr(possibleEntry, board, q)) | possibleEntry p board' q' possibleCall board q .
     pre_trys possibleEntry board q \<and> 
     pre_trys possibleCall board q \<and> 
     possibleEntry \<noteq> {} \<and> 
     p = (\<some> x . x \<in> possibleEntry) \<and> 
     pre_solve board' q' \<and> 
     possibleCall = possibleEntry - {p} \<and>
     board' = board \<union> {p} \<and> 
     q' = q+1 \<and> 
     solve board' q' = None
  }"

lemma wf_solve_try: "wf solve_try_wf" sorry

(*
lemma l_possible_finite: "finite { (r, c) | r c . 0 \<le> r \<and> r \<le> 7 \<and> 0 \<le> c \<and> c \<le> 7 }" 
  find_theorems name:fin name:induc
  find_theorems "_ \<Longrightarrow> finite _"
  apply (cut_tac subset_eq_atLeast0_atMost_finite)
  thm finite_subset
   apply (rule Finite_Set.finite_subset_induct) sorry
lemma l_try_possible: \<open>pre_solve board q \<and> q \<noteq> MAX_QUEENS + 1 \<Longrightarrow> 
  possible' = { (r, c) | r c . r \<in> {(0::VDMNat)..BOARD_SIZE-1} \<and> c \<in> {0..BOARD_SIZE-1} \<and> (allowed r c board) } \<Longrightarrow> 
  pre_trys possible' board q\<close>  
  unfolding vdm_card_def pre_trys_defs pre_solve_defs
  apply (simp, safe)
   apply (rule finite_subset[of _ \<open>{ (r, c) | r c . r \<in> {(0::VDMNat)..BOARD_SIZE-1} \<and> c \<in> {0..BOARD_SIZE-1} }\<close>])
    apply (rule subsetI, simp add: case_prod_beta)
  apply (insert l_possible_finite)
  apply (simp)+
  done
  sorry 
*)

lemma l_inv_VDMSet_remove_x:
  \<open>inv_VDMSet' inv_T S \<Longrightarrow> inv_VDMSet' inv_T (S - {x})\<close> 
  unfolding inv_VDMSet'_defs by simp

lemma l_inv_VDMSet_add_x:
  \<open>inv_VDMSet' inv_T S \<Longrightarrow> inv_T x \<Longrightarrow> inv_VDMSet' inv_T ({x} \<union> S)\<close> 
  unfolding inv_VDMSet'_defs by simp 

lemma l_inv_VDMSet_some:
  \<open>inv_VDMSet' inv_T S \<Longrightarrow> v \<in> S  \<Longrightarrow> inv_T (SOME x . x \<in> S)\<close> 
  unfolding inv_VDMSet'_defs 
  apply safe
  thm ballE
  apply (erule ballE[of S _ \<open>(SOME x . x \<in> S)\<close>])
  apply simp
  by (simp add: some_in_eq)

lemma l_inv_VDMSet_frule: 
  \<open>inv_VDMSet' inv_T S \<Longrightarrow> inv_VDMSet S\<close>
  unfolding inv_VDMSet'_def by simp

lemma l_try_solve: \<open>
  pre_trys possible' board q \<Longrightarrow> 
  possible' \<noteq> {}  \<Longrightarrow>    
  pre_solve ({SOME x. x \<in> possible'} \<union> board) (q + 1)\<close> 
  unfolding pre_solve_def pre_trys_def
  apply (simp add: case_prod_beta)
  apply (elim conjE, intro conjI)
    apply (erule_tac x=\<open>SOME x. x \<in> possible'\<close> in ballE)
  apply simp
  using some_in_eq apply blast
    apply fastforce  
  using some_in_eq apply blast+
  done

lemma l_try_try: \<open>pre_trys possible' board q \<Longrightarrow> 
  pre_trys (possible' - {SOME x. x \<in> possible'}) board q\<close> 
  unfolding pre_trys_def 
  apply (simp add: l_inv_VDMSet_remove_x)
  done

lemma l_pre_solve_pre_try: \<open>pre_solve board Q \<Longrightarrow>
       Q \<noteq> 9 \<Longrightarrow> pre_trys (possible board) board Q\<close> 
  unfolding pre_trys_def pre_solve_def pre_possible_def
  apply (simp, elim conjE, intro conjI, simp_all)
  unfolding post_possible_def inv_Board_def
    apply simp
  unfolding inv_Queens_def apply simp sorry
  

lemma l_pre_try_pre_solve: \<open>
  pre_trys possible' board Q \<Longrightarrow> possible' \<noteq> {} \<Longrightarrow> 
  pre_solve ({SOME x. x \<in> possible'} \<union> board) (Q + 1)\<close> 
  unfolding pre_trys_def
  by (simp add: some_in_eq)

termination 
  apply (relation \<open>solve_try_wf\<close>)
     apply (simp add: wf_solve_try)
    apply (simp add: solve_try_wf_def l_pre_solve_pre_try)
   apply (simp add: solve_try_wf_def)
  using l_pre_try_pre_solve apply auto[1]
   apply (simp add: solve_try_wf_def)
  done

termination 
  apply (relation \<open>
      measure (\<lambda> x . 
                case x of 
                    Inl (board, Q) \<Rightarrow> if Q = MAX_QUEENS then 0 else nat ((BOARD_SIZE*BOARD_SIZE) - (vdm_card board))
                  | Inr (possible, board, Q) \<Rightarrow> if possible = {} then 0 else nat (Q+1) )\<close>)
     apply simp
  oops

definition
  run :: \<open>Board option\<close>
  where
  \<open>run \<equiv> solve {} 1\<close>
end