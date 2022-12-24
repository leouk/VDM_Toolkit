theory NQueens
imports VDMToolkit
begin

type_synonym Pos = "VDMNat \<times> VDMNat" 

definition 
  inv_Pos :: "Pos \<Rightarrow> \<bool>"
  where
  "inv_Pos p \<equiv> inv_VDMNat (fst p) \<and> inv_VDMNat (snd p)"

type_synonym Board = "Pos VDMSet"

definition 
  inv_Board :: "Board \<Rightarrow> \<bool>"
  where
  "inv_Board b \<equiv> inv_VDMSet' inv_Pos b"

definition 
  allowed :: \<open>VDMNat \<Rightarrow> VDMNat \<Rightarrow> Board \<Rightarrow> \<bool>\<close>
  where
  \<open>allowed r c board \<equiv> 
      (r, c) \<in> board \<and>
      \<not> (\<exists> b \<in> board . let (r',c') = b in r = r' \<or> c = c' \<or> vdm_abs (r - r') = vdm_abs (c - c'))
  \<close>

definition 
  pre_solve :: \<open>Board \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>\<close>
  where
\<open>pre_solve board Q \<equiv> inv_Board board \<and> inv_VDMNat1 Q\<close>

definition 
  pre_trys :: \<open>Pos VDMSet \<Rightarrow> Board \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>\<close>
  where
\<open>pre_trys possible board Q \<equiv> inv_VDMSet' inv_Pos possible \<and> inv_Board board \<and> inv_VDMNat1 Q\<close>

function (domintros)
  solve :: \<open>Board \<Rightarrow> VDMNat1 \<Rightarrow> Board option\<close> and
  trys  :: \<open>Pos VDMSet \<Rightarrow> Board \<Rightarrow> VDMNat1 \<Rightarrow> Board option\<close>
  where 
  \<open>solve board Q = 
      (if pre_solve board Q then 
          (if Q = 9 then 
            Some board 
          else 
            (let possible = { (r, c) | r c . r \<in> {(0::VDMNat)..7} \<and> c \<in> {0..7} \<and> (allowed r c board) } in
                (trys possible board Q))
          )
       else 
          undefined)
  \<close>
| \<open>trys possible board Q = 
    (if pre_trys possible board Q then 
       let p = (\<some> x . x \<in> possible) in 
          let solution = solve (board \<union> {p}) (Q+1) in 
            if solution = None then 
              (trys (possible - {p}) board Q)
            else
              solution 
     else
      undefined
    )
  \<close>
  by (pat_completeness, auto)
termination 
  oops

definition
  run :: \<open>Board option\<close>
  where
  \<open>run \<equiv> solve {} 1\<close>
end