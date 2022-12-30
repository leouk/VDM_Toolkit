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
  "MAX_QUEENS \<equiv> BOARD_SIZE + 1"

type_synonym Queens = "VDMNat1" 

definition 
  inv_Queens :: \<open>VDMNat1 \<Rightarrow> \<bool>\<close>
  where
  \<open>inv_Queens q \<equiv> inv_VDMNat1 q \<and> q \<le> MAX_QUEENS\<close>

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
  pre_solve :: \<open>Board \<Rightarrow> Queens \<Rightarrow> \<bool>\<close>
  where
\<open>pre_solve board Q \<equiv> inv_Board board \<and> inv_Queens Q\<close>

definition 
  pre_trys :: \<open>Coord VDMSet \<Rightarrow> Board \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>\<close>
  where
\<open>pre_trys possible board Q \<equiv> inv_VDMSet' inv_Coord possible \<and> inv_Board board \<and> inv_Queens Q\<close>

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
          (if Q = MAX_QUEENS then 
            Some board 
          else 
            (let possible = { (r, c) | r c . r \<in> {(0::VDMNat)..BOARD_SIZE-1} \<and> c \<in> {0..BOARD_SIZE-1} \<and> (allowed r c board) } in
                (trys possible board Q))
          )
       else 
          undefined)
  \<close>
| \<open>trys possible board Q = 
    (if pre_trys possible board Q then 
       if possible = {} then
          None 
       else 
          let p = (\<some> x . x \<in> possible) in
            if pre_solve (board \<union> {p}) (Q+1) then
              let solution = solve (board \<union> {p}) (Q+1) in 
                if solution = None then 
                  (trys (possible - {p}) board Q)
                else
                  solution 
            else 
              undefined
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
  { (Inr(possible, board, q),Inl(board, q)) | possible board q . 
      pre_trys possible board q \<and> pre_solve board q \<and> q \<noteq> MAX_QUEENS \<and>
      possible = { (r, c) | r c . r \<in> {(0::VDMNat)..BOARD_SIZE-1} \<and> c \<in> {0..BOARD_SIZE-1} \<and> (allowed r c board) }    
  }
\<union> { (Inl(board', q'), Inr(possible, board, q)) | possible board q board' q' .
     pre_trys possible board q \<and> pre_solve board' q' \<and> q \<noteq> MAX_QUEENS \<and>
     possible \<noteq> {} \<and> board' = (board \<union> {(\<some> x . x \<in> possible)}) \<and> q' = q+1 \<and>
     pre_solve board' q' } 
\<union> { (Inr(possible', board, q), Inr(possible, board, q)) | possible possible' board q .
     pre_trys possible board q \<and> pre_trys possible' board q \<and> 
     possible \<noteq> {} \<and> possible' = possible - {(\<some> x . x \<in> possible)}  
  }"

lemma wf_solve_try: "wf solve_try_wf" sorry

lemma l_possible_finite: "finite { (r, c) | r c . 0 \<le> r \<and> r \<le> 7 \<and> 0 \<le> c \<and> c \<le> 7 }" 
  find_theorems name:fin name:induc
  find_theorems "_ \<Longrightarrow> finite _"
  apply (cut_tac subset_eq_atLeast0_atMost_finite)
  thm finite_subset
  apply (rule Finite_Set.finite_subset_induct) oops
lemma l_try_possible: \<open>pre_solve board q \<and> q \<noteq> MAX_QUEENS \<Longrightarrow> 
  possible = { (r, c) | r c . r \<in> {(0::VDMNat)..BOARD_SIZE-1} \<and> c \<in> {0..BOARD_SIZE-1} \<and> (allowed r c board) } \<Longrightarrow> 
  pre_trys possible board q\<close>  
  unfolding vdm_card_def pre_trys_defs pre_solve_defs
  apply (simp, safe)
   apply (rule finite_subset[of _ \<open>{ (r, c) | r c . r \<in> {(0::VDMNat)..BOARD_SIZE-1} \<and> c \<in> {0..BOARD_SIZE-1} }\<close>])
    apply (rule subsetI, simp add: case_prod_beta)
  apply (insert l_possible_finite)
  apply (simp)+
  done

lemma l_solve_possible: \<open>pre_trys possible board q \<Longrightarrow> q \<noteq> MAX_QUEENS \<Longrightarrow> possible \<noteq> {}  \<Longrightarrow>    
  pre_solve ({SOME x. x \<in> possible} \<union> board) (q + 1)\<close> 
  unfolding pre_solve_def pre_trys_def
  apply (simp add: case_prod_beta, safe)
   defer
  unfolding inv_Queens_def inv_VDMNat1_def
  apply simp
  sorry

lemma l_try_try_possible: \<open>pre_trys possible board q \<Longrightarrow> 
  possible \<noteq> {} \<Longrightarrow>
  pre_trys (possible - {SOME x. x \<in> possible}) board q\<close> sorry

termination 
  apply (relation \<open>solve_try_wf\<close>)
     apply (simp add: wf_solve_try)
    apply (simp add: solve_try_wf_def l_try_possible)
   apply (simp add: solve_try_wf_def)
  using l_solve_possible apply auto[1]
  unfolding pre_solve_def inv_Queens_defs apply simp
   apply (simp add: solve_try_wf_def l_try_try_possible)
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