theory ClassBinary
imports "../vdm/VDMSeq" "../vdm/VDMSet"
begin

(*************************************************************************)
text {* VDM values *}

text {*
\begin{vdmsl}[breaklines=true]

values
	MAX_BITS: nat1 = 8;
	BITS: set of nat = {0,...,MAX_BITS};
\end{vdmsl}
*}

abbreviation MAX_BITS :: VDMNat where 
  "MAX_BITS \<equiv> 8"
abbreviation BITS :: "VDMNat VDMSet" where 
  "BITS \<equiv> {0 .. MAX_BITS}" 

definition inv_MAX_BITS :: \<bool> where 
  "inv_MAX_BITS \<equiv> inv_VDMNat1 MAX_BITS"
definition inv_BITS :: \<bool> where 
  "inv_BITS \<equiv> inv_SetElems inv_VDMNat BITS"

(*************************************************************************)
text {* VDM types *}

text {*
\begin{vdmsl}[breaklines=true]
types 
	Bits = nat
	inv b == b in set BITS;
	
	uint = nat
	inv v == v < pow(2,MAX_BITS);	
	
	bin = seq of bool
	inv b == len b <= MAX_BITS;
\end{vdmsl}
*}

type_synonym Bits = VDMNat
type_synonym uint = VDMNat
type_synonym bin = "\<bool> VDMSeq"

fun powProblematic :: "\<int> \<Rightarrow> \<nat> \<Rightarrow> VDMNat1" where
  "powProblematic base exp = 
      (if exp = 0 then 1 else base * powProblematic base (exp - 1))"

lemma "powProblematic 2 3 = R" apply simp oops  
  

fun pow0 :: "\<nat> \<Rightarrow> \<nat> \<Rightarrow> \<nat>" where
  "pow0 base 0 = 1" |
  "pow0 base (Suc exp) = base * pow0 base exp"

definition
  pow :: "VDMInt \<Rightarrow> VDMNat \<Rightarrow> VDMNat1"
where
  "pow base exp \<equiv> int (pow0 (nat base) (nat exp))"

definition inv_Bits :: "Bits \<Rightarrow> \<bool>" where 
  "inv_Bits b \<equiv> b \<in> BITS"
definition inv_uint :: "uint \<Rightarrow> \<bool>" where 
  "inv_uint v \<equiv> inv_VDMNat v \<and> v < (pow 2 MAX_BITS)"
definition inv_bin :: "bin \<Rightarrow> \<bool>" where 
  "inv_bin b \<equiv> len b \<le> MAX_BITS"

(*************************************************************************)
text {* VDM functions *}


text {*
\begin{vdmsl}[breaklines=true]
functions 

b2n: bool -> nat
b2n(b) == if b then 1 else 0
post RESULT <= 1;

n2b: nat -> bool
n2b(n) == n <> 0

pow : int * nat -> nat1
pow(base, exp) == if exp = 0 then 1 else base * pow(base, exp - 1)
pre base >= 0
post RESULT = base**exp;

bpow : Bits -> uint
bpow(exp) == pow(2,exp);

toNat: bin -> uint
toNat(bs) == if bs = [] then 0 else b2n(hd bs) + 2 * toNat(tl bs)
post RESULT < bpow(len bs);

toBin: uint -> bin
toBin(n) == if n = 0 then [] else toBin(n div 2) ^ [n2b(n mod 2)] 
post n < bpow(len RESULT);
\end{vdmsl}
*}

definition pre_pow :: "VDMInt \<Rightarrow> VDMNat \<Rightarrow> \<bool>" where
 "pre_pow base exp \<equiv> inv_VDMNat exp \<and> base \<ge> 0"

definition post_pow :: "VDMInt \<Rightarrow> VDMNat \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>" where
 "post_pow base exp RESULT \<equiv> inv_VDMNat exp \<and> 
    inv_VDMNat1 RESULT \<and> pre_pow base exp \<and>
    RESULT = int((nat base) ^ (nat exp))"

definition b2n :: "\<bool> \<Rightarrow> VDMNat" where 
  "b2n b \<equiv> if b then 1 else 0"

definition pre_b2n :: "\<bool> \<Rightarrow> \<bool>" where 
  "pre_b2n b \<equiv> True"

definition post_b2n :: "\<bool> \<Rightarrow> VDMNat \<Rightarrow> \<bool>" where 
  "post_b2n b RESULT \<equiv> inv_VDMNat RESULT \<and> RESULT \<le> 1"

definition n2b :: "VDMNat \<Rightarrow> \<bool>" where "n2b n \<equiv> n \<noteq> 0"

definition pre_n2b :: "VDMNat \<Rightarrow> \<bool>" where 
  "pre_n2b n \<equiv> inv_VDMNat n"

definition post_n2b :: "VDMNat \<Rightarrow> \<bool> \<Rightarrow> \<bool>" where 
  "post_n2b n RESULT \<equiv> inv_VDMNat n"
  
definition bpow :: "Bits \<Rightarrow> uint" where "bpow exp \<equiv> pow 2 exp"

definition pre_bpow :: "Bits \<Rightarrow> \<bool>" where 
  "pre_bpow exp \<equiv> inv_Bits exp"

definition post_bpow :: "Bits \<Rightarrow> uint \<Rightarrow> \<bool>" where 
  "post_bpow exp RESULT \<equiv> inv_Bits exp \<and> inv_uint RESULT"

fun toNatWrong :: "bin \<Rightarrow> uint" where 
  "toNatWrong [] = 0" |
  "toNatWrong (b#bs) = (b2n b) + 2 * (toNatWrong bs)"

lemma "toNatWrong [False, True, True] = 6" by (simp add: b2n_def)

fun toNat0 :: "bin \<Rightarrow> \<nat> \<Rightarrow> \<nat>"
where
  "toNat0 [] p = p"
| "toNat0 (b # bs) p = (toNat0 bs (nat (b2n b) + (2 * p)))" 

definition toNat :: "bin \<Rightarrow> uint" where
  "toNat bs \<equiv> int (toNat0 bs 0)"

lemma "toNat [True, True, False] = 6" 
unfolding toNat_def
apply (simp only: toNat0.simps)
unfolding b2n_def
by simp

definition pre_toNat :: "bin \<Rightarrow> \<bool>" where 
  "pre_toNat bs \<equiv> inv_bin bs"

definition post_toNat :: "bin \<Rightarrow> uint \<Rightarrow> \<bool>" where 
  "post_toNat bs RESULT \<equiv> 
      inv_uint RESULT \<and> inv_bin bs \<and> RESULT < bpow (len bs)"

fun toBin0 :: "\<nat> \<Rightarrow> bin" where 
  "toBin0 0 = []" |
  "toBin0 (Suc n) =  toBin0 ((Suc n) div 2) @ [n2b (int ((Suc n) mod 2))] "

definition toBin :: "uint \<Rightarrow> bin" where
  "toBin n \<equiv> toBin0 (nat n)"

lemma "toBin 6 = [True, True, False]" unfolding toBin_def
apply (subgoal_tac "nat 6 = Suc(Suc(Suc(Suc(Suc(Suc 0)))))")
apply (simp only: toBin0.simps)
using n2b_def by simp_all

definition pre_toBin :: "uint \<Rightarrow> \<bool>" where 
  "pre_toBin n \<equiv> inv_uint n"

definition post_toBin :: "uint \<Rightarrow> bin \<Rightarrow> \<bool>" where 
  "post_toBin n RESULT \<equiv> 
      inv_uint n \<and> inv_bin RESULT \<and> n < bpow (len RESULT)"

lemma "toBin0 (toNat0 bs 0) = bs"
  apply (induct bs, simp)
  apply simp
  unfolding b2n_def
  apply (case_tac a, simp)
  oops 
    
lemma "toNat0 (toBin0 n) 0 = n" 
  apply (induct n, simp+)
  oops
    
lemma "toNat0 (toBin0 n) 0 = n"
apply (induct n, simp)
  apply (simp only: toBin0.simps)
  unfolding n2b_def
  apply simp
    oops

lemma "toBin0 (toNat0 bs 0) = bs"
apply (induct bs, simp_all)
unfolding b2n_def apply auto oops 








theorem PO_bpow_legal_fcn_appl: "\<forall> exp . inv_Bits exp \<longrightarrow> pre_pow 2 exp"
unfolding pre_pow_def inv_Bits_def inv_VDMNat_def by auto 
lemma "0 \<le> exp \<and> exp \<le> (nat MAX_BITS) \<Longrightarrow> pow0 2  exp < pow0 2 8" 
apply (induct exp, simp_all)
apply (subgoal_tac "8=Suc(Suc(Suc(Suc(Suc(Suc(Suc(Suc 0)))))))")
apply (simp only: pow0.simps, simp) oops

theorem PO_bpow_type_compatibility: "\<forall> exp . inv_Bits exp \<longrightarrow> inv_uint (pow 2 exp)" 
unfolding inv_Bits_def inv_uint_def inv_VDMNat_def pow_def
apply (intro allI impI conjI, simp_all, elim conjE)oops

lemma "powProblematic 2 3 = 8" apply simp done

value "[0 .x \<leftarrow> [0..(3::int)]] = [0,0,0,0]"
end