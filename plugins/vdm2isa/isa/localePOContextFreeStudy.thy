theory localePOContextFreeStudy
  imports VDMToolkit
begin

type_synonym T = VDMNat 

(*
module m1
types 
  T = nat inv t == t \<ge> 10 and t \<le> 20;

functions 
  f : T \<rightarrow> nat1
  f(x) == x * x 
  post x < RESULT;
end m1
*)
definition 
  inv_T :: "VDMNat \<Rightarrow> \<bool>"
  where
  "inv_T t \<equiv> inv_VDMNat t \<and> t \<ge> 10 \<and> t \<le> 20"

lemmas inv_T_defs = inv_T_def inv_VDMNat_def

definition 
  pre_f :: "T \<Rightarrow> \<bool>"
  where
  "pre_f t \<equiv> inv_T t"

definition 
  post_f :: "T \<Rightarrow> VDMNat1 \<Rightarrow> \<bool>"
  where
  "post_f t RESULT \<equiv> inv_T t \<and> inv_VDMNat1 RESULT \<and> t < RESULT"

lemmas pre_f_defs = pre_f_def inv_T_defs 
lemmas post_f_defs = post_f_def inv_T_defs inv_VDMNat1_def

definition 
  f :: "T \<Rightarrow> VDMNat1"
  where
  "f x \<equiv> x * x"

definition 
  PO1 :: "\<bool>"
  where
  "PO1 \<equiv> (\<forall> t . inv_T t \<and> pre_f t \<longrightarrow> post_f t (f t))"

lemmas PO1_defs = PO1_def inv_T_defs pre_f_defs post_f_defs

definition 
  PO2 :: "\<bool>"
  where
  "PO2 \<equiv> (\<exists> t . inv_T t)"

lemmas PO2_defs = PO2_def inv_T_defs 

locale fPOS = 
  assumes a1: PO1
  and a2: PO2
begin

lemma l1: "whatever = whichever" 
  sorry 
end

interpretation ps_surrender: fPOS
  apply (unfold_locales)
  apply (insert fPOS.l1)
  oops

interpretation ps_optimistic: fPOS
  apply (unfold_locales)
  unfolding PO1_defs
   apply (simp add: f_def)
  unfolding PO2_defs
  by presburger

end