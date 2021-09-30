theory XO
imports Main
begin

(*=========================================================================================*)
section {* Introduction *}

text {* This example was translated from a VDM specification courtesy of Nick Battle from Fujistsu *}

(*=========================================================================================*)
section {* VDM values *}

text {* This section defines the VDM  \textsf{values} section of \textsf{XO.vdmsl}. *}

find_theorems name:Relation

text {* The size of the board is 3, but we could generalise the game, or even make it 3D! *}

abbreviation
  SIZE :: nat
where
  "SIZE \<equiv> 3"

text {* The maximum number of moves is the board dimensions *}

abbreviation "MAX \<equiv> SIZE * SIZE"


(*=========================================================================================*)
section {* VDM types *}

text {* This section defines the VDM  \textsf{types} section of \textsf{XO.vdmsl}. *}

text {* We also define two types for the play outcome options and the players.
        In VDM this is easier: we just need to extend the enumerated type.
      *}

datatype GameResult = NOUGHT_WON | CROSS_WON | DRAW | UNFINISHED

datatype Player = NOUGHT | CROSS

print_theorems

(* Teach proof by regular expressions *)
(*typedef Player = "{ NOUGHT, CROSS }" by (rule exI,simp,rule disjI1,simp) *)

text {* We also need to know the set of valid players as all possible players. 
        This is a value in VDM *}

abbreviation "PLAYERS \<equiv> {NOUGHT, CROSS}"

text {* A move position is defined next as a pair of numbers with the invariant 
        they are non negative and within @{text "SIZE"} *}

type_synonym Pos = "(nat \<times> nat)"

(*
definition
  inv_Pos :: "Pos \<Rightarrow> bool"
where
  "inv_Pos pos \<equiv> (fst pos) \<ge> 1 \<and> (fst pos) \<le> SIZE \<and> 
                  (snd pos) \<ge> 1 \<and> (snd pos) \<le> SIZE"
*)

text {* For the @{term Pos} invariant we could either use field selection, 
        or patterns matching like in VDM $mk-Pos(x,y)$; we will choose the later. 
      *}

definition
  inv_Pos :: "Pos \<Rightarrow> bool"
where
  "inv_Pos z \<equiv> let (x,y) = z in  
                  x \<ge> 1 \<and> x \<le> SIZE \<and> 
                  y \<ge> 1 \<and> y \<le> SIZE"

find_theorems "inv_Pos _"
thm inv_Pos_def

text {* Next we need to decide how the game is to be modelled. Discuss options in class/practicals *}

text {* The game is modelled as VDM Isabelle Map from position to player. The invariant
        asserts that all positions in the domain satisfy the position type invariant as well.
        Isabelle maps are total functions to an optional type:~it maps elements outside of 
        the domain to @{text "None"} and within the domain to @{text "Some x"}. So effectively,
        @{text "m :: T1 \<rightharpoonup> T2"} is the same as @{text "m :: T1 \<Rightarrow> T2 option"}, where 
        @{text "m x"} can be either @{text "None"} if @{text "x \<notin> dom m"} or @{text "Some y"}
        if @{text "x \<in> dom m"}.

        This nesting of invariant checking is common place in our translation because VDM
        type invariants are not maintained by Isabelle, hence we need to keep them ourselves.
        For a manual translation, this obviously play a serious threat to correctness
        (i.e. in case one misses checking the invariant at all necessary places).

        As the @{text "Game"} invariant is on a set of @{text "Pos"}, we generalise it a bit.
      *}

type_synonym Game = "Pos \<rightharpoonup> Player"

definition
  inv_PosSet :: "Pos set \<Rightarrow> bool"
where
  "inv_PosSet ps \<equiv> (\<forall> pos \<in> ps . inv_Pos pos)"

definition
  inv_Game :: "Game \<Rightarrow> bool"
where
  "inv_Game g \<equiv> inv_PosSet (dom g)"


text {* Next we define play order and moves using lists. Play order as a list is a bit overkill.
        Perhaps just a boolean would suffice. \textbf{TODO: check - I guess it is modelled as a list because of Overture 
        animation or for generalisation of players to more than two?}
      *}

type_synonym Moves = "Pos list"
type_synonym PlayOrder = "Player list"

definition 
  inv_Moves :: "Moves \<Rightarrow> bool"
where
  "inv_Moves m \<equiv> inv_PosSet (set m) \<and> 
                 length m = card(set m) \<and> 
                 length m > (card PLAYERS) * (SIZE-(1::nat)) \<and> 
                 length m \<le> MAX" 

definition
  inv_PlayOrder :: "PlayOrder \<Rightarrow> bool"
where
  "inv_PlayOrder po \<equiv> length po > 0 \<and> 
                       length po = card(set po) \<and>  
                       (set po) = PLAYERS"

text {* Isabelle @{term "length xs"} is the same as VDM's $\len{xs}$, whereas
        @{term "set xs"} equals $\elems{xs}$. One key difference from VDM is that
        Isabelle lists are indexed from zero, whereas VDM sequences are indexed from one.
      *}

type_synonym Line = "Pos set"

definition
  inv_Line :: "Line \<Rightarrow> bool"
where
  "inv_Line l \<equiv> inv_PosSet l"

(* IJW: to me, this is not the invariant on a line! 
{(1,2), (1,3), (2,3)} does not a line make. Nor
{(1,1)}
*)

(*-----------------------------------------------------------------------------------------*)
subsection {* Technical note *}

text {* Looking into Isabelle's libraries I guess there is  simpler and more efficient way
        of calculating sequence injectivity by asking that all elements are distinct.
      *}

(* Referencial transparency; show distinct and set *)
find_theorems "distinct _"
find_theorems "set _"
find_theorems "remdups _"

--"declare [[smt_trace]]"
lemma "distinct l \<longleftrightarrow> length l = card(set l)"
--"by (metis length_remdups_card_conv length_remdups_eq remdups_id_iff_distinct)"
by (metis card_distinct distinct_card)

thm card_distinct distinct_card

(* TODO: make defining this as part of coursework? *)

lemma "remdups m = m \<longleftrightarrow> length m = card(set m)"
by (metis length_remdups_card_conv length_remdups_eq)

(*=========================================================================================*)
section {* VDM functions *}

text {* This section defines the VDM \textsf{functions} section of \textsf{XO.vdmsl}. *}

(*-----------------------------------------------------------------------------------------*)
subsection {* Extra VDM operators *}

text {* Certain VDM map operators are not defined, like range filtering or restriction. 
        We define it next as expected and give it a seemingly infix syntax.
      *}

definition
  ran_restr :: "('a \<rightharpoonup> 'b) \<Rightarrow> 'b set \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixl "\<triangleright>" 105)
where
  "m \<triangleright> s \<equiv> (\<lambda>x . if (\<exists> y. m x = Some y \<and> y \<in> s) then m x else None)"


(*-----------------------------------------------------------------------------------------*)
subsection {* Explicitly defined functions *}

definition
  movesForPlayer :: "Game \<Rightarrow> Player \<Rightarrow> Pos set"
where
  "movesForPlayer g p \<equiv> dom (g \<triangleright> {p})"

definition
  movesSoFar :: "Game \<Rightarrow> Pos set"
where
  "movesSoFar g \<equiv> dom g"

definition 
  movesCountSoFar :: "Game \<Rightarrow> nat"
where
  "movesCountSoFar g \<equiv> card (dom g)" 
  --{* same as @{term "(if (finite(dom g)) then card (dom g) else 0)"} *}

(* EXPLAIN: caveat about 0-3 = 0*)
definition 
  movesCountLeft :: "Game \<Rightarrow> nat"
where
  "movesCountLeft g \<equiv> MAX - movesCountSoFar g"

definition
  makeMove :: "Game \<Rightarrow> Player \<Rightarrow> Pos \<Rightarrow> Game"
where
  "makeMove g p pos \<equiv> g(pos \<mapsto> p)"

(* See discussion below on post_makeMove on use or not of option types for resulting Game 
definition
  makeMove :: "Game \<Rightarrow> Player \<Rightarrow> Pos \<Rightarrow> Game option"
where
  "makeMove g p pos \<equiv> Some (g(pos \<mapsto> p))"
*)

(*-----------------------------------------------------------------------------------------*)
subsection {* Game solution (comparison) value *} 

abbreviation
  BOARD :: "nat set"
where
  "BOARD \<equiv> {1 .. SIZE}"

definition
  row :: "nat \<Rightarrow> Line"
where
  "row rr \<equiv> { (r, c) . c \<in> BOARD \<and> r=rr \<and> inv_Pos (r, c) }"

declare [[show_types]]
definition
  row2 :: "nat \<Rightarrow> Line"
where
  "row2 rr \<equiv> { (rr, c) | c . c \<in> BOARD \<and> inv_Pos (rr, c) }"

--"row2 1 \<equiv> { (1, c) | c . c \<in> 1..2 } \<equiv> { (1, 1), (1, 2) }"

lemma "row2 1 = { (1, 1), (1, 2), (1, 3) }"
unfolding row2_def inv_Pos_def
apply simp
apply auto
done

lemma "row2 r = row r"
unfolding row2_def row_def by auto

(* IJW: Have a correct line invariant then prove that row(rr) satisfies it 
   IJW: Also, if c \<in> BOARD, then surely the inv_Pos is a consequence? COuld prove to... 
  
*)
definition
  col :: "nat \<Rightarrow> Line"
where
  "col cc \<equiv> { (r,cc) | r . r \<in> BOARD \<and> inv_Pos (r, cc) }"

value "{ [A,B,C] ! i | i . i \<in> {1, 2} }"

abbreviation
  allRows0 :: "Line set"
where
  "allRows0 \<equiv> { row 1, row 2, row 3 }"

abbreviation
  allRows :: "Line set"
where
  "allRows \<equiv> \<Union> r \<in> BOARD . { row r }"
 
abbreviation
  allCols :: "Line set"
where
  "allCols \<equiv> \<Union> c \<in> BOARD . { col c }"

abbreviation
  downwardDiag0 :: "Line"
where
  "downwardDiag0 \<equiv> { (x,x) . x \<in> BOARD }" --"variable capture on snd x?"
(* IJW: no capture, this just isn't set comprehension as you imagine it.
   It should look like:
 *)
abbreviation
  downwardDiagIJW :: "Line"
where
  "downwardDiagIJW \<equiv> { (x,x)| x . x \<in> BOARD }"
(* Now the lemma can be proved, see below. *)

abbreviation
  downwardDiag :: "Line"
where
  "downwardDiag \<equiv> { (x,y) . x \<in> BOARD \<and> x=y }"


(* IJW: you'll need to do the same for this *)
abbreviation
  upwardDiag0 :: "Line"
where
  "upwardDiag0 \<equiv> { (x,y) . x \<in> BOARD \<and> y = x-SIZE+(1::nat) }" --"flipped x and SIZE"

abbreviation
  upwardDiag :: "Line"
where
  "upwardDiag \<equiv> { (x,y) . x \<in> BOARD \<and> y = SIZE-x+(1::nat) }"

(* Use definition to tame unfolding *)
definition
  winningLines :: "Line set"
where
(*  "winningLines \<equiv> \<Union> {allRows, allCols, {downwardDiag}, {upwardDiag}}"*)
   "winningLines \<equiv> allRows \<union> allCols \<union> {downwardDiag, upwardDiag}"
(* IJW: Hmm, maybe rather than sets of sets, use allRows \<union> allCols \<union> ...? *)

abbreviation
  explicitWinningLines :: "Line set"
where
  "explicitWinningLines \<equiv> 
          { {(1, 1), (1, 2), (1, 3)}, 
					 	{(2, 1), (2, 2), (2, 3)}, 
					  {(3, 1), (3, 2), (3, 3)},  

					  {(1, 1), (2, 1), (3, 1)}, 
					  {(1, 2), (2, 2), (3, 2)}, 
					  {(1, 3), (2, 3), (3, 3)}, 

					  {(1, 1), (2, 2), (3, 3)},
 
					  {(1, 3), (2, 2), (3, 1)}
				  }"	

(* Give me some sanity please :-) *)
lemma "(\<Union> x \<in> BOARD . {(x,y) . inv_Pos (x,y) }) = { (r, c) . inv_Pos (r, c) }"
by (rule,rule,simp,rule,simp)

lemma lBoardKeepsPos: "x \<in> BOARD \<and> y \<in> BOARD \<Longrightarrow> inv_Pos (x,y) \<and> inv_Pos (y,x)"
unfolding inv_Pos_def by auto

lemma "BOARD = {1,2,3}" by auto

lemma "row 1 = ({ (r,c) . r=1 \<and> c \<in> BOARD })"
unfolding inv_Pos_def row_def by auto
lemma "row 1 = { (1,1), (1,2), (1,3) }"
unfolding inv_Pos_def row_def by auto
lemma "col 1 = { (1,1), (2,1), (3,1) }"
unfolding inv_Pos_def col_def by auto

lemma ar: "allRows = allRows0"
apply (rule)
apply (rule_tac[1-] subsetI)
apply simp_all
apply (erule bexE)
apply simp
apply (elim conjE)
apply (case_tac r)
apply simp_all
apply (case_tac nat)
apply simp_all
apply (case_tac nata)
apply simp_all
apply (rule disjI2,rule disjI1)
defer
apply (rule disjI2,rule disjI2)
defer
apply (erule disjE)
apply (rule_tac x="Suc 0" in bexI,simp_all)
apply (erule disjE)
apply (rule_tac x="2" in bexI,simp_all)
apply (rule_tac x="SIZE" in bexI,simp_all)
unfolding row_def
apply auto
done (* why so protracted! *)

(* Now provable by auto *)
lemma "downwardDiagIJW = { (1,1), (2,2), (3,3) }" nitpick
  by auto

lemma "downwardDiag0 = { (1,1), (2,2), (3,3) }"
apply simp
nitpick oops

lemma dwd: "downwardDiag = { (1,1), (2,2), (3,3) }"
apply rule 
apply simp_all
apply rule
apply simp (* Hum... there is something fishy about way pairs are handled *)
apply (case_tac x,simp)
apply (elim conjE)
apply (case_tac a,simp_all)
apply (case_tac nat,simp_all)
apply (case_tac nata,simp_all) (* something fishy here on range as well *)
done


lemma "upwardDiag0 = { (3,1), (2,2), (1,3) }"
apply simp nitpick oops

lemma wdd: "upwardDiag = { (3,1), (2,2), (1,3) }"
apply rule 
apply simp_all
apply rule
apply simp (* Hum... there is something fishy about way pairs are handled *)
apply (case_tac x,simp)
apply (elim conjE)
apply (case_tac a,simp_all)
apply (case_tac nat,simp_all)
apply (case_tac nata,simp_all) (* something fishy here on range as well *)
done

(* quit unmanageable / tedious *)
lemma "winningLines = explicitWinningLines"
unfolding winningLines_def apply rule
apply simp_all  oops
(* IJW: maybe slightly easier with some of the simplifications above? *) 

(*-----------------------------------------------------------------------------------------*)
subsection {* Game solution (predicates) testing functions *} 

definition 
  hasWon :: "Game \<Rightarrow> Player \<Rightarrow> bool"
where
  "hasWon g p \<equiv> \<exists> line \<in> winningLines . line \<subseteq> (movesForPlayer g p)"

find_theorems "\<exists>! _ . _"

definition 
  isWon :: "Game \<Rightarrow> bool"
where
  "isWon g \<equiv> \<exists>! p . hasWon g p"

definition
  whoWon :: "Game \<Rightarrow> Player"
where
  "whoWon g \<equiv> THE p . hasWon g p"

definition
  isDraw :: "Game \<Rightarrow> bool"
where
  "isDraw g \<equiv> \<not> isWon g \<and> movesCountLeft g = 0"

definition
  isUnfinished :: "Game \<Rightarrow> bool"
where
  "isUnfinished g \<equiv> \<not> isWon g \<and> \<not> isDraw g"

(*=========================================================================================*)
section {* VDM state and operations *} 

text {* The only VDM operation is the one that ``plays'' the game, but first we need a conversion
        function between the two (obviously related) datatypes. 

        The game play is defined recursively on the length of the moves to be played,
        where the game remains unfinished if there are no more moves. We also augment the
        original VDM definition to tolerate (as an unfinished game) empty player ordering
        (i.e. it should really be ust boolean, so this is just glitch from the VDM model?).

        The recursive case makes the move in the game according to who is playing and,
        either decides the result, if possible, or else cary on playing. We should perhaps
        consider a iterative version of the game play function.
  *}

definition
  conv_playerToPlayOpt :: "Player \<Rightarrow> GameResult"
where
  "conv_playerToPlayOpt p \<equiv> (case p of NOUGHT \<Rightarrow> NOUGHT_WON | CROSS \<Rightarrow> CROSS_WON)"

thm Let_def

fun
  play :: "Game \<Rightarrow> PlayOrder \<Rightarrow> Moves \<Rightarrow> GameResult"
where
  "play g ps []             = UNFINISHED"
| "play g [] ms             = UNFINISHED" --"extra equation for pat-completeness"
| "play g (p # ps) (m # ms) = 
      (let g' = makeMove g p m in
          (if (isWon g') then 
                conv_playerToPlayOpt (whoWon g') 
           else if (isDraw g') then
                DRAW
           else
                play g' (ps @ [p]) ms))"

(*-----------------------------------------------------------------------------------------*)
subsubsection {* Technical note *}

text {* extra equation + recursive def + etc *}

(*
fun
  itplay :: "Game \<Rightarrow> PlayOrder \<Rightarrow> Moves \<Rightarrow> Game \<Rightarrow> PlayOrder \<Rightarrow> Moves \<Rightarrow> GameResult"
where
  "itplay g ps [] g'             = UNFINISHED"     --"when moves finished get result"
| "itplay g [] ms g'             = UNFINISHED"     --"when playorder is screw up it's UNFINISHED"
| "itplay g (p # ps) (m # ms) g' = CROSS_WON"
*)

(*=========================================================================================*)
section {* VDM test data *}

find_theorems "insort"
thm Finite_Set.fold_def 

value "sorted_list_of_set {1,2}"
value "sorted_list_of_set BOARD"
value "zip (sorted_list_of_set BOARD) (sorted_list_of_set BOARD)"
lemma "(sorted_list_of_set BOARD) = [1,2,3]" oops

abbreviation
  allPos :: "Pos set"
where
  "allPos \<equiv> { (r, c) . inv_Pos (r, c) }"

find_theorems name:choice
thm inv_def
find_theorems name:Hilbert

abbreviation
  somePos :: "Pos set \<Rightarrow> Pos"
where
  "somePos ps \<equiv> Eps (\<lambda> x . x \<in> ps \<and> inv_PosSet ps)" --{* or @{text "inv_Pos x"}? *}

value "somePos"

definition
  randomMove :: Moves
where
  "randomMove \<equiv> 
     let m1 = (somePos allPos) in 
       let m2 = (somePos (allPos - {m1})) in  
        let m3 = (somePos (allPos - {m1,m2})) in
          let m4 = (somePos (allPos - {m1,m2,m3})) in
            let m5 = (somePos (allPos - {m1,m2,m3,m4})) in
              [m1,m2,m3,m4,m5]
    "
(*
let m1 in set ALLPOS in										-- 9 1st moves
		let m2 in set ALLPOS \ {m1} in								-- 72 1st-2nd pairs
		let m3 in set ALLPOS \ {m1, m2} in							-- 504 1st-2nd-3rd etc...
		let m4 in set ALLPOS \ {m1, m2, m3} in						-- 3024
		let m5 in set ALLPOS \ {m1, m2, m3, m4} in					-- 15120 (minimum)
--		let m6 in set ALLPOS \ {m1, m2, m3, m4, m5} in				-- 60480
--		let m7 in set ALLPOS \ {m1, m2, m3, m4, m5, m6} in			-- 181440
--		let m8 in set ALLPOS \ {m1, m2, m3, m4, m5, m6, m7} in		-- 362880
--		let m9 in set ALLPOS \ {m1, m2, m3, m4, m5, m6, m7, m8} in	-- 362880
*)

find_theorems name:induct name:Finite_Set
thm finite_induct

(* I wish! How to define recursive functions over sets? 
definition
  complexMove :: "Pos set \<Rightarrow> Moves" 
where
  "complexMove ps = 
      (if (ps = {}) then []
       else 
          let x = (somePos ps) in
             x # (complexMove (ps - {x})))"
*)

abbreviation
  simpleMoves :: Moves
where
  "simpleMoves \<equiv> [(x,y) . x \<leftarrow> sorted_list_of_set BOARD, y \<leftarrow> sorted_list_of_set BOARD]"

abbreviation
  winningMoves :: Moves
where
  "winningMoves \<equiv> [(2,2),(1,3),(3,1),(2,3),(3,3),(1,1),(3,2)]"

value simpleMoves
--"value randomMove"

definition 
  testPlay0 :: "GameResult"
where
  "testPlay0 \<equiv> play empty [CROSS, NOUGHT] []"

definition 
  testPlayCross :: "GameResult"
where
  "testPlayCross \<equiv> play empty [CROSS, NOUGHT] winningMoves"

definition 
  testPlayNought :: "GameResult"
where
  "testPlayNought \<equiv> play empty [NOUGHT, CROSS] winningMoves"

thm Let_def list.split Pair_def split_if split_if_asm

(*
lemma "testPlayCross = CROSS_WON"
unfolding testPlayCross_def
apply auto
(* TODO: bugger! let's are complicated *)
oops
*)

declare [[smt_trace=false]]
lemma "allPos = { (1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3)}"
apply (rule,rule,simp,unfold inv_Pos_def,simp_all)
apply (case_tac x,simp,elim conjE)
by smt

(*=========================================================================================*)
section {* VDM pre and post condition definitions for functions *}

(*-----------------------------------------------------------------------------------------*)
subsection {* Implicitly definined pre and post *}

text {* All VDM functions have an implicitly defined pre and post condition functions.
        If no explicit pre/post condition is defined by the user, these functions just
        check the type invariants and return @{term "True"}. 

        In our translation, because the type invariants are not guaranteed by Isabelle,
        we use the definitions to achieve that. Moreover, because these are functions,
        and not operations, there is no need to check after state on postconditions.

        Furthermore, when no explicit postcondition is given, we assert the explicit VDM
        definition as part of the postcondition.

        TODO: Q for nick when calling functions within the definitions are their pre/post called?
        If so, the repetitiveness of defnitions below can be aliviated. Also, is asserting explicit
        defs as part of (implicit) post okay? Should be?
      *}

definition 
  pre_movesForPlayer :: "Game \<Rightarrow> Player \<Rightarrow> bool"
where
  "pre_movesForPlayer g p \<equiv> inv_Game g"

definition 
  post_movesForPlayer :: "Game \<Rightarrow> Player \<Rightarrow> Pos set \<Rightarrow> bool"
where
  "post_movesForPlayer g p ps \<equiv> inv_Game g \<and> inv_PosSet ps \<and> ps = movesForPlayer g p"

definition 
  pre_movesSoFar :: "Game \<Rightarrow> bool"
where
  "pre_movesSoFar g \<equiv> inv_Game g"

definition 
  post_movesSoFar :: "Game  \<Rightarrow> Pos set \<Rightarrow> bool"
where
  "post_movesSoFar g ps \<equiv> inv_Game g \<and> inv_PosSet ps \<and> ps = movesSoFar g"

definition 
  pre_movesCountSoFar :: "Game \<Rightarrow> bool"
where
  "pre_movesCountSoFar g \<equiv> inv_Game g"

definition 
  post_movesCountSoFar :: "Game \<Rightarrow> nat \<Rightarrow> bool"
where
  "post_movesCountSoFar g n \<equiv> inv_Game g \<and> n = movesCountSoFar g" -- {* maybe add @{term "n > 0"}? *}

definition 
  pre_movesCountLeft :: "Game \<Rightarrow> bool"
where
  "pre_movesCountLeft g \<equiv> inv_Game g"
  
definition 
  post_movesCountLeft :: "Game \<Rightarrow> nat \<Rightarrow> bool"
where
  "post_movesCountLeft g n \<equiv> inv_Game g \<and> n = MAX - movesCountSoFar(g)" 
                        -- {* should we call here pre_movesCountSoFar g; should @{text "n > 0"}? *}

(*-----------------------------------------------------------------------------------------*)
subsection {* Explicitly definined pre and post by the user *}

text {* When the user explicitly provides a pre and post condition, we need to be careful.
        We still need our implicit translations becasue of the type invariants, yet we also
        need the explicit definitions given by the user. 
        Thus, we define both these as boolean functions with suffix I and without suffix:~the
        former for the type invariant, whereas the latter is for the external user's definition.
        The user defined translation must call the implicitly defined one in order to check the
        invariant holds.
 *}

definition
  pre_makeMoveI :: "Game \<Rightarrow> Player \<Rightarrow> Pos \<Rightarrow> bool"
where
  "pre_makeMoveI g p pos \<equiv> inv_Game g \<and> inv_Pos pos"

definition
  pre_makeMove :: "Game \<Rightarrow> Player \<Rightarrow> Pos \<Rightarrow> bool"
where
  "pre_makeMove g p pos \<equiv> pre_makeMoveI g p pos \<and> pos \<notin> movesSoFar g \<and> movesCountLeft g > 0"

text {* Note that for the postcondition we needed to make some changes. Firstly, the implicit
        (invariant checking) definition remains the same, whereas the implicit post condition
        does not generate a call to @{text "makeMove"} given there is a post condition.

        \textbf{TODO: simplify this? Yes, because makeMove doesn't have option either? 
        Moreover, it would entail having all sorts of option types in general? THINK/ASK Nick/Cliff.}
*}

definition
  post_makeMoveI :: "Game \<Rightarrow> Player \<Rightarrow> Pos \<Rightarrow> Game \<Rightarrow> bool"
where
  "post_makeMoveI g p pos g' \<equiv> inv_Game g \<and> inv_Pos pos \<and> inv_Game g'"

definition
  post_makeMove :: "Game \<Rightarrow> Player \<Rightarrow> Pos \<Rightarrow> Game \<Rightarrow> bool"
where
  "post_makeMove g p pos g' \<equiv> 
        post_makeMoveI g p pos g' \<and>
        pos \<notin> dom g \<and>
        movesCountSoFar g' = movesCountSoFar g - 1"
        -- {* no call to @{term "g' = makeMove g p pos"}! *}

(*
definition 
  inv_GameOpt :: "Game option \<Rightarrow> bool"
where
  "inv_GameOpt g \<equiv> (case g of None \<Rightarrow> False | (Some gg) \<Rightarrow> inv_Game gg)"

definition
  post_makeMoveI :: "Game \<Rightarrow> Player \<Rightarrow> Pos \<Rightarrow> Game option \<Rightarrow> bool"
where
  "post_makeMoveI g p pos g' \<equiv> inv_Game g \<and> inv_Pos pos \<and> inv_GameOpt g'"

definition
  post_makeMoveE :: "Game \<Rightarrow> Player \<Rightarrow> Pos \<Rightarrow> Game option \<Rightarrow> bool"
where
  "post_makeMoveE g p pos g' \<equiv> 
        post_makeMoveI g p pos g' \<and>
        pos \<notin> dom g \<and>
        g' \<noteq> None \<and>
        movesCountSoFar (the g') = movesCountSoFar g - 1"
*)

(*-----------------------------------------------------------------------------------------*)
subsection {* Implicitly defined pre and post for solution (boolean-valued) functions *}

text {* Boolean valued functions (or predicates) in VDM perhaps could have a simpler translation? 
        Their very definition is already a postcondition
      *}

definition 
  pre_hasWon :: "Game \<Rightarrow> Player \<Rightarrow> bool"
where
  "pre_hasWon g p \<equiv> inv_Game g"

definition 
  post_hasWon :: "Game \<Rightarrow> Player \<Rightarrow> bool"
where
  "post_hasWon g p \<equiv> inv_Game g \<and> hasWon g p"

definition 
  pre_isWon :: "Game \<Rightarrow> bool"
where
  "pre_isWon g \<equiv> inv_Game g"

definition 
  post_isWon :: "Game \<Rightarrow> bool"
where
  "post_isWon g \<equiv> inv_Game g \<and> isWon g"

definition
  pre_whoWon :: "Game \<Rightarrow> bool"
where
  "pre_whoWon g \<equiv> inv_Game g"

definition
  pre_whoWonG :: "Game \<Rightarrow> bool"
where
  "pre_whoWonG g \<equiv> inv_Game g \<and> isWon g"

(* This one is not quite boolean valued, though :-) *)
definition
  post_whoWon :: "Game \<Rightarrow> Player \<Rightarrow> bool"
where
  "post_whoWon g p \<equiv> inv_Game g \<and> p = whoWon g"

definition
  post_whoWonG :: "Game \<Rightarrow> Player \<Rightarrow> bool"
where
  "post_whoWonG g p \<equiv> inv_Game g \<and> (\<exists>! x . hasWon g x \<and> x = p)"

definition
  pre_isDraw :: "Game \<Rightarrow> bool"
where
  "pre_isDraw g \<equiv> inv_Game g"

definition
  post_isDraw :: "Game \<Rightarrow> bool"
where
  "post_isDraw g \<equiv> inv_Game g \<and> isDraw g"

definition
  pre_isUnfinished :: "Game \<Rightarrow> bool"
where
  "pre_isUnfinished g \<equiv> inv_Game g"

definition
  post_isUnfinished :: "Game \<Rightarrow> bool"
where
  "post_isUnfinished g \<equiv> inv_Game g \<and> isUnfinished g"

(*=========================================================================================*)
section {* VDM pre and post condition definitions for operations *}

(*-----------------------------------------------------------------------------------------*)
subsection {* Implicitly defined pre and post for operations *}

(*-----------------------------------------------------------------------------------------*)
subsection {* Explicitly defined pre and post by the user for operations *}

definition 
  pre_play :: "Game \<Rightarrow> PlayOrder \<Rightarrow> Moves \<Rightarrow> bool"
where
  "pre_play g po m \<equiv> inv_Game g \<and> inv_PlayOrder po \<and> inv_Moves m"
 
definition
  post_playI :: "Game \<Rightarrow> PlayOrder \<Rightarrow> Moves \<Rightarrow> (Game \<times> GameResult) \<Rightarrow> bool"
where
  "post_playI g po m RESULT \<equiv> inv_Game g \<and> inv_PlayOrder po \<and> inv_Moves m \<and> inv_Game (fst RESULT)"

(* Interesting: Game isn't talked about in the result? *)
definition
  post_play :: "Game \<Rightarrow> PlayOrder \<Rightarrow> Moves \<Rightarrow> (Game \<times> GameResult) \<Rightarrow> bool"
where 
  "post_play g po m RESULT \<equiv> 
       post_playI g po m RESULT \<and>
       (if (snd RESULT) = DRAW then 
          isDraw g
       else if (snd RESULT) = UNFINISHED then
          isUnfinished g
       else 
          (snd RESULT) = conv_playerToPlayOpt (whoWon g))"

(*=========================================================================================*)
section {* VDM proof obligations *}

(*-----------------------------------------------------------------------------------------*)
subsection {* Satisfiability *}

text {* From Overture proof obligations tools, we get these translated and proved *}

(*
(forall g:Game & isWon(g) =>
  exists1 p:Player & hasWon(g, p))
*)
lemma "\<forall> g . isWon g \<longrightarrow> (\<exists>! p . hasWon g p)"
unfolding isWon_def by simp

(*
(forall g:Game &
  pre_whoWonG(g) => exists p:Player & post_whoWonG(g, p))
*)
lemma "\<forall> g . pre_whoWonG g \<longrightarrow> (\<exists> p . post_whoWonG g p)"
unfolding pre_whoWonG_def post_whoWonG_def isWon_def by auto

(*<*)

(*-----------------------------------------------------------------------------------------*)
(*=========================================================================================*)

lemma "2 = (THE n . (n::nat) + 4 = 6)"
by auto

lemma "3 \<noteq> (THE n . (n::nat) + 4 = 6)"
by auto

lemma "1 = (THE n . n = (n::nat) + 0)"
apply auto
oops

lemma "1 = (THE n . n = (n::nat) + 1)"
apply auto
nitpick
oops

lemma "(x \<noteq> y \<and> a=b) = (\<not> (x = y \<or> a \<noteq> b))"
by auto

lemma "(x \<noteq> y \<and> a=b) = (\<not> (a = b \<longrightarrow> x = y))"
by auto


lemma "(\<forall> x \<in> S . \<not>(\<exists> y \<in> S . x \<noteq> y \<and> a=b)) = (\<forall> x \<in> S . \<not>(\<exists> y \<in> S . (\<not> (a = b \<longrightarrow> x = y))))"
by auto

lemma "(\<forall> x \<in> S . \<not>(\<exists> y \<in> S . x \<noteq> y \<and> a=b)) = (\<forall> x \<in> S . (\<forall> y \<in> S . ((a = b \<longrightarrow> x = y))))"
by auto

end
(*>*)
