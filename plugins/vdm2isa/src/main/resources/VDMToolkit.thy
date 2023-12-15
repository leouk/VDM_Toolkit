(*
  Title : VDM mathematical toolkit, Sep 2021
  Author: Leo Freitas
*)
theory VDMToolkit
  imports 
    \<comment> \<open> Include real fields, list and option types ordering \<close>
    "Complex_Main"
(*    VDMEisbach*)
    "HOL-Library.List_Lexorder"
    "HOL-Library.Option_ord"
    "HOL-Library.LaTeXsugar"
    "HOL-Library.While_Combinator"
begin

(*****************************************************************)      
section \<open> Basic types \<close>  

type_notation bool ("\<bool>")
type_notation nat ("\<nat>")
type_notation int ("\<int>")
type_notation rat ("\<rat>")
type_notation real ("\<real>")

text \<open>VDM numeric expressions have a series of implicit type widening rules. For 
      example, \<^term>\<open>(4::\<nat>) - (x::\<nat>)\<close> could lead to an integer \<^term>\<open>-y\<close> result, despite 
      all parameters involved being \<^typ>\<open>\<nat>\<close>, whereas in HOL, the result is always a \<^typ>\<open>\<nat>\<close> 
      ultimately equal to\<^term>\<open>0\<close>.

      Therefore, we take the view of the widest (compatible) type to use in the translation,
      where type widening to \<^typ>\<open>\<rat>\<close> or \<^typ>\<open>\<real>\<close> is dealt with through Isabelle's type coercions.\<close>
type_synonym VDMNat  = \<int>
type_synonym VDMNat1 = \<int>
type_synonym VDMInt  = \<int>
type_synonym VDMRat  = \<rat>
type_synonym VDMReal = \<real>
type_synonym VDMChar = char

text \<open>Moreover, VDM type invariant checks have to be made explicit in VDM. That is possible either 
     through subtyping, which will require substantial proof-engineering machinery; or through explicit
     type invariant predicates. We choose the later for all VDM types.\<close>
definition
  inv_VDMNat :: "\<int> \<Rightarrow> \<bool>"
where
  (*<*) [intro!]: (*>*) 
  "inv_VDMNat n \<equiv> n \<ge> 0"

definition
  inv_VDMNat1 :: "\<int> \<Rightarrow> \<bool>"
where
  (*<*)[intro!]: (*>*) 
  "inv_VDMNat1 n \<equiv> n > 0"

text \<open>Bottom invariant check is that value is not undefined.\<close>
definition
  inv_True :: "'a \<Rightarrow> \<bool>"
  where
  [intro!]: "inv_True \<equiv> \<lambda> x . True"
  (* \<lambda> x . x \<noteq> undefined *)

definition
  "inv_bool" :: "\<bool> \<Rightarrow> \<bool>"
where
  (*<*) [simp]: (*>*) 
  "inv_bool i \<equiv> inv_True i"

definition
  inv_VDMChar :: "VDMChar \<Rightarrow> \<bool>"
where
  (*<*) [intro!]: (*>*) 
  "inv_VDMChar c \<equiv> inv_True c"

definition
  inv_VDMInt :: "\<int> \<Rightarrow> \<bool>"
where
  (*<*) [intro!]: (*>*) 
  "inv_VDMInt i \<equiv> inv_True i"

definition
  inv_VDMReal :: "\<real> \<Rightarrow> \<bool>"
where
  (*<*) [intro!]: (*>*) 
  "inv_VDMReal r \<equiv> inv_True r"

definition
  inv_VDMRat :: "\<rat> \<Rightarrow> \<bool>"
where
  (*<*) [intro!]: (*>*) 
  "inv_VDMRat r \<equiv> inv_True r"

(*
lemma l_inv_True_undefined[simp]: "\<not> inv_True undefined" unfolding inv_True_def by simp
lemma l_inv_bool_undefined[simp]: "\<not> inv_bool undefined" unfolding inv_bool_def by simp

lemma l_inv_True_True[simp]: "r \<noteq> undefined \<Longrightarrow> inv_True r" 
  by (simp add: inv_True_def)  
*)

lemma l_inv_True_True[iff]: "inv_True r"
  by (simp add: inv_True_def)

lemma l_inv_VDMNat[iff]: "inv_VDMNat n \<longleftrightarrow> n \<ge> 0"
  by (simp add: inv_VDMNat_def)

lemma l_inv_VDMNat1[iff]: "inv_VDMNat1 n \<longleftrightarrow> n > 0"
  by (simp add: inv_VDMNat1_def)

text \<open>In general, VDM narrow expressions are tricky, given they can downcast types according 
  to the user-specified type of interest. In particular, at least for \<^typ>\<open>\<real>\<close> and \<^typ>\<open>\<rat>\<close> 
  (\<^term>\<open>floor_ceiling\<close> type class), type narrowing to \<^typ>\<open>VDMInt\<close> is fine\<close>
definition 
  vdm_narrow_real :: "('a::floor_ceiling) \<Rightarrow> VDMInt"
  where
  "vdm_narrow_real r \<equiv> \<lfloor>r\<rfloor>"

definition
  vdm_div :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt" (infixl "vdmdiv" 70)
where
  [intro!] :
  "x vdmdiv y \<equiv> 
    (if ((x / y) < 0) then
       -\<lfloor>\<bar>-x / y\<bar>\<rfloor>
    else  
       \<lfloor>\<bar>x / y\<bar>\<rfloor>)"  

definition
  pre_vdm_div :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>"
  where
  "pre_vdm_div x y \<equiv> y \<noteq> 0"

definition
  post_vdm_div :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>"
  where
  "post_vdm_div x y RESULT \<equiv> 
    (x \<ge> 0 \<and> y \<ge> 0 \<longrightarrow> RESULT \<ge> 0) \<and>
    (x < 0 \<and> y < 0 \<longrightarrow> RESULT \<ge> 0) \<and>
    (x < 0 \<and> 0 < y \<longrightarrow> RESULT \<le> 0) \<and>
    (0 < x \<and> y < 0 \<longrightarrow> RESULT \<le> 0)"
  (* Could perhaps strengthen the < 0 case for when 1 < x? *)

text \<open>VDM has div and mod but also rem for remainder. This is treated 
differently depending on whether the values involved have different sign.
For now, we add these equivalences below, but might have to pay price in proof
later. To illustrate this difference consider the result of 
@{lemma \<open>-7 div (3::\<int>) = -3\<close> by simp} versus 
@{lemma \<open>-7 vdmdiv (3::\<int>) = -2\<close> by (simp add: vdm_div_def)}\<close>

definition 
  vdm_mod :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt" (infixl "vdmmod" 70)
where
  [intro!] :
  "x vdmmod y \<equiv> x - y * \<lfloor>x / y\<rfloor>"

definition
  pre_vdm_mod :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>"
  where
  "pre_vdm_mod x y \<equiv> y \<noteq> 0"

definition
  post_vdm_mod :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>"
  where
  "post_vdm_mod x y RESULT \<equiv> 
    (y \<ge> 0 \<longrightarrow> RESULT \<ge> 0) \<and>
    (y < 0 \<longrightarrow> RESULT \<le> 0)"

definition 
  vdm_rem :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt" (infixl "vdmrem" 70)
where
  [intro!] :
  "x vdmrem y \<equiv> x - y * (x vdmdiv y)" 

definition
  pre_vdm_rem :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>"
  where
  "pre_vdm_rem x y \<equiv> y \<noteq> 0"

definition
  post_vdm_rem :: "VDMInt \<Rightarrow> VDMInt \<Rightarrow> VDMInt \<Rightarrow> \<bool>"
  where
  "post_vdm_rem x y RESULT \<equiv> 
    (x \<ge> 0 \<longrightarrow> RESULT \<ge> 0) \<and>
    (x < 0 \<longrightarrow> RESULT \<le> 0)"

text \<open>VDM has the power (\verb'**') operator for numbers, which is \<^term>\<open>Transcendental.powr\<close> in Issable. 
   Like in VDM, it accepts non-integer exponents. Isabelle have \<^term>\<open>x^y\<close> for exponent \<^term>\<open>y\<close> of type \<^typ>\<open>\<nat>\<close>, 
   and \<^term>\<open>x powr y\<close> for exponent \<^term>\<open>y\<close> that is a subset of the \<^typ>\<open>\<real>\<close> (i.e. real normed algebra natural logarithms; 
  or natural logarithm exponentiation). We take the latter for translation.\<close>

definition
  vdm_pow :: "'a::ln \<Rightarrow> 'a::ln \<Rightarrow> 'a::ln" (infixl "vdmpow" 80)
  where                     
  [intro!]: "x vdmpow y \<equiv> x powr y"

definition
  pre_vdm_pow :: "'a::ln \<Rightarrow> 'a::ln \<Rightarrow> \<bool>"
  where
  "pre_vdm_pow x y \<equiv> True"

definition
  post_vdm_pow :: "'a::ln \<Rightarrow> 'a::ln \<Rightarrow> 'a::ln \<Rightarrow> \<bool>"
  where
  "post_vdm_pow x y RESULT \<equiv> True"

text \<open>For VDM floor and abs, we use Isabelle's. Note that in VDM abs of \<^typ>\<open>\<int>\<close>  
will return \<^typ>\<open>VDMNat\<close>, as the underlying type invariant might require further filtering 
on the function's results. \<close>

find_theorems "_ (_::'a list list)" name:concat
definition 
  vdm_floor :: "VDMReal \<Rightarrow> VDMNat"
  where
  [intro!]: "vdm_floor x \<equiv> \<lfloor>x\<rfloor>"

text \<open>The postcondition for flooring, takes the axiom defined in the archimedian field type class\<close>
definition
  post_vdm_floor :: "VDMReal \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
  where
  "post_vdm_floor x RESULT \<equiv> 
    of_int RESULT \<le> x \<and> x < of_int (RESULT + 1)"    

definition 
  vdm_abs :: "('a::{zero,abs,ord}) \<Rightarrow> ('a::{zero,abs,ord})"
  where
  [intro!]: "vdm_abs x \<equiv> \<bar>x\<bar>"

text \<open>Absolute postcondition does not use \<^term>\<open>inv_VDMNat\<close> because the result could also be of type \<^typ>\<open>\<real>\<close>.\<close>
definition
  post_vdm_abs :: "('a::{zero,abs,ord}) \<Rightarrow> ('a::{zero,abs,ord}) \<Rightarrow> \<bool>"
  where
  "post_vdm_abs x RESULT \<equiv> RESULT \<ge> 0" (*inv_VDMNat RESULT"*)

text \<open>For equally signed  operands of VDM's div/mod, we can get back to Isabelle's version of the operators, 
  which will give access to various lemmas useful in proofs. So, if possible, automatically jump to the Isabelle versions.\<close>
lemma vdmdiv_div_ge0[simp] : 
  "0 \<le> x \<Longrightarrow> 0 \<le> y \<Longrightarrow> x vdmdiv y = x div y"
  unfolding vdm_div_def
  apply (induct y) apply simp_all
  by (metis divide_less_0_iff floor_divide_of_int_eq floor_less_zero floor_of_int floor_of_nat le_less_trans less_irrefl of_int_of_nat_eq of_nat_less_0_iff)

lemma vdmdiv_div_le0[simp] : 
  "x \<le> 0 \<Longrightarrow> y \<le> 0 \<Longrightarrow> x vdmdiv y = x div y"
  unfolding vdm_div_def
  apply (induct y) apply simp_all
  apply safe
   apply (simp add: divide_less_0_iff)
  by (metis (no_types) floor_divide_of_int_eq minus_add_distrib minus_divide_right of_int_1 of_int_add of_int_minus of_int_of_nat_eq uminus_add_conv_diff)

lemma vdmmod_mod[simp] : 
  "x vdmmod y = x mod y"
  unfolding vdm_mod_def
  apply (induct y) apply simp_all
   apply (metis floor_divide_of_int_eq minus_mult_div_eq_mod of_int_of_nat_eq)
  by (smt (verit, ccfv_threshold) floor_divide_of_int_eq minus_div_mult_eq_mod mult.commute of_int_diff of_int_eq_1_iff of_int_minus of_int_of_nat_eq)

lemma l_vdm_div_fsb: "pre_vdm_div x y \<Longrightarrow> post_vdm_div x y (x vdmdiv y)" 
  unfolding pre_vdm_div_def post_vdm_div_def
  apply (safe)
  using div_int_pos_iff vdmdiv_div_ge0 apply presburger
  using vdm_div_def apply (smt (verit) divide_neg_neg floor_less_iff of_int_0_less_iff of_int_minus)
  using vdm_div_def using divide_less_0_iff apply auto[1]
  using vdm_div_def 
  by auto
  
lemma l_vdm_mod_fsb: "pre_vdm_mod x y \<Longrightarrow> post_vdm_mod x y (x vdmmod y)" 
  unfolding pre_vdm_mod_def post_vdm_mod_def
  apply safe
  by (simp add: vdm_mod_def)+

lemma l_vdm_rem_fsb: "pre_vdm_rem x y \<Longrightarrow> post_vdm_rem x y (x vdmrem y)" 
  unfolding pre_vdm_rem_def post_vdm_rem_def vdm_rem_def
  apply safe
  apply (cases "y \<ge> 0")
    apply simp
    apply (metis Euclidean_Division.pos_mod_sign add.commute add.left_neutral add_mono_thms_linordered_semiring(3) div_mult_mod_eq le_less mult.commute)
   defer
   apply (cases "y \<le> 0")
    apply simp 
    apply (metis div_mod_decomp_int group_cancel.rule0 le_add_same_cancel1 le_less mult.commute neg_mod_sign not_le)
  unfolding vdm_div_def
   apply (simp_all, safe)
     apply (smt (verit, ccfv_SIG) divide_minus_left floor_divide_lower floor_less_iff floor_uminus_of_int mult.commute of_int_mult)
    apply (simp add: divide_neg_pos)
   apply (smt (verit) ceiling_def ceiling_divide_eq_div minus_mod_eq_mult_div neg_mod_sign)
  using divide_pos_neg by force

subsection \<open>VDM tokens\<close>

text 
\<open>VDM tokens are like a record with a parametric type (i.e. you can 
have anything inside a \verb'mk_token(x)' expression, akin to a VDM record
 \verb'Token :: token : ?', where \verb'?' refers to \verb'vdmj' wildcard type. 
Isabelle does not allow parametric records, hence we use datatypes instead. 

This will impose the restriction on token variables during translation: they will always 
have to be of the same inner type; whereas for token constants, then any type is acceptable. \<close>
(* types T = token; values x: T = mk_token("ABC"); y: T = mk_token(10); --wrong type inference for 'a
   values z: token = mk_token("ABC"); w: token = mk_token(10); -- okay given no specific type synonym for 'a *)
datatype 'a VDMToken = Token 'a

definition 
  inv_VDMToken :: "'a VDMToken \<Rightarrow> \<bool>"
  where
  "inv_VDMToken t \<equiv> inv_True t"

definition 
  inv_VDMToken' :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a VDMToken \<Rightarrow> \<bool>"
  where
  "inv_VDMToken' inv_T t \<equiv> case t of Token a \<Rightarrow> inv_T a"

text \<open>Isabelle lemmas definitions are issues for all the inner calls and related definitions used
      within given definitions. This allows for a laywered unfolding and simplification of VDM terms 
      during proofs. \<close>
lemmas inv_VDMToken'_defs = inv_VDMToken'_def inv_True_def

lemma l_inv_VDMTokenI[simp]: "inv_T a \<Longrightarrow> t = (Token a) \<Longrightarrow> inv_VDMToken' inv_T t" 
  by (simp add: inv_VDMToken'_def)

(*****************************************************************)
section \<open> Sets \<close>

text \<open>All VDM structured types (e.g. sets, sequences, maps, etc.) must check the
     type invariant of its constituent parts, beyond any user-defined invariant. 

      Moreover, all VDM sets are finite. Therefore, we define VDM set invariant checks as
      combination of finiteness checks with invariant checks of its elements type. \<close>

type_synonym 'a VDMSet = "'a set"
type_synonym 'a VDMSet1 = "'a set"

definition
  inv_VDMSet :: "'a VDMSet \<Rightarrow> \<bool>"
  where
   [intro!]:  "inv_VDMSet s \<equiv> finite s"

definition
  inv_VDMSet1 :: "'a VDMSet1 \<Rightarrow> \<bool>"
  where
   [intro!]:  "inv_VDMSet1 s \<equiv> inv_VDMSet s \<and> s \<noteq> {}"

definition 
  inv_SetElems :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a VDMSet \<Rightarrow> \<bool>"
where
  "inv_SetElems einv s \<equiv> \<forall> e \<in> s . einv e"

text \<open> Added wrapped version of the definition so that we can translate 
complex structured types (e.g. \verb'seq of seq of T', etc.). Parameter order matter
for partial instantiation (e.g. \<^term>\<open>inv_VDMSet' (inv_VDMSet' inv_VDMNat) s\<close>).\<close>
definition
  inv_VDMSet' :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a VDMSet \<Rightarrow> \<bool>"
  where
   [intro!]:  "inv_VDMSet' einv s \<equiv> inv_VDMSet s \<and> inv_SetElems einv s"
    
definition
  inv_VDMSet1' :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a VDMSet1 \<Rightarrow> \<bool>"
  where
   [intro!]:  "inv_VDMSet1' einv s \<equiv> inv_VDMSet1 s \<and> inv_SetElems einv s"

definition
  vdm_card :: "'a VDMSet \<Rightarrow> VDMNat"
  where
  "vdm_card s \<equiv> (if inv_VDMSet s then int (card s) else undefined)"

definition
  pre_vdm_card :: "'a VDMSet \<Rightarrow> \<bool>"
  where
  [intro!]:  "pre_vdm_card s \<equiv> inv_VDMSet s"

definition
  post_vdm_card :: "'a VDMSet \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
  where
  [intro!]:  "post_vdm_card s RESULT \<equiv> pre_vdm_card s \<longrightarrow> inv_VDMNat RESULT"

lemmas inv_VDMSet_defs   = inv_VDMSet_def
lemmas inv_VDMSet1_defs  = inv_VDMSet1_def inv_VDMSet_def   
lemmas inv_VDMSet'_defs  = inv_VDMSet'_def  inv_VDMSet_def inv_SetElems_def
lemmas inv_VDMSet1'_defs = inv_VDMSet1'_def inv_VDMSet1_defs inv_SetElems_def
lemmas vdm_card_defs     = vdm_card_def inv_VDMSet_defs

lemma l_invVDMSet_finite_f: "inv_VDMSet s \<Longrightarrow> finite s"
  using inv_VDMSet_def by auto
    
lemma l_inv_SetElems_Cons[simp]: "(inv_SetElems f (insert a s)) = (f a \<and> (inv_SetElems f s))"
unfolding inv_SetElems_def
  by auto

lemma l_inv_SetElems_Un[simp]: "(inv_SetElems f (S \<union> T)) = (inv_SetElems f S \<and> inv_SetElems f T)"
  unfolding inv_SetElems_def
  by auto

lemma l_inv_SetElems_Int[simp]: "(inv_SetElems f (S \<inter> T)) = (inv_SetElems f (S \<inter> T))"
  unfolding inv_SetElems_def
  by auto

lemma l_inv_SetElems_empty[simp]: "inv_SetElems f {}" 
unfolding inv_SetElems_def by simp

lemma l_invSetElems_inv_True_True[simp]: "undefined \<notin> r \<Longrightarrow> inv_SetElems inv_True r" 
  by (metis inv_SetElems_def l_inv_True_True)
  
lemma l_vdm_card_finite[simp]: "finite s \<Longrightarrow> vdm_card s = int (card s)"
  unfolding vdm_card_defs by simp

lemma l_vdm_card_range[simp]: "x \<le> y \<Longrightarrow> vdm_card {x .. y} = y - x + 1"
  unfolding vdm_card_defs by simp 

lemma l_vdm_card_positive[simp]: 
  "finite s \<Longrightarrow> 0 \<le> vdm_card s"
  by simp

lemma l_vdm_card_VDMNat[simp]: 
  "finite s \<Longrightarrow> inv_VDMNat (vdm_card s)"
  by (simp add: inv_VDMSet_def inv_VDMNat_def)

lemma l_vdm_card_non_negative[simp]:
  "finite s \<Longrightarrow> s \<noteq> {} \<Longrightarrow> 0 < vdm_card s"
  by (simp add: card_gt_0_iff)
    
lemma l_vdm_card_isa_card[simp]:
  "finite s \<Longrightarrow> card s \<le> i \<Longrightarrow> vdm_card s \<le> i"
  by simp

lemma l_isa_card_inter_bound: 
  "finite T \<Longrightarrow> card T \<le> i \<Longrightarrow> card (S \<inter> T) \<le> i"
  thm card_mono inf_le2 le_trans card_seteq Int_commute nat_le_linear
  by (meson card_mono inf_le2 le_trans)

lemma l_vdm_card_inter_bound: 
  "finite T \<Longrightarrow> vdm_card T \<le> i \<Longrightarrow> vdm_card (S \<inter> T) \<le> i"
proof -
  assume a1: "vdm_card T \<le> i"
  assume a2: "finite T"
  have f3: "\<forall>A Aa. ((card (A::'a set) \<le> card (Aa::'a set) \<or> \<not> vdm_card A \<le> vdm_card Aa) \<or> infinite A) \<or> infinite Aa"
    by (metis (full_types) l_vdm_card_finite of_nat_le_iff)
  { assume "T \<inter> S \<noteq> T"
    then have "vdm_card (T \<inter> S) \<noteq> vdm_card T \<and> T \<inter> S \<noteq> T \<or> vdm_card (T \<inter> S) \<le> i"
      using a1 by presburger
    then have "vdm_card (T \<inter> S) \<le> i"
      using f3 a2 a1 by (meson card_seteq dual_order.trans inf_le1 infinite_super verit_la_generic) }
  then show ?thesis
    using a1 by (metis (no_types) Int_commute)
qed

theorem l_vdm_card_fsb:
  "pre_vdm_card s \<Longrightarrow> post_vdm_card s (vdm_card s)"
  by (simp add: inv_VDMNat_def inv_VDMSet_def post_vdm_card_def pre_vdm_card_def)

text \<open> @TODO power set \<close>
    
(*****************************************************************)      
section \<open> Sequences \<close>

type_synonym 'a VDMSeq  = "'a list"
type_synonym 'a VDMSeq1 = "'a list"

definition
  inv_VDMSeq1 :: "'a VDMSeq1 \<Rightarrow> \<bool>"
where
  [intro!]: "inv_VDMSeq1 s \<equiv> s \<noteq> []"

text\<open> Sequences may have invariants within their inner type. \<close>

definition 
  inv_SeqElems :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>"
where
  [intro!]: "inv_SeqElems einv s \<equiv> list_all einv s"

definition 
  inv_SeqElems0 :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>"
where
  "inv_SeqElems0 einv s \<equiv> \<forall> e \<in> (set s) . einv e"

text \<open>  Isabelle's list @{term hd} and @{term tl} functions have the
same name as VDM. Nevertheless, their results is defined for empty lists.
We need to rule them out.
\<close>

definition
  inv_VDMSeq' :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>"
  where
   [intro!]:  "inv_VDMSeq' einv s \<equiv> inv_SeqElems einv s"
    
definition
  inv_VDMSeq1' :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a VDMSeq1 \<Rightarrow> \<bool>"
  where
   [intro!]:  "inv_VDMSeq1' einv s \<equiv> inv_VDMSeq' einv s \<and> inv_VDMSeq1 s"

lemmas inv_VDMSeq'_defs  = inv_VDMSeq'_def  inv_SeqElems_def
lemmas inv_VDMSeq1'_defs = inv_VDMSeq1'_def inv_VDMSeq'_defs inv_VDMSeq1_def 

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

(*****************************************************************)
subsection \<open> Sequence operators specification \<close>  

definition
  len :: "'a VDMSeq \<Rightarrow> VDMNat"
where
  [intro!]: "len l \<equiv> int (length l)"

definition
  post_len :: "'a VDMSeq \<Rightarrow> VDMNat \<Rightarrow> \<bool>"
where
  "post_len s R \<equiv> inv_VDMNat R \<and> (s \<noteq> [] \<longrightarrow> inv_VDMNat1 R)"

definition 
  elems :: "'a VDMSeq \<Rightarrow> 'a VDMSet"
where
  [intro!]: "elems l \<equiv> set l"

definition 
  post_elems :: "'a VDMSeq \<Rightarrow> 'a VDMSet \<Rightarrow> \<bool>" 
  where
  "post_elems s R \<equiv> R \<subseteq> set s"

text \<open> Be careful with representation differences 
   VDM lists are 1-based, whereas Isabelle list 
   are 0-based. This function returns {0,1,2}
   for sequence [A, B, C] instead of {1,2,3} \<close>

definition
   inds0 :: "'a VDMSeq \<Rightarrow> VDMNat VDMSet"
where
  "inds0 l \<equiv> {0 ..< len l}"

definition
   inds :: "'a VDMSeq \<Rightarrow> VDMNat1 VDMSet"
where
  [intro!]: "inds l \<equiv> {1 .. len l}"

definition
  post_inds :: "'a VDMSeq \<Rightarrow> VDMNat1 VDMSet \<Rightarrow> \<bool>"
  where
  "post_inds l R \<equiv> finite R \<and> (len l) = (card R)"

definition
   inds_as_nat :: "'a VDMSeq \<Rightarrow> \<nat> set"
where
  "inds_as_nat l \<equiv> {1 .. nat (len l)}"

text \<open> @{term applyList} plays with @{typ "'a option"} type instead of @{term undefined}. \<close>  

definition
  applyList :: "'a VDMSeq \<Rightarrow> \<nat> \<Rightarrow> 'a option" 
where
 "applyList l n \<equiv> (if (n > 0 \<and> int n \<le> len l) then 
                      Some(l ! (n - (1::nat))) 
                   else 
                      None)"

text \<open> @{term applyVDMSeq} sticks with @{term undefined}. \<close>  
 
definition
  applyVDMSeq :: "'a VDMSeq \<Rightarrow> VDMNat1 \<Rightarrow> 'a" (infixl "$" 100)
  where
 "l $ n \<equiv> (if (inv_VDMNat1 n \<and> n \<le> len l) then 
                      (l ! nat (n - 1)) 
                   else 
                      undefined)"

definition
  applyVDMSubseq' :: "'a VDMSeq \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> 'a VDMSeq"        ("_ $$$ (1{_.._})") where
  "s $$$ {l..u} \<equiv> if inv_VDMNat1 l \<and> inv_VDMNat1 u \<and> (l \<le> u) then 
                  nths s {(nat l)-1..(nat u)-1}
                else
                  []"

text \<open>Thanks to Tom Hayle for suggesting a generalised version, which is similar to the one below\<close>
definition
  applyVDMSubseq :: "'a VDMSeq \<Rightarrow> VDMInt VDMSet \<Rightarrow> 'a VDMSeq" (infixl "$$" 105)
  where
  "xs $$ s \<equiv> nths xs {x::nat | x . x+1 \<in> s }"

lemma l_vdm_len_fsb: "post_len s (len s)"
  using post_len_def len_def 
  by (simp add: len_def post_len_def inv_VDMNat1_def inv_VDMNat_def)

lemma l_vdm_elems_fsb: "post_elems s (elems s)"
  by (simp add: elems_def post_elems_def)

lemma l_vdm_inds_fsb: "post_inds s (inds s)"
  using post_inds_def inds_def len_def 
  by (simp add: inds_def len_def post_inds_def)

lemma l_vdmsubseq_empty[simp]: 
  "[] $$ {l..u} = []" unfolding applyVDMSubseq_def by simp

lemma l_vdmsubseq_beyond[simp]: 
  "l > u \<Longrightarrow> s $$ {l..u} = []" unfolding applyVDMSubseq_def by simp

(*
s(i,...,j) = 

          1.........(len s)
            i.......j       = j - i + 1  
          i....j            = j - i + 1
      -1..0..1
       i............j       = j - 1 + 1
       i.......j            = j - 1 + 1
       i...............j    = len s - 1 + 1

       i..j                 = j - i + 1 = 0

                     = (min j (len s) - max 1 i) + 1
  "len (s $$ {l..u}) = (min 0 (max 1 ((min u (len s)) - (min l 1) + 1)))"
*)

lemma "len (s $$ {i..j}) = (min j ((len s) - (max 1 i))) + 1"
  unfolding applyVDMSubseq_def len_def
  apply (simp add: length_nths)
  unfolding min_def max_def apply (simp, safe)
  apply (induct s)
   apply simp
      apply (induct i )
  oops
  
lemma l_vdmsubseq_ext_eq:
  "inv_VDMNat1 l \<Longrightarrow> inv_VDMNat1 u \<Longrightarrow> s $$$ {l..u} = s $$ {l..u}" 
  unfolding applyVDMSubseq_def applyVDMSubseq'_def inv_VDMNat1_def 
  apply (simp;safe)
  apply (subgoal_tac "{nat l - Suc 0..nat u - Suc 0} = {x. l \<le> int x + 1 \<and> int x + 1 \<le> u}")
   apply (erule HOL.subst; simp)
   apply (safe;simp)
     apply linarith+
  apply (subgoal_tac "{x. l \<le> int x + 1 \<and> int x + 1 \<le> u} = {}")
   apply (erule ssubst,simp)
  by auto

lemmas applyVDMSeq_defs = applyVDMSeq_def inv_VDMNat1_def len_def

definition 
  pre_applyVDMSeq :: "'a VDMSeq \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
  "pre_applyVDMSeq xs i \<equiv> inv_VDMNat1 i \<and> i \<le> len xs" (*\<and> i \<in> inds xs?*)

definition 
  post_applyVDMSeq :: "'a VDMSeq \<Rightarrow> VDMNat1 \<Rightarrow> 'a \<Rightarrow> \<bool>"
where
  "post_applyVDMSeq xs i R \<equiv> pre_applyVDMSeq xs i \<longrightarrow> R = xs $ i"

theorem PO_applyVDMSeq_fsb:
  "\<forall> xs i . pre_applyVDMSeq xs i \<longrightarrow> post_applyVDMSeq xs i (xs$i)"  
  unfolding post_applyVDMSeq_def pre_applyVDMSeq_def by simp

definition 
  pre_applyVDMSubseq :: "'a VDMSeq \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
where
  "pre_applyVDMSubseq xs l u \<equiv> inv_VDMNat1 l \<and> inv_VDMNat1 u \<and> l \<le> u" 

definition 
  post_applyVDMSubseq :: "'a VDMSeq \<Rightarrow> VDMNat1 \<Rightarrow> VDMNat1 \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>"
where
  "post_applyVDMSubseq xs l u R \<equiv> R = (if pre_applyVDMSubseq xs l u then (xs$${l..u}) else [])"

theorem PO_applyVDMSubseq_fsb:
  "\<forall> xs i . pre_applyVDMSubseq xs l u \<longrightarrow> post_applyVDMSubseq xs l u (xs$${l..u})"  
  unfolding post_applyVDMSubseq_def pre_applyVDMSubseq_def by simp

definition
  post_append :: "'a VDMSeq \<Rightarrow> 'a VDMSeq \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>"
  where
  "post_append s t r \<equiv> r = s @ t"

lemmas VDMSeq_defs = elems_def inds_def applyVDMSeq_defs

lemma l_applyVDMSeq_inds[simp]: 
  "pre_applyVDMSeq xs i = (i \<in> inds xs)"
  unfolding pre_applyVDMSeq_def inv_VDMNat1_def len_def inds_def
  by auto

text \<open> Isabelle @{term hd} and @{term tl} is the same as VDM \<close> 
  
definition
  pre_hd :: "'a VDMSeq \<Rightarrow> \<bool>"
where
  "pre_hd s \<equiv> s \<noteq> []"

definition
  post_hd :: "'a VDMSeq \<Rightarrow> 'a \<Rightarrow> \<bool>"
where
  "post_hd s RESULT \<equiv> pre_hd s \<longrightarrow> (RESULT \<in> elems s \<or> RESULT = s$1)"
  
definition
  pre_tl :: "'a VDMSeq \<Rightarrow> \<bool>"
where
  "pre_tl s \<equiv> s \<noteq> []"

definition
  post_tl :: "'a VDMSeq \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>"
where
  "post_tl s RESULT \<equiv> pre_tl s \<longrightarrow> elems RESULT \<subseteq> elems s"

definition
  vdm_reverse :: "'a VDMSeq \<Rightarrow> 'a VDMSeq"
  where
  [intro!]: "vdm_reverse xs \<equiv> rev xs"

definition
  post_vdm_reverse :: "'a VDMSeq \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>"
  where
  "post_vdm_reverse xs R \<equiv> elems xs = elems R"
  
definition
  conc :: "'a VDMSeq VDMSeq \<Rightarrow> 'a VDMSeq"
  where
  [intro!]: "conc xs \<equiv> concat xs"

definition
  vdmtake :: "VDMNat \<Rightarrow> 'a VDMSeq \<Rightarrow> 'a VDMSeq"
  where
  "vdmtake n s \<equiv> (if inv_VDMNat n then take (nat n) s else [])"

definition
  post_vdmtake :: "VDMNat \<Rightarrow> 'a VDMSeq \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>"
  where
  "post_vdmtake n s RESULT \<equiv> 
    len RESULT = min n (len s)
  \<and> elems RESULT \<subseteq> elems s"

definition
  seq_prefix :: "'a VDMSeq \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool>" ("(_/ \<sqsubseteq> _)" [51, 51] 50)
  where
  "s \<sqsubseteq> t \<equiv> (s = t) \<or> (s = []) \<or> (len s \<le> len t \<and> (\<exists> i \<in> inds t . s = vdmtake i t))"

definition
  post_seq_prefix :: "'a VDMSeq \<Rightarrow> 'a VDMSeq \<Rightarrow> \<bool> \<Rightarrow> \<bool>"
  where
  "post_seq_prefix s t RESULT \<equiv>
    RESULT \<longrightarrow> (elems s \<subseteq> elems t \<and> len s \<le> len t)"

(*****************************************************************)      
subsection \<open> Sequence operators lemmas \<close>  

lemma l_inv_VDMSet_finite[simp]: 
  "finite xs \<Longrightarrow> inv_VDMSet xs"
  unfolding inv_VDMSet_def by simp  

lemma l_inv_SeqElems_alt: "inv_SeqElems einv s = inv_SeqElems0 einv s"  
by (simp add: elems_def inv_SeqElems0_def inv_SeqElems_def list_all_iff)

lemma l_inv_SeqElems_empty[simp]: "inv_SeqElems f []" 
  by (simp add: inv_SeqElems_def)

lemma l_inv_SeqElems_Cons: "(inv_SeqElems f (a#s)) = (f a \<and> (inv_SeqElems f s))"
unfolding inv_SeqElems_def elems_def by auto

lemma l_inv_SeqElems_Cons': "f a \<Longrightarrow> inv_SeqElems f s \<Longrightarrow> inv_SeqElems f (a#s)"
  by (simp add: l_inv_SeqElems_Cons)

lemma l_inv_SeqElems_append: "(inv_SeqElems f (xs @ [x])) = (f x \<and> (inv_SeqElems f xs))"
unfolding inv_SeqElems_def elems_def by auto

lemma l_inv_SeqElems_append': "f x \<Longrightarrow> inv_SeqElems f xs \<Longrightarrow> inv_SeqElems f (xs @ [x])"
  by (simp add: l_inv_SeqElems_append)

(*
lemma l_invSeqElems_inv_True_True[simp]: "undefined \<notin> elems r \<Longrightarrow> inv_SeqElems inv_True r" 
  by (metis elems_def inv_SeqElems0_def l_inv_SeqElems_alt l_inv_True_True)
*)
lemma l_invSeqElems_inv_True_True[simp]: "inv_SeqElems inv_True r" 
  by (metis inv_SeqElems0_def l_inv_SeqElems_alt l_inv_True_True)

lemma l_len_nat1[simp]: "s \<noteq> [] \<Longrightarrow> 0 < len s"
  unfolding len_def by simp

lemma l_len_append_single[simp]: "len(xs @ [x]) = 1 + len xs"
apply (induct xs)
apply simp_all
unfolding len_def by simp_all

lemma l_len_empty[simp]: "len [] = 0" unfolding len_def by simp

lemma l_len_cons[simp]: "len(x # xs) = 1 + len xs"
apply (induct xs)
unfolding len_def by simp_all

lemma l_elems_append[simp]: "elems (xs @ [x]) = insert x (elems xs)"
unfolding elems_def by simp

lemma l_elems_cons[simp]: "elems (x # xs) = insert x (elems xs)"
unfolding elems_def by simp

lemma l_elems_empty[simp]: "elems [] = {}" unfolding elems_def by simp

lemma l_inj_seq: "distinct s \<Longrightarrow> nat (len s) = card (elems s)"
by (induct s) (simp_all add: elems_def len_def) (* add: l_elems_cons *)

lemma l_elems_finite[simp]:
  "finite (elems l)"
  by (simp add: elems_def)

lemma l_inds_append[simp]: "inds (xs @ [x]) = insert (len (xs @ [x])) (inds xs)"
unfolding inds_def  
by (simp add: atLeastAtMostPlus1_int_conv len_def)

lemma l_inds_cons[simp]: "inds (x # xs) = {1 .. (len xs + 1)}"
  unfolding inds_def len_def
  by simp

lemma l_len_within_inds[simp]: "s \<noteq> [] \<Longrightarrow> len s \<in> inds s"
unfolding len_def inds_def
apply (induct s)
by simp_all

lemma l_inds_empty[simp]: "inds [] = {}" 
  unfolding inds_def len_def by simp

lemma l_inds_as_nat_append: "inds_as_nat (xs @ [x]) = insert (length (xs @ [x])) (inds_as_nat xs)"
unfolding inds_as_nat_def len_def by auto 

lemma l_applyVDM_len1: "s $ (len s + 1) = undefined"
  unfolding applyVDMSeq_def len_def by simp
  
lemma l_applyVDM_zero[simp]: "s $ 0 = undefined"
  unfolding applyVDMSeq_defs by simp

(* this goal is too specific; they are useful in specific situations *)
lemma l_applyVDM1: "(x # xs) $ 1 = x" 
  by (simp add: applyVDMSeq_defs)

lemma l_applyVDM2: "(x # xs) $ 2 = xs $ 1" 
  by (simp add: applyVDMSeq_defs)

(* generalise previous failure for a better matching goal: trade $ for ! *)
lemma l_applyVDM1_gen[simp]: "s \<noteq> [] \<Longrightarrow> s $ 1 = s ! 0"
  by (induct s, simp_all add: applyVDMSeq_defs)

lemma l_applyVDMSeq_i[simp]: "i \<in> inds s \<Longrightarrow> s $ i = s ! nat(i - 1)"
  unfolding applyVDMSeq_defs inds_def by simp

lemma l_applyVDM_cons_gt1empty: "i > 1 \<Longrightarrow> (x # []) $ i = undefined"
  by (simp add: applyVDMSeq_defs)

lemma l_applyVDM_cons_gt1: "len xs > 0 \<Longrightarrow> i > 1 \<Longrightarrow> (x # xs) $ i = xs $ (i - 1)"
  apply (simp add: applyVDMSeq_defs) (* again too complex; try avoiding the trade $ for ! again *)
  apply (intro impI)
  apply (induct xs rule: length_induct)
  apply simp_all
  by (smt nat_1 nat_diff_distrib)

lemma l_applyVDMSeq_defined: "s \<noteq> [] \<Longrightarrow> inv_SeqElems (\<lambda> x . x \<noteq> undefined) s \<Longrightarrow>  s $ (len s) \<noteq> undefined"
  unfolding applyVDMSeq_defs  
  apply (simp) (* add: l_len_nat1)*)
  apply (cases "nat (int (length s) - 1)")
  apply simp_all
  apply (cases s)
    apply simp_all 
  unfolding inv_SeqElems_def 
   apply simp 
  by (simp add: list_all_length)
  (*thm ssubst[OF l_inv_SeqElems_alt]
  apply (subst ssubst[OF l_inv_SeqElems_alt])*)

lemma l_applyVDMSeq_append_last: 
  "(ms @ [m]) $ (len (ms @ [m])) = m"
  unfolding applyVDMSeq_defs 
  by (simp)

lemma l_applyVDMSeq_cons_last: 
  "(m # ms) $ (len (m # ms)) = (if ms = [] then m else ms $ (len ms))"
  apply (simp)
  unfolding applyVDMSeq_defs
  by (simp add: nat_diff_distrib')

lemma l_inds_in_set:
  "i \<in> inds s \<Longrightarrow> s$i \<in> set s"
  unfolding inds_def applyVDMSeq_def inv_VDMNat1_def len_def
  apply (simp,safe)
  by (simp)

lemma l_inv_SeqElems_inds_inv_T:
  "inv_SeqElems inv_T s \<Longrightarrow> i \<in> inds s \<Longrightarrow> inv_T (s$i)"
  apply (simp add: l_inv_SeqElems_alt)
  unfolding inv_SeqElems0_def 
  apply (erule_tac x="s$i" in ballE)
  apply simp
  using l_inds_in_set by blast

lemma l_inv_SeqElems_all:
  "inv_SeqElems inv_T s = (\<forall> i \<in> inds s . inv_T (s$i))"
  unfolding inv_SeqElems_def 
  apply (simp add: list_all_length)
  unfolding inds_def len_def
  apply (safe,simp, safe)
   apply (erule_tac x="nat(i-1)" in allE)
   apply simp
   apply (erule_tac x="int n + 1" in ballE)
  by simp+

lemma l_inds_upto: "(i \<in> inds s) = (i \<in> {1..len s})" 
  by (simp add: inds_def)

lemma l_vdmtake_take[simp]: "vdmtake n s = take n s" 
  unfolding vdmtake_def inv_VDMNat_def 
  by simp

lemma l_seq_prefix_append_empty[simp]: "s \<sqsubseteq> s @ []"
  unfolding seq_prefix_def
  by simp

lemma l_seq_prefix_id[simp]: "s \<sqsubseteq> s"
  unfolding seq_prefix_def
  by simp

lemma l_len_append[simp]: "len s \<le> len (s @ t)"
  apply (induct t)
  by (simp_all add: len_def)

lemma l_vdmtake_len[simp]: "vdmtake (len s) s = s"
  unfolding vdmtake_def len_def inv_VDMNat_def by simp

lemma l_vdmtake_len_append[simp]: "vdmtake (len s) (s @ t) = s" 
  unfolding vdmtake_def len_def inv_VDMNat_def by simp

lemma l_vdmtake_append[simp]: "vdmtake (len s + len t) (s @ t) = (s @ t)" 
  apply (induct t)
   apply simp_all 
  unfolding vdmtake_def len_def inv_VDMNat_def
  by simp

value "vdmtake (1 + len [a,b,c]) ([a,b,c] @ [a])"

lemma l_seq_prefix_append[simp]: "s \<sqsubseteq> s @ t"
  unfolding seq_prefix_def  
  apply (induct t)
  apply simp+
  apply (elim disjE)
    apply (simp_all)
  apply (cases s, simp)
  apply (rule disjI2, rule disjI2)
   apply (rule_tac x="len s" in bexI)
    apply (metis l_vdmtake_len_append)
  using l_len_within_inds apply blast
  by (metis (full_types) atLeastAtMost_iff inds_def l_len_append l_len_within_inds l_vdmtake_len_append)

lemma l_elems_of_inds_of_nth:  
  "1 < j \<Longrightarrow> j < int (length s) \<Longrightarrow> s ! nat (j - 1) \<in> set s"
  by simp
    
lemma l_elems_inds_found:
  "x \<in> set s \<Longrightarrow> (\<exists> i . i < length s \<and> s ! i = x)"
  (*apply (simp only: ListMem_iff[symmetric])*)
  apply (induct s)
   apply simp_all
  apply safe
  by auto
    
lemma l_elems_of_inds: 
  "(x \<in> elems s) = (\<exists> j . j \<in> inds s \<and> (s$j) = x)" 
  unfolding elems_def inds_def
  apply (rule iffI)
  unfolding applyVDMSeq_def len_def
  apply (frule l_elems_inds_found)
  apply safe
   apply (rule_tac x="int(i)+1" in exI)
   apply (simp add: inv_VDMNat1_def)
  using inv_VDMNat1_def by fastforce

(*****************************************************************)      
section \<open> Optional inner type invariant check \<close>

definition
  inv_Option :: "('a \<Rightarrow> \<bool>) \<Rightarrow> 'a option \<Rightarrow> \<bool>"
  where
  [intro!]: "inv_Option inv_type v \<equiv> v \<noteq> None \<longrightarrow> inv_type (the v)"

lemma l_inv_option_Some[simp]:
  "inv_Option inv_type (Some x) = inv_type x"
  unfolding inv_Option_def
  by simp

lemma l_inv_option_None[simp]:
  "inv_Option inv_type None"
  unfolding inv_Option_def
  by simp

(*****************************************************************)      
section \<open> Maps \<close>
  
(*type_synonym ('a, 'b) "VDMMap" = "'a \<rightharpoonup> 'b" (infixr "\<rightharpoonup>" 0)*)
text \<open>
   In Isabelle, VDM maps can be declared by the @{text "\<rightharpoonup>"} operator (not @{text "\<Rightarrow>"}) 
   (i.e. type 'right' and you will see the arrow on dropdown menu).

   It represents a function to an optional result as follows:

   VDM     : map X to Y
   Isabelle: @{text "X \<rightharpoonup> Y"}

   which is the same as 

   Isabelle: @{text "X \<Rightarrow> Y option"}
   
   where an optional type is like using nil in VDM (map X to [Y]).
   That is, Isabele makes the map total by mapping everything outside
   the domain to None (or nil). In Isabelle

   @{text "datatype 'a option = None | Some 'a"}

 Some VDM functions for map domain/range restriction and filtering. You use some like <: and :>.
 The use of some of these functions is one reason that makes the use of maps a bit more demanding,
 but it works fine. Given these are new definitions, "apply auto" won't finish proofs as Isabelle
 needs to know more (lemmas) about the new operators. \<close>
  
definition
  inv_VDMMap :: "('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow>\<bool>"
where
  [intro!]: 
  "inv_VDMMap inv_Dom inv_Rng m \<equiv> 
      inv_VDMSet' inv_Dom (dom m) \<and> 
      inv_VDMSet' inv_Rng (ran m)"
  
definition
  inv_VDMMap1 :: "('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> \<bool>"
  where
  [intro!]: "inv_VDMMap1 inv_Dom inv_Ran m \<equiv> 
    inv_VDMMap inv_Dom inv_Ran m \<and> m \<noteq> Map.empty"
  (*vdm_card (dom m) > 0 \<and> is worst more complicated for nothing*)

definition
  inv_VDMInmap :: "('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> \<bool>"
  where
  [intro!]: "inv_VDMInmap inv_Dom inv_Ran m \<equiv> 
    inv_VDMMap inv_Dom inv_Ran m \<and> inj m"

lemmas inv_VDMMap_defs = inv_VDMMap_def inv_VDMSet'_defs
lemmas inv_VDMMap1_defs = inv_VDMMap1_def inv_VDMMap_defs
lemmas inv_VDMInmap_defs = inv_VDMInmap_def inv_VDMMap_defs inj_def

definition
  rng :: "('a \<rightharpoonup> 'b) \<Rightarrow> 'b VDMSet" 
  where
  [intro!]: "rng m \<equiv> ran m"

lemmas rng_defs = rng_def ran_def
  
definition
  dagger :: "('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixl "\<dagger>" 100)
where
  [intro!]: "f \<dagger> g \<equiv> f ++ g"

definition
  munion :: "('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixl "\<union>m" 90)
where
  [intro!]: "f \<union>m g \<equiv> (if dom f \<inter> dom g = {} then f \<dagger> g else undefined)"

definition 
  dom_restr :: "'a set \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixr "\<triangleleft>" 110)
where
  [intro!]: "s \<triangleleft> m \<equiv> m |` s"
   (* same as VDM  s <: m *)

definition
  dom_antirestr :: "'a set \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixr "-\<triangleleft>" 110)
where
  [intro!]: "s -\<triangleleft> m \<equiv> (\<lambda>x. if x : s then None else m x)"
   (* same as VDM   s <-: m *)

definition
  rng_restr :: "('a \<rightharpoonup> 'b) \<Rightarrow> 'b set \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixl "\<triangleright>" 105)
where
  [intro!]: "m \<triangleright> s \<equiv> (\<lambda>x . if (\<exists> y. m x = Some y \<and> y \<in> s) then m x else None)"
   (* same as VDM   m :> s *)
 
definition
  rng_antirestr :: "('a \<rightharpoonup> 'b) \<Rightarrow> 'b set \<Rightarrow> ('a \<rightharpoonup> 'b)" (infixl "\<triangleright>-" 105)
where
  [intro!]: "m \<triangleright>- s \<equiv> (\<lambda>x . if (\<exists> y. m x = Some y \<and> y \<in> s) then None else m x)"
   (* same as VDM   m :-> s *)

definition
  vdm_merge :: "('a \<rightharpoonup> 'b) VDMSet \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "vdm_merge mm \<equiv> undefined" (*TODO: (\<lambda> x . x \<in> \<Union> { dom mmi | mmi \<in> mm )} )"*)

definition
  vdm_inverse :: "('a \<rightharpoonup> 'b) \<Rightarrow> ('b \<rightharpoonup> 'a)"
  where
  "vdm_inverse m \<equiv> undefined" (*(\<lambda> x . if (x \<in> rng m) then (m x) else None)"*)

definition
  map_subset :: "('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('b \<Rightarrow> 'b \<Rightarrow> \<bool>) \<Rightarrow> \<bool>"  ("((_)/ \<subseteq>\<^sub>s (_)/, (_))" [0, 0, 50] 50)
where
  "(m\<^sub>1 \<subseteq>\<^sub>s m\<^sub>2, subset_of) \<longleftrightarrow> (dom m\<^sub>1 \<subseteq> dom m\<^sub>2 \<and> (\<forall>a \<in> dom m\<^sub>1. subset_of (the(m\<^sub>1 a)) (the(m\<^sub>2 a))))"

text \<open> Map application is just function application, but the result is an optional type, 
  so it is up to the user to unpick the optional type with the @{term the} operator. 
  It means we shouldn't get to undefined,
        rather than we are handling undefinedness. That's because the value
        is comparable (see next lemma). In effect, if we ever reach undefined
        it means we have some partial function application outside its domain
        somewhere within any rewriting chain. As one cannot reason about this
        value, it can be seen as a flag for an error to be avoided.\<close>

definition
  map_comp :: "('b \<rightharpoonup> 'c) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'c)" (infixl "\<circ>m" 55)
  where
  "f \<circ>m g \<equiv> (\<lambda> x . if x \<in> dom g then f (the (g x)) else None)"

definition 
  map_compatible :: "('a \<rightharpoonup> 'b) \<Rightarrow> ('a \<rightharpoonup> 'b) \<Rightarrow> \<bool>" 
  where
  "map_compatible m1 m2 \<equiv> (\<forall> a \<in> dom m1 \<inter> dom m2 . m1 a = m2 a)"

(*****************************************************************)      
subsection \<open>Map comprehension\<close>

text \<open>Isabelle maps are similar to VDMs, but with some significant differences worth observing. 
 
      If the filtering is not unique (i.e. result is not a function), then the @{term "THE x . P x"} expression
      might lead to (undefined) unexpected results. In Isabelle maps, repetitions is equivalent to overriding,
      so that @{lemma "[1::nat \<mapsto> 2, 1 \<mapsto> 3] 1 = Some 3" by simp}. 

      In various VDMToolkit definitions, we default to @{term undefined} in case where the situation is out of hand,
      hence, proofs will fail, and users will know that @{term undefined} being reached means some earlier problem has
      occurred.  
    \<close>

text \<open>Type bound map comprehension cannot filter for type invariants, hence won't have @{term undefined} results.
      This corresponds to the VDMSL expression
      %
      \begin{verbatim}
        { domexpr(d) |-> rngexpr(d, r) | d:S, r: T & P(d, r) }
      \end{verbatim}
      % 
      where the maplet expression can be just variables or functions over the domain/range input(s). 

      VDM also issues a proof obligation for type bound maps (i.e. avoid it please!) to ensure the resulting map is finite.
      Concretely, the example below generates the corresponding proof obligation:
      %
      \begin{verbatim}
      	ex: () -> map nat to nat
	      ex() == { x+y |-> 10 | x: nat, y in set {4,5,6} \& x < 10 };

        exists finmap1: map nat to (map (nat1) to (nat1)) & 
            forall x:nat, y in set {4, 5, 6} & (x < 10) => 
              exists findex2 in set dom finmap1 & 
                finmap1(findex2) = {(x + y) |-> 10}
      \end{verbatim}
     \<close>
definition 
  mapCompTypeBound :: "('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "mapCompTypeBound inv_S inv_T domexpr rngexpr pred \<equiv> 
        (\<lambda> dummy::'a . 
            if (\<exists> d r . inv_S d \<and> inv_T r \<and> dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r) then
                Some (THE r . inv_T r \<and> (\<exists> d . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r)) 
              else 
                None
        )"

value "[1::nat \<mapsto> 2::nat, 3 \<mapsto> 3] 10"
text \<open>Set bound map comprehension can filter bound set for their elements invariants.
      This corresponds to the VDMSL expression
      %
      \begin{verbatim}
        { domexpr(d, r) |-> rngexpr(d, r) | d in set S, r in set T & pred(d, r) } 
        { domexpr(d, r) | d in set S , r in set T & pred(d, r) }  
        { rngexpr(d, r) | d in set S , r in set T & pred(d, r) } 
        domexpr: S * T -> S 
        rngexpr: S * T -> T 
        pred   : S * T -> bool 
      \end{verbatim}
      % 
      If the types of \verb'domexpr' or \verb'rngexpr' are different from \verb'S' or \verb'T' then this will not work! 
      If the filtering is not unique (i.e. result is not a function), then the @{term "THE x . P x"} expression
      might lead to (undefined) unexpected results. In Isabelle maps, repetitions is equivalent to overriding,
      so that @{lemma "[1::nat \<mapsto> 2::nat, 1 \<mapsto> 3] 1 = Some 3" by simp}. 
     \<close>
definition 
  mapCompSetBound :: "'a set \<Rightarrow> 'b set \<Rightarrow> ('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> 'b) \<Rightarrow> ('a \<Rightarrow> 'b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<rightharpoonup> 'b)"
  where
  "mapCompSetBound S T inv_S inv_T domexpr rngexpr pred \<equiv> 
        (\<lambda> dummy::'a . 
            \<comment> \<open>In fact you have to check the \<^term>\<open>inv_Type\<close> of domexpr and rngexpr!!!\<close>
            if inv_VDMSet' inv_S S \<and> inv_VDMSet' inv_T T then
              if (\<exists> r \<in> T . \<exists> d \<in> S . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r) then
                Some (THE r . r \<in> T \<and> inv_T r \<and> (\<exists> d \<in> S . dummy = domexpr d r \<and> r = rngexpr d r \<and> pred d r)) 
              else 
                \<comment> \<open>This is for map application outside its domain error, VDMJ 4061 \<close>
                None
            else
              \<comment> \<open>This is for type invariant violation errors, VDMJ ????\<close>
              undefined
        )"

text \<open>Identity functions to be used for the dom/rng expression functions for the case they are variables.\<close>
definition 
  domid :: "'a \<Rightarrow> 'b \<Rightarrow> 'a"
  where
  "domid \<equiv> (\<lambda> d . (\<lambda> r . d))"

definition
  rngid :: "'a \<Rightarrow> 'b \<Rightarrow> 'b"
  where
  "rngid \<equiv> (\<lambda> d . id)"

text \<open>Constant function to be used for the dom expression function for the case they are constants.\<close>
definition
  domcnst :: "'a \<Rightarrow> 'a \<Rightarrow> 'b \<Rightarrow> 'a"
  where
  "domcnst v \<equiv> (\<lambda> d . (\<lambda> r . v))"

text \<open>Constant function to be used for the rng expression function for the case they are constants.\<close>
definition
  rngcnst :: "'b \<Rightarrow> 'a \<Rightarrow> 'b \<Rightarrow> 'b"
  where
  "rngcnst v \<equiv> (\<lambda> d . (\<lambda> r . v))"

definition
  truecnst :: "'a \<Rightarrow> 'b \<Rightarrow> \<bool>"
  where
  "truecnst \<equiv> (\<lambda> d . inv_True)"

definition
  predcnst :: "\<bool> \<Rightarrow> 'a \<Rightarrow> 'b \<Rightarrow> \<bool>"
  where
  "predcnst p \<equiv> (\<lambda> d . (\<lambda> r . p))"

lemma domidI[simp]: "domid d r = d"
  by (simp add: domid_def)

lemma rngidI[simp]: "rngid d r = r"
  by (simp add: rngid_def)

lemma domcnstI[simp]: "domcnst v d r = v" 
  by (simp add: domcnst_def)

lemma rngcnstI[simp]: "rngcnst v d r = v"
  by (simp add: rngcnst_def)

lemma predcnstI[simp]: "predcnst v d r = v"
  by (simp add: predcnst_def)

lemma truecnstI[simp]: "r \<noteq> undefined \<Longrightarrow> truecnst d r"
  by (simp add: truecnst_def)

lemmas maplet_defs = domid_def rngid_def rngcnst_def id_def truecnst_def inv_True_def
lemmas mapCompSetBound_defs = mapCompSetBound_def inv_VDMSet'_def inv_VDMSet_def maplet_defs rng_defs
lemmas mapCompTypeBound_defs = mapCompTypeBound_def maplet_defs rng_defs

(*========================================================================*)
section \<open> Lambda types \<close>
(*========================================================================*)

text \<open>Lambda definitions entail an implicit satisfiability proof obligation check
      as part of its type invariant checks. 

      Because Isabelle lambdas are always curried, we need to also take this into
      account. For example, \verb'lambda x: nat, y: nat1 & x+y' will effectively become
      @{term "(\<lambda> x . \<lambda> y . x + y)"}. Thus callers to this invariant check must 
      account for such currying when using more than one parameter in lambdas. 
      (i.e. call this as @{term "inv_Lambda inv_Dom (inv_Lambda inv_Dom' inv_Ran) l"} 
       assuming the right invariant checks for the type of x and y and the result 
       are used.
     \<close>
definition 
  inv_Lambda :: "('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b) \<Rightarrow> \<bool>"
  where
  "inv_Lambda inv_Dom inv_Ran l \<equiv> (\<forall> d . inv_Dom d \<longrightarrow> inv_Ran (l d))"

definition 
  inv_Lambda' :: "('a \<Rightarrow> \<bool>) \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> ('a \<Rightarrow> 'b) \<Rightarrow> 'a  \<Rightarrow> \<bool>"
  where
  "inv_Lambda' inv_Dom inv_Ran l d \<equiv> inv_Dom d \<longrightarrow> inv_Ran (l d)"

(*========================================================================*)
section \<open> Is test and type coercions \<close>
(*========================================================================*)

subsection \<open> Basic type coercions \<close>

definition
  is_VDMRealWhole :: "VDMReal \<Rightarrow> \<bool>"
  where
 "is_VDMRealWhole r \<equiv> r \<ge> 1 \<and> (r - real_of_int (vdm_narrow_real r)) = 0"

definition
  vdmint_of_real :: "VDMReal \<rightharpoonup> VDMInt"
  where
 "vdmint_of_real r \<equiv> if is_VDMRealWhole r then Some (vdm_narrow_real r) else None"

definition
  is_VDMRatWhole :: "VDMRat \<Rightarrow> \<bool>"
  where
 "is_VDMRatWhole r \<equiv> r \<ge> 1 \<and> (r - rat_of_int (vdm_narrow_real r)) = 0"

definition
  vdmint_of_rat :: "VDMRat \<rightharpoonup> VDMInt"
  where
 "vdmint_of_rat r \<equiv> if is_VDMRatWhole r then Some (vdm_narrow_real r) else None"

subsection \<open> Structured type coercions \<close>

type_synonym ('a, 'b) VDMTypeCoercion = "'a \<rightharpoonup> 'b"

text \<open>A total VDM type coercion is one where every element in the type space of
      interest is convertible under the given type coercion 
      (e.g., set of real = {1,2,3} into set of nat is total; whereas 
             set of real = {0.5,2,3} into set of nat is not total given 0.5 is not nat).  
     \<close>
definition 
  total_coercion :: "'a VDMSet \<Rightarrow> ('a, 'b) VDMTypeCoercion \<Rightarrow> \<bool>"
  where
  "total_coercion space conv \<equiv> (\<forall> i \<in> space . conv i \<noteq> None)"

text \<open>To convert a VDM set s of type 'a into type 'b (e.g., set of real into set of nat),
      it must be possible to convert every element of s under given type coercion
     \<close>
definition 
  vdmset_of_t :: "('a, 'b) VDMTypeCoercion \<Rightarrow> ('a VDMSet, 'b VDMSet) VDMTypeCoercion" 
  where
  "vdmset_of_t conv \<equiv> 
      (\<lambda> x . if total_coercion x conv then
                Some { the(conv i) | i . i \<in> x \<and> conv i \<noteq> None }
             else
                None)"

text \<open>To convert a VDM seq s of type 'a into type 'b (e.g., seq of real into seq of nat),
      it must be possible to convert every element of s under given type coercion
     \<close>
definition 
  vdmseq_of_t :: "('a, 'b) VDMTypeCoercion \<Rightarrow> ('a VDMSeq, 'b VDMSeq) VDMTypeCoercion" 
  where
  "vdmseq_of_t conv \<equiv> 
      (\<lambda> x . if total_coercion (elems x) conv then
                Some [ the(conv i) . i \<leftarrow> x, conv i \<noteq> None ]
             else
                None)"

(* map coercion will be tricky because result d2 depends on dconv call, which needs x's d1!
definition 
  vdmmap_of_dr :: "('d1, 'd2) VDMTypeCoercion \<Rightarrow> ('r1, 'r2) VDMTypeCoercion \<Rightarrow> ('d1 \<rightharpoonup> 'r1, 'd2 \<rightharpoonup> 'r2) VDMTypeCoercion" 
  where
  "vdmmap_of_dr dconv rconv \<equiv> 
      \<comment> \<open>x is a 'd1 \<rightharpoonup> 'r1, d is a 'd2 \<Rightarrow> 'r2; where dconv/rconv is applied throughout and succeeded\<close>
      (\<lambda> x . if total_coercion (dom x) dconv \<and> total_coercion (rng x) rconv then 
                Some (\<lambda> d . if (\<exists> xd . d = dconv xd) then None else None)
             else
                None)"
*)

subsection \<open> Is tests \<close>

text \<open>"Successful" is expr test is simply a call to the test expression invariant\<close>
definition 
  isTest :: "'a \<Rightarrow> ('a \<Rightarrow> \<bool>) \<Rightarrow> \<bool>"
  where
  [intro!]: "isTest x inv_X \<equiv> inv_X x"

lemma l_isTestI[simp]: "isTest x inv_X = inv_X x" 
  by (simp add: isTest_def)

text \<open>Possibly failing is expr tests up to given type coercion \<close>
definition 
  isTest' :: "'a \<Rightarrow> ('a, 'b) VDMTypeCoercion \<Rightarrow> ('b \<Rightarrow> \<bool>) \<Rightarrow> \<bool>"
  where
  [intro!]: "isTest' x conv inv_X \<equiv> 
    (case conv x of
        None \<Rightarrow> False 
      | Some x \<Rightarrow> inv_X x)"

(*========================================================================*)
section \<open> Well founded relation useful for sets in recursive functions \<close>
(*========================================================================*)
definition
  gen_set_term ::"('a VDMSet \<times> 'a VDMSet) VDMSet \<Rightarrow> ('a VDMSet \<times> 'a VDMSet) VDMSet" 
  where
  [simp]: "gen_set_term rel \<equiv> finite_psubset \<inter> rel"

definition
  gen_VDMInt_term :: \<open>VDMInt \<Rightarrow> (VDMInt \<times> VDMInt) set \<Rightarrow> (VDMInt \<times> VDMInt) set\<close>
  where
  [simp]: \<open>gen_VDMInt_term i rel \<equiv> (int_ge_less_than i) \<inter> rel\<close>

definition
  gen_VDMNat_term :: \<open>(VDMNat \<times> VDMNat) set \<Rightarrow> (VDMNat \<times> VDMNat) set\<close>
  where
  [simp]: \<open>gen_VDMNat_term rel \<equiv> gen_VDMInt_term 0 rel\<close>

lemma l_gen_set_term_wf[simp]: "wf (gen_set_term rel)" 
  by (simp add: wf_Int1)

lemma l_gen_VDMInt_term_wf[simp]: "wf (gen_VDMInt_term d rel)" 
  by (simp add: wf_Int1 wf_int_ge_less_than)

lemma l_gen_VDMNat_term_wf[simp]: "wf (gen_VDMNat_term rel)" 
  by (simp add: wf_Int1 wf_int_ge_less_than)

text \<open>Cast the well founded infrastructure from @{typ \<nat>} to @{typ VDMNat}.\<close>

definition pred_VDMNat :: "(VDMNat \<times> VDMNat) set"
  where "pred_VDMNat \<equiv> {(z, z+1) | z . inv_VDMNat z }"

text \<open>Project @{term pred_VDMNat} into @{typ \<nat>} for link to well foundedness\<close>
lemma l_pred_VDMNat_wf: \<open>wf pred_VDMNat\<close>
proof -
  have "pred_VDMNat \<subseteq> measure nat" 
     by (auto simp add: pred_VDMNat_def inv_VDMNat_def)
  then show ?thesis
     by (rule wf_subset [OF wf_measure])
qed

lemma l_pred_VDMNat_subset_int_ge_less_than: 
  \<open>pred_VDMNat \<subseteq> int_ge_less_than 0\<close>
  by (simp add: int_ge_less_than_def inv_VDMNat_def pred_VDMNat_def subset_iff)

definition less_than_VDMNat :: "(VDMNat \<times> VDMNat) set"
(*  where "less_than_VDMNat \<equiv> pred_VDMNat\<^sup>+"*)
  where \<open>less_than_VDMNat \<equiv> (int_ge_less_than 0)\<^sup>+\<close>

lemma l_less_than_VDMNat_wf [iff]: "wf less_than_VDMNat"
  by (simp add: less_than_VDMNat_def wf_int_ge_less_than wf_trancl)

lemma trans_less_than_VDMNat [iff]: "trans less_than_VDMNat"
  by (simp add: less_than_VDMNat_def)

lemma l_less_than_VDMNat_irrefl: "irrefl less_than_VDMNat"
  by (simp add: wf_imp_irrefl)

lemma l_less_than_VDMNat_asym: "asym less_than_VDMNat"
  by (meson asym_iff l_less_than_VDMNat_wf wf_not_sym)

lemma less_int_rel: "(<) = (\<lambda>m n. m < (n::int))\<^sup>+\<^sup>+"
proof (rule ext, rule ext, rule iffI)
  fix n m :: int
  show "(\<lambda>m n. m < (n::int))\<^sup>+\<^sup>+ m n" if "m < n"
    using that
  proof (induct n)
    case base
    then show ?case by auto
  next
    case (step i)
    then show ?case 
      by (auto intro: tranclp.trancl_into_trancl)
  qed
  show "m < n" if "(\<lambda>m n. m < (n::int))\<^sup>+\<^sup>+ m n"
    using that by (induct n) (simp_all)
qed

lemma l_less_than_VDMNat_subset_int_ge_less_than:
  "less_than_VDMNat \<subseteq> int_ge_less_than 0"
  apply (simp add: less_than_VDMNat_def int_ge_less_than_def inv_VDMNat_def  pred_VDMNat_def subset_iff)
  apply (intro allI impI conjI)
  using tranclD apply fastforce 
  by (smt (z3) case_prodD mem_Collect_eq trancl_trans_induct)

lemma l_less_than_VDMNat_iff [iff]: "inv_VDMNat x \<Longrightarrow> ((x,y) \<in> less_than_VDMNat) = (x<y)"
  apply (intro iffI)  
  using int_ge_less_than_def l_less_than_VDMNat_subset_int_ge_less_than apply fastforce
  unfolding less_than_VDMNat_def int_ge_less_than_def 
  by (rule r_into_trancl, simp add: inv_VDMNat_def)

lemma l_total_on_less_than_VDMNat [simp]: "total_on { x . inv_VDMNat x} less_than_VDMNat"
  unfolding total_on_def 
  using inv_VDMNat_def by fastforce

definition
  pair_less_VDMNat :: \<open>((VDMNat \<times> VDMNat) \<times> (VDMNat \<times> VDMNat)) VDMSet\<close>
  where
  "pair_less_VDMNat \<equiv> less_than_VDMNat <*lex*> less_than_VDMNat"

lemma wf_pair_less_VDMNat[simp]: "wf pair_less_VDMNat"
  by (auto simp: pair_less_VDMNat_def)

lemma l_trans_pair_less_VDMNat [iff]: "trans pair_less_VDMNat"
  by (simp add: pair_less_VDMNat_def)

lemma total_pair_less_VDMNat [iff]: "total_on less_than_VDMNat pair_less_VDMNat" 
  unfolding total_on_def pair_less_VDMNat_def lex_prod_def
  apply safe
  apply (metis (mono_tags, lifting) case_prodD int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq subsetD)
  apply (metis (no_types, lifting) Product_Type.Collect_case_prodD fst_conv insert_absorb insert_subset int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than not_less_iff_gr_or_eq)
  apply (metis (no_types, lifting) case_prodD in_mono int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq)
  apply (metis (no_types, lifting) case_prodD int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq subsetD)
  apply (metis (mono_tags, lifting) case_prodD in_mono int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq)
  apply (metis (no_types, lifting) case_prodD int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq subsetD)
  apply (metis (no_types, lifting) case_prodD in_mono int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than mem_Collect_eq not_less_iff_gr_or_eq)
  by (smt (verit, best) Product_Type.Collect_case_prodD fst_conv int_ge_less_than_def inv_VDMNat_def l_less_than_VDMNat_iff l_less_than_VDMNat_subset_int_ge_less_than subset_iff)

lemma l_pair_less_VDMNat_iff1_case1: "inv_VDMNat x \<Longrightarrow> ((x, y), x, z) \<in> pair_less_VDMNat \<Longrightarrow> y < z"
  by (metis (no_types, lifting) CollectD case_prodD in_lex_prod int_ge_less_than_def l_less_than_VDMNat_subset_int_ge_less_than order_less_irrefl pair_less_VDMNat_def subset_iff)
  (* 
  proof -
    assume "((x, y), x, z) \<in> pair_less_VDMNat"
    then have "((x, y), x, z) \<in> less_than_VDMNat <*lex*> less_than_VDMNat"
      using pair_less_VDMNat_def by blast
    then show ?thesis
      using int_ge_less_than_def l_less_than_VDMNat_subset_int_ge_less_than by auto
  *)

lemma l_pair_less_VDMNat_iff1 [simp]: "inv_VDMNat x \<Longrightarrow> inv_VDMNat y \<Longrightarrow> ((x,y), (x,z)) \<in> pair_less_VDMNat \<longleftrightarrow> y<z"
  apply (intro iffI) 
   apply (simp add: l_pair_less_VDMNat_iff1_case1)
  by (simp add: pair_less_VDMNat_def)

lemma l_pair_less_VDMNat_I1: "inv_VDMNat a \<Longrightarrow> inv_VDMNat s \<Longrightarrow> a < b  \<Longrightarrow> ((a, s), (b, t)) \<in> pair_less_VDMNat"
  by (simp add: pair_less_VDMNat_def) 

lemma l_pair_less_VDMNat_I2: "inv_VDMNat a \<Longrightarrow> inv_VDMNat s \<Longrightarrow> a \<le> b \<Longrightarrow> s < t \<Longrightarrow> ((a, s), (b, t)) \<in> pair_less_VDMNat"
  using l_pair_less_VDMNat_I1 by force

(*========================================================================*)
section \<open> Set operators lemmas \<close>
(*========================================================================*)

lemma l_psubset_insert: "x \<notin> S \<Longrightarrow> S \<subset> insert x S"
by blast

lemma l_right_diff_left_dist: "S - (T - U) = (S - T) \<union> (S \<inter> U)"
by (metis Diff_Compl Diff_Int diff_eq)
  thm Diff_Compl
      Diff_Int
      diff_eq

lemma l_diff_un_not_equal: "R \<subset> T \<Longrightarrow> T \<subseteq> S  \<Longrightarrow> S - T \<union> R \<noteq> S"
by auto


(*========================================================================*)
section \<open> Map operators lemmas \<close>
(*========================================================================*)

lemma l_map_non_empty_has_elem_conv:
  "g \<noteq> Map.empty \<longleftrightarrow> (\<exists> x . x \<in> dom g)"
by (metis domIff)

lemma l_map_non_empty_dom_conv:
  "g \<noteq> Map.empty \<longleftrightarrow> dom g \<noteq> {}"
by (metis dom_eq_empty_conv)

lemma l_map_non_empty_ran_conv:
  "g \<noteq> Map.empty \<longleftrightarrow> ran g \<noteq> {}"
by (metis empty_iff equals0I 
          fun_upd_triv option.exhaust 
          ranI ran_restrictD restrict_complement_singleton_eq)

lemma l_finite_rng: 
  "finite (dom m) \<Longrightarrow> finite (rng m)" 
  by (simp add: finite_ran rng_def)
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> Domain restriction weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* Lemma: dom restriction set inter equiv [ZEVES-LEMMA] *)
lemma l_dom_r_iff: "dom(S \<triangleleft> g) = S \<inter> dom g"
by (metis Int_commute dom_restr_def dom_restrict)

(* Lemma: dom restriction set inter equiv [ZEVES-LEMMA] *)
lemma l_dom_r_subset: "(S \<triangleleft> g) \<subseteq>\<^sub>m g"
by (metis Int_iff dom_restr_def l_dom_r_iff map_le_def restrict_in)

(* Lemma: dom restriction set inter equiv [ZEVES-LEMMA] *)
lemma l_dom_r_accum: "S \<triangleleft> (T \<triangleleft> g) = (S \<inter> T) \<triangleleft> g"
by (metis Int_commute dom_restr_def restrict_restrict)

(* Lemma: dom restriction set inter equiv [ZEVES-LEMMA] *)
lemma l_dom_r_nothing: "{} \<triangleleft> f = Map.empty"
by (metis dom_restr_def restrict_map_to_empty)

(* Lemma: dom restriction set inter equiv [ZEVES-LEMMA] *)
lemma l_dom_r_empty: "S \<triangleleft> Map.empty = Map.empty"
by (metis dom_restr_def restrict_map_empty)

lemma l_dres_absorb: "UNIV \<triangleleft> m = m"
by (simp add: dom_restr_def map_le_antisym map_le_def)  
  
lemma l_dom_r_nothing_empty: "S = {} \<Longrightarrow> S \<triangleleft> f = Map.empty"
by (metis l_dom_r_nothing)
(* FD: in specific dom subsumes application (over Some+None) [ZEVES-LEMMA] *)
(*
lemmX f_in_dom_r_apply_elem: 
  "l \<in> dom f \<and> l \<in> S \<Longrightarrow> ((S \<triangleleft> f) l) = (f l)"
unfolding dom_restr_def
by (cases "l\<in>S", auto)
*)
(* Simplified as doesn't need the l:dom f case *)
lemma  f_in_dom_r_apply_elem: " x \<in> S \<Longrightarrow> ((S \<triangleleft> f) x) = (f x)"
by (metis dom_restr_def restrict_in)

lemma  f_in_dom_r_apply_the_elem: "x \<in> dom f \<Longrightarrow> x \<in> S \<Longrightarrow> ((S \<triangleleft> f) x) = Some(the(f x))"
by (metis domIff f_in_dom_r_apply_elem option.collapse)

(* TODO: classify; rename. *) 
lemma l_dom_r_disjoint_weakening: "A \<inter> B = {} \<Longrightarrow> dom(A \<triangleleft> f) \<inter> dom(B \<triangleleft> f) = {}"
by (metis dom_restr_def dom_restrict inf_bot_right inf_left_commute restrict_restrict)

(* TODO: classify; rename - refactor out for l_dom_r_iff? *)
lemma l_dom_r_subseteq: "S \<subseteq> dom f \<Longrightarrow> dom (S \<triangleleft> f) = S" unfolding dom_restr_def
by (metis Int_absorb1 dom_restrict)

(* TODO: classift; rename  - refactor out for l_dom_r_subset? *)
lemma l_dom_r_dom_subseteq: "(dom ( S \<triangleleft> f)) \<subseteq> dom f" 
unfolding dom_restr_def by auto

lemma l_the_dom_r: "x \<in> dom f \<Longrightarrow> x \<in> S \<Longrightarrow> the (( S \<triangleleft> f) x) = the (f x)"
by (metis f_in_dom_r_apply_elem)

lemma l_in_dom_dom_r: "x \<in> dom (S \<triangleleft> f) \<Longrightarrow> x \<in> S"
    by (metis Int_iff l_dom_r_iff)

lemma l_dom_r_singleton: "x \<in> dom f \<Longrightarrow> ({x} \<triangleleft> f) = [x \<mapsto> the (f x)]"
unfolding dom_restr_def
by auto

lemma singleton_map_dom:
assumes "dom f = {x}" shows "f = [x \<mapsto> the (f x)]"
proof -
from assms obtain y where "f = [x \<mapsto> y]" 
    by (metis dom_eq_singleton_conv)
then have "y = the (f x)" 
by (metis fun_upd_same option.sel)
thus ?thesis by (metis `f = [x \<mapsto> y]`)
qed

lemma l_relimg_ran_subset:
  "ran (S \<triangleleft> m) \<subseteq> ran m"
  by (metis (full_types) dom_restr_def ranI ran_restrictD subsetI)

lemma f_in_relimg_ran:
  "y \<in> ran (S \<triangleleft> m) \<Longrightarrow> y \<in> ran m"
  by (meson l_relimg_ran_subset subsetCE)

(* An experiment - not sure which are the best rules to choose! *)
lemmas restr_simps = l_dom_r_iff l_dom_r_accum l_dom_r_nothing l_dom_r_empty
                     f_in_dom_r_apply_elem l_dom_r_disjoint_weakening l_dom_r_subseteq
                     l_dom_r_dom_subseteq

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> Domain anti restriction weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* FD: dom elem subsume dom ar *)
lemma f_in_dom_ar_subsume: "l \<in> dom (S -\<triangleleft> f) \<Longrightarrow>  l \<in> dom f"
unfolding dom_antirestr_def
by (cases "l\<in>S", auto)

(* FD: in specific dom_ar cannot be what's filtered *)
lemma f_in_dom_ar_notelem: "l \<in> dom ({r} -\<triangleleft> f) \<Longrightarrow> l \<noteq> r"
unfolding dom_antirestr_def
by auto

(* FD: in specific dom_ar subsumes application (over Some) *)
lemma f_in_dom_ar_the_subsume: 
  "l \<in> dom (S -\<triangleleft> f) \<Longrightarrow> the ((S -\<triangleleft> f) l) = the (f l)"
unfolding dom_antirestr_def
by (cases "l\<in>S", auto)

(* FD: in specific dom_ar subsumes application (over Some+None) *)
lemma f_in_dom_ar_apply_subsume: 
  "l \<in> dom (S -\<triangleleft> f) \<Longrightarrow> ((S -\<triangleleft> f) l) = (f l)"
unfolding dom_antirestr_def
by (cases "l\<in>S", auto)

(* FD: in specific dom subsumes application (over Some+None) [ZEVES-LEMMA] *)
(*
lemmX f_in_dom_ar_apply_not_elem: 
  "l \<in> dom f \<and> l \<notin> S \<Longrightarrow> ((S -\<triangleleft> f) l) = (f l)"
unfolding dom_antirestr_def
by (cases "l\<in>S", auto)
*)
(* TODO: I had a more general lemma: *)
lemma f_in_dom_ar_apply_not_elem: "l \<notin> S \<Longrightarrow> (S -\<triangleleft> f) l = f l"
by (metis dom_antirestr_def)

(* FD: dom_ar subset dom [ZEVES-LEMMA] *)
lemma f_dom_ar_subset_dom:
	"dom(S -\<triangleleft> f) \<subseteq> dom f"
unfolding dom_antirestr_def dom_def
by auto

(* Lemma: dom_ar as set different [ZEVES-LEMMA] *)
lemma l_dom_dom_ar:
	"dom(S -\<triangleleft> f) = dom f - S"
unfolding dom_antirestr_def
by (smt Collect_cong domIff dom_def set_diff_eq)

(* Lemma: dom_ar accumulates to left [ZEVES-LEMMA] *)
lemma l_dom_ar_accum:
	"S -\<triangleleft> (T -\<triangleleft> f) = (S \<union> T) -\<triangleleft> f"
unfolding dom_antirestr_def
by auto

(* Lemma: dom_ar subsumption [ZEVES-LEMMA] *)
lemma l_dom_ar_nothing:
	"S \<inter> dom f = {} \<Longrightarrow> S -\<triangleleft> f = f"
unfolding dom_antirestr_def
apply (simp add: fun_eq_iff)
by (metis disjoint_iff_not_equal domIff)

(* NOTE: After finding fun_eq_iff, there is also map_le_antisym for maps!*)

(* Lemma: dom_ar nothing LHS [ZEVES-LEMMA] *)
lemma l_dom_ar_empty_lhs:
  "{} -\<triangleleft> f = f"
by (metis Int_empty_left l_dom_ar_nothing)

(* Lemma: dom_ar nothing RHS [ZEVES-LEMMA] *)
lemma l_dom_ar_empty_rhs:
  "S -\<triangleleft> Map.empty = Map.empty"
by (metis Int_empty_right dom_empty l_dom_ar_nothing)

(* Lemma: dom_ar all RHS is empty [ZEVES-LEMMA] *)
lemma l_dom_ar_everything:
  "dom f \<subseteq> S \<Longrightarrow> S -\<triangleleft> f = Map.empty"
by (metis domIff dom_antirestr_def in_mono)

(* Lemma: dom_ar submap [ZEVES-LEMMA] *)
lemma l_map_dom_ar_subset: "S -\<triangleleft> f \<subseteq>\<^sub>m f"
by (metis domIff dom_antirestr_def map_le_def)

(* Lemma: dom_ar nothing RHS is f [ZEVES-LEMMA] *)
lemma l_dom_ar_none: "{} -\<triangleleft> f = f"
unfolding dom_antirestr_def
by (simp add: fun_eq_iff)

(* Lemma: dom_ar something RHS isn't f [ZEVES-LEMMA] *)
lemma l_map_dom_ar_neq: "S \<subseteq> dom f \<Longrightarrow> S \<noteq> {} \<Longrightarrow> S -\<triangleleft> f \<noteq> f"
apply (subst fun_eq_iff)
apply (insert ex_in_conv[of S])
apply simp
apply (erule exE)
unfolding dom_antirestr_def
apply (rule exI)
apply simp
apply (intro impI conjI)
apply simp_all
by (metis domIff set_mp)

lemma l_dom_rres_same_map_weaken: 
  "S = T \<Longrightarrow> (S -\<triangleleft> f) = (T -\<triangleleft> f)" by simp   

(*  TODO classify; rename *)
lemma l_dom_ar_not_in_dom:
  assumes *: "x \<notin> dom f"
  shows  "x \<notin> dom (s -\<triangleleft> f)"
by (metis * domIff dom_antirestr_def)

(*  TODO: classify; rename *)
lemma l_dom_ar_not_in_dom2: "x \<in> F \<Longrightarrow> x \<notin> dom (F  -\<triangleleft> f)"
by (metis domIff dom_antirestr_def)

lemma l_dom_ar_notin_dom_or: "x \<notin> dom f \<or> x \<in> S \<Longrightarrow> x \<notin> dom (S -\<triangleleft> f)"
by (metis Diff_iff l_dom_dom_ar)

(*  TODO: classify - shows conditions for being in antri restr dom *)
lemma l_in_dom_ar: "x \<notin> F \<Longrightarrow> x \<in> dom f \<Longrightarrow> x \<in> dom  (F  -\<triangleleft> f)"
by (metis f_in_dom_ar_apply_not_elem domIff) 

lemma l_Some_in_dom: 
  "f x = Some y \<Longrightarrow> x \<in> dom f" by auto

(*  TODO: classify; fix proof; rename; decide whether needed?! *)
lemma l_dom_ar_insert: "((insert x F) -\<triangleleft> f) = {x} -\<triangleleft> (F-\<triangleleft> f)" 
proof
  fix xa
  show "(insert x F -\<triangleleft> f) xa = ({x} -\<triangleleft> F -\<triangleleft> f) xa"
  apply (cases "x= xa")
  apply (simp add: dom_antirestr_def)
  apply (cases "xa\<in>F")
  apply (simp add: dom_antirestr_def)
  apply (subst f_in_dom_ar_apply_not_elem)
  apply simp
  apply (subst f_in_dom_ar_apply_not_elem)
  apply simp
  apply (subst f_in_dom_ar_apply_not_elem)
  apply simp
  apply simp  
  done
qed


(*  TODO: classify; rename?; subsume by l_dom_ar_accum? *)
(*  Think it may also be unused? *)
lemma l_dom_ar_absorb_singleton: "x \<in> F \<Longrightarrow> ({x} -\<triangleleft> F -\<triangleleft> f) =(F -\<triangleleft> f)"
by (metis l_dom_ar_insert insert_absorb)

(*  TODO: rename; classify; generalise? *)
lemma l_dom_ar_disjoint_weakening:
  "dom f \<inter> Y = {} \<Longrightarrow> dom (X -\<triangleleft> f) \<inter> Y = {}" 
 by (metis Diff_Int_distrib2 empty_Diff l_dom_dom_ar)

(* TODO: not used? *)
lemma l_dom_ar_singletons_comm: "{x}-\<triangleleft> {y} -\<triangleleft> f = {y}-\<triangleleft> {x} -\<triangleleft> f" 
    by (metis l_dom_ar_insert insert_commute)

lemma l_dom_r_ar_set_minus: 
  "S \<triangleleft> (T -\<triangleleft> m) = (S - T) \<triangleleft> m" 
  find_theorems "_ = _" name:HOL name:"fun"
  apply (rule ext)
  unfolding dom_restr_def dom_antirestr_def restrict_map_def
  by simp

lemma l_VDMMap_filtering_psubset: "d \<in> dom m \<Longrightarrow> dom ({d} -\<triangleleft> m) \<subset> dom m"
  find_theorems \<open>(_ -\<triangleleft> _)\<close>  
  apply (intro psubsetI f_dom_ar_subset_dom)
  by (metis f_in_dom_ar_notelem)

lemma l_VDMMap_filtering_card: "finite (dom m) \<Longrightarrow> d \<in> dom m \<Longrightarrow> card (dom ({d} -\<triangleleft> m)) < card (dom m)"
  by (simp add: l_VDMMap_filtering_psubset psubset_card_mono)


lemmas antirestr_simps = f_in_dom_ar_subsume f_in_dom_ar_notelem f_in_dom_ar_the_subsume
f_in_dom_ar_apply_subsume f_in_dom_ar_apply_not_elem f_dom_ar_subset_dom
l_dom_dom_ar l_dom_ar_accum l_dom_ar_nothing l_dom_ar_empty_lhs l_dom_ar_empty_rhs
l_dom_ar_everything l_dom_ar_none l_dom_ar_not_in_dom l_dom_ar_not_in_dom2
l_dom_ar_notin_dom_or l_in_dom_ar l_dom_ar_disjoint_weakening l_VDMMap_filtering_psubset
l_VDMMap_filtering_card

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> Map override weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* Lemma: dagger associates [ZEVES-LEMMA] *)
lemma l_dagger_assoc:
  "f \<dagger> (g \<dagger> h) = (f \<dagger> g) \<dagger> h"
by (metis dagger_def map_add_assoc)
thm ext option.split fun_eq_iff (* EXT! Just found function extensionality! *)

(* Lemma: dagger application [ZEVES-LEMMA] *)
lemma l_dagger_apply:
	"(f \<dagger> g) x = (if x \<in> dom g then (g x) else (f x))"
unfolding dagger_def
by (metis (full_types) map_add_dom_app_simps(1) map_add_dom_app_simps(3))

(* Lemma: dagger domain [ZEVES-LEMMA] *)
lemma l_dagger_dom:
	"dom(f \<dagger> g) = dom f \<union> dom g"
unfolding dagger_def
by (metis dom_map_add sup_commute)

(* Lemma: dagger absorption LHS *)
lemma l_dagger_lhs_absorb:
  "dom f \<subseteq> dom g \<Longrightarrow> f \<dagger> g = g"
apply (rule ext) 
by(metis dagger_def l_dagger_apply map_add_dom_app_simps(2) set_rev_mp)

lemma l_dagger_lhs_absorb_ALT_PROOF:
  "dom f \<subseteq> dom g \<Longrightarrow> f \<dagger> g = g"
apply (rule ext)
apply (simp add: l_dagger_apply)
apply (rule impI)
find_theorems "_ \<notin> _ \<Longrightarrow> _" name:Set 
apply (drule contra_subsetD)
unfolding dom_def
by (simp_all)   (* NOTE: foun nice lemmas to be used: contra_subsetD*)

(* Lemma: dagger empty absorption lhs [ZEVES-LEMMA] *)
lemma l_dagger_empty_lhs:
  "Map.empty \<dagger> f = f"
by (metis dagger_def empty_map_add)

(* Lemma: dagger empty absorption rhs [ZEVES-LEMMA] *)
lemma l_dagger_empty_rhs:
  "f \<dagger> Map.empty = f"
by (metis dagger_def map_add_empty)

(* Interesting observation here:

A few times I have spotted this. I then to get these
lemmas and use them in Isar; whereas Leo, you don't seem
to use this variety. Probably because the automation takes
care of the reasoning?...
*)
(*  TODO: Rename; classify *)
lemma dagger_notemptyL: 
  "f \<noteq> Map.empty \<Longrightarrow> f \<dagger> g \<noteq> Map.empty" by (metis dagger_def map_add_None)

lemma dagger_notemptyR: 
  "g \<noteq> Map.empty \<Longrightarrow> f \<dagger> g \<noteq> Map.empty" by (metis dagger_def map_add_None)


(* Lemma: dagger associates with dom_ar [ZEVES-LEMMA] *)
(*  It's not really an assoc prop? Well, kinda, but also kinda distrib *)
lemma l_dagger_dom_ar_assoc:
	"S \<inter> dom g = {} \<Longrightarrow> (S -\<triangleleft> f) \<dagger> g = S -\<triangleleft> (f \<dagger> g)"
apply (simp add: fun_eq_iff)
apply (simp add: l_dagger_apply)
apply (intro allI impI conjI)
unfolding dom_antirestr_def
apply (simp_all add: l_dagger_apply)
by (metis dom_antirestr_def l_dom_ar_nothing)
thm map_add_comm
   (* NOTE: This should be provable, if only I know how to do map extensionality :-(. Now I do! fun_eq_iff! 
   			Thm map_add_comm is quite nice lemma two, and could be used here, yet l_dagger_apply seems nicer.
    *)

lemma l_dagger_not_empty:
  "g \<noteq> Map.empty \<Longrightarrow> f \<dagger> g \<noteq> Map.empty"
by (metis dagger_def map_add_None)

(* TODO: Following 6 need renamed; classified? LEO: how do you do such choices? *)
lemma in_dagger_domL:
  "x \<in> dom f \<Longrightarrow> x \<in> dom(f \<dagger> g)" 
by (metis dagger_def domIff map_add_None)

lemma in_dagger_domR:
  "x \<in> dom g \<Longrightarrow> x \<in> dom(f \<dagger> g)" 
by (metis dagger_def domIff map_add_None)

lemma the_dagger_dom_right:
  assumes "x \<in> dom g"
  shows "the ((f \<dagger> g) x) = the (g x)"    
by (metis assms dagger_def map_add_dom_app_simps(1))

lemma the_dagger_dom_left:
  assumes  "x \<notin> dom g"
  shows "the ((f \<dagger> g) x) = the (f x)"
by (metis assms dagger_def map_add_dom_app_simps(3))    

lemma the_dagger_mapupd_dom: "x\<noteq>y \<Longrightarrow>  (f \<dagger> [y \<mapsto> z]) x = f x "
by (metis dagger_def fun_upd_other map_add_empty map_add_upd)

lemma dagger_upd_dist: "f \<dagger> fa(e \<mapsto> r) = (f \<dagger> fa)(e \<mapsto> r)" by (metis dagger_def map_add_upd)

lemma antirestr_then_dagger_notin: "x \<notin> dom f \<Longrightarrow> {x} -\<triangleleft> (f \<dagger> [x \<mapsto> y]) = f"
proof
  fix z
  assume "x \<notin> dom f"
  show "({x} -\<triangleleft> (f \<dagger> [x \<mapsto> y])) z = f z"
  by (metis `x \<notin> dom f`  domIff dom_antirestr_def fun_upd_other insertI1 l_dagger_apply singleton_iff)  
qed
lemma antirestr_then_dagger: "r\<in> dom f \<Longrightarrow> {r} -\<triangleleft> f \<dagger> [r \<mapsto> the (f r)] = f"
proof
  fix x
  assume *: "r\<in>dom f"
  show "({r} -\<triangleleft> f \<dagger> [r \<mapsto> the (f r)]) x = f x"
  proof (subst l_dagger_apply,simp,intro conjI impI)
    assume "x=r" then show "Some (the (f r)) = f r" using * by auto
    next
    assume "x \<noteq>r" then show " ({r} -\<triangleleft> f) x = f x" by (metis f_in_dom_ar_apply_not_elem singleton_iff)
  qed
qed 


(* TODO: rename; classify *)
lemma dagger_notin_right: "x \<notin> dom g \<Longrightarrow> (f \<dagger> g) x = f x" 
by (metis l_dagger_apply)
(* TODO: rename; classify *)

lemma dagger_notin_left: "x \<notin> dom f \<Longrightarrow> (f \<dagger> g) x = g x"
 by (metis dagger_def map_add_dom_app_simps(2))

lemma l_dagger_commute: "dom f \<inter> dom g = {} \<Longrightarrow>f \<dagger> g = g \<dagger> f"
  unfolding dagger_def 
apply (rule map_add_comm) 
by simp

lemmas dagger_simps = l_dagger_assoc l_dagger_apply l_dagger_dom l_dagger_lhs_absorb
l_dagger_empty_lhs l_dagger_empty_rhs dagger_notemptyL dagger_notemptyR l_dagger_not_empty
in_dagger_domL in_dagger_domR the_dagger_dom_right the_dagger_dom_left the_dagger_mapupd_dom
dagger_upd_dist antirestr_then_dagger_notin antirestr_then_dagger dagger_notin_right
dagger_notin_left

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> Map update weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

text \<open> without the condition nitpick finds counter example \<close>
lemma l_inmapupd_dom_iff:  
  "l \<noteq> x \<Longrightarrow> (l \<in> dom (f(x \<mapsto> y))) = (l \<in> dom f)"
by (metis (full_types) domIff fun_upd_apply)

lemma l_inmapupd_dom:  
  "l \<in> dom f \<Longrightarrow> l \<in> dom (f(x \<mapsto> y))"
by (metis dom_fun_upd insert_iff option.distinct(1))

lemma l_dom_extend: 
  "x \<notin> dom f \<Longrightarrow>  dom (f1(x \<mapsto> y)) = dom f1 \<union> {x}" 
by simp

lemma l_updatedom_eq: 
  "x=l \<Longrightarrow> the ((f(x \<mapsto> the (f x) - s)) l) = the (f l) - s"
by auto

lemma l_updatedom_neq: 
  "x\<noteq>l \<Longrightarrow> the ((f(x \<mapsto> the (f x) - s)) l) = the (f l)"
by auto

\<comment> \<open>A helper lemma to have map update when domain is updated\<close>
lemma l_insertUpdSpec_aux: "dom f = insert x F \<Longrightarrow> (f0 = (f |` F)) \<Longrightarrow> f = f0 (x \<mapsto> the (f x))"
proof auto
  assume insert: "dom f = insert x F"
  then have "x \<in> dom f" by simp
  then show "f = (f |` F)(x \<mapsto> the (f x))" using insert
         unfolding dom_def
         apply simp
         apply (rule ext)
         apply auto
         done
qed


lemma l_the_map_union_right: "x \<in> dom g \<Longrightarrow>dom f \<inter> dom g = {} \<Longrightarrow> the ((f \<union>m g) x) = the (g x)"
by (metis l_dagger_apply munion_def)

lemma l_the_map_union_left: "x \<in> dom f \<Longrightarrow>dom f \<inter> dom g = {} \<Longrightarrow> the ((f \<union>m g) x) = the (f x)"
by (metis l_dagger_apply l_dagger_commute munion_def)

lemma l_the_map_union: "dom f \<inter> dom g = {} \<Longrightarrow> the ((f \<union>m g) x) = (if x \<in> dom f then the (f x) else the (g x))"
by (metis l_dagger_apply l_dagger_commute munion_def)

lemmas upd_simps = l_inmapupd_dom_iff l_inmapupd_dom l_dom_extend
                  l_updatedom_eq l_updatedom_neq

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> Map union (VDM-specific) weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

(* Weaken: munion point-wise update well-definedness condition *)
lemma k_munion_map_upd_wd: 
  "x \<notin> dom f \<Longrightarrow> dom f \<inter> dom [x\<mapsto> y] = {}"
by (metis Int_empty_left Int_insert_left dom_eq_singleton_conv inf_commute)
    (* NOTE: munion updates are often over singleton sets. This weakening rule 
             states that's enough to show x is not in f to enable the application
             of f \<union>m [x \<mapsto> y].
     *)

(* Lemma: munion application *)
lemma l_munion_apply:
	"dom f \<inter> dom g = {} \<Longrightarrow> (f \<union>m g) x = (if x \<in> dom g then (g x) else (f x))"
unfolding munion_def
by (simp add: l_dagger_apply)

(* Lemma: munion domain *)
lemma l_munion_dom:
	"dom f \<inter> dom g = {} \<Longrightarrow> dom(f \<union>m g) = dom f \<union> dom g"
unfolding munion_def
by (simp add: l_dagger_dom)

lemma l_diff_union: "(A - B) \<union> C = (A \<union> C) - (B - C)"
by (metis Compl_Diff_eq Diff_eq Un_Int_distrib2)

lemma l_munion_ran: "dom f \<inter> dom g = {} \<Longrightarrow> ran(f \<union>m g) = ran f \<union> ran g"
apply (unfold munion_def)
apply simp
find_theorems "(_ \<dagger> _) = _"
(*apply (simp add: b_dagger_munion)*)
apply (intro set_eqI iffI)
unfolding ran_def 
thm l_dagger_apply
apply (simp_all add: l_dagger_apply split_ifs)

apply metis
by (metis Int_iff all_not_in_conv domIff option.distinct(1))

(* Bridge: dagger defined through munion [ZEVES-LEMMA] *)
lemma b_dagger_munion_aux:
	"dom(dom g -\<triangleleft> f) \<inter> dom g = {}"
apply (simp add: l_dom_dom_ar)
by (metis Diff_disjoint inf_commute)

lemma b_dagger_munion:
	"(f \<dagger> g) = (dom g -\<triangleleft> f) \<union>m g"
find_theorems (300) "_ = (_::(_ \<Rightarrow> _))" -name:Predicate -name:Product -name:Quick -name:New -name:Record -name:Quotient
		-name:Hilbert -name:Nitpick -name:Random -name:Transitive -name:Sum_Type -name:DSeq -name:Datatype -name:Enum
		-name:Big -name:Code -name:Divides
thm fun_eq_iff[of "f \<dagger> g" "(dom g -\<triangleleft> f) \<union>m g"]
apply (simp add: fun_eq_iff)
apply (simp add: l_dagger_apply)
apply (cut_tac b_dagger_munion_aux[of g f]) (* TODO: How to make this more automatic? Iain, help? subgoal_tac! Try that. *)
apply (intro allI impI conjI)
apply (simp_all add: l_munion_apply)
unfolding dom_antirestr_def
by simp


lemma l_munion_assoc:
  "dom f \<inter> dom g = {} \<Longrightarrow> dom g \<inter> dom h = {} \<Longrightarrow> (f \<union>m g) \<union>m h = f \<union>m (g \<union>m h)"
unfolding munion_def
apply (simp add: l_dagger_dom)
apply (intro conjI impI)
apply (metis l_dagger_assoc)
apply (simp_all add: disjoint_iff_not_equal)
apply (erule_tac [1-] bexE)
apply blast
apply blast
done

lemma l_munion_commute: 
  "dom f \<inter> dom g = {} \<Longrightarrow> f \<union>m g = g \<union>m f"
by (metis b_dagger_munion l_dagger_commute l_dom_ar_nothing munion_def)

lemma l_munion_subsume:
	"x \<in> dom f \<Longrightarrow> the(f x) = y \<Longrightarrow> f = ({x} -\<triangleleft> f) \<union>m [x \<mapsto> y]"
apply (subst fun_eq_iff)
apply (intro allI)
apply (subgoal_tac "dom({x} -\<triangleleft> f) \<inter> dom [x \<mapsto> y] = {}")
apply (simp add: l_munion_apply)
apply (metis domD dom_antirestr_def singletonE option.sel)
by (metis Diff_disjoint Int_commute dom_eq_singleton_conv l_dom_dom_ar)

text_raw \<open> Perhaps add @{text "g \<subseteq>\<^sub>m f"} instead? \<close>
lemma l_munion_subsumeG:  
	"dom g \<subseteq> dom f \<Longrightarrow> \<forall>x \<in> dom g . f x = g x \<Longrightarrow> f = (dom g -\<triangleleft> f) \<union>m g"
	
unfolding munion_def
apply (subgoal_tac "dom (dom g -\<triangleleft> f) \<inter> dom g = {}")
apply simp
apply (subst fun_eq_iff)
apply (rule allI)
apply (simp add: l_dagger_apply)
apply (intro conjI impI)+
unfolding dom_antirestr_def
apply (simp)
apply (fold dom_antirestr_def)
by (metis Diff_disjoint inf_commute l_dom_dom_ar)

lemma l_munion_dom_ar_assoc:
	"S \<subseteq> dom f \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> (S -\<triangleleft> f) \<union>m g = S -\<triangleleft> (f \<union>m g)"
unfolding munion_def
apply (subgoal_tac "dom (S -\<triangleleft> f) \<inter> dom g = {}")
defer 1
apply (metis Diff_Int_distrib2 empty_Diff l_dom_dom_ar)
apply simp
apply (rule l_dagger_dom_ar_assoc)
by (metis equalityE inf_mono subset_empty)

lemma l_munion_empty_rhs[simp]: 
  "(f \<union>m Map.empty) = f"
unfolding munion_def
by (metis dom_empty inf_bot_right l_dagger_empty_rhs)

lemma l_munion_empty_lhs[simp]: 
  "(Map.empty \<union>m f) = f"
unfolding munion_def
by (metis dom_empty inf_bot_left l_dagger_empty_lhs)

lemma k_finite_munion[simp]:
  "finite (dom f) \<Longrightarrow> finite(dom g) \<Longrightarrow> dom f \<inter> dom g = {} \<Longrightarrow> finite(dom(f \<union>m g))" 
by (metis finite_Un l_munion_dom)

lemma l_munion_singleton_not_empty:
  "x \<notin> dom f \<Longrightarrow> f \<union>m [x \<mapsto> y] \<noteq> Map.empty"
apply (cases "f = Map.empty")
apply (metis l_munion_empty_lhs map_upd_nonempty)
unfolding munion_def
apply simp
by (metis dagger_def map_add_None)

lemma l_trivial_vdmset[simp]: "inv_VDMSet' invt {}" 
  by (simp add: inv_VDMSet'_def)

lemma l_trivial_vdmmap[simp]: "inv_VDMMap invd invr Map.empty"
  by (simp add: inv_VDMMap_def)

lemma l_vdmmap_dom_munion_dist: 
  "dom m \<inter> dom n = {} \<Longrightarrow> inv_VDMSet' invDom (dom (m \<union>m n)) = (inv_VDMSet' invDom (dom m) \<and> inv_VDMSet' invDom (dom n))"
  unfolding inv_VDMSet'_def inv_VDMSet_def
  find_theorems "dom (_ \<union>m _) = _"
  by (auto simp add: l_munion_dom)

(* Use ran instead of rng, given internal Maps.thy expansions(?) *)
lemma l_vdmmap_ran_munion_dist: 
  "dom m \<inter> dom n = {} \<Longrightarrow> inv_VDMSet' invRng (ran (m \<union>m n)) = (inv_VDMSet' invRng (ran m) \<and> inv_VDMSet' invRng (ran n))"
  unfolding inv_VDMSet'_def inv_VDMSet_def
  find_theorems "ran (_ \<union>m _) = _"
  by (auto simp add: l_munion_ran)

lemma l_vdmmap_inv_munion_dist: 
  "dom m \<inter> dom n = {} \<Longrightarrow> inv_VDMMap invDom invRng (m \<union>m n) = (inv_VDMMap invDom invRng m \<and> inv_VDMMap invDom invRng n)"
  unfolding inv_VDMMap_def
  by (auto simp add: l_vdmmap_dom_munion_dist l_vdmmap_ran_munion_dist)

lemma l_vdmmap_inv_singleton[simp]:   
  "invDom x \<Longrightarrow> invRng y \<Longrightarrow> inv_VDMMap invDom invRng [x \<mapsto> y]"
  unfolding inv_VDMMap_def inv_VDMSet'_def inv_VDMSet_def
  by simp

lemma l_vdmset_inv_singleton[simp]:
  "invElem x \<Longrightarrow> inv_VDMSet' invElem {x}"
  unfolding inv_VDMSet'_def inv_VDMSet_def inv_SetElems_def
  by simp

lemma l_munion_empty_iff: 
  "dom f \<inter> dom g = {} \<Longrightarrow> (f \<union>m g = Map.empty) \<longleftrightarrow> (f = Map.empty \<and> g = Map.empty)"
apply (rule iffI)
apply (simp only: dom_eq_empty_conv[symmetric] l_munion_dom)
apply (metis Un_empty)
by (simp ) (*add: l_munion_empty_lhs l_munion_empty_rhs)*)

lemma l_indom_munion_in_map: "d \<in> dom m \<Longrightarrow> x \<notin> dom m \<Longrightarrow> d \<in> dom (m \<union>m [x \<mapsto> y])"
  unfolding munion_def dagger_def
  by simp

lemma l_indom_munion_in_map': "dom m \<inter> {x} = {} \<Longrightarrow> d \<in> dom m  \<Longrightarrow> d \<in> dom (m \<union>m [x \<mapsto> y])"
  unfolding munion_def dagger_def
  by simp

lemma l_indom_munion_in_maplet: "x \<notin> dom m \<Longrightarrow> x \<in> dom (m \<union>m [x \<mapsto> y])"
  unfolding munion_def dagger_def
  by simp

lemma l_munion_dom_ar_singleton_subsume: 
    "x \<notin> dom f \<Longrightarrow> {x} -\<triangleleft> (f \<union>m [x \<mapsto> y]) = f"
apply (subst fun_eq_iff)
apply (rule allI)
unfolding dom_antirestr_def
by (auto simp: l_munion_apply)

(*
lemmX l_dom_ar_union:
  "S -\<triangleleft> (f \<union>m g) = (S -\<triangleleft> f) \<union>m (S -\<triangleleft> g)"
apply (rule ext)
unfolding munion_def
apply (split split_if, intro conjI impI)+
apply (simp_all add: l_dagger_apply)
apply (intro conjI impI)
apply (insert f_dom_ar_subset_dom[of S f])
apply (insert f_dom_ar_subset_dom[of S g])
oops
*)

(* TODO: rename? *)
lemma l_munion_upd: "dom f \<inter> dom [x \<mapsto> y] = {}  \<Longrightarrow> f \<union>m [x \<mapsto> y] = f(x \<mapsto>y)" 
unfolding munion_def
  apply simp
  by (metis dagger_def map_add_empty map_add_upd)

(* TODO: Do I really need these?! *)
lemma munion_notemp_dagger: "dom f \<inter> dom g = {} \<Longrightarrow> f \<union>m g\<noteq>Map.empty \<Longrightarrow> f \<dagger> g \<noteq> Map.empty" 
by (metis munion_def)

lemma dagger_notemp_munion: "dom f \<inter> dom g = {} \<Longrightarrow> f \<dagger> g\<noteq>Map.empty \<Longrightarrow> f \<union>m g \<noteq> Map.empty" 
by (metis munion_def)

lemma munion_notempty_left: "dom f \<inter> dom g = {} \<Longrightarrow> f \<noteq> Map.empty \<Longrightarrow> f \<union>m g \<noteq> Map.empty"
by (metis dagger_notemp_munion dagger_notemptyL)

lemma munion_notempty_right: "dom f \<inter> dom g = {} \<Longrightarrow> g \<noteq> Map.empty \<Longrightarrow> f \<union>m g \<noteq> Map.empty"
by (metis dagger_notemp_munion dagger_notemptyR)

lemma unionm_in_dom_left: "x \<in> dom (f \<union>m g) \<Longrightarrow> (dom f \<inter> dom g) = {} \<Longrightarrow> x \<notin> dom g \<Longrightarrow> x \<in> dom f"
by (simp add: l_munion_dom)

lemma unionm_in_dom_right: "x \<in> dom (f \<union>m g) \<Longrightarrow> (dom f \<inter> dom g) = {} \<Longrightarrow> x \<notin> dom f \<Longrightarrow> x \<in> dom g"
by (simp add: l_munion_dom)

lemma unionm_notin_dom: "x \<notin> dom f \<Longrightarrow> x \<notin> dom g \<Longrightarrow> (dom f \<inter> dom g) = {} \<Longrightarrow> x \<notin> dom (f \<union>m g)" 
by (metis unionm_in_dom_right)

lemmas munion_simps = k_munion_map_upd_wd l_munion_apply l_munion_dom  b_dagger_munion
l_munion_subsume l_munion_subsumeG l_munion_dom_ar_assoc l_munion_empty_rhs
l_munion_empty_lhs k_finite_munion  l_munion_upd munion_notemp_dagger
dagger_notemp_munion munion_notempty_left munion_notempty_right

lemmas vdm_simps = restr_simps antirestr_simps dagger_simps upd_simps munion_simps

(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)
subsubsection \<open> Map finiteness weakening lemmas [EXPERT] \<close>
(* +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ *)

\<comment> \<open>Need to have the lemma options, otherwise it fails somehow\<close>
lemma finite_map_upd_induct [case_names empty insert, induct set: finite]:
  assumes fin: "finite (dom f)"
    and empty: "P Map.empty"
    and insert: "\<And>e r f. finite (dom f) \<Longrightarrow> e \<notin> dom f \<Longrightarrow> P f \<Longrightarrow> P (f(e \<mapsto> r))"
  shows "P f" using fin
proof (induct "dom f" arbitrary: "f" rule:finite_induct) \<comment> \<open>arbitrary statement is a must in here, otherwise cannot prove it\<close>
  case empty then have "dom f = {}" by simp   \<comment> \<open>need to reverse to apply rules\<close>
  then have "f = Map.empty" by simp
  thus ?case by (simp add: assms(2)) 
next
  case (insert x F)
  \<comment> \<open>Show that update of the domain means an update of the map\<close>
  assume domF: "insert x F = dom f" then have domFr: "dom f = insert x F" by simp
  then obtain f0 where f0Def: "f0 = f |` F" by simp
  with domF have domF0: "F = dom f0" by auto
  with insert have "finite (dom f0)" and "x \<notin> dom f0" and "P f0" by simp_all
  then have PFUpd: "P (f0(x \<mapsto> the (f x)))" 
    by (simp add: assms(3))
  from domFr f0Def have "f = f0(x \<mapsto> the (f x))" by (auto intro: l_insertUpdSpec_aux)
  with PFUpd show ?case by simp
qed

lemma finiteRan: "finite (dom f) \<Longrightarrow> finite (ran f)"
proof (induct rule:finite_map_upd_induct)
  case empty thus ?case by simp
next
  case (insert e r f) then have ranIns: "ran (f(e \<mapsto> r)) = insert r (ran f)" by auto
  assume "finite (ran f)" then have "finite (insert r (ran f))" by (intro finite.insertI)
  thus ?case apply (subst ranIns)
 by simp
qed

(* TODO: classify; rename; relocate? *)

lemma l_dom_r_finite: "finite (dom f) \<Longrightarrow> finite (dom ( S \<triangleleft> f))" 
apply (rule_tac B="dom f" in  finite_subset)
apply (simp add: l_dom_r_dom_subseteq)
apply assumption
done

lemma dagger_finite: "finite (dom f) \<Longrightarrow> finite (dom g) \<Longrightarrow> finite (dom (f \<dagger> g))"
     by (metis dagger_def dom_map_add finite_Un)

lemma finite_singleton: "finite (dom [a \<mapsto> b])" 
    by (metis dom_eq_singleton_conv finite.emptyI finite_insert)

lemma not_in_dom_ar: "finite (dom f) \<Longrightarrow> s \<inter> dom f = {} \<Longrightarrow> dom (s -\<triangleleft> f) = dom f" 
apply (induct rule: finite_map_upd_induct)
apply (unfold dom_antirestr_def) apply simp
by (metis IntI domIff empty_iff)

(* LF: why go for induction ? *)
lemma not_in_dom_ar_2: "finite (dom f) \<Longrightarrow> s \<inter> dom f = {} \<Longrightarrow> dom (s -\<triangleleft> f) = dom f" 
apply (subst set_eq_subset)
apply (rule conjI)
apply (rule_tac[!] subsetI)
apply (metis l_dom_ar_not_in_dom)
by (metis l_dom_ar_nothing)

(* ======== *)

lemma l_dom_ar_commute_quickspec:
  "S -\<triangleleft> (T -\<triangleleft> f) = T -\<triangleleft> (S -\<triangleleft> f)"
by (metis l_dom_ar_accum sup_commute)

lemma l_dom_ar_same_subsume_quickspec:
  "S -\<triangleleft> (S -\<triangleleft> f) = S -\<triangleleft> f"
  by (metis l_dom_ar_accum sup_idem)

lemma l_map_with_range_not_dom_empty: "dom m \<noteq> {} \<Longrightarrow> ran m \<noteq> {}"
  by (simp add: l_map_non_empty_ran_conv)

lemma l_map_dom_ran: "dom f = A \<Longrightarrow> x \<in> A \<Longrightarrow> f x \<noteq> None"
  by blast

(* Sequential composition combinator *)

definition
  seqcomp :: "('a \<Rightarrow> 'a) \<Rightarrow> ('a \<Rightarrow> 'a) \<Rightarrow> 'a \<Rightarrow> 'a" ("((_)/ ;; (_)/, (_))" [0, 0, 10] 10)
  where
  [intro!]: "(P ;; Q, bst) \<equiv> let mst = P bst in (Q mst)" 

fun
  seqcomps :: "('a \<Rightarrow> 'a) list \<Rightarrow> 'a \<Rightarrow> 'a" 
  where
  [intro!]: "seqcomps [] bst     = bst" 
| [intro!]: "seqcomps (x#xs) bst = seqcomps xs (x bst)" 

(*
find_consts name:fold

fun
  seqcomps' :: "('a \<Rightarrow> 'a) list \<Rightarrow> 'a \<Rightarrow> 'a" 
  where
  [intro!]: "seqcomps' [] bst     = foldl (\<lambda> b::'a . (\<lambda> a . b)) bst []" 
| [intro!]: "seqcomps' (x#xs) bst = foldl (\<lambda> b . (\<lambda> a . a b)) l " 

primrec foldl :: "('b \<Rightarrow> 'a \<Rightarrow> 'b) \<Rightarrow> 'b \<Rightarrow> 'a list \<Rightarrow> 'b" where
foldl_Nil:  "foldl f a [] = a" |
foldl_Cons: "foldl f a (x # xs) = foldl f (f a x) xs"
*)

definition
  seqcomps' :: "('a \<Rightarrow> 'a) list \<Rightarrow> 'a \<Rightarrow> 'a" 
  where
  [intro!]: "seqcomps' l bst = foldl (\<lambda> b . (\<lambda> a . a b)) bst l" 

lemma l_seq_comp_simp[simp]: "(P ;; Q, bst) = Q (P bst)" unfolding seqcomp_def by simp

lemma l_ranE_frule:
  "e \<in> ran f \<Longrightarrow> \<exists> x . f x = Some e"
  unfolding ran_def by safe

lemma l_ranE_frule':
  "e \<in> ran f \<Longrightarrow> \<exists> x . e = the(f x)"
  by (metis l_ranE_frule option.sel)

lemma l_inv_VDMMapTrue: 
  "finite (dom m) \<Longrightarrow> undefined \<notin> dom m \<Longrightarrow> undefined \<notin> rng m \<Longrightarrow> inv_VDMMap inv_True inv_True m"
  by (simp add: finite_ran inv_VDMMap_def inv_VDMSet'_def rng_def)  

lemma l_invMap_domr_absorb:   
  "inv_VDMMap di ri m \<Longrightarrow> inv_VDMMap di ri (S \<triangleleft> m)"
  unfolding inv_VDMMap_def inv_VDMSet'_defs inv_VDMSet_def
  by (metis (mono_tags, lifting) domIff f_in_dom_r_apply_elem f_in_relimg_ran finiteRan l_dom_r_finite l_in_dom_dom_r)

lemma l_inv_VDMMap_on_dom[]: "inv_VDMMap inv_Dom inv_Ran m \<Longrightarrow> inv_SetElems inv_Dom (dom m)" 
  unfolding inv_VDMMap_defs by auto

lemma l_inv_VDMMap_on_ran[]: "inv_VDMMap inv_Dom inv_Ran m \<Longrightarrow> inv_SetElems inv_Ran (ran m)" 
  unfolding inv_VDMMap_defs by auto

lemma l_inv_VDMMap_finite[simp]: "inv_VDMMap inv_Dom inv_Ran m \<Longrightarrow> finite (dom m)"
  unfolding inv_VDMMap_defs by simp

lemma l_inv_VDMMap_di_absorb:
  "undefined \<notin> dom m \<Longrightarrow> undefined \<notin> rng m \<Longrightarrow> inv_VDMMap di ri m \<Longrightarrow> inv_VDMMap inv_True ri m"
  by (simp add: inv_VDMMap_def inv_VDMSet'_def)

section \<open>To tidy up or remove\<close>

value "vdm_narrow_real (4.5::VDMRat)"
value "vdm_narrow_real (4.5::VDMReal)"

value " 7 div    ( 3::\<int>) =  2"
value " 7 vdmdiv ( 3::\<int>) =  2"

value "-7 div    (-3::\<int>) =  2"
value "-7 vdmdiv (-3::\<int>) =  2"

value "-7 div    ( 3::\<int>) = -3" 
value "-7 vdmdiv ( 3::\<int>) = -2"

value " 7 div    (-3::\<int>) = -3" 
value " 7 vdmdiv (-3::\<int>) = -2" 

value " 1 div    (-2::\<int>) = -1"  
value " 1 vdmdiv (-2::\<int>) =  0"  
value "-1 div    ( 2::\<int>) = -1"  
value "-1 vdmdiv ( 2::\<int>) =  0"  

value "0 div    (-3::\<int>) = 0"
value "0 vdmdiv (-3::\<int>) = 0"
value "0 div    ( 3::\<int>) = 0"
value "0 vdmdiv ( 3::\<int>) = 0"

value " 7 mod    ( 3::\<int>) =  1"
value " 7 vdmmod ( 3::\<int>) =  1"

value "-7 mod    (-3::\<int>) = -1"
value "-7 vdmmod (-3::\<int>) = -1"

value "-7 mod    ( 3::\<int>) =  2"
value "-7 vdmmod ( 3::\<int>) =  2"

value " 7 mod    (-3::\<int>) = -2"
value " 7 vdmmod (-3::\<int>) = -2"

value " 7 vdmmod ( 3::\<int>) =  1"
value "-7 vdmmod (-3::\<int>) = -1"
value "-7 vdmmod ( 3::\<int>) =  2" 
value " 7 vdmmod (-3::\<int>) = -2"

value " 7 vdmrem ( 3::\<int>) =  1"
value "-7 vdmrem (-3::\<int>) = -1"
value "-7 vdmrem ( 3::\<int>) = -1" 
value " 7 vdmrem (-3::\<int>) =  1"

value "inds0 [A, B, C]"
value "nths [1,2,(3::nat)] {2..3}"

(*lemma "s$${l..u} = subSeq s {l..u}" *)
(* negatives give funny result, as nat -4 = 0 and nat -1 = 0! *)
value "nths [A,B,C,D] {(nat (-1))..(nat (-4))}"
value "nths [A,B,C,D] {(nat (-4))..(nat (-1))}"
value "[A,B,C,D]$$${-4..-1}"
value "[A,B,C,D]$$${-1..-4}"
value "[A,B,C,D,E]$$${4..1}"
value "[A,B,C,D,E]$$${1..5}" (* 5-1+1*)
value "[A,B,C,D,E]$$${2..5}" (* 5-2+1*)
value "[A,B,C,D,E]$$${1..3}"
value "[A,B,C,D,E]$$${0..2}"
value "[A,B,C,D,E]$$${-1..2}"
value "[A,B,C,D,E]$$${-10..20}"
value "[A,B,C,D,E]$$${2..-1}"
value "[A,B,C,D,E]$$${2..2}"
value "[A,B,C,D,E]$$${0..1}"
value "len ([A,B,C,D,E]$$${2..2})"
value "len ([A]$$${2..2})"
value "card {(2::int)..2}"
value "[A,B,C,D,E]$$${0..0}"
find_theorems "card {_.._}"

subsection \<open> Set translations: enumeration, comprehension, ranges \<close>
  
(* { expr | var . filter }, { var \<in> type . filter }, { var . filter } *)
value "{ x+x | x . x \<in> {(1::nat),2,3,4,5,6} }"
value "{ x+x | x . x \<in> {(1::nat),2,3} }"
(*value "{ x+x | x . x \<in> {(1::nat)..3} }" --"not always work"*)

value "{0..(2::int)}"  
value "{0..<(3::int)}"  
value "{0<..<(3::int)}"  

subsection \<open> Seq translations: enumeration, comprehension, ranges \<close>
  
value "{ [A,B,C] ! i | i . i \<in> {0,1,2} }"
value "{ [A,B,C,D,E,F] ! i | i . i \<in> {0,2,4} }"
(* { s(i) | i in set inds s & i mod 2 = 0 } *)

(* List application (i.e. s(x)) is available in Isabelle, but is zero based *)
value "[A, B, C] ! 0"
value "[A, B, C] ! 1"
value "[A, B, C] ! 2"
value "[A, B, C] ! 3"
value "nth [A, B, C] 0"

value "applyList [A, B] 0" \<comment> \<open>out of range\<close>
value "applyList [A, B] 1"
value "applyList [A, B] 2"
value "applyList [A, B] 3" \<comment> \<open>out of range\<close>

value "[A,B,C,D] $ 0"  
lemma "[A,B,C] $ 4 = A" unfolding applyVDMSeq_defs apply simp oops
lemma "[A,B,C] $ 1 = A" unfolding applyVDMSeq_defs apply simp done   

value "[a] $ (len [(a::nat)])"
value "[A, B] $ 0" \<comment> \<open>out of range\<close>
value "[A,B]$1"
value "[A, B]$ 1"
value "[A, B]$ 2"
value "[A, B]$ 3" \<comment>  \<open>out of range\<close>

(* List comprehension *)
value "{ [A,B,C] ! i | i . i \<in> {0,1,2} }"
value "[ x . x \<leftarrow> [0,1,(2::int)] ]" (*avoid if possible... *)
value "[ x . x \<leftarrow> [0 .. 3] ]"

value "len [A, B, C]"
value "elems [A, B, C, A, B]"
value "elems [(0::nat), 1, 2]"
value "inds [A,B,C]"
value "inds_as_nat [A,B,C]"
value "card (elems [10, 20, 30, 1, 2, 3, 4, (5::nat), 10])"
value "len [10, 20, 30, 1, 2, 3, 4, (5::nat), 10]"
  
(* MySeq = seq of nat1
   inv s == len s \<le> 9 and card(elem s) = len s and (forall i in set elems s . i \<le> 9)*)
type_synonym MySeq = "VDMNat1 list"
definition
   inv_MySeq :: "MySeq \<Rightarrow> \<bool>"
where
   "inv_MySeq s \<equiv> (inv_SeqElems inv_VDMNat1 s) \<and> 
                  len s \<le> 9 \<and> int (card (elems s)) = len s \<and>
                  (\<forall> i \<in> elems s . i > 0 \<and> i \<le> 9)"

value "inv_MySeq [1, 2, 3]"

section \<open>VDM PO layered expansion-proof strategy setup\<close>

text \<open>I use various theorem tags to step-wise expand-simplify VDM goals\<close>

(*TODO: this needs loads of experimentation for fine tuning *)

named_theorems 
  VDM_basic_defs      and

  VDM_num_defs        and
  VDM_num_fcns        and
  VDM_num_spec_pre    and
  VDM_num_spec_post   and
  VDM_num_spec        and
  VDM_num             and

  VDM_set_defs        and
  VDM_set_fcns        and
  VDM_set_spec_pre    and
  VDM_set_spec_post   and
  VDM_set_spec        and
  VDM_set             and

  VDM_seq_defs        and
  VDM_seq_fcns_1      and
  VDM_seq_fcns_2      and
  VDM_seq_fcns_3      and
  VDM_seq_fcns        and
  VDM_seq_spec_pre    and
  VDM_seq_spec_post_1 and
  VDM_seq_spec_post_2 and
  VDM_seq_spec_post_3 and
  VDM_seq_spec_post   and
  VDM_seq_spec        and
  VDM_seq             and

  VDM_map_defs        and

  VDM_map_fcns_simps  and 
  VDM_map_fcns_1_simps and 
  VDM_map_fcns_2_simps and 

  VDM_map_fcns        and
  VDM_map_fcns_1      and
  VDM_map_fcns_2      and
  VDM_map_fcns_3      and
  VDM_map_fcns_4      and

  VDM_map_comp        and
  VDM_map_comp_1      and
  VDM_map_comp_2      and
  VDM_map_comp_3      and

  VDM_map             and

  VDM_num_crc         and
  VDM_num_crc_1       and
  VDM_num_crc_2       and
  VDM_num_crc_3       and
                  
  VDM_stms_defs       and 
  VDM_stms            and

  VDM_spec            and
  VDM_all

lemmas [VDM_basic_defs]       = inv_True_def inv_VDMChar_def (*inv_bool_def *)
                                inv_VDMToken'_def inv_VDMToken_def 

lemmas [VDM_num_defs]         = inv_VDMNat_def inv_VDMNat1_def inv_VDMInt_def
                                inv_VDMReal_def inv_VDMRat_def

lemmas [VDM_num_fcns]         = vdm_narrow_real_def vdm_div_def vdm_mod_def
                                vdm_rem_def vdm_pow_def vdm_abs_def vdm_floor_def
                   
lemmas [VDM_num_spec_pre]     = pre_vdm_mod_def pre_vdm_div_def 
                                pre_vdm_rem_def pre_vdm_pow_def
                              
lemmas [VDM_num_spec_post]    = post_vdm_mod_def post_vdm_div_def 
                                post_vdm_rem_def post_vdm_pow_def
                                post_vdm_floor_def post_vdm_abs_def  


lemmas [VDM_set_defs]         = inv_VDMSet_def inv_VDMSet1_def inv_VDMSet'_def inv_VDMSet1'_def inv_SetElems_def 
lemmas [VDM_set_fcns]         = vdm_card_def
lemmas [VDM_set_spec_pre]     = pre_vdm_card_def 
lemmas [VDM_set_spec_post]    = post_vdm_card_def

thm VDM_num_fcns

lemmas [VDM_seq_defs]         = inv_VDMSeq'_def inv_VDMSeq1'_def inv_SeqElems_def
lemmas [VDM_seq_fcns_1]       = len_def elems_def inds_def inds_as_nat_def 
lemmas [VDM_seq_fcns_2]       = vdm_reverse_def vdmtake_def seq_prefix_def 
lemmas [VDM_seq_fcns_3]       = applyVDMSeq_def applyVDMSubseq'_def applyVDMSubseq_def
lemmas [VDM_seq_spec_pre]     = pre_hd_def pre_tl_def pre_applyVDMSeq_def pre_applyVDMSubseq_def
lemmas [VDM_seq_spec_post_1]  = post_len_def post_elems_def post_inds_def post_hd_def post_tl_def   
lemmas [VDM_seq_spec_post_2]  = post_vdm_reverse_def post_vdmtake_def post_seq_prefix_def post_append_def
lemmas [VDM_seq_spec_post_3]  = post_applyVDMSeq_def post_applyVDMSubseq_def 

thm VDM_seq_fcns_1
thm VDM_seq_fcns_2
lemmas [VDM_map_defs]         = inv_Option_def inv_VDMMap1_def inv_VDMMap_def inv_VDMInmap_def
lemmas [VDM_map_fcns_1]       = rng_def dagger_def munion_def 
lemmas [VDM_map_fcns_2]       = dom_restr_def dom_antirestr_def rng_restr_def rng_antirestr_def
lemmas [VDM_map_fcns_3]       = vdm_merge_def vdm_inverse_def map_subset_def 
lemmas [VDM_map_fcns_4]       = map_comp_def map_compatible_def
lemmas [VDM_map_fcns_1_simps] = dagger_simps upd_simps munion_simps 
lemmas [VDM_map_fcns_2_simps] = restr_simps antirestr_simps
lemmas [VDM_map_comp_1]       = maplet_defs
lemmas [VDM_map_comp_2]       = mapCompSetBound_defs 
lemmas [VDM_map_comp_3]       = mapCompTypeBound_defs
lemmas [VDM_num_crc_1]        = is_VDMRealWhole_def is_VDMRatWhole_def 
lemmas [VDM_num_crc_2]        = vdmint_of_real_def vdmint_of_rat_def
lemmas [VDM_num_crc_3]        = total_coercion_def vdmset_of_t_def vdmseq_of_t_def isTest_def isTest'_def
lemmas [VDM_stms_defs]        = seqcomp_def seqcomps.simps seqcomps'_def

lemmas [VDM_num_spec]         = VDM_num_spec_pre VDM_num_spec_post
lemmas [VDM_set_spec]         = VDM_set_spec_pre VDM_set_spec_post
lemmas [VDM_seq_spec_post]    = VDM_seq_spec_post_3 VDM_seq_spec_post_2 VDM_seq_spec_post_1
lemmas [VDM_seq_spec]         = VDM_seq_spec_pre VDM_seq_spec_post

lemmas [VDM_seq_fcns]         = VDM_seq_fcns_3 VDM_seq_fcns_2 VDM_seq_fcns_1
lemmas [VDM_map_fcns]         = VDM_map_fcns_4 VDM_map_fcns_3 VDM_map_fcns_2 VDM_map_fcns_1 
lemmas [VDM_map_fcns_simps]   = VDM_map_fcns_2_simps VDM_map_fcns_1_simps
lemmas [VDM_map_comp]         = VDM_map_comp_3 VDM_map_comp_2 VDM_map_comp_1
lemmas [VDM_num_crc]          = VDM_num_crc_3 VDM_num_crc_2 VDM_num_crc_1

lemmas [VDM_num]  = VDM_num_defs VDM_num_fcns VDM_num_crc 
lemmas [VDM_set]  = VDM_seq_defs VDM_set_fcns
lemmas [VDM_seq]  = VDM_seq_defs VDM_seq_fcns
lemmas [VDM_map]  = VDM_map_defs VDM_map_fcns VDM_map_comp
lemmas [VDM_stms] = VDM_stms_defs
lemmas [VDM_spec] = VDM_num_spec VDM_set_spec VDM_seq_spec
lemmas [VDM_all]  = VDM_basic_defs VDM_num VDM_set VDM_seq VDM_map VDM_stms  

(*<*)end(*>*)