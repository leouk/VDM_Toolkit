theory Suduku
imports Main
begin

type_notation bool  ("\<bool>") 
type_notation nat ("\<nat>")

(*
MAX_GRID_VAL: nat1 = 9;
MAX_SUB_GRID: nat1 = 3;
GRID_SIZE   : nat1 = MAX_GRID_VAL * MAX_GRID_VAL;
*)
abbreviation  MAX_GRID_VAL :: \<nat> where "MAX_GRID_VAL \<equiv> 9"
abbreviation  MAX_SUB_GRID :: \<nat> where "MAX_SUB_GRID \<equiv> 3"
abbreviation  GRID_SIZE :: \<nat> 
  where "GRID_SIZE \<equiv> MAX_GRID_VAL * MAX_GRID_VAL"

(*
GRID_VALS    : set of nat1 = {1,...,MAX_GRID_VAL};
ALL_CELLS   : set of Cell = { mk_Cell(r, c) | r, c in set GRID_VALS };
*)
abbreviation  GRID_VALS :: "nat set" 
  where "GRID_VALS \<equiv> {1..MAX_GRID_VAL}"

value "GRID_VALS"

(*
Cell :: r:nat1 
			  c:nat1
inv mk_Cell(r,c) == r <= MAX_GRID_VAL 
 							  and c <= MAX_GRID_VAL;
*)
record Cell =
  r :: \<nat>
  c :: \<nat>

value "\<lparr>r = 0, c = 10\<rparr>"

definition 
   inv_Cell :: "Cell \<Rightarrow> \<bool>"
where
  "inv_Cell cell \<equiv> (r cell) \<ge> 1 \<and> (c cell) \<ge> 1 \<and>
                   (r cell) \<le> MAX_GRID_VAL \<and>
                   (c cell) \<le> MAX_GRID_VAL"  (* cell.r *)

(* ALL_CELLS = { mk_Cell(v1, v2) | v1, v2 in set GRID_VALS & True *)
definition  ALL_CELLS :: "Cell set" 
  where "ALL_CELLS \<equiv> { \<lparr> r = v1, c = v2 \<rparr> | 
                        v1 v2 . v1 \<in> GRID_VALS \<and> 
                                v2 \<in> GRID_VALS \<and>  
                                inv_Cell \<lparr> r = v1, c = v2 \<rparr>}"

declare [[show_types]]
lemma "ALL_CELLS = A"
unfolding ALL_CELLS_def
apply simp
oops

(*
{{mk_Cell(1, 1), mk_Cell(1, 2), mk_Cell(1, 3), 
  mk_Cell(2, 1), mk_Cell(2, 2), mk_Cell(2, 3), 
  mk_Cell(3, 1), mk_Cell(3, 2), mk_Cell(3, 3)}, 

 {mk_Cell(1, 4), mk_Cell(1, 5), mk_Cell(1, 6), 
  mk_Cell(2, 4), mk_Cell(2, 5), mk_Cell(2, 6), 
  mk_Cell(3, 4), mk_Cell(3, 5), mk_Cell(3, 6)}, 

 {mk_Cell(1, 7), mk_Cell(1, 8), mk_Cell(1, 9), 
  mk_Cell(2, 7), mk_Cell(2, 8), mk_Cell(2, 9), 
  mk_Cell(3, 7), mk_Cell(3, 8), mk_Cell(3, 9)}, 
 
 {mk_Cell(4, 1), mk_Cell(4, 2), mk_Cell(4, 3), 
  mk_Cell(5, 1), mk_Cell(5, 2), mk_Cell(5, 3), 
  mk_Cell(6, 1), mk_Cell(6, 2), mk_Cell(6, 3)}, 

 {mk_Cell(4, 4), mk_Cell(4, 5), mk_Cell(4, 6), mk_Cell(5, 4), mk_Cell(5, 5), mk_Cell(5, 6), mk_Cell(6, 4), mk_Cell(6, 5), mk_Cell(6, 6)}, {mk_Cell(4, 7), mk_Cell(4, 8), mk_Cell(4, 9), mk_Cell(5, 7), mk_Cell(5, 8), mk_Cell(5, 9), mk_Cell(6, 7), mk_Cell(6, 8), mk_Cell(6, 9)}, {mk_Cell(7, 1), mk_Cell(7, 2), mk_Cell(7, 3), mk_Cell(8, 1), mk_Cell(8, 2), mk_Cell(8, 3), mk_Cell(9, 1), mk_Cell(9, 2), mk_Cell(9, 3)}, {mk_Cell(7, 4), mk_Cell(7, 5), mk_Cell(7, 6), mk_Cell(8, 4), mk_Cell(8, 5), mk_Cell(8, 6), mk_Cell(9, 4), mk_Cell(9, 5), mk_Cell(9, 6)}, {mk_Cell(7, 7), mk_Cell(7, 8), mk_Cell(7, 9), mk_Cell(8, 7), mk_Cell(8, 8), mk_Cell(8, 9), mk_Cell(9, 7), mk_Cell(9, 8), mk_Cell(9, 9)}}

*)

(*
Puzzle0 = map Cell to nat1;
*)

type_synonym Puzzle0 = "Cell \<rightharpoonup> \<nat>"

definition
   nat1 :: "\<nat> \<Rightarrow> \<bool>"
where
  "nat1 n \<equiv> n \<ge> 1"

definition 
    inv_Puzzle0 :: "Puzzle0 \<Rightarrow> bool"
where
   "inv_Puzzle0 p == (\<forall> x \<in> dom p . inv_Cell x) \<and>
                     (\<forall> y \<in> ran p . nat1 y)"
 

definition
    inv_Cells :: "Cell set \<Rightarrow> \<bool>"
where
    "inv_Cells cs \<equiv> \<forall> c \<in> cs . inv_Cell c"

definition 
    inv_Puzzle0_2 :: "(Cell \<rightharpoonup> \<nat>) \<Rightarrow> \<bool>"
where
    "inv_Puzzle0_2 p \<equiv> inv_Cells (dom p) \<and> 
                        (\<forall> x \<in> dom p . nat1 (the (p x)))"

definition
    inv_Puzzle :: "Puzzle0 \<Rightarrow> bool"
where   
    "inv_Puzzle p == inv_Puzzle0 p \<and> ran p \<subseteq> GRID_VALS"

definition 
  get3x3 :: "Cell \<Rightarrow> Cell"
where
  "get3x3 cell \<equiv> \<lparr>r =((((r cell)- 1) div MAX_SUB_GRID) * MAX_SUB_GRID)+1,
                  c =((((c cell)- 1) div MAX_SUB_GRID) * MAX_SUB_GRID)+1\<rparr>"

definition 
  post_get3x3 :: "Cell \<Rightarrow> Cell \<Rightarrow> bool"
where
  "post_get3x3 cell result \<equiv> (r result) \<in> {1,4,7} \<and> (c result) \<in> {1,4,7}"

(*
(forall mk_Cell(r, c):Cell & 
    post_get3x3(mk_Cell(r, c), 
        mk_Cell(((((r - 1) div MAX_SUB_GRID) * MAX_SUB_GRID) + 1), 
                ((((c - 1) div MAX_SUB_GRID) * MAX_SUB_GRID) + 1))))
*)

declare [[show_types]]
definition
   PO_get3x3_satisfiability :: "bool"
where
  "PO_get3x3_satisfiability == \<forall> cell . inv_Cell cell \<longrightarrow> 
                                          (let row = (r cell); col = (c cell) in 
                                              post_get3x3 cell 
                                                         \<lparr>r =((((r cell)- 1) div MAX_SUB_GRID) * MAX_SUB_GRID)+1,
                                                          c =((((c cell)- 1) div MAX_SUB_GRID) * MAX_SUB_GRID)+1\<rparr>)"

lemma PO_get3x3_satisfiability
unfolding PO_get3x3_satisfiability_def post_get3x3_def
apply auto
nitpick
oops

definition
   in3x3 :: "Cell \<Rightarrow> Cell \<Rightarrow> \<bool>"
where
   "in3x3 cell origin \<equiv> inv_Cell cell \<and> inv_Cell origin \<and> 
                        (r cell) \<ge> (r origin) \<and> 
                        (r cell) \<le> (r origin) + (MAX_SUB_GRID - 1) \<and>
                        (c cell) \<ge> (c origin) \<and> 
                        (c cell) \<le> (r origin) + (MAX_SUB_GRID - 1)"

(*
-- set of 'first' cells per sub-grid (e.g. mk_Cell(1,1), mk_Cell(1,7), mk_Cell(4,7))
SUB_GRID_ORIGINS : set of Cell	 		  = { get3x3(c) | c in set ALL_CELLS };
SUB_GRID_CELLS   : set of set of Cell = { { c | c in set ALL_CELLS & in3x3(c, get3x3(origin)) } | origin in set SUB_GRID_ORIGINS };
*)

definition
   SG_ORIGINS :: "Cell set"
where
  "SG_ORIGINS \<equiv> { get3x3 c | c . c \<in> ALL_CELLS }"

definition
   SG_ORIGINS2 :: "Cell set"
where
  "SG_ORIGINS2 \<equiv> { cell | cell . cell \<in> ALL_CELLS \<and> 
                   (r cell) \<in> {1,4,7} \<and> (c cell) \<in> {1,4,7}}"

definition
   SG_CELLS :: "Cell set set"
where
  "SG_CELLS \<equiv> { { c | c . c \<in> ALL_CELLS \<and> 
                  in3x3 c (get3x3 origin)} | 
                    origin . origin \<in> SG_ORIGINS }"

value "get3x3 \<lparr> r = 1, c =1 \<rparr>"
value "get3x3 \<lparr> r = 5, c =1 \<rparr>"
value "get3x3 \<lparr> r = 9, c =1 \<rparr>"
value "in3x3 \<lparr> r = 2, c = 2 \<rparr> (get3x3 \<lparr> r = 2, c = 1\<rparr>)"
value "in3x3 \<lparr> r = 2, c = 2 \<rparr> (get3x3 \<lparr> r = 5, c = 1\<rparr>)"


definition
    isInj :: "Puzzle0 \<Rightarrow> \<bool>"
where
  "isInj p \<equiv> inv_Puzzle0 p \<and>  
              (\<forall> x1 \<in> dom p . \<forall> x2 \<in> dom p . 
                  \<forall> y . p x1 = y \<and> p x2 = y \<longrightarrow> x1 = x2)"

definition
  dom_restr :: "'a set \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)"  (infixr "\<triangleleft>" 110)
where
  [intro!]: "s \<triangleleft> m \<equiv> m |` s" 
  (* same as VDM  s <: m *)

definition
    sgValid :: "Puzzle0 \<Rightarrow> \<bool>"
where
  "sgValid p \<equiv> inv_Puzzle0 p \<and> 
                (\<forall> sg \<in> SG_CELLS . isInj (sg \<triangleleft> p))"

definition
   inv_Puzzle_2 :: "Puzzle0 \<Rightarrow> \<bool>"
where
  "inv_Puzzle_2 p \<equiv> inv_Puzzle0 p \<and> finite(dom p) \<and> 
                    card(dom p) \<le> GRID_SIZE \<and> 
                    ran p \<subseteq> GRID_VALS \<and> sgValid p"


end
