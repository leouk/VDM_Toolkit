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
  "inv_Board b \<equiv> inv_VDMSet' inv_Coord b"

lemmas inv_Board_defs = inv_VDMSet'_defs inv_Coord_defs

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

lemmas pre_solve_defs = pre_solve_def inv_Board_def inv_VDMNat1_def 
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
          let p = (\<some> x . x \<in> possible);
              solution = solve (board \<union> {p}) (Q+1) in 
            if solution = None then 
              (trys (possible - {p}) board Q)
            else
              solution 
     else
      undefined
    )
  \<close>
  by (pat_completeness, auto)

lemma l_board_size: \<open>inv_Board board \<Longrightarrow> vdm_card board \<le> 64\<close> oops

termination 
  apply (relation \<open>
      measure (\<lambda> x . 
                case x of 
                    Inl (board, Q) \<Rightarrow> if Q = MAX_QUEENS then 0 else nat ((BOARD_SIZE*BOARD_SIZE) - (vdm_card board))
                  | Inr (possible, board, Q) \<Rightarrow> if possible = {} then 0 else nat (Q+1) )\<close>)
     apply simp
    apply (simp add: pre_solve_def)
    apply (intro allI conjI impI)
      apply (erule allE[of _ "0::Pos"])+
  apply simp unfolding allowed_def vdm_abs_def apply simp 
  find_theorems "_ = (_::'a set)" elim
  apply (elim equalityE)
  apply (simp add: set_of_pred_def)
  find_theorems "_ = _Collect _"
  oops

definition
  run :: \<open>Board option\<close>
  where
  \<open>run \<equiv> solve {} 1\<close>
end